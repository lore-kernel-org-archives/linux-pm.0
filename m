Return-Path: <SRS0=NsZF=A7=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6771DC433DF
	for <linux-pm@archiver.kernel.org>; Mon, 20 Jul 2020 08:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47FF120702
	for <linux-pm@archiver.kernel.org>; Mon, 20 Jul 2020 08:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595232367;
	bh=DBU10xCfPXi9S7q1y4HELT5+p2XXLy5mMLrB0UTptkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VgTxsV9PhR0mUb0lEdSLv3HVLX5QN3ofShSjjvTIhl4I2DG7ayurNUtyQo4eLHBKV
	 2Wvet62I2uaGXpxBs0fNg81GD6lovJ604U4m0CwPRz8DFIgv8mREU8jyCULOSITjOF
	 sMMKXktdHJhEpBltKjm+dgr7GL41OwKd9YY5RYN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbgGTIGG (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:06:06 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37069 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgGTIGG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jul 2020 04:06:06 -0400
Received: by mail-wm1-f66.google.com with SMTP id o2so24236749wmh.2;
        Mon, 20 Jul 2020 01:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vg09xK5q93RhjkSo+BtXD7JwKBjiF9ZCt45w+OmMMVY=;
        b=fUTMldOGfkrptj+n6jUNqqziKMMf/cgU3ebuM7YHLJZ0XgOOJqWml/zNAXU9MZAt1a
         mGZvgYzT/+3kYDfQLwSwmS+97D3X71N0LmiMg3B5PnXTfT/0q4jEw+ErAXYjQu39erMv
         PbSgzLHrqupo1/SbayKs7x3vx2lM2nE46s3LgQ2TmVm+ZkJXuxqz7NI3BWncEoacBi4W
         3tC4eBog3hxZ4MDad6D6MPar6pq5JdCYA3wpVYVNh5IRU/TZf7xK3PDgIHBjkIQX+I5R
         8xh6BibHYZ5Pd+acRH32bmKIZlUob72pbi5dVB2V9g6pE1J188m3hqVTBDOtLLNTNlyR
         jLsw==
X-Gm-Message-State: AOAM531qDr6XfPxZ57hpenTGrvUIwQWgLD3OZ9TpTfXB+rzzmUYaao2z
        dP8m+sbw2MRjojiVe49Jaz++uIB7z3g=
X-Google-Smtp-Source: ABdhPJxJ8ZIsf7AKkJqYCmB3NDTY1+PGtOCnwv5Wvo5iWqmnU/v7hbUEipw+IMyAcld5Qa3frDje4g==
X-Received: by 2002:a7b:c3d0:: with SMTP id t16mr21900753wmj.117.1595232364225;
        Mon, 20 Jul 2020 01:06:04 -0700 (PDT)
Received: from kozik-lap ([194.230.155.200])
        by smtp.googlemail.com with ESMTPSA id l67sm34178337wml.13.2020.07.20.01.06.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Jul 2020 01:06:03 -0700 (PDT)
Date:   Mon, 20 Jul 2020 10:06:01 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Willy Wolff <willy.mh.wolff.ml@gmail.com>,
        Marian Mihailescu <mihailescu2m@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] ARM: dts: exynos: Disable frequency scaling for FSYS bus
Message-ID: <20200720080601.GA3845@kozik-lap>
References: <CGME20200714064824eucas1p2ea0d2ee2c109c351fe489050905b4104@eucas1p2.samsung.com>
 <20200714064759.31772-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200714064759.31772-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 14, 2020 at 08:47:59AM +0200, Marek Szyprowski wrote:
> Commit 1019fe2c7280 ("ARM: dts: exynos: Adjust bus related OPPs to the
> values correct for Exynos5422 Odroids") changed the parameters of the
> OPPs for the FSYS bus. Besides the frequency adjustments, it also removed
> the 'shared-opp' property from the OPP table used for FSYS_APB and FSYS
> busses.
> 
> This revealed that in fact the FSYS bus frequency scaling never worked.
> When one OPP table is marked as 'opp-shared', only the first bus which
> selects the OPP sets the rate of its clock. Then OPP core assumes that
> the other busses have been changed to that OPP and no change to their
> clock rates are needed. Thus when FSYS_APB bus, which was registered
> first, set the rate for its clock, the OPP core did not change the FSYS
> bus clock later.
> 
> The mentioned commit removed that behavior, what introduced a regression
> on some OdroidXU3 boards. Frequency scaling of the FSYS bus causes
> instability of the USB host operation, what can be observed as network
> hangs. To restore old behavior, simply disable frequency scaling for the
> FSYS bus.
> 
> Reported-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
> Fixes: 1019fe2c7280 ("ARM: dts: exynos: Adjust bus related OPPs to the values correct for Exynos5422 Odroids")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 6 ------
>  1 file changed, 6 deletions(-)

Thanks Willy and Marek for digging into this, applied.

A follow up question would be if other boards (Exynos4412) require the
same?

Best regards,
Krzysztof

