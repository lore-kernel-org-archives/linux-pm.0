From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: cpufreq_resume warning issue
Date: Mon, 21 Mar 2016 13:02:28 +0530
Message-ID: <20160321073228.GC1803@vireshk-i7>
References: <678F3D1BB717D949B966B68EAEB446ED0A6D8624@SZXEMA509-MBX.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35132 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752321AbcCUHcc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Mar 2016 03:32:32 -0400
Received: by mail-pf0-f170.google.com with SMTP id n5so255017794pfn.2
        for <linux-pm@vger.kernel.org>; Mon, 21 Mar 2016 00:32:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <678F3D1BB717D949B966B68EAEB446ED0A6D8624@SZXEMA509-MBX.china.huawei.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Zengtao (B)" <prime.zeng@hisilicon.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 21-03-16, 03:43, Zengtao (B) wrote:
> Hi all:
> 	I have got the warning in the following code, 
> 	/*
> 	 * schedule call cpufreq_update_policy() for first-online CPU, as that
> 	 * wouldn't be hotplugged-out on suspend. It will verify that the
> 	 * current freq is in sync with what we believe it to be.
> 	 */
> 	policy = cpufreq_cpu_get_raw(cpumask_first(cpu_online_mask));
> 	if (WARN_ON(!policy))
> 		return;
> 	schedule_work(&policy->update);
> 
> in my platform, two cores, core 1 don't have the dvfs feature, but core 2 has.
> So I think that is the warning reason.
> 
> My question:
> 1. Do we need to warning here? 

Yes. But your system just broke an assumption we always had. i.e. all the CPUs
take part in DVFS :)

And its not just about this piece of code, but everything else that cpufreq
does.

For example, cpufreq core must be calling ->init() callback for CPU0 as well..
What are you doing there ?

I am not sure what's the right way of handling this thing is going to be.

Why doesn't you have DVFS for both the cores ?

-- 
viresh
