Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794063005;
	b=gMkfXDzK2h1JeHMkwgFbATqhJfTHOhRHNThWXQAIl/iOtsPLbPCs7FlEULUB31xUP2HB
	 qxfhi7J0ogGsAoc+DfBBGH6/IE8CeVTey9OkJKPKA/9rw4UThN8LvZdS7ICXBKvkOtYC3
	 3Nx29PS4fSvj96ibWpjP4abp3ofPgNTvIfeEy5sD9HMZU8axrnpTtb1lEg7w6tUpdz1bY
	 UjOV+TjCurY8K2ErqNSGYcvINJRazSdqzIV1HBQf++tNXMi/TASGYvWyTj9CR/XIBsZ+7
	 0/YHOfdCFWB3Qg3EO+OZyRVNBWLE/7ZhMAd5j3SU8Qw03o6hZY+sOX39+ehSBeJ0jPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794063005;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=rCtCLaXuoBajgUckhWEDWeKqUiY5Jp/q685S3dMTOBU=;
	b=GYJ/Z1KGPtlq6EI/HxywVoiBfTowY8iF5u1vvR0kCH1PgAFQc5UjZEkbfuJi+qWnUxpz
	 6n4mpTHVLS0Y+jTcWJtVvj5SEh5Ton4MacRhsKNUQec9SqMEErxtbV0NCHS5OSPY3ebow
	 KSWmc70YmgoGc3kg9/0Qlvyc5K3wtNMktMJHHUw5HKr1hFXbc4Jofj1KcbPPy3ZETnTeQ
	 XkPs9O10kyLw4WZYZdXtQV3FeztYNDIfs8jZC8eg5P0fYYP3/OZKC+2mada0ikXlqD9Wz
	 4O6LFrwZirlQZlW3nI5smY7O3nzqz5N5AQDr6cJx1JAs1+nIDx67gGN98NFMe9OdXag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=XYuv4fYM;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68855606A330;
	Sat,  7 Nov 2026 14:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68855606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=XYuv4fYM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=rCtCLaXuoBajgUckhWEDWeKqUiY5Jp/q685S3dMTOBU=; b=XYuv4fYMGfp8WiLCq7bsTniChM
	x8V2AxaJTLLbaFlm3r5jQWBGYPawdLNVgYZ3MJX8dPrAcBBZU7fgEAfk+qJ0Jgc94vK6gMgg9HGCa
	ty3mMgbt1Wl5eUiXOJMA5ZZNq6AcIFaEIO5aMZweUrTusjxTGXtN2IQdnQ1K/c0zaNeEN1y3NA/wv
	Z2Uc4uXtjeGObyJf+ElqpA5FQci4z8n4oH+1tE6muB/lYxBW5MGNxybGdZJloi110/LC2IGU5yLkN
	Ew0cFYosZD3ERCzLVZq4r29Mspj9YRYuv2mauBKSy6esUH3tT6nnjaYbw0L69ngw4jSJerd17qZcX
	EWTDz4cw==;
From: Heiko Stuebner <heiko@sntech.de>
To: rafael@kernel.org, Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
 Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject:
 Re: [PATCH v5 3/6] powercap: dtpm: Remove duplicate RK3399 CPU hierarchy
 nodes
Date: Sat, 07 Nov 2026 15:49:56 +0100
Message-ID: <2454229.bcXerOTE6V@phil>
In-Reply-To:
 <f9b6ff8250f27e117facd372735b6c1f46e74926.1793666444.git.daniel.lezcano@oss.qualcomm.com>
References:
 <cover.1793666444.git.daniel.lezcano@oss.qualcomm.com>
 <f9b6ff8250f27e117facd372735b6c1f46e74926.1793666444.git.daniel.lezcano@oss.qualcomm.com>
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

Am Dienstag, 3. November 2026, 05:48:17 Mitteleurop=C3=A4ische Normalzeit s=
chrieb Daniel Lezcano:
> The DTPM CPU backend registers one powercap zone per cpufreq policy,
> not per CPU. On RK3399, CPUs sharing the same cpufreq policy therefore
> map to the same DTPM zone.
>=20
> Remove the redundant CPU nodes from the RK3399 hierarchy and keep only
> one CPU node per cpufreq policy. The backend already suppresses duplicate
> registration through its per-CPU state, so the removed entries are
> redundant descriptions of the same zones. Keep both CPU policy domains
> and the GPU in the hierarchy, preparing for one created zone per generic
> hierarchy node.
>=20
> Also fix indentation in the Rockchip device match table.
>=20
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
> Changes in v5 (since v4):
> - Add Reviewed-by from Lukasz Luba; no code changes.
>=20
> Changes in v4 (since v3):
> - Rebase on v7.3; no code or commit-description changes.
>=20
> Changes in v3 (since v2):
> - Rebase on v7.3-rc7.
> - Fix Rockchip match-table indentation here rather than in patch 1.
> - Clarify that the existing backend suppresses duplicate registration.
>=20
>  drivers/soc/rockchip/dtpm.c | 22 +++++-----------------
>  1 file changed, 5 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/soc/rockchip/dtpm.c b/drivers/soc/rockchip/dtpm.c
> index b36d4f752c30..e71f315fbb6b 100644
> --- a/drivers/soc/rockchip/dtpm.c
> +++ b/drivers/soc/rockchip/dtpm.c
> @@ -20,30 +20,18 @@ static struct dtpm_node __initdata rk3399_hierarchy[]=
 =3D {
>  	[2] =3D { .name =3D "/cpus/cpu@0",
>  		.type =3D DTPM_NODE_DT,
>  		.parent =3D &rk3399_hierarchy[1] },
> -	[3] =3D { .name =3D "/cpus/cpu@1",
> +	[3] =3D { .name =3D "/cpus/cpu@100",
>  		.type =3D DTPM_NODE_DT,
>  		.parent =3D &rk3399_hierarchy[1] },
> -	[4] =3D { .name =3D "/cpus/cpu@2",
> +	[4] =3D { .name =3D "/gpu@ff9a0000",
>  		.type =3D DTPM_NODE_DT,
>  		.parent =3D &rk3399_hierarchy[1] },
> -	[5] =3D { .name =3D "/cpus/cpu@3",
> -		.type =3D DTPM_NODE_DT,
> -		.parent =3D &rk3399_hierarchy[1] },
> -	[6] =3D { .name =3D "/cpus/cpu@100",
> -		.type =3D DTPM_NODE_DT,
> -		.parent =3D &rk3399_hierarchy[1] },
> -	[7] =3D { .name =3D "/cpus/cpu@101",
> -		.type =3D DTPM_NODE_DT,
> -		.parent =3D &rk3399_hierarchy[1] },
> -	[8] =3D { .name =3D "/gpu@ff9a0000",
> -		.type =3D DTPM_NODE_DT,
> -		.parent =3D &rk3399_hierarchy[1] },
> -	[9] =3D { /* sentinel */ }
> +	[5] =3D { /* sentinel */ }
>  };
> =20
>  static struct of_device_id __initdata rockchip_dtpm_match_table[] =3D {
> -        { .compatible =3D "rockchip,rk3399", .data =3D rk3399_hierarchy =
},
> -        {},
> +	{ .compatible =3D "rockchip,rk3399", .data =3D rk3399_hierarchy },
> +	{},
>  };
> =20
>  static int __init rockchip_dtpm_init(void)

checked against the cpu clusters, this of course looks correct

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



