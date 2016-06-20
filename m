From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v9 2/4] power: reset: add reboot mode driver
Date: Mon, 20 Jun 2016 14:31:43 +0200
Message-ID: <5767E22F.5030207@samsung.com>
References: <1466404490-3315-1-git-send-email-andy.yan@rock-chips.com>
 <1466404696-3464-1-git-send-email-andy.yan@rock-chips.com>
 <5767A4C0.3080902@samsung.com> <5767A92E.5040602@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:44787 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526AbcFTMnW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jun 2016 08:43:22 -0400
In-reply-to: <5767A92E.5040602@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Yan <andy.yan@rock-chips.com>, robh+dt@kernel.org, heiko@sntech.de, john.stultz@linaro.org, arnd@arndb.de, bjorn.andersson@linaro.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alexandre.belloni@free-electrons.com, dbaryshkov@gmail.com, sre@kernel.org, matthias.bgg@gmail.com, linux-pm@vger.kernel.org, mbrugger@suse.com, lorenzo.pieralisi@arm.com, moritz.fischer@ettus.com, richard@nod.at, Paul Gortmaker <paul.gortmaker@windriver.com>

On 06/20/2016 10:28 AM, Andy Yan wrote:
> Hi Krzysztof:
>=20
> On 2016=E5=B9=B406=E6=9C=8820=E6=97=A5 16:09, Krzysztof Kozlowski wro=
te:
>> On 06/20/2016 08:38 AM, Andy Yan wrote:
>>> This driver parses the reboot commands like "reboot bootloader"
>>> and "reboot recovery" to get a boot mode described in the
>>> device tree , then call the write interfae to store the boot
>>> mode in some place like special register or sram, which can
>>> be read by the bootloader after system reboot, then the bootloader
>>> can take different action according to the mode stored.
>>>
>>> This is commonly used on Android based devices, in order to
>>> reboot the device into fastboot or recovery mode.
>>>
>>> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
>>> Reviewed-by: Moritz Fischer <moritz.fischer@ettus.com>
>>> Tested-by: John Stultz <john.stultz@linaro.org>
>>> Acked-by: John Stultz <john.stultz@linaro.org>
>>> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
>>>
>>> ---
>>>
>>> Changes in v9:
>>> - select MFD_SYSCON when syscon-reboot-mode driver enabled
>>> - refactoring error handling in reboot_mode_register
>>>
>>> Changes in v8:
>>> - do some cleanup when driver ubind
>>>
>>> Changes in v7:
>>> - address some suggestions from Krzysztof, make syscon-reboot-mode
>>> driver data self-contained.
>>>
>>> Changes in v6: None
>>> Changes in v5:
>>> - use two blank space under help in Kconfig
>>> - use unsigned int instead of int for member magic in struct mode_i=
nfo
>>>
>>> Changes in v4:
>>> - make this driver depends on OF to avoid kbuild test error
>>>
>>> Changes in v3:
>>> - scan multi properities
>>> - add mask value for some platform which only use some bits of the
>>> register
>>>    to store boot mode magic value
>>>
>>> Changes in v2:
>>> - move to dir drivers/power/reset/
>>> - make syscon-reboot-mode a generic driver
>>>
>>> Changes in v1:
>>> - fix the embarrassed compile warning
>>> - correct the maskrom magic number
>>> - check for the normal reboot
>>>
>>>   drivers/power/reset/Kconfig              |  14 ++++
>>>   drivers/power/reset/Makefile             |   2 +
>>>   drivers/power/reset/reboot-mode.c        | 128
>>> +++++++++++++++++++++++++++++++
>>>   drivers/power/reset/reboot-mode.h        |  14 ++++
>>>   drivers/power/reset/syscon-reboot-mode.c | 100
>>> ++++++++++++++++++++++++
>>>   5 files changed, 258 insertions(+)
>>>   create mode 100644 drivers/power/reset/reboot-mode.c
>>>   create mode 100644 drivers/power/reset/reboot-mode.h
>>>   create mode 100644 drivers/power/reset/syscon-reboot-mode.c
>>>
>>> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kcon=
fig
>>> index 9bb2622..4ceaf74 100644
>>> --- a/drivers/power/reset/Kconfig
>>> +++ b/drivers/power/reset/Kconfig
>>> @@ -183,5 +183,19 @@ config POWER_RESET_ZX
>>>       help
>>>         Reboot support for ZTE SoCs.
>>>   +config REBOOT_MODE
>>> +    tristate
>>> +
>>> +config SYSCON_REBOOT_MODE
>>> +    bool "Generic SYSCON regmap reboot mode driver"
>> Why not tristate?
>=20
>    I see many reset drivers in this directories  use bool, so I follo=
w
> them.

+Cc Paul,

I don't mind that although I don't see any particular objections for
making it module-capable. In the same time I just reminded myself about
Paul Gortmaker's long effort (like [1] [2]) about removing module
capability from non-modular drivers.

=46ollowing his rationale, I think either this should be a tristate or =
the
module stuff should be removed.

Best regards,
Krzysztof

[1] https://lkml.org/lkml/2016/2/21/180
[2] https://lkml.org/lkml/2016/6/13/682


