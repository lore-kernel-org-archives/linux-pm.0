Return-Path: <SRS0=A9Dn=EC=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75875C55179
	for <linux-pm@archiver.kernel.org>; Tue, 27 Oct 2020 09:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D5F52225C
	for <linux-pm@archiver.kernel.org>; Tue, 27 Oct 2020 09:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603789977;
	bh=cpEMFD8S6cilfz1mSxDPW5a9Q0xlNh/8/EsqVDHB1oQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JCH/AEIRT3/ClHN7iklEz3Mk2Fdlx30iXzoEs5l1zwUDbCpL2sBXhCYwemElSaKGr
	 1juvIO7vSyK7q/nQEMREfqIC1/pfq9WC09aS6RRi92KY3Kqt36h4Kp+/bnDMx7uxFY
	 P2YF8paTYxQrT++fSJ8miimycGmcqCHZMz0K1r9o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409489AbgJ0JMx (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 27 Oct 2020 05:12:53 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:46860 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2895498AbgJ0JMx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 05:12:53 -0400
Received: by mail-ej1-f65.google.com with SMTP id t25so1104002ejd.13;
        Tue, 27 Oct 2020 02:12:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rkTOJNhgqfjihtuFuHc1NI7BlUt+PrDPH7izoflCQ8M=;
        b=NQbVXyggq+Vv+aAJh/6SxYQjcsVjfS5V2zI+4Y1ok0QfKZRFS+Y5X0kr1Jxvn8Z29W
         gwa/7sfBobXpMbrLYr9xPFI7wLotpxPW4DPvQXdhOhyFss0wu9PZhSh46jB7A34+VPTz
         FVIM7MTW2/6amOPdLLk3IvzU4klLOOD5QWaFdAKo7w25hQR/B4vpPyWIsqJTCiavhZYs
         v6oh64eabSvOSNOHEaoCSsPPKsWbpDt7xeP4W3Svw91k3dVPxiN3ZYCoQHwsQEQPICj2
         wWuOSOVkyPIbVYSlLdQpJCFDgrErquMT+V/xIRzP6NVOOksSC1pxfLN/ifZgx/oB5l7V
         MfSQ==
X-Gm-Message-State: AOAM533n3uyRCtpXyUyMHGS6GBRknuvSeoUYYHPrIfPaFsVOiRzQ0o/K
        /WABIreFwrmcir98/q6tJ6c=
X-Google-Smtp-Source: ABdhPJzAZzA9uwmXL3AkXYVSo4qgHt2bA2oRWoI60v3h9p28vmDNv6sjwbIR6P2su/8plSniyaH4Sw==
X-Received: by 2002:a17:906:3b02:: with SMTP id g2mr1472975ejf.512.1603789971006;
        Tue, 27 Oct 2020 02:12:51 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
        by smtp.googlemail.com with ESMTPSA id r9sm537129edt.3.2020.10.27.02.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 02:12:49 -0700 (PDT)
Date:   Tue, 27 Oct 2020 10:12:47 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 21/52] ARM: tegra: Add interconnect properties to
 Tegra20 device-tree
Message-ID: <20201027091247.GK4244@kozik-lap>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-22-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201025221735.3062-22-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 26, 2020 at 01:17:04AM +0300, Dmitry Osipenko wrote:
> Add interconnect properties to the Memory Controller, External Memory
> Controller and the Display Controller nodes in order to describe hardware
> interconnection.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  arch/arm/boot/dts/tegra20.dtsi | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
> index 9347f7789245..2e1304493f7d 100644
> --- a/arch/arm/boot/dts/tegra20.dtsi
> +++ b/arch/arm/boot/dts/tegra20.dtsi
> @@ -111,6 +111,17 @@ dc@54200000 {
>  
>  			nvidia,head = <0>;
>  
> +			interconnects = <&mc TEGRA20_MC_DISPLAY0A &emc>,

I think you just added the defines and did not include them here, so
this should not even build. Did you test it?

Best regards,
Krzysztof
