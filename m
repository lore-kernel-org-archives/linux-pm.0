From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 16/22] mfd: axp20x: add V_OFF to writeable regs for AXP20X
 and AXP22X
Date: Thu, 5 Jan 2017 14:02:40 +0800
Message-ID: <CAGb2v675_bbceTt0Jh++t-HeWfNqn=f4Pjf-HjbZvWvKkLtrdQ@mail.gmail.com>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-17-quentin.schulz@free-electrons.com> <20170104115731.GF24058@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:35476 "EHLO
        smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030666AbdAEGDG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Jan 2017 01:03:06 -0500
In-Reply-To: <20170104115731.GF24058@dell>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>, Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, Sebastian Reichel <sre@kernel.org>, Russell King <linux@armlinux.org.uk>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-iio@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Icenowy Zheng <icenowy@aosc.xyz>, =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-v>

On Wed, Jan 4, 2017 at 7:57 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Mon, 02 Jan 2017, Quentin Schulz wrote:
>
>> The V_OFF register has its first 3 read-write bits for the minimal
>> voltage (Voff) of the battery before the system is automatically shut
>> down due to the power being too low.
>>
>> This adds V_OFF register to the writeable registers of AXP20X and AXP22X
>> PMICs.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>> ---
>>  drivers/mfd/axp20x.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> For my own reference:
>   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>

>
>> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
>> index 19bdba3..7f0f05f 100644
>> --- a/drivers/mfd/axp20x.c
>> +++ b/drivers/mfd/axp20x.c
>> @@ -65,7 +65,7 @@ static const struct regmap_access_table axp152_volatile_table = {
>>
>>  static const struct regmap_range axp20x_writeable_ranges[] = {
>>       regmap_reg_range(AXP20X_DATACACHE(0), AXP20X_IRQ5_STATE),
>> -     regmap_reg_range(AXP20X_VBUS_IPSOUT_MGMT, AXP20X_VBUS_IPSOUT_MGMT),
>> +     regmap_reg_range(AXP20X_VBUS_IPSOUT_MGMT, AXP20X_V_OFF),
>>       regmap_reg_range(AXP20X_CHRG_CTRL1, AXP20X_CHRG_CTRL1),
>>       regmap_reg_range(AXP20X_DCDC_MODE, AXP20X_FG_RES),
>>       regmap_reg_range(AXP20X_RDC_H, AXP20X_OCV(AXP20X_OCV_MAX)),
>> @@ -94,7 +94,7 @@ static const struct regmap_access_table axp20x_volatile_table = {
>>  /* AXP22x ranges are shared with the AXP809, as they cover the same range */
>>  static const struct regmap_range axp22x_writeable_ranges[] = {
>>       regmap_reg_range(AXP20X_DATACACHE(0), AXP20X_IRQ5_STATE),
>> -     regmap_reg_range(AXP20X_VBUS_IPSOUT_MGMT, AXP20X_VBUS_IPSOUT_MGMT),
>> +     regmap_reg_range(AXP20X_VBUS_IPSOUT_MGMT, AXP20X_V_OFF),
>>       regmap_reg_range(AXP20X_CHRG_CTRL1, AXP20X_CHRG_CTRL1),
>>       regmap_reg_range(AXP20X_DCDC_MODE, AXP22X_BATLOW_THRES1),
>>  };
>
> --
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
