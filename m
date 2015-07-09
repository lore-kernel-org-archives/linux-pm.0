From: Pan Xinhui <xinhuix.pan@intel.com>
Subject: Re: [PATCH V2] acpi-cpufreq: replace per_cpu with driver_data of
 policy
Date: Thu, 09 Jul 2015 09:28:30 +0800
Message-ID: <559DCE3E.8050105@intel.com>
References: <559BC96E.8020804@intel.com> <20150707143443.GT14598@linux> <12074796.mAD950pclu@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:30732 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752409AbbGIBbF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 8 Jul 2015 21:31:05 -0400
In-Reply-To: <12074796.mAD950pclu@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, "mnipxh@163.com" <mnipxh@163.com>, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>

hi, Rafael
	thanks for your kind reply. :)

On 2015=E5=B9=B407=E6=9C=8809=E6=97=A5 08:20, Rafael J. Wysocki wrote:
> On Tuesday, July 07, 2015 08:04:43 PM Viresh Kumar wrote:
>> On 07-07-15, 20:43, Pan Xinhui wrote:
>>>
>>> Drivers can store their internal per-policy information in
>>> policy->driver_data, lets use it.
>>>
>>> we have benefits after this replacing.
>>> 1) memory saving.
>>> 2) policy is shared by several cpus, per_cpu seems not correct. usi=
ng
>>> *driver_data* is more reasonable.
>>> 3) fix a memory leak in acpi_cpufreq_cpu_exit. as policy->cpu might
>>> change during cpu hotplug. So sometimes we cant't free *data*, use
>>> *driver_data* to fix it.
>>> 4) fix a zero return value of get_cur_freq_on_cpu. Only per_cpu of
>>> policy->cpu is set to *data*, if we try to get cpufreq on other cpu=
s, we
>>> get zero instead of correct values. Use *driver_data* to fix it.
>>>
>>> Signed-off-by: Pan Xinhui <xinhuix.pan@intel.com>
>>> ---
>>> Changes from V1:
>>> 	codes style fix, comments update
>>> 	move cpufreq_cpu_put(policy) after we get *driver_data*
>>> ---
>>>  drivers/cpufreq/acpi-cpufreq.c | 40 ++++++++++++++++++++++--------=
----------
>>>  1 file changed, 22 insertions(+), 18 deletions(-)
>>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>=20
> OK
>=20
> Does it fix any recent regressions or is it just an old bug?
>=20

This patch achieve old bug fix and codes improvements. In past days, po=
licy has no field *driver_data*, So
acpi-cpufreq driver has to use per_cpu to store some extra information.=
 But it did not take good care of every scenarios.
Now cpufreq core makes awesome effort to store more per-policy informat=
ion in policy. We can make use of this feature. So I
cook this patch. :)

I am preparing two patches for other two issues in acpi-cpufreq driver =
based on this patch.
I will fix them step by step. :)

thanks
xinhui

> Rafael
>=20
