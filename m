Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794186014;
	b=xVhNhHfBMS9alQlsVOyvnohS5240Nz7DfX5ja8uTiaiCdApNMtIFW/NfIoPMg8cpfj5T
	 PBl2PgjFp+zl1AziJEYnGajByeo1EMXvvUPCOywd7vPqfvzKbb8a4QAU918snU6Rd9gRW
	 DIBmLYtgRhIRQ2GerXerxrELnc/AQ9QSr/OxSipnT6HR7U3DgnyH4+4ZA9bmRw84B0XTB
	 mtHE6kbHWoU+85zCXxHeLKjt7obJVYjwizWEcoaIdQVAZy1O35nxdQNZ9NcQNMXu1s9NJ
	 +bl0bUtzST7PhJysMmp5Owwg3tKEPPzXrzIl4dUSVuuAqKuDvklGmQqYcGnyyROh/gQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794186014;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:
	 X-ZohoMailClient;
	bh=sdnWb34G/BMXd/YL9sWUPUwwFcK6qHo1a3AhFO76t2A=;
	b=LqAie7M3kEX6joitLtpfbfgRFhNFqzYNMmdyIZ9bfRm2MNFO6UJfXivS7bJzji/dOeI/
	 n+yxLXwKqWJAHvP4dsvaJhI5m2BCkaHfb9jBGCeYYt0NVgKva3sfK9KnKDQYkcd5hDFsK
	 gn2dZRX1tMOj/RA7wmKeAzi+g/Km0fV173xxWG3ODGnZphCU8+xJ/m15o0sdUOYKVzw2V
	 WoRCDeyPHFtaNcMGBPwn2JKLIRGLuV6RFFeT1D/bjCmadOLZcT2hF8VqRRnopgADtsbfy
	 oUYdIjEyPK9Eu0WikuL8FKvXsG0dazujnq/opZh3JqbZgZx2RuK4IDIiOXTWTQVgiIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=gZaMKbym;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
Received: from sender6-op-o12.zoho.com (sender6-op-o12.zoho.com [165.173.180.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69134606A320;
	Mon,  9 Nov 2026 01:00:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69134606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=gZaMKbym
ARC-Seal: i=1; a=rsa-sha256; t=1794186010; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LeRMnjiKzM5v0Fy7jn87CkziDVmBIsCD2gRC2hkSy2jrna+9YFb4HmLV5zIP/m7285ZP1cWkgVHlF/vBlBxpTgRSQhD0QTDOIwOl0WqHzSPjPc7e0xOQE9EahHUkJ2wsIVnOA+ZSSbroLO71RUdDLx/TARrD9Hm+WNK8nxDIRBw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794186010; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sdnWb34G/BMXd/YL9sWUPUwwFcK6qHo1a3AhFO76t2A=; 
	b=EsJq1zMB2IG5iW08l4Kviej4Q/kmdjz199JmOz8M6DP04LQsUWjCdYNIx0sPy0eG02II4IevYI+aUidqb9ZhH8H4BM57oR170lBCgCTQjJG+9tRAOy7wt2SefcT6Dfy+BINCiMwCZyf9tPVrOHaGn/E9h+beSsWsQ2ukPmmDrCE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: a=rsa-sha256; b=gZaMKbymSVLrbUpmiOraVSeGEnjg/zmW/tniXBWRZZmFJVXiNV60ydCngpn6033+2TxFwty1x0e19FtqHS5t8EW0igXibwHU8gcN40j1UU6DneWhNMffMPDAyTsTOJOU1SH2JDGkzZkZ4G9e1+KBSz4iF0o6FzhjUtUJ24w/rFI=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=sdnWb34G/BMXd/YL9sWUPUwwFcK6qHo1a3AhFO76t2A=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794186009742942.7669295215074;
	Sun, 8 Nov 2026 17:00:09 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 61B9E1808E6; Mon, 09 Nov 2026 02:00:09 +0100 (CET)
Date: Mon, 9 Nov 2026 02:00:09 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Yaohan Li <shunsheng1218@gmail.com>
Cc: johannes.goede@oss.qualcomm.com, krzysztof.kozlowski@oss.qualcomm.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: bq24190: stop IRQ and work before supply
 removal
Message-ID: <avEajWe1iAH-Trhr@venus>
References: <179378567491.72692.9015711605062239156@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j5jp46ygi523nust"
Content-Disposition: inline
In-Reply-To: <179378567491.72692.9015711605062239156@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.158.93
X-ZohoMailClient: External


--j5jp46ygi523nust
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] power: supply: bq24190: stop IRQ and work before supply
 removal
MIME-Version: 1.0

Hi,

On Wed, Nov 04, 2026 at 05:47:54PM +0800, Yaohan Li wrote:
> bq24190_remove() unregisters its power supplies while a managed IRQ
> handler and input_current_limit_work may still access them. The
> managed IRQ is only released after remove() returns, so stopping the
> supplies first leaves a window for a callback to use freed memory.
>=20
> Release and synchronize the IRQ before unregistering the supplies,
> and cancel the delayed current-limit work. Cancel the work once more
> after unregistering to drain any instance requeued by an in-flight
> power-supply callback.
>=20
> A KASAN test with a simulated I2C device and the in-tree charger
> driver reproduced the race during removal. The same test completed
> without the use-after-free after the change.
>=20
> Fixes: 4f73a52df7d28278 ("power: supply: bq24190: Avoid rescheduling afte=
r cancelling work")
> Assisted-by: ZCode:GLM-4
> Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>
> ---

The mistake is registering runtime PM and power_supply without
device managed resources. Instead of manually unrolling the device
amanged resources in the reomve function, fix the probe side
instead resulting in a nice cleanup as a side effect.

Greetings,

-- Sebastian

>  drivers/power/supply/bq24190_charger.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/suppl=
y/bq24190_charger.c
> index 7a5867dd74c23..fd0ea5385f0dd 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -2265,9 +2265,24 @@ static void bq24190_remove(struct i2c_client *clie=
nt)
>  		dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", error);
> =20
>  	bq24190_register_reset(bdi);
> +
> +	/*
> +	 * The IRQ handler and the input current limit work both access the
> +	 * power supplies. Stop them before the supplies are unregistered
> +	 * and freed below: the devm cleanup only runs after .remove() has
> +	 * returned. The second cancel catches work re-queued by an
> +	 * external_power_changed() callback which was still running while
> +	 * the supplies were unregistered (the work has a 300 ms delay).
> +	 */
> +	devm_free_irq(bdi->dev, client->irq, bdi);
> +	cancel_delayed_work_sync(&bdi->input_current_limit_work);
> +
>  	if (bdi->battery)
>  		power_supply_unregister(bdi->battery);
>  	power_supply_unregister(bdi->charger);
> +
> +	cancel_delayed_work_sync(&bdi->input_current_limit_work);
> +
>  	if (error >=3D 0)
>  		pm_runtime_put_sync(bdi->dev);
>  	pm_runtime_dont_use_autosuspend(bdi->dev);
> --=20
> 2.34.1
>=20

--j5jp46ygi523nust
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmrxGxkACgkQ2O7X88g7
+pqoaQ//Zgb0NQUCSTq9w+DoUDS7MHUduFf/56YIgtJATdPTPU0JOcUIWauqmyw6
EfbisO+ggkZN53S+CpnpKD8SrSibeRgyAL61JQX9Qs4iyH/Xw+8TUzHlpjVQCmrE
44WPMPLAf9WT/DE362K7Lzw854uLMvq35IXKABaGEXTiG+3V8s0J9Fid4LDllX7r
9DrvBYymrBJOwu+v3Fa7NkpJ3KZryds2Hq1x4ECjy1hZZgrRB/j+re3y0an0ip+D
XoYAEVTPdUwbfJ7q5bIVdTVs/XLnwqm3hELKAuEUiqHk/xB5XxCx2xAvY8mYBEtv
2DdnVLq+LymwIjAlPQfmkN07PmFdXcrXeJb7uWHaaUJFinrgENWN19qYtLtiUkRR
HP1iBOvJdZ0xY4oA9fOXm8qORIenpRuruqbgV1pEbmSTHHnHoYW6wJwaK+ysKp3e
Qqvx6e8fl+KYtIxYjMwW1XxADM1gHCOPxzupzq9j6tumSux5LYgmH7ZXqU/SzuKu
rcrv2R3RjGAzZ+cpPU3IZwqzjbXvNLyNCt9WWP+9xv2yyxCpQltJHZhgH+mgET+M
X0LXhT8geZlvNHSPuewyvg9BEVkALi09eQJwpwH2Dky0sDOIS0Hf2EEyelcVyj/S
KFI+mlVomPm32ThvoFEwg0ttSngaAhyNGfRmiIMAXHDdHS95hq4=
=dGOW
-----END PGP SIGNATURE-----

--j5jp46ygi523nust--
