From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/5] CPUFreq: ARM big LITTLE Fixes
Date: Thu, 02 May 2013 23:19:53 +0200
Message-ID: <5220775.R7TYxWOgo3@vostro.rjw.lan>
References: <cover.1367241503.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:55582 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752562Ab3EBVLf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 2 May 2013 17:11:35 -0400
In-Reply-To: <cover.1367241503.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, arvind.chauhan@arm.com, linux-arm-kernel@lists.infradead.org

On Monday, April 29, 2013 06:54:43 PM Viresh Kumar wrote:
> Hi Rafael,
> 
> I know I am late for this merge window and you have already closed the gates :)
> If you can still take them, its good, otherwise we will push this for v3.10-rc2.
> 
> These are minor fixes for ARM big LITTLE cpufreq driver. It doesn't impact any
> other driver or cpufreq core and are fairly independent.
> 
> Viresh Kumar (5):
>   cpufreq: ARM big LITTLE: Select PM_OPP
>   cpufreq: ARM big LITTLE DT: Return correct transition latency
>   cpufreq: ARM big LITTLE DT: Return CPUFREQ_ETERNAL if clock-latency
>     isn't found
>   cpufreq: ARM big LITTLE: Move cpu_to_cluster() to arm_big_little.h
>   cpufreq: ARM big LITTLE: Improve print message
> 
>  drivers/cpufreq/Kconfig.arm         | 1 +
>  drivers/cpufreq/arm_big_little.c    | 7 +------
>  drivers/cpufreq/arm_big_little.h    | 5 +++++
>  drivers/cpufreq/arm_big_little_dt.c | 9 +++++----
>  4 files changed, 12 insertions(+), 10 deletions(-)

All 5 queued up for the v3.10-rc2 push.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
