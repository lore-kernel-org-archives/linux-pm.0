Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CEC334374
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 12:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782737568; cv=none; b=igXgplfZdv5r0InkiFDo0imRfBiVqhH/Olat7yJ3BQlMTCU7ldH+uU72rKGZqBiuirlHgDDZ+pUf16vFtSwatjWWlO9jhCnEoQWsDqoOYxvZPp5j7DO+ooarxb8+ES2dd6MaEhx7Xq2ROv9IXBm2rsqdohS2sTiwQ4rJBOaDwcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782737568; c=relaxed/simple;
	bh=tybTxfIIvdDSnJDg/CzaRFhAvURWZAgW/PDDefJXQ4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cu+rRvfmuors9AllZcVN3iR1vqAn1g82VrqL+rVsnTb3gpXKquqmu8dSQd2O07T+FM9at+qh4UUHIH6Q1MPqCal5HZLpwaFbZAMkT9aJaY50c10stCVbajgNNsVSQKuIG+rVOlL4Cjofg0nvdvnxkxmBMWby1G2bhW3A3KZXKQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DCth07LP; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DCth07LP"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493a285ff0cso7840645e9.2
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 05:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782737565; x=1783342365; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tybTxfIIvdDSnJDg/CzaRFhAvURWZAgW/PDDefJXQ4U=;
        b=DCth07LP7WvlpdSUIOvyD89CmfR0Ec62rVJnd7DrWpVy6xUedjk5yl57qpVmgIMgHH
         DcsqCiRbBd1LZW8nZRT0JbkQa6oqwWVu/DL0Mpw2PmiX2819RjYsSGYBcDnNeiY1c6Cm
         RwQOrsEG4fOW3cR33oHqUMldwg8kcv84DxWBUw7nnlFO+THpkQ8TR+wh8M8X5uLurnSe
         Tao9XGGAPy42qjkgRdVoRLIAsFdfc/GMSqJSewxw14k+wvWqbQUBRIEy5j3X7urBMU0Q
         wHw1vT2aeB0g7q9iNgVVxG0gXWB5STvXJ2jGx9LH26uZ7eIV5TyZQsdO+tYRf5ahu/fx
         GIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782737565; x=1783342365;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tybTxfIIvdDSnJDg/CzaRFhAvURWZAgW/PDDefJXQ4U=;
        b=QobpeA+fobGeFtuff9xR9laEysMF0tej65UKWmhSe3UiBEvxyD9XHU3iTtSwHI53Su
         jjvS8Iii0hCZLFvH/PDu5HD5YDGhkTOgdupXmp1rvv2gHkL34249y1X6m057nP9ctIlz
         3ELKms4EWWBLdODbz3f2X0KwOQ1DZmprg2u+tbrAYv0PZgyqpaugD59AgVHeu4TVjGJB
         qiepgQtbn3ZJ1kPBhhhcEXP8jwzGTPORPBvvhnyc7tSfwl6EPYUldXsSfS0gu3rkVmwz
         3Dum6R4AiaHAvyd8NEcNxZa2aBFg8lWiQdLsu8mMaTP1bCVPGKKy23vy/lvn0b7Dgykk
         hykQ==
X-Forwarded-Encrypted: i=1; AFNElJ8SpFuABFlnOZKr6M/k6IaWbas/PmItxlVcuZvGodrZLehw+ysAjC/MEdLVmYjCcapB954SVpkk5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwY7rOXxiBENF9m+iAakSp3H7HuzvqJ4kurL98yG4o5oWsN/u4c
	JM9M0keFr1UcgdcecGjqpKL9EBPFzB2VzZTnBq8cZKQP49/PLcsm48RWTJir6FXxHEATeeKsPOW
	DLz1c4KbBpg==
X-Gm-Gg: AfdE7cmrolmdvncEvqGb+mGWKGBXhUflrU3/MBR2w5631OZDmqBMxvUQB0f8POncPhG
	Yp30vmkCNRC21R4arOzS3iwMPDhnl3ugAzX/Tbgb0AzLwO2QQsL0ClCfvjnXBZO3yVad/mKpYxl
	dsdLFBCd+ZFY6nH9vHkOq7iX3W5rrrfbAZUIYxYxy6w5MF0F80pm9FBY+ypo6y45VBTk6fVoz2i
	2wK7z57LPGvF1u7rQ9a770KNwH1dp/2jZWtvXgNgcuP1WxgxTg4P2OBWbZIraT14bnJqGhzGDTi
	O7K5biVi3LsmWjklJl60HhtX2UyfYRUKcSMEPBa550CWhBirZvwVQVTrj35H+UZ+RmkYydg+DuI
	+qcjqnvCY7i748K7DMuFQmHLMFSt4kWuHYEqGwJTrC3gjRCu+RxDyEWpt5tfJbMi7xMskqmbbpo
	tQHb4C5SmK1xJHB1ALRVOlB32lu1H8h0MReZ3JFn1AfLFlc7dsXB27jbk3Ud05AG94gttMHL7tA
	VS09hfxXYKfvaHY4oHMQn8pEt4QzCAivYrj0csTkVY=
X-Received: by 2002:a05:600c:8116:b0:493:b730:8d78 with SMTP id 5b1f17b1804b1-493b7308e62mr8402615e9.31.1782737565027;
        Mon, 29 Jun 2026 05:52:45 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926c285fc1sm212435035e9.1.2026.06.29.05.52.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 05:52:44 -0700 (PDT)
Message-ID: <4a661844-c6e7-42f8-9c3c-6f81ab33f247@suse.com>
Date: Mon, 29 Jun 2026 14:52:44 +0200
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
 <c4d745b9-fe6e-4290-9748-8d4d995df781@suse.com> <akJlqeg-G2P7PPgE@gmail.com>
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
In-Reply-To: <akJlqeg-G2P7PPgE@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------t48BirpCilHaVmHVdi06HmDj"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------t48BirpCilHaVmHVdi06HmDj
Content-Type: multipart/mixed; boundary="------------mRA9XI7SWqBv47fmvlPNBCi7";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>
Message-ID: <4a661844-c6e7-42f8-9c3c-6f81ab33f247@suse.com>
Subject: Re: [PATCH 02/32] powercap: Stop using 32-bit MSR interfaces
References: <20260629060526.3638272-1-jgross@suse.com>
 <20260629060526.3638272-3-jgross@suse.com> <akJWPnqcbL6RCfYN@gmail.com>
 <c4d745b9-fe6e-4290-9748-8d4d995df781@suse.com> <akJlqeg-G2P7PPgE@gmail.com>
In-Reply-To: <akJlqeg-G2P7PPgE@gmail.com>

--------------mRA9XI7SWqBv47fmvlPNBCi7
Content-Type: multipart/mixed; boundary="------------O5Vhgdkq8vqkw7fjdrxjuk1m"

--------------O5Vhgdkq8vqkw7fjdrxjuk1m
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjkuMDYuMjYgMTQ6MzEsIEluZ28gTW9sbmFyIHdyb3RlOg0KPiANCj4gKiBKw7xyZ2Vu
IEdyb8OfIDxqZ3Jvc3NAc3VzZS5jb20+IHdyb3RlOg0KPiANCj4+IE9uIDI5LjA2LjI2IDEz
OjI1LCBJbmdvIE1vbG5hciB3cm90ZToNCj4+Pg0KPj4+ICogSnVlcmdlbiBHcm9zcyA8amdy
b3NzQHN1c2UuY29tPiB3cm90ZToNCj4+Pg0KPj4+PiBUaGUgMzItYml0IE1TUiBpbnRlcmZh
Y2VzIHJkbXNyX3NhZmUoKSBhbmQgd3Jtc3Jfc2FmZSgpIGFyZSBwbGFubmVkIHRvDQo+Pj4+
IGJlIHJlbW92ZWQuIFVzZSB0aGUgcmVsYXRlZCA2NC1iaXQgdmFyaWFudHMgaW5zdGVhZC4N
Cj4+Pj4NCj4+Pj4gRHJvcCBhIHBvaW50bGVzcyBpbml0aWFsaXplci4NCj4+Pg0KPj4+IFdh
cyB0aGUgaW5pdGlhbGl6ZXIgcmVhbGx5ICdwb2ludGxlc3MnPyBJSVJDIGl0IHN1cHByZXNz
ZWQgYSBidWlsZCB3YXJuaW5nDQo+Pj4gb24gMzItYml0IGJ1aWxkcywgYXQgbGVhc3QgaW4g
c29tZSBwYXN0IGl0ZXJhdGlvbnMgb2YgdGhlc2UgQVBJcy4NCj4+DQo+PiBJIGRvbid0IHNl
ZSB0aGUgY29ubmVjdGlvbiB0byAzMi1iaXQgYnVpbGRzLiBFaXRoZXIgdGhlIHVuaW5pdGlh
bGl6ZWQNCj4+IHZhcmlhYmxlIGlzIGEgcHJvYmxlbSBvciBub3QuIEFuZCBJIGRvbid0IHNl
ZSB3aHkgImwiIGRpZG4ndCBuZWVkIGFuIGluaXRpYWwNCj4+IHZhbHVlIChpdCBpcyBtb2Rp
ZmllZCBpbiB0aGlzIGZ1bmN0aW9uIG9ubHkgdmlhIGEgIiY9IiBvcGVyYXRpb24sIHNvIHNv
bWUNCj4+IGJpdHMgd291bGQgc3RpbGwgYmUgcmFuZG9tIGluIGNhc2UgaXQgaXMgc2VlbiBu
b3QgdG8gYmUgc2V0IGJ5IHJkbXNyX3NhZmUoKSkuDQo+Pg0KPj4gSW4gcmVhbGl0eSBpdCBz
aG91bGQgbmV2ZXIgYmUgYSBwcm9ibGVtLCBhcyByZG1zcl9zYWZlKCkgd2lsbCBhbHdheXMg
c2V0IGJvdGgNCj4+IG91dHB1dCB2YXJpYWJsZXMgdG8gYSB2YWx1ZSAoMCBpbiBjYXNlIG9m
IGVycm9yLCBNU1IgY29udGVudHMgZWxzZSkuDQo+IA0KPiBTbyBpdCdzIG5vdCByZG1zcl9z
YWZlKCkgYnV0IHJkbXNyKCksIGJ1dCB3ZSBoYWQgdGhpczoNCj4gDQo+ICAgIDEwYTVkNjU4
NTZiOSAoIng4Ni9wcm9jZXNzOiBDb252ZXJ0IHJkbXNyKCkgdG8gcmRtc3JxKCkgaW4gYXJj
aF9wb3N0X2FjcGlfc3Vic3lzX2luaXQoKSB0byBhZGRyZXNzIFc9MSB3YXJuaW5nIikNCj4g
DQo+IFdoaWNoIGFkZHJlc3NlZCB0aGlzIFc9MSB3YXJuaW5nOg0KPiANCj4gICAgYXJjaC94
ODYva2VybmVsL3Byb2Nlc3MuYzogSW4gZnVuY3Rpb24gJ2FyY2hfcG9zdF9hY3BpX3N1YnN5
c19pbml0JzoNCj4gICAgYXJjaC94ODYva2VybmVsL3Byb2Nlc3MuYzo5NzI6MTc6IHdhcm5p
bmc6IHZhcmlhYmxlICdoaScgc2V0IGJ1dCBub3QgdXNlZA0KPiANCj4gQnkgdGhlIHBhdHRl
cm4gdGhlICdwb2ludGxlc3MnIGhpPTAgaW5pdGlhbGl6YXRpb24gbG9va3Mgc2ltaWxhcg0K
PiBhbmQgbWF5IG5vdCBiZSBhcyBwb2ludGxlc3MgYXMgaXQgc2VlbXMuIDotKQ0KDQpNYXli
ZSBJJ20gbm90IGdldHRpbmcgc29tZXRoaW5nIGhlcmUsIGJ1dCAxMGE1ZDY1ODU2Yjkgd2Fz
IG5vdCBhYm91dCBhDQptaXNzaW5nIGluaXRpYWxpemVyLCBidXQgYWJvdXQgImhpIiBqdXN0
IG5vdCBiZWluZyBjb25zdW1lZCBhZnRlciBzZXR0aW5nIGl0Lg0KImhpIiB3YXNuJ3QgaW5p
dGlhbGl6ZWQgYmVmb3JlIDEwYTVkNjU4NTZiOSBhbmQgaXQgd2FzIHJlbW92ZWQgYnkgdGhp
cyBjb21taXQuDQoNCkkgZG9uJ3Qgc2VlIGhvdyBhIHBvaW50bGVzcyBpbml0aWFsaXplciB3
b3VsZCBoZWxwIGluIHN1Y2ggYSBjYXNlLg0KDQpJdCB3b3VsZCBtZWFuIHRoYXQgc2V0dGlu
ZyBhIHZhcmlhYmxlIHR3aWNlIGZpeGVzIGEgInZhcmlhYmxlIHNldCBidXQgbm90DQp1c2Vk
IiB3YXJuaW5nLCB3aGljaCBzb3VuZHMgYSBsaXR0bGUgYml0IHdlaXJkLg0KDQpCVFcsIHRo
ZSAiaGk9MCIgaW5pdGlhbGl6ZXIgd2FzIGFkZGVkIF9iZWZvcmVfIHJkbXNyKCkgd291bGQg
cmV0dXJuIHdpdGggdGhlDQp2YWx1ZSBiZWluZyBzZXQgaW4gY2FzZSBvZiBhbiBlcnJvci4g
U28gYXQgdGhlIHRpbWUgb2YgdGhlIHBhdGNoIHNldHRpbmcgaGkNCnRvIDAgaXQgd2FzIGNv
cnJlY3QsIGJ1dCB0aGlzIHJlYXNvbiB2YW5pc2hlZCBvbmx5IDIgbW9udGhzIGxhdGVyLg0K
DQoNCkp1ZXJnZW4NCg==
--------------O5Vhgdkq8vqkw7fjdrxjuk1m
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------O5Vhgdkq8vqkw7fjdrxjuk1m--

--------------mRA9XI7SWqBv47fmvlPNBCi7--

--------------t48BirpCilHaVmHVdi06HmDj
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmpCapwFAwAAAAAACgkQsN6d1ii/Ey9s
Mwf/VRrHYNJFewpYerl7RyQWrzcQWete+nkoV8cXYX8NvnZ4BBPpcEdtBunFRhi4Q93r9GFzrmg0
UGIqfQ3Mbvcv/3ht7CQ3/txnc2lKDmTcOq0Azsca1DIJ+2GPiLFSFnlzxdV9j/H2i9lVxXULWJKO
sLvmPfc8bfph3ZQ6PdUqT/uyh+ytr6y/nsDGB2q/knB+iGunp1mbgZenhJitIV45iR70tMgoInZY
glIxcpvc6IoKSksM1CRjwHl2R799JcSFP4UEkUo/wtfTgqIGg9d2r0B97MRxZz6mP8aCN9PjnJOC
w8l/vTQJckmPIRxQEXUZroz+veOj0M3mKLBT5dbnaw==
=DtnN
-----END PGP SIGNATURE-----

--------------t48BirpCilHaVmHVdi06HmDj--
