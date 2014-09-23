From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [RFC PATCH 2/5] devfreq: event: Add exynos-ppmu devfreq evnet
 driver
Date: Tue, 23 Sep 2014 11:11:26 +0900
Message-ID: <5420D6CE.7050606@samsung.com>
References: <1409891419-28560-1-git-send-email-cw00.choi@samsung.com>
 <1409891419-28560-3-git-send-email-cw00.choi@samsung.com>
 <1410511274.31130.7.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:29369 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755742AbaIWCLa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Sep 2014 22:11:30 -0400
In-reply-to: <1410511274.31130.7.camel@x220>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: myungjoo.ham@samsung.com, linux-pm@vger.kernel.org, kyungmin.park@samsung.com, rafael.j.wysocki@intel.com, a.kesavan@samsung.com, kgene.kim@samsung.com, tomasz.figa@gmail.com, b.zolnierkie@samsung.com, nm@ti.com, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Paul,

On 09/12/2014 05:41 PM, Paul Bolle wrote:
> On Fri, 2014-09-05 at 13:30 +0900, Chanwoo Choi wrote:
>> This patch add exynos-ppmu devfreq event driver to provider raw data about
>> the utilization of each IP in Exynos SoC series.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  drivers/devfreq/Kconfig             |  10 +
>>  drivers/devfreq/event/Makefile      |   1 +
>>  drivers/devfreq/event/exynos-ppmu.c | 410 ++++++++++++++++++++++++++++++++++++
>>  3 files changed, 421 insertions(+)
>>  create mode 100644 drivers/devfreq/event/exynos-ppmu.c
>>
>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
>> index ef839e7..4fbbcea 100644
>> --- a/drivers/devfreq/Kconfig
>> +++ b/drivers/devfreq/Kconfig
>> @@ -90,4 +90,14 @@ config ARM_EXYNOS5_BUS_DEVFREQ
>>  
>>  comment "DEVFREQ Event Drivers"
>>  
>> +config DEVFREQ_EVENT_EXYNOS_PPMU
>> +	bool "EXYNOS PPMU (Performance Profiling Monitoring Unit) DEVFREQ event Driver"
>> +	depends on ARCH_EXYNOS
>> +	select ARCH_HAS_OPP
> 
> This select statement can be dropped: see commit 78c5e0bb145d ("PM /
> OPP: Remove ARCH_HAS_OPP").

I'll drop it. 

> 
> By the way: there's a typo in the commit summary ("evnet").

My mistake, I'll fix typo.

Thanks for your review.
Chanwoo Choi

> 
>> +	select PM_OPP
>> +	help
>> +	 This add the DEVFREQ event driver for Exynos SoC. It provides PPMU
>> +	 (Performance Profiling Monitoring Unit) counters to estimate the
>> +	 utilization of each module.
>> +
>>  endif # PM_DEVFREQ
> 
> 
> Paul Bolle
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

