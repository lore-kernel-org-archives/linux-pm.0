From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: RFC -- updated Documentation/power/devices.txt
Date: Wed, 12 Jul 2006 10:04:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0607120944370.6607-100000@iolanthe.rowland.org>
References: <200607111457.44161.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200607111457.44161.david-b@pacbell.net>
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

Just a few comments...

On Tue, 11 Jul 2006, David Brownell wrote:

> Most suspended devices will have quiesced all I/O:  no more DMA or irqs, =
no
> more data read or written, and requests from upstream drivers are no long=
er
> accepted.  A given bus or platform may have different requirements though.

Mention that a driver may decide to leave the upstream drivers active and =

automatically resume the device whenever a request arrives from upstream.

>    1	bus.suspend_prepare(dev) is called early, with all tasks active.
>    	This method may sleep, and is often morphed into a device
>    	driver call with bus-specific parameters.
> =

> 	Drivers that need to synchronize their suspension with various
> 	management activities could synchronize here.  This may be a good
> 	point to arrange that predictable actions, like removing media from
> 	suspended systems, will not cause trouble on resume.

It's worth mentioning another example: arranging that firmware images
needed for resuming are available, because the userspace helpers that =

provide the firmware won't be running later on.

> also switch off power supplies, or reduce voltages.  A pm_message_t
> parameter is currently used to nuance those semantics (described later).

Please don't use "nuance" as a verb!  (Occurs in several places)

> Resuming Devices
> ----------------
> Resuming is similarly done in multiple phases:
> =

>    1	bus.resume_early(dev) is called with IRQs disabled, and with
>    	only one CPU active.
> =

> 	This reverses the effects of bus.suspend_late().
> =

>    2	bus.resume(dev) is called next.  This may be morphed into a device
>    	driver call with bus-specific parameters.
> =

> 	This reverses the effects of bus.suspend().
> =

>    3	class.resume(dev) is called for devices associated with a class
> 	that has such a method.
> =

> 	This reverses the effects of class.suspend(), and would usually
> 	reactivate the device's I/O queue.

Note that there is no reversal of bus.suspend_early().

> Runtime Power Management
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Many devices are able to dynamically power down while the system is still
> running. This feature is useful for devices that are not being used, and
> can offer significant power savings on a running system; these devices
> often support a range of runtime power states.  Those states will in some
> cases (like PCI) be constrained by a bus the device uses, and will usually
> be hardware states that are also used in system sleep states.
> =

> However, note that if a driver puts a device into a runtime low power sta=
te
> and the system then goes into a system-wide sleep state, it normally ought
> to resume into that runtime low power state rather than "full on".  That
> distinction would be part of the driver-internal state machine for that
> hardware.

Is that last bit really right?  The PM core records each device's power =

state when beginning a system sleep, and it tries to arrange to leave the =

device in that same state when the sleep ends.  This may involve a =

transition through the fully-on state...  I'm not clear on the details.

> The controller will be woken from that state (with an IRQ) by changes to =
the
> signal state on the data lines of a given port, for example by an existing
> peripheral requestin "remote wakeup" or by plugging a new peripheral.  The
----------------------^ typo

> /sys/devices/.../power/state files
> ----------------------------------

Add a paragraph explaining /sys/devices/.../power/wakeup also, even though =

it may not exist in the vanilla kernel yet.

> For now you can also test some of this functionality using sysfs.
> =

> 	DEPRECATED:  USE "power/state" ONLY FOR DRIVER TESTING.
> 	IT WILL BE REMOVED, AND REPLACED WITH SOMETHING WHICH
> 	GIVES MORE APPROPRIATE ACCESS TO THE RANGE OF POWER STATES
> 	EACH TYPE OF DEVICE AND BUS SUPPORTS THROUGH ITS DRIVER.

Once people have decided on what that "something" should be!  :-)

Alan Stern
