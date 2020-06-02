@works
Feature: Share Works
  Testing the "Share" button on works, with Javascript emulation

  @javascript
  Scenario: Share a work
    Given I have a work "Blabla"
    When I view the work "Blabla"
    Then I should see "Share"
    When I follow "Share"
    Then the share modal should contain "Copy and paste the following code to link back to this work"
      And the share modal should contain "or use the Tweet or Tumblr links to share the work"
      And the share modal should contain '<a href="%{current_url}"><strong>Blabla</strong></a> (6 words)'
      And the share modal should contain 'by <a href="http://%{current_host}/users/testuser1"><strong>testuser1</strong></a>'
      And the share modal should contain 'Fandom: <a href="http://%{current_host}/tags/Stargate%%20SG-1">Stargate SG-1</a>'
      And the share modal should contain "Rating: Not Rated"
      And the share modal should contain "Warnings: No Archive Warnings Apply"
      And I should see "Tweet" within "a.twitter"
      And I should see "Share on Tumblr" within "div#share ul li a[title]"
      And I should not see "Series:" within "#share"
      And I should not see "Relationships:" within "#share"
      And I should not see "Characters:" within "#share"
      And I should not see "Summary:" within "#share"
    When I view the work "Blabla"
      And I log out
    Then I should see "Share"
    When I follow "Share"
    Then the share modal should contain "Copy and paste the following code to link back to this work"
      And the share modal should contain "or use the Tweet or Tumblr links to share the work"
      And the share modal should contain '<a href="http://%{current_host}/works/1"><strong>Blabla</strong></a> (6 words)'
      And the share modal should contain 'by <a href="http://%{current_host}/users/testuser1"><strong>testuser1</strong></a>'
      And the share modal should contain 'Fandom: <a href="http://%{current_host}/tags/Stargate%%20SG-1">Stargate SG-1</a>'
      And the share modal should contain "Rating: Not Rated"
      And the share modal should contain "Warnings: No Archive Warnings Apply"
      And I should see "Tweet" within "a.twitter"
      And I should see "Share on Tumblr" within "div#share ul li a[title]"
      And I should not see "Series:" within "#share"
      And I should not see "Relationships:" within "#share"
      And I should not see "Characters:" within "#share"
      And I should not see "Summary:" within "#share"

  Scenario: Share option should be disabled if all creators have set the option to disable sharing on their works
  
  Given I am logged in as "PrivaC"
    And I set my preferences to hide the share buttons on my work
    And I post the work "Don't Lie When You're Hurting Inside"
    And the user "EitherWay" allows co-creators
  When I view the work "Don't Lie When You're Hurting Inside"
  Then I should not see "Share"
  When I add the co-author "EitherWay" to the work "Don't Lie When You're Hurting Inside"
    And I view the work "Don't Lie When You're Hurting Inside"
  Then I should see "Share"
  When I am logged in as "EitherWay"
    And I set my preferences to hide the share buttons on my work
    And I view the work "Don't Lie When You're Hurting Inside"
  Then I should not see "Share"

  @javascript
  Scenario: Sharing should work for multi-chapter works
    Given the chaptered work "Whatever"
    When I view the work "Whatever"
    Then I should see "Share"
    When I follow "Share"
    Then I should see "Copy and paste the following code to link back to this work"
      And I should see "><strong>Whatever</strong></a> (9 words) b"

  @javascript
  Scenario: Share URL should not be used for post-login redirect
    Given I have a work "Blabla"
      And the following activated user exists
      | login   | password |
      | MadUser | password |
    When I am logged out
      And I view the work "Blabla"
    Then I should see "Share"
    When I follow "Share"
    Then I should see "Close" within "#modal"
    When I follow "Close"
      And I fill in "User name or email:" with "maduser"
      And I fill in "Password:" with "password"
      And I press "Log In"
    Then I should be on the "Blabla" work page
