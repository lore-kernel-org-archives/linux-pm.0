From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH v5 2/3] arm64: dts: mt8173: Add thermal zone node.
Date: Wed, 16 Dec 2015 16:34:05 +0800
Message-ID: <CAGS+omDDfJb9dfWWPaMKs=MkO4Pf3RF9SUD==i7sgHsrDhFDxA@mail.gmail.com>
References: <1450238356-36319-1-git-send-email-dawei.chien@mediatek.com> <1450238356-36319-3-git-send-email-dawei.chien@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f50.google.com ([209.85.213.50]:36348 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932986AbbLPIe0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Dec 2015 03:34:26 -0500
Received: by mail-vk0-f50.google.com with SMTP id y187so21859119vka.3
        for <linux-pm@vger.kernel.org>; Wed, 16 Dec 2015 00:34:26 -0800 (PST)
In-Reply-To: <1450238356-36319-3-git-send-email-dawei.chien@mediatek.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dawei Chien <dawei.chien@mediatek.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Matthias Brugger <matthias.bgg@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream <srv_heupstream@mediatek.com>, Sascha Hauer <kernel@pengutronix.de>, Punit Agrawal <punit.agrawal@arm.com>

On Wed, Dec 16, 2015 at 11:59 AM, Dawei Chien <dawei.chien@mediatek.com> wrote:
>
> This adds thermal zone node to Mediatek MT8173 dtsi file.
>
> Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
> ---
> This patch is base on patchset:
> https://lkml.org/lkml/2015/11/30/239
> ---
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi |   43 ++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index fda805d..4114cee 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -188,6 +188,49 @@
>                 clock-output-names = "cpum_ck";
>         };
>
> +       thermal-zones {
> +               cpu_thermal: cpu_thermal {
> +                       polling-delay-passive = <1000>; /* milliseconds */
> +                       polling-delay = <1000>; /* milliseconds */
> +
> +                       thermal-sensors = <&thermal 0>;

This should be <&thermal> with the MTK temp sensor node in
https://lkml.org/lkml/2015/11/30/239 patch series.

-Dan
