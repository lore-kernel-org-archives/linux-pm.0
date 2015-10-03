From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH 06/17] rtc: ds1343: remove misuse of IRQF_NO_SUSPEND flag
Date: Sat, 3 Oct 2015 17:20:51 +0200
Message-ID: <20151003152051.GC2694@piout.net>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
 <1442850433-5903-7-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:42694 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752368AbbJCPUx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 3 Oct 2015 11:20:53 -0400
Content-Disposition: inline
In-Reply-To: <1442850433-5903-7-git-send-email-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com

On 21/09/2015 at 16:47:02 +0100, Sudeep Holla wrote :
> The IRQF_NO_SUSPEND flag is used to identify the interrupts that should
> be left enabled so as to allow them to work as expected during the
> suspend-resume cycle, but doesn't guarantee that it will wake the system
> from a suspended state, enable_irq_wake is recommended to be used for
> the wakeup.
> 
> This patch removes the use of IRQF_NO_SUSPEND flags and uses newly
> introduce PM wakeup APIs dev_pm_{set,clear}_wake_irq.
> 
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: rtc-linux@googlegroups.com
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/rtc/rtc-ds1343.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
