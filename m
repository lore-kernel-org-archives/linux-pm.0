Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793657537;
	b=lvJQp0s9aEEcqBnPpa5gVgsToSBJWUrVwKw2NhaRb4RmGzI8hQMZaEZFA7uiC8X9i87W
	 Fk3AJrPK/7/PlCvMbFc9GXhk8TzOH3tNZ4r3aM/YpUK59X3kTl9eBEit1Xv5wULK+RG7q
	 ECZGSZxr7OSZXBKAWt9WXiHoaL/GqSDTMmpiB/+9QVsvDmasLs7q7ZkiFOm0KEu4NcplX
	 XlEfC7SUNfw/7M14Z51GQSyZUk+l5y5KrdLoPM4jGvBDK643bxENzTy6wLDN++JhX9Q7l
	 KSmuMlquikeKM0n0pxz5b7Ln2ubm/YuE7XhA8F14FdnnYcTysPcb1ZiC13B7HBMUKLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793657537;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=e1YYB8A6hDEHHLeE7ijygK35bswGqWpmgHbadPgu68M=;
	b=3e5qmmkMJZ+VlhTVuu5BGYRmKSDhx73MCmt8K8b8rl86DXHMV7PyndGgYP/lolKZC5ac
	 nX8ChjUf1U7JbblA1XifxONnsN5Jt0zIroLh2ChoO3ZzCCcceeMcKITZ6BunxI42tw3d/
	 9y+9tPbdOwcofTT3pc6n9A6OAtR7ai9bkherBwNYg3t0pdTDru9d3O6xRYTLEb56AOVPM
	 icQXgcHpJd5CFGPb2DIYc4smIf49Ks1Y8Hv75cPFSHC2/UVCF97axYOTYMLCFKbHWmI+w
	 ukaT9fVe47PZxa+roKC6FEBDwDd8R5E464kYeRKQIFmKrpw/Jqp44cQqe2MALRf22Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nhvbXSKe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2759606A324
	for <linux-pm@vger.kernel.org>; Mon,  2 Nov 2026 22:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nhvbXSKe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C981F00A17
	for <linux-pm@vger.kernel.org>; Mon,  2 Nov 2026 22:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793657537;
	bh=e1YYB8A6hDEHHLeE7ijygK35bswGqWpmgHbadPgu68M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nhvbXSKeFAKz2TvfL67iWPjkMQIkR+O3mbwAbG2uKjAc5raQh+WqmuEfYg+dWf98o
	 mzvBpztd3vo9fz5NaqQBFv4LGSP6jMVAYMWcX5ZKeWDptLdq8ghIopc9K8UQoRyCgT
	 z5LkVUXkImpwb7pYOhPRmfMOIovDOKBR29CVgmQb1Q03MZoh93nRtLKo5cdNGLUCG1
	 4tgslehg/1XaowqxEIpsylnfkm3CyBgzF0p2dEcbqc/iFhiXZAcp0GGJUeL3y1aYeh
	 vEwu/GfMKQtwDVi5eHR3jfQuUZfZG6EY+JHCm64Qo4KsADuPVTN0fvbAODq/HpNgnO
	 2SagBt4UNZt1w==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5ba3ec92031so4671103e87.2
        for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2026 14:12:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwptAau8lF+5ULZqjyj8xX4YfFokfrH8PuIi4bwsoDkVn9czaJTaYmXAc/ZH+X1EEq49D6AC8NxMg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8s68Ii5FR7vT3LhuPlFihUjHy8LvZ1UHfvWFk8xxU7GPvR6wMC
	oUgVenXLTTR/Q5SJd46BavcmJr+QHDqMx7dP5PHCsE3Tl/ba4+0Y8qCSHqPEVG0lPfJShdPzMIE
	8SCzDIK8MMN4kMRTz/gYrOYjVKR4MhiA=
X-Received: by 2002:a05:6512:10cf:b0:5be:5394:162d with SMTP id
 2adb3069b0e04-5bfd954b775mr3148381e87.3.1793657536092; Mon, 02 Nov 2026
 14:12:16 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
 <20260921-ux500-power-domains-v7-1-v3-15-9352be6b86b1@kernel.org> <CAPx+jO_KJJ6ORKuw6VJmtZAOEnzVz0+bq3bEFupAK_4UROKBAA@mail.gmail.com>
In-Reply-To: <CAPx+jO_KJJ6ORKuw6VJmtZAOEnzVz0+bq3bEFupAK_4UROKBAA@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 2 Nov 2026 23:12:04 +0100
X-Gmail-Original-Message-ID: <CAD++jLkC7XehyM3Qh4mDu1zB+_MKhmFn6ae1sA4XCxeS1btT9g@mail.gmail.com>
X-Gm-Features: AclHuK8dNHZsRqLthhksQhjLhAkrSznv9BcaYJhCMzuzVcpQer5tPiLaX8qENy8
Message-ID: <CAD++jLkC7XehyM3Qh4mDu1zB+_MKhmFn6ae1sA4XCxeS1btT9g@mail.gmail.com>
Subject: Re: [PATCH v3 15/18] dmaengine: ste_dma40: Use power domain for LCLA SRAM
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Lee Jones <lee@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	dmaengine@vger.kernel.org, Frank Li <Frank.li@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 3:27=E2=80=AFPM Ulf Hansson
<ulf.hansson@oss.qualcomm.com> wrote:

> > Hold that domain while DMA transfers are active. The DMA controller is
> > runtime PM IRQ-safe, so keep taking explicit LCLA runtime PM references
> > from the descriptor preparation path instead of relying on a runtime PM
> > device link from the atomic transfer path.
>
> A bit of an orthogonal problem, but related to the above. The irqsafe
> thing have been discussed in the past for DMA controller drivers.
>
> Would it possible to get rid of the irqsafe configuration for the dma
> controller device, altogether?
>
> I don't recall exactly, but not the entire consumer DMA API is allowed
> to be called in atomic context, but perhaps that is not sufficient to
> allow us to drop the irqsafe configuration for the DMA controller
> device?
>
> If not, I wonder if the consumer of the DMA (like an mmc controller)
> should be assigned as a consumer device (using device links and
> DL_FLAG_PM_RUNTIME) of the DMA controller device. In this way, the
> consumer (mmc) would be able to control the supplier (DMA) through the
> device link directly using runtime PM. This could potentially avoid
> the requirement of having to use irqsafe for the DMA controller
> device. Maybe someone already tried this?
>
> If the irqsafe configuration can be dropped, in some way or the other,
> this patch could become less intrusive, as all that would be needed is
> to create a device link to sram device using DL_FLAG_PM_RUNTIME.

I looked at it a bit, talked to the AI prompt a bit, thought about it from
my (limited) understanding and while it seems possible it will need a
substantial amount of work, so I think it's best to get this powerdomain
migration in place first.

Steps to actually go there would include getting proper consumer links
in place and verified, remove all atomic resume runpaths in the
DMAengine, handle requests without a device such as memcpy (I guess
by simply using the DMA device itself as device link?) and some minor
refactorings of lifetime for channel setup/teardown.

But indeed we could use the pretty well documented and supported
U8500 platform as a canary, I think you have access to this platform
too, the upside is that it is "simple" compared to some recent SoC
monsters so it could be an example of how to do stuff.

I don't see much generalizable stuff apart from things like the
pd-patch to the SRAM driver being pretty generic.

Yours,
Linus Walleij
