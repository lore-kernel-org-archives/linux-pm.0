From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: arm_big_little: remove compile-time dependency
 on BL_SWITCHER
Date: Tue, 12 May 2015 12:57:54 +0530
Message-ID: <20150512072754.GF32300@linux>
References: <1431343473-9915-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35469 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752790AbbELH16 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2015 03:27:58 -0400
Received: by pabtp1 with SMTP id tp1so137154720pab.2
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2015 00:27:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1431343473-9915-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Medhurst <tixy@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 11-05-15, 12:24, Sudeep Holla wrote:
> With the addition of switcher code, there's compile-time dependency on
> BL_SWITCHER to get arm_big_little driver compiling on ARM64. Since ARM64

The Kconfig dependency isn't on the switcher but big.LITTLE, which
isn't defined for arm64. So, we need a bit of clarity here.

> @@ -562,8 +580,7 @@ int bL_cpufreq_register(struct cpufreq_arm_bL_ops *ops)
> 
>  	arm_bL_ops = ops;
> 
> -	ret = bL_switcher_get_enabled();
> -	set_switching_enabled(ret);
> +	set_switching_enabled(bL_switcher_get_enabled());

This change wasn't required.
