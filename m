From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH 2/2] CPUFreq: Add new sysfs attribute freqdomain_cpus
 for acpi-freq driver
Date: Tue, 25 Jun 2013 16:19:14 +0800
Message-ID: <51C95282.3040305@intel.com>
References: <1372126006-4950-1-git-send-email-tianyu.lan@intel.com> <1372126006-4950-2-git-send-email-tianyu.lan@intel.com> <CAKohpokUmvkkGwCDDa1d8OCz8YcsE2J0GQkA-dJ=EE+6REm7Mg@mail.gmail.com> <51C93E9E.3030107@intel.com> <CAKohpo=K8fN=AhSKRRNRq-UXNhJ3YFVe6YKG+mAbq079TD4Yyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:37697 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751597Ab3FYI0Q (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 25 Jun 2013 04:26:16 -0400
In-Reply-To: <CAKohpo=K8fN=AhSKRRNRq-UXNhJ3YFVe6YKG+mAbq079TD4Yyg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, lenb@kernel.org, jean-philippe.halimi@exascale-computing.eu, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org

On 2013=E5=B9=B406=E6=9C=8825=E6=97=A5 15:48, Viresh Kumar wrote:
> On 25 June 2013 12:24, Lan Tianyu <tianyu.lan@intel.com> wrote:
>> On 2013=E5=B9=B406=E6=9C=8825=E6=97=A5 11:56, Viresh Kumar wrote:
>=20
>>> This is generic file, don't add this information here. Add this in
>>> acpi-cpufreq file.
>> I don't find acpi-cpufreq.txt under
>> Documentation/cpu-freq/acpi-cpufreq.txt. So I should create it?
>=20
> I meant acpi-cpufreq.c file
Ok. From my opinion, the new attribute is an ABI and it's better to add
descriptor under Document directory. The user can be easy to find how t=
o
use it.

>=20
>> Please see the acpi_processor_preregister_performance() in the
>> drivers/acpi/processor_perlib.c. All cpus in the same dependency dom=
ain
>> are stored in the perf->shared_cpu_map(including the reference cpu t=
he
>> perf belongs to). Original code will copy shared_cpu_map to
>> policy->related_cpus, do cpumask_or between policy->related_cpus and
>> policy->cpus in the cpufreq_add_dev() and store the result into
>> policy->related_cpus. Expose the data via related_cpus.
>>
>> For acpi-cpufreq driver, the shared_cpu_map is the biggest subset si=
nce
>> it regardless the coordination type.
>>
>> After the commit aa77a5, only the cpus in the software or
>> software&hardware coordination type dependency domain will copy to
>> policy->cpus and finally store into policy->related_cpus in the
>> cpufreq_add_dev() by cpumask_or. And then we miss the cpus in the
>> hardware coordination type domain. But these info is still stored in=
 the
>> policy->shared_cpu_map. Does this make sense?
>=20
> I was concerned about this code that was present earlier. That change=
s
> related_cpus based on some conditions.

Please see the commit which add the code. Maybe, we should overwrite
shared_cpu_map by sibling_cpus for this case?

commit acd316248205d553594296f1895ba5196b89ffcc
Author: Andre Przywara <andre.przywara@amd.com>
Date:   Tue Sep 4 08:28:03 2012 +0000

    acpi-cpufreq: Add quirk to disable _PSD usage on all AMD CPUs

    To workaround some Windows specific behavior, the ACPI _PSD table
    on AMD desktop boards advertises all cores as dependent, meaning
    that they all can only use the same P-state. acpi-cpufreq strictly
    obeys this description, instantiating one CPU only and symlinking
    the others. But the hardware can have distinct frequencies for each
    core and powernow-k8 did it that way.
    So, in order to use the hardware to its full potential and keep the
    original powernow-k8 behavior, lets override the _PSD table setting
    on AMD hardware.
    We use the siblings table, as it matches the current hardware
    behavior.

    Signed-off-by: Andre Przywara <andre.przywara@amd.com>
    Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>


>=20
>         if (check_amd_hwpstate_cpu(cpu) && !acpi_pstate_strict) {
>                 cpumask_clear(policy->cpus);
>                 cpumask_set_cpu(cpu, policy->cpus);
>                 cpumask_copy(policy->related_cpus, cpu_sibling_mask(c=
pu));
>                 policy->shared_type =3D CPUFREQ_SHARED_TYPE_HW;
>                 pr_info_once(PFX "overriding BIOS provided _PSD data\=
n");
>         }
>=20


--=20
Best regards
Tianyu Lan
