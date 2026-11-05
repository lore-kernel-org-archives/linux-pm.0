Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793868743;
	b=gZtEC9F9EIcaPgkYjU4mhMvfSZ+2BW4Gx3e05Tn8yqgOUJdHurxY06qy9FUzRQdGRyEV
	 lRf0VNjegIPKm4XcT31H2aOw6jRsY5yLwOd6DXhgPIml09FYNYu/oLV/4sdh95LCtZIjq
	 g6UMfHXY9/8YN7VE8HP/bq8KI1FNQEtqsnPrY/Bl9Bjgt0ZJR6/ifvKQT8orKwr27nOHu
	 5MbKlBUimBNycg3IMl+btPOMkOKToQqsaZhbhJlLlzkvvGiYod72m621qp7eW0ly/Duv3
	 u0dENePxNlD31ShI88uIQRwqAPtqVjHEO/KCkAeiEHCKoj/9dheDsxonCNKQJ1+eKOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793868743;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=Msd07b8Kgx8v1VWINbHbc0sUGrkBbqikBSOBM45eS30=;
	b=u83q8TQ+WK8pg61PL+TgqxTBdNcJKNZqF/CqRMokvXsvTM4Eve0GXg4Yrf8PoavysiZX
	 GZ6PoQBST4EfEl8Kq5SY6NxDcHK5ftqYFhKDzLfEW8208UgYX6Age/FjRZKYtLt3V9Ixl
	 GILCHVy+9PwW7NtUKpFdtjO3DlEvyzJ5jGTLTEwn7j271ZCeTbdsFVn9JPtouwRC15Wy0
	 6P0TwqN6AL00Ssvk+2lXImJUsEDAkwHJP+NOF5xdyMKfHrDkw4ozdfVWDMX7oxkQs1rUt
	 fy0akl3uAXNtupGcJyYBK+5ZL40aNkWiIMYFl2lPhH5xWmT8DilkHHV9pUObnNKLvPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Tjb6TUCQ;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FCA606A326;
	Thu,  5 Nov 2026 08:52:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72FCA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Tjb6TUCQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1793868740;
	bh=zF4UneQYBw/Lw+DtqeKovavXzEG4vgp4Z2EEg+Ep6uw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Tjb6TUCQv7G3DF8S0DUoHTXD4RBLtwXZXUNLb8OZDjnopzJw1gVPlztewE6DXF3UA
	 dyYleUyOOVLdxnw3YgsEVOFFUzqqlU8pz0IVngl7hqrT6UCw9vq3bo7l+yOZ+mfoMw
	 fxYbeEZrIoh+PAIOuOz0Fdyn+RrUnUNGwIaG/D64yZF/wy+7o2joauYl/br2M2dei5
	 pLEaRu/7XZG+xgenRXc2Fy9VZWkEyNTqTrrT4+K7MSNJyKymyHP6R3L07BXa736XpT
	 EayyMhup1elnmA0avhgBmDdRSYj+qe2eEMJqDyEJxRaEfZaBSPtx8BqrlG9/1Lv+rK
	 pU5dKp5/Xy5VA==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D64B117E05D6;
	Thu, 05 Nov 2026 09:52:19 +0100 (CET)
Message-ID: <f21d912a-48ea-4f0d-bab4-526e617f1769@collabora.com>
Date: Thu, 5 Nov 2026 09:52:19 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] pmdomain: mediatek: Enable the GPU timestamp
 counter on MT8188
To: =?UTF-8?B?TWljaGHFgiBLb3BlxIc=?= <michal@nozomi.space>,
 =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Daniel Stone <daniel.stone@collabora.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Steven Price <steven.price@arm.com>, ulfh@kernel.org,
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
References: <20261011184755.2058017-1-michal@nozomi.space>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20261011184755.2058017-1-michal@nozomi.space>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/11/26 20:47, Michał Kopeć wrote:
> On MT8188 the GPU timestamp counter reads zero until a register in the
> MFGCFG block feeds it the SoC system timer, and MFGCFG loses that
> setting whenever the MFG1 power domain is turned off. As a result, the
> SYSTEM_TIMESTAMP query and the timestamps written by GPU jobs are always
> zero, which breaks timestamp queries in userspace drivers.
> 
> v1 restored the register from panfrost through a new mediatek,mfgcfg
> phandle on the GPU node. As Krzysztof pointed out, the register is lost
> by the power domain, so v2 restores it there instead: the power

The register is not lost by the power domain, it's lost by the MFGCFG block
getting unpowered and (all) its registers being reset to the defaults, where
the defaults happen to be zero... and then the MFGCFG has a bus protection
block yes (unused for us), but that's at offset 0x20, so if you define that
as 0x130 it becomes plain wrong :-(

Besides, get this:

"MFG_TIMESTAMP_EN" is a register field that doesn't exist... so here are the
correct definitions ;')

#define MFG_TIMESTAMP		0x130
#  define TOP_TSVALUEB_EN	BIT(0)
#  define TIMER_SEL_SOC_TIMER	BIT(1) /* unset: MFG timer, set: SOC timer */

The issue that you're talking about here is not specific to MT8188, but to all
of the MediaTek SoCs with either Mali or PowerVR that are *not* using the GPUEB
firmware (so all Chromebooks and Genio boards before MT8196/MT6991/MT8894).

This doesn't belong to the power domain driver, as this is definitely not in any
way related to powering on the MediaTek Flexible Graphics (:'D) block, so this
has to be done somewhere else.

That said, let's see what a good solution could be here...

...so, the MFG Block has got a Hardware Timestamp Engine that needs to be kicked
from the MFG Configuration register area, specifically from the the MFG IP
Timestamp register.

Once the timestamp engine's timer source is selected (TIMER_SEL) and you made sure
that the actual timer source is running (eh, first make sure it's running, then
select), you enable the MFG-Top (Top==Global) TimeStampValueB (TOP_TSVALUEB_EN).

When those registers are set, your Hardware Timestamp Engine is fully ready and
will start running when frames/commands/etc come, adding a timer time to each of
the frames/commands/etc (which is why this is a timestamp engine) in a hardware
assisted manner (and this is why it's a *hardware* timestamp engine).

Now that we know what we're dealing with... we're pretty sure that this is a

H T E  .... (drivers/hte hello)

Documentation/devicetree/bindings/timestamp/hardware-timestamps-common.yaml

Panfrost needs a hardware timestamp engine to do timestamp counting, right?
Panthor would need the same.

That's not MediaTek specific, because there's a generic hardware timestamp engine
binding, so I'm sorry but you can go back implementing HTE support in Panfrost and
Panthor - in a very-very-very generic way - using the HTE APIs.

You'd have to write a (very small, really) HTE driver for the hte-mediatek-mfg.c
but that's not a big deal, a first version of that driver, which can be upstreamed
could do just:
  1. Make sure that the MFG-TOP power domain is on (not the cores domain, just the
     top one!), which is easy, it's just one line; and
  2. Set the register fields in MFG_TIMESTAMP to the correct value when Panfrost
     asks to start or initialize the HTE; and
  3. UNset TOP_TSVALUEB_EN when going to sleep, or when Panfrost asks to stop/deinit
     the HTE.

It's a 50 lines driver, nothing more (well, I didn't write anything so I don't know
but trust me it's going to be around that linecount).

That's how this matter can be resolved.

Btw, thanks for bringing this up, I didn't even realize this was an issue.

Cheers!
Angelo

> controller lists MFGCFG in access-controllers and writes the register
> every time MFG1 has been powered on.
> 
> Patch 4 converts mt8188.dtsi from the deprecated per-domain
> mediatek,infracfg phandles to access-controllers. A devicetree with it
> needs the driver changes of patches 2 and 3, because older kernels
> expect exactly one access controller on MT8188 and fail to probe the
> power controller otherwise. Older devicetrees keep working with the new
> driver, without the timestamp.
> 
> MT8370 uses the MT8188 power controller and mt8188.dtsi, so it is
> covered as well.
> 
> Tested on the Lenovo Chromebook Duet (MT8188): the timestamp counts at
> 13 MHz, also after suspend and resume.
> 
> Changes in v2:
> - Restore the register from the MFG1 power domain instead of panfrost,
>    and drop the GPU phandle (Krzysztof).
> - Drop the panfrost patch, which makes the review comments about error
>    propagation and MT8370 moot.
> 
> v1: https://lore.kernel.org/all/20261003200132.866240-1-michal@nozomi.space/
> 
> Michał Kopeć (4):
>    dt-bindings: power: mediatek: Add the MT8188 access controllers
>    pmdomain: mediatek: Restore a register after powering a domain on
>    pmdomain: mediatek: mt8188: Enable the GPU timestamp counter
>    arm64: dts: mediatek: mt8188: Use access-controllers in the power
>      controller
> 
>   .../power/mediatek,power-controller.yaml      | 16 +++++++++++++-
>   arch/arm64/boot/dts/mediatek/mt8188.dtsi      | 22 +------------------
>   drivers/pmdomain/mediatek/mt8188-pm-domains.h | 16 +++++++++++++-
>   drivers/pmdomain/mediatek/mtk-pm-domains.c    | 19 ++++++++++++++++
>   drivers/pmdomain/mediatek/mtk-pm-domains.h    | 15 +++++++++++++
>   5 files changed, 65 insertions(+), 23 deletions(-)
> 

