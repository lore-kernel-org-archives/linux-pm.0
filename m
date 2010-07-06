From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [REGRESSION] usb devices don't wake up the system
Date: Tue, 06 Jul 2010 19:51:58 +0300
Message-ID: <1278435118.11623.17.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.1007061106450.1327-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1007061106450.1327-100000@iolanthe.rowland.org>
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
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2010-07-06 at 11:17 -0400, Alan Stern wrote:
> On Sun, 4 Jul 2010, Maxim Levitsky wrote:
> 
> > > > > I want to note that I still need to enable wakeup in /power/acpi/wakeup
> > > > > to make USB mouse wakeup the system.
> > > > > This isn't a regression, but I thought that I don't need that anymore.
> > > 
> > > You shouldn't.  Which setting in /proc/acpi/wakeup needs to be enabled?
> > 
> > The wakeup GPE for UHCI controller which is connected to the mouse.
> 
> I have no idea why you need that.  It's not necessary on my system:
> 
> $ cat /proc/acpi/wakeup 
> Device  S-state   Status   Sysfs node
> P0P4      S4     disabled  pci:0000:00:1e.0
> MC97      S4     disabled  
> USB1      S4     disabled  pci:0000:00:1d.0
> USB2      S4     disabled  pci:0000:00:1d.1
> USB3      S4     disabled  pci:0000:00:1d.2
> USB4      S4     disabled  pci:0000:00:1d.3
> EUSB      S4     disabled  pci:0000:00:1d.7
> PS2K      S4     enabled   pnp:00:09
> PS2M      S4     enabled   pnp:00:0a
> GBEN      S4     disabled  
> 
> > Also, I tried to enable wakeup on the USB mouse using udev rule.
> > 
> > I did that rule for a test (very broad for testing):
> > 
> > SUBSYSTEM=="usb", ACTION=="add", ATTR{power/wakeup}="enabled"
> > 
> > I found that running udevd --debug confirms that it writes that attribute 
> > (Log of mouse attach attached :-). (I connected  it to different port now)
> > 
> > According to the log, udev does write 'enabled' to
> > /sys/devices/pci0000:00/0000:00:1a.0/usb3/3-2/power/wakeup
> > 
> > but:
> > 
> > maxim@MAIN:~$ cat /sys/devices/pci0000:00/0000:00:1a.0/usb3/3-2/power/wakeup
> > disabled
> > 
> > 
> > This looks like kernel bug.
> 
> I don't think so.  I tried essentially the same experiment, under 
> vanilla 2.6.35-rc4:
> 
> $ cat /etc/udev/rules.d/80-local.rules 
> ACTION=="add", ENV{DEVTYPE}=="usb_device", ENV{PRODUCT}=="45e/84/*", ATTR{power/wakeup}="enabled"
> 
> (045e and 0084 are the vendor and product IDs for my Microsoft USB 
> optical mouse)
> 
> $ cat /sys/devices/pci0000:00/0000:00:1d.3/usb8/8-2/power/wakeup
> enabled

Nope...

ACTION=="add", ENV{DEVTYPE}=="usb_device", ENV{PRODUCT}=="1241/1166/*", ATTR{power/wakeup}="enabled"

maxim@MAIN:~$ cat /sys/bus/usb/devices/5-1/power/wakeup 
disabled



> 
> So if the attribute ends up set to "disabled", it's probably because
> some other program on your machine is changing it.  This isn't the
> kernel's fault.
It can't be.
In older kernel the attribute is set to 'enabled' regardless of udev
rule.
Now it is set to disabled regardless of kernel rule.
I don't think userspace is that rogue... :-)



> 
> > I am not against the default of disabled wakeup, it fact I welcome that, 
> > but I think that udev rule should work to enable it back.
> 
> It does, on my system.  With that rule in place and after manually 
> doing:
                                                  ^^^
You mean 'or' ?

> 
> # echo enabled >/sys/devices/pci0000:00/0000:00:1d.3/power/wakeup
> 
> the mouse does indeed cause the computer to wakeup from suspend.  (But 
> as I mentioned before, it requires double-clicking.)
This might be a feature, to avoid waking up the system by accident.

> 
> Alan Stern
> 

Best regard,
	Maxim Levitsky
