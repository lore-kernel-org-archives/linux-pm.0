From: Rob Herring <robherring2@gmail.com>
Subject: Re: omap cpufreq driver in multi-platform kernels
Date: Wed, 27 Mar 2013 11:38:18 -0500
Message-ID: <5153207A.4050109@gmail.com>
References: <5152503C.2050503@gmail.com> <alpine.DEB.2.00.1303270212110.8161@utopia.booyaka.com> <20130327133220.GA30868@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:57754 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752613Ab3C0QiV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Mar 2013 12:38:21 -0400
Received: by mail-ob0-f171.google.com with SMTP id x4so8365144obh.30
        for <linux-pm@vger.kernel.org>; Wed, 27 Mar 2013 09:38:21 -0700 (PDT)
In-Reply-To: <20130327133220.GA30868@kahuna>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Shawn Guo <shawn.guo@linaro.org>, linux-pm@vger.kernel.org, Mark Langsdorf <mark.langsdorf@calxeda.com>

On 03/27/2013 08:32 AM, Nishanth Menon wrote:
> On 02:23-20130327, Paul Walmsley wrote:
>> Hi
>>
>> On Tue, 26 Mar 2013, Rob Herring wrote:
>>
>>> The omap cpufreq driver causes problems in multi-platform kernels
>>> because it unconditionally registers with the cpufreq core and does not
>>> check sufficiently that it is running on an omap platform. So on a
>>> kernel with highbank and omap drivers booted on highbank, the
>>> cpufreq-cpu0 driver fails to init. Any suggestions for how to fix? For
>>> DT this could just be several of_machine_is_compatible checks, but I'm
>>> not really sure for non-DT. Converting the driver to a platform driver
>>> would be another option.
>>
>> We could move the
>>
>> 	mpu_clk = clk_get(NULL, "cpufreq_ck");
>>
>> down to omap_cpufreq_init(), and bail out early if the clock alias doesn't 
>> exist.  (Presumably we'd also want to change the clock role name if we did 
>> that, to something like "omap_cpufreq_ck".)
>>
>> Experimental patch follows, comments welcome.
> We should deprecate usage on omap-cpufreq driver eventually, instead go
> towards embracing the SoC generic implementation of cpufreq-cpu0 driver
> IMHO.
> http://marc.info/?l=linux-omap&m=136371580826031&w=2
> is the series to support cpufreq_cpu0 driver in DT based boot.
> Would you think this approach is sane? 

That only solves the problem for DT, but not non-DT. My understanding is
non-DT omap platforms will be around for some time.

Rob

>>
>>
>> - Paul
>>
>> From c1b4374d9cdcf59e0cbe93aa5a23335cb3e60798 Mon Sep 17 00:00:00 2001
>> From: Paul Walmsley <paul@pwsan.com>
>> Date: Tue, 26 Mar 2013 20:16:39 -0600
>> Subject: [PATCH] EXPERIMENTAL: cpufreq: avoid loading the OMAP driver on
>>  non-OMAP multiplatform targets
>>
>> etc. etc.
>> ---
>>  arch/arm/mach-omap2/cclock2420_data.c |    2 +-
>>  arch/arm/mach-omap2/cclock2430_data.c |    2 +-
>>  arch/arm/mach-omap2/cclock3xxx_data.c |    2 +-
>>  arch/arm/mach-omap2/cclock44xx_data.c |    2 +-
>>  drivers/cpufreq/omap-cpufreq.c        |    8 ++++----
>>  5 files changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/cclock2420_data.c b/arch/arm/mach-omap2/cclock2420_data.c
>> index 0f0a97c..d4316e9 100644
>> --- a/arch/arm/mach-omap2/cclock2420_data.c
>> +++ b/arch/arm/mach-omap2/cclock2420_data.c
>> @@ -1885,7 +1885,7 @@ static struct omap_clk omap2420_clks[] = {
>>  	CLK(NULL,	"timer_32k_ck",	&func_32k_ck,	CK_242X),
>>  	CLK(NULL,	"timer_sys_ck",	&sys_ck,	CK_242X),
>>  	CLK(NULL,	"timer_ext_ck",	&alt_ck,	CK_242X),
>> -	CLK(NULL,	"cpufreq_ck",	&virt_prcm_set,	CK_242X),
>> +	CLK(NULL,	"omap_cpufreq_ck",	&virt_prcm_set,	CK_242X),
>>  };
>>  
>>  
>> diff --git a/arch/arm/mach-omap2/cclock2430_data.c b/arch/arm/mach-omap2/cclock2430_data.c
>> index aed8f74..7c855b9 100644
>> --- a/arch/arm/mach-omap2/cclock2430_data.c
>> +++ b/arch/arm/mach-omap2/cclock2430_data.c
>> @@ -2001,7 +2001,7 @@ static struct omap_clk omap2430_clks[] = {
>>  	CLK(NULL,	"timer_32k_ck",  &func_32k_ck,   CK_243X),
>>  	CLK(NULL,	"timer_sys_ck",	&sys_ck,	CK_243X),
>>  	CLK(NULL,	"timer_ext_ck",	&alt_ck,	CK_243X),
>> -	CLK(NULL,	"cpufreq_ck",	&virt_prcm_set,	CK_243X),
>> +	CLK(NULL,	"omap_cpufreq_ck",	&virt_prcm_set,	CK_243X),
>>  };
>>  
>>  static const char *enable_init_clks[] = {
>> diff --git a/arch/arm/mach-omap2/cclock3xxx_data.c b/arch/arm/mach-omap2/cclock3xxx_data.c
>> index 4579c3c..17dd82c 100644
>> --- a/arch/arm/mach-omap2/cclock3xxx_data.c
>> +++ b/arch/arm/mach-omap2/cclock3xxx_data.c
>> @@ -3501,7 +3501,7 @@ static struct omap_clk omap3xxx_clks[] = {
>>  	CLK(NULL,	"uart4_ick",	&uart4_ick_am35xx,	CK_AM35XX),
>>  	CLK(NULL,	"timer_32k_ck",	&omap_32k_fck,  CK_3XXX),
>>  	CLK(NULL,	"timer_sys_ck",	&sys_ck,	CK_3XXX),
>> -	CLK(NULL,	"cpufreq_ck",	&dpll1_ck,	CK_3XXX),
>> +	CLK(NULL,	"omap_cpufreq_ck",	&dpll1_ck,	CK_3XXX),
>>  };
>>  
>>  static const char *enable_init_clks[] = {
>> diff --git a/arch/arm/mach-omap2/cclock44xx_data.c b/arch/arm/mach-omap2/cclock44xx_data.c
>> index 3d58f33..66b85e5 100644
>> --- a/arch/arm/mach-omap2/cclock44xx_data.c
>> +++ b/arch/arm/mach-omap2/cclock44xx_data.c
>> @@ -1660,7 +1660,7 @@ static struct omap_clk omap44xx_clks[] = {
>>  	CLK("4013a000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
>>  	CLK("4013c000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
>>  	CLK("4013e000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
>> -	CLK(NULL,	"cpufreq_ck",	&dpll_mpu_ck,	CK_443X),
>> +	CLK(NULL,	"omap_cpufreq_ck",	&dpll_mpu_ck,	CK_443X),
>>  };
>>  
>>  int __init omap4xxx_clk_init(void)
>> diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
>> index 9128c07..d46caa5 100644
>> --- a/drivers/cpufreq/omap-cpufreq.c
>> +++ b/drivers/cpufreq/omap-cpufreq.c
>> @@ -175,10 +175,6 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
>>  {
>>  	int result = 0;
>>  
>> -	mpu_clk = clk_get(NULL, "cpufreq_ck");
>> -	if (IS_ERR(mpu_clk))
>> -		return PTR_ERR(mpu_clk);
>> -
>>  	if (policy->cpu >= NR_CPUS) {
>>  		result = -EINVAL;
>>  		goto fail_ck;
>> @@ -254,6 +250,10 @@ static struct cpufreq_driver omap_driver = {
>>  
>>  static int __init omap_cpufreq_init(void)
>>  {
>> +	mpu_clk = clk_get(NULL, "omap_cpufreq_ck");
>> +	if (IS_ERR(mpu_clk))
>> +		return PTR_ERR(mpu_clk);
>> +
>>  	mpu_dev = get_cpu_device(0);
>>  	if (!mpu_dev) {
>>  		pr_warning("%s: unable to get the mpu device\n", __func__);
>> -- 
>> 1.7.10.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

