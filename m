Return-Path: <SRS0=1fz4=XN=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99A8C4CEC9
	for <linux-pm@archiver.kernel.org>; Wed, 18 Sep 2019 18:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACBED21928
	for <linux-pm@archiver.kernel.org>; Wed, 18 Sep 2019 18:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568832729;
	bh=D2lZp77vuPPFjapSE1luWFqGE+AMlkDMF0qAm1nfdik=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=baO6IYb2LFnn7RYXtG4gQLebxPx/nyFmg0z77J9oqqScz0i0T7Q/ZYDDdNhYJMj06
	 4GZYtL8BboQG1NGHHjeK4QYCs6zG1SJ2gJVVgV2uJcI03s8XOUllQLjdHjMcHMayXJ
	 GyhY5PncYxjHlOAn8yXi55ODRgk//X+IfcXf0/gI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387626AbfIRSwJ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 18 Sep 2019 14:52:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387624AbfIRSwJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 18 Sep 2019 14:52:09 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34A5B21BE5;
        Wed, 18 Sep 2019 18:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568832728;
        bh=D2lZp77vuPPFjapSE1luWFqGE+AMlkDMF0qAm1nfdik=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a5jKtG9qnYgYgjRsZv1sf8NP8e0/8orK0rKmB3KgL+99PTz7koJs0RUWDyXKmUQp9
         0E4U1VJPs47imeEkPmZjgup9jYCL8bLVIkcazbyChXGKbbUaNP5KQwlugpTRHAph8Z
         Xz2GWQSqOYqrEA0J7UsvbGMqvx9TMKsoG6VK63Yo=
Received: by mail-oi1-f169.google.com with SMTP id w17so497696oiw.8;
        Wed, 18 Sep 2019 11:52:08 -0700 (PDT)
X-Gm-Message-State: APjAAAXZtFeue3jD69X0Piixvp5VoRxSMqbxuCxuPAyhXW4h/rCyZS1h
        PhXbC28/PX9oxVsNVldeR790SaFESPgb3o6RLak=
X-Google-Smtp-Source: APXvYqwTmWtPKUYeaXD8GJnHb+WNedVhZf9eATTB06UB+uViLMeI7fDdW74rhYBzQ7SfVuPq9nnlRvw+3ZAXPQhJhLQ=
X-Received: by 2002:a54:4e05:: with SMTP id a5mr3483762oiy.91.1568832727427;
 Wed, 18 Sep 2019 11:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190916100719eucas1p206fe95982b774840b5d6e62ba9c42c79@eucas1p2.samsung.com>
 <20190916100704.26692-1-l.luba@partner.samsung.com> <20190916100704.26692-4-l.luba@partner.samsung.com>
In-Reply-To: <20190916100704.26692-4-l.luba@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 18 Sep 2019 20:51:55 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcxG-mMKy5u-b0+xj_sOmrq5yq5-LYJx0Ds6_+yo_=JbA@mail.gmail.com>
Message-ID: <CAJKOXPcxG-mMKy5u-b0+xj_sOmrq5yq5-LYJx0Ds6_+yo_=JbA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: ddr: Add bindings for Samsung LPDDR3 memories
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        willy.mh.wolff.ml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 16 Sep 2019 at 12:07, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> Add compatible for Samsung k3qf2f20db LPDDR3 memory bindings.
> Introduce minor fixes in the old documentation.
>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  Documentation/devicetree/bindings/ddr/lpddr3.txt | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/ddr/lpddr3.txt b/Documentation/devicetree/bindings/ddr/lpddr3.txt
> index 3b2485b84b3f..49afe794daaa 100644
> --- a/Documentation/devicetree/bindings/ddr/lpddr3.txt
> +++ b/Documentation/devicetree/bindings/ddr/lpddr3.txt
> @@ -1,7 +1,9 @@
>  * LPDDR3 SDRAM memories compliant to JEDEC JESD209-3C
>
>  Required properties:
> -- compatible : Should be  - "jedec,lpddr3"
> +- compatible : should be one of the following:
> +       Generic default - "jedec,lpddr3".

The convention is first compatible, then description. I gave you the
example to base on - at25. Why making it different?

Best regards,
Krzysztof
