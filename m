From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 4/4] cpufreq: arm_big_little: add SCPI interface driver
Date: Wed, 29 Apr 2015 10:39:48 +0100
Message-ID: <5540A6E4.8030504@arm.com>
References: <1430134846-24320-1-git-send-email-sudeep.holla@arm.com>	<1430134846-24320-5-git-send-email-sudeep.holla@arm.com> <CAKohpondhNBhWBjspSSoBUz-V605K+4UEqQFdTCqRd=Yc-RXCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60918 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966060AbbD2Jjx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 29 Apr 2015 05:39:53 -0400
In-Reply-To: <CAKohpondhNBhWBjspSSoBUz-V605K+4UEqQFdTCqRd=Yc-RXCg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Liviu Dudau <Liviu.Dudau@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "Jon Medhurst (Tixy)" <tixy@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi Viresh,

Thanks for the review.

On 29/04/15 06:44, Viresh Kumar wrote:
> On 27 April 2015 at 17:10, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
>> index 4f3dbc8cf729..9e678bf1687c 100644
>> --- a/drivers/cpufreq/Kconfig.arm
>> +++ b/drivers/cpufreq/Kconfig.arm
>> @@ -24,6 +24,15 @@ config ARM_VEXPRESS_SPC_CPUFREQ
>>             This add the CPUfreq driver support for Versatile Express
>>            big.LITTLE platforms using SPC for power management.
>>
>> +config ARM_SCPI_CPUFREQ
>> +        tristate "SCPI based CPUfreq driver"
>> +       depends on ARM_BIG_LITTLE_CPUFREQ && ARM_SCPI_PROTOCOL
>> +        help
>> +          This add the CPUfreq driver support for ARM big.LITTLE platforms
>> +         using SCPI interface for CPU power management.
>> +
>> +         This driver works only if firmware the supporting CPU DVFS adhere
>> +         to SCPI protocol.
>
> Wanna reword that ?
>

Ok


[...]

>> +static int scpi_init_opp_table(struct device *cpu_dev)
>> +{
>> +       u8 domain = topology_physical_package_id(cpu_dev->id);
>> +       struct scpi_dvfs_info *info;
>> +       struct scpi_opp *opp;
>> +       int idx, ret = 0;
>> +
>> +       if ((dev_pm_opp_get_opp_count(cpu_dev)) > 0)
>> +               return 0;
>
> Why, who would have added it ?
>

IIRC, it was added to prevent spurious duplicate OPP addition messages
during CPU hotplug. I will check it again.

>> +       info = scpi_ops->dvfs_get_info(domain);
>
> Isn't calling this twice costly for getting the same information ?
>

No the SCPI protocol saves them and return just the pointer if it's
already populated.

>> +       if (IS_ERR(info))
>> +               return PTR_ERR(info);
>> +
>> +       opp = info->opps;
>> +       if (!opp)
>> +               return -EIO;
>> +
>> +       for (idx = 0; idx < info->count; idx++, opp++) {
>> +               ret = dev_pm_opp_add(cpu_dev, opp->freq, opp->m_volt * 1000);
>> +               if (ret) {
>> +                       dev_warn(cpu_dev, "failed to add opp %uHz %umV\n",
>> +                                opp->freq, opp->m_volt);
>
> Don't you want to free earlier OPPs here ?
>

Make sense will fix.

>> +static struct cpufreq_arm_bL_ops scpi_cpufreq_ops = {
>> +       .name   = "scpi",
>> +       .get_transition_latency = scpi_get_transition_latency,
>> +       .init_opp_table = scpi_init_opp_table,
>
> Don't want to free/remove OPPs ?
>

Ah I see a new function is added, will fix it. In-fact this driver was
written before that and was held up since the firmware was not stable.

[...]

>> +static struct platform_driver scpi_cpufreq_platdrv = {
>> +       .driver = {
>> +               .name   = "scpi-cpufreq",
>> +               .owner  = THIS_MODULE,
>> +       },
>> +       .probe          = scpi_cpufreq_probe,
>> +       .remove         = scpi_cpufreq_remove,
>> +};
>> +module_platform_driver(scpi_cpufreq_platdrv);
>> +
>> +MODULE_LICENSE("GPL");
>
> GPL V2 ?
>
> Author/Description missing ..
>

Will fix it in next version.

Regards,
Sudeep
