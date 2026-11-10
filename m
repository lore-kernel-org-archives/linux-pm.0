Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794338829;
	b=wUYedZEOMmwVLpwbKfXLj+585dq1MV6aYBdgo9r0Qx+JHRjx6f9sJEUaHnxNCI2t/aE+
	 sp+E32N5YvmShdvxDTzH1yOIjN7/NoswBoXnuTISEEpmyxzmnosz3kbyDTn6+DbwteDos
	 HRXo1dDbvZFksqBLeWhIpynXVz7I3pOHZiCLJjSoZ9WBw3HvbqnSqvRlMf/WTkFDx5dah
	 Vb06tKAGdZsIXSsqQy4+duEiPdQE1fvCPZMK4AZ/kaONM10jmfbPg7EkB635SMQFGoPPj
	 1qlsY7MGr6opcy4QMqj/yWEW9CF3GrrRAJzMSkEUrPMC8pMMJ+HG6Q+GX08j53E4nQQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794338829;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=3BDn6wwNGszSOSWtixkkwMS4uvVtcI6x5Kvm71JPIW0=;
	b=mzpvsrD62d8yzoMvK5y7jqduS2e+gfE/J8QIpPfYgJAylniP0wdVZOd47mvE0M0alIt2
	 VkHccDRWZOzqHjmnkYSKdc1pXV/a1ZHqmvAiQSQrGsMKqzRXLWH7MtR//pbsWsfUB5xSU
	 cKR/aTY2S5CZD7cj6EIVBgH3ewJyxjAvUVQBnF0JosLWUoRyCYXgEfGqlQuyElhSdIfYp
	 MT/ipaNOb2SEnI29jvpKfG6TlnkiD5h6NK52L+gBOPyVbjg2HeXu2tC5emaSXwbHKyyeQ
	 ezdyKvF1wf76bdsCdDA8pzu9ZdAWWwRrgpmw4wE+zAy4NiA9+jaD8jDJeL12C9teUxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dnMneL+X;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D37606A321
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 19:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92D37606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dnMneL+X
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8b305312e4fso20951837b3.2
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 11:27:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794338827; cv=none;
        d=google.com; s=arc-20260327;
        b=onZfxL14wyNzsCdtQLMV50SKcgs7hOaS42D4pccQV6akeudAysNx0h7WM4bxGaAfag
         4kupOKENljLpcIxckzwKqMC55jvkZmfFGURg0hWmB+HTcviPkxe4dhUWUF0guyi60bsz
         rx+ctqMANdJyjqjzFqXpKYGQjpq+soLom6IHie0JE8LBYIzZaEGBAyk224yXSb6KNIc8
         1u5+0NOMWetL9Si5NN2auaUGD4o2ti0YG/Y9kXC9Pwy2xOZIGd0OBwRy4Bqjw2FMoLq5
         YGlOClPzOikYZYXmeyb9RBo6xSJJbuYontaswlggyEs548XwqQ2ls/AU1ArAcwKx0hpO
         Kthw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3BDn6wwNGszSOSWtixkkwMS4uvVtcI6x5Kvm71JPIW0=;
        fh=6Wl7yomAatpboec9qIllxxWtt6va29XzMS97EiVQyv0=;
        b=JRM921d8IrfspQLaNUNpT+m5DB2SUs52uGQGVsZ+QsCFZWR1b8RS3h8hBd6LoZm7bZ
         uEIifFKWJ724uZ9XoSn92Io4XGo41e108lEQt3/ctbBI10Mt46GNS2jpdDwonSNb4yOh
         QnJ71K8Y/04ifgbTpxuHBSTmUO57OxciiEP2zOfy/Buamzq4in9zG4QRu4g/BBSzEzZm
         OV9u8oNceN2qzOay1ydGwl0O/CcXijttuAxli3n4oYjHL7vqVAfRrEw98hfnap+B6exi
         Je5hmEei6qUXJgqh8+YFW5pkyxEfPd9VHkggYkTIa33wE74BLsjGNJ9fpG+5TGKYrxj6
         J1gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794338827; x=1794943627; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3BDn6wwNGszSOSWtixkkwMS4uvVtcI6x5Kvm71JPIW0=;
        b=dnMneL+XJ3b1M4ASEHVeuj/dVeY2gNNpVmeesPydhdAKdVnhdMuWsMS2adyErQNl5+
         6TVNx+2AvYKqYe/fl5pbLnjtqnejCsJ21xsM99vnAbhbg5Ho+l9qrYeZad1mMorI/Gz1
         i5JcBPTsWk4EGjljE9dFTRiF8ILW9SYAd8yrz3vKTc6qVuRGY6R6ZKgJS17+GBFRONMG
         HmPfc7YHrg6mnYIusa5ZjjYxi9sMHWe5DnLwf3LQf6cjJiMdesu309BbEhoDV5gD+vrC
         /w7NI7KcdAggclYNuqWrzPHH6nEQuax1wWB2Lj2k2BAVU1VCUYKr1VD51VJ5W8W25Xao
         mZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794338827; x=1794943627;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3BDn6wwNGszSOSWtixkkwMS4uvVtcI6x5Kvm71JPIW0=;
        b=1kg3dphm9UyEMM6tfCU5qYfLHx3zAsWFLwHYcwEnqyNzhb1xfzSUXTJknoqLUxAnev
         ygfGqlZUhHk1BZj2u5cogOQai1nb7c9nQd1n93ECcCo5zQLQcK1pY/OrljccjswzcxL0
         NKd74SkOa8aHv+uzN9puUZjpRLQ+8xZkPwb3z5gfrxFQtuyrJY5YcuX1z+M/ALmtaR/0
         WUHgZECrmcrOcKcWJd5IREWa3YqbgdCpdhzon3H95UYpz2Lr76UdnhQ2Xj4HixIipVGC
         oUlXiTPvRQEMY5UiQ8F4FMwQh/abXu0Xd2qu3guJ8XPtFBQdM6CvRAsluCWVOask5+Qf
         HN1g==
X-Forwarded-Encrypted: i=1; AL+hErFQdkLCvbdQ4vOIhaNdqTWrlq72QcgvF9oIHo2qDMGQiSV7Bah5MJhw/+TTcYuTgqYncL2HnTxlJw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+mcQJcSJCpvYOFe/diBGMe29xxD8nPOPcZcNFOuXTrlD8k+9B4
	Q9VAZF3wKUPw8yedboFn17UQlKb3PpLZS46K4wRUhAjoufb5YfswfTfRlH6u3otEQFl3sRnopZh
	uwZqNCXMU3BqWFZjk4jmmYtXBObYdQ2E=
X-Gm-Gg: AYBFou39Avhp3qDjxC5yiFJJek4tbLPvNwAHtUb3P9u+0n802T3+nS/M64uOWnqzjeQ
	FHEcfuz91fLOLJa9CA2Xvple3IQovRnEDTVD8Beg49iG5WFbxPZigJv0Z1IFop5umdrI/b+b1W6
	T4itR8l+FXgOO/NdkZ/ubovy39+Yum1pslriDcpNKSDvclaE9378IvjqT4nNhGEpLXOmKP2onTY
	StYC1xegvCmKqZgnHITsSgd6VwCGpE7aRFbOSkRt2ANoFxQQvZ2QdPDFuRx62t2hkjOYmV72QYZ
	Y1AMQC5kJlNAs3dAst7/uy+RxX/LowjaMqJN/r/E3sOOqY3K7ZcNvK2TCFm8KZ9D1L7gZE5NT9O
	1AqVimrzDVxWfs3iDzfGZntcYtdyUTtCWEARbeQ==
X-Received: by 2002:a05:690c:438c:b0:8a4:be24:f233 with SMTP id
 00721157ae682-8b3a80e6b9bmr1379417b3.46.1794338827449; Tue, 10 Nov 2026
 11:27:07 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108-04-k3-pm-support-v3-0-b9dc0857039b@kernel.org>
 <20261108-04-k3-pm-support-v3-2-b9dc0857039b@kernel.org> <DMQHSDTR177I.1HWHAF4FWTFQ5@linux.spacemit.com>
 <20261110105658-GKA2005@kernel.org>
In-Reply-To: <20261110105658-GKA2005@kernel.org>
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Tue, 10 Nov 2026 20:27:00 +0100
X-Gm-Features: AclHuK9GBj1g-yv_7rKhtj60GYCKBcJP3tjfjvEauHRa7ZWcjceK1ew77-uBX4s
Message-ID: <CABdCQ=OGejVS-r2Cuod+0EZf148g_-2Y8=tkLqbK-QRn8UH+4A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] pmdomain: spacemit: Add power domain driver
To: Yixun Lan <dlan@kernel.org>
Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Icenowy Zheng <uwu@icenowy.me>, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for addressing the feedback. The series looks good now.

Reviewed-by: Iker Pedrosa <ikerpedrosam@gmail.com>

El mar, 10 nov 2026 a las 11:57, Yixun Lan (<dlan@kernel.org>) escribi=C3=
=B3:
>
> Hi Troy,
>
> On 07:12 Mon 09 Nov     , Troy Mitchell wrote:
> > Hi Yixun,
> >
> > On Sun, 08 Nov 2026 10:36:02 +0000, Yixun Lan wrote:
> > > +config SPACEMIT_PM_DOMAINS
> > > +   tristate "PM Domain driver for SpacemiT SoC"
> > [...]
> > > +     Say y to enable device power management through PM domains.
> > This is tristate now, so "Say Y or M".
> >
> Ok, will update
>
> > [...]
> > > +#include <linux/io.h>
> > > +#include <linux/err.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/pm_domain.h>
> > > +#include <linux/regmap.h>
> > > +#include <linux/auxiliary_bus.h>
> > io.h, err.h and platform_device.h are not used right now.
> >
> Ok, will drop them
>
> > [...]
> > > +static int spacemit_pd_power_off(struct generic_pm_domain *domain)
> > [...]
> > > +   if (ret) {
> > > +           dev_err(&domain->dev, "failed to power off domain %s: %d\=
n",
> > > +                   p->name, pd->pm_index);
> > > +           return -EBUSY;
> > > +   }
> >
> > -EBUSY drops the -ETIMEDOUT returned by regmap_read_poll_timeout();
> > why not print ret and return it? Same in spacemit_pd_power_on().
> >
> Yes, I think it's ok to propogate the err
>
> > [...]
> > > +static bool spacemit_pm_is_off_state(struct spacemit_pmu *pmu,
> > > +                                struct spacemit_pm_domain *pd)
> > [...]
> > > +   return (reg & bit) ? false : true;
> > return !(reg & bit);
> >
> Actually, there isn't much difference, your version is slightly short
>
> > [...]
> > > +static void spacemit_pm_domain_cleanup(struct spacemit_pmu *pmu)
> > > +{
> > > +   struct spacemit_pm_domain *pd;
> > > +   int i, ret;
> > > +
> > > +   for (i =3D 0; i < pmu->genpd_data.num_domains; i++) {
> > > +           if (!pmu->domains[i])
> > > +                   continue;
> > > +
> > > +           pd =3D to_spacemit_pd(pmu->domains[i]);
> > > +           ret =3D pm_genpd_remove(pmu->domains[i]);
> > > +           if (ret)
> > > +                   dev_err(pmu->dev, "failed to remove domain %s: %d=
 - state may be inconsistent\n",
> > > +                           pd->param->name, ret);
> > > +   }
> > > +}
> > [...]
> > > +static void spacemit_pm_domain_remove(struct auxiliary_device *adev)
> > > +{
> > > +   struct spacemit_pmu *pmu =3D auxiliary_get_drvdata(adev);
> > > +   struct device *dev =3D &adev->dev;
> > > +
> > > +   of_genpd_del_provider(dev->of_node);
> > > +   spacemit_pm_domain_cleanup(pmu);
> > > +}
> > pm_genpd_remove() fails with -EBUSY while a consumer is still attached,
> > but pd is freed by devres anyway. Set suppress_bind_attrs like most
> > pmdomain drivers?
> >
>
> No, I won't add suppress_bind_attrs
>
> As I'm also aware of this problem, but intend to address it in a differen=
t
> way, and should send a patch in another separate thread..
>
> In my opinion, Adding "suppress_bind_attrs =3D true" will only mitigate
> the problem, in the case of this driver, it will still trigger a problem
> while unloading the driver with rmmod command if built as kernel module,
> consumer side won't get notification with the event. Ideally the device l=
ink
> machanism should solve this, currently I'm working on a patch for this..
>
> --
> Yixun Lan (dlan)
