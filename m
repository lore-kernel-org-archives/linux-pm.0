From: Adam Belay <abelay-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC] Driver States
Date: Wed, 30 Mar 2005 17:45:16 -0500
Message-ID: <1112222717.3503.213.camel@localhost.localdomain>
References: <1111963367.3503.152.camel@localhost.localdomain>
	<Pine.LNX.4.50.0503292155120.26543-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============64556649750060435=="
Return-path: <linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
In-Reply-To: <Pine.LNX.4.50.0503292155120.26543-100000-x8k/2hhmB0w5etPau2IXcQ@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--===============64556649750060435==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2005-03-29 at 21:57 -0800, Patrick Mochel wrote:
> On Sun, 27 Mar 2005, Adam Belay wrote:
> 
> > Dynamic power management may require devices and drivers to transition
> > between various physical and logical states.  I would like to start a
> > discussion on how these might be defined at the bus, driver, and class
> > levels.
> 
> <snip>
> 
> > Bus Level
> > =========
> > At the bus level, there are two state attributes, power and
> > enable/disable.  Enable/disable may mean different things on different
> > buses, but they generally refer to resource decoding.  A device can only
> > be enabled during a non-off power state.
> 
> <...>
> 
> > Driver Level
> > ============
> > At the driver level there are two areas of interest, physical and
> > logical state.  There is an additional concern of transitioning between
> > these states multiple times.  Because a driver acts as a bridge between
> > physical and logical components, I think separating these steps seems
> > natural.
> 
> <...>
> 
> > *attach - allocates data structures, creates sysfs entries, prepares driver
> >        to handle the hardware.
> >
> > *start -  Sets up device resources and configures the hardware.  Loads
> > firmware, etc.
> > (physical)
> >
> > *open -   engages the hardware, and makes it usable by the class device.
> > (logical and physical)
> >
> > *close -  disengages the hardware, and stops class level access
> > (logical and physical)
> >
> > *stop -   physically disables the hardware
> > (physical)
> >
> > *detach - tears down the driver and releases it from the "struct device"
> >
> 
> You have a few things here that can easily conflict, and that will be
> developed at different paces. I like the direction that it's going, but
> how do you intend to do it gradually. I.e. what to do first?

I think the first step would be for us to all agree on a design, whether
it be this one or another, so we can began planning for long term
changes.

My arguments for these changes are as follows:

     1. If a device has been powered off, powered on, and restored in
        state, it is identical to a device that the driver is
        configuring for the first time.  So calling "*start" as part of
        device resume seems like a logical course of action.
     2. Being able to start and stop a device is useful outside the
        realm of power management.  It's required for resource
        re-balancing.  Also, the user may want to disable a device, but
        the device must still be able to save state and react correctly
        during a suspend.  Allowing the user to start and stop drivers
        gives more flexibility to userspace utilities.  There may be
        sysfs configuration files that can only be changed when the
        device isn't active.  Resource configuration cannot be changed
        when the device is in use.
     3. *open and *close also might be a possibility.  When a device is
        put into a lower power state, we want to stop driver timers and
        prepare the hardware to be inactive, which is exactly the role
        of "*close".  See the existing code in most net drivers.  I
        would like to note, however, that this portion of the API is
        optional, and needs to be looked into further.  I'm considering
        dropping it in favor of having suspend and resume handle this.
     4. Having responsibilities at each driver level encourages a
        layered and object based design, reducing code duplication and
        complexity.

* "*start" and "*stop" might even be useful for device error detection.
(Ex. we currently have no notion of starting up a device over again
after a hardware failure)

I think the next step would be to look at each class subsystem, and
verify that our proposed API could work well with it.  If it's going to
change the design of many device drivers, we want to make sure we get it
right.

>From there, the bus level changes could be made, as they would affect
the least upstream code.  Things like PCI PM could also be improved
during this stage.  Greg, I know that adding *enable, and *disable to
"struct bus_type" would be nice for PCI, ACPI, etc, as it would control
whether resources are decoded and other device initialization
requirements.  What about external devices such as USB?  Would such as
interface be useful for other buses?

Next, we could make changes to "struct device_driver".  As to not break
things, (*start or *attach) and (*stop or *detach) could be temporarily
mapped to *probe and *remove until everything is fixed up.  This hack
could be made at the bus level, so the fixes could be applied one bus at
a time.

The final step would be to introduce "*open and *close", if we decide to
use them, and also class device *start and *stop.  Pat, do you have any
comments on adding *start and *stop to class devices?  It seems like an
interesting possibility to me.

Thanks,
Adam



--===============64556649750060435==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============64556649750060435==--
