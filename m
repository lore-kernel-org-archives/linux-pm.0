From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 5/5] thermal: cpu_cooling: update the cpu device when
 cpufreq updates the policy cpu
Date: Tue, 3 Mar 2015 18:37:21 +0530
Message-ID: <CAKohponB3cNXT8p=SqrfpGEPjLpeE=tnzUVOiabV8hEfBMb8rQ@mail.gmail.com>
References: <1425316643-31991-1-git-send-email-javi.merino@arm.com>
	<1425316643-31991-6-git-send-email-javi.merino@arm.com>
	<CAOh2x=m9c-gOYcesgh+4oc9NucFdD1y0Mcit5gPwLxGFt__Lng@mail.gmail.com>
	<54F5941F.6030402@arm.com>
	<CAKohpon3sn_4aX7g+=LFdY-AgYrWdFCWtyethJtVMEK=Dw9Xbw@mail.gmail.com>
	<54F59DEF.3020700@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:34980 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263AbbCCNHW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2015 08:07:22 -0500
Received: by iecrl12 with SMTP id rl12so57550708iec.2
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2015 05:07:21 -0800 (PST)
In-Reply-To: <54F59DEF.3020700@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kapileshwar Singh <kapileshwar.singh@arm.com>
Cc: Javi Merino <Javi.Merino@arm.com>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Punit Agrawal <Punit.Agrawal@arm.com>, Lina Iyer <lina.iyer@linaro.org>, Mark Brown <broonie@kernel.org>, Jon Medhurst <tixy@linaro.org>

On 3 March 2015 at 17:11, Kapileshwar Singh <kapileshwar.singh@arm.com> wrote:
> Yes I indeed tested the case where we cache the device pointer of the CPU for which the OPP's are populated.
> When this CPU is hotplugged out, it invalidates the device pointer itself. Here are the error we get in dmesg:

What do you mean by 'invalidates the device pointer' ? that cpu_dev is NULL ?

> <3>[67203.216774] opp_get_voltage: Invalid parameters
> <3>[67203.326774] opp_get_voltage: Invalid parameters
> <3>[67203.326774] opp_get_voltage: Invalid parameters

Have you handwritten them ? Why don't they precede with dev_pm_* ??

>
> Which happens because:
>
> unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
> {
> ..
>         tmp_opp = rcu_dereference(opp);
>         if (unlikely(IS_ERR_OR_NULL(tmp_opp)) || !tmp_opp->available)
>                 pr_err("%s: Invalid parameters\n", __func__);

This %s should print routine name ..

>         else
> ..
>
> Which happens when
>
>         opp = dev_pm_opp_find_freq_exact(cpufreq_device->cpu_dev, freq_hz,
>                                          true);
>
> returns a an erroneous or NULL OPP or the opp is unavailable (in the above condition)

Please goto the depth of this thing, as I don't think it should happen.

Over that I was asking you if you have tested the solution Javi gave,
because OPPs
wouldn't have been initialized for other CPUs once policy->cpu goes down.
