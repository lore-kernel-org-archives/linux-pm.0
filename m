From: Hoan Tran <hotran@apm.com>
Subject: Re: [PATCH 1/5] acpi: cppc: Allow build with ACPI_CPU_FREQ_PSS config
Date: Fri, 12 Aug 2016 09:58:45 -0700
Message-ID: <CAFHUOYzXd-cP0G8BiScyH-EykK0D9RJD9eFKGP9Ok12NAgpRnA@mail.gmail.com>
References: <1470874646-70570-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1470874646-70570-2-git-send-email-srinivas.pandruvada@linux.intel.com>
 <CAFHUOYx55WhrwaqpB7Jh8V_fnR1xVW=RWf9ZsCnJZFJt_JbpBw@mail.gmail.com> <1471020739.3745.10.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1471020739.3745.10.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, viresh.kumar@linaro.org, linux acpi <linux-acpi@vger.kernel.org>, linux-pm@vger.kernel.org, Ashwin Chaugule <ashwin.chaugule@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi Srinivas,

On Fri, Aug 12, 2016 at 9:52 AM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> On Fri, 2016-08-12 at 09:35 -0700, Hoan Tran wrote:
>> Hi Srinivas,
>>
>> On Wed, Aug 10, 2016 at 5:17 PM, Srinivas Pandruvada
>> <srinivas.pandruvada@linux.intel.com> wrote:
>> >
>> > Some newer x86 platforms have support for both _CPC and _PSS
>> > object. So
>> > kernel config can have both ACPI_CPU_FREQ_PSS and ACPI_CPPC_LIB. So
>> > remove
>> > restriction for ACPI_CPPC_LIB to build only when ACPI_CPU_FREQ_PSS
>> > is not
>> > defined.
>> > Also for legacy systems with only _PSS, we shouldn't bail out if
>> > acpi_cppc_processor_probe() fails, if ACPI_CPU_FREQ_PSS is also
>> > defined.
>> >
>> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel
>> > .com>
>> > ---
>> >  drivers/acpi/Kconfig            | 1 -
>> >  drivers/acpi/processor_driver.c | 5 ++++-
>> >  2 files changed, 4 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> > index 445ce28..c6bb6aa 100644
>> > --- a/drivers/acpi/Kconfig
>> > +++ b/drivers/acpi/Kconfig
>> > @@ -227,7 +227,6 @@ config ACPI_MCFG
>> >  config ACPI_CPPC_LIB
>> >         bool
>> >         depends on ACPI_PROCESSOR
>> > -       depends on !ACPI_CPU_FREQ_PSS
>> From ACPI 6.1 spec, if _CPC is present, its use supersedes the use of
>> PSS. So I think, config ACPI_CPU_FREQ_PSS should depend on
>> !ACPI_CPPC_LIB.
>>
> Distro want to have a single binary kernel image, so they will turn on
> all configs. So this is not a compile time decision.
> On runtime if the ACPI contains both tables than _CPC should be used
> (but that also if the kernel is capable of handling _CPC, as legacy
> kernel will not).

Agreed. If so, this "depends on" is not need, right ? And a runtime
code will be added to decide which is used instead ?

Thanks
Hoan

>
> Thanks,
> Srinivas
>
>> Thanks
>> Hoan
>>
>> >
>> >         select MAILBOX
>> >         select PCC
>> >         help
>> > diff --git a/drivers/acpi/processor_driver.c
>> > b/drivers/acpi/processor_driver.c
>> > index 0553aee..0e0b629 100644
>> > --- a/drivers/acpi/processor_driver.c
>> > +++ b/drivers/acpi/processor_driver.c
>> > @@ -245,8 +245,11 @@ static int __acpi_processor_start(struct
>> > acpi_device *device)
>> >                 return 0;
>> >
>> >         result = acpi_cppc_processor_probe(pr);
>> > -       if (result)
>> > +       if (result) {
>> > +#ifndef CONFIG_ACPI_CPU_FREQ_PSS
>> >                 return -ENODEV;
>> > +#endif
>> > +       }
>> >
>> >         if (!cpuidle_get_driver() || cpuidle_get_driver() ==
>> > &acpi_idle_driver)
>> >                 acpi_processor_power_init(pr);
>> > --
>> > 2.7.4
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-
>> > acpi" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pm"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
