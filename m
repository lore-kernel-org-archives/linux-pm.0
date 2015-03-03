From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 5/5] thermal: cpu_cooling: update the cpu device when
 cpufreq updates the policy cpu
Date: Tue, 3 Mar 2015 20:59:18 +0530
Message-ID: <CAKohpokrxi2p0Ad3SZDjX90gk7HSgwHwNs5DTiYPZYUZMOTJSA@mail.gmail.com>
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
Received: from mail-oi0-f41.google.com ([209.85.218.41]:35787 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbbCCP3T (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2015 10:29:19 -0500
Received: by oifz81 with SMTP id z81so80828oif.2
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2015 07:29:19 -0800 (PST)
In-Reply-To: <54F5CEBC.1070303@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kapileshwar Singh <kapileshwar.singh@arm.com>
Cc: Javi Merino <Javi.Merino@arm.com>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Punit Agrawal <Punit.Agrawal@arm.com>, Lina Iyer <lina.iyer@linaro.org>, Mark Brown <broonie@kernel.org>, Jon Medhurst <tixy@linaro.org>

On 3 March 2015 at 20:39, Kapileshwar Singh <kapileshwar.singh@arm.com> wrote:

> I did test this but we were working with the assumption that OPPs should be populated for all the CPUs and also that OPPs are lost for a hotplugged CPU which I see is not the case.

Then what did you test? My point here is, even with the latest patches
that you have
sent, you wouldn't be able to get the OPPs once policy->cpu goes down. So, how
did this worked for you ?

> We have looked at this more closely and found that problem lies in:
>
>         freq = cpufreq_quick_get(cpumask_any(&cpufreq_device->allowed_cpus));
>
> which returns a NULL frequency as we are not checking for online CPUs here. We shall come up with a fix for this. Many thanks for helping us with the investigation.

Right.
