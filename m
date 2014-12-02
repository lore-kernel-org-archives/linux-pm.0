From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v13 03/10] qcom: spm: Add Subsystem Power Manager driver
Date: Tue, 02 Dec 2014 10:53:30 +0100
Message-ID: <547D8C1A.1010204@linaro.org>
References: <1417065854-37745-1-git-send-email-lina.iyer@linaro.org> <1417065854-37745-4-git-send-email-lina.iyer@linaro.org> <5476E653.4040007@linaro.org> <20141201185023.GB499@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20141201185023.GB499@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 12/01/2014 07:50 PM, Lina Iyer wrote:
> On Thu, Nov 27 2014 at 01:52 -0700, Daniel Lezcano wrote:
>> On 11/27/2014 06:24 AM, Lina Iyer wrote:
>
>> +    static bool cpuidle_drv_init;
>>
>>        ^^^^^^^^^
>>
>> As already said in a previous comment, please find a way to remove t=
hat.
>>
> I will look into it. Stephen and I wanted the cpuidle driver to be
> probed only after any of the SPMs are ready. And possibly, only for t=
hat
> cpu, for which the SPM has been probed.
>
> To achieve the SPM -> CPUIDLE Device relation, I havent found a good =
way
> to do that. Without using CPUIDLE_MULTIPLE_DRIVERS, initializing each
> cpuidle device, separate from the cpuidle driver, requires that I upd=
ate
> the cpuidle_driver->cpumask after probing each SPM device, to allow f=
or
> only one driver and cpuidle devices only for the probed cpus. Using t=
he
> cpuidle_register_driver(), resets the drv->refcnt in
> __cpuidle_driver_init.
>
> I may need something like this in the else clause of
> CPUIDLE_MULTIPLE_DRIVERS -
>
> static inline struct cpuidle_driver *__cpuidle_get_cpu_driver(int cpu=
)
> {
>         struct cpuidle_driver *drv =3D cpuidle_curr_driver;
>
>         if (drv && !cpumask_test_cpu(cpu, drv->cpumask))
>                  drv =3D NULL;
>
>         return drv;
> }

You don't have to deal with the drv->cpumask and=20
CPUIDLE_MULTIPLE_DRIVERS. This field gives the list of the cpus the=20
driver will have to potentially handle.

Just register the driver at the first place with the platform device by=
=20
using cpuidle_register_driver(drv), I suggest somewhere else than the=20
spm code.

The underlying code will do:

         if (!drv->cpumask)
                 drv->cpumask =3D (struct cpumask *)cpu_possible_mask;

Until the cpuidle device is not initialized for a specific cpu, the=20
cpuidle code will have no effect for this cpu. If you register the=20
driver but without registering the cpuidle devices that will result in=20
nothing more than a structure initialized but inoperative.

=46or each SPM being probed:

struct cpuidle_device *dev =3D &per_cpu(cpuidle_dev, cpu);
dev->cpu =3D cpu;
cpuidle_register_device(dev);

Note cpuidle_dev is exported via cpuidle.h, so you don't have to=20
redeclare a per cpu cpuidle device by your own.

So rephrasing all that:

(1) in cpuidle-qcom register the driver
(2) in the spm code register the device for each spm probe

(1) being called before (2).

If after that in the code you still have a "static bool=20
cpuidle_drv_init", then I guess we have a problem in the init sequence=20
somewhere else.

> void cpuidle_update_cpumask(struct cpumask *mask) {
>         struct cpuidle_driver *drv;
>
>         spin_lock(&cpuidle_driver_lock);
>         drv =3D cpuidle_get_driver();
>      if (drv)
>          drv->cpumask =3D mask ?: cpu_possible_mask;
>         spin_unlock(&cpuidle_driver_lock);
> }
>
> With that, I could register cpuidle driver the first time when the ma=
sk
> changes
> from empty and consequent updates would just update the cpumask. (I a=
m not
> sure, if I missed anything in this change). It just seemed far too
> invasive at
> this time, in lieu of the static bool.
>
>>> +    const struct platform_device_info qcom_cpuidle_info =3D {
>>> +        .name    =3D "qcom_cpuidle",
>>> +        .id    =3D -1,
>>> +        .data =3D &lpm_ops,
>>> +        .size_data =3D sizeof(lpm_ops),
>>> +    };
>>> +
>>> +    drv =3D spm_get_drv(pdev, &cpu);
>>> +    if (!drv || cpu < 0)
>>> +        return -EINVAL;
>>
>> As already said in a previous comment, it is not possible to have "c=
pu
>> < 0" with "drv !=3D NULL", so except I am missing something the test
>> should be:
>>
>>     if (!drv)
>>         return -EINVAL;
>>
> Sorry, done.
>
>> There is something wrong with the init sequence. Don't you find weir=
d
>> you have to backward search for the cpu belonging to the pdev each
>> time the probe function is called ?
>>
>>
> Well, it was that or the SPM device node pointing to the CPU that it
> references. It seems more common to have an iterator than the doubly
> linked device nodes. I dont have a strong preference either way, just
> chose the way that made device nodes easier.
>
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
>>> +
>>> +    /* Write the SPM sequences first.. */
>>> +    addr =3D drv->reg_base +
>>> drv->reg_data->reg_offset[SPM_REG_SEQ_ENTRY];
>>> +    __iowrite32_copy(addr, drv->reg_data->seq,
>>> +            ARRAY_SIZE(drv->reg_data->seq) / 4);
>>> +
>>> +    /*
>>> +     * ..and then the control registers.
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
>>> +    /*
>>> +     * Ensure all observers see the above register writes before t=
he
>>> +     * cpuidle driver is allowed to use the SPM.
>>> +     */
>>> +    wmb();
>>> +    per_cpu(cpu_spm_drv, cpu) =3D drv;
>>> +
>>> +    if (!cpuidle_drv_init) {
>>> +        platform_device_register_full(&qcom_cpuidle_info);
>>> +        cpuidle_drv_init =3D true;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static struct platform_driver spm_driver =3D {
>>> +    .probe =3D spm_dev_probe,
>>> +    .driver =3D {
>>> +        .name =3D "saw",
>>> +        .of_match_table =3D spm_match_table,
>>> +    },
>>> +};
>>> +
>>> +module_platform_driver(spm_driver);
>>> +
>>> +MODULE_LICENSE("GPL v2");
>>> +MODULE_DESCRIPTION("SAW power controller driver");
>>> +MODULE_ALIAS("platform:saw");
>>> diff --git a/include/soc/qcom/pm.h b/include/soc/qcom/pm.h
>>> new file mode 100644
>>> index 0000000..d9a56d7
>>> --- /dev/null
>>> +++ b/include/soc/qcom/pm.h
>>> @@ -0,0 +1,31 @@
>>> +/*
>>> + * Copyright (c) 2009-2014, The Linux Foundation. All rights reser=
ved.
>>> + *
>>> + * This software is licensed under the terms of the GNU General Pu=
blic
>>> + * License version 2, as published by the Free Software Foundation=
, and
>>> + * may be copied, distributed, and modified under those terms.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + * GNU General Public License for more details.
>>> + *
>>> + */
>>> +
>>> +#ifndef __QCOM_PM_H
>>> +#define __QCOM_PM_H
>>> +
>>> +enum pm_sleep_mode {
>>> +    PM_SLEEP_MODE_STBY,
>>> +    PM_SLEEP_MODE_RET,
>>> +    PM_SLEEP_MODE_SPC,
>>> +    PM_SLEEP_MODE_PC,
>>> +    PM_SLEEP_MODE_NR,
>>> +};
>>> +
>>> +struct qcom_cpu_pm_ops {
>>> +    int (*standby)(void *data);
>>> +    int (*spc)(void *data);
>>> +};
>>> +
>>> +#endif  /* __QCOM_PM_H */
>>>
>>
>>
>> --
>> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software f=
or ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog
>>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
