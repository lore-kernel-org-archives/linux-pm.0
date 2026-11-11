Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794437893;
	b=tfOOOJy9Q0dcLBxWvcNa9A4rPMKZhHyCBa/XfCxQOi2jfCqNoznxOip/NhLByC0M9DWw
	 2nVPBUsZG70C/Z2VP8cMnipPz7GQpuu4dHwpwmTVjPtpzp00aEWvkqXVEyfUh+ORXTLj2
	 oS4wOHsK7OqszYEgcnIb3hQh82ENiMcvI9b4BP8t+X9qY0sFoNSwQ+h+R1tH9yzIFoRO3
	 reYoHqvxyG1JsCSfS7dotQN3TFfY29Y/cLS68k+GQrT8JNeREJyPGxDcSNIFlM4ohZoBG
	 bM/Xm5XmASz67w4yTfZuMcUqqEwkAU4UjCsXMpFHHCAHvEo7puOgEOcpC5PqLNUuCbQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437893;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:
	 X-ZohoMailClient;
	bh=c/v4QTdP0wFTr9RiVb4M9LTtOgChhD0w31JKBca0pxM=;
	b=Asbri71x/Sb1ga23lTKMyOhoQIeFf4JWe+Fz7kCOkizTCDPZQckan0zTZMQqx7ualoac
	 XZGnZ98G8w5h3+Wt2VSrPwzqq1t4f0rJ2aRQtZcDJ2FDB/pdxRNOxx2j/jx4hf8U7p1YJ
	 1H2JXfL9pb09sfGGgi1lNOUErJchUTH9q1nPAwWBC+ShVXezgpKjCprIAh/MjKsDwMY3h
	 R57zMJ7gJLiUFYM43n7FdE9dAkjhk1vbFIyW4fwXluuaLjh/sB55v72skrnXdVFcH34sS
	 A2EsBZXkXS6j/je39wGZm9lPqdHQ1CjZF5L9mzaoPZWp885A9CtQZlPZUbrGur6eitQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=MBefhUwu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82A4606A31C;
	Wed, 11 Nov 2026 22:58:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D82A4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=MBefhUwu
ARC-Seal: i=1; a=rsa-sha256; t=1794437877; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PcClibU0ukI9g9mCDY9l6t4sjIeFRsG4jxmU2azHN95/6IHXvT7VZ0ftv7lu05O0gxPyTazGF5VPThpt8kYhfl/XdLUuKv+e7XnE+ZKnSWWegfGawMNHitYRLinpV36xU1zkmXIpWoA3DAm4yz3tKrlJf/QvLfUtSkUowvZWDb4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794437877; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=c/v4QTdP0wFTr9RiVb4M9LTtOgChhD0w31JKBca0pxM=; 
	b=NllP9KSA7uCEz5Buf+P5HpWky+kqVpTqoAHqyOYP6F1LJ8IaBTYxx/WmE1VztPskC6PgjoAfAnnHVlJ443MSCiImmFmThAmdRj77wXxiO8LHx9xqlPgI5DHyTiTP+aZHU8RreJdGcgk7cnpxaEKktr6BZcS62TRLGdr7215Lw8Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: a=rsa-sha256; b=MBefhUwutfEqxNQQQWLLqBWgtrPDUAdeMurRCQ2j7YWit8iXtGpVEaOloe48mNX5ZFu/DnKt0w+WEVVzWUEhZkXSYwqrAL9VmAlZ7yx+cTeg2uDugoe3Aa4xMCWgIwvTgaTxh3lnxKNKn7PFNN6R6dOKZPJeOCxH3FR9QcALATk=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=c/v4QTdP0wFTr9RiVb4M9LTtOgChhD0w31JKBca0pxM=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794437876453820.8198898258573;
	Wed, 11 Nov 2026 14:57:56 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 781C1180758; Wed, 11 Nov 2026 23:57:52 +0100 (CET)
Date: Wed, 11 Nov 2026 23:57:52 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: aiyengar1990@gmail.com
Cc: Ulf Hansson <ulfh@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Shawn Lin <shawn.lin@rock-chips.com>, Kevin Hilman <khilman@linaro.org>, 
	Caesar Wang <wxt@rock-chips.com>, Elaine Zhang <zhangqing@rock-chips.com>, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] pmdomain: rockchip: do not report probe deferral of
 a domain as an error
Message-ID: <avTxNzSvbWM673H5@venus>
References: <20261110-pmdomain-rockchip-v1-0-6b9fa6ebaa86@gmail.com>
 <20261110-pmdomain-rockchip-v1-3-6b9fa6ebaa86@gmail.com>
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
	protocol="application/pgp-signature"; boundary="c6h4l5bp3f35fdzy"
Content-Disposition: inline
In-Reply-To: <20261110-pmdomain-rockchip-v1-3-6b9fa6ebaa86@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.427.16
X-ZohoMailClient: External


--c6h4l5bp3f35fdzy
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/3] pmdomain: rockchip: do not report probe deferral of
 a domain as an error
MIME-Version: 1.0

Hi,

On Tue, Nov 10, 2026 at 07:11:30AM +0000, Arun Iyengar via B4 Relay wrote:
> From: Arun Iyengar <aiyengar1990@gmail.com>
>=20
> When a power domain clock is not available yet,
> rockchip_pm_add_one_domain() records the reason with dev_err_probe() and
> returns -EPROBE_DEFER, but its callers rockchip_pm_domain_probe() and
> rockchip_pm_add_subdomain() still print it with dev_err():
>=20
>   rockchip-pm-domain ...: failed to handle node power-domain: -517
>=20
> once per probe attempt, and twice for a nested domain. On an RK3588
> board whose NPU domain clock appears late this is more than 20 error
> lines before the domain finally probes.
>=20
> Only rockchip_pm_add_one_domain() can return -EPROBE_DEFER here, and it
> already records the deferral reason, so skip the message in the callers
> for -EPROBE_DEFER and keep it for real errors. dev_err_probe() is not
> used in the callers because it would replace the reason recorded for
> /sys/kernel/debug/devices_deferred ("failed to get clk at index 1") with
> the less specific "failed to handle node power-domain".
>=20
> Fixes: 7c696693a4f5 ("soc: rockchip: power-domain: Add power domain drive=
r")
> Fixes: 6be05b5ec161 ("soc: rockchip: power-domain: add support for sub-po=
wer domains")
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
> ---
>  drivers/pmdomain/rockchip/pm-domains.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/ro=
ckchip/pm-domains.c
> index d7df19e10000..70ebe5696b39 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -1050,8 +1050,9 @@ static int rockchip_pm_add_subdomain(struct rockchi=
p_pmu *pmu,
> =20
>  		error =3D rockchip_pm_add_one_domain(pmu, np);
>  		if (error) {
> -			dev_err(pmu->dev, "failed to handle node %pOFn: %d\n",
> -				np, error);
> +			if (error !=3D -EPROBE_DEFER)
> +				dev_err(pmu->dev, "failed to handle node %pOFn: %d\n",
> +					np, error);
>  			return error;
>  		}
> =20
> @@ -1144,15 +1145,17 @@ static int rockchip_pm_domain_probe(struct platfo=
rm_device *pdev)
>  	for_each_available_child_of_node_scoped(np, node) {
>  		error =3D rockchip_pm_add_one_domain(pmu, node);
>  		if (error) {
> -			dev_err(dev, "failed to handle node %pOFn: %d\n",
> -				node, error);
> +			if (error !=3D -EPROBE_DEFER)
> +				dev_err(dev, "failed to handle node %pOFn: %d\n",
> +					node, error);
>  			goto err_out;
>  		}
> =20
>  		error =3D rockchip_pm_add_subdomain(pmu, node);
>  		if (error < 0) {
> -			dev_err(dev, "failed to handle subdomain node %pOFn: %d\n",
> -				node, error);
> +			if (error !=3D -EPROBE_DEFER)
> +				dev_err(dev, "failed to handle subdomain node %pOFn: %d\n",
> +					node, error);
>  			goto err_out;
>  		}
>  	}

I suggest to fully drop those dev_err() and instead ensure that
rockchip_pm_add_subdomain() has dev_err_probe() in all relevant
error paths. Note that -ENOMEM should also be quiet, so its almost
done already.

-- Sebastian

--c6h4l5bp3f35fdzy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmr08uwACgkQ2O7X88g7
+prQGQ/+MElFeHJshgEN+c9kS/KDR0NI6m/JOuiYp1kUZIXBDsjEAzMTWNpGFwIj
46EAPO2ZZ//WIruRfH4hLCHFK14qvKRHlZCOcRuLvVUJmqysmXB5t5fYWVM8o9PC
t21TAjZVCE4tkMpYwxmYq8zzIrFttOhf9BJFDO1GNXMHDjva4vMe8+6A2sTgrU2D
WNZoGV+Zj+IkuE1nbKZQohxa48V9CahycI48mqAIjMcr+BndjykK1nX4PPonpWnl
CybGa3E588YOgLhBY1n0yIUt5mWHkHOnoVv7YhZ8X4QADSqygiFaMfZAafZLYn2T
3dYI7xkACo9kxHUZ5OmEuhEpBCHPYnjiRXn2+U+S6rYEkKYLI3hoAtr9RcAr3q/5
nPVFjUxmnsvQkG3zstJ98ZPMyTrCQC6r+q1wX7TTx8JE7sbUWDbNLAp4h55P05AS
Dlv2O4/ZSNAQ/5+xomkYxfthNzkU3YDNQQ9BGN8DSdShcj/zvLBbkczHkQYSUajg
MOMBX+uHNGTcnfgdyl45HzYaKQF6i2/TuKAp6FBUPXZR0NR1toFKjpWVOj9G3d9I
iGJIEOgLF25muVE6njnZmfk565q2nIMr+TyL19e+wh/2hlUTAbFIMtNXJOugQf0g
7GGCtZUP1Ooj0GERn1axXnwkXa8Zn1HH2Eln96TXbWN6WiO/r3U=
=Ul/T
-----END PGP SIGNATURE-----

--c6h4l5bp3f35fdzy--
