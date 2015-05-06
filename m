From: =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>
Subject: Re: [PATCH v3] power_supply: Add support for Richtek rt9455 battery charger
Date: Wed, 6 May 2015 21:10:28 +0900
Message-ID: <CAJKOXPdnmvNXUyt31NfXK8AAY1VCyz=2oPXCu9qdcfw3sHS7tA@mail.gmail.com>
References: <1430843530-26252-1-git-send-email-anda-maria.nicolae@intel.com>
	<20150506114003.GM10973@lpalcu-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vn0-f53.google.com ([209.85.216.53]:35158 "EHLO
	mail-vn0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697AbbEFMK3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 May 2015 08:10:29 -0400
In-Reply-To: <20150506114003.GM10973@lpalcu-linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laurentiu Palcu <laurentiu.palcu@intel.com>
Cc: Anda-Maria Nicolae <anda-maria.nicolae@intel.com>, sre@kernel.org, dbaryshkov@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

2015-05-06 20:40 GMT+09:00 Laurentiu Palcu <laurentiu.palcu@intel.com>:
> On Tue, May 05, 2015 at 07:32:10PM +0300, Anda-Maria Nicolae wrote:
>> +static int rt9455_probe(struct i2c_client *client,
>> +                     const struct i2c_device_id *id)
>> +{
>> +     struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
>> +     struct device *dev = &client->dev;
>> +     struct rt9455_info *info;
>> +     struct power_supply_config rt9455_charger_config = {};
>> +     /* mandatory device-specific data values */
>> +     u32 ichrg, ieoc_percentage, voreg;
>> +     /* optional device-specific data values */
>> +     u32 mivr = -1, iaicr = -1;
>> +     int i, ret;
>> +
>> +     if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
>> +             dev_err(dev, "No support for SMBUS_BYTE_DATA\n");
>> +             return -ENODEV;
>> +     }
>> +     info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
>> +     if (!info)
>> +             return -ENOMEM;
>> +
>> +     info->client = client;
>> +     i2c_set_clientdata(client, info);
>> +
>> +     info->regmap = devm_regmap_init_i2c(client,
>> +                                         &rt9455_regmap_config);
>> +     if (IS_ERR(info->regmap)) {
>> +             dev_err(dev, "Failed to initialize register map\n");
>> +             return -EINVAL;
>> +     }
>> +
>> +     for (i = 0; i < F_MAX_FIELDS; i++) {
>> +             info->regmap_fields[i] =
>> +                     devm_regmap_field_alloc(dev, info->regmap,
>> +                                             rt9455_reg_fields[i]);
>> +             if (IS_ERR(info->regmap_fields[i])) {
>> +                     dev_err(dev,
>> +                             "Failed to allocate regmap field = %d\n", i);
>> +                     return PTR_ERR(info->regmap_fields[i]);
>> +             }
>> +     }
>> +
>> +     ret = rt9455_discover_charger(info, &ichrg, &ieoc_percentage,
>> +                                   &voreg, &mivr, &iaicr);
>> +     if (ret) {
>> +             dev_err(dev, "Failed to discover charger\n");
>> +             return ret;
>> +     }
>> +
>> +#if IS_ENABLED(CONFIG_USB_PHY)
>> +     info->usb_phy = usb_get_phy(USB_PHY_TYPE_USB2);
> If you used devm_usb_get_phy() you wouldn't have to worry about
> releasing usb_phy(as Krzysztof suggested in the previous mail). It's up
> to you.

That's a good idea, it would simplify the exit and error paths. But
still usb_unregister_notifier() would be needed.

Best regards,
Krzysztof
