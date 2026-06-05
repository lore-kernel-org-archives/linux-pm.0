Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88714BC020
	for <linux-pm@vger.kernel.org>; Fri,  5 Jun 2026 09:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780650827; cv=none; b=K+tEit59mPW6y3pozR+WmEBOJSU5eSwDbziXhp1VtaEVhwt2PAuu0S/zq26CbdAhhgfLM0U8aDA5+JENwv8KFEIljjg13Lwz0G0frNeimgvsRja5SAbpZTpZMi46UDFXoYCiH6vzXZ/6ynqdicZneyluMzqfdTSkoxxc8Wi9FRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780650827; c=relaxed/simple;
	bh=nJkm/qohzyKgVwdvjSNXbLFtH3gLY88R0T5pEAJzFs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qQMR3E7+LWdz8lNt2x+l1rNAeMd6Iom9sdYVitpEEtJ9Gy6Qjl0cB9VAKdLdT8qQVTw5VbKwYo2s5UsJoLtUAboJr0zTZztm7iJv3O19ddY0v4+E1jV+v4J1KhVnkMvAmpBYv6DXBuOsNhdl4zrH2qaaFIYWX48q2CpmPSIthi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D/PCZ7j/; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D/PCZ7j/"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-beb1bee8c16so215444066b.0
        for <linux-pm@vger.kernel.org>; Fri, 05 Jun 2026 02:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780650824; x=1781255624; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nJkm/qohzyKgVwdvjSNXbLFtH3gLY88R0T5pEAJzFs0=;
        b=D/PCZ7j/XK+o1GUMy/S7o/jRIqkyq5k93qf/Rb04Iwg/ao9l6S6icGoSvl2C70DHuB
         py+OABVqa3z4uZtnpiRQYu+RNePhcLPZx95z/h/bbsbMsua/3LkeZ2oJ6ZVgz1608oOk
         GG5OHA2Z1k2LNGfH8alcofjQeCTS2SJeoTZzNSxaW6sCv1iGYDZMFE5whBmqeOeq2IsC
         y+dx68l6x/SJxBs0cxQEt2YnZZEDfN5OIdBnv9FnYap7WSw2IqquhuAzcjNf/Wu4d1lq
         MlPoa7zDklrezEDe6SQ+UA5IodxhXM+Rzcgs6aeWjXugF0blS1iHiNiJks6TVXPKnCya
         SM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780650824; x=1781255624;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nJkm/qohzyKgVwdvjSNXbLFtH3gLY88R0T5pEAJzFs0=;
        b=fPWy1KitOBWGBNbidrtx0l9WQRLP8qx9Um1DVDaKD2kvoaKA/C012kX83PZc0y79Ss
         QM1maobCxbAHUDS9cZkl0bsTdilHRGyEIxUwI4GB1VRzqMJylSFpQtXby/H8vDiL4VSR
         3bjtt/8MRFr7i+HUhAMP7oYFAQiNj3nIc8C2gwmTw1yKGbWGuOvZN8s3wnBlb6+2I4Dj
         /VR8cqIV/B4Qbon4sVFZBmwKVzZz2YKrsRtgUSusTcjBePoXJZLXI6yDBxV4/wy20aX1
         5n1tb6yPNENUyBlrkCpAdyfoK6UM3/Ew0ST7k+izGMhYf5PC2ioKjxT9yZunaYHE9AGl
         8BTg==
X-Forwarded-Encrypted: i=1; AFNElJ8VWUuNWkQvDQMuyI7LZIw+eId6ZDG6UxR6UYB9p+u39KoOtt4NoErtOe9kEGyIayD+ls5WP1tVPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHRExVajBRz/1BFai+oBImsfa0Te+wxQM8Y5FTSgkmwUa/zA0g
	S2aYle7GxOpgVtetXcXwNO7E5IEc5qfVJ8bpx24OyPotRe3EjflFP41s/QtZREyzNqg=
X-Gm-Gg: Acq92OHDOFqN6AjnrEIUrZL38KGR97Bbq2RciTCndS5tdRd5ll9gi9tR4YqHUVTyU+z
	DSGjLlzawtH0ytCYki3GNu6gweTw5MazE9Oh1Kq0lz+E2V0if3zRq+IjLTLyfAE7DE+WA8CykTk
	x3lq/bJUcSu0P4zBA2HiRQIkOK+bj16vLtPJuOkKrIdMVjUP6+RNUQx3w1Yh+4ADmxT2ej+SAJy
	hQX6rnuMgNRUqGM2b0BJAejZ+Pappc978cmGNk7aKq1xGE7JJK391sq0QjId2dGIfFnQ31a+UrH
	UlaDqe7nONjjFd8kRDWjjYa6N3dvaYmdCvUsaQWUXsGJ1YKji9M/216av15YjBe+3SVS0IR97sM
	UGx9Oa1QeT377qhZzS/gTH6fsH7wxhSPIA+C/KKHgwNKgMr1toWJ2iY6wiGYsmnn2QXg15NFjcH
	QdFO4FvS0ih3w6EUE36gUUocN2jREycH8TP08QyRqcwkW4qlo4fNdsd5krIAkvKUdU87FEkfBGp
	84H8A+Z33DZRx8Crb+MwEDjMPQXx8/U/QGxsS4vOQ7oR5PeuIFltDKuCZpVUNfB
X-Received: by 2002:a17:907:a4a:b0:bee:7c9b:fbd1 with SMTP id a640c23a62f3a-bf3a68ee6f6mr84450566b.1.1780650824273;
        Fri, 05 Jun 2026 02:13:44 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf0559f1f62sm435537866b.57.2026.06.05.02.13.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 02:13:43 -0700 (PDT)
Message-ID: <a477aefe-e1c8-4652-b263-86c4cce09eba@suse.com>
Date: Fri, 5 Jun 2026 11:13:42 +0200
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
 <aiKRbRHyDCjmqvGB@gmail.com>
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
In-Reply-To: <aiKRbRHyDCjmqvGB@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------42g0lK7RCjA0V5Hpk0wwPtog"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------42g0lK7RCjA0V5Hpk0wwPtog
Content-Type: multipart/mixed; boundary="------------W8k45yeHavmrtS79YNqNh771";
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
Message-ID: <a477aefe-e1c8-4652-b263-86c4cce09eba@suse.com>
Subject: Re: [PATCH 0/8] x86/msr: Drop 32-bit variants of *_on_cpu() MSR
 functions
References: <20260605070826.2995913-1-jgross@suse.com>
 <aiKRbRHyDCjmqvGB@gmail.com>
In-Reply-To: <aiKRbRHyDCjmqvGB@gmail.com>

--------------W8k45yeHavmrtS79YNqNh771
Content-Type: multipart/mixed; boundary="------------PLHK4mnGD0P23Fm2MyNO99EN"

--------------PLHK4mnGD0P23Fm2MyNO99EN
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDUuMDYuMjYgMTE6MDUsIEluZ28gTW9sbmFyIHdyb3RlOg0KPiANCj4gKiBKdWVyZ2Vu
IEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+IHdyb3RlOg0KPiANCj4+IERyb3AgdGhlIHZhcmlh
bnRzIHVzaW5nIDIgMzItYml0IHZhbHVlcyBpbnN0ZWFkIG9mIGEgc2luZ2xlIDY0LWJpdCBv
bmUNCj4+IG9mIHRoZSAqX29uX2NwdSgpIE1TUiBhY2Nlc3MgZnVuY3Rpb25zLg0KPj4NCj4+
IEp1ZXJnZW4gR3Jvc3MgKDgpOg0KPj4gICAgeDg2L21zcjogU3dpdGNoIHJkbXNyX29uX2Nw
dSgpIHRvIHJldHVybiBhIDY0LWJpdCBxdWFudGl0eQ0KPj4gICAgeDg2L21zcjogU3dpdGNo
IGFsbCBjYWxsZXJzIG9mIHJkbXNycV9vbl9jcHUoKSB0byB1c2UgcmRtc3Jfb25fY3B1KCkN
Cj4+ICAgIHg4Ni9tc3I6IFN3aXRjaCB3cm1zcl9vbl9jcHUoKSB0byB1c2UgYSA2NC1iaXQg
cXVhbnRpdHkNCj4+ICAgIHg4Ni9tc3I6IFN3aXRjaCBhbGwgY2FsbGVycyBvZiB3cm1zcnFf
b25fY3B1KCkgdG8gdXNlIHdybXNyX29uX2NwdSgpDQo+PiAgICB4ODYvbXNyOiBTd2l0Y2gg
cmRtc3Jfc2FmZV9vbl9jcHUoKSB0byByZXR1cm4gYSA2NC1iaXQgcXVhbnRpdHkNCj4+ICAg
IHg4Ni9tc3I6IFN3aXRjaCBhbGwgY2FsbGVycyBvZiByZG1zcnFfc2FmZV9vbl9jcHUoKSB0
byB1c2UgcmRtc3Jfc2FmZV9vbl9jcHUoKQ0KPj4gICAgeDg2L21zcjogU3dpdGNoIHdybXNy
X3NhZmVfb25fY3B1KCkgdG8gdXNlIGEgNjQtYml0IHF1YW50aXR5DQo+PiAgICB4ODYvbXNy
OiBTd2l0Y2ggYWxsIGNhbGxlcnMgb2Ygd3Jtc3JxX3NhZmVfb25fY3B1KCkgdG8gdXNlICB3
cm1zcl9zYWZlX29uX2NwdSgpDQo+IA0KPiBUbyBzdW0gdXAgbXkgcmV2aWV3IGZlZWRiYWNr
IGZvciB0aGUgaW52aWRpZHVhbCBwYXRjaGVzLCB3ZSB3YW50DQo+IHRvIGRvIHRoaXMgaW5z
dGVhZDoNCj4gDQo+ICAgIHg4Ni9tc3I6IENvbnZlcnQgcmRtc3JsX29uX2NwdSgpIHVzZXJz
IHRvIHJkbXNycV9vbl9jcHUoKQ0KPiAgICB4ODYvbXNyOiBEcm9wIHRoZSByZG1zcmxfb25f
Y3B1KCkgYWxpYXMgdG8gcmRtc3JxX29uX2NwdSgpDQo+IA0KPiAgICB4ODYvbXNyOiBTd2l0
Y2ggYWxsIGNhbGxlcnMgb2YgcmRtc3Jfb25fY3B1KCkgdG8gdXNlIHJkbXNycV9vbl9jcHUo
KQ0KPiAgICB4ODYvbXNyOiBSZW1vdmUgdGhlIHVudXNlZCByZG1zcl9vbl9jcHUoKSBBUEkN
Cj4gDQo+ICAgIHg4Ni9tc3I6IFN3aXRjaCBhbGwgY2FsbGVycyBvZiB3cm1zcl9vbl9jcHUo
KSB0byB1c2Ugd3Jtc3JxX29uX2NwdSgpDQo+ICAgIHg4Ni9tc3I6IFJlbW92ZSB1bnVzZWQg
d3Jtc3Jfb25fY3B1KCkgQVBJDQo+IA0KPiAgICB4ODYvbXNyOiBTd2l0Y2ggYWxsIGNhbGxl
cnMgb2YgcmRtc3Jfc2FmZV9vbl9jcHUoKSB0byB1c2UgcmRtc3JxX3NhZmVfb25fY3B1KCkN
Cj4gICAgeDg2L21zcjogUmVtb3ZlIHVudXNlZCByZG1zcl9zYWZlX29uX2NwdSgpIEFQSQ0K
PiANCj4gICAgeDg2L21zcjogU3dpdGNoIGFsbCBjYWxsZXJzIG9mIHdybXNyX3NhZmVfb25f
Y3B1KCkgdG8gdXNlIHdybXNycV9zYWZlX29uX2NwdSgpDQo+ICAgIHg4Ni9tcnM6IFJlbW92
ZSB1bnVzZWQgd3Jtc3JxX3NhZmVfb25fY3B1KCkgQVBJDQo+IA0KPiBOb3RlIGhvdyB0aGVy
ZSdzIG5vICJjb252ZXJzaW9uIiBvZiB0aGUgMzItYml0IEFQSSBpdHNlbGYgaW4gdGhpcw0K
PiBhcHByb2FjaCwgd2UganVzdCBkbyBhIHN0cmFpZ2h0Zm9yd2FyZCBtaWdyYXRpb24gb2Yg
dGhlIHVzZXJzIHRvDQo+IHRoZSBhbHJlYWR5IGV4aXN0aW5nIDY0LWJpdCBBUElzLCB0aGVu
IHJlbW92ZSBhbnkgdW51c2VkIEFQSXMuDQoNCkZpbmUgd2l0aCBtZSwgYnV0IEkganVzdCB3
YW50ZWQgdG8gZ2V0IHJpZCBvZiB0aGUgInEiIGFuZCAibCIgc3VmZmljZXMNCmNvbXBsZXRl
bHksIGFzIHRoZXkgc2VydmUgbm8gc3BlY2lhbCBwdXJwb3NlIGFmdGVyIGRyb3BwaW5nIGFs
bCBvdGhlcg0KdmFyaWFudHMuDQoNCk9UT0ggaWYgd2FudGVkIHN1Y2ggYSBzd2l0Y2ggY291
bGQgYmUgZG9uZSBsYXRlciBlYXNpbHkuDQoNCg0KSnVlcmdlbg0K
--------------PLHK4mnGD0P23Fm2MyNO99EN
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------PLHK4mnGD0P23Fm2MyNO99EN--

--------------W8k45yeHavmrtS79YNqNh771--

--------------42g0lK7RCjA0V5Hpk0wwPtog
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmoik0YFAwAAAAAACgkQsN6d1ii/Ey+V
wgf+NMO5uSXAzCwVh1HiRnL6y5gmgho87+zE3OFdKKZfXPKixPyfDzIns61vfrPUB6hQmhr3fvvb
QLaH79wLvjdkIKLt/NOBVCKzOw3hdFSwi3lsM1iOgQHLRlia4CuNXwizJh6+qBDKfKoDDPcS2hDt
DO/TV5MU+wo1pxcmJaTFNGIdcm6UX/00rV7/2QW4NzDekaW13wTJ7kysm9ZYBEaH2rmkVvdUQ/oO
f5SGzSgSO2I1u75qJZm/8HizWClX466fIh0mqZfQiptFciajPMj2/w+7gqIUCNNHbK01h+bzVBZI
I+kvvaHNq8H3Cb9jSH9KtCzwSDCuAaBmHsmpZWaIaA==
=zn+n
-----END PGP SIGNATURE-----

--------------42g0lK7RCjA0V5Hpk0wwPtog--
