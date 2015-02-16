From: =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>
Subject: Re: [PATCH v3 1/6] mfd: max77843: Add max77843 MFD driver core driver
Date: Mon, 16 Feb 2015 15:02:30 +0100
Message-ID: <CAJKOXPd2ZRcMf-rb+-V-vGQBaFMdmx4DZCX1OMbwwbCaJc+eoQ@mail.gmail.com>
References: <1423025771-4139-1-git-send-email-jaewon02.kim@samsung.com>
	<1423025771-4139-2-git-send-email-jaewon02.kim@samsung.com>
	<20150216135155.GI14545@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vc0-f181.google.com ([209.85.220.181]:54873 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755806AbbBPOCb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Feb 2015 09:02:31 -0500
In-Reply-To: <20150216135155.GI14545@x1>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Jaewon Kim <jaewon02.kim@samsung.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Inki Dae <inki.dae@samsung.com>, SangBae Lee <sangbae90.lee@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, Mark Brown <broonie@kernel.org>, Beomho Seo <beomho.seo@samsung.com>

2015-02-16 14:51 GMT+01:00 Lee Jones <lee.jones@linaro.org>:
> On Wed, 04 Feb 2015, Jaewon Kim wrote:
>
>> This patch adds MAX77843 core/irq driver to support PMIC,
>> MUIC(Micro USB Interface Controller), Charger, Fuel Gauge,
>> LED and Haptic device.
>>
>> Cc: Lee Jones <lee.jones@linaro.org>
>> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
>> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
>> ---
>>  drivers/mfd/Kconfig                  |   14 ++
>>  drivers/mfd/Makefile                 |    1 +
>>  drivers/mfd/max77843.c               |  245 +++++++++++++++++++
>>  include/linux/mfd/max77843-private.h |  441 ++++++++++++++++++++++++++++++++++
>>  4 files changed, 701 insertions(+)
>>  create mode 100644 drivers/mfd/max77843.c
>>  create mode 100644 include/linux/mfd/max77843-private.h
>>
>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index 2e6b731..0c67c79 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -442,6 +442,20 @@ config MFD_MAX77693
>>         additional drivers must be enabled in order to use the functionality
>>         of the device.
>>
>> +config MFD_MAX77843
>> +     bool "Maxim Semiconductor MAX77843 PMIC Support"
>> +     depends on I2C=y
>> +     select MFD_CORE
>> +     select REGMAP_I2C
>> +     select REGMAP_IRQ
>> +     help
>> +       Say yes here to add support for Maxim Semiconductor MAX77843.
>> +       This is companion Power Management IC with LEDs, Haptic, Charger,
>> +       Fuel Gauge, MUIC(Micro USB Interface Controller) controls on chip.
>> +       This driver provides common support for accessing the device;
>> +       additional drivers must be enabled in order to use the functionality
>> +       of the device.
>> +
>>  config MFD_MAX8907
>>       tristate "Maxim Semiconductor MAX8907 PMIC Support"
>>       select MFD_CORE
>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>> index 53467e2..fe4f75c 100644
>> --- a/drivers/mfd/Makefile
>> +++ b/drivers/mfd/Makefile
>> @@ -117,6 +117,7 @@ obj-$(CONFIG_MFD_DA9063)  += da9063.o
>>  obj-$(CONFIG_MFD_MAX14577)   += max14577.o
>>  obj-$(CONFIG_MFD_MAX77686)   += max77686.o
>>  obj-$(CONFIG_MFD_MAX77693)   += max77693.o
>> +obj-$(CONFIG_MFD_MAX77843)   += max77843.o
>
> This is the 11th MAX driver.  Can't they be supported using device
> specific data structures instead of taking a 'one file per device'
> approach?

We did this for max14577+max77836 and max77686+max77802.  I didn't see
the specs of max77843 but I think in many cases other and newer
drivers could be merged. Someone needs to advocate for this...

Best regards,
Krzysztof
