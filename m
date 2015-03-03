From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 5/5] thermal: cpu_cooling: update the cpu device when
 cpufreq updates the policy cpu
Date: Tue, 3 Mar 2015 16:49:25 +0530
Message-ID: <CAKohpon3sn_4aX7g+=LFdY-AgYrWdFCWtyethJtVMEK=Dw9Xbw@mail.gmail.com>
References: <1425316643-31991-1-git-send-email-javi.merino@arm.com>
	<1425316643-31991-6-git-send-email-javi.merino@arm.com>
	<CAOh2x=m9c-gOYcesgh+4oc9NucFdD1y0Mcit5gPwLxGFt__Lng@mail.gmail.com>
	<54F5941F.6030402@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:46933 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754021AbbCCLT0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2015 06:19:26 -0500
Received: by igbhl2 with SMTP id hl2so25957071igb.5
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2015 03:19:25 -0800 (PST)
In-Reply-To: <54F5941F.6030402@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kapileshwar Singh <kapileshwar.singh@arm.com>
Cc: Javi Merino <Javi.Merino@arm.com>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Punit Agrawal <Punit.Agrawal@arm.com>, Lina Iyer <lina.iyer@linaro.org>, Mark Brown <broonie@kernel.org>, Jon Medhurst <tixy@linaro.org>

On 3 March 2015 at 16:29, Kapileshwar Singh <kapileshwar.singh@arm.com> wrote:
> We store the device pointer of the lead CPU (policy CPU) in a cpufreq domain as a part of the
> cpufreq_cooling_device data structure. There is one cpufreq_cooling_device per
> cpufreq domain.
>
> We need the device to find out the current OPP for the cpufreq_cooling_device for our static power calculation.
>
>         opp = opp_find_freq_exact(cpu_dev, freq_hz, true);
>         voltage = dev_pm_opp_get_voltage(opp);
>
>
> The problem we are trying to solve here is:
>
> When this lead CPU gets hotplugged out, the device pointer becomes stale and the policy
> cpu for the cpufreq domain changes. We then store the new policy CPU's device pointer for the
> in cpufreq_cooling_device on the reception of a notification from cpufreq. Being open to your
> suggestions for any other possible ways to solve the problem..

I would have loved that if life was that simple :)

So, the OPP library today isn't that perfect and so is this doing rounds [1].
The problem is the OPPs are initialized per device today and even if they
are shared by multiple CPUs, OPP library doesn't know about it.

So, if the policy->cpu goes away, OPP APIs on the new CPU will not work
as OPPs are only initialized for one CPU and not for others within the same
policy :)

The way cpufreq-dt is taking care of this is by saving cpu_dev of the first
CPU for which OPPs are initialized and always using that even if the CPU
goes away. And you need to do exactly that.

And please, do test such scenario before sending the patches again. As
it would have simply failed in this case, have you given it a try ..

Once my patchset [1] is applied, life would be very simple and we can
call OPP library for any CPU, but that is going to take some time.

--
viresh

[1] https://www.marc.info/?l=linaro-kernel&m=142364262800650&w=3
