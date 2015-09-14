From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 2/3] thermal: Add Mediatek thermal controller support
Date: Mon, 14 Sep 2015 15:32:56 +0800
Message-ID: <CAGS+omCHAGrRPwM8Wghver+o5ky3MG2+JJqKiwWzHtDTQkaD4g@mail.gmail.com>
References: <1441006446-4558-1-git-send-email-s.hauer@pengutronix.de> <1441006446-4558-3-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f179.google.com ([209.85.160.179]:35247 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbbINHdR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Sep 2015 03:33:17 -0400
Received: by ykdu9 with SMTP id u9so145604747ykd.2
        for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2015 00:33:16 -0700 (PDT)
In-Reply-To: <1441006446-4558-3-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, Sasha Hauer <kernel@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Sascha,

On Mon, Aug 31, 2015 at 3:34 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> This adds support for the Mediatek thermal controller found on MT8173
> and likely other SoCs.
> The controller is a bit special. It does not have its own ADC, instead
> it controls the on-SoC AUXADC via AHB bus accesses. For this reason
> we need the physical address of the AUXADC. Also it controls a mux
> using AHB bus accesses, so we need the APMIXEDSYS physical address aswell.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

[snip...]

> +static int mtk_read_temp(void *data, long *temp)
> +{
> +       struct mtk_thermal_bank *bank = data;
> +
> +       mtk_thermal_get_bank(bank);
> +
> +       *temp = mtk_thermal_bank_temperature(bank);
> +
> +       mtk_thermal_put_bank(bank);
> +
> +       return 0;
> +}
> +
> +static const struct thermal_zone_of_device_ops mtk_thermal_ops = {
> +       .get_temp = mtk_read_temp,

On v4.3-rc1, this now causes a compile warning, since the prototype
for get_temp was changed to:

       int (*get_temp)(void *, int *);

by:
commit 17e8351a77397e8a83727eb17e3a3e9b8ab5257a
    thermal: consistently use int for temperatures

-Dan
