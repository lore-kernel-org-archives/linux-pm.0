Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05BA3EAC84
	for <linux-pm@vger.kernel.org>; Fri,  5 Jun 2026 10:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780653980; cv=none; b=IJeqrX/W1to09DCaea583NFUfQOa24q/drCWQhrYdeSpvaYHAqhzAmvc9rQFv4KoQNDeKxOL2lB9ahlENfo1ZStFs3gqztcA9tW3jpkFmU9cmZFAdo3sD4L2O3c0WFMAs0LUnPwl8UMWfbqZBYQqBAXwxck+5Q5nt5+MJxAd4+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780653980; c=relaxed/simple;
	bh=qTiAQ6siT2nw2yuHuoMwBQYbTV0+f9txKpRw6bPdfKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MdYKL4znK2XLNWXQOAUiSwudbQTygRtRonsvbK6ouAOP27/kItU9m64Myqps4Aov4Zhu4HsMVyrYZ/hl2qJvRhYHQdhlR+cCOEiXTr7P0Q4nOLUOm6JQ95a4QKZG9/vytcpiKYcCBWLXnNbAWB/4nPi4BZMboQaRtOp/oN6BusY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fR6FE2Cf; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fR6FE2Cf"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-beeba001887so227587766b.3
        for <linux-pm@vger.kernel.org>; Fri, 05 Jun 2026 03:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780653977; x=1781258777; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qTiAQ6siT2nw2yuHuoMwBQYbTV0+f9txKpRw6bPdfKU=;
        b=fR6FE2Cfdixw/cW1NXvW8HMg313lwUBRirSPZhby2BTf/U70cR0eztLhxt2818tK5+
         b+HOKSZmA9JRqKuiUShZ2O/fbEW8FcXAfgzKNO+jXNjav+ueskPN/RRu60v5YbfJ6Vc+
         r8kWrT4TNbd/Ii2za/yrr3OGEGcLXxIhXfB3qEQTJAZGWBq1WYDha8RYjhZw7JHtQAY/
         aB2AJOI5RWBkvX1Q9onAhuYRQNiPBd/y05fFGBwoumHs91cXWXHXSHtLLa/fRQ894iAI
         NzCOZ8N+fqkFfydU83hQTZoo+zcJo2b208dgt0ITbt9yoHdzSZt74SKeTRPG0Rg8/D2S
         VBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780653977; x=1781258777;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qTiAQ6siT2nw2yuHuoMwBQYbTV0+f9txKpRw6bPdfKU=;
        b=aBqiFnRkHe+TvwzJZ9zng0z3RCEzlpvxuHemA+P2Gr04zOltg2+5ojWDqfkfrlnajT
         gyL86q+gqpbgCazLh78UAWZoTqV25uzBv8cNX0zgU2sFfZqnIjfj/hOvRJakgubAfZ1n
         nLmCsH9xtErUZv5m8+eQ8GyivSyZR+aajtFB++LfBfCQcUTZ//fLXV20Run6hT24LzmI
         8I9DyO32/VfA4gdnlyWDRp8EPZY8cvppipAQS02XUThsacVgMjCQinZH6uulzJQPafvr
         76itOmIf/omwmRQSpi+UQygx5yTtmi/ESXryhI0LvzlWwu1GfO/ngXDpdkvrbR9NJF52
         AcKQ==
X-Forwarded-Encrypted: i=1; AFNElJ/MsjmzBrQrqU6fk0fmruLFIPlQwLoMI7B1AfKXAdqNiH9XBitmWa2y27W2NXy1EmKpMmE6lVjmVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEqD46bgYEQUA6+KTPqBwEnxRaFuvAx+LZUctTD7ftN/VrN+HP
	XymgScX70hHoq7ECniweJqjKhtDLHZfIBs/wwHqZAaaFW4t9nhP1Sg+g0fCncm3Xp/I=
X-Gm-Gg: Acq92OEmMu0uTrosdIm94a7sVkA24pBv0zwoJgYR3QqHKDvKQ1EIKhX/gMydoSQ4Wbk
	zaH4YBkCpiuAI4krw5RvoDT6JWHEH4rlg81Xutf0Fyqp+Dhy/Q4U2XckfKFpFjAloXKgqDN5ATx
	qWwPOnCflvve2uh9PJ8u+bluKaqE4Md8pCzrHDNEpNNPut008126sKr7u4QdQ5LrePQNNaNqxWX
	d/mmUrb77zEYfoG6z+/UtO1Dl4njEabqUuCifkkT1RBbUqVHhWU9Y5Ds3BqgmDkpjFYxtVp40tB
	FQMgySqUaEIeCiY8bvlu8jPFb3XRdoEMrm2HeiaTv9DtISVD4i+C2gNFClWp1E3O9V4pKvThg5h
	4lb/HaqcFzxqTEG/XhOLmg/Z3D5NhsRtgHvXuxc+FwUaIUAO8CN7Y0ace5haSgsJnZZnX9fKoS1
	KgauTos5Spb06c80yi1+KPaKxxPUC3r4b6Ty8K4sca6M7JV+YiJDujXtiqYGki1nugaS3wSQw3u
	zguBP5oV4lwZ09kEeREoDmCU0ow4YfCo4sK6EDJo46ON0CbRfXCHrkwJyJtBaCw
X-Received: by 2002:a17:907:6b89:b0:bec:fa92:d36c with SMTP id a640c23a62f3a-bf3743e7469mr134908366b.38.1780653977104;
        Fri, 05 Jun 2026 03:06:17 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e65b4d988sm3565186a12.25.2026.06.05.03.05.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 03:05:56 -0700 (PDT)
Message-ID: <e05f38fe-5036-4903-a300-46034667219a@suse.com>
Date: Fri, 5 Jun 2026 12:05:36 +0200
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
 boundary="------------Qk8Lm3E1Hf8i8sdNNQF5rJW1"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Qk8Lm3E1Hf8i8sdNNQF5rJW1
Content-Type: multipart/mixed; boundary="------------rzGgLeWTNEEF5YKShXVQ0nwJ";
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
Message-ID: <e05f38fe-5036-4903-a300-46034667219a@suse.com>
Subject: Re: [PATCH 0/8] x86/msr: Drop 32-bit variants of *_on_cpu() MSR
 functions
References: <20260605070826.2995913-1-jgross@suse.com>
 <aiKRbRHyDCjmqvGB@gmail.com> <a477aefe-e1c8-4652-b263-86c4cce09eba@suse.com>
 <aiKUenaT9VD0DrpW@gmail.com> <b7e799a6-1f1a-49ef-8aac-0d5fd4a06dc7@suse.com>
 <aiKcz6I8GO-TG8uq@gmail.com> <aiKdSPS-YT6KZV81@gmail.com>
In-Reply-To: <aiKdSPS-YT6KZV81@gmail.com>

--------------rzGgLeWTNEEF5YKShXVQ0nwJ
Content-Type: multipart/mixed; boundary="------------zDWtiRGxoRdRnXMWMA3xPdAU"

--------------zDWtiRGxoRdRnXMWMA3xPdAU
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
--------------zDWtiRGxoRdRnXMWMA3xPdAU
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------zDWtiRGxoRdRnXMWMA3xPdAU--

--------------rzGgLeWTNEEF5YKShXVQ0nwJ--

--------------Qk8Lm3E1Hf8i8sdNNQF5rJW1
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmoin3AFAwAAAAAACgkQsN6d1ii/Ey9v
sAgAgwluRWpWjA5Tv+f+PONpRX5XXZADkjYSjij3QmojCWYeaWk0J4Ll9t7ewRnFzEWxMHpX0juI
L5kW7CrJYhL444oA2CL15BgQ33DK0UVCKZdK8SwsYdEbfOyO+CJi/Nk6zAe0O1MNSZ9+9D6e0Yu6
vskutCJIs84xZwt83UwbIzCijHSy4hBURrvuo/kFzXkUeSZFaStgdxZQE5S5GjEn5xFiSBIpUAFq
M23Cnx1k3qEkEpnOHIEnu290glV7p0JdTT15Wg6MYa1RfySFASQaIhzcCChrPhyGLxFOBIYo3h6J
HbgBmCIzppCeGj5/rFEAEZv9a/coqGSSBrefcm3Iew==
=dtR0
-----END PGP SIGNATURE-----

--------------Qk8Lm3E1Hf8i8sdNNQF5rJW1--
