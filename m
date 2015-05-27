From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v5 2/6] ACPI: Make ACPI processor driver more extensible
Date: Wed, 27 May 2015 10:05:45 -0400
Message-ID: <CAJ5Y-eYdH76TGTGnVK6ShmdBqFFin7=Ty9V6Sb+J3qtj8Bsuag@mail.gmail.com>
References: <1432590659-9016-1-git-send-email-ashwin.chaugule@linaro.org>
	<1432675261.11262.276.camel@spandruv-DESK3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:34454 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795AbbE0OFq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 May 2015 10:05:46 -0400
Received: by obew15 with SMTP id w15so8196649obe.1
        for <linux-pm@vger.kernel.org>; Wed, 27 May 2015 07:05:45 -0700 (PDT)
In-Reply-To: <1432675261.11262.276.camel@spandruv-DESK3.jf.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: "patches@linaro.org" <patches@linaro.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "sudeep.holla@arm.com" <sudeep.holla@arm.com>, "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>

On 26 May 2015 at 17:22, Pandruvada, Srinivas
<srinivas.pandruvada@intel.com> wrote:
> On Mon, 2015-05-25 at 17:50 -0400, Ashwin Chaugule wrote:
>> The ACPI processor driver is currently tied too closely
>> to the ACPI C-states (CST), P-states (PSS) and other related
>> constructs for controlling CPU idle and CPU performance.
>>
>> The newer ACPI specification (v5.1 onwards) introduces
>> alternative methods to CST and PSS. These new mechanisms
>> are described within each ACPI Processor object and so they
>> need to be scanned whenever a new Processor object is detected.
>> This patch introduces two new Kconfig symbols to allow for
>> finer configurability among the various options for controlling
>> CPU idle and performance states. There is no change in functionality
>> and these options are defaulted to enabled to maintain previous
>> behaviour.
>>
>> The following patchwork introduces CPPC: A newer method of
>> controlling CPU performance. The OS is not expected to support CPPC
>> and PSS at runtime. So the kconfig option lets us make these two
>> mutually exclusive at compile time.
>>
>> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
>> ---
>>  drivers/acpi/Kconfig            |  41 +++++++++++----
>>  drivers/acpi/Makefile           |   7 +--
>>  drivers/acpi/processor_driver.c |  85 ++++++++++++++++++++---------=
--
>>  drivers/cpufreq/Kconfig         |   2 +-
>>  drivers/cpufreq/Kconfig.x86     |   2 +
>>  include/acpi/processor.h        | 109 +++++++++++++++++++++++++++++=
+++++------
>>  6 files changed, 187 insertions(+), 59 deletions(-)
>>
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index ab2cbb5..d98d304 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -163,23 +163,42 @@ config ACPI_FAN
>>  config ACPI_DOCK
>>       bool "Dock"
>>       help
>> -       This driver supports ACPI-controlled docking stations and re=
movable
>> -       drive bays such as the IBM Ultrabay and the Dell Module Bay.
>> +     This driver supports ACPI-controlled docking stations and remo=
vable
>> +     drive bays such as the IBM Ultrabay and the Dell Module Bay.
>> +
> To be consistent align help text to letter "l" of help.

Ok.

> Also checkpatch errors in this file.

Arg. I ran checkpatch first, then made more mods and forgot to run it
again. Will make sure its done before sending out the final version.

>> -static int __acpi_processor_start(struct acpi_device *device)
>> +#ifdef CONFIG_ACPI_PSS
>> +static int acpi_pss_init(struct acpi_processor *pr, struct acpi_dev=
ice *device)
>>  {
> This name sounds to me that it it initializing something to do with _=
PSS
> only. But this function does more than that. Like handling ppc change
> and also thermal cdev register. Can we have some better name?
>

True. I couldn't really come up with anything better. From the way
this thing was structured originally, everything seems linked to PSS
one way or another. (including CSS based idle).

How about acpi_legacy_perf_init() ?

>> -     struct acpi_processor *pr =3D acpi_driver_data(device);
>> -     acpi_status status;
>>       int result =3D 0;
>>
>> -     if (!pr)
>> -             return -ENODEV;
>> -
>> -     if (pr->flags.need_hotplug_init)
>> -             return 0;
>> -
>> -#ifdef CONFIG_CPU_FREQ
>>       acpi_processor_ppc_has_changed(pr, 0);
>> -#endif
>> +
>>       acpi_processor_get_throttling_info(pr);
> When CPPC is present, you don't need support for _PTC, _TSS and _TPC?

Nope.

----8<----
8.4.7.1.10 Relationship to other ACPI-defined Objects and Notifications
If _CPC is present, its use supersedes the use of the following
existing ACPI objects:
=E2=80=A2 The P_BLK P_CNT register
=E2=80=A2 _PTC
=E2=80=A2 _TSS
=E2=80=A2 _TPC
=E2=80=A2 _TSD
=E2=80=A2 _TDL
=E2=80=A2 _PCT
=E2=80=A2 _PSS
=E2=80=A2 _PPC
=E2=80=A2 _PDL
=E2=80=A2 Notify 0x80 on the processor device
=E2=80=A2 Notify 0x82 on the processor device
The _PSD object may be used to specify domain dependencies between
processors. On a system
with heterogeneous processors, all processors within a single domain
must have the same
performance capabilities.

----8<----

>
>>
>>       if (pr->flags.throttling)
>>               pr->flags.limit =3D 1;
>>
>> -     if (!cpuidle_get_driver() || cpuidle_get_driver() =3D=3D &acpi=
_idle_driver)
>> -             acpi_processor_power_init(pr);
>> -
>>       pr->cdev =3D thermal_cooling_device_register("Processor", devi=
ce,
>>                                                  &processor_cooling_=
ops);
>>       if (IS_ERR(pr->cdev)) {
>>               result =3D PTR_ERR(pr->cdev);
>> -             goto err_power_exit;
>> +             return result;
>>       }
> Don't you need this thermal_ call for when controlling via CPPC?
> I think you should move to common start function.

I'd prefer to keep thermal stuff outside of CPPC for now. Everyone
I've discussed with in the ARM64 server space plans to handle thermal
independently on a remote processor. If that changes, then we'll come
back to this. Anyway, as it is today, the thermal stuff in ACPI
depends on TSS, which will need changes for CPPC.

>
> I feel that all the old function did was relevant to CPPC support als=
o.
> except PPC change. So you may just need to add call to
> acpi_cppc_processor_probe() for CPPC support.
>

I hope the above explains this.

Thanks,
Ashwin.
