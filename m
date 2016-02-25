From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] cpufreq: acpi_cpufreq: base frequency attribute support
Date: Thu, 25 Feb 2016 10:07:52 -0800
Message-ID: <1456423672.17628.9.camel@linux.intel.com>
References: <1443738317-4224-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <20151007172343.GE4557@linux> <4807388.hTIoZIhGRk@vostro.rjw.lan>
	 <20151016054226.GQ19018@linux> <1456344052.8680.208.camel@linux.intel.com>
	 <CAJZ5v0hh20C3vgWfBpRmR+oOjOf7kqP6HMLKjqzYx8h0ka_dVQ@mail.gmail.com>
	 <1456357073.3860.21.camel@linux.intel.com>
	 <20160225032700.GA2822@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:44765 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933140AbcBYSJX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 25 Feb 2016 13:09:23 -0500
In-Reply-To: <20160225032700.GA2822@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Thu, 2016-02-25 at 08:57 +0530, Viresh Kumar wrote:
> On 24-02-16, 15:37, Srinivas Pandruvada wrote:
> > Good I tested again.
> >=20
> > Hi Viresh,
> >=20
> > Are we no longer allowed to call
> > 	sysfs_create_file in cpufreq_driver.init() callback?
> >=20
> > The following call crashes because of BUG_ON for !kobj->sd:
> > 	sysfs_create_file(&policy->kobj,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
> > &(cpufreq_attr_base_frequency.attr));
> >=20
> > Before I debug further, I want to check with you.
> > This used to work before.
>=20
> Haven't checked that yet, but you should be using cpufreq_driver.attr
> for this
> kind of stuff, isn't it ?
If I use=C2=A0cpufreq_driver.attr, then it will create sysfs attribute =
for
every system using acpi-cpufreq, whether they can support it or not.
This change is only needed for the later generation of Intel CPUs
(IvyBridge and later).=C2=A0
There is no standard ACPI way to know the base frequency if we add
attribute for all systems using acpi-cpufreq.

Thanks,
Srinivas

>=20
