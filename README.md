# Northeastern-University-Event-Management-System

Database Purpose:
Considering the increasing need for organized event management, the mission of this database is to create a system for managing events efficiently at Northeastern. The goal is to provide event organizers with a tool for effective event management by facilitating the tracking of attendees, managing event locations, budgets, and promotions, and optimizing overall coordination.

Business Problems Addressed: • Event Planning and Coordination: Efficiently plan and coordinate all aspects of an event, including scheduling, venue selection, budgeting, and resource allocation. The database can store event details, vendor information, contracts, and timelines, ensuring smooth execution.
• Ticket Management: Maintain accurate records of users buying the ticket, including registration information, ticket type, ticket price, ticket level, contact details of user, 
preferences, and attendance history. This helps with managing invites, seats and the total budget for the event.
• Venue Management: Keep track of venue availability, capacity and amenities. The database can streamline the process of finding suitable venues, negotiating contracts, managing event logistics.
• Budgeting and Financial Management: Monitor event budgets, expenses, and revenue streams. The database can generate financial reports, track payments, and reconcile accounts, enabling better financial planning and control.
• Sponsorship and Promotion: Track sponsorship agreements, exhibitor contracts, and 
deliverables. The database can help in identifying potential sponsors, managing sponsor relationships, and maximizing sponsor ROI. Segment target audiences, track marketing 
campaigns, and analyze response rates. The database can store marketing materials, track leads, and measure the effectiveness of promotional activities.
• Inventory: Coordinate event inventory, such as speakers, mics, catering, audio-visual equipment, and security. The database can centralize information, automate workflows and facilitate communication among stakeholders.
• Feedback: Collect feedback from users through surveys, polls, and social media. The database can be used to analyze feedback data, identify areas for improvement, and enhance user satisfaction and engagement.
 Business Rules: - Each event may have zero or one ticket. 
- Each event may have zero or more inventory items.
- Each event may have zero or more feedback
- Each event will have one and only one organizer.
- Each event will have one and only one venue.
- Each event will have one and only one schedule.
- Each event will have zero or more promotions.
- Each event will have one and only one budget.
- Each user can provide zero or more feedback.
- Each user can buy zero or more tickets. - Each Venue will have only one event at a time.
- Each sponsor may have one or more sponsorships.
- Each sponsorship is associated with one and only one sponsor.
- Each budget may have one or more sponsors.
- Each sponsorship is associated with one and only one budget.
- Each organizer may have one or more vendor-organizer associations.
- Each vendor may have one or more vendor-organizer associations.
- Each vendor-organizer is associated with one and only one vendor.
- Each vendor-organizer is associated with one and only one organizer.
  
Design Requirements (Credit to Professor Simon Wang)
• Use Crow's Foot Notation.
• Specify the primary key fields in each table by specifying PK beside the fields.
• Draw a line between the fields of each table to show the relationships between each 
table. This line should be pointed directly to the fields in each table used to form the 
relationship.
• Specify which table is on one side of the relationship by placing one next to the field 
where the line ends.
• Specify which table is on one side of the relationship by placing one next to the field 
where the line starts.
Design Decisions


SEARCH AND TRACK OBJECTIVES:
● To perform searches on event details based on date and time data
● To perform searches on attendees' RSVP status for specific events
● To perform searches on event venues by location and capacity
● To perform searches on sponsors in various events
● To perform searches on dietary preferences for event planning
● To perform searches on event transport options across events
● To perform searches on teams organizing the event like volunteers, and
managers
● To track changes in RSVP response statuses
● To track attendance count across multiple events
● To track event budget expenditures
● To track the number of events on a particular date/location
● To track the number of tickets sold for an event
● To track the available inventory options for next event
● To track the reach of events achieved via offline and online promotions.
REPORTING OBJECTIVES:
● To report the number of attendees based on events
● To report vacant seats for a particular event
● To report on the popularity of specific event sponsors
● To report on transportation preferences for events
● To report the number of sponsors for each event
