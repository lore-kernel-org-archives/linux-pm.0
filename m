From: Mattia Dongili <malattia@linux.it>
Subject: Re: Re: [2.6.22-rc1-mm1] vaio laptop (SZ72B) immediately
	resumes after STR
Date: Thu, 21 Jun 2007 18:22:04 +0900
Message-ID: <20070621092204.GB10635__8739.21832903779$1182418076$gmane$org@inferi.kami.home>
References: <20070620144532.GA3761@inferi.kami.home>
	<Pine.LNX.4.44L0.0706201220150.3518-100000@iolanthe.rowland.org>
	<20070621064215.GB9050@inferi.kami.home>
	<1182410926.5411.142.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1182410926.5411.142.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, David Brownell <dbrownell@users.sourceforge.net>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 21, 2007 at 03:28:46PM +0800, Zhang Rui wrote:
> On Thu, 2007-06-21 at 15:42 +0900, Mattia Dongili wrote:
> > On Wed, Jun 20, 2007 at 12:33:04PM -0400, Alan Stern wrote:
> > > On Wed, 20 Jun 2007, Mattia Dongili wrote:
> > > 
> > > > > Just as with Raphael, I suggest you build a kernel with 
> > > > > CONFIG_USB_DEBUG turned on and then post the dmesg log showing the USB 
> > > > > debugging messages during the suspend and immediate resume.  To reduce 
> > > > > the amount of clutter you might want to rmmod uhci-hcd before starting 
> > > > > the test.
> > > > 
> > > > here we go:
> > > > http://www.linux.it/~malattia/logs/dmesg-suspend-ehci-debug-log
> > > > 
> > > > and by the way:
> > > > 00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #1 (rev 02)
> > > > 00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #2 (rev 02)
> > > > 00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #3 (rev 02)
> > > > 00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #4 (rev 02)
> > > > 00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI Controller (rev 02)
> > > > 
> > > > with ehci only:
> > > > Bus 005 Device 007: ID 054c:0281 Sony Corp. 
> > > > Bus 005 Device 004: ID 05ca:1830 Ricoh Co., Ltd 
> > > > Bus 005 Device 001: ID 0000:0000  
> > > 
> > > The log shows suspicious behavior on the part of the Sony UMH-U09
> > > device, the first one in your ehci-only list above.  When it was
> > > suspended it apparently disconnected itself from the USB bus, thereby
> > > triggering a wakeup signal.  If at all possible, try unplugging the USB
> > > cable to that device and then see what happens when you suspend.
> > 
> > wow, spotted!
> > 
> > This device is an express card (SD/MMC reader). Do you have any
> > suggestion to make suspend work without any workarounds?
> > 
> > I mean, all of this started by enabling wakeup on the ehci controller
> > USB1	  S3	 disabled  pci:0000:00:1d.0
> > USB2	  S3	 disabled  pci:0000:00:1d.1
> > USB3	  S3	 disabled  pci:0000:00:1d.2
> > USB4	  S3	 disabled  pci:0000:00:1d.3
> > USB7	  S3	 enabled   pci:0000:00:1d.7
> > 
> > and this was triggered when trying to understand if enabling wakeup by
> > default on PCI devices was good or not (and the patch itself was
> > responsible or not for problems).
> > So, from my POV it's either not good or there has to be some way of
> > dealing with disconnecting devices on suspend.
> > 
> Without this patch, users need to manually override /proc/acpi/wakeup
> to enable the wakeup ability of a given device.
> With this patch applied, /sys/.../power/wakeup is used to enable/disable
> device's wakeup ability, while they are all enabled by default.
> 
> The change log of this patch is quite clear about this:
> http://marc.info/?l=linux-acpi&m=117580342513025&w=2

So is this the case of the "broken hardware of drivers" as stated in the
chagelog? also, which of the two, hw or driver?

> > Just to simplify, in this situation, if I had an usb mouse attached to
> > this usb controller and removed the mouse while suspended, would the
> > laptop wakeup?
> > If so that's not what I most probably want. :)
> > 
> > > You also ought to be able to prevent this immediate resume by disabling
> > > wakeup on the EHCI controller.  For example:
> > > 
> > > 	echo disable >/sys/bus/usb/devices/usb5/power/wakeup
> > > 	echo disable >/sys/bus/usb/devices/usb5/../power/wakeup
> > that doesn't seem to work very well (on -rc5 at least):
> > $ echo disable > /sys/bus/usb/devices/usb2/power/wakeup
> > echo: write error: invalid argument
> > 
> "$ echo disabled > /sys/bus/usb/devices/usb2/power/wakeup"
> should work. :)

oops, thanks that is working indeed :)

-- 
mattia
:wq!
