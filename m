From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 5/5] ARM: dts: axp209: Enable usb_power_supply by
 default
Date: Thu, 5 May 2016 12:39:48 +0200
Message-ID: <f672f0c7-495c-de63-6115-68d57500d874@redhat.com>
References: <1462444508-9363-1-git-send-email-haas@computerlinguist.org>
 <1462444508-9363-6-git-send-email-haas@computerlinguist.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43509 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757172AbcEEKkA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 5 May 2016 06:40:00 -0400
In-Reply-To: <1462444508-9363-6-git-send-email-haas@computerlinguist.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Haas <haas@computerlinguist.org>, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, maxime.ripard@free-electrons.com, wens@csie.org, lee.jones@linaro.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: bonbons@linux-vserver.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, linux-sunxi@googlegroups.com

Hi,

On 05-05-16 12:35, Michael Haas wrote:
> This node should be enabled by default. A device is likely to have an USB power
> connection. If USB power is indeed absent, the USB power driver
> will simply report the power input as offline.

Nack, as Maxime already said we do not want to enable any optional
features by default. Many top set boxes do not use the usb power supply,
and we don't want some userspace power control panel applet showing
the supply as offline, we want the supply to simply not be there.

Regards,

Hans



>
> Signed-off-by: Michael Haas <haas@computerlinguist.org>
> ---
>  arch/arm/boot/dts/axp209.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/axp209.dtsi b/arch/arm/boot/dts/axp209.dtsi
> index 7deb7d9..4f16be0 100644
> --- a/arch/arm/boot/dts/axp209.dtsi
> +++ b/arch/arm/boot/dts/axp209.dtsi
> @@ -97,7 +97,7 @@
>
>  	usb_power_supply: usb_power_supply {
>  		compatible = "x-powers,axp202-usb-power-supply";
> -		status = "disabled";
> +		status = "okay";
>  	};
>
>  };
>
