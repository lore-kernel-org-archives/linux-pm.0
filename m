From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [Resend][PATCH] PM: Move disabling/enabling runtime PM to late
 suspend/early resume
Date: Sun, 16 Dec 2012 10:29:47 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1212161028330.13850-100000@netrider.rowland.org>
References: <3558004.3QJ46yYCyI@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3558004.3QJ46yYCyI@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jiri Kosina <jkosina@suse.cz>, Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jan-Matthias Braun <jan_braun@gmx.net>
List-Id: linux-pm@vger.kernel.org

On Sun, 16 Dec 2012, Rafael J. Wysocki wrote:

> On Saturday, December 15, 2012 10:16:29 PM Jiri Kosina wrote:
> > On Sat, 15 Dec 2012, Rafael J. Wysocki wrote:
> > 
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > 
> > > Currently, the PM core disables runtime PM for all devices right
> > > after executing subsystem/driver .suspend() callbacks for them
> > > and re-enables it right before executing subsystem/driver .resume()
> > > callbacks for them.  This may lead to problems when there are
> > > two devices such that the .suspend() callback executed for one of
> > > them depends on runtime PM working for the other.  In that case,
> > > if runtime PM has already been disabled for the second device,
> > > the first one's .suspend() won't work correctly (and analogously
> > > for resume).
> > > 
> > > To make those issues go away, make the PM core disable runtime PM
> > > for devices right before executing subsystem/driver .suspend_late()
> > > callbacks for them and enable runtime PM for them right after
> > > executing subsystem/driver .resume_early() callbacks for them.  This
> > > way the potential conflitcs between .suspend_late()/.resume_early()
> > > and their runtime PM counterparts are still prevented from happening,
> > > but the subtle ordering issues related to disabling/enabling runtime
> > > PM for devices during system suspend/resume are much easier to avoid.
> > > 
> > > Reported-and-tested-by: Jan-Matthias Braun <jan_braun@gmx.net>
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Hi Rafael,
> > 
> > just curious what is the reason for resend? Do you want to gather more 
> > Acks before pushing this upstream?
> 
> Well, I thought that some people might actually look at it when they found it
> again in their mailboxes. :-)

I did look at it the first time it appeared.  It seemed to be okay, but 
I haven't tried any testing.

Alan Stern
