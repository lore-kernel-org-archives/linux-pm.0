From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v9 2/9] qcom: spm: Add Subsystem Power Manager driver
Date: Wed, 26 Nov 2014 12:19:00 +0100
Message-ID: <5475B724.80202@linaro.org>
References: <1414194024-55547-1-git-send-email-lina.iyer@linaro.org> <1414194024-55547-3-git-send-email-lina.iyer@linaro.org> <54662622.2020307@linaro.org> <20141119174339.GA891@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:55043 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226AbaKZLTG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Nov 2014 06:19:06 -0500
Received: by mail-wi0-f178.google.com with SMTP id hi2so4570413wib.11
        for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2014 03:19:04 -0800 (PST)
In-Reply-To: <20141119174339.GA891@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org

On 11/19/2014 06:43 PM, Lina Iyer wrote:
> On Fri, Nov 14 2014 at 08:56 -0700, Daniel Lezcano wrote:
>> On 10/25/2014 01:40 AM, Lina Iyer wrote:
>
>>> +/**
>>> + * spm_set_low_power_mode() - Configure SPM start address for low
>>> power mode
>>> + * @mode: SPM LPM mode to enter
>>> + */
>>> +int qcom_spm_set_low_power_mode(enum pm_sleep_mode mode)
>>> +{
>>> +    struct spm_driver_data *drv =3D this_cpu_ptr(&cpu_spm_drv);
>>> +    u32 start_index;
>>> +    u32 ctl_val;
>>> +
>>> +    if (!drv->available)
>>> +        return -ENXIO;
>>
>> really weird how this was initialized.
>>
>> Are you sure 'drv' is not NULL if it is not available ? (see below)
>>
> 'drv' has some data that I need to decode the register address. Hence
> cant have that NULL. Therefore, the available flag.
>
> ...
>
>> +static int spm_dev_probe(struct platform_device *pdev)
>>> +{
>>> +    struct spm_driver_data *drv;
>>> +    struct resource *res;
>>> +    const struct of_device_id *match_id;
>>> +    void __iomem *addr;
>>> +    const u32 *seq_data;
>>> +    int cpu =3D -EINVAL;
>>> +    static bool cpuidle_drv_init;
>>> +
>>> +    drv =3D spm_get_drv(pdev, &cpu);
>>> +    if (!drv)
>>> +        return -EINVAL;
>>> +
>>> +    res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +    drv->reg_base =3D devm_ioremap_resource(&pdev->dev, res);
>>> +    if (IS_ERR(drv->reg_base))
>>> +        return PTR_ERR(drv->reg_base);
>>> +
>>> +    match_id =3D of_match_node(spm_match_table, pdev->dev.of_node)=
;
>>> +    if (!match_id)
>>> +        return -ENODEV;
>>> +
>>> +    drv->reg_data =3D match_id->data;
>>> +    if (!drv->reg_data)
>>> +        return -EINVAL;
>>> +
>>> +    /* Write the SPM sequences, first.. */
>>> +    addr =3D drv->reg_base +
>>> drv->reg_data->reg_offset[SPM_REG_SEQ_ENTRY];
>>> +    seq_data =3D (const u32 *)drv->reg_data->seq;
>>> +    __iowrite32_copy(addr, seq_data, ARRAY_SIZE(drv->reg_data->seq=
)/4);
>>> +
>>> +    /* ..and then, the control registers.
>>> +     * On some SoC's if the control registers are written first an=
d
>>> if the
>>> +     * CPU was held in reset, the reset signal could trigger the S=
PM
>>> state
>>> +     * machine, before the sequences are completely written.
>>> +     */
>>> +    spm_register_write(drv, SPM_REG_CFG, drv->reg_data->spm_cfg);
>>> +    spm_register_write(drv, SPM_REG_DLY, drv->reg_data->spm_dly);
>>> +    spm_register_write(drv, SPM_REG_PMIC_DLY, drv->reg_data->pmic_=
dly);
>>> +
>>> +    spm_register_write(drv, SPM_REG_PMIC_DATA_0,
>>> +                drv->reg_data->pmic_data[0]);
>>> +    spm_register_write(drv, SPM_REG_PMIC_DATA_1,
>>> +                drv->reg_data->pmic_data[1]);
>>> +
>>> +    /**
>>> +     * Ensure all observers see the above register writes before t=
he
>>> +     * cpuidle driver is allowed to use the SPM.
>>> +     */
>>> +    wmb();
>>> +    drv->available =3D true;
>>
>> IMO if you have to do that, that means there is something wrong with
>> how is initialized the driver.
>>
>> It should be drv =3D=3D NULL =3D> not available
>>
> drv has the register base that I dont want to pass seprately.
>
>>> +
>>> +    if ((cpu > -1) && !cpuidle_drv_init) {
>>> +        platform_device_register(&qcom_cpuidle_device);
>>> +        cpuidle_drv_init =3D true;
>>> +    }
>>
>> 'cpu' is always > -1.
>>
> OK. I was hoping to use -1 for not a cpu (i.e, L2) SPM. For now, I wi=
ll
> change.
>
>
>> If the 'spm_get_drv' succeed, cpu is no longer equal to -EINVAL.
>> Otherwise we do not reach this point because we return right after
>> spm_get_drv with an error.
>>
>> Adding the platform_device_register depending in a static variable i=
s
>> not very nice. Why not add it explicitely in a separate init routine
>> we know it will be called one time (eg. at the same place than cpufr=
eq
>> is) ?
>>
> We want to register the cpuidle device only if any of the SPM devices
> have been probed.
>
> Ideally, Stephen and I would like to register cpuidle device separate=
ly
> for each CPU SPM, when it is probed, so we would invoke cpuidle drive=
r
> and thereby the low power modes only for those cpus. However, the
> complexity to do that, AFAICS, is very complex. I would need to chang=
e
> quite a bit of the framework and in the cpuidle driver, I may have to
> stray from the recommended format.
>
> Here I set up cpuidle device, when I know atleast 1 cpu is ready to
> allow low power modes.

Yes, instead of using the generic cpuidle_register function, you can us=
e=20
the low level functions for that.

One call to cpuidle_register_driver in a single place and then=20
cpuidle_register_device for each spm probe.

Wouldn't make sense ?

   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

