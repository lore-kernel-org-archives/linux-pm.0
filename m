From: Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH v9 2/4] power: reset: add reboot mode driver
Date: Mon, 20 Jun 2016 16:28:30 +0800
Message-ID: <5767A92E.5040602@rock-chips.com>
References: <1466404490-3315-1-git-send-email-andy.yan@rock-chips.com>
 <1466404696-3464-1-git-send-email-andy.yan@rock-chips.com>
 <5767A4C0.3080902@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5767A4C0.3080902@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, robh+dt@kernel.org, heiko@sntech.de, john.stultz@linaro.org, arnd@arndb.de, bjorn.andersson@linaro.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alexandre.belloni@free-electrons.com, dbaryshkov@gmail.com, sre@kernel.org, matthias.bgg@gmail.com, linux-pm@vger.kernel.org, mbrugger@suse.com, lorenzo.pieralisi@arm.com, moritz.fischer@ettus.com, richard@nod.at
List-Id: linux-pm@vger.kernel.org

Hi Krzysztof:

On 2016=E5=B9=B406=E6=9C=8820=E6=97=A5 16:09, Krzysztof Kozlowski wrote=
:
> On 06/20/2016 08:38 AM, Andy Yan wrote:
>> This driver parses the reboot commands like "reboot bootloader"
>> and "reboot recovery" to get a boot mode described in the
>> device tree , then call the write interfae to store the boot
>> mode in some place like special register or sram, which can
>> be read by the bootloader after system reboot, then the bootloader
>> can take different action according to the mode stored.
>>
>> This is commonly used on Android based devices, in order to
>> reboot the device into fastboot or recovery mode.
>>
>> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
>> Reviewed-by: Moritz Fischer <moritz.fischer@ettus.com>
>> Tested-by: John Stultz <john.stultz@linaro.org>
>> Acked-by: John Stultz <john.stultz@linaro.org>
>> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
>>
>> ---
>>
>> Changes in v9:
>> - select MFD_SYSCON when syscon-reboot-mode driver enabled
>> - refactoring error handling in reboot_mode_register
>>
>> Changes in v8:
>> - do some cleanup when driver ubind
>>
>> Changes in v7:
>> - address some suggestions from Krzysztof, make syscon-reboot-mode d=
river data self-contained.
>>
>> Changes in v6: None
>> Changes in v5:
>> - use two blank space under help in Kconfig
>> - use unsigned int instead of int for member magic in struct mode_in=
fo
>>
>> Changes in v4:
>> - make this driver depends on OF to avoid kbuild test error
>>
>> Changes in v3:
>> - scan multi properities
>> - add mask value for some platform which only use some bits of the r=
egister
>>    to store boot mode magic value
>>
>> Changes in v2:
>> - move to dir drivers/power/reset/
>> - make syscon-reboot-mode a generic driver
>>
>> Changes in v1:
>> - fix the embarrassed compile warning
>> - correct the maskrom magic number
>> - check for the normal reboot
>>
>>   drivers/power/reset/Kconfig              |  14 ++++
>>   drivers/power/reset/Makefile             |   2 +
>>   drivers/power/reset/reboot-mode.c        | 128 +++++++++++++++++++=
++++++++++++
>>   drivers/power/reset/reboot-mode.h        |  14 ++++
>>   drivers/power/reset/syscon-reboot-mode.c | 100 +++++++++++++++++++=
+++++
>>   5 files changed, 258 insertions(+)
>>   create mode 100644 drivers/power/reset/reboot-mode.c
>>   create mode 100644 drivers/power/reset/reboot-mode.h
>>   create mode 100644 drivers/power/reset/syscon-reboot-mode.c
>>
>> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconf=
ig
>> index 9bb2622..4ceaf74 100644
>> --- a/drivers/power/reset/Kconfig
>> +++ b/drivers/power/reset/Kconfig
>> @@ -183,5 +183,19 @@ config POWER_RESET_ZX
>>   	help
>>   	  Reboot support for ZTE SoCs.
>>  =20
>> +config REBOOT_MODE
>> +	tristate
>> +
>> +config SYSCON_REBOOT_MODE
>> +	bool "Generic SYSCON regmap reboot mode driver"
> Why not tristate?

    I see many reset drivers in this directories  use bool, so I follow=
=20
them.
>
> Beside that the patch looks good.
>
> Best regards,
> Krzysztof
>
>> +	depends on OF
>> +	select REBOOT_MODE
>> +	select MFD_SYSCON
>> +	help
>> +	  Say y here will enable reboot mode driver. This will
>> +	  get reboot mode arguments and store it in SYSCON mapped
>> +	  register, then the bootloader can read it to take different
>> +	  action according to the mode.
>> +
>
>
>
