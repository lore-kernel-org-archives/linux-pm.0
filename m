From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC][PATCH 0/3] PM: Mechanism to avoid resuming runtime-suspended devices during system suspend, v2
Date: Fri, 25 Apr 2014 00:36:33 +0200
Message-ID: <5039115.7hOuWtlQhG@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1402271001190.1150-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1402271001190.1150-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Aaron Lu <aaron.lu@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, February 27, 2014 10:02:05 AM Alan Stern wrote:
> On Thu, 27 Feb 2014, Rafael J. Wysocki wrote:
> 
> > > If the child knows about the problem beforehand, it can runtime-resume 
> > > the parent during its ->suspend.
> > 
> > Well, it even should do that in those cases.  We may need to deal with children
> > that don't do that, though.
> > 
> > > > Well, if power.fast_suspend set guarantees that ->suspend_late, ->suspend_noirq,
> > > > ->resume_noirq, and ->resume_early will be skipped for a device, then we may
> > > > restrict setting it for devices whose children have it set (or that have no
> > > > children).  Initially, that will be equivalent to setting it for leaf devices
> > > > only, but it might be extended over time in a natural way.
> > > 
> > > Initially, maybe.
> > 
> > Of course initially.
> > 
> > > But it's the wrong approach in general.
> > 
> > In the long run - I agree.
> > 
> > > The right approach is to restrict setting fast_suspend for devices whose
> > > children don't mind their parent being suspended when their resume callbacks 
> > > run -- not for devices whose children also have fast_suspend set.
> > 
> > I agree, but we need to know which children are OK with the parent being
> > suspended.  Having fast_suspend set is a good indication of that. :-)
> > 
> > Of course, we may introduce a separate flag for that just fine if you prefer.
> > 
> > > That's the point I've been trying to express all along.
> > 
> > I see.
> 
> Okay.  I'll wait to see the next version.

Well, that took some time, but a new version follows.

It uses two flags (see the changelog of patch [1/3]) and is reworked on top of
the changes that went into 3.15-rc.  Patch [2/3] is just a resend.

Thanks,
Rafael
