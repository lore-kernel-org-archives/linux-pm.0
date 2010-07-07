From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [REGRESSION] usb devices don't wake up the system
Date: Wed, 7 Jul 2010 11:33:44 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1007071123460.1912-100000@iolanthe.rowland.org>
References: <1278449506.3793.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1278449506.3793.8.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 6 Jul 2010, Maxim Levitsky wrote:

> Ok, it seems that recent changes really did made /proc/acpi/wakeup
> unnecessary.
> 
> 
> Let me explain from beginning the current situation:
> 
> 1. Indeed if I enable manually wakeup on both usb controller, wakeup
> works.
> 
> usb controller = /sys/devices/pci0000:00/0000:00:1a.0/power/wakeup
> usb device = /sys/devices/pci0000:00/0000:00:1a.0/usb2/2-2/power/wakeup
> 
> UDEV rule to set wakeup on usb controller works:
> 
> SUBSYSTEM=="pci", DRIVER=="uhci_hcd", ATTR{power/wakeup}="enabled"
> SUBSYSTEM=="pci", DRIVER=="ehci_hcd", ATTR{power/wakeup}="enabled"
> 
> 
> UDEV rule to set wakeup on device itself just doesn't work, even though
> udev executes it:
> 
> ACTION=="add", ENV{DEVTYPE}=="usb_device", ATTR{power/wakeup}="enabled"
> 
> I did try to add my usb id for mouse like you did. It of course doesn't
> help.
> 
> I also found that above rule, *sometimes* works, but very rarely, so
> indeed something else sets it. I strongly suspect its kernel.

Why not edit drivers/base/power/sysfs.c:wake_store()?  Add something 
like this:

	dev_info(dev, "Process %s wrote: %s\n", current->comm, buf);

Then you'll know for certain what userspace is doing to the wakeup
attribute.  If it turns out that userspace isn't disabling the mouse's
setting then the kernel must be responsible, so you can track down the
problem by bisecting.

> I also think that I shouldn't need to set wakeup to enabled on usb
> controller. This should be done automaticly as soon as I set 'enabled'
> on usb device.

No.  They are two different wakeup settings for two different devices.

Indeed, suppose you had both a USB mouse and a USB keyboard attached to 
the same controller, and suppose you wanted the keyboard to be a wakeup 
device but not the mouse.  Then should disabling wakeup for the mouse 
also disable wakeup for the controller?  Should the wakeup setting for 
the controller always follow the last setting that was changed on any 
device beneath it?  That does not seem like a robust approach.

Alan Stern
