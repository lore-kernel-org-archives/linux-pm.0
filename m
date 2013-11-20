From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Subject: IRQF_RESUME_EARLY and errors in dpm_suspend_noirq
Date: Wed, 20 Nov 2013 10:20:07 +0100
Message-ID: <201311201020.08158.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:54598 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750858Ab3KTJUZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 20 Nov 2013 04:20:25 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ian Campbell <ian.campbell@citrix.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Thomas Gleixner <tglx@linutronix.de>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Hi,

Commit 9bab0b7fbace (genirq: Add IRQF_RESUME_EARLY and resume such IRQs
earlier) split the suspend/resume of the irqs into two parts.

The early-irqs get resumed during syscore_resume, while the rest get
resumed by the regular resume_device_irqs.

I may be blind, but where get the early-irqs resumed in the error
path of dpm_suspend_noirq?

When a suspend_noirq callback returns an error, dpm_resume_noirq gets called,
which only calls resume_device_irqs while the suspend_device_irqs call in
dpm_suspend_noirq suspends all irqs. So it does not seem that the early-irqs
get resumed at all in this case.


Thanks
Heiko
