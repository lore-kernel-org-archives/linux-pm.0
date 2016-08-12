From: Hoan Tran <hotran@apm.com>
Subject: Re: [PATCH 1/5] acpi: cppc: Allow build with ACPI_CPU_FREQ_PSS config
Date: Fri, 12 Aug 2016 09:32:55 -0700
Message-ID: <CAFHUOYxOzs-z8OgyemAaBU9JkEJ0t2+gy_BbRcq-9pVDAFM1sw@mail.gmail.com>
References: <1470874646-70570-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1470874646-70570-2-git-send-email-srinivas.pandruvada@linux.intel.com>
 <20160812091337.GA7017@arm.com> <44dbbac5-92e6-d4f9-df92-50e1129d2734@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ua0-f171.google.com ([209.85.217.171]:35784 "EHLO
	mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752600AbcHLQc4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Aug 2016 12:32:56 -0400
Received: by mail-ua0-f171.google.com with SMTP id n59so49963215uan.2
        for <linux-pm@vger.kernel.org>; Fri, 12 Aug 2016 09:32:56 -0700 (PDT)
In-Reply-To: <44dbbac5-92e6-d4f9-df92-50e1129d2734@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Prakash, Prashanth" <pprakash@codeaurora.org>
Cc: Alexey Klimov <alexey.klimov@arm.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, viresh.kumar@linaro.org, linux acpi <linux-acpi@vger.kernel.org>, linux-pm@vger.kernel.org, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>

Hi,

On Fri, Aug 12, 2016 at 9:04 AM, Prakash, Prashanth
<pprakash@codeaurora.org> wrote:
> Hi Alexey,
>
> On 8/12/2016 3:13 AM, Alexey Klimov wrote:
>> (adding Sudeep and Prashanth in c/c)
>>
>> On Wed, Aug 10, 2016 at 05:17:22PM -0700, Srinivas Pandruvada wrote:
>>> Some newer x86 platforms have support for both _CPC and _PSS object. So
>>> kernel config can have both ACPI_CPU_FREQ_PSS and ACPI_CPPC_LIB. So remove
>>> restriction for ACPI_CPPC_LIB to build only when ACPI_CPU_FREQ_PSS is not
>>> defined.
>>> Also for legacy systems with only _PSS, we shouldn't bail out if
>>> acpi_cppc_processor_probe() fails, if ACPI_CPU_FREQ_PSS is also defined.
>>>
>>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>>> ---
>>>  drivers/acpi/Kconfig            | 1 -
>>>  drivers/acpi/processor_driver.c | 5 ++++-
>>>  2 files changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>>> index 445ce28..c6bb6aa 100644
>>> --- a/drivers/acpi/Kconfig
>>> +++ b/drivers/acpi/Kconfig
>>> @@ -227,7 +227,6 @@ config ACPI_MCFG
>>>  config ACPI_CPPC_LIB
>>>      bool
>>>      depends on ACPI_PROCESSOR
>>> -    depends on !ACPI_CPU_FREQ_PSS
>>>      select MAILBOX
>>>      select PCC
>>>      help
>>> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
>>> index 0553aee..0e0b629 100644
>>> --- a/drivers/acpi/processor_driver.c
>>> +++ b/drivers/acpi/processor_driver.c
>>> @@ -245,8 +245,11 @@ static int __acpi_processor_start(struct acpi_device *device)
>>>              return 0;
>>>
>>>      result = acpi_cppc_processor_probe(pr);
>>> -    if (result)
>>> +    if (result) {
>>> +#ifndef CONFIG_ACPI_CPU_FREQ_PSS
>>>              return -ENODEV;
>>> +#endif
>>> +    }
>>>
>>>      if (!cpuidle_get_driver() || cpuidle_get_driver() == &acpi_idle_driver)
>>>              acpi_processor_power_init(pr);
>> If PSS is not defined and kernel fails to probe CPPC then why we should not
>> execute acpi_processor_power_init()?
> Returning on cppc probe failure looks like a bug. We can just print
> a warning and continue to acpi_processor_power_init().

Yes, it is. We should continue. I saw an issue about that. If the CPPC
probe fails, CPUidle can NOT be registered.

Thanks
Hoan

>
> Thanks,
> Prashanth
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
