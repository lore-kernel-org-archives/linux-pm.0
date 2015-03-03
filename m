From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v3 5/5] thermal: cpu_cooling: update the cpu device when
 cpufreq updates the policy cpu
Date: Tue, 3 Mar 2015 15:26:57 +0000
Message-ID: <CAPKp9ubM2PSzHUcqM7f=0LC9P=b-r5hjgZmoi0nRrr+Gk2miuw@mail.gmail.com>
References: <1425316643-31991-1-git-send-email-javi.merino@arm.com>
	<1425316643-31991-6-git-send-email-javi.merino@arm.com>
	<CAOh2x=m9c-gOYcesgh+4oc9NucFdD1y0Mcit5gPwLxGFt__Lng@mail.gmail.com>
	<54F5941F.6030402@arm.com>
	<CAKohpon3sn_4aX7g+=LFdY-AgYrWdFCWtyethJtVMEK=Dw9Xbw@mail.gmail.com>
	<54F59DEF.3020700@arm.com>
	<CAKohponB3cNXT8p=SqrfpGEPjLpeE=tnzUVOiabV8hEfBMb8rQ@mail.gmail.com>
	<54F5CEBC.1070303@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:35072 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756394AbbCCP06 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2015 10:26:58 -0500
In-Reply-To: <54F5CEBC.1070303@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kapileshwar Singh <kapileshwar.singh@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Javi Merino <Javi.Merino@arm.com>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Punit Agrawal <Punit.Agrawal@arm.com>, Lina Iyer <lina.iyer@linaro.org>, Mark Brown <broonie@kernel.org>, Jon Medhurst <tixy@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>

On Tue, Mar 3, 2015 at 3:09 PM, Kapileshwar Singh
<kapileshwar.singh@arm.com> wrote:
> On 03/03/15 13:07, Viresh Kumar wrote:

[...]

>> Please goto the depth of this thing, as I don't think it should happen.
>>
>> Over that I was asking you if you have tested the solution Javi gave,
>> because OPPs
>> wouldn't have been initialized for other CPUs once policy->cpu goes down.
> I did test this but we were working with the assumption that OPPs should be populated for all the CPUs and also that OPPs are lost for a hotplugged CPU which I see is not the case.
>
> We have looked at this more closely and found that problem lies in:
>
>         freq = cpufreq_quick_get(cpumask_any(&cpufreq_device->allowed_cpus));
>
> which returns a NULL frequency as we are not checking for online CPUs here. We shall come up with a fix for this. Many thanks for helping us with the investigation.
>

You can use any_online_cpu(..) instead of cpumask_any IMO

Regards,
Sudeep
