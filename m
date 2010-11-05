From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: HCD polling root hub status before controller is
 brought out of suspend
Date: Fri, 5 Nov 2010 09:56:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1011050942000.28439-100000@netrider.rowland.org>
References: <AANLkTikiwJ1F5deXS9yrtW9-7QbhNZX00svPWe-ihXM_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikiwJ1F5deXS9yrtW9-7QbhNZX00svPWe-ihXM_@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Maksim Rayskiy <maksim.rayskiy@gmail.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 4 Nov 2010, Maksim Rayskiy wrote:

> Hello,
> 
> I am running into a crash on 2.6.36-rc7 kernel when I am bringing ohci
> controller out of suspend. Our suspend gates the clocks, so any access to
> the ohci registers becomes a bus error.
> I tracked the crash down to hcd polling function running off the timer. And
> it happens _before_ pm core calls our ohci resume method.
> 
> #1  0x80310b84 in ohci_hub_status_data (hcd=<value optimized out>,
> buf=<value optimized out>)
>     at drivers/usb/host/ohci-hub.c:520
> #2  0x802f11a0 in usb_hcd_poll_rh_status (hcd=<value optimized out>) at
> drivers/usb/core/hcd.c:675
> #3  0x8003faec in call_timer_fn (h=<value optimized out>) at
> kernel/timer.c:1057
> #4  __run_timers (h=<value optimized out>) at kernel/timer.c:1118
> #5  run_timer_softirq (h=<value optimized out>) at kernel/timer.c:1297
> #6  0x80038ff0 in __do_softirq () at kernel/softirq.c:219
> #7  0x80039140 in do_softirq () at kernel/softirq.c:266
> #8  0x800392d8 in irq_exit () at kernel/softirq.c:303
> #9  0x8000c35c in plat_irq_dispatch (regs=<value optimized out>) at
> arch/mips/brcmstb/irq.c:423
> #10 0x80001784 in ret_from_exception () at arch/mips/kernel/entry.S:34
> 
> The simplest fix was to clear hcd->rh_pollable before going into suspend,

Drivers are not supposed to touch that flag.  It is for use only by 
usbcore.

> and restoring it after resume, but I am wondering if it is a known issue and
> there is a better solution to the problem.

This issue has not been reported before.  Why didn't the

	if (!HCD_HW_ACCESSIBLE(hcd))
		goto done;

statements at the start of ohci_hub_status_data() prevent the unwanted 
hardware accesses from occurring?

Admittedly, it might be a good idea to change this code to

	if (!HCD_HW_ACCESSIBLE(hcd)) {
		clear_bit(HCD_FLAG_POLL_RH, &hcd->flags);
		goto done;
	}

since there's no reason to continue polling if the hardware isn't 
accessible.

Alan Stern
