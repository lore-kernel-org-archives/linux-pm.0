From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] cpufreq: acpi_cpufreq: base frequency attribute support
Date: Fri, 26 Feb 2016 12:21:38 -0800
Message-ID: <1456518098.17628.92.camel@linux.intel.com>
References: <1443738317-4224-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <20151007172343.GE4557@linux> <4807388.hTIoZIhGRk@vostro.rjw.lan>
	 <20151016054226.GQ19018@linux> <1456344052.8680.208.camel@linux.intel.com>
	 <CAJZ5v0hh20C3vgWfBpRmR+oOjOf7kqP6HMLKjqzYx8h0ka_dVQ@mail.gmail.com>
	 <1456357073.3860.21.camel@linux.intel.com>
	 <20160225032700.GA2822@vireshk-i7>
	 <1456423672.17628.9.camel@linux.intel.com>
	 <20160226015718.GA2639@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:3471 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751364AbcBZUX7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 26 Feb 2016 15:23:59 -0500
In-Reply-To: <20160226015718.GA2639@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Fri, 2016-02-26 at 07:27 +0530, Viresh Kumar wrote:
> On 25-02-16, 10:07, Srinivas Pandruvada wrote:
> > If I use=C2=A0cpufreq_driver.attr, then it will create sysfs attrib=
ute
> > for
> > every system using acpi-cpufreq, whether they can support it or
> > not.
> > This change is only needed for the later generation of Intel CPUs
> > (IvyBridge and later).=C2=A0
> > There is no standard ACPI way to know the base frequency if we add
> > attribute for all systems using acpi-cpufreq.
>=20
> Why can't you set cpufreq_driver.attr selectively from probe()?
>=20
We are setting a cpufreq global variable in cpufreq_driver->attr with
this for each cpu. This feature can be absent in certain cpus. So
unlike boost it is not system wide, so I have to reset the attr to NULL
for some cpus.
Can we assume that cpufreq_driver->init(policy) calls are always
serialized from cpu online/offline and subsys_interface callback path?

Thanks,
Srinivas
> See below for reference.
>=20
> commit 21c36d35711d ("cpufreq-dt: make scaling_boost_freqs sysfs attr
> available
> when boost is enabled")
>=20
