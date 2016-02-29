From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] cpufreq: acpi_cpufreq: base frequency attribute support
Date: Mon, 29 Feb 2016 09:11:32 -0800
Message-ID: <1456765892.21069.18.camel@linux.intel.com>
References: <20151007172343.GE4557@linux>
	 <4807388.hTIoZIhGRk@vostro.rjw.lan> <20151016054226.GQ19018@linux>
	 <1456344052.8680.208.camel@linux.intel.com>
	 <CAJZ5v0hh20C3vgWfBpRmR+oOjOf7kqP6HMLKjqzYx8h0ka_dVQ@mail.gmail.com>
	 <1456357073.3860.21.camel@linux.intel.com>
	 <20160225032700.GA2822@vireshk-i7>
	 <1456423672.17628.9.camel@linux.intel.com>
	 <20160226015718.GA2639@vireshk-i7>
	 <1456518098.17628.92.camel@linux.intel.com>
	 <20160229031601.GI5823@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:54169 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752207AbcB2RN0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 29 Feb 2016 12:13:26 -0500
In-Reply-To: <20160229031601.GI5823@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Mon, 2016-02-29 at 08:46 +0530, Viresh Kumar wrote:
> On 26-02-16, 12:21, Srinivas Pandruvada wrote:
> > We are setting a cpufreq global variable in cpufreq_driver->attr
> > with
> > this for each cpu. This feature can be absent in certain cpus. So
> > unlike boost it is not system wide, so I have to reset the attr to
> > NULL
> > for some cpus.
> 
> Ahh, I see..
> 
> What about always creating this file in sysfs, but allowing
> read/write only if
> it is applicable to a CPU.
> 
> > Can we assume that cpufreq_driver->init(policy) calls are always
> > serialized from cpu online/offline and subsys_interface callback
> > path?
> 
> It is called from these paths but only on poilcy creation. So, if you
> are going
> to have a single CPU for each policy, then yes.
> 
This depends on ACPI configuration, so not guaranteed to have one cpu
per policy. Since this is not guaranteed, I can't change mode to Read
only on some as after I set the cpufreq_driver->attr, the other call to
init may change the mode before the actual attribute creation.
So safe bet is to implement like boost for all CPUs and fail on read
for some CPUs, where this is not present. If this becomes a problem,
then we can revisit.

Thanks,
Srinivas
