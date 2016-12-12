From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: Re: [PATCH v2 00/11] add support for VBUS max current and min voltage
 limits AXP20X and AXP22X PMICs
Date: Mon, 12 Dec 2016 09:07:45 +0100
Message-ID: <2189bf2a-b577-85d6-c54a-0440aed05411@free-electrons.com>
References: <20161209110419.28981-1-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:54233 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753064AbcLLIHs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Dec 2016 03:07:48 -0500
In-Reply-To: <20161209110419.28981-1-quentin.schulz@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org, linux@armlinux.org.uk, maxime.ripard@free-electrons.com, lee.jones@linaro.org
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, thomas.petazzoni@free-electrons.com

Hi all,

I forgot to add a question to my cover letter so here it is:

The X-Powers AXP209 and AXP223 PMICs allow to not limit the maximal
current for the VBUS power supply.[1]
(If a Chinese-speaking person could check it's the same for the AXP221
that would be great also[2]).

In the get_property (axp20x_usb_power_get_property) of the power supply
driver, I see that we use -1 as value for "no limit". Should we use the
same (-1) value for the set_property (axp20x_usb_power_set_property) to
disable max current limit?

[1] http://dl.linux-sunxi.org/AXP/AXP209_Datasheet_v1.0en.pdf page 33,
REG 30H, BITS 0 & 1
[2]
http://dl.linux-sunxi.org/AXP/AXP221%20Datasheet%20V1.2%2020130326%20.pdf
page 33, REG 30H, BITS 0 & 1 => 不限流 is written for when the BIT(1) is
set.

Thanks,
Quentin

On 09/12/2016 12:04, Quentin Schulz wrote:
> The X-Powers AXP209 and AXP20X PMICs are able to set a limit for the
> VBUS power supply for both max current and min voltage supplied. This
> series of patch adds the possibility to set these limits from sysfs.
> 
> Also, the AXP223 PMIC shares most of its behaviour with the AXP221 but
> the former can set the VBUS power supply max current to 100mA, unlike
> the latter. The AXP223 VBUS power supply driver used to probe on the
> AXP221 compatible. This series of patch introduces a new compatible for
> the AXP223 to be able to set the current max limit to 100mA.
> 
> With that new compatible, boards having the AXP223 see their DT updated
> to use the VBUS power supply driver with the correct compatible.
> 
> This series of patch also migrates from of_device_is_compatible function
> to the data field of of_device_id to identify the compatible used to
> probe. This improves the code readability.
> 
> Mostly cosmetic changes in v2 and adding volatile and writeable regs to
> AXP20X and AXP22X MFD cells for the VBUS power supply driver.
> 
> Quentin Schulz (11):
>   power: supply: axp20x_usb_power: use of_device_id data field instead
>     of device_is_compatible
>   mfd: axp20x: add volatile and writeable reg ranges for VBUS power
>     supply driver
>   power: supply: axp20x_usb_power: set min voltage and max current from
>     sysfs
>   Documentation: DT: binding: axp20x_usb_power: add axp223 compatible
>   power: supply: axp20x_usb_power: add 100mA max current limit for
>     AXP223
>   mfd: axp20x: add separate MFD cell for AXP223
>   ARM: dtsi: add DTSI for AXP223
>   ARM: dts: sun8i-a33-olinuxino: use AXP223 DTSI
>   ARM: dts: sun8i-a33-sinlinx-sina33: use AXP223 DTSI
>   ARM: dts: sun8i-r16-parrot: use AXP223 DTSI
>   ARM: dtsi: sun8i-reference-design-tablet: use AXP223 DTSI
> 
>  .../bindings/power/supply/axp20x_usb_power.txt     |   5 +
>  arch/arm/boot/dts/axp223.dtsi                      |  58 +++++++++++
>  arch/arm/boot/dts/sun8i-a33-olinuxino.dts          |   2 +-
>  arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts     |   2 +-
>  arch/arm/boot/dts/sun8i-r16-parrot.dts             |   2 +-
>  .../boot/dts/sun8i-reference-design-tablet.dtsi    |   2 +-
>  drivers/mfd/axp20x.c                               |  32 +++++-
>  drivers/power/supply/axp20x_usb_power.c            | 116 ++++++++++++++++++---
>  8 files changed, 197 insertions(+), 22 deletions(-)
>  create mode 100644 arch/arm/boot/dts/axp223.dtsi
> 

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
