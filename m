Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E64043E497
	for <linux-pm@vger.kernel.org>; Thu,  4 Jun 2026 12:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780575940; cv=pass; b=nkURnFRy5btNfXe54tKS82RNZh4/FRqVcBOzpTt/gwaIei/1+vP+4DVN5xRPuuAUBX8HPhjszgo6201k7+ZC47eemx5pZnbtL/lJzDR4qGsThFaW9fiMoSpz6aPjgW3lTUWFMXZZ4pznsTXFJFPlqnpKmOvDhDRDoS4tSgsVZxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780575940; c=relaxed/simple;
	bh=QXg9S3LANuU2Vu2CwL7ml9RG3pg9mmdQqBn/HO6HYQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ng5X6ejTF2t5AcHdg6HT2z2v1UyEz7GLWy2YGeY/NUhXWZnGCCK3D9F22y2BA664XM4XK/MEM44PfNso6QrSBNHlqD4SLvBPKO9kEVu7NgsFGDxE+0y6OmMH6yhVDHr1dHe/VMhKg6nvGMV9SBgblVzbR8P7HbXHqx+9ziLnhPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VNrKS+F5; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VNrKS+F5"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-68b90fc6a1dso747843a12.1
        for <linux-pm@vger.kernel.org>; Thu, 04 Jun 2026 05:25:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780575936; cv=none;
        d=google.com; s=arc-20240605;
        b=AA4O//gYTULOBqYwKHmjNe21YxpwGa8WEVn6bDk/5EL+4vF0jIytMxSpwf9Pnpzq1S
         YbVQ7LGisADP6KAw9jyaU9/0yF8aRRLSPl78d9ibMcXIA1HxXDA1tTsl3wc4tTgyUIvG
         KhwyYxmI+EqKW7lF4+aE6SsQ1aY0S5QM7QGQo0TEb4nI8aLXclMN12WgwxKon4C0Y2aj
         4PdbnC9ELR5JzwPnyp0OP8t1hGyMZ+y1XjHCzbl11h5rzZbm8aojWVM46CzqnvKh0CvB
         1IL9iIv1FudCKUB/oaSH8XRf+dedf5brjVUks784hj33UFTl8tYJliv9SvHktjYjXfCh
         C17Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=knW0aQIBp4ONXOIx4MTZpzmtpQjVdTKmzR82B1HLZdY=;
        fh=op9D3XyVg2SPs/TqRL7mbvuCRXh6T37yKcK3X42iYQE=;
        b=KasmkOJlqBuLMNdL6vRWfdpk4BUA2+KQ6myPoaRF7FulW6WzP2nyIt11ZpQLyN+MPR
         i27o4+IClTHfgULML26focXTuwVJ0IMv732MQOAvewAoLmJ1imTT2pC7WoeezDaRM4kK
         7Vi9yQ5EuNUvukaT+SHoT/tDIegrfwknlpiyWJs3PezXc5RC4v8GWglDX4PCadDkOkYh
         c0XKaVnsJ8Eup+GQcwczu7ZqWFhgP2N0VAJM65bJKnS13XZFbZUjLfU3k9NgQsGSS+uG
         a5iysdWCBmlfNKYbObt7Gq10990y9JkX4bbYjhaObYLTva/yybHm/j+ndKmW2nVwTbSw
         1GbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780575936; x=1781180736; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=knW0aQIBp4ONXOIx4MTZpzmtpQjVdTKmzR82B1HLZdY=;
        b=VNrKS+F5Q/MjcXlX0j/M0qvcolEc5C8XWATfjY3gaaCFWwg2vK2Evo3JIiAMObMPdY
         5inFXiO8SfKHFAuzsDNFOwybZV2xkgMrXpJxBzRgKvXINWORM0AVzr3LNLKefIB1xR9M
         OJDyeItVdF+aMiCL+PBnBbP+qS+Ao3Sc7SGxbFnLCN7HlYT1KYxSA3Cxdc3+2AAQwbG7
         IFXA5OCQXcSr+mDSwVxdUirtrs+ESNJlBPb4G9ZWZcPWdB6hv9I5hJYIBfgORf0zzKjb
         QU2tBJh+3O2/RFVFsJFDgFNowFbj7Dgn0ZL0eWjfHtZTiSyst1DLTalXaF/vlr8xDgyf
         0B4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780575936; x=1781180736;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knW0aQIBp4ONXOIx4MTZpzmtpQjVdTKmzR82B1HLZdY=;
        b=SrcWWPkFzAcwZcyrgs53kGpzRGT6yoGxu2I2IS4OS/diyQwr/KLl0z3+zVbL2VGlqt
         wjMoMR8Q1ApH3ht9Lnx3HKkxfnvpnAF94G5inEeBbzXQ58/WxAGsjzbI3IQUpoqzU/HT
         MxEnnxam2xvUJgvoEGi7A/473IqrMBp2q8SxQVPRqCiz4ln2fqWLv31M/UATiBe0/V15
         n7GyfbLOM93jaFNb/HHKFMtTrdjb4rLhaH4ZM+aCrdc7fPbuSuD16wH+aeQGWyPxOTKM
         4lGJA6wSHu8CWFrGc8nKk7j6ZSTnD1Hg5M1V5YZzsHKEbOubUAxYeCSJndV9UlDpGe7l
         4seg==
X-Forwarded-Encrypted: i=1; AFNElJ/6ce29Rjaj2u8ihL9r4tC/tNGWgBVKkOz2epbXHp3Mo4v4XNl3y5UILm1l0wvbSjXozrbeRNt/rg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJrVcvuCNSn6IckBXlYmtw9CgP0HbTZx4seC8CHlLBZStUMzlu
	AptdupqYkmGJCXzlReWGMwtjbMnq57ONrVuQzweCPFzDfKWCzNzTd9vPKQe/dOT+AwA6BLJKbE1
	ywYLNqKv18A06pMu9wWyQXdEm/L2P7kzbeh+v+n5R+w==
X-Gm-Gg: Acq92OGH0LopabpnNyu9Cp63Do/3s8ImmyByVQ7IBxVYUH4Eq9L/VgRf6tBKha84AKt
	9oiPPEbwwwDkut0Jv7Q2/NMvPhZiamaBjLd6neNEsLQ92luUZ/aA7QBaIPNPC8Xa/KCWFBV/MOq
	aYYoA8w9mUo7RNzGmrBwF/5hsRIufnOBwltGMvNSGprSJzJw7W2I7+jXaKuIEdMKSdbHxlVCyYv
	MZcbpmkAdH+3wQPNuw3pZqc/SrjYz22PCk4GX2NkBWrQzXbQLqqAxgK9zPZNekwzj5MQmLik13l
	8mSsnjkwm4Tad+AElQNHyKURZj7WM29S8HUgPbJTKwp1nkSR
X-Received: by 2002:aa7:c3d8:0:b0:68c:3439:945f with SMTP id
 4fb4d7f45d1cf-68f0f3ef6c9mr1109192a12.12.1780575936462; Thu, 04 Jun 2026
 05:25:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603-acpm-tmu-v8-0-0f1810a356e6@linaro.org> <20260603-acpm-tmu-v8-5-0f1810a356e6@linaro.org>
In-Reply-To: <20260603-acpm-tmu-v8-5-0f1810a356e6@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Thu, 4 Jun 2026 13:25:23 +0100
X-Gm-Features: AVHnY4J8PoxEVn9YHkIV62f2JcL-eq6_poQLFyumkGxMP4pQHp8fyUwqwpP8j1s
Message-ID: <CADrjBPqXnv97XX2y-_YKi4=NCJw5CcaBd5b9ibQEHLZ5N6ZYkQ@mail.gmail.com>
Subject: Re: [PATCH v8 5/5] arm64: defconfig: enable Exynos ACPM thermal support
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, jyescas@google.com, linux-kernel@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jun 2026 at 14:00, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>
> Enable the Exynos ACPM thermal driver (CONFIG_EXYNOS_ACPM_THERMAL)
> to allow temperature monitoring and thermal management on Samsung
> Exynos SoCs (like Google GS101), used on pixel phones.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index d905a0777f93..3fe76a4c2633 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -793,6 +793,7 @@ CONFIG_BCM2711_THERMAL=m
>  CONFIG_BCM2835_THERMAL=m
>  CONFIG_BRCMSTB_THERMAL=m
>  CONFIG_EXYNOS_THERMAL=y
> +CONFIG_EXYNOS_ACPM_THERMAL=m
>  CONFIG_TEGRA_SOCTHERM=m
>  CONFIG_TEGRA_BPMP_THERMAL=m
>  CONFIG_GENERIC_ADC_THERMAL=m
>
> --
> 2.54.0.1013.g208068f2d8-goog
>
