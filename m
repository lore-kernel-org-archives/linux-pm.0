Return-Path: <SRS0=thCJ=B3=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A43FC433E1
	for <linux-pm@archiver.kernel.org>; Mon, 17 Aug 2020 19:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B1BD20738
	for <linux-pm@archiver.kernel.org>; Mon, 17 Aug 2020 19:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597691812;
	bh=zIS/OxiWJT0USm8ylTU7Llp58GDXNvLgpHpQm6PVlsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H4q1yvtVaYdMh7npBHv7jSkBpKnt4QoLrc79gKHax0QQOD2Iqz+YUBijg7m6xw9uC
	 3W8+fYrKO+n5JFTGdfy5+tcum7z8Q6H3nE2Zs0qrwEfBqFaKnwP1q4VenUVHiI0zXw
	 ZKvKjgC1ftWbIZSceCVqV+MFuVAIuwh3BJ/j09ms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbgHQTQd (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:16:33 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:39995 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730457AbgHQPjM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Aug 2020 11:39:12 -0400
Received: by mail-ej1-f65.google.com with SMTP id o18so18265019eje.7;
        Mon, 17 Aug 2020 08:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bbc3Jq90wBrnkEhTh6h/zVaFu4opATk2C7+6kErmGF8=;
        b=GCKK+1hcrnSS17rJv8IS357S3eN0sG4DiA9p4C51g/OBQPN4/ihdCGXJmCTtyErJ9o
         oKCl+e9V0JL61+aUaBZp3dDQcZyb5GHsjG37qpyztgswHroBfICkvmffBo1wvDnQpv4K
         NPl5dUNWWon3zy6iagTFSxA952rdt1KgwToIfnIq83ucNImuJQYm3jKD0wgl6VaMKa5Y
         Xku3HTyhd/Dcmnb8Rr2T4MJEOUdak3+VcOI1VXqNvY+hAOfcI58Kj2iHktGM1my/d+6g
         nUZEbGajLiNsEJXftUWoCfm7Xtf4qiDFkbQW25paipHgAE7Z4eF3R4rv68EA/Ckm6Tt3
         BFzQ==
X-Gm-Message-State: AOAM533tcIwroyp7hf4wSr0kSBmlbowIMzjFZ5FvtRmUb88IeKfjAuwn
        q67mlBc1ZeaV3EehDYHkyJU=
X-Google-Smtp-Source: ABdhPJyEi8WZWyZaI3VmlZPB34uMnAbvDO2ZsHQq9+VQ+Ddi9qRQZCpn162YzLhp+f5b7s22O2AfqQ==
X-Received: by 2002:a17:906:4dd4:: with SMTP id f20mr16628985ejw.170.1597678750714;
        Mon, 17 Aug 2020 08:39:10 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id k10sm14563979ejj.108.2020.08.17.08.39.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Aug 2020 08:39:10 -0700 (PDT)
Date:   Mon, 17 Aug 2020 17:39:08 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH 2/4] cpuidle: big.LITTLE: enable driver only on
 Peach-Pit/Pi Chromebooks
Message-ID: <20200817153908.GA13144@kozik-lap>
References: <20200616081230.31198-1-m.szyprowski@samsung.com>
 <CGME20200616081249eucas1p2ad165b545f265bec88a06270d55fce76@eucas1p2.samsung.com>
 <20200616081230.31198-3-m.szyprowski@samsung.com>
 <db3315ef-1ca8-14b5-486a-9cc5a02150a8@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <db3315ef-1ca8-14b5-486a-9cc5a02150a8@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 24, 2020 at 12:05:46PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> On 6/16/20 10:12 AM, Marek Szyprowski wrote:
> > This driver always worked properly only on the Exynos 5420/5800 based
> > Chromebooks (Peach-Pit/Pi), so change the required compatible string to
> > the 'google,peach', to avoid enabling it on the other Exynos 542x/5800
> > boards, which hangs in such case. The main difference between Peach-Pit/Pi
> > and other Exynos 542x/5800 boards is the firmware - Peach platform doesn't
> > use secure firmware at all.
> > 
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

This patch waited on list for almost two months and was not picked up.
Therefore I'll take it for v5.10.

Thanks, applied.

Best regards,
Krzysztof

