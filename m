Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1D13F5BF5
	for <linux-pm@vger.kernel.org>; Fri,  5 Jun 2026 10:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780653992; cv=none; b=tx34EPCH7JCmrnOn5EqtB79t65vohkWaKhy55KXPp3DpVMdqylWGAUywEMcREwfm7CqvLuQYRx1OjkS0y6tbDhgz2I+w5H8AfyVEp6mqWI+f3a+NlOWHNX1wDp6jAF6jPtjoIdmPAmbz2NnxDJuIZW2aokn6IxdYgbj8AL7AQHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780653992; c=relaxed/simple;
	bh=cRhepLsRkNAd6d/Dkyuf2TN0aczQ9ChDd+Shad/mEO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r3LFwPbE+5TODK9XwX+SGI6TtNUTrnQSWe/gUbz2aa5EieWh2gFmfMH9QAa3MGZwIRbQ8g6rjpYi1kaE13hDrHbdfTTMNJuhoKq2PXgiaETXAjYQPduaDKFQVaSG5HFV0GfQ40aIcPrc6B+/QgP1lnkmqB6OsxOqEPTdGMpwpvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FblYBSmB; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FblYBSmB"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-68c08bfe5afso3241531a12.2
        for <linux-pm@vger.kernel.org>; Fri, 05 Jun 2026 03:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780653989; x=1781258789; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cRhepLsRkNAd6d/Dkyuf2TN0aczQ9ChDd+Shad/mEO0=;
        b=FblYBSmBPPbL0YMuGZO+e+b2Qz6L8M9PrgH58I0PQQLnCG7RNpU71qtKyflhLGZB+w
         K+8rZwEgi/aCeEM0j0bX0IiFDMl4/kRHXpE1aLniLbmzTrWgOB4CEul7QLCTjBSeGC0C
         MNBPaNszKOmQWGbn5z2b2nq2Y8iK2kPdla9OIflhMAgK+SAztPmwnNm8yyy0LbXNwUgc
         iXorNJuOR2JZesYlnDbp+E7BrCce8oWiQwdNojHVHIJOaKX4ot4Lfc9Utm4bwuMlM/Ov
         DSAzql8mkE1lZZdhOuyrlBwObg3w4UhV1JX0T58GlafQszPrZpQq/tbKNLJ+Mya3WR5/
         pZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780653989; x=1781258789;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cRhepLsRkNAd6d/Dkyuf2TN0aczQ9ChDd+Shad/mEO0=;
        b=SFHHG1n3uyeerE00PaPoUMMvLAs3t2bg9Tt8h7wTipNcj7Xeo2/1xMz5AApz8J0Fno
         jUaASgB80MmCxh7GGayLJjS5i+ccm9JqEQIil1pB5zRdGWzctKhF+eGw3KPmHU7PMGmi
         K9o8BY67Ulpz9XTug3XvdzSuUfMOS1/L3hWJdHIurX3mkgegtQw5iEnDb92QK50EuTzN
         oMmeDHnogPd1PX7AfdaDuBOcpOId6O9Is/uCbCbqAejRvf5CBliTB87rNoVJy7JLtmgq
         AcafLB8ToooJFqW2Yx/P8S/Vbnk17fyDOZcBM27qG7tasbkLRw1M+fB81AJ01fN3wETx
         q+4g==
X-Forwarded-Encrypted: i=1; AFNElJ+vMphPDDI6l/hn7UcFGBvceAmRZZ76athXHp4qct2wJpwFoMEtoXClHMefV+OQntfGmxmf3NuVaA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7qeIKpoyP+j1CM42teQ7trM/UcZhKSFWPRMxMdJQXXHdB01R2
	hIJ6DfDofJ+yYOogU1GnxF1ztToPlRXrgr69oT1WUKXvDDgWFx1W40gCjklA6GPozDc=
X-Gm-Gg: Acq92OEG54ar8OHEJSVL0tqYSOK0Pgy1g+ne26zGqTi2jqC3062PtkyD8hZzPfFnkg/
	dFRetuzbbHWDYhF8RWDYnFj8cEaLXX2Tm9RCwTg49gd2AhINuzK7WJLJ1tz+KSuWBzXsYkG/6eh
	cmAGOtmOW+bssHGMFuU/Zy7LehH7dkyz6cjb7bAK3pgU33A7d/edcI/sNv/2iURLVC5Rwc9k8ag
	FiXz/xI1dwF5JO21fH2ECVFFtOM/7eopbA2MjPbpKuZjY2X8T5lx0iXmgDPB2EnKW1PnNuzUE85
	v7oTLA+WheLSjbcptPjesFV+JkET4KSaU8aLgN4IRS+8qEw6KtVmWWrz66g6yxOctryEqn/6ipQ
	0RWoxXzHbji5A5LQaw5PLax0Qssvdk5QmFGDruHLkwh93qls2XEzftiFeR8P4GYd+fWZWkMG/Ty
	QO6b+o6oOgVY4Tp7y42i12YxhA64AaD7UfM1/wDTAlhdpTj0Gx0UJCXCcrpD7+Rg9uwwrP/H7Ks
	Lsyv3MyKRlH1Ds1Jov5O9N0FeOl2yKsMRSQupL9ETX33wDTdkb8eDJDCfHPfAK0
X-Received: by 2002:a05:6402:5201:b0:687:f18:c37f with SMTP id 4fb4d7f45d1cf-68fa514b053mr1541082a12.22.1780653989412;
        Fri, 05 Jun 2026 03:06:29 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e65b4d988sm3565186a12.25.2026.06.05.03.06.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 03:06:19 -0700 (PDT)
Message-ID: <6f989d86-bbb8-47fd-8367-b2c8a3c5f6f5@suse.com>
Date: Fri, 5 Jun 2026 12:06:12 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] x86/msr: Drop 32-bit variants of *_on_cpu() MSR
 functions
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-edac@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-perf-users@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Guenter Roeck <linux@roeck-us.net>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Huang Rui <ray.huang@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Len Brown <lenb@kernel.org>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20260605070826.2995913-1-jgross@suse.com>
 <aiKRbRHyDCjmqvGB@gmail.com> <a477aefe-e1c8-4652-b263-86c4cce09eba@suse.com>
 <aiKUenaT9VD0DrpW@gmail.com> <b7e799a6-1f1a-49ef-8aac-0d5fd4a06dc7@suse.com>
 <aiKcz6I8GO-TG8uq@gmail.com> <aiKdSPS-YT6KZV81@gmail.com>
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
In-Reply-To: <aiKdSPS-YT6KZV81@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------TqpVRvHG9JxgX9GL0sRxBCyG"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------TqpVRvHG9JxgX9GL0sRxBCyG
Content-Type: multipart/mixed; boundary="------------Da1SKvb0yQ6c70iODbaa72pf";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-edac@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-perf-users@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Guenter Roeck <linux@roeck-us.net>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Huang Rui <ray.huang@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Len Brown <lenb@kernel.org>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Message-ID: <6f989d86-bbb8-47fd-8367-b2c8a3c5f6f5@suse.com>
Subject: Re: [PATCH 0/8] x86/msr: Drop 32-bit variants of *_on_cpu() MSR
 functions
References: <20260605070826.2995913-1-jgross@suse.com>
 <aiKRbRHyDCjmqvGB@gmail.com> <a477aefe-e1c8-4652-b263-86c4cce09eba@suse.com>
 <aiKUenaT9VD0DrpW@gmail.com> <b7e799a6-1f1a-49ef-8aac-0d5fd4a06dc7@suse.com>
 <aiKcz6I8GO-TG8uq@gmail.com> <aiKdSPS-YT6KZV81@gmail.com>
In-Reply-To: <aiKdSPS-YT6KZV81@gmail.com>

--------------Da1SKvb0yQ6c70iODbaa72pf
Content-Type: multipart/mixed; boundary="------------wGgS4ganA3WbEq7JPL9B9fB0"

--------------wGgS4ganA3WbEq7JPL9B9fB0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDUuMDYuMjYgMTE6NTYsIEluZ28gTW9sbmFyIHdyb3RlOg0KPiANCj4gKiBJbmdvIE1v
bG5hciA8bWluZ29Aa2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPj4NCj4+ICogSsO8cmdlbiBH
cm/DnyA8amdyb3NzQHN1c2UuY29tPiB3cm90ZToNCj4+DQo+Pj4+IFdlbGwsIHdlIGhhZCBh
IHNpbWlsYXIgZGlzY3Vzc2lvbiBiYWNrIHdoZW4gd2Ugc3RhbmRhcmRpemVkIG9uDQo+Pj4+
IHJkbXNycSgpIGFuZCB3cm1zcnEoKSwgYW5kIHdlIHVzZSB0aGVtIGFzIG91ciBwcmltYXJ5
IDY0LWJpdA0KPj4+PiBNU1IgaGFuZGxpbmcgQVBJcy4gV2h5IGhhdmUgYSBkaWZmZXJlbnQg
cGF0dGVybiBpbiBhbnkgb2YgdGhlDQo+Pj4+IGRlcml2ZWQgQVBJcz8gSXQgc2hvdWxkIHJl
YWxseSB1c2UgdGhlIHNhbWUgY29uY2VwdHVhbCBuYW1lc3BhY2UsDQo+Pj4+IG5vdCBzb21l
IGNvbmZ1c2luZyBtaXh0dXJlIG9mIHR3byBuYW1pbmcgc2NoZW1lcy4NCj4+Pg0KPj4+IElu
IHRoZSBsb25nIHJ1biBJJ2QgbGlrZSB0byBkbyB0aGUgc2FtZSBjb252ZXJzaW9uIGZvciB0
aGUgcmRtc3IqKCkgYW5kDQo+Pj4gd3Jtc3IqKCkgaW50ZXJmYWNlcywgdG9vIChzbyBvbmx5
IG9mZmVyaW5nIGFuZCB1c2luZyB0aGUgNjQtYml0IHZhcmlhbnRzKS4NCj4+DQo+PiBXaHk/
IFdlIGhhZCB0aGlzIGRpc2N1c3Npb24gZm9yIHRoZSBvcmlnaW5hbCBNU1IgQVBJIG5hbWVz
cGFjZQ0KPj4gY2xlYW51cCBhIHllYXIgYWdvLCBhbmQgZGVjaWRlZCB0byBzdGFuZGFyZGl6
ZSBvbiB0aGUgcmRtc3JxKCkvd3Jtc3JxKCkNCj4+IG5hbWVzcGFjZToNCj4+DQo+PiAgICBj
NDM1ZTYwOGNmNTkgeDg2L21zcjogUmVuYW1lICdyZG1zcmwoKScgdG8gJ3JkbXNycSgpJw0K
Pj4gICAgNzgyNTVlYjIzOTczIHg4Ni9tc3I6IFJlbmFtZSAnd3Jtc3JsKCknIHRvICd3cm1z
cnEoKScNCj4+ICAgIDZmZTIyYWJhY2Q0MCB4ODYvbXNyOiBSZW5hbWUgJ3JkbXNybF9zYWZl
KCknIHRvICdyZG1zcnFfc2FmZSgpJw0KPj4gICAgNmZhMTdlZmU0NTQ0IHg4Ni9tc3I6IFJl
bmFtZSAnd3Jtc3JsX3NhZmUoKScgdG8gJ3dybXNycV9zYWZlKCknDQo+PiAgICA1ZTQwNGNi
N2FjNGMgeDg2L21zcjogUmVuYW1lICdyZG1zcmxfc2FmZV9vbl9jcHUoKScgdG8gJ3JkbXNy
cV9zYWZlX29uX2NwdSgpJw0KPj4gICAgMjdhMjNhNTQ0YTU1IHg4Ni9tc3I6IFJlbmFtZSAn
d3Jtc3JsX3NhZmVfb25fY3B1KCknIHRvICd3cm1zcnFfc2FmZV9vbl9jcHUoKScNCj4+ICAg
IGQ3NDg0YmFiZDJjNCB4ODYvbXNyOiBSZW5hbWUgJ3JkbXNybF9vbl9jcHUoKScgdG8gJ3Jk
bXNycV9vbl9jcHUoKScNCj4+ICAgIGM4OTVlY2RhYjJlNCB4ODYvbXNyOiBSZW5hbWUgJ3dy
bXNybF9vbl9jcHUoKScgdG8gJ3dybXNycV9vbl9jcHUoKScNCj4+ICAgIGViZTI5MzA5YzRk
MiB4ODYvbXNyOiBSZW5hbWUgJ21jZV9yZG1zcmwoKScgdG8gJ21jZV9yZG1zcnEoKScNCj4+
ICAgIDhlNDRlODNmNTdjMyB4ODYvbXNyOiBSZW5hbWUgJ21jZV93cm1zcmwoKScgdG8gJ21j
ZV93cm1zcnEoKScNCj4+ICAgIGUyYjhhZjBjNjkzOSB4ODYvbXNyOiBSZW5hbWUgJ3JkbXNy
bF9hbWRfc2FmZSgpJyB0byAncmRtc3JxX2FtZF9zYWZlKCknDQo+PiAgICA2MDRkMTVkMTVl
YmQgeDg2L21zcjogUmVuYW1lICd3cm1zcmxfYW1kX3NhZmUoKScgdG8gJ3dybXNycV9hbWRf
c2FmZSgpJw0KPj4gICAgN2NiYzJiYTdjMTA3IHg4Ni9tc3I6IFJlbmFtZSAnbmF0aXZlX3dy
bXNybCgpJyB0byAnbmF0aXZlX3dybXNycSgpJw0KPj4gICAgZWVmNDc2ZjE1YzgzIHg4Ni9t
c3I6IFJlbmFtZSAnd3Jtc3JsX2NzdGFyKCknIHRvICd3cm1zcnFfY3N0YXIoKScNCj4+DQo+
PiBUaGVyZSdzIHNldmVyYWwgZ29vZCByZWFzb25zIHRvIHVzZSB0aGUgJ3EnIHN1ZmZpeCBp
biB0aGUgQVBJIG5hbWVzLA0KPj4gd2h5IHJlbGl0aWdhdGUgdGhpcz8gOi0pDQo+IA0KPiBB
bmQganVzdCB0byBiZSBjbGVhcjogSSBoYXZlIG5vIG9iamVjdGlvbnMgd2hhdHNvZXZlciB0
bw0KPiBwaGFzaW5nIG91dCBhbGwgdGhlIG9sZCAzMi1iaXQgQVBJcywgbGlrZSB5b3VyIHNl
cmllcyBkb2VzLg0KDQpUaGFua3MgZm9yIHRoZSBjb25maXJtYXRpb24uIDotKQ0KDQpBbmQg
cmVnYXJkaW5nIHRoZSAicSIgc3VmZml4OiBJJ20gbm90IGluc2lzdGluZyB0byBkcm9wIGl0
LCBJIGp1c3QgZmVsdCBpdCB3b3VsZA0Kbm8gbG9uZ2VyIGJlIG5lZWRlZCB3aGVuIHRoZSB2
YXJpYW50cyB3aXRob3V0IHN1ZmZpeCBubyBsb25nZXIgZXhpc3QuIElmIHlvdQ0KbGlrZSB0
byBrZWVwIGl0LCB0aGVuIGJlIGl0IHNvLg0KDQoNCkp1ZXJnZW4NCg==
--------------wGgS4ganA3WbEq7JPL9B9fB0
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------wGgS4ganA3WbEq7JPL9B9fB0--

--------------Da1SKvb0yQ6c70iODbaa72pf--

--------------TqpVRvHG9JxgX9GL0sRxBCyG
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmoin5QFAwAAAAAACgkQsN6d1ii/Ey+B
tQgAnalu6YDwl7RAxP1bHeyoU9ECkDR1tBNBsYxRi0JmwByzbS3zzWmmvqA4PCeVfGzSVvuIim2f
ExvmQqBRKkssFdrolUukjdn8/bKTnGxf7uqzAsVaxkvBvioFPCUVSn7c1aZYQnXdbEHawXmxdR68
zsBgnUFbsY6NW/IlHx2OyBFJtbgvDazWEweozfMFxlB4hjLnWlsvxjelQz7Yrjlw36KaCzZrdA1E
3TT8GSe/HIAF9q+xZChDMoFOz1P5RPibCLkAKF5Xz29ffrwptZRoulmnaJcPWdgbRf6GU0/yTTJa
bHrx+Rc/0cmS1RHN9zjZWco/831obneQ169TBKcYzw==
=nXsn
-----END PGP SIGNATURE-----

--------------TqpVRvHG9JxgX9GL0sRxBCyG--
