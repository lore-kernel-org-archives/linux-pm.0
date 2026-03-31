Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD084218A7
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 16:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774973034; cv=pass; b=uh061anOYiuie7O8jU+5c2GJrKnxoqzqzv7H7pJ2ymIlX9nuN9pQBAe62MeoQpW3ld1hTI9pvUQroI0DZCggFmG1jH5knfwrCYA0XthqYAGfcdW0VeoJK+Lz6h2kbp84Lza6GSpdqbd57eLHsA0HAjSIAwZwcxl1eWXuD11j2h4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774973034; c=relaxed/simple;
	bh=2yavj7EK1PmGo4upHMwJjReye7feEWJp2Qv0943llFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n/Bl6yHYG4VULYvyGpW92ot4Ha4BlLSQ7xX38CtgTv2nrs8X9czwWV8kzO9ycmX6wLaFHtKTFF23YMShCnmyYX/BT4kxe3fHCo4p5K5qwepu0zUl9DR9LsFrJA62U50/StLdJZqNWcUHh0oyYizIJUi0owE31DuDFFk6l+PlU0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F5HpDifM; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F5HpDifM"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64e87a81639so9059940d50.0
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 09:03:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774973031; cv=none;
        d=google.com; s=arc-20240605;
        b=c3D+fmsE5MJ5pUaxKLKKaP9fo0PWL5kqw2XuHdrtqz6ozPWTnXQSe8uSVrN+xkJ3ud
         4KEmOufx3QPLVbTLZlv5YTocBaQxxD+aXJYRqG+yUR4McjUPppxJCMud5wWyOTMW8sUD
         En07Av8U40F04EM9etuwfeheckslTE6WNv/v/McHPQhWBTwRLPMGxFrFTZHGjJaT6hjb
         8bPavNmko5cbq1+cnL0DbKZ+7pURVM4JZJL7WpgULMlG0I9RxEZz5wGQTKHv0njgLIpk
         5y+MtQprXl0nsHLexaRwJ+dfzb8V9NOn4yeuWcgUlBmGFhsKH/UeecNkaeWy9CAQgXys
         J8qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rBdTZ4XJk/aBrMhfzRVF3zUCulaowGOaG9ZKyP9cK7U=;
        fh=hitZjmlteTbKWEQv320ZYoUxZHZzgmFDnOegbcU477M=;
        b=D9Gg3tefwKfPO4fsoH/AQTfOifX0sW4sDDBaLuTlfPf8QTulYY84v19NS7Wnm0+yQ6
         8ImxRb9yGPvno/92e8CbMk4ukauHgmNaf4/DXf7RCDRSP2Y2TrChRb49G29Ds18pFfaI
         1mmA9S8dXHN2Nla7qs0WHzRsCybzwX6qKda/g733e1PgF6G5KMKBgZyjeOSMQSkgK0J3
         9Vbudf7TOWNP7l378seT/4tFHM20Hj0bb8CxejPnxUvM0GKj6M805uW56kyVnR+ZWCH6
         gT6U0BOrzkeSfCU3lekFkSlLLqlOlbaMRPM+bEDzeg2gV6kQ+AMVM/gFrPCYq8O7KzGO
         1shw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774973031; x=1775577831; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rBdTZ4XJk/aBrMhfzRVF3zUCulaowGOaG9ZKyP9cK7U=;
        b=F5HpDifMJPunnc56ScwcE8sTJjw/oUV6pxHh4y/v9q7rLyhckeiBMW4eD4hrKVABMB
         GjPq5nEyzTEqj6JP8zAmI/zXMz58PaKWgO2huITTQnb2lCMg2aHyiZjesxt0OknLAP2h
         ON2y+QX1Ba6nRzOYzANRNwxVhQdmqJiinS2pD6+lLlZpgyuMeK5Ri+cwGVWVjEvYWRf+
         wMsUU7N+Hu0thue+MHtr0QFJfC0IjQ3PY0yr67YkjINr0DFrPABNhUUOm4G5cVqE1tA/
         7nXdoyHMkAbSD65paUfs3lD2OAK2iC5XBRvnFpGUyaFGaVreSVLldB6TTrTCHGpLr3EP
         dLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774973031; x=1775577831;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rBdTZ4XJk/aBrMhfzRVF3zUCulaowGOaG9ZKyP9cK7U=;
        b=hBtKuiwBXI4pkxZ2skY3t5SjmTdMBRIZZRM0CCj7tedsggT/x+amDKaq5a1CRaMzbf
         HoYohiu2UQ8CjNfuxqCS/9UWbqEzWFlSrY9haY8uFl8Y3UcAiFiyh8S/pUJTJPCZUNBo
         cAIxlavajDC0RLeQd20UjWk5X+byhaha0E1YvSvqV54FuuTIj8jItZUVwu08cQXuoL7e
         TDWQqNPY0Op0LMyA8FqP+Wa9HO8Nl1pFpm2MfCBLW6SpdbzBli3G+6eWGl4Xl7q51noD
         Z0+L29ojlTvnRRe+tzNcH6dsBPzkBV0ygFerPM8BZb3fWy/Ib8ZrkMaLtgJkS/55tkV4
         ecLg==
X-Forwarded-Encrypted: i=1; AJvYcCV+gdFjDIXWTtSHmeqeK7qkvq9kfxuJrutXrXLqNFTAzWsJuiUsUsy6nyY2a5/DT3fLhvvDFYRQsg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfoOVUwYkxBWCvkpbrYDL6BGRNkdCOPMts1hpPmZIC5+FwGoVJ
	iN3GUMyVKgLOMvbDa4D+JcNaN23ALtGiyfHd4NMt/P+7AOK+hY0Zdt9obi4tTXFGP0CeJbqayaC
	8xsGPvoHsEXJPzAAw2Yq9MSrSJVEDi4OmLZi2jl009A==
X-Gm-Gg: ATEYQzyr4D7urBJvYtb7vSc+M4D7HW/htQoDZyyJMcCm1H8PaKAXd1dVL0n9V2NLT0e
	eNucKZLjqLS/1RjInl8Q3MgKDdFieWXY8QNc1ulyhcl+K6nYunag2/giTiP9xY4VNU+aEOWYN2m
	TJqylATkVsEzTidh1gA+QSqZnn0xoTEiLeVrGmdVdyuaAQ/bphe4qQZ3L2ZeLAcpijNLX09+HlK
	E2kBF2V7RpOpHcO2QTYuuw0ZCPTyC7+q7Y0dccKFadPzwqAiYgnXg/+ehJVRSPQzW+kpEsHXlaP
	R03Sk4icTrC/vA5eucg=
X-Received: by 2002:a05:690e:11c4:b0:650:2379:665a with SMTP id
 956f58d0204a3-650237968d3mr5493002d50.27.1774973030427; Tue, 31 Mar 2026
 09:03:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320-imx8mp_hdmi_hang-v1-1-ccfce0517999@nxp.com>
In-Reply-To: <20260320-imx8mp_hdmi_hang-v1-1-ccfce0517999@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 31 Mar 2026 18:03:09 +0200
X-Gm-Features: AQROBzC_bCTqHlcTi3-7217Va-IAxfmw49HgqDKRyv7Q0XoLPSqjyqoAOhtHuJQ
Message-ID: <CAPDyKFo57xyjyp4C5g5PYvVj40bTXaFaEGe3kgrNi1X2HB3BUA@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: imx8mp-blk-ctrl: Keep the NOC_HDCP clock enabled
To: Jacky Bai <ping.bai@nxp.com>
Cc: Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Shawn Guo <shawnguo@kernel.org>, Peng Fan <peng.fan@nxp.com>, linux-pm@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Mar 2026 at 09:41, Jacky Bai <ping.bai@nxp.com> wrote:
>
> Keep the NOC_HDCP clock always enabled to fix the potential hang
> caused by the NoC ADB400 port power down handshake.
>
> Fixes: 77b0ddb42add ("soc: imx: add i.MX8MP HDMI blk ctrl HDCP/HRV_MWR")
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/imx/imx8mp-blk-ctrl.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> index 8fc79f9723f07e34fd3f5162f2c9c549dcdaeb5b..3f5b9499d30a0c8fb8ad8ba3b638d7de1fc55ab6 100644
> --- a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> @@ -352,9 +352,6 @@ static void imx8mp_hdmi_blk_ctrl_power_on(struct imx8mp_blk_ctrl *bc,
>                 regmap_set_bits(bc->regmap, HDMI_RTX_RESET_CTL0, BIT(12));
>                 regmap_clear_bits(bc->regmap, HDMI_TX_CONTROL0, BIT(3));
>                 break;
> -       case IMX8MP_HDMIBLK_PD_HDCP:
> -               regmap_set_bits(bc->regmap, HDMI_RTX_CLK_CTL0, BIT(11));
> -               break;
>         case IMX8MP_HDMIBLK_PD_HRV:
>                 regmap_set_bits(bc->regmap, HDMI_RTX_CLK_CTL1, BIT(3) | BIT(4) | BIT(5));
>                 regmap_set_bits(bc->regmap, HDMI_RTX_RESET_CTL0, BIT(15));
> @@ -408,9 +405,6 @@ static void imx8mp_hdmi_blk_ctrl_power_off(struct imx8mp_blk_ctrl *bc,
>                 regmap_clear_bits(bc->regmap, HDMI_RTX_CLK_CTL0, BIT(7));
>                 regmap_clear_bits(bc->regmap, HDMI_RTX_CLK_CTL1, BIT(22) | BIT(24));
>                 break;
> -       case IMX8MP_HDMIBLK_PD_HDCP:
> -               regmap_clear_bits(bc->regmap, HDMI_RTX_CLK_CTL0, BIT(11));
> -               break;
>         case IMX8MP_HDMIBLK_PD_HRV:
>                 regmap_clear_bits(bc->regmap, HDMI_RTX_RESET_CTL0, BIT(15));
>                 regmap_clear_bits(bc->regmap, HDMI_RTX_CLK_CTL1, BIT(3) | BIT(4) | BIT(5));
> @@ -439,7 +433,7 @@ static int imx8mp_hdmi_power_notifier(struct notifier_block *nb,
>         regmap_write(bc->regmap, HDMI_RTX_CLK_CTL0, 0x0);
>         regmap_write(bc->regmap, HDMI_RTX_CLK_CTL1, 0x0);
>         regmap_set_bits(bc->regmap, HDMI_RTX_CLK_CTL0,
> -                       BIT(0) | BIT(1) | BIT(10));
> +                       BIT(0) | BIT(1) | BIT(10) | BIT(11));
>         regmap_set_bits(bc->regmap, HDMI_RTX_RESET_CTL0, BIT(0));
>
>         /*
>
> ---
> base-commit: b84a0ebe421ca56995ff78b66307667b62b3a900
> change-id: 20260122-imx8mp_hdmi_hang-e7c5b4bdf1bb
>
> Best regards,
> --
> Jacky Bai <ping.bai@nxp.com>
>
