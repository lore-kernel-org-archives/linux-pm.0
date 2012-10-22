From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Subject: Re: USB port power off discussion
Date: Mon, 22 Oct 2012 11:08:44 -0700
Message-ID: <20121022180844.GC5378@xanatos>
References: <Pine.LNX.4.44L0.1209241709430.1583-100000@iolanthe.rowland.org>
 <201209250009.06713.rjw@sisk.pl>
 <20120924221036.GG29990@xanatos>
 <84398681.LDNNF19qAk@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:31994 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755980Ab2JVSJF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 22 Oct 2012 14:09:05 -0400
Content-Disposition: inline
In-Reply-To: <84398681.LDNNF19qAk@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, Lan Tianyu <tianyu.lan@intel.com>, Greg KH <gregkh@linuxfoundation.org>, Len Brown <lenb@kernel.org>, Arjan Van De Ven <arjan@linux.intel.com>, Oliver Neukum <oneukum@suse.de>, linux-usb@vger.kernel.org, linux-pm@vger.kernel.org

On Mon, Oct 15, 2012 at 08:42:47AM +0200, Rafael J. Wysocki wrote:
> Sorry for the delay, I have been distracted by a number of things.

Me too. :)

> On Monday 24 of September 2012 15:10:36 Sarah Sharp wrote:
> > On Tue, Sep 25, 2012 at 12:09:06AM +0200, Rafael J. Wysocki wrote:
> > > What about hubs connected to such ports?  I don't think they're going to
> > > work when power is removed from it, are they?
> > 
> > USB hubs would have remote wakeup enabled, so we would never power off
> > their port with the "auto" policy.
> 
> Here's my idea how to arrange things.
> 
> Why don't make runtime PM manage the USB port power on/off such that the
> port's .runtime_suspend() routine will remove power from it, if
> PM_QOS_FLAG_NO_POWER_OFF is not (effectively) set for it, and its
> .runtime_resume() will restore power to it (if removed previously).

Ok, so you're basically proposing we power off suspended devices, except
when userspace (or perhaps the kernel) sets PM_QOS_FLAG_NO_POWER_OFF?

What happens if userspace clears the PM_QOS_FLAG_NO_POWER_OFF flag while
the port is suspended?  Does the USB core then re-power it on?  Should
it also resume the device?

> The USB core will then do pm_runtime_get_sync() on the port every time
> a device depending on it is added and pm_runtime_put() every time such
> a device is removed.

Are you saying that every time a device is connected to an _external_
hub, the USB core would call pm_runtime_get_sync()?  If you apply that
policy to roothubs, then you're basically disabling port power off when
a device is connected, which doesn't make sense in conjunction to your
last sentence, so now I'm just confused, sorry.

Wouldn't it make more sense to call pm_runtime_get_sync() when remote
wakeup is enabled for a device, and pm_runtime_put() when remote wakeup
is disabled?  That way, when an external hub is attached to the port, it
always has remote wakeup enabled, so we will always increment the PM
counter. [1]

> The initial setting of PM_QOS_FLAG_NO_POWER_OFF in the PM QoS request
> structure used by user space will depend on the type of the port (e.g.
> it will be unset for ports that aren't visible to the user and connectable).
> 
> That should allow things to work automatically and it should allow user space
> to override the defaults in any case, either by disabling runtime PM for the
> ports altogether (by writing "on" to their device objects' "control" sysfs
> files), or by setting/unsetting PM_QOS_FLAG_NO_POWER_OFF in the PM QoS
> request controlled by it as desired.

Are you then pushing the policy decision for whether ports should be
powered off completely into userspace then?  I.e. you want userspace to
read the ACPI port connect type info and clear PM_QOS_FLAG_NO_POWER_OFF
in the userspace structure if the port is not user visible and not
connectable?

Or are you thinking the kernel will set PM_QOS_FLAG_NO_POWER_OFF based
on the ACPI tables and userspace will have the option to override it?

We also probably need to allow USB interface drivers to set
PM_QOS_FLAG_NO_POWER_OFF as well, for cases like devices that have
firmware or other internal state.  We probably need a USB core API to
add a request for PM_QOS_FLAG_NO_POWER_OFF to be set, and a way to clear
that flag if the driver is unbound or the driver decides it's safe to
power off the device.

> > There are things like USB lights or fans that pull port power, but don't
> > actually enumerate as a USB device.  So to the OS, those would be
> > "empty" ports.  But they would be external ports, so the default "auto"
> > policy would never power off external ports.  The user could write a
> > small script to PWM the fan on and off to control the speed.  It would
> > just be a novelty though, as Alan said.
> 
> For those things we can provide a "raw port driver" with ioctls allowing
> user space to get the port's physical location information from the kernel,
> if available, and manipulate the port's power on the low level.

Sure, I think it's fine to push that corner case off to usbdevfs.

Sarah Sharp

[1] The above sentence doesn't apply to VIA USB 3.0 hubs, because they
don't actually advertise remote wakeup in their device descriptors.
However, the USB core will never suspend those hubs, so we'll never
power off the USB 3.0 port the device is connected to.  Not sure how
they'll react to having the USB 2.0 portion powered off while the USB
3.0 potion is powered.  We'll see.  I really hate these uncertified
hubs.
