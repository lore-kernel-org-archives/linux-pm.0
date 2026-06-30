Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A7440B373
	for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 12:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823365; cv=none; b=DYvhus6kYpIDk5AbLhTFolJZljEJUhfXyuNYS41Q4kMurO3vZWUh5SE0XY1lyFaBz0HRwvRbOCtskqA2trC+DpCRU0iCKoBHWdVorlxuFMVU+RmBmctvC2H4xLuVUvV1a8tN+dOXneIKr2nXfFo277/1h0zeY0jNine5UsvHI5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823365; c=relaxed/simple;
	bh=UWtLRS95Rw87fOMMnFQsAy8y8t9RLlsuznMLaDcRnTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hhe6eGgCB+cx5vxuuFlhrQy2UyjxCLkIVpO/FGBp7UIIWuCU8M66LkmnmwkNutcuNnvOpyFQso2sEXP/yWRtt82//uppl8vqe254c5oJ1Yk7u/8VcWZnDuPEAo8QU6tm64vpRff9pw/GWNfGvg8MN2b/XLl7BuPDL/+LshSSlM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HnNeU9BL; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HnNeU9BL"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6976b0c5adbso8043745a12.2
        for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 05:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782823361; x=1783428161; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UWtLRS95Rw87fOMMnFQsAy8y8t9RLlsuznMLaDcRnTE=;
        b=HnNeU9BLH83347YtHl9QaNp4Heg38pv2pithTvGVOgJFwF5QTVrzlUUanB9TKuCuS4
         Ncq1bPQ09T1B9RQrfPxpvhd4XC5ultsI5oD16aIWH1s2lsxfxNJR43G7TPyVrcrmNWPn
         o127YpqrtS1ER4PidwRepeWMuUeDKg9zoJNXhokZnpYM0yO6lV2Z35ZgeBplK6Z7oNE9
         DgwRJsbHojXt3PHhIGXw+HJU6FDiLn49KK14hSzmOjUstTP9p2VG+2EQZy1MbivLVK9d
         EDVFZlRos7EgaHWkHP8eCGdkkyhxrHFRN/WJKa0bskXo+P+JSv7/jKrOEwdVAldRyxqu
         GfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782823361; x=1783428161;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UWtLRS95Rw87fOMMnFQsAy8y8t9RLlsuznMLaDcRnTE=;
        b=JDsARD+rtUcp37rBXyFTSRyCgtx3Suz4PEtIiTfByq0ELQA+yQqifZnMDh6lrVhkHP
         25J/55wV11Gx2PBfjeOrmgSbJK24vO9D5RTjDUds/hd6qIJL11vpDnMF+7VcdYHjTBo0
         cgP1ysZgHYXTZPuMYWLLJ0WSJh6dWI4/z2p/GYBgJVQp/Hvzq+g1hreoOWJPf+w7zGQK
         RU7kJ+CFZfkmpoIvA8pppeHjgqPnjxK4hBB2RAXR6VV0qnnTb4t8806ocbzSUJwv2YXc
         cc+tZxxic1o2ZY8CLg8rUdUMQUrC7E6xCmrIiWIULhQ9clynS/Fd2YebKCzXe1lFiQJn
         WCRQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp7qBrf67r+UXp3gaeRxa4gsvplysk+9gjRQ+ARYgtRpHQJs5p8SBwYAmADGQiIrsutX5EpMEOVcA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYqIMSVlZfzSQ2TnHAZCXy8NENEE3sJBuUws2rbpNA+DTRH9D/
	LOEkMn2tej5LoE8R1HDu8gryOBkmzNS/eATwsjBguvBFiN6VF7Wb3iIQg7mAylOen0g=
X-Gm-Gg: AfdE7cludtd4DGSgXbyh/DNX0dYF1bCS/K3htFwdBWhAeiK1bYPWg5qRvXE4xvBQ9VV
	Ffdl93Fty+Q11xy4UunZdPA3KDnzztqea0s6X2f6PXYzR1p0EU93BiwEZEhfvpWOE7fakDxAGyZ
	bHPgNjoPfJ/+SA2oTfsLpY9vXB0meFpj8456d0tqfPYyc/D1xpZt9e21pksJplIT8vrUY8B/jIr
	Igvwzml2DutdtuFXKphro7S25IK1B+uyqc/Kd1UP2V8/9agPSNtthXyUg63PkGz/eLpce/UDnRH
	kfNjhf5I5fMADB19GPHxuY4zeAHe56q5HQ6580yGhwo8LmXcu5jVkxtKufwWM9DDayxLsfTS04p
	nkzUfczT6c395XTCWq7L9tLgyFJ1POFYoRgj5gTUWKw3hBDm9PJwDNgljXDsh2NhKBFJwHhAKBu
	P2ibMN7msskF3O+1VZ4yjDr8/SpsSipyqvczHxI0wrAVnletbQu4SE0OqWtuy2jtu1J3GwR6q+A
	4gP6iawD2rlUOD3hGp5ref3UhdgUrVkD4NqieXAGAI=
X-Received: by 2002:a05:6402:194a:b0:698:7989:e74e with SMTP id 4fb4d7f45d1cf-69879df825bmr1395710a12.17.1782823361551;
        Tue, 30 Jun 2026 05:42:41 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6987c3a3bc5sm1161190a12.5.2026.06.30.05.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 05:42:41 -0700 (PDT)
Message-ID: <95a4c9fc-6970-4170-8355-66593d29dd31@suse.com>
Date: Tue, 30 Jun 2026 14:42:40 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/32] acpi: Stop using 32-bit MSR interfaces
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
References: <20260629060526.3638272-1-jgross@suse.com>
 <20260629060526.3638272-5-jgross@suse.com>
 <CAJZ5v0itUVZ6=GCbRomkMiesy5uhZVWWjsUbqFqsZTyNeCBAbQ@mail.gmail.com>
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
In-Reply-To: <CAJZ5v0itUVZ6=GCbRomkMiesy5uhZVWWjsUbqFqsZTyNeCBAbQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------aN4DNfaK2MUYFsWBV8V80Qu4"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------aN4DNfaK2MUYFsWBV8V80Qu4
Content-Type: multipart/mixed; boundary="------------rQonZjHp2ttw4lV0zSdS2ZK0";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <95a4c9fc-6970-4170-8355-66593d29dd31@suse.com>
Subject: Re: [PATCH 04/32] acpi: Stop using 32-bit MSR interfaces
References: <20260629060526.3638272-1-jgross@suse.com>
 <20260629060526.3638272-5-jgross@suse.com>
 <CAJZ5v0itUVZ6=GCbRomkMiesy5uhZVWWjsUbqFqsZTyNeCBAbQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0itUVZ6=GCbRomkMiesy5uhZVWWjsUbqFqsZTyNeCBAbQ@mail.gmail.com>

--------------rQonZjHp2ttw4lV0zSdS2ZK0
Content-Type: multipart/mixed; boundary="------------4ZZtOm0WNhj6geyiYY8fl45E"

--------------4ZZtOm0WNhj6geyiYY8fl45E
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMzAuMDYuMjYgMTQ6MzAsIFJhZmFlbCBKLiBXeXNvY2tpIChJbnRlbCkgd3JvdGU6DQo+
IE9uIE1vbiwgSnVuIDI5LCAyMDI2IGF0IDg6MDXigK9BTSBKdWVyZ2VuIEdyb3NzIDxqZ3Jv
c3NAc3VzZS5jb20+IHdyb3RlOg0KPj4NCj4+IFRoZSAzMi1iaXQgTVNSIGludGVyZmFjZXMg
cmRtc3IoKSwgd3Jtc3IoKSwgcmRtc3Jfc2FmZSgpIGFuZA0KPj4gd3Jtc3Jfc2FmZSgpIGFy
ZSBwbGFubmVkIHRvIGJlIHJlbW92ZWQuIFVzZSB0aGUgcmVsYXRlZCA2NC1iaXQgdmFyaWFu
dHMNCj4+IGluc3RlYWQuDQo+Pg0KPj4gSW4gcHJvY2Vzc29yX3Rocm90dGxpbmcuYyBkcm9w
IG5lZWRsZXNzIGluaXRpYWxpemVycy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBKdWVyZ2Vu
IEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQo+IA0KPiBMR1RNIG92ZXJhbGwuDQoNClRoYW5r
cy4NCg0KPiBEbyB5b3Ugd2FudCBtZSB0byBwaWNrIGl0IHVwIG9yIGRvIHlvdSBwcmVmZXIg
dG8gcm91dGUgaXQgYWxvbmcgd2l0aA0KPiB0aGUgcmVzdCBvZiB0aGUgc2VyaWVzPw0KDQpJ
J20gZmluZSB3aXRoIHlvdSBwaWNraW5nIGl0IHVwLg0KDQoNCkp1ZXJnZW4NCg==
--------------4ZZtOm0WNhj6geyiYY8fl45E
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------4ZZtOm0WNhj6geyiYY8fl45E--

--------------rQonZjHp2ttw4lV0zSdS2ZK0--

--------------aN4DNfaK2MUYFsWBV8V80Qu4
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmpDucAFAwAAAAAACgkQsN6d1ii/Ey9Q
FQgAkFD0QFADmNiTgrOqGnJOXVOnYmP6SS+YNb9VT5te4L9EDmH/GC6oulvodGeWdyuAmC2UnUK2
i2Pxy4M7imLWw/ECu9ucQx3uthMN6UvGSwsTjG9lJTbl9RWoXzEzlzESeWi9MEYXvpqj3pyHDNnn
VIQO9tWupb0XSqJ5ub4+ldg2i0btspxwcOFMOKHwQdhM7ln2pDI0EYowyy8yDn5VYjsaMht3MwEj
F/mIVuwDBNDZVcYBxnL3fpa/uRJYnhfvJlIep0qvtzxCKi3QXYTvghsipKwsA3PT2DGywSeUmsLv
2mFA0DX7BMZBYiFLP4uvQaChvND0Pts0b98RzcqlZQ==
=2JcO
-----END PGP SIGNATURE-----

--------------aN4DNfaK2MUYFsWBV8V80Qu4--
