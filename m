From: Patrick Mochel <mochel@digitalimplant.org>
Subject: Power Management Summit
Date: Wed, 23 Nov 2005 15:30:09 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0511231524000.16769-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============48691462594346313=="
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

--===============48691462594346313==
Content-Type: TEXT/PLAIN; charset=US-ASCII


As promised last July, I am organizing a Linux Power Management Summit.
Due to an unexpected three-month-long vacation, it got delayed from being
in January to being in mid-April, to coincide with the recently announced
CELF Embedded Linux Conference. Now that I am employed again (with a heavy
focus on Power Management), I hope to have the details of the Summit
solidified in the very near future.

Below is a small write-up of the Summit so far. Please feel free to
comment or ask questions about the content of the write-up and the
proposed format.

Note that there is no separate list for this discussion. If the chatter
becomes too heavy about it and people would like to see it moved, please
let me know and I will set up a different list.

Thanks,


	Pat



Linux Power Management Summit

12-14 April 2006

San Jose, California



Overview
--------

This will be a three day event with two primary goals:

- Giving the Linux Power Management developers an opportunity to
  interact face-to-face.
- Giving the PM developers and industry sponsors an opportunity to
  interact and discuss their mutual needs, requirements, and
  expectations.

This event is going to coincide with the CELF Embedded Linux
Conference. It will held at the same venue (TBD) and overlap one day with
it. Information on the CELF ELC can be found at

http://tree.celinuxforum.org/CelfPubWiki/EmbeddedLinuxConference2006

Many details are to be determined, such as the attendees, the final
list of sponsors, and the final agenda. What is known is the framework
for the Summit and some guidelines for the content. These are detailed
below. More information will be filled in as it becomes known.

In general, I want this to be a meeting of people that are actively
contributing to the betterment of Linux Power Management. There is a
lot of work to do and many of the issues are not along the lines of
"What else needs to be done?", but rather "How are we going to do
everything we need to do?" I want this to be a forum that reaffirms
the cooperation and collaboration needed to make Linux Power
Management great.


Sponsors
--------

We have three tentative sponsors for this event. I would love to see
more sponsors, and if anyone is interested, or knows the right person
to contact about potential sponsorship, please contact me. In
particular, it would be nice to see some embedded device manufacturers
with Linux-based devices. (And, if one or more manufacturers wanted to
sponsor with an embedded device for each attending developer, there
would be no arguments).


Attendees
---------

Based past experiences, large groups and highly technical "Summits" do
not mix well. We need to keep the group as small as possible in order
to ensure participation from everyone, as well as making it easy as
possible to speak to (and feel comfortable with) everyone. However, I
want to ensure that we have adequate representation in the following
areas (meaning 1-3 core developers):

- CPU Power Management (cpufreq)
- Suspend to Disk (swsusp[1-n])
- Embedded Power Management (DPM, OMAP, etc)
- Core Infrastructure (driver model, core code)
- Runtime Power Management
- Distribution Support of PM (including userspace tools)

At the absolute most, I would like to have 15-18 developers present.
Please feel free to email me (privately) suggestions for attendees.
I'd like to finalize the list by mid-January.

I would like the sponsors to send representatives to the Summit as
well. I would prefer 1 person per sponsor (beyond invited attendees),
though at the very most, I suppose 2 would be fine.

However, I want to make sure that everyone lives up to my high
standards - I expect everyone to participate at a very technical level
in a majority of the discussions; I want everyone to understand the
different types power management and how they interact and conflict;
and I want everyone to be well-versed in the current state of Linux
Power Management.

[ These requirements may sound obvious to some, but I have encountered
exactly the opposite at the Linux Kernel Summit in the past few
years. While it's not disastrous, it always ends up detracting
unnecessarily from the core discussions. ]


Agenda
------

This is to be determined, but I want it to be based on the 6 topics
listed above, with +/- equal time given to each during the first and
based on the format below. We should discuss in the coming months and
finalize it some time in mid-March.


Format
------

The Summit will be three days long, with each day having a slightly
different focus, in hopes to maximize the efficiency of the time
together. Unlike OLS, we don't have a full week to informally hash out
the various issues.


* Day 1 - Core Developer Workshop

  This day is dedicated to the invited developers and the issues that
  they have.

  [ I had initially wanted this to be a closed event with just the
  invited developers, but as long as the entire list of attendees is
  kept a reasonable number, I don't mind sharing this with the sponsor
  representatives. If anything, this could considered optional for
  them. ]

  I had initially wanted each developer to present for 45-60 minutes,
  but I do not think we can fit that many presentations into a day.
  By "presentation", I really mean lead a discussion which might
  include a presentation, some pretty graphs, or simply some hand-
  waving.

  I would like to fashion something along these lines (everything
  tenative):

   8:00  -   9:00	Breakfast
   9:00	 -   9:30	Introduction
   9:30  -  10:15	CPU PM Slot 1
  10:15  -  11:00	Suspend Slot 1

  11:00  -  11:30	Break
  11:30  -  12:15	Embedded Slot 1
  12:15  -  13:00	Core Infrastructure Slot 1

  13:00  -  14:00	Lunch
  14:00  -  14:45	Runtime Slot 1
  14:45  -  15:30	Distro/Userspace Topics Slot 1
  15:30	 -  16:15	Suspend Slot 2

  16:15  -  16:45	Break
  16:45	 -  17:30	Embedded Slot 2
  17:30	 -  18:15	Runtime Slot 2

  18:30	 -  ???		Dinner


* Day 2 - Sponsor Presentations

  This day is dedicated to giving the sponsors time to lead a
  discussion about topics they feel are important, overlooked, or soon
  to be a serious issue.

  The format of this will be dependent on how many sponsors we
  have. If the number (and time!) permits, we could give each sponsor
  90 minutes, or two 45 minute slots - one to lead a discussion and
  another to discuss upcoming power management features / devices /
  architectures.

  Maybe something like this:

   8:00  -   9:00	Breakfast
   9:00  -   9:45	Sponsor A, Slot 1
   9:45  -  10:30	Sponsor B, Slot 1

  10:30  -  11:00	Break
  11:00  -  11:45	Sponsor C, Slot 1
  11:45  -  12:30	Sponsor D, Slot 1

  12:30  -  13:30	Lunch
  13:30  -  14:15	Sponsor E, Slot 1
  14:15  -  15:00	Sponsor A Slot 2
  15:00	 -  15:45	Sponsor B, Slot 2

  15:45  -  16:15	Break
  16:15	 -  17:00	Sponsor C, Slot 2
  17:00	 -  17:45	Sponsor D, Slot 2
  17:45	 -  18:30	Sponsor E, Slot 2

  18:30	 -  ???		Dinner


* Day 3 - Workshop

  This day is dedicated to discussing topics that are still issues,
  topics that didn't get covered in the first two days, and topics
  that have arisen since then. In a way, it will be like a day of BoF
  sessions. Each slot will be 1 hour in length. Something like this:

   8:00  -   9:00	Breakfast
   9:00	 -  10:00	Topic 1
  10:00	 -  11:00	Topic 2
  11:00	 -  12:00	Topic 3

  12:00	 -  13:00	Lunck
  13:00	 -  14:00	Topic 4
  14:00	 -  15:00	Topic 5
  15:00	 -  16:00	Topic 6

  16:00	 -  16:30	Break

  16:30	 -  17:00	Closing Remarks

We'll depart early and leave dinner up to the attendees. Seeing as
this is a Friday evening, it will give everyone the opportunity to
make their own weekend plans and/or explore the Bay Area nightlife.



--===============48691462594346313==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============48691462594346313==--
