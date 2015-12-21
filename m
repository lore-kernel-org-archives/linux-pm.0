From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 2/3] thermal: Add Mediatek thermal controller support
Date: Mon, 21 Dec 2015 12:07:58 +0800
Message-ID: <CAGS+omC86=Kfdj0cFNHqs4fXCAT0uU+AxHCj3ORd2HetNZ2gVQ@mail.gmail.com>
References: <1448883753-19068-1-git-send-email-s.hauer@pengutronix.de> <1448883753-19068-3-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f41.google.com ([209.85.213.41]:35242 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbbLUEIT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 20 Dec 2015 23:08:19 -0500
Received: by mail-vk0-f41.google.com with SMTP id a189so94273209vkh.2
        for <linux-pm@vger.kernel.org>; Sun, 20 Dec 2015 20:08:18 -0800 (PST)
In-Reply-To: <1448883753-19068-3-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sasha Hauer <kernel@pengutronix.de>, linux-mediatek@lists.infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>

Hi Sascha,

One nit below that can be fixed up later, or now if you don't plan to
spin this driver to
address Eduardo's feedback...

On Mon, Nov 30, 2015 at 7:42 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> This adds support for the Mediatek thermal controller found on MT8173
> and likely other SoCs.
> The controller is a bit special. It does not have its own ADC, instead
> it controls the on-SoC AUXADC via AHB bus accesses. For this reason
> we need the physical address of the AUXADC. Also it controls a mux
> using AHB bus accesses, so we need the APMIXEDSYS physical address aswell.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

[snip]

> +static int mtk_thermal_get_calibration_data(struct device *dev, struct mtk_thermal *mt)
> +{
> +       struct nvmem_cell *cell;
> +       u32 *buf;
> +       size_t len;
> +       int i, ret = 0;
> +
> +       /* Start with default values */
> +       mt->adc_ge = 512;
> +       for (i = 0; i < MT8173_NUM_SENSORS; i++)
> +               mt->vts[i] = 260;
> +       mt->degc_cali = 40;
> +       mt->o_slope = 0;
> +
> +       cell = nvmem_cell_get(dev, "calibration-data");
> +       if (IS_ERR(cell)) {
> +               if (PTR_ERR(cell) == -EPROBE_DEFER)

It is useful to know why the thermal driver is being probe defered, so
I suggest here:
dev_warn(dev, "Waiting for calibration data.\n");

> +                       return PTR_ERR(cell);
> +               return 0;
> +       }

Thanks,
-Dan
