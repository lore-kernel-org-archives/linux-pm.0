From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [RFD] How to tell ACPI drivers what the target
	sleep state is (was: Re: [PATCH 1/2] acpi choose sleep state help)
Date: Thu, 21 Jun 2007 22:35:23 +0200
Message-ID: <200706212235.23947.rjw__42479.8795640983$1182457765$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0706211424170.14859-100000@iolanthe.rowland.org>
	<200706211251.52952.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706211251.52952.david-b@pacbell.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thursday, 21 June 2007 21:51, David Brownell wrote:
> On Thursday 21 June 2007, Alan Stern wrote:
> > On Thu, 21 Jun 2007, David Brownell wrote:
> > > On Thursday 21 June 2007, Alan Stern wrote:
> > > > 
> > > > _How_ does the provider know what the next target state is?
> > > 
> > > That's an interface between the provider and the platform's PM code.
> > > Remember those two patches?
> > > ...
> > 
> > Now we're getting back to the question which started this thread.  
> > That patch takes care of one platform, but now consider an ACPI system.  
> > How should the ACPI core learn what the next target system state will
> > be? 
> 
> The original patch -- to which the previous $SUBJECT patch was
> an update -- did more or less the same thing:  pm_ops recorded
> the ACPI target state ...
> 
> 
> > And once it possess that knowledge, what's the best way for it to 
> > tell various subsystems which device states/functions will be
> > supported?
> 
> ... and then exposed a method returning ACPI_STATE_Sx values,
> called by non-core ACPI code.

But we have changed the suspend code ordering and the state
recorded by pm_ops only becomes known to ACPI _after_ we have suspended
devices.

That's what this thread is all about, BTW.

> At which point your narrative falters.  What it's exposed to is
> not a subsystem ... but ACPI versions of hooks invoked by the
> subsystem.  For PCI, to be specific.
> 
> That is, the knowledge of that target sleep state never leaves
> that platform's PM code.  (In this case, ACPI; including its PCI
> support, which lives in drivers/pci not drivers/acpi.)  Because
> no subsystem other than ACPI itself should care how ACPI does any
> of its PM stuff.

All of this is fine, but we need some way to tell ACPI what the next sleep
state will be, because currently _we_ _have_ _not_ one.

So, do we introduce an additional pm_op to do that or are we going to do
something else?
 
> > > Of course, I believe we need to move away from "suspend_state_t"
> > > being effectively just "standby" or "STR" (or "ON") so that more
> > > of the hardware capabilities can be exposed.   Systems that have,
> > > say, seven different hardware states can't fit into Linux today.
> > 
> > I agree that the list of system states should be configurable and 
> > perhaps even adjustable at runtime.  However this is somewhat OT.
> 
> Only slightly; remember, a main reason Linux has so few states is
> that PCs don't use any more.  There are a number of PC-specific
> models and assumptions lurking in this area.  One of them is that
> the target sleep state is anything more than a stepping-stone to
> the important platform-specific information.

As far as my original question is concerned, this is OT.

> > > (Related, I think that target *run* states are under-appreciated.
> > > That's the general runtime PM issue.  Interfaces should work for
> > > run-state transitions as well as sleep-state ones...)
> > 
> > Perhaps something like this: Resource providers have an API whereby
> > drivers can find out what resources either are currently available or
> > will be available in the next system state (a little awkward to specify
> > which is needed).  Then drivers decide on a new device state based on
> > the type of change requested and the available resources, and notify
> > the providers via a second API about any change in resource usage.
> 
> Resource providers have interfaces (*) they expose; yes.  *IF* those
> resources change availability based on system states, there must be
> interfaces drivers can use to notice that.  The providers already have
> interfaces to manage resources, and won't need new cals for that. 
> 
> The calls to expose whether a given in-use resource must be released
> or modified would be simplest if they're just query calls made by
> driver suspend()/resume() methods, but there's also something to be
> said for callbacks in certain contexts.
> 
> (*) "API" == "Application Programming Interface", a userspace thing.
>     So I avoid using that TLA for anything inside the OS kernel.

Agreed.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
