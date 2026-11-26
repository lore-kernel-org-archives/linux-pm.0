Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795702483;
	b=n6XwM3rjZfv752Ot/QgvOCKKgq4SBHYp1rpalxO51yicFQvGNNZnOWgM2LtGJshcsEpI
	 GLop2Hrpf3f81lm1/7ztc8xZW8+YIZSJBaVVL4vYVgI727ymFz5aXpKK8GimnJvJ5h1Od
	 KfK0PMBnyWS5lOSxLZLsIOEzbxS9lysEp5Oa3Q4Cv9K87NoC/A75K/0wFKv9agmzi8lD7
	 1xe0pneLUi2CWW92vtF+1JbSO5kJvtiuDd3vgU+wJj5kt9wuqhYBamXxzS3GKMTmpOWuZ
	 y+cFvs6auDRX9KUNg4aysRkHPPc0LiAh0Sv3dQ/zQL4NOsqC+4NKIXYiXYKRNzP3byQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702483;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:
	 X-ZohoMailClient;
	bh=v/0H+eeFYmdmqs3rzoBRgVbz7rsz3OGuWh6okG7NDWY=;
	b=0t7gjIwU1pnEowb733B0rvZcXuugPE8D57xqZSsXoB/a+ilXJfQiQ33utUpLo7nn2H4/
	 UHvaHZ7mfAQIuIYIc5T/kpcKBCs2NUMZbzW3WnFnSf7hPsKQj+HNFd0IgwpYYgEPnTUww
	 Kn1/PWRXO4X8x4nf2UBd+B2jrhqCcCrzB3q3yErkBW3BHhteRtgGlhjbOgFqJ3tKeOszn
	 KSOcumnOM/B4ynR6KWzdJQJC8qNgIcv5AHa2Ww7HTYqfg0QFeFuzkLPr00YZSvRBEHPH4
	 fJqzDV8inHrrpCJD/NtKp6oieAl2CX5OEDPLDKVaCuJ+llTfh27q+eL6WN3xKigS91w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=dxf4Z9oZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF4F606A31C;
	Thu, 26 Nov 2026 14:14:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FF4F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=dxf4Z9oZ
ARC-Seal: i=1; a=rsa-sha256; t=1795702437; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QO94+WDzc88540FN7hTiPl1xptCjeno9y0BJSETD7qUhPkJBgdHlbK2DhMCaThUWhmlFwLNJMd86jTyuHNEvLvnh6+TqjLvFmTiBYURZcgPwdrt/E1izlmnd44fIFcWa76LzMLmweAPpbGPOyM0hhC2L4r/W27IHIDzQuvakucE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795702437; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=v/0H+eeFYmdmqs3rzoBRgVbz7rsz3OGuWh6okG7NDWY=; 
	b=Q3Qn9mrawWE+ITINRsKRmKaBBIRBfSLrsL9w2fTHA9Xx05V4yV2684qlBRybPIypo6EVtvpgq/fKcjjOm9ULEMywH0ul1u8Z3fQgiYrzk0EtYq43O1zTy6Nns+73kvfmxTS0d5FrUjqnrMeLyCZFjJGGNt3x0jbUUT9vkLrE9tE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: a=rsa-sha256; b=dxf4Z9oZ7Ex0qE4uw9fUrRbozgbecJ9MUAH6e3lKlIZSRO9VNoUvsGM82KpNcsir+qWA1Ws9r3uRawuWTXBabo3MuHkoCxVl0SswKRQvsvAfT8sgfq/JEp01NcsNQVrp0mnMp/veMT4hpo/4ml1qcR9S5TWeQIalQULzWsewKBE=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=v/0H+eeFYmdmqs3rzoBRgVbz7rsz3OGuWh6okG7NDWY=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795702435028347.9531354202811;
	Thu, 26 Nov 2026 06:13:55 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 35D121804FF; Thu, 26 Nov 2026 15:13:50 +0100 (CET)
Date: Thu, 26 Nov 2026 15:13:50 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: chanwoo@kernel.org
Cc: Chanwoo Choi <cw00.choi@samsung.com>, 
	MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v4 08/11] PM / devfreq: rockchip-dfi: make RK3588 use its
 clocks
Message-ID: <awg8juW-7cCerIqO@venus>
References: <20261119-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v4-0-517a68c008fe@collabora.com>
 <20261119-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v4-8-517a68c008fe@collabora.com>
 <772ec0ea-da77-42e3-a281-8b8b7f364bf9@gmail.com>
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
	protocol="application/pgp-signature"; boundary="a3o5crxq32b7rld2"
Content-Disposition: inline
In-Reply-To: <772ec0ea-da77-42e3-a281-8b8b7f364bf9@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/295.675.79
X-ZohoMailClient: External


--a3o5crxq32b7rld2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 08/11] PM / devfreq: rockchip-dfi: make RK3588 use its
 clocks
MIME-Version: 1.0

Hello Chanwoo,

On Thu, Nov 26, 2026 at 10:00:25PM +0900, Chanwoo Choi wrote:
> > +static const char * const rk3588_clk_names[] =3D {
> > +	"pclk_ddr_mon_ch0", "pclk_ddr_mon_ch1", "pclk_ddr_mon_ch2",
> > +	"pclk_ddr_mon_ch3",
> > +};
>=20
> For proper operation of this patch, the following patch should be applied.
> The following patch is applied to other git?
>=20
> https://lore.kernel.org/linux-rockchip/20260921-rockchip-dfi-cleanup-v2-6=
-43ff34ac8599@collabora.com/

Let me quote the cover letter:

Changes in PATCHv3:
 * split out DFI driver patches from both series and merge them into a
   new one; clock controller and DT patches will be sent separately.

FWIW those clock names are from DT, referencing them in DT obviously
requires the clocks to exist in the first place. I will send a
series with the clocks and the DT changes later today.

Greetings,

-- Sebastian

--a3o5crxq32b7rld2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmsIPpIACgkQ2O7X88g7
+pr1IhAAqCA4Xj1b+Ss7BlM5Kv9ey5ZxdGBIA1MUwbSdahDgw4J4ULogZSDtKTf3
qDdROlY8hubScVYAWfVWFNUp4eB6VUp3/XwMTpi0HVoBlyKqkoOW1cRHES2dz6Zv
v5Bz0BgI5NIpyNgQo1qdJ1aVxRPFk19hqhP8XT8ZLGFsNbYiIdrXlv0wQIdCljhU
GHxe2fx7ewRWY404EfZoAP6mXvewUQf7VtL+bfVbvk0trMeLxfJiYCRQjshzkHEv
GjbL7I98hgKWg40iCTfAiPwWDtD4bIf4cFF2IivL7VgPK40Wbl230KIJI8pTM3Gz
Q54qNozlMqHfcWf+x1EY2Fg8QqvHCgn8oWP2Nzguex/gzuN5wn58L94qChnIpKQy
UJXdifgcjbmUCI0Qwii/FA60xP35ENYY8hRWJVtArHaN+RA8Lt418HPLNIV5JASX
9KoyrM3uy7wNsiHk1dUhUfNRnSqQD2YGtSXAf7AhsPvp0r+zpel9ntUkyyVOgYQD
mYWJMtEpIa70xhSA8Y+pmWohsO0Jynp78FHlyM/P3KQ3sf2MpJ7z52QECeSKrFe5
HoqZyeBuCI27pLjfwnf5MtPnoL9Df8TSCFm/VM9YNSXtpROaGyUqOkCqTyOjzYKO
WskTCeNT99DafpE63CbClDirt8DQbzAqklN6jEmJZyl9tr06rQg=
=YCWj
-----END PGP SIGNATURE-----

--a3o5crxq32b7rld2--
