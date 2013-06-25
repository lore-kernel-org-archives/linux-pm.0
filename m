From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] CPUFreq: Add new sysfs attribute freqdomain_cpus for
 acpi-freq driver
Date: Tue, 25 Jun 2013 13:18:17 +0530
Message-ID: <CAKohpo=K8fN=AhSKRRNRq-UXNhJ3YFVe6YKG+mAbq079TD4Yyg@mail.gmail.com>
References: <1372126006-4950-1-git-send-email-tianyu.lan@intel.com>
	<1372126006-4950-2-git-send-email-tianyu.lan@intel.com>
	<CAKohpokUmvkkGwCDDa1d8OCz8YcsE2J0GQkA-dJ=EE+6REm7Mg@mail.gmail.com>
	<51C93E9E.3030107@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:47256 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317Ab3FYHsR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2013 03:48:17 -0400
Received: by mail-oa0-f51.google.com with SMTP id i4so12818396oah.24
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2013 00:48:17 -0700 (PDT)
In-Reply-To: <51C93E9E.3030107@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: rjw@sisk.pl, lenb@kernel.org, jean-philippe.halimi@exascale-computing.eu, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org

On 25 June 2013 12:24, Lan Tianyu <tianyu.lan@intel.com> wrote:
> On 2013=E5=B9=B406=E6=9C=8825=E6=97=A5 11:56, Viresh Kumar wrote:

>> This is generic file, don't add this information here. Add this in
>> acpi-cpufreq file.
> I don't find acpi-cpufreq.txt under
> Documentation/cpu-freq/acpi-cpufreq.txt. So I should create it?

I meant acpi-cpufreq.c file

> Please see the acpi_processor_preregister_performance() in the
> drivers/acpi/processor_perlib.c. All cpus in the same dependency doma=
in
> are stored in the perf->shared_cpu_map(including the reference cpu th=
e
> perf belongs to). Original code will copy shared_cpu_map to
> policy->related_cpus, do cpumask_or between policy->related_cpus and
> policy->cpus in the cpufreq_add_dev() and store the result into
> policy->related_cpus. Expose the data via related_cpus.
>
> For acpi-cpufreq driver, the shared_cpu_map is the biggest subset sin=
ce
> it regardless the coordination type.
>
> After the commit aa77a5, only the cpus in the software or
> software&hardware coordination type dependency domain will copy to
> policy->cpus and finally store into policy->related_cpus in the
> cpufreq_add_dev() by cpumask_or. And then we miss the cpus in the
> hardware coordination type domain. But these info is still stored in =
the
> policy->shared_cpu_map. Does this make sense?

I was concerned about this code that was present earlier. That changes
related_cpus based on some conditions.

        if (check_amd_hwpstate_cpu(cpu) && !acpi_pstate_strict) {
                cpumask_clear(policy->cpus);
                cpumask_set_cpu(cpu, policy->cpus);
                cpumask_copy(policy->related_cpus, cpu_sibling_mask(cpu=
));
                policy->shared_type =3D CPUFREQ_SHARED_TYPE_HW;
                pr_info_once(PFX "overriding BIOS provided _PSD data\n"=
);
        }
