Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793787954;
	b=HV/biW6SYg8mAfsn2YFPZwfA9qwaeszmTlCaCWRblXE8ImNjfx3yLHgQjqvz2WEyB8aQ
	 NBz2KHmzNzUJAXoZPTJgCGrrQTKznMPz1xRDCJWqN91B79vnZAfueMwgScxEK2pfs7euy
	 LSdWiUwptkkv3eVt2vp68Sloy6f+WEyZvvLbZZ7LbxurrfKMDkQfhJXDxfyvRPk7Ln2GJ
	 0fGmJoAXYL9tRq2apadFPORhy51sVL63OJ10Ch0gITEzk8xasPSPp1e0yy4lGF0PtB8DX
	 VdWSk1Yczt8Kq9mao/2kt7nWrY2FQDpZ3j6E6s36x3XaPRAcX+ZJO89O2gwP5Ne+sYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793787954;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=uRrdt0oAcAPfS+w2dQ61HkrI15khdaUCiJ5g7tU0p+Q=;
	b=VmaI1gtY7OW4R3Z8JopkUPOmTUnw+Ybne9a+SX66xr1wyXVsePbnhwqZqILWTiVvwfQW
	 +LJD5hwJKLfE+9gmkGQY80/0ySN92NJh/WsogVu/alLXgtbuwTOzhTXKBIefJrOWyQ1B4
	 VRd7UazUsbkWlwuQbb+1urz4pnE1cTck5qxnoblBkM1b9wQNKqDjLRrLkrDS5nfbZ0E/B
	 cnwI+RqFkM0SxAocP3sTdbq7rlVv+0SClLaNeCqdvkW3peyAOx0CFs6gem+TdqYI8CFUo
	 wyI6SlVeMaUxzL5DlRP44QdYomKMu9tC15i88G4aTg1my+mqfnx6xxpzPEwfEZgOehw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=A+8t5vjZ;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0F1606A329;
	Wed,  4 Nov 2026 10:25:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D0F1606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=A+8t5vjZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=uRrdt0oAcAPfS+w2dQ61HkrI15khdaUCiJ5g7tU0p+Q=; b=A+8t5vjZqpreZvPSLqn2rWHCfk
	n20HzKOydnfedJfrqrbJoETErbWXGYMoVDxPotfS+pj30dhVa9kgt9ioE3h2XT9i+o0G+8YdGkx94
	c3QBYW5k2mk+ni5jhkwtbJ0XyA5dPKbn2W67WeyaIRUJ548XcG9M2F372a+JG9Z4saOhjOzo+w3oC
	eyhS0ZoraybqUEcq+Rs1ShIc64rINHDJig5KDlfjZqHUgloCWhUZhfDAow0U/X/rkbraLV4ZTsUbE
	L8NNkvSjhwcAGWUz3HAevwzEEWEfjFK3ykebZUp2dFTL+4ugzZ2Y132qKzJFggyFXmgKN48nvtd3S
	d5ApHuFg==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: tomeu@tomeuvizoso.net, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 ulfh@kernel.org, p.zabel@pengutronix.de, ogabbay@kernel.org,
 zhangqing@rock-chips.com, Jiaxing Hu <gahing@gahingwoo.com>
Cc: royalnet026@gmail.com, abel.vesa@oss.qualcomm.com,
 sebastian.reichel@collabora.com, sidong.yang@furiosa.ai,
 u.kleine-koenig@baylibre.com, chaoyi.chen@rock-chips.com,
 diederik@cknow-tech.com, alchark@flipper.net, leonard@lausen.nl,
 jeff.hugo@oss.qualcomm.com, rfoss@kernel.org,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jiaxing Hu <gahing@gahingwoo.com>
Subject:
 Re: [PATCH v15 04/15] accel/rocket: let the core suspend after a reset
Date: Wed, 04 Nov 2026 11:25:30 +0100
Message-ID: <3373678.NnENhoQgcM@diego>
In-Reply-To: <20261101082307.151957-5-gahing@gahingwoo.com>
References:
 <20261101082307.151957-1-gahing@gahingwoo.com>
 <20261101082307.151957-5-gahing@gahingwoo.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Sonntag, 1. November 2026, 09:22:56 Mitteleurop=C3=A4ische Normalzeit sc=
hrieb Jiaxing Hu:
> rocket_reset() drops the in-flight job's runtime PM reference with
> pm_runtime_put_noidle(), which requests nothing, so the core does not
> suspend until something else asks and its power domain does not cycle. On
> RK3576 the domain's power-on resets the NPU bus interface; without it the
> IOMMU stops answering and the job after a timeout fails.
>=20
> Use pm_runtime_put_autosuspend(), as the completion path does. On a ROCK =
4D
> the job after a timeout goes from 0 to 128 of 128 channels correct.
>=20
> Link: https://lore.kernel.org/all/20260819073530.6087-1-royalnet026@gmail=
=2Ecom/
> Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three cores, i=
nduced reset, JOB_TIMEOUT_MS=3D2
> ---
>  drivers/accel/rocket/rocket_job.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index 5b2abf40b618..152a9098634b 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -467,12 +467,12 @@ rocket_reset(struct rocket_core *core, struct drm_s=
ched_job *bad)
> =20
>  	/*
>  	 * No handler is running now, but we might still have stuck jobs. Let's
> -	 * make sure the PM counters stay balanced by manually calling
> -	 * pm_runtime_put_noidle().
> +	 * make sure the PM counters stay balanced by putting the reference the
> +	 * job took, and request idle while doing it so the core can suspend.
>  	 */

with my comment in patch 3/15 fixed

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

>  	scoped_guard(mutex, &core->job_lock) {
>  		if (core->in_flight_job)
> -			pm_runtime_put_noidle(core->dev);
> +			pm_runtime_put_autosuspend(core->dev);
> =20
>  		iommu_detach_group(NULL, core->iommu_group);
> =20
>=20




