From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v6 0/4] Add Mediatek MT8173 cpufreq driver
Date: Thu, 9 Jul 2015 16:04:20 +0530
Message-ID: <20150709103420.GC5627@linux>
References: <1436437661-17606-1-git-send-email-pi-cheng.chen@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34489 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146AbbGIKeZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2015 06:34:25 -0400
Received: by pabvl15 with SMTP id vl15so148446016pab.1
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2015 03:34:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1436437661-17606-1-git-send-email-pi-cheng.chen@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-mediatek@lists.infradead.org

On 09-07-15, 18:27, Pi-Cheng Chen wrote:
> MT8173 is a ARMv8 based SoC with 2 clusters. All CPUs in a single cluster
> share the same power and clock domain. This series tries to add cpufreq support
> for MT8173 SoC.
> 
> changes in v6:
> - Move clock and regulator consumer properties document to the device tree
>   bindings documents of MT8173 CPU DVFS clock driver
> - Add change log to describe what is implemented in the MT8173 cpufreq driver
> - Add missed rcu_read_unlock() in the error path
> - Move of_init_opp_table() call to make sure all required hardware resources
>   are already there before it is called
> - Add comments to describe why both platform driver and deivce registration
>   codes are put in the initcall function
> - Use the term "voltage tracking" instead of "voltage trace" according to an
>   internal SoC document

I think Mike would again need to comment or Ack 1/4 as we have moved
the stuff to another file.

But for [1,3-4]:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks for your hardwork :)

-- 
viresh
