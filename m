From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: cpufreq_resume warning issue
Date: Tue, 22 Mar 2016 16:02:04 +0530
Message-ID: <20160322103204.GG5272@vireshk-i7>
References: <678F3D1BB717D949B966B68EAEB446ED0A6D8624@SZXEMA509-MBX.china.huawei.com>
 <20160321073228.GC1803@vireshk-i7>
 <678F3D1BB717D949B966B68EAEB446ED0A6D96C7@SZXEMA509-MBX.china.huawei.com>
 <20160321083422.GE1803@vireshk-i7>
 <678F3D1BB717D949B966B68EAEB446ED0A6D9738@SZXEMA509-MBX.china.huawei.com>
 <20160321090920.GB27778@vireshk-i7>
 <678F3D1BB717D949B966B68EAEB446ED0A6D9756@SZXEMA509-MBX.china.huawei.com>
 <20160321094441.GC27778@vireshk-i7>
 <678F3D1BB717D949B966B68EAEB446ED0A6D9D5A@SZXEMA509-MBX.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35948 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822AbcCVKck (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Mar 2016 06:32:40 -0400
Received: by mail-pf0-f173.google.com with SMTP id u190so305780341pfb.3
        for <linux-pm@vger.kernel.org>; Tue, 22 Mar 2016 03:32:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <678F3D1BB717D949B966B68EAEB446ED0A6D9D5A@SZXEMA509-MBX.china.huawei.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Zengtao (B)" <prime.zeng@hisilicon.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 22-03-16, 09:58, Zengtao (B) wrote:
> Yes, but we are just cheating the kernel by doing so, the cpu frequency governor of CPU0 is fixed 
> even it has got the tunable interface to users. 

You are mixing policy and features here..

Feature wise, your platform has the capability of supporting dynamic-frequency
scaling for CPU0 (A7), but as a policy you don't see much advantage of doing
that today.

But things will change, and perhaps your customers would want to do things
differently to save small amounts of powers lately. They would be required to go
through the code then to make that happen.

That's why I said, Keep the feature in place and support dynamic-frequency
switching for CPU0 as well (Its not gonna consume much of your time, I am quite
sure), and let people deal with policy. They can choose performance/powersave or
ondemand later on. They would be required to touch few sysfs file only then.

Changing core for this would mean, that we go through each and every line of
cpufreq-core again, as its an assumption we always had. Its not impossible and
may be required to be done in future, but it has to be worth the effort.

In this case, you are trying to avoid a small amount of effort, as you don't see
much value in terms of saving power.

But believe me, its a new platform and things will change. All current platforms
that are supporting DVFS for A7s aren't idiots :)

-- 
viresh
