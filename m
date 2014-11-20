From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH RFC 3/3] ARM: dts: enable power subsystem for i.MX28
Date: Thu, 20 Nov 2014 19:32:02 -0200
Message-ID: <CAOMZO5AWOs8ODsru+ySsLb=R4ezDL19nK_z0zAXdbrDfPT8KhA@mail.gmail.com>
References: <1416514477-19190-1-git-send-email-stefan.wahren@i2se.com>
	<1416514477-19190-4-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:45492 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758261AbaKTVcD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 20 Nov 2014 16:32:03 -0500
In-Reply-To: <1416514477-19190-4-git-send-email-stefan.wahren@i2se.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Stefan,

On Thu, Nov 20, 2014 at 6:14 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> This patch enables the power subsystem for all i.MX28 boards.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  arch/arm/boot/dts/imx28.dtsi |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> index 47f68ac..5c163a5 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -1022,8 +1022,12 @@
>                         };
>
>                         power: power@80044000 {
> +                               compatible = "fsl,imx28-power";

Should we have 'fsl,imx23-power' and 'fsl,imx28-power' as compatible strings?

Or  ''fsl,mxs-power' could be used for both?
