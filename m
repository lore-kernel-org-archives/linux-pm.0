From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: USB port power off discussion
Date: Mon, 22 Oct 2012 14:37:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1210221422380.1724-100000@iolanthe.rowland.org>
References: <20121022180844.GC5378@xanatos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:53450 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755771Ab2JVShy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Oct 2012 14:37:54 -0400
In-Reply-To: <20121022180844.GC5378@xanatos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Lan Tianyu <tianyu.lan@intel.com>, Greg KH <gregkh@linuxfoundation.org>, Len Brown <lenb@kernel.org>, Arjan Van De Ven <arjan@linux.intel.com>, Oliver Neukum <oneukum@suse.de>, USB list <linux-usb@vger.kernel.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>

On Mon, 22 Oct 2012, Sarah Sharp wrote:

> On Mon, Oct 15, 2012 at 08:42:47AM +0200, Rafael J. Wysocki wrote:
> > Sorry for the delay, I have been distracted by a number of things.
> 
> Me too. :)
> 
> > On Monday 24 of September 2012 15:10:36 Sarah Sharp wrote:
> > > On Tue, Sep 25, 2012 at 12:09:06AM +0200, Rafael J. Wysocki wrote:
> > > > What about hubs connected to such ports?  I don't think they're going to
> > > > work when power is removed from it, are they?
> > > 
> > > USB hubs would have remote wakeup enabled, so we would never power off
> > > their port with the "auto" policy.
> > 
> > Here's my idea how to arrange things.
> > 
> > Why don't make runtime PM manage the USB port power on/off such that the
> > port's .runtime_suspend() routine will remove power from it, if
> > PM_QOS_FLAG_NO_POWER_OFF is not (effectively) set for it, and its
> > .runtime_resume() will restore power to it (if removed previously).
> 
> Ok, so you're basically proposing we power off suspended devices, except
> when userspace (or perhaps the kernel) sets PM_QOS_FLAG_NO_POWER_OFF?

Rafael is suggesting that the interface to control when ports get
powered off should be associated with the usb_port device, rather than
with the usb_device attached to the port.

> What happens if userspace clears the PM_QOS_FLAG_NO_POWER_OFF flag while
> the port is suspended?  Does the USB core then re-power it on?  Should
> it also resume the device?

I don't know how the PM QOS flags interact with runtime PM.  Rafael may 
still be working on that.

At any rate, runtime suspend for the usb_port will remove power.  
Runtime resume will turn power back on.  But if there's a usb_device 
attached to the port, resuming the port will not necessarily resume the 
device.  (However, we will be careful to make sure that the port cannot 
be runtime suspended unless the device is suspended first.)

> > The USB core will then do pm_runtime_get_sync() on the port every time
> > a device depending on it is added and pm_runtime_put() every time such
> > a device is removed.
> 
> Are you saying that every time a device is connected to an _external_
> hub, the USB core would call pm_runtime_get_sync()?  If you apply that
> policy to roothubs, then you're basically disabling port power off when
> a device is connected, which doesn't make sense in conjunction to your
> last sentence, so now I'm just confused, sorry.

He is saying that the core would call pm_runtime_get_sync(&port->dev),
not pm_runtime_get_sync(&udev->dev).  And this would only be for while
the device was active, not for when the device is suspended (unless the 
device can't handle loss of power).

> Wouldn't it make more sense to call pm_runtime_get_sync() when remote
> wakeup is enabled for a device, and pm_runtime_put() when remote wakeup
> is disabled?  That way, when an external hub is attached to the port, it
> always has remote wakeup enabled, so we will always increment the PM
> counter. [1]
> 
> > The initial setting of PM_QOS_FLAG_NO_POWER_OFF in the PM QoS request
> > structure used by user space will depend on the type of the port (e.g.
> > it will be unset for ports that aren't visible to the user and connectable).
> > 
> > That should allow things to work automatically and it should allow user space
> > to override the defaults in any case, either by disabling runtime PM for the
> > ports altogether (by writing "on" to their device objects' "control" sysfs
> > files), or by setting/unsetting PM_QOS_FLAG_NO_POWER_OFF in the PM QoS
> > request controlled by it as desired.
> 
> Are you then pushing the policy decision for whether ports should be
> powered off completely into userspace then?  I.e. you want userspace to
> read the ACPI port connect type info and clear PM_QOS_FLAG_NO_POWER_OFF
> in the userspace structure if the port is not user visible and not
> connectable?
> 
> Or are you thinking the kernel will set PM_QOS_FLAG_NO_POWER_OFF based
> on the ACPI tables and userspace will have the option to override it?

The latter.

> We also probably need to allow USB interface drivers to set
> PM_QOS_FLAG_NO_POWER_OFF as well, for cases like devices that have
> firmware or other internal state.  We probably need a USB core API to
> add a request for PM_QOS_FLAG_NO_POWER_OFF to be set, and a way to clear
> that flag if the driver is unbound or the driver decides it's safe to
> power off the device.

How about adding a no_power_off flag to the usb_interface structure, 
analogous to the needs_remote_wakeup flag?

Alan Stern

