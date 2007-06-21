From: David Brownell <david-b@pacbell.net>
Subject: Re: Re: [RFD] How to tell ACPI drivers what the target
	sleep state is (was: Re: [PATCH 1/2] acpi choose sleep state help)
Date: Thu, 21 Jun 2007 12:51:52 -0700
Message-ID: <200706211251.52952.david-b__893.726808908646$1182456991$gmane$org@pacbell.net>
References: <Pine.LNX.4.44L0.0706211424170.14859-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0706211424170.14859-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thursday 21 June 2007, Alan Stern wrote:
> On Thu, 21 Jun 2007, David Brownell wrote:
> > On Thursday 21 June 2007, Alan Stern wrote:
> > > 
> > > _How_ does the provider know what the next target state is?
> > 
> > That's an interface between the provider and the platform's PM code.
> > Remember those two patches?
> > ...
> 
> Now we're getting back to the question which started this thread.  
> That patch takes care of one platform, but now consider an ACPI system.  
> How should the ACPI core learn what the next target system state will
> be? 

The original patch -- to which the previous $SUBJECT patch was
an update -- did more or less the same thing:  pm_ops recorded
the ACPI target state ...


> And once it possess that knowledge, what's the best way for it to 
> tell various subsystems which device states/functions will be
> supported?

... and then exposed a method returning ACPI_STATE_Sx values,
called by non-core ACPI code.

At which point your narrative falters.  What it's exposed to is
not a subsystem ... but ACPI versions of hooks invoked by the
subsystem.  For PCI, to be specific.

That is, the knowledge of that target sleep state never leaves
that platform's PM code.  (In this case, ACPI; including its PCI
support, which lives in drivers/pci not drivers/acpi.)  Because
no subsystem other than ACPI itself should care how ACPI does any
of its PM stuff.


> > Of course, I believe we need to move away from "suspend_state_t"
> > being effectively just "standby" or "STR" (or "ON") so that more
> > of the hardware capabilities can be exposed.   Systems that have,
> > say, seven different hardware states can't fit into Linux today.
> 
> I agree that the list of system states should be configurable and 
> perhaps even adjustable at runtime.  However this is somewhat OT.

Only slightly; remember, a main reason Linux has so few states is
that PCs don't use any more.  There are a number of PC-specific
models and assumptions lurking in this area.  One of them is that
the target sleep state is anything more than a stepping-stone to
the important platform-specific information.


> > (Related, I think that target *run* states are under-appreciated.
> > That's the general runtime PM issue.  Interfaces should work for
> > run-state transitions as well as sleep-state ones...)
> 
> Perhaps something like this: Resource providers have an API whereby
> drivers can find out what resources either are currently available or
> will be available in the next system state (a little awkward to specify
> which is needed).  Then drivers decide on a new device state based on
> the type of change requested and the available resources, and notify
> the providers via a second API about any change in resource usage.

Resource providers have interfaces (*) they expose; yes.  *IF* those
resources change availability based on system states, there must be
interfaces drivers can use to notice that.  The providers already have
interfaces to manage resources, and won't need new cals for that. 

The calls to expose whether a given in-use resource must be released
or modified would be simplest if they're just query calls made by
driver suspend()/resume() methods, but there's also something to be
said for callbacks in certain contexts.

(*) "API" == "Application Programming Interface", a userspace thing.
    So I avoid using that TLA for anything inside the OS kernel.

 
> > > There could be a global next_pm_system_state() routine.  It would have
> > > to return _something_ -- and I think a cookie would be better than a
> > > struct.
> > 
> > But *should* there be such a routine?  Interpreting it would
> > necessarily be very platform-specific.  Why should anyone care
> > about platform-specific calls ... except people writing the
> > platform-specific code to implement and use those calls?
> 
> You forgot one thing.  Yes, the code that makes those calls and uses
> the results would be platform-specific.  But the code that gets called
> would be part of the PM core and hence not platform-specific -- even
> though the values it returns are.

That's the kind of notion that waves red flags at me.  If it's
returning platform-specific values and types, to platform-specific
code, is there any realistic way to view that code as not being
specific to that platform?  Why bother trying to package it as a
core capability, except to show that it's possible to discard
type information at will?

Sure, ACPI_STATE_Sx values aren't declared as "__bitwise", and so
they are very amenable to type punning with values from other
platforms.  But I'd call that sort of thing a "bug" not a "feature".
And I can't see a way to have that routine be part of the PM core
without relying on that bug in a very deep (and error prone) way.


> > I still disagree.  Has anyone even proposed an example of a driver
> > caring about "what the target sleep state is"?  Every example we
> > have seen in the past several years is an example where the relevant
> > detail is something *else* ... something which is only loosely
> > associated with that state, in a very platform-specific way.
> 
> Granted that the association is loose and platform-specific.  
> Nevertheless, it is non-zero.

So are the association with Earthlings, and the non-association with
Martians or Venusians.  ;)

The association is so weak that trying to build on it becomes
rapidly counterproductive.  Focus on the "something else" which
actually matters to the drivers.

- Dave
