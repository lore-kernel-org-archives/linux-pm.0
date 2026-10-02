Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB243E2746
	for <linux-pm@vger.kernel.org>; Fri,  2 Oct 2026 18:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790967353; cv=pass; b=UoEtWVM2bKDAClly1F4VlL1Angj/dZZPWP5zpgS/e5OgJWFIuMrdbP48AJ/XuSqvn7nOuLe3lyhqOrnP/bK11KV0Aurzu/qrnEZDTjF9lKogD7RmNthPFUppdX0lkhoMQY4/cM+M7c8APGXe9EVTmvkwi0okG7z1E8jWqM9DXvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790967353; c=relaxed/simple;
	bh=OR38zRZFAFpy4mOZaFXDsm6BWL0amMVzyna9ToNEKKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ifgCXv95Stb5ZdwU7hSVsZvF+e4n3yR08Zn+ZWuedekD3cDU61ZyNTfsp3DIDzjQ1RJ1K+s4OTrmwpiUajt3zIhjqm+xkzsJoypmJ0iCMBjbAHqhW+qpw837FV5z6R+uavvngQRGGcSCSxT0/HdnLozi6WkI8lLCaFvyg8eiueQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixtdxi2e; arc=pass smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixtdxi2e"
Received: by mail-yx2-f42.google.com with SMTP id 956f58d0204a3-672ce86b21aso448754d50.3
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2026 11:55:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790967350; cv=none;
        d=google.com; s=arc-20260327;
        b=N/1EPwNfNp7VEypVggYNI47YQeXp42T3QqE+MwTOrx4nEouOB4t6DOc0HbuNgq8/4+
         xXupVH2JIK5HrXvjR5GPxCJAr07xheF4sAB99WkYHbwPwhcuQ5bXW6Bs8eCAVfUHMohv
         MQcnmj2XkL+qZneZ50w2Xe/QzKlX/liYZ5lQQ0wTA8Ww3GE4Y3dyZG1qTgB9uNQoOHcP
         5XjaxK4c2LKbUxN7vZsXYfUpfnpRuMywoyGbKtx/qsUwgbphUo/5PKKZVXo0nDpIGr0f
         83wZ3Yyz9Bv1tQPEcqQIWcBqqz+wD0K+UnvDYUOSW70oNNWHi3glfZ/6Gb8Pq+0UKfHc
         /ClA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9S5eAE312pd6HZl9cjvi/BgiTHAVYy5cEZ8AWzWw5xo=;
        fh=YXfdnVsKSh1707a96+7w1hOqXTfP+E9zcyb6NuTu180=;
        b=Ug/bmfNsR/8oV7/WUSkCdg40g+RjAeI5JO1O0jZxCgKLh6slMm8Orq6t9/xx6g55jp
         lywtZalyjpTJ/1baWi4L+L2umuWV6tuwh0mehAO9uD2R/2E1/bU+t41Z0g5diWJBr3Eu
         L+N0+vYJQOLqkmIEuZDfsLwqDLUTEb0yEoRRCRqv4kml7CF2gymBnk31hKjJ4/TKtriz
         pG8anNbwONeAeAXfT7WzcHfDQYMSO7mciLsPINa01auXcikwa/L2rYpPyBUMHZ0o/p0I
         oFhRmnyljT4sDFX0sdM1UY/igCYxAJbSdY4aQQNkAisqnvwMtsnxxFHZ3NDoiDijLO1y
         kQGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790967350; x=1791572150; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9S5eAE312pd6HZl9cjvi/BgiTHAVYy5cEZ8AWzWw5xo=;
        b=ixtdxi2epUtKkuXGhSUNb8u7gi3ElY1KdTNYlhK+kZJUHuWz1ZvjK34YDV6lujj/Up
         GSLFC0IAjjq4Ixdmv7MqjzUtqTK8oyDqJzOvg89I/oikJqNofFCRxql+FNBq1lhsUNfr
         Mx63HpGg0Hnnvy6xYrQPmImodN190UZSNgdMUu+EGiBAXkkLW511auUv0DD7tU6M6u16
         uinBUCCSShX9Gkz95Fvx78wvnLoVxtU3eT+GzXvOT6BeoOte2+CunvbWjSgteAMhe1US
         JnopbvRys2LTPbnL8H2ZeXp7OeRuTQSQihOV1IeiHnNFglSX2LX2xTNqu+WAgPxxh2cq
         Z3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790967350; x=1791572150;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9S5eAE312pd6HZl9cjvi/BgiTHAVYy5cEZ8AWzWw5xo=;
        b=W4MXpONImdfGfszRcH2y3qouBiuzaVgJRMi2Dx9XIj63de15gLgVJ5A0VnJyAlnmJZ
         4ml8Yis/bLSb3r5yoYOPxXc4S33Y8Ltik1tukGg/LOy92GfS2MB3FQSJx25Ma2EoAx6f
         QSE6QRaBqHcggzUv67GIiD3jYhaWaOnyJOgWbG/0zUqgozKdOD/t0szNeejfpTRyyMxi
         4kfp943GjhM54D9qdzii2YM6hXUL67XEYTGq92p48MAoiBdd8VIuMRDPKXsMvEx2trlP
         EfEavqopoSI/ZCdUrd006D1ELys5XwJs+d5RFlxf1Ocfifb2uiYyiu9PmCJbJWiFl278
         OgDQ==
X-Forwarded-Encrypted: i=1; AKwUvByMGO+QvynAJSFPzlyzb1oMXae1B+bR0v7hct1qZbsR48KbskWL40MRiSlWyusjp9iRI7aN3yG4Zw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLUEnfXDwR8Hrle4R7MMdWA9gZ7+P8Nrgd+D6/3CSpmEBBd/cZM
	fuFC7zRc0rwsvoHR7nYMr1NVQce3FnA3xgSEWoKNcR9brYMlfGdRkJgpn8wOsmFv8+tJBgJgAAB
	bqwAWZq5NKjzshC0xgZecvfS5nRdDPqM=
X-Gm-Gg: AYBFou0AKUHCxPWqnJjEom58gI4hxPj6+Dos3GIJ4dRxuHjibGGAxihiOLNsLLcChlX
	I6/GfwP7A/OKstzIRggsaQHTlEJYDZeuC0FaA1OlNxNIgfAsh04eGf4LlQlPccUbp2Cm/OCQtHk
	ph67TGuZzTGYuCutnHwfjTRLwfYTdW8BW0gdpsePFukVhnYVQ502pIqtMcrbJ/7MzJO1VjjapXA
	4fBYk6CHOIrdbmQ0fuWDsP4WKt+nw5M1X/xmbQa7dr2i984UZc7EMIDgnNJj6d0vF10g1Ya+tYS
	5rCRsTy8ozWT3YIXq804NpjDLAGZrR7scC1nYyduw3quxeBM05/3ADLu
X-Received: by 2002:a05:690e:1243:b0:677:b7e7:f68 with SMTP id
 956f58d0204a3-677b7e71be5mr813923d50.108.1790967349727; Fri, 02 Oct 2026
 11:55:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918-04-k3-pm-support-v1-0-0acd2b36b96f@kernel.org> <20260918-04-k3-pm-support-v1-2-0acd2b36b96f@kernel.org>
In-Reply-To: <20260918-04-k3-pm-support-v1-2-0acd2b36b96f@kernel.org>
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Fri, 2 Oct 2026 20:54:00 +0200
X-Gm-Features: AclHuK9ruP21ynPDiadHS4oYScZ4A0eIuHPpImnDhttohXSuBO4BfsPMVhy9WRo
Message-ID: <CABdCQ=OUTASG8JDBqnJAPJ5aTDUC-BQzCVcw0r=cxrb8CPUO2A@mail.gmail.com>
Subject: Re: [PATCH 2/3] pmdomain: spacemit: Add power domain driver
To: Yixun Lan <dlan@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El vie, 18 sept 2026 a las 7:49, Yixun Lan (<dlan@kernel.org>) escribi=C3=
=B3:
> [...]
> diff --git a/drivers/pmdomain/spacemit/pm_domains.c b/drivers/pmdomain/sp=
acemit/pm_domains.c
> new file mode 100644
> index 000000000000..d563e4e4e232
> --- /dev/null
> +++ b/drivers/pmdomain/spacemit/pm_domains.c
> [...]
> +static struct spacemit_pmu *gpmu;

Would it make sense to embed the 'struct spacemit_pmu' pointer directly int=
o
'struct spacemit_pm_domain'? Other generic Power Domain drivers (Rockchip,
QCOM, Renesas) use this pattern to keep domain callbacks self-contained and
ready for multi-instance SoCs

> [...]
> +static int spacemit_pd_power_on(struct generic_pm_domain *domain)
> +{
> [...]
> + regmap_read(gpmu->regmap, APMU_POWER_STATUS_REG, &val);

Please check the return value of regmap_read()

> [...]
> + if (ret < 0) {
> + dev_err(&domain->dev, "power-off domain: %d, error\n", spd->pm_index);

Typo: should this say "power-on domain" since this is inside
spacemit_pd_power_on()?

> [...]
> +static bool spacemit_pm_get_state(struct spacemit_pmu *pmu,
> +  struct spacemit_pm_domain *pd)
> +{
> + const struct spacemit_pm_domain_param *p =3D pd->param;
> + u32 reg, bit;
> +
> + regmap_read(pmu->regmap, APMU_POWER_STATUS_REG, &reg);

Please check the return value here as well

> + bit =3D p->use_hw ? BIT(pd->param->bit_hw_pwr_stat) :
> +  BIT(pd->param->bit_pwr_stat);

Since 'p' is initialized to 'pd->param' above, you can use 'p->bit_hw_pwr_s=
tat'
and 'p->bit_pwr_stat' directly here
