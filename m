Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522933E0C66
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 09:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774947730; cv=pass; b=YgJVvgGbBbvZ9EAJBZbrg69WTz53DA35XOTYr19XuXomG2yGzkYi6ED1+3cWKHdssxaSDFU98/UByXxewZR4W38lQubP2pb2W9ZQvlXwC0Wkacg6sOcPPY2J6cZcyyWmaNvCZ76jLbuJPfcUN62dE/Rh+YWR1VX2uwyqs0kpBrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774947730; c=relaxed/simple;
	bh=QuCvn599COW//1DtmRcEag0zAJukE3mULPcfdxWmbHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tcySHCWoghahhi/WRI2JlR491/ExeSy/fCfqcz7DLHHZJ0pHF33D0azLVF16g50io3f0JGnGWQQ1Oa//zIRxiHSHKF3bYbc1QMccxpuJSCxGzlDRdW1vIxMaMnUShtIAAY9dGc9urJ8ZedeJ+KGhC7tEeBZ/XMyS2z1nli7ifdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WyW8aOgY; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WyW8aOgY"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a0fc5e2c59so6212865e87.1
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 02:02:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774947727; cv=none;
        d=google.com; s=arc-20240605;
        b=G6TEH+0e4K6f1qYpNgT3vjT2301yIqCJZQ0VjVgYtBoGRE3zor9G+H4M494Lu/pv4e
         2nJPnMYUbOQN6t1gdEJjHi+SAR44nT9vqDtu9p26r1c9k4fMPX2jWKdoGm68T8GeRK/+
         xijlyaQ2Lv5kEBgZ53FDZy7njJ2Ja1eTLntS63ucucbZoeSXuEulTzBra9urNIA0imGU
         9pEjQmtRAF7qmyWQsB4InqTIK2W7R22U1f1VSKGiLADPzoCcu2nc5BKUmlKP8JyBO/Kf
         0qVHYcaQpAl2+BETYEkhHTX3B6iUdNQDZQppfR3le8zZbcyWCSLcvPllRkKyn+wndQH8
         iBXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QuCvn599COW//1DtmRcEag0zAJukE3mULPcfdxWmbHI=;
        fh=IeiY5fKFdnE1to/uHF/TfZ9n0O2nQOcXHQr0UMCum68=;
        b=cILLKiB1CSjEP5N5uZKZkmvuqYyFGv8cgo/CNbDs268s7Ad+s4tifKWti+ZnfPpOUs
         +RTWhUbDpKavDBdSkUiDzsqMEKTM2tCxNRe+n8u4BkGDeFP6OGPxhuDPtTLDcG5r2iq0
         gZMVDoqWn02oiLQjP8vxe0S6CrekqqmudjG9v4eQh8nHI+N/T+gDMdeo4AJgCKKpqpjo
         G+yfntJyda+JvGu1AYTZxE37tK7PpF43FPjbbCCG6MkZRCDFHpIggNVX0CokzEIZ3eTI
         1oErgpTFfpvKfXgZX5Yo80rrTSPjxEQ/9wjeIKnhRvH0pp5ZkugkNzhJvaRI5M+jSraX
         SZqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774947727; x=1775552527; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QuCvn599COW//1DtmRcEag0zAJukE3mULPcfdxWmbHI=;
        b=WyW8aOgYi8MVszoV+uXI6HpIqbblZcKFU61V67eBcX0jra4k/WaoEzrxKrnHaF2MdE
         5yyvdXkmBYkkOR+wbXPEtQ4ZtCbilrZeEuoFlyIaC56gAYJMxzM155shYE78fY1pfj7G
         M21H3Noe1GilKjaI1f40ma2GRIq3IP/2N8jl66/to2eiiEHlf2H/KUwUAEG+q9OE7M23
         Y6guly5IqcdEGm8HB6jN3l3OVon6JTBgQ4ia+/aH1ridr7GXTgTKKBI5ZHpMBsRWGIMv
         PMIf8w9+mVbgLeNUjVPRZL4CqVVS+M/mAgAcdQ3110A2jQIp0PM66DQ18sRdsVh9xnqE
         gUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774947727; x=1775552527;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QuCvn599COW//1DtmRcEag0zAJukE3mULPcfdxWmbHI=;
        b=qgX37sBuZabDSPkySYh5wuKZqfHcbU6shFC+37uUDTLe6jBQszqeQviKqLRphx1rkb
         nv+ZBvz1DyhBcpN7S3KTJ1516dNx2E+dKnZ0I39FUcPeMGsMVzUauv9b1XgrCzyodRje
         +zJTDIiL0eFDg0ESJ8lPBvtNpkE2RNAuNvuQanaxDzUx34xpNlLFpKJxOQGY+Tu1meul
         C5LGEa+mkvZaLgDJ2UCdJZi5zHIH6WasldBqJf3VP6U7pxZJNdflqJHn1kxv6TIVQTGW
         pAi3W6YvLNWrnMhnZv0VvH2a8tqySuvi8d3u+iFwJajExzTKr5foxcO3yQYjVT2OHRjn
         ZLBw==
X-Forwarded-Encrypted: i=1; AJvYcCUXRMXbKnVPElMlesGq3ePlKPMs0w90csPFGD2UAFIqi6DUSyvYAGCu3B6OdN/8IeH0mM+WHIS9Vg==@vger.kernel.org
X-Gm-Message-State: AOJu0YywoJsWBv5Lz3Cth2nNBipZcYZNYgBAM4YjNOPnfB8BcB4zTIEU
	JE24qxaVfg5+ZnhihS0sn2pg9cxrhjOAh3jipkxj9DuxyO5wSbcY+RGMcYa67XVbptpfDQqMvnu
	GoxX8ESK/X6t6G/sMImEbROKjO1tjzm4aFnx/j/6qbQ==
X-Gm-Gg: ATEYQzz8vDToNJEJIYVKNfEHEMP7qCJGefo0X4AQquYPWGtfZzMQgO7Cmy7YtK0W/7/
	kG6TL0FxKJ1flCvG8VcY0+RaBQzrzX6ksUFcwVVUnJtWVWZMCVjJVCLZVwm/C9XWg5eOrrqDra8
	4n7PPpu8h9V/15Jzk10sy25oRJE9gWk+xqtonlyH5KvIrSoCjW6Oq2lfwuPglaHW6VvYpbVNirS
	L1xnxAXsP4ADmLroaU75wu+qp+v2u7za/+MBL+m5nnarEKnDRyVg3gSIuTMjBPzQ6EQLQUXE45Q
	EQS/oLlA
X-Received: by 2002:a05:6512:3b95:b0:5a2:78f8:60aa with SMTP id
 2adb3069b0e04-5a2ab92e0a6mr5921259e87.37.1774947727265; Tue, 31 Mar 2026
 02:02:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318-gs101-pd-v8-0-241523460b10@linaro.org>
 <177409907930.268981.5882592990447577348.b4-ty@b4> <CAPDyKFoz-sm0pfvn5iSYFY0mrW38vaGRZsFvrVPqsv7BsYxeWQ@mail.gmail.com>
 <1fbf5c54-8793-4585-be33-ded77019adb2@kernel.org> <CAPDyKFrK3NLwaii-9FEmyaTzUAuVkMkLL3rWBQwQvT-M+PzEHA@mail.gmail.com>
 <3bb6b71e-947b-4248-95ba-79852f743c1d@kernel.org> <CAPDyKFpOPC2stAJ262jdap-=ByY09AeQ0kj6p_9FTGJBx+Tu-Q@mail.gmail.com>
 <a417e45b-1632-4b14-9e3c-f7110db53190@kernel.org> <CAPDyKFomzokuF+UL8d0+Syk1FCG3jnUfy7rVr+3iC1GPZmH1UQ@mail.gmail.com>
 <c4d6b758-474b-409d-b553-fa4ec1df494e@kernel.org>
In-Reply-To: <c4d6b758-474b-409d-b553-fa4ec1df494e@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 31 Mar 2026 11:01:30 +0200
X-Gm-Features: AQROBzB7d4a8fUYE9ADAwNJgppR-qAENvrUiLIFB9dQe-2GMylgbIm_d4czfNl4
Message-ID: <CAPDyKFrwxVcLByHef7GjbyB+Du0bRbD=6_ELmmnMWW-TsjMhCQ@mail.gmail.com>
Subject: Re: (subset) [PATCH v8 00/10] pmdomain: samsung: add support for
 Google GS101
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	=?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Juan Yescas <jyescas@google.com>, Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 30 Mar 2026 at 15:38, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 30/03/2026 15:30, Ulf Hansson wrote:
> >
> > Usually we want bindings to go along with their respective drivers on
> > a subsystem basis.
> >
> > Both patch2 and patch4 updates DT bindings for the power-domain providers.
>
> Patch 2 yes. Patch 4 not. That's why I did not take patch 2.
>
> >
> > Why shouldn't the bindings go along with the driver changes here?
>
> Patch #2 is pmdomain, so with pmdomain drivers thus your tree. Patch #4
> is not pmdomain, so not with pmdomain drivers, so not your tree... At
> least I do not see any pmdomain parts in that patch #4. It's a Samsung
> SoC PMU driver and none of further driver patches touch that PMU driver.

Yes, you are right that the PMU driver isn't touched.

Although, the PMU DT description added in patch3 and extended in
patch4, allows power-domain providers to be described in its child
nodes. Those child nodes use the same compatible string as the
power-domain providers described in patch2.

Kind regards
Uffe
