From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: Re: RFC -- updated Documentation/power/devices.txt
Date: Tue, 11 Jul 2006 02:56:13 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A5068E0468@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

One trivial comment would be to use number bullets instead of asterisks
as ordering is important.

> suspending devices
> ------------------
> Suspending a given device is done in several phases.  Each phase will
be
> omitted if it's not relevant for that device.  Other devices will
often
> be suspending at the same time, so each phase will normally be done
for
> all devices before the next phase begins.
> =

> In order, the phases are:
> =

>    *	bus.suspend_prepare(dev) is called early, with all tasks active.
>    	This method may sleep, and is often morphed into a device
>    	driver call with bus-specific parameters.
> =

> 	Drivers that need to synchronize their suspension with various
> 	management activities could synchronize here.  This may be a
good
> 	point to arrange that predictable actions, like removing media
from
> 	suspended systems, will not cause trouble on resume.
> =

>    *	class.suspend(dev) is called after tasks are frozen, for devices
> 	associated with a class that has such a method.

Should/is call.suspend be called before bus.suspend_preapare? If it is
it should be documented first.  Stopping class level things before bus
level which services it seems more natural.  The resume bullets are
documented this way.

> Low Power (suspend) States
> --------------------------
...
> Some details here may be platform-specific.  Systems may have devices
that
> may be fully active in certain sleep states, such as an LCD display
that's
> refreshed using DMA while most of the system is sleeping lightly ...
and
> its framebuffer might even be updated by a DSP or other non-Linux CPU
> while
> the Linux control processor stays idle.

Partial system idle states generally involve several devices.  There
doesn't seem to be a grouping mechanism to define these relationships.
To take device relationships into account we currently look to scripted
user space groupings and notification accesses via extended driver sysfs
endpoints.

> Runtime Power Management
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
...
> In each device's directory, there is a 'power' directory, which
> contains at least a 'state' file. Reading from this file displays what
> power state the device is currently in. Writing to this file initiates
> a transition to the specified power state, which must currently be a
> number: '0' for 'on', or either '2' or '3' for 'suspended' (which
> sometimes also implies reset, especially in conjunction with deeper
> system sleep states).

It would be nice if some of the previous 'on-ness' discussions would
result in some movement here.

Regards,
Richard W.
 =
