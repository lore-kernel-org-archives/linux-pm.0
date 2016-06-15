From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 3/3] firmware: scpi: add device power domain support using
 genpd
Date: Wed, 15 Jun 2016 14:23:34 +0100
Message-ID: <576156D6.4010606@arm.com>
References: <1465228439-13457-1-git-send-email-sudeep.holla@arm.com>
 <1465228439-13457-4-git-send-email-sudeep.holla@arm.com>
 <CAPDyKFp5GacJNq_hqhrdupN9gYNHYmE_-Z7ZV-c6BP59AaurZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37347 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751903AbcFONXi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 15 Jun 2016 09:23:38 -0400
In-Reply-To: <CAPDyKFp5GacJNq_hqhrdupN9gYNHYmE_-Z7ZV-c6BP59AaurZw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jon Medhurst <tixy@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Suzuki K Poulose <suzuki.poulose@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>



On 15/06/16 14:05, Ulf Hansson wrote:
> On 6 June 2016 at 17:53, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> This patch hooks up the support for device power domain provided by
>> SCPI using the Linux generic power domain infrastructure.
>>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Cc: Kevin Hilman <khilman@kernel.org>
>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>> Cc: linux-pm@vger.kernel.org
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>
> For following versions, please keep me in the loop for the entire
> series. Including the cover-letter which I am unable to find.
>

Ok, will do.

>> ---
>>   drivers/firmware/Kconfig   |   8 +++
>>   drivers/firmware/Makefile  |   1 +
>>   drivers/firmware/scpi_pd.c | 152 +++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 161 insertions(+)
>>   create mode 100644 drivers/firmware/scpi_pd.c
>>
>> Hi,
>>
>> Since most of the power controller drivers are place in drivers/soc/<soc_name>,
>> I am not sure where to put this SCPI power domain code as it can be used
>> on multiple SoC. I have placed it in drivers/firmware temporarily for
>> review. Please suggest the most apt place to put this driver.
>
> To me, I think it makes sense to put this in the suggested directory,
> as it's not SoC specific code.
>

Sure

>>
>> Regards,
>> Sudeep
>>
>> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
>> index 41abdc54815e..80c963c60f13 100644
>> --- a/drivers/firmware/Kconfig
>> +++ b/drivers/firmware/Kconfig
>> @@ -27,6 +27,14 @@ config ARM_SCPI_PROTOCOL
>>            This protocol library provides interface for all the client drivers
>>            making use of the features offered by the SCP.
>>
>> +config ARM_SCPI_POWER_DOMAIN
>> +       tristate "SCPI power domain driver"
>> +       depends on (ARM_SCPI_PROTOCOL && PM) || COMPILE_TEST
>> +       select PM_GENERIC_DOMAINS_OF
>
> I think this is better:
> depends on (ARM_SCPI_PROTOCOL) || COMPILE_TEST
> select PM_GENERIC_DOMAINS if PM
>

Yes it's changed already like this after Tixy reported an issue.

>> +       help
>> +         This enables support for the SCPI power domains which can be
>> +         enabled or disabled via the SCP firmware
>> +
>>   config EDD
>>          tristate "BIOS Enhanced Disk Drive calls determine boot disk"
>>          depends on X86
>> diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
>> index 474bada56fcd..24f7fe8e3fc3 100644
>> --- a/drivers/firmware/Makefile
>> +++ b/drivers/firmware/Makefile
>> @@ -3,6 +3,7 @@
>>   #
>>   obj-$(CONFIG_ARM_PSCI_FW)      += psci.o
>>   obj-$(CONFIG_ARM_SCPI_PROTOCOL)        += arm_scpi.o
>> +obj-$(CONFIG_ARM_SCPI_POWER_DOMAIN) += scpi_pd.o
>>   obj-$(CONFIG_DMI)              += dmi_scan.o
>>   obj-$(CONFIG_DMI_SYSFS)                += dmi-sysfs.o
>>   obj-$(CONFIG_EDD)              += edd.o
>> diff --git a/drivers/firmware/scpi_pd.c b/drivers/firmware/scpi_pd.c
>
> Perhaps name it scpi_pm_domain.c instead as it gives a better
> description of its purpose.
>

Agreed.

[...]

>> +static const struct of_device_id scpi_power_domain_ids[] = {
>> +       { .compatible = "arm,scpi-power-domains", },
>> +       { /* sentinel */ }
>> +};
>
> Actually I think you shouldn't implement this a standalone driver and
> thus you can remove this compatible.
>

While I tend to agree, I did this to keep it aligned with other SCPI
users(clocks, sensors,.. for example).

I assume remove compatible just from driver ? IMO, it doesn't make sense
to add power domain provider without a compatible.

> Instead, I think it's better if you let the arm_scpi driver to also
> initialize the PM domain.
>

OK, I can do that.

> If you still want the PM domain code to be maintained in a separate
> file, just provide a header file which declares an
> "scpi_pm_domain_init()" function (and a stub when not supported),
> which the arm_scpi driver should call during ->probe().
>

I am fine with that, just that it deviates from the approach taken in
other subsystems as I mentioned above.

-- 
Regards,
Sudeep
