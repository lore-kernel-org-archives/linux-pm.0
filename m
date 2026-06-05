Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514AE3CDBAA
	for <linux-pm@vger.kernel.org>; Fri,  5 Jun 2026 09:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780652416; cv=none; b=Ya0s9cPa7bsUEwNR+P5OvtNzfcJtJ2KsvhV3Vggs+yDazwslA8Msl7FOMoyzIONWAbuWghiJGRd788e/QRKpDedU+s2kurjHi2Qki8gErjjLWovQcFrylqCK0Shm38ynE2i5AYyssY/QM7b9s0E0KzhSOD74AmE6B7UJjx5DrEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780652416; c=relaxed/simple;
	bh=ItRwmOBbDzMYmI4NkgUNtmoVP0EsETxfLp36T5Slcck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bi2vzZZWOEukVn+PqQKYX0U4ozfO1PO24CibP/xm2jmMvogL2hTolU9OXUnO07fC/29XXULD5yogut/adIlRTZWVNJETocKlLMZFb4/GbLRfr02Lu8MSsGKeA4/yUd26tNiobcoZHkabRJ4I7D8btGJUvMNrx5cDYsKpvsCaFt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aUHbhYEc; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aUHbhYEc"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bef47b1ac01so270647666b.2
        for <linux-pm@vger.kernel.org>; Fri, 05 Jun 2026 02:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780652413; x=1781257213; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ItRwmOBbDzMYmI4NkgUNtmoVP0EsETxfLp36T5Slcck=;
        b=aUHbhYEcXYPBeGXHrduE0gonDtR1fn/asDBmUZcnsbcKYGPDTRRZoQl8tEK8v1lFvH
         n0yGmz2vOrFj9gDZRXe05HB9Uhw4PdOKASzvaehgiYXGpZmzeE/UuNXkY/2d5/lXANMu
         S11cAFXr7D8j/gTpHwzjurqikJeJDzCTAu8QaFncaUYD8IqYJvojRwUuEB6TV6Ey2Cok
         Zp3bbdv8TubKmqsUdaYTMlvaArGoRXBhW9CWfrjrX9Ih6lehIQC0jzdh9xZEX0wFB1eR
         iiah1qb0Ls5oJs017NExUBb+uG1rU3e9R846zjlc4TH87KKQsyzBBXMw4ttgJV8BoUdc
         wFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780652413; x=1781257213;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ItRwmOBbDzMYmI4NkgUNtmoVP0EsETxfLp36T5Slcck=;
        b=lF13KRYrbY2BWWyAiOM0MOkOMMHryT3uWnpsuAL4vpGaxLUS1UZVPv+zjE1XR+1ciE
         VHHBLksW9KducKoGirS59ExoeUuYfbE/g1eoCk8MWDY7SRZV+nLzpHGkO61zx69UpOjP
         11cL84vwHxRh9kAqTElyH+wa4g28bVQDvSyFfu7IA6NW1s05YgG/WW7D4uXWhYqqrTDm
         Z9KaHmZ4r+a+Jktc9uS1ywyHTpqHVT41Uz0cADSuCCaAwpeoyCIWBA3vX/PqDQ64BFCJ
         UEuF7o/9tywtDyivOr3N+lPUmn0KISa6+tsh+K7gBmryS0gArJYoZlEVVKYfAWk+Y2YC
         i0bw==
X-Forwarded-Encrypted: i=1; AFNElJ99o3hUdAKPhS0sfuhQb4wfHOxHw/6z6uoM3lzdHqwtm/Uq32gc8K2gdsGXN5btnDXsqH9iDeWMpg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEq/cWkBNlAl9uwnXBt6y0Yvft+RIw/GGcGyUFelOkk0V20DPV
	ufmXtBYrDbSqe/ORDqTDT8/Q/ZjFh1zLo8eO/I6ehUTpbIJbf0JlP2u/mEYEt7kJvFM=
X-Gm-Gg: Acq92OGyUjvvtPQdkx0eAAOl8dddZ28tkyqwi4CDIP2R2SM1vZN0yUuPS/oIMqY+hIv
	5rYl5MvlW7oVrXrmqTkbZ0Eqb7xvD/XQI4q64is1CKi/XBRd0/ig+T1/D/PwGmxgT0j9IfYNFOC
	UdPEPO6+uz6hxf0XftofnyWFbd6xB0osuRF/VypCoNzBz4V8XVTrSTBnM0TPXW7pYOOkLzL/xCN
	/jFe0AGJGyw0Ej/yQ2c+5qQsQFwAHmX/0McJ9940DJJar+8Dskfmp+lmrz7siQL4wCwHzmpDEzh
	t2T9QhhGYzHPIBnoTWKIzkV8dZeWwiSVkQ8o7NsAgvSb99PKYAelPZQ4KYYyBmELdVbOIFSImBO
	V8KPb5qH4BnMD4EULDlwVfvMb/ijEIOPvMPpAjXf1XuWEZ50RKr6em8lrbG0Kiecp7y3L/W00la
	eu8FHZj1ksVXpbvcSoOvMszwi7zlZeG/Ke46yC00WZTNzw4FfRJhJRtwUnRrM33unDFMBPYCPJX
	o0sv0GpK53zcwg4+85X7odXs6TxKn7G21oFgPUHTUCI7nvQOetBPfFxiRngAdLJ
X-Received: by 2002:a17:907:75c2:b0:beb:9be6:f249 with SMTP id a640c23a62f3a-bf3737ea2fdmr91884766b.47.1780652412676;
        Fri, 05 Jun 2026 02:40:12 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054e051a5sm435919266b.35.2026.06.05.02.40.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 02:40:12 -0700 (PDT)
Message-ID: <b7e799a6-1f1a-49ef-8aac-0d5fd4a06dc7@suse.com>
Date: Fri, 5 Jun 2026 11:40:11 +0200
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
 <aiKUenaT9VD0DrpW@gmail.com>
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
In-Reply-To: <aiKUenaT9VD0DrpW@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------x6p6seQKjoqBU6SQR0OrjR4R"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------x6p6seQKjoqBU6SQR0OrjR4R
Content-Type: multipart/mixed; boundary="------------bYFZE3YlcnS98YrDup00fJv4";
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
Message-ID: <b7e799a6-1f1a-49ef-8aac-0d5fd4a06dc7@suse.com>
Subject: Re: [PATCH 0/8] x86/msr: Drop 32-bit variants of *_on_cpu() MSR
 functions
References: <20260605070826.2995913-1-jgross@suse.com>
 <aiKRbRHyDCjmqvGB@gmail.com> <a477aefe-e1c8-4652-b263-86c4cce09eba@suse.com>
 <aiKUenaT9VD0DrpW@gmail.com>
In-Reply-To: <aiKUenaT9VD0DrpW@gmail.com>

--------------bYFZE3YlcnS98YrDup00fJv4
Content-Type: multipart/mixed; boundary="------------NsR79dww0BmUQFjwgnbL7v4l"

--------------NsR79dww0BmUQFjwgnbL7v4l
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDUuMDYuMjYgMTE6MTgsIEluZ28gTW9sbmFyIHdyb3RlOg0KPiANCj4gKiBKw7xyZ2Vu
IEdyb8OfIDxqZ3Jvc3NAc3VzZS5jb20+IHdyb3RlOg0KPiANCj4+IE9uIDA1LjA2LjI2IDEx
OjA1LCBJbmdvIE1vbG5hciB3cm90ZToNCj4+Pg0KPj4+ICogSnVlcmdlbiBHcm9zcyA8amdy
b3NzQHN1c2UuY29tPiB3cm90ZToNCj4+Pg0KPj4+PiBEcm9wIHRoZSB2YXJpYW50cyB1c2lu
ZyAyIDMyLWJpdCB2YWx1ZXMgaW5zdGVhZCBvZiBhIHNpbmdsZSA2NC1iaXQgb25lDQo+Pj4+
IG9mIHRoZSAqX29uX2NwdSgpIE1TUiBhY2Nlc3MgZnVuY3Rpb25zLg0KPj4+Pg0KPj4+PiBK
dWVyZ2VuIEdyb3NzICg4KToNCj4+Pj4gICAgIHg4Ni9tc3I6IFN3aXRjaCByZG1zcl9vbl9j
cHUoKSB0byByZXR1cm4gYSA2NC1iaXQgcXVhbnRpdHkNCj4+Pj4gICAgIHg4Ni9tc3I6IFN3
aXRjaCBhbGwgY2FsbGVycyBvZiByZG1zcnFfb25fY3B1KCkgdG8gdXNlIHJkbXNyX29uX2Nw
dSgpDQo+Pj4+ICAgICB4ODYvbXNyOiBTd2l0Y2ggd3Jtc3Jfb25fY3B1KCkgdG8gdXNlIGEg
NjQtYml0IHF1YW50aXR5DQo+Pj4+ICAgICB4ODYvbXNyOiBTd2l0Y2ggYWxsIGNhbGxlcnMg
b2Ygd3Jtc3JxX29uX2NwdSgpIHRvIHVzZSB3cm1zcl9vbl9jcHUoKQ0KPj4+PiAgICAgeDg2
L21zcjogU3dpdGNoIHJkbXNyX3NhZmVfb25fY3B1KCkgdG8gcmV0dXJuIGEgNjQtYml0IHF1
YW50aXR5DQo+Pj4+ICAgICB4ODYvbXNyOiBTd2l0Y2ggYWxsIGNhbGxlcnMgb2YgcmRtc3Jx
X3NhZmVfb25fY3B1KCkgdG8gdXNlIHJkbXNyX3NhZmVfb25fY3B1KCkNCj4+Pj4gICAgIHg4
Ni9tc3I6IFN3aXRjaCB3cm1zcl9zYWZlX29uX2NwdSgpIHRvIHVzZSBhIDY0LWJpdCBxdWFu
dGl0eQ0KPj4+PiAgICAgeDg2L21zcjogU3dpdGNoIGFsbCBjYWxsZXJzIG9mIHdybXNycV9z
YWZlX29uX2NwdSgpIHRvIHVzZSAgd3Jtc3Jfc2FmZV9vbl9jcHUoKQ0KPj4+DQo+Pj4gVG8g
c3VtIHVwIG15IHJldmlldyBmZWVkYmFjayBmb3IgdGhlIGludmlkaWR1YWwgcGF0Y2hlcywg
d2Ugd2FudA0KPj4+IHRvIGRvIHRoaXMgaW5zdGVhZDoNCj4+Pg0KPj4+ICAgICB4ODYvbXNy
OiBDb252ZXJ0IHJkbXNybF9vbl9jcHUoKSB1c2VycyB0byByZG1zcnFfb25fY3B1KCkNCj4+
PiAgICAgeDg2L21zcjogRHJvcCB0aGUgcmRtc3JsX29uX2NwdSgpIGFsaWFzIHRvIHJkbXNy
cV9vbl9jcHUoKQ0KPj4+DQo+Pj4gICAgIHg4Ni9tc3I6IFN3aXRjaCBhbGwgY2FsbGVycyBv
ZiByZG1zcl9vbl9jcHUoKSB0byB1c2UgcmRtc3JxX29uX2NwdSgpDQo+Pj4gICAgIHg4Ni9t
c3I6IFJlbW92ZSB0aGUgdW51c2VkIHJkbXNyX29uX2NwdSgpIEFQSQ0KPj4+DQo+Pj4gICAg
IHg4Ni9tc3I6IFN3aXRjaCBhbGwgY2FsbGVycyBvZiB3cm1zcl9vbl9jcHUoKSB0byB1c2Ug
d3Jtc3JxX29uX2NwdSgpDQo+Pj4gICAgIHg4Ni9tc3I6IFJlbW92ZSB1bnVzZWQgd3Jtc3Jf
b25fY3B1KCkgQVBJDQo+Pj4NCj4+PiAgICAgeDg2L21zcjogU3dpdGNoIGFsbCBjYWxsZXJz
IG9mIHJkbXNyX3NhZmVfb25fY3B1KCkgdG8gdXNlIHJkbXNycV9zYWZlX29uX2NwdSgpDQo+
Pj4gICAgIHg4Ni9tc3I6IFJlbW92ZSB1bnVzZWQgcmRtc3Jfc2FmZV9vbl9jcHUoKSBBUEkN
Cj4+Pg0KPj4+ICAgICB4ODYvbXNyOiBTd2l0Y2ggYWxsIGNhbGxlcnMgb2Ygd3Jtc3Jfc2Fm
ZV9vbl9jcHUoKSB0byB1c2Ugd3Jtc3JxX3NhZmVfb25fY3B1KCkNCj4+PiAgICAgeDg2L21y
czogUmVtb3ZlIHVudXNlZCB3cm1zcnFfc2FmZV9vbl9jcHUoKSBBUEkNCj4+Pg0KPj4+IE5v
dGUgaG93IHRoZXJlJ3Mgbm8gImNvbnZlcnNpb24iIG9mIHRoZSAzMi1iaXQgQVBJIGl0c2Vs
ZiBpbiB0aGlzDQo+Pj4gYXBwcm9hY2gsIHdlIGp1c3QgZG8gYSBzdHJhaWdodGZvcndhcmQg
bWlncmF0aW9uIG9mIHRoZSB1c2VycyB0bw0KPj4+IHRoZSBhbHJlYWR5IGV4aXN0aW5nIDY0
LWJpdCBBUElzLCB0aGVuIHJlbW92ZSBhbnkgdW51c2VkIEFQSXMuDQo+Pg0KPj4gRmluZSB3
aXRoIG1lLCBidXQgSSBqdXN0IHdhbnRlZCB0byBnZXQgcmlkIG9mIHRoZSAicSIgYW5kICJs
IiBzdWZmaWNlcw0KPj4gY29tcGxldGVseSwgYXMgdGhleSBzZXJ2ZSBubyBzcGVjaWFsIHB1
cnBvc2UgYWZ0ZXIgZHJvcHBpbmcgYWxsIG90aGVyDQo+PiB2YXJpYW50cy4NCj4+DQo+PiBP
VE9IIGlmIHdhbnRlZCBzdWNoIGEgc3dpdGNoIGNvdWxkIGJlIGRvbmUgbGF0ZXIgZWFzaWx5
Lg0KPiANCj4gV2VsbCwgd2UgaGFkIGEgc2ltaWxhciBkaXNjdXNzaW9uIGJhY2sgd2hlbiB3
ZSBzdGFuZGFyZGl6ZWQgb24NCj4gcmRtc3JxKCkgYW5kIHdybXNycSgpLCBhbmQgd2UgdXNl
IHRoZW0gYXMgb3VyIHByaW1hcnkgNjQtYml0DQo+IE1TUiBoYW5kbGluZyBBUElzLiBXaHkg
aGF2ZSBhIGRpZmZlcmVudCBwYXR0ZXJuIGluIGFueSBvZiB0aGUNCj4gZGVyaXZlZCBBUElz
PyBJdCBzaG91bGQgcmVhbGx5IHVzZSB0aGUgc2FtZSBjb25jZXB0dWFsIG5hbWVzcGFjZSwN
Cj4gbm90IHNvbWUgY29uZnVzaW5nIG1peHR1cmUgb2YgdHdvIG5hbWluZyBzY2hlbWVzLg0K
DQpJbiB0aGUgbG9uZyBydW4gSSdkIGxpa2UgdG8gZG8gdGhlIHNhbWUgY29udmVyc2lvbiBm
b3IgdGhlIHJkbXNyKigpIGFuZA0Kd3Jtc3IqKCkgaW50ZXJmYWNlcywgdG9vIChzbyBvbmx5
IG9mZmVyaW5nIGFuZCB1c2luZyB0aGUgNjQtYml0IHZhcmlhbnRzKS4NCg0KSSB1bmRlcnN0
YW5kIHRoYXQgdGhpcyBpcyBub3QgZ3VhcmFudGVlZCB0byBiZSBhY2NlcHRlZCBpbW1lZGlh
dGVseSBhZnRlcg0KdGhpcyBzZXJpZXMsIHNvIEkgYWdyZWUgdGhhdCBpdCBpcyBiZXR0ZXIg
dG8ga2VlcCB0aGUgInEiIHN1ZmZpeCBmb3Igbm93DQppbiBvcmRlciB0byBhdm9pZCBjb25m
dXNpb24uDQoNCg0KSnVlcmdlbg0K
--------------NsR79dww0BmUQFjwgnbL7v4l
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------NsR79dww0BmUQFjwgnbL7v4l--

--------------bYFZE3YlcnS98YrDup00fJv4--

--------------x6p6seQKjoqBU6SQR0OrjR4R
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmoimXsFAwAAAAAACgkQsN6d1ii/Ey8q
+Af/YUy+d34/AkCArj1a1s0qvo5bgUdP9PHx6B1UuRLTg3lvsrCujYmk9eAsEKiinBfFZDKFbAr2
6VXRBDCZhzQ3Mv1hGx2oYC+KyF53UXV/Nd8GCqZPiF/o3u1LH3YmG8lTPU7ykrpYkI5H1tnj29AR
exkWbY4IgGSmuBvD3IVKmq3DqzlsoB+fDDPFDrd3ZKcsrXIPdT0Z89SNsYeiiYsAFzG03NsAvBcN
YvzPazP56H+4cTagb525vz2TWwDinDNGdG7CJuMDkv5XApnbWLIvbUlZLFYuoIt1/H6E1mRQy0yD
czzOXtvoNOEtnhkYYBTXlXl/3ibEdUfub9yKycR2uA==
=dWgo
-----END PGP SIGNATURE-----

--------------x6p6seQKjoqBU6SQR0OrjR4R--
