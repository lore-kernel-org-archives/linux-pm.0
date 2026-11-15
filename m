Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794706414;
	b=cAxog/1F2cRtXnnwLIAqKS6kBDX6DwlBe8d/QV14qo2ztXI9DV+a7JXa2Hz59MoIHmL6
	 5KURcBMbprVuSL4LTpiG8w+pk0+jXuh5RCCUFtbfEeEvbGbjSJLFWPNkgzqx0VW49iVmm
	 qWyKTV17AsI1f3MLjcMDn6Li4FcS53nhvA84x2hmU/JmrXfSij+jjc6zl08qa8KQBiFDj
	 4nLaXrKyV52F7+JZXhZ+G2z4l0PQuC9W1+0RHIr/5SjPfe21fDeBerO4KYkPVlTciP9tn
	 eGyyCw2OL6ZMT5tt93ohQzwN/lEgu7AxJEd5b9jneCNdHQsEOHLvR/SJRkw0KxBnTBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794706414;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:
	 X-ZohoMailClient;
	bh=xg9g6C/5fZ2E7eZtJQ3y3FzrxJXQqr0QulKYhlA7ksE=;
	b=g+Y1Fu1locy+WkoktNOYCM/M139nMAr6dIZyZ56LmPWdOwqY9ePwJGJgACPk+8Yg7r6M
	 KtrDTpyPyZ6+O88pi76osDPE/DBten1my+FUmsXyfRDHcQzKQmkX8CHRtTasc8BzJYRoA
	 fFSm9WTc52/3B2RJowSeD9+tQKdW6aaW6J66CiH2eAb6Zfqlzbq35kjuFRs38oD9NgWnn
	 yQZ6AJWj21cHK6SOKMoEd1v1p44ZcjGOWgiJvZ0OALIyElz0Ax95sk5ERTZV4X2E8u8V6
	 99metFjmihlO/Lurbag0DMIHthMzdxSB8psRBkjccWtUMglvOoaSlZbadOeWM+fE9tg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=ilqVIflI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91851606A32C;
	Sun, 15 Nov 2026 01:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91851606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=ilqVIflI
ARC-Seal: i=1; a=rsa-sha256; t=1794706389; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nLJRCzEYNbLoxN3S1NuockbI2t6ExOS23/WUmS8imsFw1bdVB162TD/2mKLacUCgQm7Gr2a8QUMk/lBuc5iQ/0D2qoL5zrklHAzMFCxuhotseq+gsqT8gH74i+5tBiwFp7oJiRzuZynEOKp/5TVtsowCCQfzdCfad9cd2V58aDY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794706389; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xg9g6C/5fZ2E7eZtJQ3y3FzrxJXQqr0QulKYhlA7ksE=; 
	b=BZg97skBHgr8As2NVh6NVmc1Np/xV+lQUT6hna+UQynunVRpjihw0H6izlenFsq0urQxDxW3DSWHW5hI1fS/N/KxC5JJu4hSGbidcVs9LZCjeD9u+GG+NvvP7eo7IqMYwzGFLszXZ8Ub+LVBQ1jL3rjL4L8dv2YuQJrqraYJmk8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: a=rsa-sha256; b=ilqVIflIqTQHTbEk4//3nZQG1ccH+/ue3B6IcZj6f0+SY9ewX40telS1hLr2G2DE0hLzkrM187SX5g3pePrywofm0nhJ21QwYvWpEoHLH7fZ0VypZtNPkeEzcJ7Rmjn4Yk8hujNb6+hRNkypuV2sGCSRZnWOWJfO8ZGkPMXHMug=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=xg9g6C/5fZ2E7eZtJQ3y3FzrxJXQqr0QulKYhlA7ksE=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794706386483224.14966488591017;
	Sat, 14 Nov 2026 17:33:06 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id E94731801C7; Sun, 15 Nov 2026 02:32:59 +0100 (CET)
Date: Sun, 15 Nov 2026 02:32:59 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: chanwoo@kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, 
	MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	kernel@collabora.com
Subject: Re: [PATCH v2 3/7] dt-bindings: devfreq: event: rockchip,dfi: add
 rk3576
Message-ID: <avkHvso6ljhn693V@venus>
References: <20260921-b4-rockchip-dfi-rk3576-support-v2-0-04f847016321@collabora.com>
 <20260921-b4-rockchip-dfi-rk3576-support-v2-3-04f847016321@collabora.com>
 <0f536451-9f7b-46f7-acca-e10e54dec37e@gmail.com>
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
	protocol="application/pgp-signature"; boundary="4opafguzx4x2ylyg"
Content-Disposition: inline
In-Reply-To: <0f536451-9f7b-46f7-acca-e10e54dec37e@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.637.76
X-ZohoMailClient: External


--4opafguzx4x2ylyg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 3/7] dt-bindings: devfreq: event: rockchip,dfi: add
 rk3576
MIME-Version: 1.0

Hi,

On Sun, Nov 15, 2026 at 09:58:48AM +0900, Choi Chanwoo wrote:
> On 9/22/2026 6:15 AM, Sebastian Reichel wrote:
> > From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> >=20
> > The RK3576 has DFI hardware for monitoring the DDR's bandwidth much
> > like other rockchip SoCs do. Unlike the RK3588 however, it only has two
> > memory channels, so only two per-channel pclks for DFI.
> >=20
> > Add a compatible for this SoC's variant, and add it to the conditionals
> > at the bottom of the bindings file.
> >=20
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> >  .../bindings/devfreq/event/rockchip,dfi.yaml          | 19 +++++++++++=
++++++++
> >  1 file changed, 19 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/devfreq/event/rockchip,d=
fi.yaml b/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
> > index 3450e28b4020..dcf3bbde3e8d 100644
> > --- a/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
> > +++ b/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
> > @@ -14,6 +14,7 @@ properties:
> >      enum:
> >        - rockchip,rk3399-dfi
> >        - rockchip,rk3568-dfi
> > +      - rockchip,rk3576-dfi
> >        - rockchip,rk3588-dfi
> > =20
> >    clocks:
> > @@ -64,6 +65,24 @@ allOf:
> >          - clocks
> >          - clock-names
> > =20
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - rockchip,rk3576-dfi
> > +    then:
> > +      properties:
> > +        clocks:
> > +          minItems: 2
> > +          maxItems: 2
> > +        clock-names:
> > +          minItems: 2
> > +          maxItems: 2
> > +      required:
> > +        - clocks
> > +        - clock-names
> > +
> >    - if:
> >        properties:
> >          compatible:
> >=20
>=20
> When I applied it, there are some error.
> Could you please resend it on latest commit?

This patch should still apply cleanly, when you merge this one first:

https://lore.kernel.org/linux-rockchip/20260921-rockchip-dfi-cleanup-v2-2-4=
3ff34ac8599@collabora.com/

Generally all DFI patches from the linked "PM / devfreq:
rockchip-dfi: cleanups" series are backwarts and forward compatible.
You can just pick them up (i.e. patches 2, 3, 4, 5, and 7).

Afterwards from this series you can pick up 3, 5, 6, 7.

I can then ask Heiko to pick the clock and DT changes.

I probably should have structured this submission a bit differently,
sorry for the mess.

Thanks for your reviews.

Greetings,

-- Sebastian

--4opafguzx4x2ylyg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmr5C8gACgkQ2O7X88g7
+po+tQ/8DXaiXv5bhz6X8EjEPpQ/FjCstJcZ2thsSB3EUjQHwKBpqrVQo9rS0eB3
ctkdzB6OUpFRJGWTG1tAlhbkHhnwi9ZfnXmM2TDHd6EdNjNzd9uAtUeUt0BrWsiY
rLBX1sTC45nh4eMaAT7IAFAHDZxa5jOAr2UnDqUKy9H/Hb1s382gpkSn7nXltkLS
pfQ741MqDbiIx/AvU6tvJVF4Q/RSC6+Pr2/x8qURUZs5ZeEOxkXEZ9LYgt2oVYWk
H27BfOgnwfxLiomWLOWAY4vOo2ujWyW9bSIMhxqvcQxdtimZ8EJmY4a8IHo0AL8J
JbHyLadHU2DzT94WF2K47VVC15M4vwukyCy532OLHPAkfWoyBguNLd4dbu0oYDOn
zakprRwAY3knNSta2f4m+NGJyce2haAd9Rb/NGpR6X4GymQ4JOg1Q24duwrsUUz5
OmCJL80VCKNy22H9SnPhat/Q6Sd/88hfxFlDwsO86GKUutobkeZ1ymY5mu8Wld6L
DiWYnKGy5WVlth7lOg59k5X6C7hJMNuNKVDBaXUIpGzvrUWcZLkai/3KHQJrhOKL
AowPuTyo8CHqKYNJXuxvv5120Sxg6Wo6h0Snrd6HWArsMdrt+ICCPBmj334FiL79
MAv3osTwm9leJMHRhWTfxGkvc6Rhy6E+8cW88URrOx3TyjE1Nfc=
=OpSE
-----END PGP SIGNATURE-----

--4opafguzx4x2ylyg--
