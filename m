From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: intel_pstate: Load when ACPI PCCH is present
Date: Tue, 17 Jul 2018 19:28:41 +0200
Message-ID: <CAJZ5v0hFAWr7ozVb9OfVTUPCyjZAtsQsDSm=Le_oMwOxAgTJbA@mail.gmail.com>
References: <20180717065048.74mmgk4t5utjaa6a@suselix> <20180717102136.snayvzmv2h3dcwiq@suselix>
 <20180717140336.ayovaz4ksdlak6bb@suselix> <8115130.Fhkpr82c7G@aspire.rjw.lan> <d4419603cb727bb28fe9ab7abfc9595b78cb7554.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d4419603cb727bb28fe9ab7abfc9595b78cb7554.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andreas Herrmann <aherrmann@suse.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <frederic@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 17, 2018 at 7:23 PM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> On Tue, 2018-07-17 at 18:13 +0200, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Currently, intel_pstate doesn't load if _PSS is not present on
>> HP Proliant systems, because it expects the firmware to take over
>> CPU performance scaling in that case.  However, if ACPI PCCH is
>> present, the firmware expects the kernel to use it for CPU
>> performance scaling and the pcc-cpufreq driver is loaded for that.
>>
>> Unfortunately, the firmware interface used by that driver is not
>> scalable for fundamental reasons, so pcc-cpufreq is way suboptimal
>> on systems with more than just a few CPUs.  In fact, it is better to
>> avoid using it at all.
>>
>> For this reason, modify intel_pstate to look for ACPI PCCH if _PSS
>> is not present and load if it is there.
>>
>> Fixes: fbbcdc0744da (intel_pstate: skip the driver if ACPI has power
>> mgmt option)
>> Reported-by: Andreas Herrmann <aherrmann@suse.com>
>> Tested-by: Andreas Herrmann <aherrmann@suse.com>
>> Reviewed-by: Andreas Herrmann <aherrmann@suse.com>
>> Cc: 4.17+ <stable@vger.kernel.org> # 4.17+
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>
> But do we need a change as done by the following commit in in pcc-
> cpufreq.c?
>
> "
> commit 8a61e12e84597b5f8155ac91b44dea866ccfaac2
> Author: Yinghai Lu <yinghai@kernel.org>
> Date:   Fri Sep 20 10:43:56 2013 -0700
>
>     acpi-cpufreq: skip loading acpi_cpufreq after intel_pstate
>
> "

Quite likely yes, good point!


>> ---
>>  drivers/cpufreq/intel_pstate.c |   17 ++++++++++++++++-
>>  1 file changed, 16 insertions(+), 1 deletion(-)
>>
>> Index: linux-pm/drivers/cpufreq/intel_pstate.c
>> ===================================================================
>> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
>> +++ linux-pm/drivers/cpufreq/intel_pstate.c
>> @@ -2391,6 +2391,18 @@ static bool __init intel_pstate_no_acpi_
>>       return true;
>>  }
>>
>> +static bool __init intel_pstate_no_acpi_pcch(void)
>> +{
>> +     acpi_status status;
>> +     acpi_handle handle;
>> +
>> +     status = acpi_get_handle(NULL, "\\_SB", &handle);
>> +     if (ACPI_FAILURE(status))
>> +             return true;
>> +
>> +     return !acpi_has_method(handle, "PCCH");
>> +}
>> +
>>  static bool __init intel_pstate_has_acpi_ppc(void)
>>  {
>>       int i;
>> @@ -2450,7 +2462,10 @@ static bool __init intel_pstate_platform
>>
>>       switch (plat_info[idx].data) {
>>       case PSS:
>> -             return intel_pstate_no_acpi_pss();
>> +             if (!intel_pstate_no_acpi_pss())
>> +                     return false;
>> +
>> +             return intel_pstate_no_acpi_pcch();
>>       case PPC:
>>               return intel_pstate_has_acpi_ppc() && !force_load;
>>       }
>>
