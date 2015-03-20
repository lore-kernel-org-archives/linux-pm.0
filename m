From: kongxinwei <kong.kongxinwei@hisilicon.com>
Subject: Re: [PATCH 1/3] thermal: hisilicon: add new hisilicon thermal sensor
 driver
Date: Fri, 20 Mar 2015 15:37:24 +0800
Message-ID: <550BCE34.9010904@hisilicon.com>
References: <1426751849-10604-1-git-send-email-kong.kongxinwei@hisilicon.com> <1426751849-10604-2-git-send-email-kong.kongxinwei@hisilicon.com> <20150319141753.GB25967@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150319141753.GB25967@leverpostej>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "rui.zhuang@intel.com" <rui.zhuang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linuxarm@huawei.com" <linuxarm@huawei.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "liguozhu@hisilicon.com" <liguozhu@hisilicon.com>, "xuwei5@hisilicon.com" <xuwei5@hisilicon.com>
List-Id: linux-pm@vger.kernel.org



=E5=9C=A8 2015/3/19 22:17, Mark Rutland =E5=86=99=E9=81=93:
> On Thu, Mar 19, 2015 at 07:57:27AM +0000, kongxinwei wrote:
>> This patch adds the support for hisilicon thermal sensor, within
>> hisilicon SoC. there will register sensors for thermal framework
>> and use device tree to bind cooling device.
>>
>> Signed-off-by: Leo Yan <leo.yan@linaro.org>
>> Signed-off-by: kongxinwei <kong.kongxinwei@hisilicon.com>
>> ---
>>  drivers/thermal/Kconfig        |   8 +
>>  drivers/thermal/Makefile       |   1 +
>>  drivers/thermal/hisi_thermal.c | 531 ++++++++++++++++++++++++++++++=
+++++++++++
>>  3 files changed, 540 insertions(+)
>>  create mode 100644 drivers/thermal/hisi_thermal.c
>=20
> [...]
>=20
>> +       ret =3D of_property_read_u32(np, "hisilicon,tsensor-lag-valu=
e",
>> +                                  &sensor->lag);
>=20
> This wasn't in the binding.
>=20

good comment, delete it.

Xinwei

> [...]
>=20
>> +       ret =3D of_property_read_u32(np, "hisilicon,tsensor-thres-te=
mp",
>> +                                  &sensor->thres_temp);
>> +       if (ret) {
>> +               dev_err(&pdev->dev, "failed to get thres value %d: %=
d\n",
>> +                       index, ret);
>> +               return ret;
>> +       }
>> +
>> +       ret =3D of_property_read_u32(np, "hisilicon,tsensor-reset-te=
mp",
>> +                                  &sensor->reset_temp);
>> +       if (ret) {
>> +               dev_err(&pdev->dev, "failed to get reset value %d: %=
d\n",
>> +                       index, ret);
>> +               return ret;
>> +       }
>=20
> I see now that these properties result in the HW being programmed. Yo=
u
> should figure out how to reconcile these with thermal-zone trip point=
s
> rather than having parallel properties.
>=20
oh,firstly,this "tsensor-thres-temp" property is threshold temperature =
value
which causes interrupt function by setting thermal value register. "the=
rmal
-zone trip points" applies scanning mode to cause other function such a=
s
cooling freq .., but this "tsensor-thres-temp" property be used by inte=
rrupt
mode. when scanning mode don't satisfies systerm demands, the interrut =
mode
perfectly help scanning mode to complete function. "tsensor-thres-temp"=
 temp-
erature is higher than "thermal-zone trip points" temperature, so this =
"
tsensor-thres-temp" property is secondary attribute.

secondly, this "tsensor-reset-temp" property is hardware protect temper=
ature
which is close to or is below to burn out the SoC. When SoC temperature=
 is
"tsensor-reset-temp" temperature value, SoC will be force to reboot and=
 ensure
SoC not to burn out. So it don't conflict thermal-zone.


>> +
>> +       if (of_property_read_bool(np, "hisilicon,tsensor-bind-irq"))=
 {
>> +
>> +               if (data->irq_bind_sensor !=3D -1)
>> +                       dev_warn(&pdev->dev, "irq has bound to index=
 %d\n",
>> +                                data->irq_bind_sensor);
>> +
>> +               /* bind irq to this sensor */
>> +               data->irq_bind_sensor =3D index;
>> +       }
>=20
> I don't see why this should be specified in the DT. Why do you believ=
e
> it should?
>=20
SoC include foure thermal sensor modules,every modules is able to cause
interrupt,so binding a module to realize interupt function and i believ=
e
it should be specified.
> [...]
>=20
>> +static int hisi_thermal_probe(struct platform_device *pdev)
>> +{
>> +       struct hisi_thermal_data *data;
>> +       struct resource *res;
>> +       int i;
>> +       int ret;
>> +
>> +       if (!cpufreq_get_current_driver()) {
>> +               dev_dbg(&pdev->dev, "no cpufreq driver!");
>> +               return -EPROBE_DEFER;
>> +       }
>=20
> Surely we care about not burning out the board even if we don't have
> cpufreq?
>=20
> Is there any ordering guarantee between the probing of this driver an=
d
> cpufreq?
>=20
>=20
Yes! It will use thermal framework to realize cpu cooling device functi=
on.

> [...]
>=20
>> +       data->clk =3D devm_clk_get(&pdev->dev, NULL);
>=20
> You gave this clock a name in the binding. Use it or drop it.
>

Thanks comment,use it.

> Mark.=20
>=20

Xinwei
> .
>=20
