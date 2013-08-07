From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 5/6] ARM: Tegra: start using cpufreq-cpu0 driver
Date: Wed, 7 Aug 2013 23:19:09 +0530
Message-ID: <CAKohpokOn4-RZE5mfoM+2p8jszWoGfOErrLShZmv86OgCMv+JA@mail.gmail.com>
References: <cover.1375886595.git.viresh.kumar@linaro.org>
	<6610c86618b781b00eba446ca19035e077d99691.1375886595.git.viresh.kumar@linaro.org>
	<520287EA.5060508@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35956 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932250Ab3HGRtK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 7 Aug 2013 13:49:10 -0400
Received: by mail-ob0-f174.google.com with SMTP id wd6so1776773obb.19
        for <linux-pm@vger.kernel.org>; Wed, 07 Aug 2013 10:49:09 -0700 (PDT)
In-Reply-To: <520287EA.5060508@wwwdotorg.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: rjw@sisk.pl, swarren@nvidia.com, linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org

On 7 August 2013 23:16, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 08/07/2013 08:46 AM, Viresh Kumar wrote:
>> cpufreq-cpu0 driver can be probed over DT only if a corresponding device node is
>> created for the SoC which wants to use it. Lets create a platform device for
>> cpufreq-cpu0 driver for Tegra.
>>
>> Also it removes the Kconfig entry responsible to compiling tegra-cpufreq driver
>> and hence there will not be any conflicts between two cpufreq drivers.
>
>> diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
>
>>  static void __init tegra_dt_init(void)
>>  {
>> +     struct platform_device_info devinfo = { .name = "cpufreq-cpu0", };
>
> static? const?

static: yes
const: no, as it might be modified by platform_device_register_full()

>>       struct soc_device_attribute *soc_dev_attr;
>>       struct soc_device *soc_dev;
>>       struct device *parent = NULL;
>>
>>       tegra_clocks_apply_init_table();
>> +     platform_device_register_full(&devinfo);
>
> This seems awfully like going back to board files. Shouldn't something
> that binds to the CPU nodes register the cpufreq device automatically,
> based on the CPU's compatible value?

This link has got some information why we can't have a node for cpufreq
or a compatibility value..

http://permalink.gmane.org/gmane.linux.kernel.cpufreq/9018
