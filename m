Return-Path: <SRS0=MfD0=YJ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34F8FA372A
	for <linux-pm@archiver.kernel.org>; Wed, 16 Oct 2019 16:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B87121A4C
	for <linux-pm@archiver.kernel.org>; Wed, 16 Oct 2019 16:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571242618;
	bh=NDlN1NhoxOUb6sQg78if7MeDpGfgM15YqoKkPUVkIOc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=v4UxU6QB5FV6ZEro7HZB7U1RSarTLWgc/Z2tzhjk+bYFoIJtk/2Qtx7PEAkyJpJsS
	 vvTdr/KeCbW5QZ7aPZ8VtBHceFDbymI/7iZPgJKdl0ChiTOrs0/2y5ZhmbFD3LMBGc
	 B4evhnBCjL3mVgSSUDgQcQMhu/0N0pB/7lIZsPaE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388530AbfJPQQ6 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 16 Oct 2019 12:16:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:60570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728316AbfJPQQ5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 16 Oct 2019 12:16:57 -0400
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BFB02168B;
        Wed, 16 Oct 2019 16:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571242616;
        bh=NDlN1NhoxOUb6sQg78if7MeDpGfgM15YqoKkPUVkIOc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BPCNecFFtHLJh8YGydUcErcc9GHraZuwNukQ3UMRUO2pxiNWCiPqiTmtFhlKsk/dp
         JFax8Yiqgy+0IVhI2mxBFa5iv5SJtJNtA0kFEHnc86CRGZc91g56stXYM9C9BZGSfQ
         9IFgMowfJDceUeRB9g9lP8B/Rmr49u71VLZpZIxM=
Received: by mail-lj1-f182.google.com with SMTP id y23so24599585lje.9;
        Wed, 16 Oct 2019 09:16:56 -0700 (PDT)
X-Gm-Message-State: APjAAAU6G5JT3s4+0UAy+NDaUhHouuV5llj8bKAQOuDgFmpNkZN2LNL7
        pvRexXObQduIojV8atT0PQ3akiRKqqxJEwU3dW0=
X-Google-Smtp-Source: APXvYqwCOKkrXmNKQSP499CXhlqBMZpMhDnOgQ3rTLtNunGGURcys1oCywZ9m+kRVId/EhZGWzjROCb4rQ5GKxsDtwg=
X-Received: by 2002:a2e:1b52:: with SMTP id b79mr26755456ljb.225.1571242614784;
 Wed, 16 Oct 2019 09:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20191016145812eucas1p1a3cf3f44a2cff4c32a2270334630c4a2@eucas1p1.samsung.com>
 <20191016145756.16004-1-s.nawrocki@samsung.com> <20191016145756.16004-3-s.nawrocki@samsung.com>
In-Reply-To: <20191016145756.16004-3-s.nawrocki@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 16 Oct 2019 19:16:41 +0300
X-Gmail-Original-Message-ID: <CAJKOXPeagcSRUm2Qwwby=NHfWGdQ6KVZ2htb3UmnU2GfX+Ckcg@mail.gmail.com>
Message-ID: <CAJKOXPeagcSRUm2Qwwby=NHfWGdQ6KVZ2htb3UmnU2GfX+Ckcg@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] dt-bindings: arm: samsung: Update the CHIPID
 binding for ASV
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     vireshk@kernel.org, robh+dt@kernel.org, sboyd@kernel.org,
        roger.lu@mediatek.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 16 Oct 2019 at 17:58, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>
> This patch adds documentation of new optional "samsung,asv-bin"
> property in the chipid device node and documents requirement of
> "syscon" compatible string.  These additions are needed to support
> Exynos ASV (Adaptive Supply Voltage) feature.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Depends on patch ("8d0daa4c89c9 dt-bindings: arm: samsung: Convert
> Exynos Chipid bindings to json-schema") already applied to Rob's
> dt/next.
>
> Changes since v4:
>  - converted to YAML
>
> Changes since v3:
>  - none
>
> Changes since v2:
>  - corrected patch summary line prefix, the patch moved in the
>    sequence
>
> Changes since v1 (RFC):
>  - new patch
>
>  .../bindings/arm/samsung/exynos-chipid.yaml   | 31 +++++++++++++++++--
>  1 file changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.yaml b/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.yaml
> index 9c573ad7dc7d..df84d9e9f4c2 100644
> --- a/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.yaml
> +++ b/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.yaml
> @@ -9,17 +9,42 @@ title: Samsung Exynos SoC series Chipid driver
>  maintainers:
>    - Krzysztof Kozlowski <krzk@kernel.org>
>
> +# Custom select to avoid matching all nodes with 'syscon'
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        const: samsung,exynos4210-chipid
> +  required:
> +    - compatible
> +
>  properties:
>    compatible:
> -    items:
> -      - const: samsung,exynos4210-chipid
> +    allOf:

I think it was my mistake to use allOf in other Exynos bindings. It
should not be needed.

Rest looks good so with allOf removal:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
