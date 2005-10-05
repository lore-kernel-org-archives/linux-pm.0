From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC 3/3] Runtime PM support for named power states
Date: Wed, 5 Oct 2005 16:08:03 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0510051454540.6157-100000@iolanthe.rowland.org>
References: <20051005013133.87E7BBF45E@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============32047745413371587=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051005013133.87E7BBF45E@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============32047745413371587==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Tue, 4 Oct 2005, David Brownell wrote:

> Let's forget about the names for a moment (which I certainly prefer
> in sysfs, especially with driver-controlled values).
> 
> The "confusion" is that there are two notions of state:
> 
>  - One of them is for system sleep transitions, and in practice it's
>    nothing more than "I successfully called suspend_device()".
> 
>  - The other notion is for runtime power management, and it needs
>    a richer notion.  Part of that is that the states are defined
>    by the driver (or bus).

In the early stages of the PM development, the developers thought a device
was either ON or SUSPENDed and imagined this would suffice for runtime 
PM.  So there was originally just one notion of state, which has since 
split into two.

> My theory is that the PM core doesn't need any notion that's more
> complex than "moved device from <this> device list to <that> one".
> Suspend and resume just move devices between lists.

Sounds reasonable.  There's one thing to consider, though.  System sleep
transitions are supposed to work even when devices are already in a
low-power state, which some drivers may not be able to handle.  That's the
main reason why dev->power.power_state exists today -- so that the PM core
can see if a device needs to be set back to full power before suspending
it.

IMO we could avoid the need for power_state by removing the guarantee
about never calling ->suspend when a device is already in a low-power
state.  The system sleep code could issue an optimistic ->suspend call,
and if that fails then do ->resume followed by ->suspend.

> One nice consequence of that theory is that there's nothing to
> prevent completly ripping out the other notions of power state.
> Or -- equivalently, but less painfully! -- repurposing all that
> infrastructure to the exclusive use of runtime PM.  Which I'd
> argue only really needs one cookie identifying the device state.
> Be it a string constant, or whatever.

That's why I wrote the patch in that form.  Since we need string constants 
for user interaction anyway, they may as well serve as the state 
indicator.

As part of the infrastructure changes, we could remove
dev->power.power_state, dev->power.prev_state, and maybe also
dev->power.saved_state (currently it is used only in a few platform
drivers for stuff that could easily be stored in a private data
structure).  Nothing would be needed but the name pointer, and that should
be under the bus/driver's control.

People have already pretty much agreed that ->resume needs to take a 
pm_message_t argument, and that will mean changing a lot of drivers.  We 
ought to settle on a decision about the rest of this too, so we won't have 
to go through and change them all yet again.

(BTW, a theoretical advantage of passing a pm_message_t to ->resume is
that a driver could use the _same_ subroutine as a combined suspend/resume
method.  :-))

> > The problem is made even worse by the way runtime_resume() and 
> > runtime_suspend() assign their own values to dev->power.power_state, 
> > overwriting whatever the driver may have put there.  I should have taken 
> > out those assignments; they really don't do any good.
> 
> Well, virtually no drivers set that value themselves.  I think
> that suspend.c::suspend_device() should probably set the value,
> at least for devices that don't change it themselves, ditto with
> the corresponding resume path.
> 
> (IMO it's clearly wrong to clobber a power_state value that the
> driver set ... it surely knows more about itself than the pm core.)

Drivers _should_ manage these values, especially if they will be used by 
sysfs.  On the other hand, if there are only two states then the PM core 
can assume that the first is ON and the second is SUSPEND, so it could 
handle the updates by itself.

> I suspect only driver code should ever care about device states.
> 
> The PM core should just tell drivers to become compatible with some
> new constraint (like ACPI S3, generally implying devices in PCI D2
> or D3; while S1 doesn't) ... and not worry about whether that involves
> a state change or not.
> 
> Maybe they're already _in_ that state for example.

The PM core shouldn't worry too much about redundant calls.  Drivers can
easily filter them out, and the core won't have enough information to
detect them in general.

As I see it, we can use the new .name field to distinguish between the 
different kinds of system state change calls.  The PM core could export 
strings like (for FREEZE):

	APM-standby, APM-suspend, snapshot, kexec;

or (for SUSPEND):

	RAM, S3, S4, S5, shutdown;

or (for RESUME):

	snapshot, RAM, kexec.

Something like this will provide drivers the means for telling which
target state to use, thus addressing one of your biggest complaints about
the current system.

Of course, this means that drivers will need code to map these 
higher-level names to the appropriate target state, although that code 
wouldn't need to be very sophisticated.  It would have to be smart enough 
to recognize that when .event is PM_EVENT_RUNTIME, the name indicates the 
requested power state directly.

Alan Stern


--===============32047745413371587==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============32047745413371587==--
