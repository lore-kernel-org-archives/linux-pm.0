Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D083364EAA
	for <linux-pm@vger.kernel.org>; Thu,  8 Oct 2026 17:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791481296; cv=none; b=t6Mb91ek9aT7a30To2Ggr6o4sLlV4wu8x17jADfkkDymidKRIvaVt900/CTRxlL78u4kj8O+5+hsNv21yD0LR1U85L3LcVzgtaKZyiqo+Lq5zk795CenEthXQp7GlhKhAjReb+lNbHN33TQTVwD/qYEDevZXFzsig7d8Lc/XJ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791481296; c=relaxed/simple;
	bh=tJyXfCgQWKJoJW+jidNyd1FNACSo0ZNPY5I2bQmtnms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eCpSPV4A8dgLRwSf17V25MAbVpAL8KkmG7/SSCZSolsT1Avr8E8pE1H4Ov1245TrmTOxmHOka4PWf6RI7d91asxW/Bcgb1FAoY/psDZo4Pw94XPLr/3e+96lrgfvP5C7wJkwePDTqYWXHhGIInCp6ES1kBqUBubxCtBZ3uVdnLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfpLiDo+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfpLiDo+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC7C1F0089A
	for <linux-pm@vger.kernel.org>; Thu,  8 Oct 2026 17:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791481294;
	bh=5i+jUBNJvJIFB5HiIYZuQDmQj7HbLmugYNNn4gZkj88=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=QfpLiDo+ScFtGJGP/5JODLI0pv8v5KZVTe3aJRCgmwNneXmkgfhJBnTBTYaSE+lTT
	 +nZwnnkZq3F682cP6EqkDvLOAmz6rEvskLWzPF+Qz6cUZHR0oqmArJVkOL8+ypYJBJ
	 tEksKTJ7nr5OGgwE6kEJKpEbyJsSfseOrtKGq+gqPa9EanBqd8g0deddbYDuBD2Vpw
	 2B2piO9VomrzAyAoubg5+a+CsmEO/iy++UgxqNVbbWCyoDlpbRyUxxgi0pepT48rF0
	 ve7ESnP+YoqLfYBd8ZdS7lxCAlp4v+SEG48ztNI+pTxA0/FHwnqlItwIJ3uXrn452X
	 pcIwYkuYyQ83w==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c31988fc977so117272166b.2
        for <linux-pm@vger.kernel.org>; Thu, 08 Oct 2026 10:41:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByAQ4tBDPjJBSzSphCZxqrKcyWm0ih4AOkptAF4pShGIcHHr51tnGqNa4kWBLFekm+zEmR32q7FnA==@vger.kernel.org
X-Gm-Message-State: AFuF++mCDfDiRZzeZgREXBlsEAYSgia9cpYIxqotnOGTY3h7EHCMm5Zm
	P6918os9A/qmmYo1nvSdgTvQc/Gmxv31Me/Eca2Hn1O4NG3PyLbwkvLmnSBKfllOvcVcV9yjGxH
	5MJ+BZu4Xb/giTuSDCfE4YgSHM8Ph0g==
X-Received: by 2002:a17:907:961e:b0:c2a:34fe:ea4d with SMTP id
 a640c23a62f3a-c317c0b85e3mr582174866b.25.1791481292967; Thu, 08 Oct 2026
 10:41:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org> <20260921-ux500-power-domains-v7-1-v3-5-9352be6b86b1@kernel.org>
In-Reply-To: <20260921-ux500-power-domains-v7-1-v3-5-9352be6b86b1@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Thu, 8 Oct 2026 12:41:21 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+1O+os8=YGUoKg6zCm-r0gQ35baKX=z65uTQNB0i=RVQ@mail.gmail.com>
X-Gm-Features: AclHuK9f1ZliBZPCj2LPLQU47t9EaM2IftpsDD1GQ_Z1aWMRTo5dRurMLb5PWy0
Message-ID: <CAL_Jsq+1O+os8=YGUoKg6zCm-r0gQ35baKX=z65uTQNB0i=RVQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/18] dt-bindings: display: ste,mcde: Allow power domains
To: Linus Walleij <linusw@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ulf Hansson <ulfh@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Lee Jones <lee@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	dmaengine@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 20, 2026 at 5:48=E2=80=AFPM Linus Walleij <linusw@kernel.org> w=
rote:
>
> Document the MCDE power domain.
>
> Keep the legacy EPOD regulator binding unchanged for now.
>
> Assisted-by: LLM
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  Documentation/devicetree/bindings/display/ste,mcde.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/ste,mcde.yaml b/Do=
cumentation/devicetree/bindings/display/ste,mcde.yaml
> index 7a12d0b817e6..05e7e4ebc882 100644
> --- a/Documentation/devicetree/bindings/display/ste,mcde.yaml
> +++ b/Documentation/devicetree/bindings/display/ste,mcde.yaml
> @@ -35,6 +35,9 @@ properties:
>    resets:
>      maxItems: 1
>
> +  power-domains:
> +    maxItems: 1
> +
>    epod-supply:
>      description: a phandle to the EPOD regulator
>
> @@ -109,6 +112,7 @@ examples:
>    - |
>      #include <dt-bindings/interrupt-controller/irq.h>
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/arm/ux500_pm_domains.h>
>      #include <dt-bindings/mfd/dbx500-prcmu.h>
>      #include <dt-bindings/gpio/gpio.h>
>
> @@ -116,6 +120,7 @@ examples:
>        compatible =3D "ste,mcde";
>        reg =3D <0xa0350000 0x1000>;
>        interrupts =3D <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
> +      power-domains =3D <&pm_domains DOMAIN_B2R2_MCDE>;

This patch is in next, but the define is not breaking dt_binding_check.

Rob
