Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B02C42E40A
	for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 12:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787661186; cv=pass; b=m0MzXUbAIpoDYw36cnqkVmostadYYXABP3lYetzso/L3YbSymDS+zEMZJndQcEMFa7lL3NdkjSn/pdzvKJBCJkJTJmrwxcR8EjdmkuOLEFlMwU8VpJ/jcnRX0hvH1Su4Xq+Z12yecsKEJhxRIDN5pv3pGHoqHOMFab0G5/CrLnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787661186; c=relaxed/simple;
	bh=NGrK7unDAm/B2x/Ykw7H2riNy8GEYeiyVELFClUTNpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ekbMQNI1QXQsaFgTSOHjvZ8ncuKsww2R1Fkn6Uhsm6Z4c42BUUwMJGIx+kxvTdkfxDSEm7+LTC87L+Xc8If9XTm8y3dqbuy0dKz8PNMZ9JPatS+XbdlUwetp0iCYOr0w1LDZLBiMkaahL+M5n5BGzN6C6GgPx83SgSFDJGTzW48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RBaM23L9; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBaM23L9"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-81e8c68c0cdso3775317b3.2
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 05:33:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787661184; cv=none;
        d=google.com; s=arc-20260327;
        b=ZHpdfwhCRd/QqSi+zUf57hdRBT3LsDgAMdCumUpqcilp87cU5bpe+/yQwroUIYBa6X
         KxJKPO5uzootAW6z8K3xZCcbViy+IwMr57OaofCY4qOQwQCZ2KP3EeDD+BNAXmJgnjve
         rt6xuVsVIt8ISUWP3/Ozc87b1aQPe14oCkwp6sWe17stdlUzarrX8x6vxInEwN3gJ5QL
         JIMq7pZGy9rKXey4SukpjLFY7o507NwO5PpmwMslSW6YBHLabCl/CnJKr/LkwzPRz+kL
         MsVXtdBsPw/NiXYBLP90zkgLVOJyOyelwJ5q09Rm08+c6B4bfvF8EmXWXE6587aWQ2hM
         U79w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j5Ct481F4wkRupatYcRj24aj8wwNlrEwHJD/XdnqyS4=;
        fh=w+JzPTDxlOAHWSy/PKS412IGe1gn8iWV/7kb7iWWXtA=;
        b=GScVP+5WSHfdDcS18Nwd2xIb8ostj7LqMe/RbQ1TFPSwbGyRu8FjRVrCHa0ZF8P6WX
         UaeR+uYmJ1CkCpsioetooA+wG7TrSiiHYTIXE8zx/1R8eOh7xATrv56T13wH31TVw18M
         YFcuIR6k3DfIFI+8dwQRLmyr783T5VR7cgZ0GJW3by7k7KFWikjCkVKZ6ISE5athygg/
         sBsF50lnY0ewJtQPCl9S5sPUJUgOmuxtQ3cC+bHN7YYHcHWrbo3ooIKZYZc3NHzXmjyN
         d2suMRKMwxS5JNJkXTJNmSCkQbjdWmJyeSOCmNMsZPdEZYkMYiWYWDjPbCJgXNSBnjww
         u4qA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787661184; x=1788265984; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j5Ct481F4wkRupatYcRj24aj8wwNlrEwHJD/XdnqyS4=;
        b=RBaM23L9MQgk9+ZaufeFEwnvYurWs7Ssr+zkOpbqY51S8ijjrv0gjPW5C80IMkUZbL
         4pgkXklBL2flWATIG10ke4KKv9r4gUChlet7+qxlzIncf5YCobkC8JWkiF9m5Xykdlvs
         bvt8p/h2+U/eg95X0QJZWhn6MCfGCMEXuGfngJOiExZFpqpoDfolmCzZXvhGxSgVlZc/
         aU6u298ywDZTqdx0HVXf06JhWSmxXJzHl0YXJfAtOIi185e9J/vqC/BhRcY5j/2qPZjY
         8M7cbvdOpowgaeNOlNipjrIC5s+p5TvYRzfervjYATt2cgO9cClWLH0Gg/Mi5DHEtW+7
         n1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787661184; x=1788265984;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j5Ct481F4wkRupatYcRj24aj8wwNlrEwHJD/XdnqyS4=;
        b=tDHCMx8X3+brLPcAIZpUnn1A45sH5xg0q8DryVf0hRbNmDJ90joJzkgPx8Npb+FEuq
         WhLmOHZhJ/pPMn8oE9cU+HTXdy8b3Hw4B++R3NU8UbN2D4YOMLnGACGesQJuyPO4VJ2Y
         h6DCdveHCM7tFBZrhaNPoAKmJMdP5fKGLpCl0mSBsRRXAgLfYTHp1+n/CxLbGjG9kdEX
         GwOVzjQz4mnxnO0eECvuvtxyNhswsVU/pAch81sAOU84aIkX9uKYafqneBiQi/id+lDV
         A2x9mbvo/oWbtAXebpbim7c8zyQ2lb3I3PkGw9CAFVqYzZYInCkIWlq/0yqnzcMYCV3m
         gm9w==
X-Forwarded-Encrypted: i=1; AHgh+Rqdg6czmtzoZuXO7udb04Bww5/ojoqc8h6kSbx/JgB/Ej5MZEQQci/hell5g5Sf+y/l2fOBv7NVqg==@vger.kernel.org
X-Gm-Message-State: AFuF++mO+WuGfEFdzYDRNH+iXe0i2wtGfN2gEWnVY1vRbl1w9jZ06a+O
	FCLIYWuqpe6B11JTeqtkF2kEUci6L2CpvitxILfIk1PDWvWZ4tMs41AcsvnShiKVsxwR/c1PWIB
	9RgHaUcA3MQBNXUVQR+uh881T4nJ772M=
X-Gm-Gg: AR+sD13jjqTuSNvj1rEM6RrKtTdjyA/gruKmvqxyuvN+X2wdq2N0DB6pV5/GOojaxtt
	ZcXbgx99RjbCwV9H45gYcSt4o6ui3wkTjKUBwtxO88DqSlTXMqkJjyEGfdm89igAvob4Ra73i+C
	GA1DF4ptg/YOktZMJwBxA8L+jS/yCe+4m6aQD0H27rkseXm1IPs47jYn7nR0PgjnA5evML646Yd
	J42WhjN1cl9+hEeOeAh7eOZhXfQuEyXGZUJh8CsOD9PSGwN6oI4i4Kwbn8gSmE5DofTQbe9mnwe
	oDNaGf//PP7t8xTD2lmHGVylPk9M/Yuzld53rWXK9Srxcw==
X-Received: by 2002:a05:690c:6b03:b0:7ba:f0d0:5e9b with SMTP id
 00721157ae682-849f4692ca7mr107963927b3.2.1787661184163; Tue, 25 Aug 2026
 05:33:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f1805c2bce56c89d8ace35f67c665b24bab90965.1787568944.git.gahing@gahingwoo.com>
 <ed82f56171bbab8b150d3512412cda12e7e09a7d.1787568944.git.gahing@gahingwoo.com>
In-Reply-To: <ed82f56171bbab8b150d3512412cda12e7e09a7d.1787568944.git.gahing@gahingwoo.com>
From: Igor Paunovic <royalnet026@gmail.com>
Date: Tue, 25 Aug 2026 14:32:52 +0200
X-Gm-Features: AcwNN1Xtzi2WJl1KccSUfPCnVd1JKytTLunfgDKRxF-zeJjSJm8murTNkgUrOck
Message-ID: <CAEWPSH7AcRb4uAnhmcL+kk3mQrgqYsQAYR=JQjJdkFGVK4qfHw@mail.gmail.com>
Subject: Re: [PATCH v9 05/13] dt-bindings: npu: rockchip: add rockchip,rk3576-rknn-core
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de, 
	ogabbay@kernel.org, zhangqing@rock-chips.com, u.kleine-koenig@baylibre.com, 
	chaoyi.chen@rock-chips.com, diederik@cknow-tech.com, alchark@flipper.net, 
	dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
	iommu@lists.linux.dev, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiaxing,

One small thing I noticed while applying the series for the
RK3588 re-run: the cover letter says this patch carries a git
note naming the base and the one prerequisite, but the posted
mail has no Notes section - perhaps format-patch ran without
--notes. Mentioning it only because Rob's bot asked on v8 for
the dependency to be recorded in the patch itself, and it would
be a pity to collect the same remark again on v10.

Regards,
Igor

On Mon, Aug 24, 2026 at 1:10=E2=80=AFPM Jiaxing Hu <gahing@gahingwoo.com> w=
rote:
>
> The RK3576 NPU has two cores of the same RKNN block the RK3588 binding
> already describes, but it wires them up differently: two extra CBUF
> clocks, two power domains per core, and a single reset instead of two.
> It also has no NPU SRAM supply.
>
> Widen the property ranges to cover both, then pin each SoC back to its
> own shape in allOf so nothing loosens for RK3588, and keep sram-supply
> required for rockchip,rk3588-rknn-core only.
>
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  .../npu/rockchip,rk3588-rknn-core.yaml        | 47 +++++++++++++++++--
>  1 file changed, 44 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-c=
ore.yaml b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.=
yaml
> index caca2a490..3b611b64c 100644
> --- a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yam=
l
> +++ b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yam=
l
> @@ -21,6 +21,7 @@ properties:
>
>    compatible:
>      enum:
> +      - rockchip,rk3576-rknn-core
>        - rockchip,rk3588-rknn-core
>
>    reg:
> @@ -33,14 +34,18 @@ properties:
>        - const: core # Main NPU core processing unit registers
>
>    clocks:
> -    maxItems: 4
> +    minItems: 4
> +    maxItems: 6
>
>    clock-names:
> +    minItems: 4
>      items:
>        - const: aclk
>        - const: hclk
>        - const: npu
>        - const: pclk
> +      - const: aclk_cbuf
> +      - const: hclk_cbuf
>
>    interrupts:
>      maxItems: 1
> @@ -51,12 +56,15 @@ properties:
>    npu-supply: true
>
>    power-domains:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
>
>    resets:
> +    minItems: 1
>      maxItems: 2
>
>    reset-names:
> +    minItems: 1
>      items:
>        - const: srst_a
>        - const: srst_h
> @@ -75,7 +83,40 @@ required:
>    - resets
>    - reset-names
>    - npu-supply
> -  - sram-supply
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: rockchip,rk3588-rknn-core
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 4
> +        clock-names:
> +          maxItems: 4
> +        power-domains:
> +          maxItems: 1
> +        resets:
> +          minItems: 2
> +        reset-names:
> +          minItems: 2
> +      required:
> +        - sram-supply
> +    else:
> +      properties:
> +        clocks:
> +          minItems: 6
> +        clock-names:
> +          minItems: 6
> +        power-domains:
> +          minItems: 2
> +        resets:
> +          maxItems: 1
> +        reset-names:
> +          maxItems: 1
> +        sram-supply: false
>
>  additionalProperties: false
>
> --
> 2.43.0
>
