From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: acpi_cpufreq: base frequency attribute support
Date: Mon, 29 Feb 2016 08:46:01 +0530
Message-ID: <20160229031601.GI5823@vireshk-i7>
References: <20151007172343.GE4557@linux>
 <4807388.hTIoZIhGRk@vostro.rjw.lan>
 <20151016054226.GQ19018@linux>
 <1456344052.8680.208.camel@linux.intel.com>
 <CAJZ5v0hh20C3vgWfBpRmR+oOjOf7kqP6HMLKjqzYx8h0ka_dVQ@mail.gmail.com>
 <1456357073.3860.21.camel@linux.intel.com>
 <20160225032700.GA2822@vireshk-i7>
 <1456423672.17628.9.camel@linux.intel.com>
 <20160226015718.GA2639@vireshk-i7>
 <1456518098.17628.92.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35010 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753610AbcB2DQI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 28 Feb 2016 22:16:08 -0500
Received: by mail-pa0-f47.google.com with SMTP id bj10so14393795pad.2
        for <linux-pm@vger.kernel.org>; Sun, 28 Feb 2016 19:16:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1456518098.17628.92.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 26-02-16, 12:21, Srinivas Pandruvada wrote:
> We are setting a cpufreq global variable in cpufreq_driver->attr with
> this for each cpu. This feature can be absent in certain cpus. So
> unlike boost it is not system wide, so I have to reset the attr to NULL
> for some cpus.

Ahh, I see..

What about always creating this file in sysfs, but allowing read/write only if
it is applicable to a CPU.

> Can we assume that cpufreq_driver->init(policy) calls are always
> serialized from cpu online/offline and subsys_interface callback path?

It is called from these paths but only on poilcy creation. So, if you are going
to have a single CPU for each policy, then yes.

-- 
viresh
