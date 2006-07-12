From: David Brownell <david-b@pacbell.net>
Subject: Re: RFC -- updated Documentation/power/devices.txt
Date: Wed, 12 Jul 2006 08:45:46 -0700
Message-ID: <200607120845.47410.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0607120944370.6607-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0607120944370.6607-100000@iolanthe.rowland.org>
Content-Disposition: inline
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
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 12 July 2006 7:04 am, Alan Stern wrote:
> Just a few comments...
> =

> On Tue, 11 Jul 2006, David Brownell wrote:
> =

> > Most suspended devices will have quiesced all I/O:  no more DMA or irqs=
, no
> > more data read or written, and requests from upstream drivers are no lo=
nger
> > accepted.  A given bus or platform may have different requirements thou=
gh.
> =

> Mention that a driver may decide to leave the upstream drivers active and =

> automatically resume the device whenever a request arrives from upstream.

I added similar text right after the #2 mode says that upstream drivers
won't know or care about this state, a para earlier.  Right there, I think
such nuances would be confusing ... that whole section is just background
and frame-setting.


> >    1	bus.suspend_prepare(dev) is called early, with all tasks active.
> >    	This method may sleep, and is often morphed into a device
> >    	driver call with bus-specific parameters.
> > =

> > 	Drivers that need to synchronize their suspension with various
> > 	management activities could synchronize here.  This may be a good
> > 	point to arrange that predictable actions, like removing media from
> > 	suspended systems, will not cause trouble on resume.
> =

> It's worth mentioning another example: arranging that firmware images
> needed for resuming are available, because the userspace helpers that =

> provide the firmware won't be running later on.

Hmm, agreed that firmware reload is an issue, but I'm not totally sure
that's the right place to address that ... I'll add "needing to reload
firmware" as another predictable action though.


> > also switch off power supplies, or reduce voltages.  A pm_message_t
> > parameter is currently used to nuance those semantics (described later).
> =

> Please don't use "nuance" as a verb!  (Occurs in several places)

Erm, OK; "refine" then ... the fact that something can be nuanced
evidently does not imply that something has nuanced it.  ;)


> Note that there is no reversal of bus.suspend_early().

Self-evident yes?  Maybe we _should_ have a resume_late() though...


> > Runtime Power Management
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > Many devices are able to dynamically power down while the system is sti=
ll
> > running. This feature is useful for devices that are not being used, and
> > can offer significant power savings on a running system; these devices
> > often support a range of runtime power states.  Those states will in so=
me
> > cases (like PCI) be constrained by a bus the device uses, and will usua=
lly
> > be hardware states that are also used in system sleep states.
> > =

> > However, note that if a driver puts a device into a runtime low power s=
tate
> > and the system then goes into a system-wide sleep state, it normally ou=
ght
> > to resume into that runtime low power state rather than "full on".  That
> > distinction would be part of the driver-internal state machine for that
> > hardware.
> =

> Is that last bit really right?  The PM core records each device's power =

> state when beginning a system sleep, and it tries to arrange to leave the =

> device in that same state when the sleep ends.  This may involve a =

> transition through the fully-on state...  I'm not clear on the details.

I think the PM core should stop recording _its_ notion of the power state,
but that's a different discussion.

Yes that bit is right, it's just emphasizing that there _is_ a state machine
in the driver (or should be!), and that with runtime power management it's
not going to be in lock-step with system suspend/resume transitions.  That
is after all the whole point of runtime device PM:  to decouple from those
system-wide transitions so that "system on" needn't imply "device on".


> > The controller will be woken from that state (with an IRQ) by changes t=
o the
> > signal state on the data lines of a given port, for example by an exist=
ing
> > peripheral requestin "remote wakeup" or by plugging a new peripheral.  =
The
> ----------------------^ typo

Fixed.

> > /sys/devices/.../power/state files
> > ----------------------------------
> =

> Add a paragraph explaining /sys/devices/.../power/wakeup also, even thoug=
h =

> it may not exist in the vanilla kernel yet.

It does exist in vanilla kernels, for several releases now!  And mentioned
in several places there already.  It's not just for runtime PM either; I'll
add a section earlier on.

 =

> > For now you can also test some of this functionality using sysfs.
> > =

> > 	DEPRECATED:  USE "power/state" ONLY FOR DRIVER TESTING.
> > 	IT WILL BE REMOVED, AND REPLACED WITH SOMETHING WHICH
> > 	GIVES MORE APPROPRIATE ACCESS TO THE RANGE OF POWER STATES
> > 	EACH TYPE OF DEVICE AND BUS SUPPORTS THROUGH ITS DRIVER.
> =

> Once people have decided on what that "something" should be!  :-)

Certainly.  But there seems to be no disagreement that power/state is
broken for a variety of reasons.

- Dave



> Alan Stern
> =
