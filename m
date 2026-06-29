Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959802765D7
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 11:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782732817; cv=none; b=lwKsuEwRmYi3XOaG4ML+wgL+Xtpulf4vUYpFkO9eOvLd93WAlEYuq/6n5BYOmVTVdpQx/VKHWySROvA+GLorWNhLNta+EPrut69GBzpIjE3hSYlbm6CnokZ391osH7KrJ8ginLD9AZcTjQgdn8wpLhWjNe9EkxBaC8ryoB2773E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782732817; c=relaxed/simple;
	bh=KUeTVcRRHlt2nNxIuvni6QGMV2+Kux3mA373m0SaozA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dvgfZprkGWIuCUvmeHTYmK1fpERRteIMy6v9n8pDuAM8yn4HU6S32FjnpPSF4j4mPrP5f+sNLpZ9844XTYyAS5AG2UUQLeDZIF6ADriVtShPCOpLB2fqycRo5k+CxKblUG7Jp44lp7AdTVEtOGsZx4LX98TVRZzWREUAZqX82uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Cvb7DkaE; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Cvb7DkaE"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6984169c126so3722016a12.1
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 04:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782732814; x=1783337614; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KUeTVcRRHlt2nNxIuvni6QGMV2+Kux3mA373m0SaozA=;
        b=Cvb7DkaEyO7FVkotcmZ9+Q9wqHeLq5WfGkkoGDIXn3AL+ImmgyB7GJ0vM9WUapTpXQ
         W2Hnydm8bmFCkn/NxtGJtsvv62PFBJvR5zXtuvvterxuuIbOZcsPAmTVaDSJquQmbezZ
         stP1PnwfFXFOtjnNKvKFMM5r17ZTHsfBRlmsTVU/kb3Xo1+1aYdEWpmaNHptA82I42Xu
         YlN4e7Z3SwR7hLuxiFPg8YkZEKtcj9aDzuQVMtydm0RtPD8vudmXwNG2YRwxyWc8+V+p
         eStRx2CaGX/o95f6L4MbjDjmTH9sEHgvO+7qempRt9VAv1KkisTAMw+7OaoC64Kcq1U3
         X+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782732814; x=1783337614;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KUeTVcRRHlt2nNxIuvni6QGMV2+Kux3mA373m0SaozA=;
        b=sagTl4cImv6+GkdTT5MkxoSQBtxBgOBvmLUTUutWgZRrmjyo1MWmb4U3K2hi9Q3fV4
         Mgp1SISx787V9SvDCpkmf+IKRCs6zTtadZOEbh0gqbrzXyw6RMbbAUr1s8TiRMDVCntW
         sa4Vv2f++qLWB8iPErSDj2w3YI3zTg85syScqESN36QTmE7AwhN9Y8FqVFXyhyvr+eaI
         ofJOO9Ue1DsufGLOLN58SGOeN4ImEZ3LHXA7NRoD7YXglWh2b8cnNDCr9o/MKg9gSJYL
         rAkfl2WPW2xKjI22wVYT9rasUJaUSG1coReiypLH8ALp2/63DgZ5mfg58xuOp+YxHk9m
         eP4A==
X-Forwarded-Encrypted: i=1; AHgh+Rq3v7Ta3h+yHWxe9AIhfzF9fo/c7U4YQp1dSMSPnWnCLyPBedbM2uBsIPke9xmyq1INqhMMoRk8BQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpPOTwWB2An4yQP8dGZUXECriTOzqyJCyG+1makTgB0gQ6gBCq
	riQ6SmjRmIRtNDYggk283VNFh8fRHCOC4xRUqlqVyjlFnPzOn+LcYfyhiOExfR1Z0ew=
X-Gm-Gg: AfdE7cnwmtP2gb4JNXxbryZo6tZ3oQMzFLo9xb5JT9Gj0wXBdJzl94sqgAkQzeO2Kzr
	UjpIqM1nvrGj7Ehr0QtMUR6i0xOSGAqWW7EnVA/DbzsnL9WnkgyWiyhCUF6nmY7j2y+wEgRC4oc
	WpoQyASOQUM2WCiN5SU/UKW56ZqpMBKkjTfViwC1sfXIaV7gnZi7OA84I43FcPaDrFU/WYchEFZ
	5HD257NQGE0qn1cpH34Qp4XeLgMGf7wPR+26BuPC16ADHWbG21JH/dlXxTbyzHJeTRhFnhjsgSK
	fzBrDnRZKNviHP1yLfXqqWFdAK6Ve8cBUDvd3hc2n8zrGfd1G6YBG5goWFumzsX8YxZzK5IlQfP
	P/9A5CYeZ/RgxLifsDsp4UZKEriCHrji8eOthDosGMGRcS3ifJJm2VFHgLf8afXbQfl8SHS486o
	SSjVXwJ/2VNNGS+8dXwCyAknIHcwbLw3dupkD9iauAcfZq2edMV1hSISv1dL63Oh4tWXEAuT2NE
	PdV5RvifGLjhk5sIFuOX+pnIf+NuTvdYBqrCu7toZ7/8hJ2lhH4rg==
X-Received: by 2002:a05:6402:2809:b0:698:5f35:a8f1 with SMTP id 4fb4d7f45d1cf-6985f35b18amr2101411a12.6.1782732813962;
        Mon, 29 Jun 2026 04:33:33 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f46e15besm6842586a12.15.2026.06.29.04.33.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 04:33:33 -0700 (PDT)
Message-ID: <c4d745b9-fe6e-4290-9748-8d4d995df781@suse.com>
Date: Mon, 29 Jun 2026 13:33:33 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/32] powercap: Stop using 32-bit MSR interfaces
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <20260629060526.3638272-1-jgross@suse.com>
 <20260629060526.3638272-3-jgross@suse.com> <akJWPnqcbL6RCfYN@gmail.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <akJWPnqcbL6RCfYN@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Tr0ROu2f0by9PPYRkw6rHFGx"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Tr0ROu2f0by9PPYRkw6rHFGx
Content-Type: multipart/mixed; boundary="------------LYxaVpTYeJNXvAyxA0dn1386";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>
Message-ID: <c4d745b9-fe6e-4290-9748-8d4d995df781@suse.com>
Subject: Re: [PATCH 02/32] powercap: Stop using 32-bit MSR interfaces
References: <20260629060526.3638272-1-jgross@suse.com>
 <20260629060526.3638272-3-jgross@suse.com> <akJWPnqcbL6RCfYN@gmail.com>
In-Reply-To: <akJWPnqcbL6RCfYN@gmail.com>

--------------LYxaVpTYeJNXvAyxA0dn1386
Content-Type: multipart/mixed; boundary="------------dTca6myBQpgCsBgmumw1tObh"

--------------dTca6myBQpgCsBgmumw1tObh
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjkuMDYuMjYgMTM6MjUsIEluZ28gTW9sbmFyIHdyb3RlOg0KPiANCj4gKiBKdWVyZ2Vu
IEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+IHdyb3RlOg0KPiANCj4+IFRoZSAzMi1iaXQgTVNS
IGludGVyZmFjZXMgcmRtc3Jfc2FmZSgpIGFuZCB3cm1zcl9zYWZlKCkgYXJlIHBsYW5uZWQg
dG8NCj4+IGJlIHJlbW92ZWQuIFVzZSB0aGUgcmVsYXRlZCA2NC1iaXQgdmFyaWFudHMgaW5z
dGVhZC4NCj4+DQo+PiBEcm9wIGEgcG9pbnRsZXNzIGluaXRpYWxpemVyLg0KPiANCj4gV2Fz
IHRoZSBpbml0aWFsaXplciByZWFsbHkgJ3BvaW50bGVzcyc/IElJUkMgaXQgc3VwcHJlc3Nl
ZCBhIGJ1aWxkIHdhcm5pbmcNCj4gb24gMzItYml0IGJ1aWxkcywgYXQgbGVhc3QgaW4gc29t
ZSBwYXN0IGl0ZXJhdGlvbnMgb2YgdGhlc2UgQVBJcy4NCg0KSSBkb24ndCBzZWUgdGhlIGNv
bm5lY3Rpb24gdG8gMzItYml0IGJ1aWxkcy4gRWl0aGVyIHRoZSB1bmluaXRpYWxpemVkDQp2
YXJpYWJsZSBpcyBhIHByb2JsZW0gb3Igbm90LiBBbmQgSSBkb24ndCBzZWUgd2h5ICJsIiBk
aWRuJ3QgbmVlZCBhbiBpbml0aWFsDQp2YWx1ZSAoaXQgaXMgbW9kaWZpZWQgaW4gdGhpcyBm
dW5jdGlvbiBvbmx5IHZpYSBhICImPSIgb3BlcmF0aW9uLCBzbyBzb21lDQpiaXRzIHdvdWxk
IHN0aWxsIGJlIHJhbmRvbSBpbiBjYXNlIGl0IGlzIHNlZW4gbm90IHRvIGJlIHNldCBieSBy
ZG1zcl9zYWZlKCkpLg0KDQpJbiByZWFsaXR5IGl0IHNob3VsZCBuZXZlciBiZSBhIHByb2Js
ZW0sIGFzIHJkbXNyX3NhZmUoKSB3aWxsIGFsd2F5cyBzZXQgYm90aA0Kb3V0cHV0IHZhcmlh
YmxlcyB0byBhIHZhbHVlICgwIGluIGNhc2Ugb2YgZXJyb3IsIE1TUiBjb250ZW50cyBlbHNl
KS4NCg0KPiANCj4gU28gbWF5YmUgdGhpcyBzaG91bGQgc2F5OiAnRHJvcCBpbml0aWFsaXpl
ciB0aGF0IGJlY2FtZSBwb2ludGxlc3MnPw0KDQpJIGRvbid0IHRoaW5rIHNvLg0KDQoNCkp1
ZXJnZW4NCg==
--------------dTca6myBQpgCsBgmumw1tObh
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------dTca6myBQpgCsBgmumw1tObh--

--------------LYxaVpTYeJNXvAyxA0dn1386--

--------------Tr0ROu2f0by9PPYRkw6rHFGx
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmpCWA0FAwAAAAAACgkQsN6d1ii/Ey+D
wwf/Q3cm0/CqFJnK5oh8LXcvSa0odZBfvOQ9AdwRn3PllXsRHBXWrwloaFQouYDvuLoKC1fyqlh1
e7l4TEWUOGZTfZfn4IqqgCadAnLpzhXZWCK/Ve8/PSUGohpe+b3CF8SblRU4hIm7HnFKGEoYXLM9
jisLnF9iWGoPj8CYZZg4dKorTIDqpQ/dCNy7bc2WWO/EZWuBzBLcNf5ErSe/0wN5FR9J5/xH2Cp2
WnMORPNz17xC3uZwenmsZvhDLUxdEoCmT1J2DFuY+OS2QRXJZ3/bmq1L5Q753KbDA3Qnye80n1Kc
LG1mVQ+Zr90rKDODvEAhIShGH3nx89jr+EF6fEVnSw==
=kxnH
-----END PGP SIGNATURE-----

--------------Tr0ROu2f0by9PPYRkw6rHFGx--
