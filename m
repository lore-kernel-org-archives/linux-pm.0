From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2] acpi-cpufreq: replace per_cpu with driver_data of policy
Date: Fri, 10 Jul 2015 03:16:49 +0200
Message-ID: <57468987.NPFzCAAv5k@vostro.rjw.lan>
References: <559BC96E.8020804@intel.com> <12074796.mAD950pclu@vostro.rjw.lan> <559DCE3E.8050105@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55910 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752166AbbGJAuU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2015 20:50:20 -0400
In-Reply-To: <559DCE3E.8050105@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pan Xinhui <xinhuix.pan@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, "mnipxh@163.com" <mnipxh@163.com>, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>

On Thursday, July 09, 2015 09:28:30 AM Pan Xinhui wrote:
> hi, Rafael
> 	thanks for your kind reply. :)
>=20
> On 2015=E5=B9=B407=E6=9C=8809=E6=97=A5 08:20, Rafael J. Wysocki wrote=
:
> > On Tuesday, July 07, 2015 08:04:43 PM Viresh Kumar wrote:
> >> On 07-07-15, 20:43, Pan Xinhui wrote:
> >>>
> >>> Drivers can store their internal per-policy information in
> >>> policy->driver_data, lets use it.
> >>>
> >>> we have benefits after this replacing.
> >>> 1) memory saving.
> >>> 2) policy is shared by several cpus, per_cpu seems not correct. u=
sing
> >>> *driver_data* is more reasonable.
> >>> 3) fix a memory leak in acpi_cpufreq_cpu_exit. as policy->cpu mig=
ht
> >>> change during cpu hotplug. So sometimes we cant't free *data*, us=
e
> >>> *driver_data* to fix it.
> >>> 4) fix a zero return value of get_cur_freq_on_cpu. Only per_cpu o=
f
> >>> policy->cpu is set to *data*, if we try to get cpufreq on other c=
pus, we
> >>> get zero instead of correct values. Use *driver_data* to fix it.
> >>>
> >>> Signed-off-by: Pan Xinhui <xinhuix.pan@intel.com>
> >>> ---
> >>> Changes from V1:
> >>> 	codes style fix, comments update
> >>> 	move cpufreq_cpu_put(policy) after we get *driver_data*
> >>> ---
> >>>  drivers/cpufreq/acpi-cpufreq.c | 40 ++++++++++++++++++++++------=
------------
> >>>  1 file changed, 22 insertions(+), 18 deletions(-)
> >>
> >> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> >=20
> > OK
> >=20
> > Does it fix any recent regressions or is it just an old bug?
> >=20
>=20
> This patch achieve old bug fix and codes improvements. In past days, =
policy has no field *driver_data*, So
> acpi-cpufreq driver has to use per_cpu to store some extra informatio=
n. But it did not take good care of every scenarios.
> Now cpufreq core makes awesome effort to store more per-policy inform=
ation in policy. We can make use of this feature. So I
> cook this patch. :)

OK, patch applied, thanks!

> I am preparing two patches for other two issues in acpi-cpufreq drive=
r based on this patch.
> I will fix them step by step. :)

Thanks for doing that!

Rafael

