From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V11] Report interrupt that caused system wakeup
Date: Wed, 16 Sep 2015 04:40:04 +0200
Message-ID: <17197937.G4AcryW2hF@vostro.rjw.lan>
References: <1442338366-16911-1-git-send-email-alexandra.yates@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:45015 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751772AbbIPCMF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2015 22:12:05 -0400
In-Reply-To: <1442338366-16911-1-git-send-email-alexandra.yates@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alexandra Yates <alexandra.yates@linux.intel.com>
Cc: linux-pm@vger.kernel.org, tglx@linutronix.de, kristen.c.accardi@intel.com

On Tuesday, September 15, 2015 10:32:46 AM Alexandra Yates wrote:
> Add a sysfs attribute, /sys/power/pm_wakeup_irq, reporting the IRQ
> number of the first wakeup interrupt (that is, the first interrupt
> from an IRQ line armed for system wakeup) seen by the kernel during
> the most recent system suspend/resume cycle.
> 
> This feature will be useful for system wakeup diagnostics of
> spurious wakeup interrupts.
> 
> Signed-off-by: Alexandra Yates <alexandra.yates@linux.intel.com>

I've applied this, but I needed to fix it up due to build problems.

I'd rather not to that again for any of your future patches.

Thanks,
Rafael

