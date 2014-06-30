From: Thomas Abraham <ta.omasab@gmail.com>
Subject: Re: [PATCH] cpufreq: arm_big_little: set lowest frequcency for
 cluster when no cpus in it
Date: Mon, 30 Jun 2014 14:02:14 +0530
Message-ID: <CAJuA9agDU1-wLHW4yH+2u2EB51SCCbyN+SSshZ271SBK-D=iBA@mail.gmail.com>
References: <1403795313-6903-1-git-send-email-thomas.ab@samsung.com>
	<CAKohpomv=0y30q09fuuRDOGQ_XtuKnerC830vFExNok9mAcyfw@mail.gmail.com>
	<53AC42CE.2050304@arm.com>
	<CAJuA9agJb4xx--ujc3=efeFNFLiw4o87nOig8u-X+kY0wj99dA@mail.gmail.com>
	<53AC6D31.7010709@arm.com>
	<CAJuA9ajOAhZAzwJEsP9bU83n=n30pgawy-otGU4t=d3ADVKOwg@mail.gmail.com>
	<CAKohponCoTuoYaLFWzOhZm2XVYjkS2VUsePuso8othxAVsgsyw@mail.gmail.com>
	<alpine.LFD.2.11.1406272202220.16842@knanqh.ubzr>
	<CAKohpomLQcfp5OD1QB5m6JTSJPT_JF+mb=mEtGbG4RQb6gsovA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:39948 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754196AbaF3IcQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Jun 2014 04:32:16 -0400
Received: by mail-lb0-f171.google.com with SMTP id s7so5610367lbd.2
        for <linux-pm@vger.kernel.org>; Mon, 30 Jun 2014 01:32:14 -0700 (PDT)
In-Reply-To: <CAKohpomLQcfp5OD1QB5m6JTSJPT_JF+mb=mEtGbG4RQb6gsovA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>

On Mon, Jun 30, 2014 at 10:22 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 28 June 2014 07:42, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
>> If reducing the frequency of the cluster going down saves power, then it
>> should be done _all_ the time i.e. when using CPU hotplug, when cpuidle
>> sends all CPUs to sleep, etc.  So this has nothing to do with the
>> switcher even if the switcher would also benefit from this.
>>
>> In other words, this should be performed by the MCPM backend as part of
>> the last man operations. This way it is generic and completely
>> transparent to the rest of the system.
>>
>> To restore the CPU frequency that was effective before going down, you
>> may use the MCPM powered_up method.
>
> Oh yes, this is exactly what we want then..
>
> But do we want this forced for every platform? Or can we have some flag
> set by multi-cluster platforms, so that it stays optional ?

Thanks Nicolas and Viresh for your feedback. Probably, this can be
handled in platform specific mcpm backend driver.
