From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [RFD] How to tell ACPI drivers what the target
	sleep state is (was: Re: [PATCH 1/2] acpi choose sleep state help)
Date: Thu, 21 Jun 2007 21:41:40 +0200
Message-ID: <200706212141.40726.rjw__21956.9991845221$1182454531$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0706211110480.3547-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0706211110480.3547-100000@iolanthe.rowland.org>
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

On Thursday, 21 June 2007 17:23, Alan Stern wrote:
> On Thu, 21 Jun 2007, Rafael J. Wysocki wrote:
> 
> > > Just do 1). Global variables are ugly, and we already have space in
> > > pm_message_t. 
> > 
> > Well, this is what Len voted for, I think.  David is against it.
> > 
> > I also think that the cleanest way would be to pass that as an argument
> > to .suspend(), but currently pm_message_t. is passed by value and if we
> > made it a real struct (ie. with more than one field), that would also become
> > ugly, IMHO.
> > 
> > So, can we make pm_message_t consist only of the target state?
> 
> You're both repeating the mistakes from two years ago.
> 
> You can't use a simple type to describe a target system state.  While 
> it might work for ACPI states, it won't work on general (i.e., 
> non-ACPI) systems.

I don't want to _describe_ system sleep states this way.

> It's probably a mistake even to use a data  structure to describe a system
> state, since the requirements are so complex.

We already have defined two system sleep states that we think all of the
architectures may support: 'standby' and 'suspend'.  Why don't we assign an
integer to each of them?

> The only reasonable approach is to describe it in code. 
> 
> What you can do is this: Pick a small enumerated set of labels for some 
> selected system states.  For example:
> 
> enum pm_system_state {
> 	PM_STATE_RUNNING,

What for?

> 	PM_STATE_STANDBY,
> 	PM_STATE_SUSPEND,
> 	PM_STATE_HIBERNATE,

Different thing.

> };
> 
> (It might be preferable to make the list more configurable, perhaps 
> even allow changes at runtime.  Never mind all that for now.)

Let me repeat: we _only_ need to tell drivers what the target system sleep
state will be.  No less, no more.

We can do this using the existing pm_message_t, perhaps slightly modifying it,
or anything else, and in fact I don't care much what that will be.  I'd only
prefer to use a .suspend() argument for this purpose, but if you think that
has to be a global variable for whatever practical reason, I'm fine with that
too.

> These are merely labels, they don't actually describe anything.  To use 
> them, you would have to pass them to a subsystem routine for 
> interpretation.  For example, pci_select_state() might pass one of 
> these things to an ACPI routine, which would know what ACPI state 
> corresponded to the given pm_system_state and would be able to say what 
> D-state would be appropriate for a given PCI device.  On a non-ACPI 
> platform, pci_select_state() would have to call a different routine -- 
> something platform-dependent -- to do the same job.
> 
> 
> On the other hand, maybe you don't need anything like this at all.  
> What would happen if a PCI driver put its device into a D-state which 
> wasn't supported under the target ACPI state?  Would it be so terrible?
> I can imagine that the requested wakeup functionality might not be 
> available, but would it prevent the device from working properly when 
> it was resumed?

Yes, I think so, in general.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
