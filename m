From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: Make cpufreq_quick_get() safe to call.
Date: Sat, 12 Mar 2016 06:52:37 +0700
Message-ID: <20160311235237.GA27500@vireshk-mac-ubuntu>
References: <CAJZ5v0gDkVyHyQ-4YPV5SYz5ppbc+OT6xm-zaAVfMdponS4L8A@mail.gmail.com>
 <1457685787-6046-1-git-send-email-rcochran@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35920 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbcCKXwk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Mar 2016 18:52:40 -0500
Received: by mail-pf0-f175.google.com with SMTP id u190so64496973pfb.3
        for <linux-pm@vger.kernel.org>; Fri, 11 Mar 2016 15:52:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1457685787-6046-1-git-send-email-rcochran@linutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Richard Cochran <rcochran@linutronix.de>
Cc: linux-kernel@vger.kernel.org, rt@linutronix.de, Dirk Brandewie <dirk.brandewie@gmail.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org

On 11-03-16, 09:43, Richard Cochran wrote:
> The function, cpufreq_quick_get, accesses the global 'cpufreq_driver' and
> its fields without taking the associated lock, cpufreq_driver_lock.
> 
> Without the locking, nothing guarantees that 'cpufreq_driver' remains
> consistent during the call.  This patch fixes the issue by taking the lock
> before accessing the data structure.
> 
> Cc: Dirk Brandewie <dirk.brandewie@gmail.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Richard Cochran <rcochran@linutronix.de>
> ---
>  drivers/cpufreq/cpufreq.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
