From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/1] suspend: make sync() on suspend-to-RAM optional
Date: Wed, 22 Jul 2015 09:23:23 +0200
Message-ID: <20150722072322.GA18401@amd>
References: <1436927091-32520-1-git-send-email-lenb@kernel.org>
 <CAJZ5v0gNKRRaXvfqvj4YEjb+7X1aEobfvWuWyAnAcKArcxtZPA@mail.gmail.com>
 <20150721151941.GA19581@amd>
 <7453812.eRsb3OQU2z@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54943 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753882AbbGVHXZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jul 2015 03:23:25 -0400
Content-Disposition: inline
In-Reply-To: <7453812.eRsb3OQU2z@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Brown, Len" <len.brown@intel.com>, Austin S Hemmelgarn <ahferroin7@gmail.com>, Len Brown <lenb@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed 2015-07-22 03:25:41, Rafael J. Wysocki wrote:
> On Tuesday, July 21, 2015 05:19:41 PM Pavel Machek wrote:
> > On Tue 2015-07-21 16:41:12, Rafael J. Wysocki wrote:
> > > Hi Pavel,
> > > 
> > > On Tue, Jul 21, 2015 at 11:38 AM, Pavel Machek <pavel@ucw.cz> wrote:
> > > > On Sat 2015-07-18 01:54:09, Rafael J. Wysocki wrote:
> > > >> On Wednesday, July 15, 2015 02:58:22 PM Brown, Len wrote:
> > > 
> > > [cut]
> > > 
> > > >> > >> Why do you need CONFIG parameter?
> > > >> >
> > > >> > So that an OS that doesn't want to change their user-space,
> > > >> > can build a kernel that does what they want by default.
> > > >> >
> > > >> > Originally I had the config parameter remove this code entirely,
> > > >> > which would achieve the same goal.
> > > >> > But Rafael prefers the sysfs attribute always exist
> > > >> > and the config simply set the default.
> > > >>
> > > >> Indeed.
> > > >>
> > > >> And so I'm queuing this patch up for 4.3 (with a couple of minor fixups).
> > > >
> > > > Please don't.
> > > >
> > > > "OS that doesn't want to change the user-space to speed up suspend by
> > > > few milliseconds" is not a valid reason for asking about million users
> > > > one more config question.
> > > 
> > > That's your opinion and I beg to differ.
> > 
> > Perhaps explaining your opinion would help here? Having to echo value
> > to file to improve performance over reliability does not look too
> > burdensome on the users.
> 
> That's for the people for whom changing the kernel is easier than messing
> up with user space.

You are maintainer of s2ram package, IIRC. If you don't like extra
syncs, you should remove them from the user part (where they are racy,
unlike in kernel).

Unfortunately, it will be harder to do that if CONFIG_ option is
introduced, because now s2ram will need extra work to determine if
kernel will sync or not.

> Also if your user space does the sync before suspending, it's better to
> make "no kernel sync" the default, because that saves you some overhead
> and energy too (either on the extra redundant sync on every suspend or
> on the write to the sysfs attribute on every boot).

So you want to "save the overhead of writing to sysfs file on boot" (30usec?)
but are happy to "add overhead of extra config question" (5 seconds
_user_ has to decide what is going on)...? What about overhead of
reading longer config file on each kernel compile?

> > > > Affected users can't run mainline kernel
> > > > anyway, and will have to change their userland in non-trivial ways to
> > > > get there.
> > > 
> > > And I'm not sure what you're talking about here.  Who are the
> > > "affected users" in particular?
> > 
> > Who does enter suspend to ram multiple times a second? Only android,
> > AFAICT. Can you run android on mainline kernel? No. Can you run
> > android on kernel with less that 100k lines of patches? No.
> > 
> > So who benefits from the new config option? No one.
> 
> I am, for one.  None of the systems I use actually needs the sync in the
> kernel.  I bet there are more people like me, because I have a stock
> distro installed on my systems.

If the bug is in distro (extra syncs) it should be solved in distro
(remove the extra syncs, keep the in-kernel one that works). CONFIG_
option actually makes that harder.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
