From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [REGRESSION] usb devices don't wake up the system
Date: Tue, 6 Jul 2010 13:07:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1007061300580.1327-100000@iolanthe.rowland.org>
References: <1278435118.11623.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1278435118.11623.17.camel@localhost.localdomain>
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

> > I don't think so.  I tried essentially the same experiment, under 
> > vanilla 2.6.35-rc4:
> > 
> > $ cat /etc/udev/rules.d/80-local.rules 
> > ACTION=="add", ENV{DEVTYPE}=="usb_device", ENV{PRODUCT}=="45e/84/*", ATTR{power/wakeup}="enabled"
> > 
> > (045e and 0084 are the vendor and product IDs for my Microsoft USB 
> > optical mouse)
> > 
> > $ cat /sys/devices/pci0000:00/0000:00:1d.3/usb8/8-2/power/wakeup
> > enabled
> 
> Nope...
> 
> ACTION=="add", ENV{DEVTYPE}=="usb_device", ENV{PRODUCT}=="1241/1166/*", ATTR{power/wakeup}="enabled"
> 
> maxim@MAIN:~$ cat /sys/bus/usb/devices/5-1/power/wakeup 
> disabled
> 
> 
> 
> > 
> > So if the attribute ends up set to "disabled", it's probably because
> > some other program on your machine is changing it.  This isn't the
> > kernel's fault.
> It can't be.
> In older kernel the attribute is set to 'enabled' regardless of udev
> rule.
> Now it is set to disabled regardless of kernel rule.
> I don't think userspace is that rogue... :-)

This would be another good thing to bisect, assuming it really is
caused by something in the kernel.

> > > I am not against the default of disabled wakeup, it fact I welcome that, 
> > > but I think that udev rule should work to enable it back.
> > 
> > It does, on my system.  With that rule in place and after manually 
> > doing:
>                                                   ^^^
> You mean 'or' ?

I meant "and".  Both the controller and the mouse were enabled for 
wakeup when I ran the test.  I didn't try other combinations, but it 
would be surprising if they did anything.  If the mouse isn't enabled 
for wakeup then it won't send a wakeup request when you click a button, 
and if the controller isn't enabled for wakeup then it won't cause the 
system to resume when it receives a request.

> > # echo enabled >/sys/devices/pci0000:00/0000:00:1d.3/power/wakeup
> > 
> > the mouse does indeed cause the computer to wakeup from suspend.  (But 
> > as I mentioned before, it requires double-clicking.)
> This might be a feature, to avoid waking up the system by accident.

Could be.

Alan Stern
