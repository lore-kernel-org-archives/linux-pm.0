From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: PM: knowing the system state in the device callback
Date: Mon, 16 Mar 2015 20:52:45 +0100
Message-ID: <20150316205245.1b66bbea@bbrezillon>
References: <20150316191742.GI4560@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:36915 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932234AbbCPTxB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Mar 2015 15:53:01 -0400
In-Reply-To: <20150316191742.GI4560@piout.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Alexandre,

On Mon, 16 Mar 2015 20:17:42 +0100
Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> Hi,
> 
> I'm trying to get rid of at91_suspend_entering_slow_clock() which is
> exposing the platform suspend_state_t to the devices. From what I
> understand, whenever suspend_state_t is PM_SUSPEND_MEM or
> PM_SUSPEND_STANDBY, the pm_message_t passed to the device driver is
> always PM_EVENT_SUSPEND.
> 
> The requirement is to know whether we are going to cut the master clock
> and in that case, avoid calling enable_irq_wake() because we will not be
> able to wakeup from the device.

Actually the master clock is never switched off, we're only changing
its source (from PLLA to slow clk) which in turn changes its rate.

> 
> Is there a better way to do that? Or should I implement a similar
> function in the pm core (which I guess would already be there if
> really needed)?

IMHO we should let devices (RTC/RTT, debug UART, GPIOC, ...) mark their
interrupt line as a wakeup interrupt, and adapt the device
configuration (UART baudrate, ...) according to the new master clock
rate instead of testing the suspend mode to check whether we can mark
irq lines as wakeup sources or not.
The fact that we're disabling PLLA is not really related to
suspend-to-ram mode (we could leave the master clock unchanged and
still put the SDRAM chip in self-refresh mode).

The problem here is that we need some kind of notifier infrastructure
that would be called before the master clock source is switched to slow
clock. This notifier must be written in asm so that it can be called
from the asm code executed from SRAM (the SDRAM chip is placed in self
refresh before switching to slow clock).

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
