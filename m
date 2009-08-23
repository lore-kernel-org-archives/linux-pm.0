From: Wu Zhangjin <wuzhangjin@gmail.com>
Subject: Re: How to wakup system from standby via USB keyboard
Date: Sun, 23 Aug 2009 21:00:10 +0800
Message-ID: <1251032410.7203.83.camel@falcon>
References: <Pine.LNX.4.44L0.0908221005140.5241-100000@netrider.rowland.org>
Reply-To: wuzhangjin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0908221005140.5241-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sat, 2009-08-22 at 10:08 -0400, Alan Stern wrote:
> On Sat, 22 Aug 2009, Wu Zhangjin wrote:
> 
> > > I think the interface you're looking for is
> > > 
> > > 	/sys/bus/usb/devices/usbN/../power/wakeup
> > > 
> > > where N is the USB bus number.  This file defaults to "disabled"; if
> > > you write "enabled" to it then the USB host controller will be enabled
> > > as a wakeup source.  This should work even without ACPI; it uses the
> > > PCI PME mechanism.
> > > 
> > 
> > I checked the /sys/bus/usb.../wakeup interfaces, seems the
> > usbN/power/wakeup interfaces are enabled by default in my machine, but
> > the usbN/N-X:Y/power/wakeup is not available. so, I can not wakeup the
> > system via any USB devices.
> > 
> > Here is the output:
> > 
> > $ find /sys/bus/usb/devices/usb1/ -name "wakeup" -exec echo {} \; -exec
> > cat '{}' \;
> > /sys/bus/usb/devices/usb1/power/wakeup
> > enabled
> ...
> 
> You did not read what I wrote.
> 
> You shouldn't look at: /sys/bus/usb/devices/usb1/power/wakeup.  
> You should look at:    /sys/bus/usb/devices/usb1/../power/wakeup.
> 
> The N-X:Y/power/wakeup interfaces don't matter; the kernel doesn't 
> use them.
> 

Sorry, I at first thought .. is only an ellipsis, because the TAB key of
keyboard can not list the files(Seems only symbol links to pci/
directories) :-)

There is really a such file in system of FuLoong2F, but seems the USB
controller is 'not' a PCI one(sorry for my mistake in the last E-mail),
this USB interface is integrated in the CS5536 southbridge, and
CS5536(from AMD) is connected to the PCI bus.

the connection is like this:

----------------------------------------
|         Loongson2F                   |
|                                      |                 ------------- 
|     CPU internal northbridge         |                 |            |
|(bonito64 compatiable, PCI controller)| <----PCI BUS -->| AMD CS5536 |
---------------------------------------                  |(USB inside)|
                                                         --------------
$ cat /sys/bus/usb/devices/usb1/../power/wakeup
[empty here]

but in YeeLoong System, for there is a NEC USB controller connect to PCI
BUS directly.

----------------------------------------
|         Loongson2F                   |
|            |                         |                 ------------- 
|     CPU internal northbridge         |                 |            |
|(bonito64 compatiable, PCI controller)| <----PCI BUS -->| AMD CS5536 |
---------------------------------------      |           |(USB inside)|
                                             |            --------------
                                             ---- USB HC
and the wakeup interface is really there:

$ cat /sys/bus/usb/devices/usb1/../power/wakeup
disabled

but after I enabled it,

$ echo enabled > /sys/bus/usb/devices/usb1/../power/wakeup

and ensured the USB interrupt is not disabled in the northbridge, but
unfortunately, I can NOT wakeup YeeLoong from standby mode via the
keyboard or mouse connect to NEC USB interface :-(

BTW: I have tested this wakeup interface on two different X86 machines,
both of them can be waked up from a USB keyboard or Mouse.

perhaps I have missed something else.

Thanks & Regards,
Wu Zhangjin
