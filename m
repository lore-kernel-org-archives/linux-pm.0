From: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: mt8173: migrate to use operating-points-v2 bindings
Date: Mon, 7 Dec 2015 20:43:21 +0800
Message-ID: <CALx668XK_hriOqcKSqypT61XfMx50TjxRH5n038ju8CdCsTpUA@mail.gmail.com>
References: <1449305584-414-1-git-send-email-pi-cheng.chen@linaro.org>
	<1449305584-414-2-git-send-email-pi-cheng.chen@linaro.org>
	<20151207100427.GG3294@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:33085 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753450AbbLGMnV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2015 07:43:21 -0500
Received: by ykdv3 with SMTP id v3so192397234ykd.0
        for <linux-pm@vger.kernel.org>; Mon, 07 Dec 2015 04:43:21 -0800 (PST)
In-Reply-To: <20151207100427.GG3294@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Daniel Kurtz <djkurtz@chromium.org>, "moderated list:ARM/Mediatek SoC..." <linux-mediatek@lists.infradead.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Mon, Dec 7, 2015 at 6:04 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 05-12-15, 16:53, Pi-Cheng Chen wrote:
>> diff --git a/drivers/cpufreq/mt8173-cpufreq.c b/drivers/cpufreq/mt8173-cpufreq.c
>> index 257bcb9..17e9cad 100644
>> --- a/drivers/cpufreq/mt8173-cpufreq.c
>> +++ b/drivers/cpufreq/mt8173-cpufreq.c
>> @@ -344,6 +344,9 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
>>       unsigned long rate;
>>       int ret;
>>
>> +     /* Mark the first owner of this CPU DVFS domain information */
>> +     cpumask_set_cpu(cpu, &info->cpus);
>> +
>
> This is bad, sorry about that. Please update
> dev_pm_opp_of_get_sharing_cpus() to update this as well.

Hi Viresh,

Thanks for reviewing.
Will do it.

Pi-Cheng

>
> --
> viresh
