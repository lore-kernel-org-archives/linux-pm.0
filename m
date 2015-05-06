From: Anda-Maria Nicolae <anda-maria.nicolae@intel.com>
Subject: Re: [PATCH v3] power_supply: Add support for Richtek rt9455 battery
 charger
Date: Wed, 06 May 2015 19:02:32 +0300
Message-ID: <554A3B18.7050401@intel.com>
References: <1430843530-26252-1-git-send-email-anda-maria.nicolae@intel.com> <CAJKOXPfu-O8XnbYjjn4hz0EGpN1R2afeS1Fjvhb4XDjQof0iXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:29305 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750698AbbEFQAH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 6 May 2015 12:00:07 -0400
In-Reply-To: <CAJKOXPfu-O8XnbYjjn4hz0EGpN1R2afeS1Fjvhb4XDjQof0iXA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?B?S3J6eXN6dG9mIEtvesWCb3dza2k=?= <k.kozlowski.k@gmail.com>
Cc: sre@kernel.org, dbaryshkov@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org


On 05/06/2015 10:58 AM, Krzysztof Koz=C5=82owski wrote:
> 2015-05-06 1:32 GMT+09:00 Anda-Maria Nicolae <anda-maria.nicolae@inte=
l.com>:
>> Based on the datasheet found here:
>> http://www.richtek.com/download_ds.jsp?p=3DRT9455
>>
>> Signed-off-by: Anda-Maria Nicolae <anda-maria.nicolae@intel.com>
>> ---
>>
>> Updates from v2 version:
>> - removed unused masks and keep the used ones. I have tried to acces=
s mask field
>> from struct regmap_field, but I have received the following compilat=
ion error:
>> "dereferencing pointer to incomplete type". I think this happens bec=
ause I include
>> the file include/linux/regmap.h and in this file struct regmap_field=
 is only declared
>> and not defined. Struct regmap_field is defined in drivers/base/regm=
ap/internal.h.
>> If I include this file, compilation works. But I do not think it is =
a good idea
>> to include it; I did not find any other driver which includes this f=
ile. I also
>> could not find any driver that accesses mask field from struct regma=
p_field.
>> For instance, drivers/pwm/pwm-sti.c at lines 157, 158, also uses mas=
ks.
>>
>> - I have also kept REG_FIELD definitions for interrupt registers, si=
nce, for instance,
>> I use F_BATAB to check battery presence property.
>>
>> - cached regs 0x05 and 0x06. Also, I have added rt9455_is_writeable_=
reg function
>> for writeable_reg field of regmap_config.
>>
>> - used POWER_STATUS_DISCHARGING, replaced break with and replaced it=
 with return and
>> indented it correctly. I spent some time on this and I finally under=
stood what is happening.
>> So, if PWR_RDY bit is set, but STAT bits value is 0, the charger may=
 be in one
>> of the following cases:
>> 1. CHG_EN bit is 0.
>> 2. CHG_EN bit is 1 but the battery is not connected.
>> In any of these cases, POWER_SUPPLY_STATUS_NOT_CHARGING is returned.
>> If the PWR_RDY bit is cleared, POWER_SUPPLY_STATUS_DISCHARGING is re=
turned.
>>
>> - used VOREG bits value instead of VMREG in functions rt9455_charger=
_get_voltage_max()/
>> rt9455_charger_set_voltage_max(). Although RT9455 charger has VMREG =
bits which,
>> according to the datasheet, represent "Maximum battery regulation vo=
ltage", the
>> charger never uses VMREG value as maximum threshold for battery volt=
age. This
>> happens because TE and TE_SHDN_EN bits are set during rt9455_probe()=
, and charging
>> operation is terminated when charging current is less than ICHRG x I=
EOC. When charging
>> operation is terminated, battery voltage is almost equal to VOREG. T=
herefore,
>> VMREG value is not taken into account. This is the reason why VOREG =
value is
>> set/returned in these functions.
>>
>> - corrected comment from rt9455_usb_event_id() function.
>>
>> - replaced IS_ERR_OR_NULL() with IS_ERR() to check the result of usb=
_get_phy()
>> function. Also, if usb_register_notifier() fails, since usb_put_phy(=
) is immediately
>> called, I have set info->usb_phy to ERR_PTR(-ENODEV) so that in rt94=
55_remove()
>> usb_put_phy is not mistakenly called again.
>>
>>   .../devicetree/bindings/power/rt9455_charger.txt   |   43 +
>>   .../devicetree/bindings/vendor-prefixes.txt        |    1 +
>>   drivers/power/Kconfig                              |    6 +
>>   drivers/power/Makefile                             |    1 +
>>   drivers/power/rt9455_charger.c                     | 1801 ++++++++=
++++++++++++
>>   5 files changed, 1852 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/power/rt9455_=
charger.txt
>>   create mode 100644 drivers/power/rt9455_charger.c
>>
>> diff --git a/Documentation/devicetree/bindings/power/rt9455_charger.=
txt b/Documentation/devicetree/bindings/power/rt9455_charger.txt
>> new file mode 100644
>> index 0000000..7e8aed6
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/rt9455_charger.txt
>> @@ -0,0 +1,43 @@
>> +Binding for Richtek rt9455 battery charger
>> +
>> +Required properties:
>> +- compatible: Should contain one of the following:
>> + * "richtek,rt9455"
>> +
>> +- reg:                                 integer, i2c address of the =
device.
>> +- richtek,output-charge-current:       integer, output current from=
 the charger to the
>> +                                       battery, in uA.
>> +- richtek,end-of-charge-percentage:    integer, percent of the outp=
ut charge current.
>> +                                       When the current in constant=
-voltage phase drops
>> +                                       below output_charge_current =
x end-of-charge-percentage,
>> +                                       charge is terminated.
>> +- richtek,battery-regulation-voltage:  integer, maximum battery vol=
tage in uV.
>> +
>> +Optional properties:
>> +- richtek,min-input-voltage-regulation: integer, input voltage leve=
l in uA, used to
>> +                                       decrease voltage level when =
the over current
>> +                                       of the input power source oc=
curs.
>> +                                       This prevents input voltage =
drop due to insufficient
>> +                                       current provided by the powe=
r source.
>> +- richtek,avg-input-current-regulation: integer, input current valu=
e drained by the
>> +                                       charger from the power sourc=
e.
>> +
>> +Example:
>> +
>> +rt9455@22 {
>> +       compatible =3D "richtek,rt9455";
>> +       reg =3D <0x22>;
>> +
>> +       interrupt-parent =3D <&gpio1>;
>> +       interrupts =3D <0 1>;
>> +
>> +       interrupt-gpio =3D <&gpio1 0 1>;
>> +       reset-gpio =3D <&gpio1 1 1>;
>> +
>> +       richtek,output-charge-current       =3D <500000>;
>> +       richtek,end-of-charge-percentage    =3D <10>;
>> +       richtek,battery-regulation-voltage  =3D <4200000>;
>> +
>> +       richtek,min-input-voltage-regulation =3D <4500000>;
>> +       richtek,avg-input-current-regulation =3D <500000>;
>> +};
>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b=
/Documentation/devicetree/bindings/vendor-prefixes.txt
>> index 8033919..7b8c129 100644
>> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> @@ -161,6 +161,7 @@ ralink      Mediatek/Ralink Technology Corp.
>>   ramtron        Ramtron International
>>   realtek Realtek Semiconductor Corp.
>>   renesas        Renesas Electronics Corporation
>> +richtek        Richtek Technology Corporation
>>   ricoh  Ricoh Co. Ltd.
>>   rockchip       Fuzhou Rockchip Electronics Co., Ltd
>>   samsung        Samsung Semiconductor
>> diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
>> index 4091fb0..39f208d 100644
>> --- a/drivers/power/Kconfig
>> +++ b/drivers/power/Kconfig
>> @@ -439,6 +439,12 @@ config BATTERY_RT5033
>>            The fuelgauge calculates and determines the battery state=
 of charge
>>            according to battery open circuit voltage.
>>
>> +config CHARGER_RT9455
>> +       tristate "Richtek RT9455 battery charger driver"
>> +       depends on I2C && GPIOLIB
> Laurentiu Palcu pointed already the need of REGMAP_I2C dependency.
> Actually you need to select it.
Will do it.
>
> (...)
>
>> +
>> +static int rt9455_charger_property_is_writeable(struct power_supply=
 *psy,
>> +                                               enum power_supply_pr=
operty psp)
>> +{
>> +       switch (psp) {
>> +       case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
>> +       case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
>> +       case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
>> +               return 1;
>> +       default:
>> +               return 0;
>> +       }
>> +}
> And comments from previous email? Which "numerous charger drivers" ex=
pose these
> properties as writable?
>
Yesterday I run: POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT and drivers=20
were shown. What I did not do was to look in those drivers to see if=20
indeed the property is writeable, or if it is readable.
I agree with removing them from the driver.  I've spent some time to=20
understand them and this is why I did not agree with this in the beginn=
ing.
> (...)
>
>> +static int rt9455_probe(struct i2c_client *client,
>> +                       const struct i2c_device_id *id)
>> +{
>> +       struct i2c_adapter *adapter =3D to_i2c_adapter(client->dev.p=
arent);
>> +       struct device *dev =3D &client->dev;
>> +       struct rt9455_info *info;
>> +       struct power_supply_config rt9455_charger_config =3D {};
>> +       /* mandatory device-specific data values */
>> +       u32 ichrg, ieoc_percentage, voreg;
>> +       /* optional device-specific data values */
>> +       u32 mivr =3D -1, iaicr =3D -1;
>> +       int i, ret;
>> +
>> +       if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DA=
TA)) {
>> +               dev_err(dev, "No support for SMBUS_BYTE_DATA\n");
>> +               return -ENODEV;
>> +       }
>> +       info =3D devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
>> +       if (!info)
>> +               return -ENOMEM;
>> +
>> +       info->client =3D client;
>> +       i2c_set_clientdata(client, info);
>> +
>> +       info->regmap =3D devm_regmap_init_i2c(client,
>> +                                           &rt9455_regmap_config);
>> +       if (IS_ERR(info->regmap)) {
>> +               dev_err(dev, "Failed to initialize register map\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       for (i =3D 0; i < F_MAX_FIELDS; i++) {
>> +               info->regmap_fields[i] =3D
>> +                       devm_regmap_field_alloc(dev, info->regmap,
>> +                                               rt9455_reg_fields[i]=
);
>> +               if (IS_ERR(info->regmap_fields[i])) {
>> +                       dev_err(dev,
>> +                               "Failed to allocate regmap field =3D=
 %d\n", i);
>> +                       return PTR_ERR(info->regmap_fields[i]);
>> +               }
>> +       }
>> +
>> +       ret =3D rt9455_discover_charger(info, &ichrg, &ieoc_percenta=
ge,
>> +                                     &voreg, &mivr, &iaicr);
>> +       if (ret) {
>> +               dev_err(dev, "Failed to discover charger\n");
>> +               return ret;
>> +       }
>> +
>> +#if IS_ENABLED(CONFIG_USB_PHY)
>> +       info->usb_phy =3D usb_get_phy(USB_PHY_TYPE_USB2);
>> +       if (IS_ERR(info->usb_phy)) {
>> +               dev_err(dev, "Failed to get USB transceiver\n");
>> +       } else {
>> +               info->nb.notifier_call =3D rt9455_usb_event;
>> +               ret =3D usb_register_notifier(info->usb_phy, &info->=
nb);
>> +               if (ret) {
>> +                       dev_err(dev, "Failed to register USB notifie=
r\n");
>> +                       usb_put_phy(info->usb_phy);
>> +                       /*
>> +                        * Since usb_put_phy() has been called, info=
->usb_phy is
>> +                        * set to ERR_PTR so that in rt9455_remove()
>> +                        * usb_put_phy() is not mistakenly called ag=
ain.
>> +                        */
>> +                       info->usb_phy =3D ERR_PTR(-ENODEV);
>> +               }
>> +       }
>> +#endif
>> +
>> +       INIT_DEFERRABLE_WORK(&info->pwr_rdy_work, rt9455_pwr_rdy_wor=
k_callback);
>> +       INIT_DEFERRABLE_WORK(&info->max_charging_time_work,
>> +                            rt9455_max_charging_time_work_callback)=
;
>> +       INIT_DEFERRABLE_WORK(&info->batt_presence_work,
>> +                            rt9455_batt_presence_work_callback);
>> +
>> +       rt9455_charger_config.of_node           =3D dev->of_node;
>> +       rt9455_charger_config.drv_data          =3D info;
>> +       rt9455_charger_config.supplied_to       =3D rt9455_charger_s=
upplied_to;
>> +       rt9455_charger_config.num_supplicants   =3D
>> +                                       ARRAY_SIZE(rt9455_charger_su=
pplied_to);
>> +       ret =3D devm_request_threaded_irq(dev, client->irq, NULL,
>> +                                       rt9455_irq_handler_thread,
>> +                                       IRQF_TRIGGER_LOW | IRQF_ONES=
HOT,
>> +                                       RT9455_DRIVER_NAME, info);
>> +       if (ret) {
>> +               dev_err(dev, "Failed to register IRQ handler\n");
> I pointed this 2 times, so maybe third time lucky? I think we
> misunderstood each other. Why are you not cleaning the usb_phy? If
> this fails then you should goto put_usb_phy because now it leaks.
Ok, I understand.
>
>> +               return ret;
>> +       }
>> +
>> +       ret =3D rt9455_hw_init(info, ichrg, ieoc_percentage, voreg, =
mivr, iaicr);
>> +       if (ret) {
>> +               dev_err(dev, "Failed to set charger to its default v=
alues\n");
>> +               return ret;
> Ditto.
Ok, I understand.
> Best regards,
> Krzysztof

