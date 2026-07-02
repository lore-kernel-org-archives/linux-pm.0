Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0563C4174
	for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2026 11:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782991115; cv=none; b=qm8rRn9rE28OXCY23d18jP30r37Pf/ge3N6zhEZOhAZozR7CBAy7O+U+T6Nk9Vm+hUwEaSvcbz6LNeMy030CMSSk+XvRUz5xRurNu1vFezJa1OabMOxaN/izTSfyqIrmpqq38ERRnP0DLxs4g+c/2AKkmNZAF3dgA2gkZxkI/pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782991115; c=relaxed/simple;
	bh=8gYSV1kqextaOUgw3JpLrU0bubaf/9EUYHk+7GoL4Tc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d7G52U/tN4Tq4hK8qN5pbfbV6lEBRY/Ca9opiDY/oMW1l/6ZOGhSnTSsaSLmbzrRy5RTIQYKjhME4kEaAvJLM4x1UjA4QP/G9FX4I/nbI3q4baMewZKfWEPnk8mb9FBkrzcXeADexwSRBAIw2pkMCPK9mQBA4eiG3fA+UqNABo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ankAUIu9; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ankAUIu9"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-697bd21fdc2so3395133a12.1
        for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 04:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782991113; x=1783595913; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8gYSV1kqextaOUgw3JpLrU0bubaf/9EUYHk+7GoL4Tc=;
        b=ankAUIu9OwjWUZfhGVT3THjDoB/lb1y1nZgAQLPoEjXjrX5kQ3XmfhoKjoRZ0ZKmdS
         fa5S7JNr/zxFOaP45E0KTLE97R8jznUToAjEnweqMQQvpE2VhCd8sellKt8B3Dn+Mqvy
         U41I6mCs7RAvePHslem2/EaS1eroIMKeBZLl1nbmHATCjTZh+ncHBKvZaVdA7flUnFnz
         MehItfoJFPda7XmPjZO4OZ4y6kDBcjQNVqTdRci0mjyNBrKfKCb+EiKTHnhp7M+m3bCu
         /ypMa+dx0zT8mviYAa0AbJYZdP82P4U9yb19W61+nHWkS+xyaAv26nd03TJJ5gkf8wcR
         rq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782991113; x=1783595913;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8gYSV1kqextaOUgw3JpLrU0bubaf/9EUYHk+7GoL4Tc=;
        b=bIPuYq7A4ThK+0AcbXZ0JESj+hkmrz/VnS5Iac/dGhUYx9H2oj/vErSnca9mhQCBgn
         XCdQoBsofypSks5uLfDItKFR3eQYImzzqQdQBUcim4sZezT6B/zdUyIpAqidPflZiBVV
         7+1cBtHB5/Jf3/J93X9jgPrK/XMpj990JWZyAhcqtmovyLAe9ono9vn+BYW2afBR+ZVr
         R0tXgfqCNXMJx5aS6aR02JIuHqB1CW9dwjwekpUr9h6X4sLVtwD3rTVhLS0ZDHmMOzyE
         JM0ofXqVzNxvbKPVf8zUisnLR6hVR5N5sZKRtuU9I8J9hPGQEpW2+e0AgNo558wu+F2g
         8rew==
X-Forwarded-Encrypted: i=1; AHgh+RrRG10kKzkGWP4GP0fCkpwYz9MxVnfKLG5DGpgBCyW5TURHSatUYp6xFfeCFGmEdoo3DO2WH6w/Cg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgUv5ZeCq2TEpkcc18AcLIYqraNrOO+Qk1nOBop5mBfOzHLN/U
	C6xyosAoJ9fsarOsmW0V8rqh4Tl2sgwxhm4AezlMZg6XFWP0tK/WYfZYS4atkdA9A45cxUodGXZ
	ZUXA2F7c//Q==
X-Gm-Gg: AfdE7ckg6WHETUr9W6XsIfoYwO/1dSE+NZEQIeg39Wct/0pr6ewqry4YU9apELz0pUR
	NKaFJDL3rw8eKUYrAvyWZ9R/DakAjRNeWGqSRCv0vIQwcDeQ21jmxzv29mfgDMFKeaPmb+gMc0m
	BMM1Q+o7NuJ9KERtod1ZBCTLP/bbzfQ5Rx6hK5edtwtlE93JL5FhFqU1x04PFrtvR9nqxki4EAB
	HIulXrzpmgqAxWVe+W+Xpw0MWW7mFs5DYyiofkUpJOZvEzEPMl6i9GLgvtPLezTtoPnGiZ+EQxA
	cbfSU/Wn84bA7GQHtL9uK78jCCUd77kHg5Uz0u1LqXRZt6Ka0CbIClHl8cyViMZvU4g+xihbeR4
	F+bQmXSA8G2jq65Avplj6rbrIfcIYGNdJh6G0E80Cw04NmMCM89Kl8LLnnn4iOTuMaNE1I0oMsu
	3henoNReZaU67x2hno4dWFHSUQBV+4hmi/0L8DOZVxUO2Zi7q9byx9QYo/f4sjweSfREJpjEpiG
	LGHLhfi+WWvdQ9niCmgha2IJrkBQBAKVPWgtlZgIrU=
X-Received: by 2002:a05:6402:458a:b0:697:7f68:4340 with SMTP id 4fb4d7f45d1cf-698a2cd83d7mr1913877a12.20.1782991112809;
        Thu, 02 Jul 2026 04:18:32 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-698ad100047sm824496a12.14.2026.07.02.04.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 04:18:32 -0700 (PDT)
Message-ID: <1add6748-12cd-405e-8cf6-17f03907243f@suse.com>
Date: Thu, 2 Jul 2026 13:18:32 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/32] thermal/intel: Stop using 32-bit MSR interfaces
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>
References: <20260629060526.3638272-1-jgross@suse.com>
 <20260629060526.3638272-2-jgross@suse.com> <akYv_fhsLpTt15FI@gmail.com>
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
In-Reply-To: <akYv_fhsLpTt15FI@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Qz9p5umweWMe9ehZjIEhLj7S"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Qz9p5umweWMe9ehZjIEhLj7S
Content-Type: multipart/mixed; boundary="------------7QmReaKbPg0SN06bHvQZwRJC";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <1add6748-12cd-405e-8cf6-17f03907243f@suse.com>
Subject: Re: [PATCH 01/32] thermal/intel: Stop using 32-bit MSR interfaces
References: <20260629060526.3638272-1-jgross@suse.com>
 <20260629060526.3638272-2-jgross@suse.com> <akYv_fhsLpTt15FI@gmail.com>
In-Reply-To: <akYv_fhsLpTt15FI@gmail.com>

--------------7QmReaKbPg0SN06bHvQZwRJC
Content-Type: multipart/mixed; boundary="------------Dal5iinU0yKlHCK264bf9XJb"

--------------Dal5iinU0yKlHCK264bf9XJb
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDIuMDcuMjYgMTE6MzEsIEluZ28gTW9sbmFyIHdyb3RlOg0KPiANCj4gKiBKdWVyZ2Vu
IEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+IHdyb3RlOg0KPiANCj4+IC0JcmRtc3IoTVNSX0lB
MzJfVEhFUk1fSU5URVJSVVBULCBsLCBoKTsNCj4+ICsJcmRtc3JxKE1TUl9JQTMyX1RIRVJN
X0lOVEVSUlVQVCwgdmFsLnEpOw0KPj4gICAJaWYgKGNwdV9oYXMoYywgWDg2X0ZFQVRVUkVf
UExOKSAmJiAhaW50X3Bsbl9lbmFibGUpDQo+PiAtCQl3cm1zcihNU1JfSUEzMl9USEVSTV9J
TlRFUlJVUFQsDQo+PiAtCQkJKGwgfCAoVEhFUk1fSU5UX0xPV19FTkFCTEUNCj4+IC0JCQl8
IFRIRVJNX0lOVF9ISUdIX0VOQUJMRSkpICYgflRIRVJNX0lOVF9QTE5fRU5BQkxFLCBoKTsN
Cj4+ICsJCXZhbC5sID0gKHZhbC5sIHwgVEhFUk1fSU5UX0xPV19FTkFCTEUgfCBUSEVSTV9J
TlRfSElHSF9FTkFCTEUpICYNCj4+ICsJCQl+VEhFUk1fSU5UX1BMTl9FTkFCTEU7DQo+IA0K
PiBUaGlzIGNvdWxkIGJlIHdyaXR0ZW4gYXMgc29tZXRoaW5nIGxpa2U6DQo+IA0KPiAJCXZh
bC5sIHw9IFRIRVJNX0lOVF9MT1dfRU5BQkxFIHwgVEhFUk1fSU5UX0hJR0hfRU5BQkxFOw0K
PiAJCXZhbC5sICY9IH5USEVSTV9JTlRfUExOX0VOQUJMRTsNCj4gDQo+IFdoaWNoIHdvdWxk
IGJlIGZhciBtb3JlIHJlYWRhYmxlIHRoYW4gdGhlIG11bHRpLWxpbmUgc3RhdGVtZW50Lg0K
PiANCj4+ICsJCQl2YWwubCA9ICh2YWwubCB8IFBBQ0tBR0VfVEhFUk1fSU5UX0xPV19FTkFC
TEUgfA0KPj4gKwkJCQkgUEFDS0FHRV9USEVSTV9JTlRfSElHSF9FTkFCTEUpICYNCj4+ICsJ
CQkJflBBQ0tBR0VfVEhFUk1fSU5UX1BMTl9FTkFCTEU7DQoNCk9rYXksIHdpbGwgY2hhbmdl
Lg0KDQoNCkp1ZXJnZW4NCg==
--------------Dal5iinU0yKlHCK264bf9XJb
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------Dal5iinU0yKlHCK264bf9XJb--

--------------7QmReaKbPg0SN06bHvQZwRJC--

--------------Qz9p5umweWMe9ehZjIEhLj7S
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmpGSQgFAwAAAAAACgkQsN6d1ii/Ey/6
Lwf+Mo87j519X57DvBGL2+OX2CKWxI+Qk202y0/zIjOH5ezoYVUjFCPlSURjQAzF8pAkjRrkZIjB
e00U4yhZp7u7t4mBFF4WbB9GREMFN+2KyZgu5vD2i4jfty5GkP0ZlGJ2Hs2NPzqVo2gWvR+obm66
BPT7BKgeIfQUmGfrqKuHdDJqJwjOIykM8nS2w0J4K85P3SO+hxvVmpPy13dH4cI9u1vSpRHRF9za
eOBtzZE20AIc57FmwlK4ZVz7cCypNEw+Pgj/Z4NKWDnogEGAREYPPAIiI41OFVf8OygvJkBwC6B3
EcWLFXWIbjktWYsMzxyLVvnDpXWZ7IiKr3s9n46lDA==
=i1E1
-----END PGP SIGNATURE-----

--------------Qz9p5umweWMe9ehZjIEhLj7S--
