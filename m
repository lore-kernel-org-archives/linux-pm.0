From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: Re: [PATCH v2 02/11] mfd: axp20x: add volatile and writeable reg
 ranges for VBUS power supply driver
Date: Mon, 19 Dec 2016 13:28:11 +0100
Message-ID: <98fa2460-b7fe-3a0b-5b93-7a2e4e6e83ce@free-electrons.com>
References: <20161209110419.28981-1-quentin.schulz@free-electrons.com>
 <20161209110419.28981-3-quentin.schulz@free-electrons.com>
 <CAGb2v66jDsU2rt4d-0ydWR926y-hHTfOBJQmyYVdKd7rcm1WWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:43363 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751192AbcLSM2Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Dec 2016 07:28:16 -0500
In-Reply-To: <CAGb2v66jDsU2rt4d-0ydWR926y-hHTfOBJQmyYVdKd7rcm1WWQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Maxime Ripard <maxime.ripard@free-electrons.com>, Lee Jones <lee.jones@linaro.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Hi Chen-Yu,

On 14/12/2016 16:43, Chen-Yu Tsai wrote:
> On Fri, Dec 9, 2016 at 7:04 PM, Quentin Schulz
> <quentin.schulz@free-electrons.com> wrote:
>> The X-Powers AXP20X and AXP22X PMICs allow to choose the maximum voltage
>> and minimum current delivered by the VBUS power supply.
>>
>> This adds the register used by the VBUS power supply driver to the range
>> of volatile and writeable regs ranges.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>> ---
>>
>> added in v2
>>
>>  drivers/mfd/axp20x.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
>> index ba130be..6ee2cc6 100644
>> --- a/drivers/mfd/axp20x.c
>> +++ b/drivers/mfd/axp20x.c
>> @@ -65,12 +65,14 @@ static const struct regmap_access_table axp152_volatile_table = {
>>
>>  static const struct regmap_range axp20x_writeable_ranges[] = {
>>         regmap_reg_range(AXP20X_DATACACHE(0), AXP20X_IRQ5_STATE),
>> +       regmap_reg_range(AXP20X_VBUS_IPSOUT_MGMT, AXP20X_VBUS_IPSOUT_MGMT),
> 
> This is already covered by the previous entry.
> 
>>         regmap_reg_range(AXP20X_DCDC_MODE, AXP20X_FG_RES),
>>         regmap_reg_range(AXP20X_RDC_H, AXP20X_OCV(AXP20X_OCV_MAX)),
>>  };
>>
>>  static const struct regmap_range axp20x_volatile_ranges[] = {
>>         regmap_reg_range(AXP20X_PWR_INPUT_STATUS, AXP20X_USB_OTG_STATUS),
>> +       regmap_reg_range(AXP20X_VBUS_IPSOUT_MGMT, AXP20X_VBUS_IPSOUT_MGMT),
> 
> And I'm not sure why you specify it as volatile? The PMIC doesn't change any
> of the bits in this register on its own.
> 

I got things mixed up between the work on the battery driver I'll soon
send (which actually needs updated reg ranges) and this VBUS driver.
Sorry for that.

> Same for the AXP22x bits. So basically I think you don't need this patch.
> 

Indeed. Should I send a v3 to remove this patch or is it fine for you to
ignore this one?

Thanks!
Quentin

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
