class Field < Question
  has_one :special_field_association, :foreign_key => :question_id
  
  before_save do |field|
    if field.caption.blank?
      field.caption = "Click here to type a question."
    end
  end
  
  def purpose
    if special_field_association.nil?
      nil
    else
      special_field_association.purpose
    end
  end
  
  def purpose=(newpurpose)
    if not (newpurpose.nil? or newpurpose == '')
      if special_field_association.nil?
        sfa = SpecialFieldAssociation.create!(:questionnaire => questionnaire,
                                              :purpose => newpurpose,
                                              :question => self)
        reload
      else
        special_field_association.purpose = newpurpose
      end
    else
      if not special_field_association.nil?
        special_field_association.destroy
      end
    end
  end
  
  before_save do |field|
    if not field.special_field_association.nil?
      field.special_field_association.save!
    end
  end
  
  def to_json
    super :methods => "purpose"
  end
  
  def xmlcontent(xml)
    super
    xml.default_answer(self.default_answer)
    xml.purpose(self.purpose)
  end
  
  def deepclone
    c = super
    c.default_answer = self.default_answer
    
    return c
  end
end