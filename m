From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V4] Report interrupt(s) that caused system wakeup
Date: Sat, 18 Jul 2015 00:24:39 +0200
Message-ID: <119770186.psRuv6BNVl@vostro.rjw.lan>
References: <1434589721-15018-1-git-send-email-alexandra.yates@linux.intel.com> <1434589721-15018-2-git-send-email-alexandra.yates@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53696 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752115AbbGQV56 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jul 2015 17:57:58 -0400
In-Reply-To: <1434589721-15018-2-git-send-email-alexandra.yates@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alexandra Yates <alexandra.yates@linux.intel.com>
Cc: tglx@linutronix.de, kristen.c.accardi@intel.com, linux-pm@vger.kernel.org, peterz@infradead.org

Hi Alex,

On Wednesday, June 17, 2015 06:08:41 PM Alexandra Yates wrote:
> Add a new IRQ flag named IRQD_WAKEUP_TRIGGERED.  This flag is set
> when a given IRQ fires after it has been armed for system wakeup.
> The flag is cleared before arming the IRQ for system wakeup
> during the next system suspend. This feature makes possible to
> check which IRQs might have woken the system up from sleep last
> time it was suspended.
> 
> Add a new sysfs attribute under /sys/power/ named:pm_last_wakeup_irqs
> when read, will return a list of IRQs with the new flag set.  That
> will be useful for system wakeup diagnostics.
> 
> Signed-off-by: Alexandra Yates <alexandra.yates@linux.intel.com>

Can you please rebase the patch on top of 4.2-rc2 and resend it?

Also please move the definition of irqd_triggered_wakeup() after
irqd_is_wakeup_armed() (perhaps rename irqd_triggered_wakeup() to
irqd_irq_triggered_wakeup() to follow the convention there) and
use __irqd_to_state() in it.

Thanks,
Rafael

