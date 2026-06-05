Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B977372ED5
	for <linux-pm@vger.kernel.org>; Fri,  5 Jun 2026 15:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780672198; cv=none; b=ey2qaUP0/r5l1KzJjQGSW+eqZdc//Asuvt6IUVQ16GIYjVMmVo5Y1xEQjj0p2PysO2XHaHAaDDzOI1AandUArYoUTcpZ5xylq7MOMeT5vDBAX4OR88DIndIqb38+igwF8QI+4/1URt5l1uTgQQiRncH7Z2Z1Jb47W0rF2ZL4oJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780672198; c=relaxed/simple;
	bh=d/PRN/C2ZY+2mNKXnjEZyNJoguXeoxxhz4uGxSVVtIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dCfjexGtT/KJQKp1iaakjkDRAz1/BlnjMhoQH88HTLIFUzeSU1LnRYWJb8C5s8uNrlUXrOz6eE8A7Vud/ENqgc24xy3N6dLs/wtjfzguBPzASEg0XpjtM13zEBtJsplWIXzPYeAMx5hTL6rLtq78/opYRYHxDsT6DIpl1u5ewvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LEoj5tmr; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LEoj5tmr"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-68cec9f4c6cso2971667a12.0
        for <linux-pm@vger.kernel.org>; Fri, 05 Jun 2026 08:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780672196; x=1781276996; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d/PRN/C2ZY+2mNKXnjEZyNJoguXeoxxhz4uGxSVVtIU=;
        b=LEoj5tmriDs9q0GR/+PBbJBKk8k0C+sboSdRdc5mGmPY80BAhvSpZbPPXFOe88zBMH
         zic2HG1Etjbg/PzQ2JMAU2ukZqkoUEyGYqYm/+HPcXYIczG6YFuI3Q+EHoVxJl/2lVbv
         GuscKYh6lbQoIT9cr+Wz07UTBMW4NMlj5AtEWCVL6Gj7SPE6R16LYuXRTBI00pxiAyuq
         m/XUYkjguxH+XP7uNZMgA7BU6hW/iXR0f/Bn8eO/RuspRA4fvGYsS0mTYLvGfaXshlZ1
         2m6KXXbQDL5Bkp/xVpDS4F1ApPDU3H5gLlfHnUtLS1shoMg2Hl9sEGB3Mha9/mrKiJGu
         JKsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780672196; x=1781276996;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d/PRN/C2ZY+2mNKXnjEZyNJoguXeoxxhz4uGxSVVtIU=;
        b=QbeeHvOlkm5T0AVOu8nO4iAL4LV95Bylq4MKxQNN5P/fWE+H8qwf2uC56yf2TIa9NG
         KQy7pb08UF9eqSH2fuwKZ/DfGaAIA7FNyesveigEaB4xJ2CDi2yBGaMi9u4Yw8IvSebs
         qeltw8FSYdbyhT2tCw7yavep9wWBgUYO/9mv8dogdtRB7/q0jbxFDzTV3sK8Mj1Rlub9
         6rw8er3caov4zh6cISww+JTAhxZbwG8vyJEY/3TdNUGYDg6bGu7AC+C+de3+3SKCEsyA
         sqe6+me0DmJ647wTta9fBL+murpHL3Q9RlhJMuL0EJ3Upv/zO7kEn1pKcbi0lLoh8RxD
         sGMw==
X-Forwarded-Encrypted: i=1; AFNElJ+mfV+lbi+qujFYZJhYzKMg9EaDMSHphpe3CA86f8oim+aLFVJJvhxcM0EUM2l2VJ4pDoSMtmm9qg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/0qXb6u0rlqYxrV5Pw3TMZBGvTU+ucsqGbpgTdYh30qYehxlx
	00jxAj3J0wmts1qr2o1DFJPmZCltJOOOTp/V4Rs7yYgrQXsiE6OUMZptemQxCpBDwlU=
X-Gm-Gg: Acq92OH2L1j/HH3nM9/78ndrN4tZZXKuuM6l6aFI1hcSFfPRkfnTPnYC4Mu12iBkCuk
	Q21Ii1MuEoK+72wpLXNLjYA0hyFKkFkLBvLIshLxW+b7tmqSCJBNyyCbJ16lioWyPb1mEmmByQX
	uzzjInrdZ6+HpNm306XlZJNXIMZywKbqIKMpgSnGmOXtQ+GqUZy0Pmpd2ulQXRPBBkNxXYVeA4S
	UdGFpEZRxdVLjUtdfPAaRvxwIyxldMlbhG+tyv8aHzu4cEkgqzkVP5Q3TmJkKClND3c1rkykbJ5
	IxW0Um+gzVstRaK2TlKcF2svBxJkkVFJDTIQIDMXtiiccD0QgIUapRzZh5zQqQC7+hq+PlxYF+3
	eGGQ9llQ8OGKWW0UlprWFCVVvQn1s1W1hsFViX2dTCl8x3zEeEBsZFTjV3OykLuVKfw9995ZGrM
	dYEqvIzE5tNwvfWM1gcy0GP1lzWMN5O+dfEFvMYRKdiUcQok+FFEDLPcOUJp2coHTRzIPzEvpbT
	gomP/VNsCypwB8YpdRHADR5/m7UB+TeRZl8xEKZqLTK+nlWWyNSXRzX9t1Oiytr
X-Received: by 2002:a17:907:608b:b0:bec:9f90:629d with SMTP id a640c23a62f3a-bf3743ea8d5mr257957366b.39.1780672195972;
        Fri, 05 Jun 2026 08:09:55 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf0559f1f62sm480462366b.57.2026.06.05.08.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 08:09:55 -0700 (PDT)
Message-ID: <152901f0-d1cf-4106-9b10-39d16c9a4f55@suse.com>
Date: Fri, 5 Jun 2026 17:09:54 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] x86/msr: Drop 32-bit variants of *_on_cpu() MSR
 functions
To: Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, x86@kernel.org, linux-edac@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Huang Rui <ray.huang@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Tony Luck <tony.luck@intel.com>, Guenter Roeck <linux@roeck-us.net>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>
References: <20260605144314.3031049-1-jgross@suse.com>
 <633a8b8a-9dd8-410d-a9a5-a9cd2e87e63b@intel.com>
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
In-Reply-To: <633a8b8a-9dd8-410d-a9a5-a9cd2e87e63b@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------CfFMPknLyQaN7sy2Q0kqkhmo"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------CfFMPknLyQaN7sy2Q0kqkhmo
Content-Type: multipart/mixed; boundary="------------E4xAZx8nWliBbcWRKh5sEs0A";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, x86@kernel.org, linux-edac@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Huang Rui <ray.huang@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Tony Luck <tony.luck@intel.com>, Guenter Roeck <linux@roeck-us.net>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>
Message-ID: <152901f0-d1cf-4106-9b10-39d16c9a4f55@suse.com>
Subject: Re: [PATCH v2 00/10] x86/msr: Drop 32-bit variants of *_on_cpu() MSR
 functions
References: <20260605144314.3031049-1-jgross@suse.com>
 <633a8b8a-9dd8-410d-a9a5-a9cd2e87e63b@intel.com>
In-Reply-To: <633a8b8a-9dd8-410d-a9a5-a9cd2e87e63b@intel.com>

--------------E4xAZx8nWliBbcWRKh5sEs0A
Content-Type: multipart/mixed; boundary="------------rsMyfZxZc8gld63N7FQonwvB"

--------------rsMyfZxZc8gld63N7FQonwvB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDUuMDYuMjYgMTc6MDgsIERhdmUgSGFuc2VuIHdyb3RlOg0KPiBPbiA2LzUvMjYgMDc6
NDMsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+PiAgIGFyY2gveDg2L2V2ZW50cy9pbnRlbC9k
cy5jICAgICAgICAgICAgICAgICAgIHwgMTEgKy0tDQo+PiAgIGFyY2gveDg2L2luY2x1ZGUv
YXNtL21zci5oICAgICAgICAgICAgICAgICAgIHwgMjggKy0tLS0tDQo+PiAgIGFyY2gveDg2
L2tlcm5lbC9jcHUvbWNlL2FtZC5jICAgICAgICAgICAgICAgIHwgIDYgKy0NCj4+ICAgYXJj
aC94ODYva2VybmVsL2NwdS9tY2UvaW5qZWN0LmMgICAgICAgICAgICAgfCAgOCArLQ0KPj4g
ICBhcmNoL3g4Ni9rZXJuZWwvbXNyLmMgICAgICAgICAgICAgICAgICAgICAgICB8ICA4ICst
DQo+PiAgIGFyY2gveDg2L2xpYi9tc3Itc21wLmMgICAgICAgICAgICAgICAgICAgICAgIHwg
ODkgKysrLS0tLS0tLS0tLS0tLS0tLS0NCj4+ICAgZHJpdmVycy9jcHVmcmVxL2FtZC1wc3Rh
dGUuYyAgICAgICAgICAgICAgICAgfCAgMiArLQ0KPj4gICBkcml2ZXJzL2NwdWZyZXEvYW1k
X2ZyZXFfc2Vuc2l0aXZpdHkuYyAgICAgICB8ICA2ICstDQo+PiAgIGRyaXZlcnMvY3B1ZnJl
cS9wNC1jbG9ja21vZC5jICAgICAgICAgICAgICAgIHwgMzIgKysrLS0tLQ0KPj4gICBkcml2
ZXJzL2NwdWZyZXEvc3BlZWRzdGVwLWNlbnRyaW5vLmMgICAgICAgICB8IDI3ICsrKy0tLQ0K
Pj4gICBkcml2ZXJzL2h3bW9uL2NvcmV0ZW1wLmMgICAgICAgICAgICAgICAgICAgICB8IDQ0
ICsrKysrLS0tLS0NCj4+ICAgZHJpdmVycy9od21vbi92aWEtY3B1dGVtcC5jICAgICAgICAg
ICAgICAgICAgfCAxNiArKy0tDQo+PiAgIGRyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnRlbF90
Y2MuYyAgICAgICAgICAgIHwgNDMgKysrKystLS0tLQ0KPj4gICBkcml2ZXJzL3RoZXJtYWwv
aW50ZWwveDg2X3BrZ190ZW1wX3RoZXJtYWwuYyB8IDI1ICsrKy0tLQ0KPj4gICAxNCBmaWxl
cyBjaGFuZ2VkLCAxMjggaW5zZXJ0aW9ucygrKSwgMjE3IGRlbGV0aW9ucygtKQ0KPiANCj4g
VGhpcyBpcyB3b25kZXJmdWwuIFRoYW5rIHlvdSBmb3IgZG9pbmcgdGhpcyENCj4gDQo+IE15
IG9ubHkgcmVhbCBjb21wbGFpbnQgaXMgdGhlIGxhY2sgb2YgY2hhbmdlbG9nIGZvciAwNy8x
MC4gT3RoZXJ3aXNlLCBpdA0KPiBsb29rcyBncmVhdCB0byBtZS4gSWRlYWxseSwgeW91J2Qg
Y29sbGVjdCBhIGZldyBtb3JlIHJldmlld3MgYW5kIHBvc3QgYQ0KPiB2MyByZWJhc2VkIHJp
Z2h0IGFmdGVyIHRoZSBuZXh0IC1yYzEuDQo+IA0KPiBSZXZpZXdlZC1ieTogRGF2ZSBIYW5z
ZW4gPGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbT4NCg0KVGhhbmtzLCB3aWxsIGRvIGFz
IHlvdSBzdWdnZXN0Lg0KDQoNCkp1ZXJnZW4NCg==
--------------rsMyfZxZc8gld63N7FQonwvB
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------rsMyfZxZc8gld63N7FQonwvB--

--------------E4xAZx8nWliBbcWRKh5sEs0A--

--------------CfFMPknLyQaN7sy2Q0kqkhmo
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmoi5sMFAwAAAAAACgkQsN6d1ii/Ey9v
bQf+P+RkcVUYjR/aFpHi/+lABtHiJYBdl6uoMtnlzC/iXalXkTLimPnC9FEb41Vv6DUXDNaBGRwB
WezmTxZektPwGCfiLLLGzbudSajp/h7b6QxHk1XNVBimKzcyYLyqhrWHRVgP05+iXVg7muGlWV9w
owF9qGVTOK+LtqeGfZyXNFDfEVJDXtVqljU2x/er/Q+LnRz6WItXkPI3Q9s/CP79n6PYZUdF/q9+
sI6/WhXuPR0mu6uYNzb4PlNEgEk6i6dycsaPFSkEk3t+HZo2LN52/DgeRnxEljVJHcktrrLK9CSQ
mM3vW3YduyXDPM6JtOoTc/6tXu4qSDS4zCQXdmTkgw==
=1HUx
-----END PGP SIGNATURE-----

--------------CfFMPknLyQaN7sy2Q0kqkhmo--
