Return-Path: <SRS0=A9Dn=EC=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8875C4363A
	for <linux-pm@archiver.kernel.org>; Tue, 27 Oct 2020 09:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58E212224E
	for <linux-pm@archiver.kernel.org>; Tue, 27 Oct 2020 09:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603790300;
	bh=xQlHG3Wr1kivyrVR4eOgJYKVqmFfzqu/xts6ZuPqFaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H4XzK+9E5zkUoiIMlxYitCofqYYbXgJemvPfvWRTohyDv+/DciGgoQuehOoeKt/uO
	 H2syV6r2iMlitXgE584xaOJcz2PzqE5rVJVc//hN9CiQ2atzzbny3wMf8B5CXQ+ahd
	 p51H52cpUOmWh7jODsP2bEyO2e2yczxIHeBwa1kA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443650AbgJ0JSL (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 27 Oct 2020 05:18:11 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46330 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394889AbgJ0JSL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 05:18:11 -0400
Received: by mail-ed1-f66.google.com with SMTP id 33so627079edq.13;
        Tue, 27 Oct 2020 02:18:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HAb5s57kc6FoxJJ5M7USdfq0o0bKGmCp0q9T2Pfs8tQ=;
        b=TXaO1+VHX5OYgJfTIhS05eodj40obeRzhzC1QtUfXFLmiUnWiQwlmTDyMYopDsMQSd
         N8IJ+lWZQf40616gYv4hROK7s8Ptj0Rfs08mKECtZJ5vqQhsy4pojhlhG3iQfR16vT6o
         PZaF/XejckNiJ+RL+PRYcLtjxVyQ+rHCImWuXcPvJ8zVLqgNiksAzG2Z1p1+LltB/yej
         Ean6rkNntx345vog4kWwtiy/Yxu06/onjRhAcp45SBX1LkSJYXmgfXx7PJAL2migP8jQ
         uMnw46mqmTf6gQk2MHC8sTeD6yFk/lz+hz3tTeNQlvtASTx9WikAVCefac/WprXyJUze
         n3XQ==
X-Gm-Message-State: AOAM530YxVEjrFr0Eth5QYggBryPGXlzNVMK8JHmCcHAUsd+65xA5XpA
        HiduxsDTtBW4YVTRGL0ROBU=
X-Google-Smtp-Source: ABdhPJzOLthwFj6nDtDIvhLVvFPoESLoUtoRlDAuM65L24KRPnOdjwxWM9Zp5eXDz2i7noU2UuMTag==
X-Received: by 2002:a05:6402:135a:: with SMTP id y26mr1207604edw.114.1603790288831;
        Tue, 27 Oct 2020 02:18:08 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
        by smtp.googlemail.com with ESMTPSA id v18sm658320ejj.10.2020.10.27.02.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 02:18:07 -0700 (PDT)
Date:   Tue, 27 Oct 2020 10:18:05 +0100
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
Subject: Re: [PATCH v6 25/52] ARM: tegra: Add DVFS properties to Tegra20 EMC
 device-tree node
Message-ID: <20201027091805.GC10762@kozik-lap>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-26-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201025221735.3062-26-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 26, 2020 at 01:17:08AM +0300, Dmitry Osipenko wrote:
> Add EMC OPP DVFS/DFS tables and emc-stats subdev that will be used for
> dynamic memory bandwidth scaling, while EMC itself will perform voltage
> scaling. Update board device-trees with optional EMC core supply and
> remove unsupported OPPs.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../boot/dts/tegra20-acer-a500-picasso.dts    |  12 ++
>  arch/arm/boot/dts/tegra20-colibri.dtsi        |   8 +
>  arch/arm/boot/dts/tegra20-paz00.dts           |  10 +
>  .../arm/boot/dts/tegra20-peripherals-opp.dtsi | 181 ++++++++++++++++++
>  arch/arm/boot/dts/tegra20.dtsi                |  12 +-
>  5 files changed, 222 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/tegra20-peripherals-opp.dtsi
> 
> diff --git a/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts b/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
> index a0b829738e8f..f5c1591c8ea8 100644
> --- a/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
> +++ b/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
> @@ -1058,9 +1058,21 @@ map0 {
>  		};
>  	};
>  
> +	emc_opp_table0 {

All node names with hyphens -. Not underscores.

Best regards,
Krzysztof
