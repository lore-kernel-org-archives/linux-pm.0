Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794871552;
	b=fWzKehXEOurYiA8Iri9S1V1wrUWn+lLqkiGeJHRVFfpkGVX0GvB4ColFb+8x+cZMMmDn
	 DiRWQMrvdVNR1wOO8BWa9XJU5oBJFWkEkL4uBpkyB7JAI/r+g+9KDRXziDZ308izkXm2J
	 vB6wl62idj79wMfu36PmcQtJSJR3SJJkGbLb+j0waazzOmV2aZwNbTYSx99yEsjthlsgj
	 vsMSVPlesvlNHNT14Ain4LmRpRfWnu9b4j/bSTbuAE2A2vblkKcxx8eq1PYqguO56OwKv
	 ra5r9Nkl2av8FVQTyj1AtIvNTn3pIV7T56JBheLl2QW095vZJ7K9V2zBRWs2S/YKwcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794871552;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=PN04PSX+g8QpPPJaQdcDFzVHTVuQYn9JYXSW2HDFXC4=;
	b=slf84dvOfifnNWT6g6HPjJJRvhGqBObDnZpYfs+/ia9X1A+jfTWjoDYZB/aSTYa2h+kF
	 xmOOnvB2hRQiVVczttYhKXPtim6iBTJwQbIZWRNY8Iw48XVaHy+erPqeyju8J1zr5W3bW
	 /O+/xURyON5mvvwl8Jd6ORPd0o8vmLjJXz/pCgIoy6XnrbSEcpsWxAhKWjLbFOvGO2Tc+
	 LSq9ORntEREYXi78WqOHD2HjIn0AM9gdFvmbHdal3GWCNdOgQAAEVTdR7gQ7Pkn2Lu5hZ
	 MsO6s9q/G7TzI4XEVdLlxzohWlr0Cdmo3UBQU/y9VlVJt6IahbcGowhD30BZewTf9nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dUezxy5R;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA174606A31C
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 23:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA174606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dUezxy5R
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36e795af1d4so257393eec.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 15:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794871551; x=1795476351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PN04PSX+g8QpPPJaQdcDFzVHTVuQYn9JYXSW2HDFXC4=;
        b=dUezxy5RwEkfWQV+1g2HSSMQSh42mSnd2b93TMl1JBombL/8VDFmQileeKIC88aX22
         2+TBIDc/ZA7XkAXhgCVVw8C4ASuKnDIHkEFT7pqqHohpSwwkPrFjAkeqCV5WtmbIIn7w
         kwKdypv4hczV+JloWQU/INyj+51yU+T8QqvO9iDBFuDDy+xZHZGnUAxGcam9Pz4rBRT6
         san0O4ykw83Yr3HlpTR+ZKLi+NMo5YyGvCtITTA6cyxYtBrjV/YR62jplUbPQeQF+tBK
         oYCXa0ibVw2AtM6ZIzWzqOkzzShx5mhfqAjZ0HKY8VCtM0fXPljf4OF+jyNll1PkwtzL
         w7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794871551; x=1795476351;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PN04PSX+g8QpPPJaQdcDFzVHTVuQYn9JYXSW2HDFXC4=;
        b=MebmaOds4eqV4eCUFG/neyUmta9NZKjfECrj5cYh3SN9Us9bMET8E84q0uc7melYYG
         IWt2g4vY97liXjrBf9XJ6X0e/Yjq8GCfAer6ifG0/h5PAqISBWMi7jvJULbl9kw4c7N/
         6HRtxOSCqULNqe4pnbkgTr6rArWLBuy7S6gBBbqiZcJGej0R4BVnZzgVxTh2zJF4+tja
         HZj23e9DZ5IXfQ2xBToaxI+aZvgNrh4ytbvSXPQVNnDBn7SrRlULCFPB5f4C53PbFEGi
         I37YIKTXglJMo+AZ0aWsp2q3mP1a+h7J1QThGZvn5A4qlRIzPx1wRKWKQK2m2pMQ8IIS
         O5/A==
X-Forwarded-Encrypted: i=1; AL+hErGaBikpwvMl5v5xZCmkMyPEHtivS8PfQQvZUaX04fVr3TQu2ahWnSNjNp8MYYuBs9y8W0xHNKwzfg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+V/yDMR8FFIt3c2I4Kuv1OnWuW4tkIwwsTVq+xebvOCnzzb5Aj
	QsJQP1Mjd5+3Hh76m861f+d4Ij4w0QWKwD5HfC91aDQHfjNKezdBSsBc
X-Gm-Gg: AYBFou1JLBiX4npiKZaNVLGQSCMQkZ4dL7p7sIu88hKg4xdbsIU2VFlU45Kzuk3xvAz
	6nOUa0BL7mdsr1GqXPhfI1HIwpWCaaCjpboVuC6R+bvQq4+m6gT3vWeNTV02TYk+w0jfZXJlS9z
	wblz8HYjUJfo+MaQOufNm8FoeTYbyXQ5GwgFP5irdOWdWz2yr8/BRVPzl2Q7eIkRmkvbzXWcqvQ
	YixhfllXSP4DcRXLl5gbp2hE4EjyLcOUUeBzAbTMMLmOPXkcUmK4eZTxXK999o+Jul3YACdb1oh
	DMhzURkATvSvO9hWdxhQ4slztSz7qkqH5X/hZr7Igii6z1sBcOF76glzBRe+WDDGqh6/V2Veux3
	jOrgQOjtCqAVewJ9KswKSJcdlBbuKKRkhxAWKTuuaUWzhK5Si93Vw7ScK2OGIx6RcqCaKmzU158
	Xykk4HEnuW3hmdWLXfmqbbfhh1RgxoickbtkF1fVTF2JEOG6jz06xJoq0HTXjWkyVjeYZ5RNUVQ
	Hf1MyLJvuF7i9EWvlQIcEQ22BEP7eObjkzPek30KhBVbUoZtc7gGCLL38F3wYYOyZgFLEYU2/Rs
	Zz+CS/EcYU3Det+s886alQXg8OU=
X-Received: by 2002:a05:7301:70d:b0:357:ee3a:267a with SMTP id 5a478bee46e88-3810bb5a7bemr909668eec.2.1794871550628;
        Mon, 16 Nov 2026 15:25:50 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955332a77sm33489188eec.4.2026.11.16.15.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 15:25:49 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id BFE0F420B801; Tue, 17 Nov 2026 06:25:45 +0700 (WIB)
Date: Tue, 17 Nov 2026 06:25:45 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Power Management <linux-pm@vger.kernel.org>,
	Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: supply: rt9467, rt9471: Escape the asterisk in
 ABI documentation
Message-ID: <avuQ9A7MJwgrx3y3@archie.me>
References: <20261116034200.14045-1-bagasdotme@gmail.com>
 <pndld6taqgi.a.out@axis.com>
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
	protocol="application/pgp-signature"; boundary="ujQ/f9H7VXVBL7vn"
Content-Disposition: inline
In-Reply-To: <pndld6taqgi.a.out@axis.com>

--ujQ/f9H7VXVBL7vn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 01:52:29PM +0100, Waqar Hameed wrote:
> On Mon, Nov 16, 2026 at 10:42 +0700 Bagas Sanjaya <bagasdotme@gmail.com> =
wrote:
>=20
> > Sphinx reports docutils warnings:
> >
> > Documentation/ABI/testing/sysfs-class-power-rt9467:1: WARNING: Inline e=
mphasis start-string without end-string. [docutils]
> > Documentation/ABI/testing/sysfs-class-power-rt9471:1: WARNING: Inline e=
mphasis start-string without end-string. [docutils]
> >
> > Fix them by escaping the asterisk in
> > /sys/class/power_supply/{rt9467,rt9471}/load_switch.
> >
> > Fixes: 3f21de6784a654 ("power: supply: rt9467: Use POWER_SUPPLY_PROP_LO=
AD_SWITCH")
> > Fixes: cb012fe405f0f4 ("power: supply: rt9471: Use POWER_SUPPLY_PROP_LO=
AD_SWITCH")
> > Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
>=20
> These have already been fixed :) [1]
>=20
> [1] https://lore.kernel.org/lkml/cover.1793225920.git.waqar.hameed@axis.c=
om/

OK, thanks! I'm just refreshing my patch submission skills.

--=20
An old man doll... just what I always wanted! - Clara

--ujQ/f9H7VXVBL7vn
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCavuQ9AAKCRD2uYlJVVFO
owDXAQDvUVBLkHe5PSdcyObK04zf646ubgT6dr3eRI0dQjDMogD+L2HRgrWp5m0F
gYXsYAilAPWl5iJ2pu5e5HtsXzXx4AA=
=P3l5
-----END PGP SIGNATURE-----

--ujQ/f9H7VXVBL7vn--
