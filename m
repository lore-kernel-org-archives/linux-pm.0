From: Beomho Seo <beomho.seo@samsung.com>
Subject: Re: [PATCH 1/3] power: max17042_battery: Use reg type instead of chip
 type
Date: Wed, 01 Apr 2015 18:00:44 +0900
Message-ID: <551BB3BC.8030501@samsung.com>
References: <1427808574-19397-1-git-send-email-beomho.seo@samsung.com>
 <1427808574-19397-2-git-send-email-beomho.seo@samsung.com>
 <CAJKOXPdM1zt_y19Lv8Q6PPLzhOJSw3JaLRgi=ziaNsg0p=-ieg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:27961 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbbDAJAr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Apr 2015 05:00:47 -0400
In-reply-to: <CAJKOXPdM1zt_y19Lv8Q6PPLzhOJSw3JaLRgi=ziaNsg0p=-ieg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: linux-kernel@vger.kernel.org, cw00.choi@samsung.com, sangbae90.lee@samsung.com, inki.dae@samsung.com, linux-pm@vger.kernel.org, myungjoo.ham@samsung.com, Sebastian Reichel <sre@kernel.org>, jonghwa3.lee@samsung.comlinux-pm@vger.kernel.org, beomho.seo@samsung.com

On 04/01/2015 05:18 PM, Krzysztof Kozlowski wrote:
> 2015-03-31 15:29 GMT+02:00 Beomho Seo <beomho.seo@samsung.com>:
>> Currently, max17042 battery driver choose register map by MAX17042_DevName
>> register. But thid register is return IC specific firmware version. So other
>> maxim chip hard to use this drvier. This patch choose reg_type by driver_data.
> 
> I don't quite get the concept of "reg_type" and why it replaces chip
> type? It seems that you choose reg_type based on given chip type so
> there is direct mapping chip_type->reg_type. If max17047 and max17050
> are the same from the point of view of interface (registers) then they
> should use the same compatible or the same device type. Something
> like:
> 

When I check datasheet, MAX17042_DevName register return Firmware version.
Firmware version not chip type. For use other maxim chip, be better use
of_id->data or id->driver_data(be like other maxim mfd driver)

I will remove reg_type. and chip_type will be assigned through
of_id->data or id->driver_data.

>>  static const struct i2c_device_id max17042_id[] = {
>> -       { "max17042", 0 },
>> -       { "max17047", 1 },
>> -       { "max17050", 2 },
>> +       { "max17042", MAXIM_DEVICE_TYPE_MAX17042 },
>> +       { "max17047", MAXIM_DEVICE_TYPE_MAX17047 },
>> +       { "max17050", MAXIM_DEVICE_TYPE_MAX17047 }, /* Same as 17047 */
>>         { }
> 
> So why you are adding the conversion from i2c_device_id -> reg_type?
> 
> Beside that, thanks for integrating this into existing driver! Much appreciated.
> 
> Best regards,
> Krzysztof
> 

Best regards,
Beomho

