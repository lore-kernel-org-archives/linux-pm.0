From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: How to wakup system from standby via USB keyboard
Date: Sat, 22 Aug 2009 00:06:10 +0200
Message-ID: <200908220006.10863.rjw@sisk.pl>
References: <1250862449.29439.85.camel@falcon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1250862449.29439.85.camel@falcon>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: wuzhangjin@gmail.com
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Friday 21 August 2009, Wu Zhangjin wrote:
> Hi All,
> 
> After reading some documents in Documentation/ and the Internet, I found
> there is an interface /proc/acpi/wakeup to set the wakeup devices on
> machines support ACPI. but my machine does not support ACPI,
> no /proc/acpi/wakeup there.
> 
> my machine is FuLoong2F, which is loongson based machine, it does not
> support ACPI, but currently, I have made it support basic standby mode
> for it has a 'wait' mode(after setting it's frequency to ZERO) and can
> be waked up via an external interrupt. and here is the basic framework:
> 
> 0. suspend:
> 
> arch_suspend_disable_irqs(disable all interrupts)
> 
> ...
> 
> fuloong_pm_enter()
> 
> ...
> 
> arch_suspend_enable_irqs(enable all interrupts)
> 
> 1. fuloong_pm_enter:
> 
> setup_wakeup_interrupts()
> 
> loongson_pm_enter(put loongson into 'wait' mode)
> 
> 3. setup_wakeup_interrupts
> 
> if the interrupt line is connected to loongson directly, no setup need
> to do, but if there is an interrupt line connected to loongson
> indirectly(i.e via i8259A), I need to get through the interrupt path via
> enable(un-mask) the interrupts in interrupt controller and resuming the
> devices earlier manually or enable the interrupt bit on the devices and
> even or set a flag of the device driver to tell the system not suspend
> this device.
> 
> I have tried the first(resuming earlier) and second method(enable the
> interrupt bit) on the 8042 keyboard o YeeLoong(another loongson-based
> machine, a netbook, i8042 is connected to i8259A directly), it works
> well, but not tried the third method yet.
> 
> I guess the /proc/acpi/wakeup based method in user-space should be
> something like this, but is there any relative method in kernel space?
> 
> there are only USB interfaces on FuLoong2F machines, I guess it will be
> very hard to get through the interrupt path via the above two methods(I
> have tried to enable the USB interrupt in south bright, but not work),
> so, is there an easier method to do it?

Is your USB controller a PCI one?

Rafael
