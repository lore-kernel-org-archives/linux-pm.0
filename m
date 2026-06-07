Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447FC4071FE
	for <linux-pm@vger.kernel.org>; Sun,  7 Jun 2026 06:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780814914; cv=none; b=MU1tyImgqPXKbejcxfy8VVDgfqMc3/M5qW5iKphy5pDm8mw2cLefaIqqNVVbjKWrXjo+nUgpomudREDy3PMVeC0gcU1FDcZQ81FIMWR391RPKbBPezw3Ov5+9+4V47kq/lqWZn2jhMnCyFLmWX7OZIqLIm6ChC+xat5r/zaEwHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780814914; c=relaxed/simple;
	bh=ZDChcHbqZEWHStEAhW9wiXGsMbsM/2Lz8H5wlv3Kdl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=liC1xXZYPmuawW77ORFXi4f5qiMV38YZCMUnlfBAapJ2U1pLaO68381SasYH0xLayvY7eQ1VtgQVMm8ARH07ypfo4Mw6xqn0a6csUmRBuSq9cXi8dElmNMw+5x+5G6xe/6PN1Yf2ofo5lpC92YRaT4Gq1rlnqdH26NF9TJ7LnTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Jjskwt/i; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Jjskwt/i"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bebbc325000so379513666b.0
        for <linux-pm@vger.kernel.org>; Sat, 06 Jun 2026 23:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780814912; x=1781419712; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZDChcHbqZEWHStEAhW9wiXGsMbsM/2Lz8H5wlv3Kdl4=;
        b=Jjskwt/i74Ko/ffDa4F+18CzmC+nGLb02pN9TGDN4LMPEB3dknc7+nJc8d9U86k+Sz
         B+HPGnEdkNOR+Iph9VeL6I9+IMdvo92iACUr72Z9pNu0JMDGK9sWlMrYTcgUwZ20F8e1
         EG3/cnIwHaijeBibeDi5eWwa3dR+vK79A4Yf7D8WKVlGSz44MhreRMGnEX7/R7rkq8A8
         b3t7aeBgZ6gkrws2/v6kVNMQVbrYgxUIFOgzgregfMoNNEnfNnQDkXEQNGteCHYQDl/z
         YbxRXlnIV5tkPnaDrkzQWIJlYjDTit2vjQi8GIPq00jc/bg1wvEWplmkUih7tviVNJGv
         7kfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780814912; x=1781419712;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDChcHbqZEWHStEAhW9wiXGsMbsM/2Lz8H5wlv3Kdl4=;
        b=dGOHAIuCnHm55wwYYb9sqBo2aobW/LOT/pfXu802tWzhuU2YPy2qixJyiixp/XOmN9
         6jss75NRKc+gV+kvqPzgbt/TmJG4mujjTmFLFJDpxn8yNePapmM7soxnT6U/6QHVGP0n
         VSDasc+Klm8nuFi+uGptFD+dpKEBuiR6TDO5BPp7B1QzpeA7gQabU0n22Z/CRRE1x0re
         7PH7XqIuzKqpcWQQpiswEF89W67nxzFmdd0Vw4zhUE4wTlJWstHP5CpXD2zWlWextYtZ
         tqnhecJ0V61o338JXJ8rMO5xPAKjhJCn/+dC9fgxwd//1uS6F4CO7MyLCyH+zLiYv8r6
         9tiQ==
X-Forwarded-Encrypted: i=1; AFNElJ9sIqpY7P4OyJtNeIN3OHpDLcfceFmqlrfWtkEKBmZA+O4rMr/v91fPwH/Jgrg+Q8M9fo0tRh07tA==@vger.kernel.org
X-Gm-Message-State: AOJu0YweQtaJ5VpTou0HVkhwbwZ5agIliUXSAeZj/btUvwuzqPK+IQgC
	jxc4fiogw5Zqj8ODqxu9xTxs1CYznMdu+Z/is+CEtww2rG/fNvbi+T93nN9gbWLPSQk=
X-Gm-Gg: Acq92OFuhN8fHdAnwpCve0ThP+5ZOtmSDLSdEytCPaCdsSIiCLVUHQ/3Oaem8yktuOl
	zjOk0tXRI9IWD8ODGtCp25byw82D8quRDeegq6+lQ7mEDSyFdiTwI3FUJc2ibhOf36P3DuYhgeH
	GKJcjV/N+Ox/AokDZ2UUvxfPQFOgQzHjAzuk523wE59/Or3Gqpfb8AgDbc+kfEtE3X/X0rsiURO
	DP60v4I3bVoeNoqTQGNul+qHWEwlgOeZVARwhaiDHfWEmAd1zx5KzNbpHo3BQsnYXVd74/Y0Ale
	lAUswsHFQYKuH7ngEzi79KdASL0WRQ1oITY/4hIodgdke/rXZkIVoUgx47JM3jglaseYOJYSQN3
	wKFAn43yIpak73fZUy6tqdusyM1r+1BGitqZMZk7phIYLpuxzV/BNo+z/Gd9ywSC2WgE+ayHU7k
	5iNX8akIRNXR8FU3A7f4BUULm0c5DjKQyZb0BR9xqZeBcwPaR3ehDgOSLOCJJzmWAtl5WVXwnzf
	1llrZDDleZELm8bp2SE8mD9FxIhMHnd33z7Gohh3/eCdrAnuaqoHvFv3oyWvhfv
X-Received: by 2002:a17:907:741:b0:bf0:b39:dcc8 with SMTP id a640c23a62f3a-bf3738f356emr544388866b.26.1780814911662;
        Sat, 06 Jun 2026 23:48:31 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054e06dddsm691114766b.36.2026.06.06.23.48.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jun 2026 23:48:31 -0700 (PDT)
Message-ID: <f8d02c78-4681-4043-a5fa-921fa790b1b4@suse.com>
Date: Sun, 7 Jun 2026 08:48:30 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/10] x86/msr: Switch rdmsr_safe_on_cpu() users to
 rdmsrq_safe_on_cpu()
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-hwmon@vger.kernel.org, linux-pm@vger.kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Guenter Roeck
 <linux@roeck-us.net>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>
References: <20260605144314.3031049-1-jgross@suse.com>
 <20260605144314.3031049-8-jgross@suse.com> <aiPtnrkdHDHc0Iqz@gmail.com>
 <2db3e888-a675-474a-9d1a-bb9d9bb162bd@suse.com> <aiUTpBrQSQIDIS8c@gmail.com>
Content-Language: en-US
From: Juergen Gross <jgross@suse.com>
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
In-Reply-To: <aiUTpBrQSQIDIS8c@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------5L0GDztaCMgjeXBRHVy3bVZp"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------5L0GDztaCMgjeXBRHVy3bVZp
Content-Type: multipart/mixed; boundary="------------eMtxraMeazBJCVDuP3HYlMAw";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-hwmon@vger.kernel.org, linux-pm@vger.kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Guenter Roeck
 <linux@roeck-us.net>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <f8d02c78-4681-4043-a5fa-921fa790b1b4@suse.com>
Subject: Re: [PATCH v2 07/10] x86/msr: Switch rdmsr_safe_on_cpu() users to
 rdmsrq_safe_on_cpu()
References: <20260605144314.3031049-1-jgross@suse.com>
 <20260605144314.3031049-8-jgross@suse.com> <aiPtnrkdHDHc0Iqz@gmail.com>
 <2db3e888-a675-474a-9d1a-bb9d9bb162bd@suse.com> <aiUTpBrQSQIDIS8c@gmail.com>
In-Reply-To: <aiUTpBrQSQIDIS8c@gmail.com>

--------------eMtxraMeazBJCVDuP3HYlMAw
Content-Type: multipart/mixed; boundary="------------SXP0Ju4z89jZvkWA7snzGPH4"

--------------SXP0Ju4z89jZvkWA7snzGPH4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDcuMDYuMjYgMDg6NDUsIEluZ28gTW9sbmFyIHdyb3RlOg0KPiANCj4gKiBKw7xyZ2Vu
IEdyb8OfIDxqZ3Jvc3NAc3VzZS5jb20+IHdyb3RlOg0KPiANCj4+IE9rYXksIGZpbmUgd2l0
aCBtZS4NCj4+DQo+PiBJJ2xsIHNlbmQgVjMgYWZ0ZXIgcmMxIG9mIDcuMiBhcyBEYXZlIHN1
Z2dlc3RlZC4NCj4gDQo+IFNpbmNlIHRoZXNlIGFyZSByZWFsbHkgdHJpdmlhbCB3aXRoIGxp
dHRsZSB2YWx1ZSBpbiBwb3N0cG9uaW5nDQo+IHRoZW0gb3ZlciBhIGZ1bGwgY3ljbGUgYW5k
IGdlbmVyYXRpbmcgY29uZmxpY3RzLCBhIC1yYzcgYmFzZQ0KPiBtaWdodCB3b3JrIGFzIHdl
bGwsIGFzIGxvbmcgYXMgeW91IHNlbmQgdGhlbSBpbiB0aGUgbmV4dCAxLTIgZGF5cw0KPiBv
ciBzby4gKFVubGVzcyBEYXZlIGZlZWxzIHN0cm9uZ2x5IGFib3V0IHRoZSB0aW1pbmcuKQ0K
PiANCj4+IE9uZSBmaW5hbCBxdWVzdGlvbiAobm90IGRpcmVjdGx5IGZvciB0aGlzIHNlcmll
cywgYnV0IGZvciBhIGZ1dHVyZSBvbmUpOg0KPj4NCj4+IEknZCBsaWtlIHRvIHN3aXRjaCBy
ZG1zcnEoKSBmcm9tIGEgbWFjcm8gdG8gYW4gaW5saW5lIGZ1bmN0aW9uLCBhcyBhIG1hY3Jv
DQo+PiB1c2luZyBvbmUgb2YgaXRzIHBhcmFtZXRlcnMgYXMgdGhlIGRlc3RpbmF0aW9uIGZv
ciBhbiBhc3NpZ25tZW50IGlzbid0DQo+PiBuaWNlLg0KPiANCj4gU28gYmFzaWNhbGx5Og0K
PiANCj4gICAgLSByZG1zcnEoTVNSX0NPUkVfUEVSRl9HTE9CQUxfQ1RSTCwgY3RybCk7DQo+
ICAgICsgY3RybCA9IHJkbXNycShNU1JfQ09SRV9QRVJGX0dMT0JBTF9DVFJMKTsNCj4gDQo+
ID8gQWdyZWVkIHdpdGggdGhhdC4NCj4gDQo+PiBBZGRpdGlvbmFsbHkgSSdkIGxpa2UgdG8g
cmVwbGFjZSByZG1zciooKSB1c2UgY2FzZXMgd2l0aCByZG1zcnEqKCkNCj4+IGFuZCB3cm1z
ciooKSB3aXRoIHdybXNycSooKSAoc2ltaWxhciB0byB0aGUgcmVwbGFjZW1lbnRzIGRvbmUg
aXMgdGhpcw0KPj4gc2VyaWVzKS4NCj4gDQo+IFllYWguDQo+IA0KPj4gVGhlIHJkbXNycSgp
IHRyYW5zZm9ybWF0aW9uIGludG8gYSBmdW5jdGlvbiBjYW4gZWFzaWx5IGJlIGRvbmUgdmlh
IGENCj4+IGNvY2NpbmVsbGUgc2NyaXB0LiBXaGF0IHdvdWxkIGJlIHlvdXIgY2hvaWNlIHJl
Z2FyZGluZyB0aGUgc2VxdWVuY2UgZG9pbmcNCj4+IHRoaXM/DQo+Pg0KPj4gYSkgU3RhcnQg
d2l0aCByZG1zcnEoKSB0cmFuc2Zvcm1hdGlvbiBpbnRvIGEgZnVuY3Rpb24uDQo+PiBiKSBG
aXJzdCBkbyB0aGUgcmRtc3Ivd3Jtc3IgLT4gcmRtc3JxL3dybXNycSByZXBsYWNlbWVudHMs
IHRoZW4gZG8gdGhlDQo+PiAgICAgcmRtc3JxKCkgdHJhbnNmb3JtYXRpb24gaW50byBhIGZ1
bmN0aW9uICh0aGlzIHdpbGwgdG91Y2ggbW9yZSBjb2RlLCBhcw0KPj4gICAgIHRoZSBpbml0
aWFsIHJkbXNyKCkgdXNlIGNhc2VzIHdpbGwgYmUgYWZmZWN0ZWQsIHRvbykuDQo+PiBjKSBM
ZWF2ZSByZG1zcnEoKSBhcyBhIG1hY3JvLg0KPiANCj4gSSdkIHByZWZlciAoYiksIGJlY2F1
c2Ugd2hpbGUgaXQncyB0ZWNobmljYWxseSBhIGJpdCBtb3JlIHdvcmssDQo+IHRoZSBmbG93
IGlzIGVhc2llciB0byByZXZpZXc6IHRoZSByZG1zci93cm1zciByZXBsYWNlbWVudHMNCj4g
YmFzaWNhbGx5IGRvIGE6DQo+IA0KPiAgICBtYWNybyh1MzIsIHUzMikgPT4+IG1hY3JvKHU2
NCkNCj4gDQo+IHJlcGxhY2VtZW50LCB3aGlsZSB3aXRoIChhKSB3ZSBkbyBhOg0KPiANCj4g
ICAgbWFjcm8odTMyLCB1MzIpID0+IHU2NCA9IGZ1bmN0aW9uKCkNCj4gDQo+IHJlcGxhY2Vt
ZW50IHRoYXQgaXMgYSBiaXQgbW9yZSBjb21wbGV4IHRyYW5zZm9ybWF0aW9uIGFuZCBiaXQN
Cj4gaGFyZGVyIHRvIHJldmlldy92YWxpZGF0ZSBhdCBhIGdsYW5jZS4gU28gSSB0aGluayBp
dCdzIGJldHRlcg0KPiB0byBkbyB0aGUgdHdvIHRyYW5zZm9ybWF0aW9ucyBzZXBhcmF0ZWx5
Lg0KDQpPa2F5LCB0aGFua3MuIFdpbGwgdXNlIHRoaXMgYXBwcm9hY2guDQoNCg0KSnVlcmdl
bg0K
--------------SXP0Ju4z89jZvkWA7snzGPH4
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjri
oyspZKOBycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2
kaV2KL9650I1SJvedYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i
1TXkH09XSSI8mEQ/ouNcMvIJNwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/B
BLUVbDa4+gmzDC9ezlZkTZG2t14zWPvxXP3FAp2pkW0xqG7/377qptDmrk42GlSK
N4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEBAAHNHEp1ZXJnZW4gR3Jvc3Mg
PGpnQHBmdXBmLm5ldD7CwHkEEwECACMFAlOMcBYCGwMHCwkIBwMCAQYVCAIJCgsE
FgIDAQIeAQIXgAAKCRCw3p3WKL8TL0KdB/93FcIZ3GCNwFU0u3EjNbNjmXBKDY4F
UGNQH2lvWAUy+dnyThpwdtF/jQ6j9RwE8VP0+NXcYpGJDWlNb9/JmYqLiX2Q3Tye
vpB0CA3dbBQp0OW0fgCetToGIQrg0MbD1C/sEOv8Mr4NAfbauXjZlvTj30H2jO0u
+6WGM6nHwbh2l5O8ZiHkH32iaSTfN7Eu5RnNVUJbvoPHZ8SlM4KWm8rG+lIkGurq
qu5gu8q8ZMKdsdGC4bBxdQKDKHEFExLJK/nRPFmAuGlId1E3fe10v5QL+qHI3EIP
tyfE7i9Hz6rVwi7lWKgh7pe0ZvatAudZ+JNIlBKptb64FaiIOAWDCx1SzR9KdWVy
Z2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+wsB5BBMBAgAjBQJTjHCvAhsDBwsJ
CAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/Ey/HmQf/RtI7kv5A2PS4
RF7HoZhPVPogNVbC4YA6lW7DrWf0teC0RR3MzXfy6pJ+7KLgkqMlrAbN/8Dvjoz7
8X+5vhH/rDLa9BuZQlhFmvcGtCF8eR0T1v0nC/nuAFVGy+67q2DH8As3KPu0344T
BDpAvr2uYM4tSqxK4DURx5INz4ZZ0WNFHcqsfvlGJALDeE0LhITTd9jLzdDad1pQ
SToCnLl6SBJZjDOX9QQcyUigZFtCXFst4dlsvddrxyqT1f17+2cFSdu7+ynLmXBK
7abQ3rwJY8SbRO2iRulogc5vr/RLMMlscDAiDkaFQWLoqHHOdfO9rURssHNN8WkM
nQfvUewRz80hSnVlcmdlbiBHcm9zcyA8amdyb3NzQG5vdmVsbC5jb20+wsB5BBMB
AgAjBQJTjHDXAhsDBwsJCAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/
Ey8PUQf/ehmgCI9jB9hlgexLvgOtf7PJnFOXgMLdBQgBlVPO3/D9R8LtF9DBAFPN
hlrsfIG/SqICoRCqUcJ96Pn3P7UUinFG/I0ECGF4EvTE1jnDkfJZr6jrbjgyoZHi
w/4BNwSTL9rWASyLgqlA8u1mf+c2yUwcGhgkRAd1gOwungxcwzwqgljf0N51N5Jf
VRHRtyfwq/ge+YEkDGcTU6Y0sPOuj4Dyfm8fJzdfHNQsWq3PnczLVELStJNdapwP
OoE+lotufe3AM2vAEYJ9rTz3Cki4JFUsgLkHFqGZarrPGi1eyQcXeluldO3m91NK
/1xMI3/+8jbO0tsn1tqSEUGIJi7ox80eSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1
c2UuZGU+wsB5BBMBAgAjBQJTjHDrAhsDBwsJCAcDAgEGFQgCCQoLBBYCAwECHgEC
F4AACgkQsN6d1ii/Ey+LhQf9GL45eU5vOowA2u5N3g3OZUEBmDHVVbqMtzwlmNC4
k9Kx39r5s2vcFl4tXqW7g9/ViXYuiDXb0RfUpZiIUW89siKrkzmQ5dM7wRqzgJpJ
wK8Bn2MIxAKArekWpiCKvBOB/Cc+3EXE78XdlxLyOi/NrmSGRIov0karw2RzMNOu
5D+jLRZQd1Sv27AR+IP3I8U4aqnhLpwhK7MEy9oCILlgZ1QZe49kpcumcZKORmzB
TNh30FVKK1EvmV2xAKDoaEOgQB4iFQLhJCdP1I5aSgM5IVFdn7v5YgEYuJYx37Io
N1EblHI//x/e2AaIHpzK5h88NEawQsaNRpNSrcfbFmAg987ATQRTjHAWAQgAyzH6
AOODMBjgfWE9VeCgsrwH3exNAU32gLq2xvjpWnHIs98ndPUDpnoxWQugJ6MpMncr
0xSwFmHEgnSEjK/PAjppgmyc57BwKII3sV4on+gDVFJR6Y8ZRwgnBC5mVM6JjQ5x
Dk8WRXljExRfUX9pNhdE5eBOZJrDRoLUmmjDtKzWaDhIg/+1Hzz93X4fCQkNVbVF
LELU9bMaLPBG/x5q4iYZ2k2ex6d47YE1ZFdMm6YBYMOljGkZKwYde5ldM9mo45mm
we0icXKLkpEdIXKTZeKDO+Hdv1aqFuAcccTg9RXDQjmwhC3yEmrmcfl0+rPghO0I
v3OOImwTEe4co3c1mwARAQABwsBfBBgBAgAJBQJTjHAWAhsMAAoJELDendYovxMv
Q/gH/1ha96vm4P/L+bQpJwrZ/dneZcmEwTbe8YFsw2V/Buv6Z4Mysln3nQK5ZadD
534CF7TDVft7fC4tU4PONxF5D+/tvgkPfDAfF77zy2AH1vJzQ1fOU8lYFpZXTXIH
b+559UqvIB8AdgR3SAJGHHt4RKA0F7f5ipYBBrC6cyXJyyoprT10EMvU8VGiwXvT
yJz3fjoYsdFzpWPlJEBRMedCot60g5dmbdrZ5DWClAr0yau47zpWj3enf1tLWaqc
suylWsviuGjKGw7KHQd3bxALOknAp4dN3QwBYCKuZ7AddY9yjynVaD5X7nF9nO5B
jR/i1DG86lem3iBDXzXsZDn8R3/CwO0EGAEIACAWIQSFEmdy6PYElKXQl/ew3p3W
KL8TLwUCWt3w0AIbAgCBCRCw3p3WKL8TL3YgBBkWCAAdFiEEUy2wekH2OPMeOLge
gFxhu0/YY74FAlrd8NAACgkQgFxhu0/YY75NiwD/fQf/RXpyv9ZX4n8UJrKDq422
bcwkujisT6jix2mOOwYBAKiip9+mAD6W5NPXdhk1XraECcIspcf2ff5kCAlG0DIN
aTUH/RIwNWzXDG58yQoLdD/UPcFgi8GWtNUp0Fhc/GeBxGipXYnvuWxwS+Qs1Qay
7/Nbal/v4/eZZaWs8wl2VtrHTS96/IF6q2o0qMey0dq2AxnZbQIULiEndgR625EF
RFg+IbO4ldSkB3trsF2ypYLij4ZObm2casLIP7iB8NKmQ5PndL8Y07TtiQ+Sb/wn
g4GgV+BJoKdDWLPCAlCMilwbZ88Ijb+HF/aipc9hsqvW/hnXC2GajJSAY3Qs9Mib
4Hm91jzbAjmp7243pQ4bJMfYHemFFBRaoLC7ayqQjcsttN2ufINlqLFPZPR/i3IX
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------SXP0Ju4z89jZvkWA7snzGPH4--

--------------eMtxraMeazBJCVDuP3HYlMAw--

--------------5L0GDztaCMgjeXBRHVy3bVZp
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmolFD4FAwAAAAAACgkQsN6d1ii/Ey9V
+wf/dDwXYyQ9Xeuqfxc10YRR3KCIpVTswZY5gsVJTLeIueVi7eP6VlshjT9mSxc3nFyXI3i+ZIOp
g1zt7LkuSuITlDtVGc4EZa9n920caR3aarS4lCcjym1MmhwDCZYaYeCC7mpWkzk+JbL8Y/rJBVTL
ymwblQ+RcnI6fKyCwlN6sDEGF31cpVbBWHhwUyASv0QWDnEqK4QHbhAqCbX5iVu39+s10xqOTspk
h+ge9tfUqBY8q3936f1DZZz7Cn3AqYk4sW4IbzMIlOVKP8H0xxzAtyCw6GuV1XflUbM8xf0YoTZn
O1gsyBQfSrF4To1FaMmRMmzpxuRp/A7GLK+mzEoYGg==
=1FuJ
-----END PGP SIGNATURE-----

--------------5L0GDztaCMgjeXBRHVy3bVZp--
