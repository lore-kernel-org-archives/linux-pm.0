From: Adam Belay <ambx1@neo.rr.com>
Subject: Re: [RFC 3/3] Runtime PM support for named power states
Date: Wed, 5 Oct 2005 16:48:06 -0400
Message-ID: <20051005204806.GD3306@neo.rr.com>
References: <20051005013133.87E7BBF45E@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
	<Pine.LNX.4.44L0.0510051454540.6157-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============73835788514767708=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0510051454540.6157-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Brownell <david-b@pacbell.net>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============73835788514767708==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 05, 2005 at 04:08:03PM -0400, Alan Stern wrote:
> On Tue, 4 Oct 2005, David Brownell wrote:
> 
> > Let's forget about the names for a moment (which I certainly prefer
> > in sysfs, especially with driver-controlled values).
> > 
> > The "confusion" is that there are two notions of state:
> > 
> >  - One of them is for system sleep transitions, and in practice it's
> >    nothing more than "I successfully called suspend_device()".
> > 
> >  - The other notion is for runtime power management, and it needs
> >    a richer notion.  Part of that is that the states are defined
> >    by the driver (or bus).
> 
> In the early stages of the PM development, the developers thought a device
> was either ON or SUSPENDed and imagined this would suffice for runtime 
> PM.  So there was originally just one notion of state, which has since 
> split into two.
> 
> > My theory is that the PM core doesn't need any notion that's more
> > complex than "moved device from <this> device list to <that> one".
> > Suspend and resume just move devices between lists.
> 
> Sounds reasonable.  There's one thing to consider, though.  System sleep
> transitions are supposed to work even when devices are already in a
> low-power state, which some drivers may not be able to handle.  That's the
> main reason why dev->power.power_state exists today -- so that the PM core
> can see if a device needs to be set back to full power before suspending
> it.
> 
> IMO we could avoid the need for power_state by removing the guarantee
> about never calling ->suspend when a device is already in a low-power
> state.  The system sleep code could issue an optimistic ->suspend call,
> and if that fails then do ->resume followed by ->suspend.

Another solution would be to make it entirely the driver's responsibility.
We could just unconditionally issue ->suspend and it could be a noop if
the device is already in a low power state.  If driver knows the device
needs to be powered back on and then off again to complete the suspend
transition then all of this can happen inside the ->suspend method.

I see ->suspend and ->resume as a way to notify drivers of userspace
requests and system state changes.  The driver can determine its own
actions for each of these requests.

> 
> > One nice consequence of that theory is that there's nothing to
> > prevent completly ripping out the other notions of power state.
> > Or -- equivalently, but less painfully! -- repurposing all that
> > infrastructure to the exclusive use of runtime PM.  Which I'd
> > argue only really needs one cookie identifying the device state.
> > Be it a string constant, or whatever.
> 
> That's why I wrote the patch in that form.  Since we need string constants 
> for user interaction anyway, they may as well serve as the state 
> indicator.
> 
> As part of the infrastructure changes, we could remove
> dev->power.power_state, dev->power.prev_state, and maybe also
> dev->power.saved_state (currently it is used only in a few platform
> drivers for stuff that could easily be stored in a private data
> structure).  Nothing would be needed but the name pointer, and that should
> be under the bus/driver's control.
> 
> People have already pretty much agreed that ->resume needs to take a 
> pm_message_t argument, and that will mean changing a lot of drivers.  We 
> ought to settle on a decision about the rest of this too, so we won't have 
> to go through and change them all yet again.

Right.

> 
> (BTW, a theoretical advantage of passing a pm_message_t to ->resume is
> that a driver could use the _same_ subroutine as a combined suspend/resume
> method.  :-))

Yeah, this occured to me also.  Should we go for it?  What would we call it?
(e.g. ->statectl()).

-->snip

> 
> > I suspect only driver code should ever care about device states.
> > 
> > The PM core should just tell drivers to become compatible with some
> > new constraint (like ACPI S3, generally implying devices in PCI D2
> > or D3; while S1 doesn't) ... and not worry about whether that involves
> > a state change or not.
> > 
> > Maybe they're already _in_ that state for example.

I agree.


-Adam

--===============73835788514767708==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============73835788514767708==--
