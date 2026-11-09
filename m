Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794218022;
	b=UrSHxtumzm7tL4v8oMTAFzTd09RdNXWgj3mJtexSXEef5UbfYvfyTViKTMMKhQc0MPBj
	 Cz4dJFZENruVCjWkOJWFM8t+6aD5dKrBlAGOK/gwCxDIngYvhG3XZh+m0SZWOuKy5mid0
	 48v6wYy75lS69y4Ec2+WKgscVwr7XO9cuJlblCkZPZu9Y5u22bY4jnvFlZm/dC+iwjfGS
	 qRGlz65NsecQU+s9ILA8a3lyt7JdJeVB6XRmlsT0vvIM5n+G5+2gkXeET5aAlp9bUYMVZ
	 4RzcSpa8LdocWPheRaRU8OnLXtwQNF41FR+ZUwKI35g3SyqUg9vFI8Oik5Mmv60c7eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794218022;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Message-ID:Date:
	 MIME-Version:From:Content-Language:To:Cc:Subject:Autocrypt:
	 Content-Type;
	bh=8prTv+MPSHTPBy1i3jbcq6UwPyEEuXAeqjCSNYnoeEM=;
	b=NB3kmU1Fmovyy6atFOX2Os8l8b94PAFTopZxiRxcl40XXWddUYzNcXTMYwh/1mdkrL2l
	 QVX/wDexh1bWz4Uzy2kFZ0Y1kNQRs8r9k1tw1cogq2k2cowu/qgLWf3Mad7kFI/B1HZHP
	 Ed9m36iFopAE+4Vr/Q6WuWOY67pPUfPI2MkFkLMCYCpsAU4IOVFrNMYhYOTfSHQG+/2Ir
	 SPNEQ61GhIujX91rJl7N2nxVgC8NRvsuNoIc6YDBk47Vv0KjwjwQY72SM3ADuGwu98Wlg
	 XlThI8/UScF1vNY37WsN65UGz6rR8lCXe0d2vDyX0O41F+kgG2rnyJyj+B3eKXcV7Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.de;
	spf=pass smtp.mailfrom=posteo.de;
	dkim=pass header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=UXxZA8Oe;
	arc=none smtp.remote-ip=185.67.36.66
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA911606A31C
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 09:53:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA911606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=UXxZA8Oe
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 3701524010A
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 10:53:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1794218013;
	bh=8prTv+MPSHTPBy1i3jbcq6UwPyEEuXAeqjCSNYnoeEM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Autocrypt:
	 Content-Type:From;
	b=UXxZA8OeJgEkWP4ezKPzMJ3daESRvNgBZHBxTx23VsCePronQGJE5CR43VACbByMc
	 qQmsIkZLLSn482sqhfooFEedy8yzxLdqGtjHfq5cCVsxZP50RRqjTQzBNvZDMd2zeE
	 /GGUXMiS6jdYHdyRnrs76j0Zo1p91GsCUr8nSSDa7Kdu+OKlbl/F5PnYJ/hzZv6D1Q
	 e6mr89tLihAOO7kKU/14ammmjqn3Ey7lw9IGlUm+VfZJTp0fSwXDyjypPJ6DYFJOzc
	 dpBFopkNxUq0X+I42oUT8yYWzm/JjCEW6T0Iqoy2h+CFITcSDAv4BzrtFVa+TQ4J60
	 vUA8svc923nEw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4jNQ8X17Khz9rxT;
	Mon,  9 Nov 2026 10:53:32 +0100 (CET)
Message-ID: <68b6c302-b175-41b4-9af9-71d974b82538@posteo.de>
Date: Mon, 09 Nov 2026 09:53:32 +0000
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: "Matthias B." <matthias.b@posteo.de>
Content-Language: de-DE
To: linux-pm@vger.kernel.org
Cc: rafael@kernel.org, artem.bityutskiy@linux.intel.com, lenb@kernel.org,
 platform-driver-x86@vger.kernel.org
Subject: Arrow Lake-H hard freezes on C6 exit (bugzilla 221923): CPU-side oops
 data, max_cstate=1 holds, max_cstate=2 does not
Autocrypt: addr=matthias.b@posteo.de; keydata=
 xjMEaPkB5hYJKwYBBAHaRw8BAQdAJVUDYh5hFaqVQCwk34bSiDbJO/06wbVOaRBRCpNGmHHN
 Ik1hdHRoaWFzIEIuIDxtYXR0aGlhcy5iQHBvc3Rlby5kZT7CjwQTFggANxYhBEdoUeEO6U17
 MUyxksSm7rjJER8lBQJo+QHmBQkDwmcAAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQxKbuuMkR
 HyUb0QEAv+MemOMCAEcHo3mBUufh2dVC9MwVnnf+1mfWF3NKdQEA/0FXvAD47uy9W4AtdQ2l
 /JX8f3ljtrsjIlNhq1CpJu4LzjgEaPkB5hIKKwYBBAGXVQEFAQEHQIcyz3trEd2yS8Rl4F/m
 wF1cu4vfovUubOweQJWuZD4DAwEIB8J+BBgWCAAmFiEER2hR4Q7pTXsxTLGSxKbuuMkRHyUF
 Amj5AeYFCQPCZwACGwwACgkQxKbuuMkRHyWooQD+Ohv3mMqvC4nUZHbcinqZZZCtt585XaKI
 6BSlgAeMrV4A/ivbYFLThUqFTH8qv3vKmOz3M8e81wY5TXU1iF08SzgI
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------hjPi6vFZ0oCe0vihVl6mGuwM"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------hjPi6vFZ0oCe0vihVl6mGuwM
Content-Type: multipart/mixed; boundary="------------dm4eBQn81l0LFU4NrsH250Y5";
 protected-headers="v1"; hp="clear"
Message-ID: <68b6c302-b175-41b4-9af9-71d974b82538@posteo.de>
Date: Mon, 9 Nov 2026 10:53:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Matthias B." <matthias.b@posteo.de>
Content-Language: de-DE
To: linux-pm@vger.kernel.org
Cc: rafael@kernel.org, artem.bityutskiy@linux.intel.com, lenb@kernel.org,
 platform-driver-x86@vger.kernel.org
Subject: Arrow Lake-H hard freezes on C6 exit (bugzilla 221923): CPU-side oops
 data, max_cstate=1 holds, max_cstate=2 does not
Autocrypt: addr=matthias.b@posteo.de; keydata=
 xjMEaPkB5hYJKwYBBAHaRw8BAQdAJVUDYh5hFaqVQCwk34bSiDbJO/06wbVOaRBRCpNGmHHN
 Ik1hdHRoaWFzIEIuIDxtYXR0aGlhcy5iQHBvc3Rlby5kZT7CjwQTFggANxYhBEdoUeEO6U17
 MUyxksSm7rjJER8lBQJo+QHmBQkDwmcAAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQxKbuuMkR
 HyUb0QEAv+MemOMCAEcHo3mBUufh2dVC9MwVnnf+1mfWF3NKdQEA/0FXvAD47uy9W4AtdQ2l
 /JX8f3ljtrsjIlNhq1CpJu4LzjgEaPkB5hIKKwYBBAGXVQEFAQEHQIcyz3trEd2yS8Rl4F/m
 wF1cu4vfovUubOweQJWuZD4DAwEIB8J+BBgWCAAmFiEER2hR4Q7pTXsxTLGSxKbuuMkRHyUF
 Amj5AeYFCQPCZwACGwwACgkQxKbuuMkRHyWooQD+Ohv3mMqvC4nUZHbcinqZZZCtt585XaKI
 6BSlgAeMrV4A/ivbYFLThUqFTH8qv3vKmOz3M8e81wY5TXU1iF08SzgI

--------------dm4eBQn81l0LFU4NrsH250Y5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNCnRoaXMgaXMgYSBwb2ludGVyIHRvIGRhdGEgSSBhZGRlZCB0byANCmh0dHBzOi8v
YnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjIxOTIzDQooIkNvcmUgVWx0
cmEgOSAyODVIOiB1bnJlY292ZXJhYmxlIGhhcmQgZnJlZXplIGF0IGlkbGU7IEZBVEFMIEJF
UlQgU29DL1BNQw0KY3Jhc2hsb2dzIC4uLiIpLCB3aGljaCBoYXMgZm91ciByZXBvcnRlcnMg
bm93IGFuZCBubyByZXNwb25zZSB5ZXQuDQoNCk15IG1hY2hpbmUgaXMgYSBMZW5vdm8gVGhp
bmtQYWQgRTE0IEdlbiA3IHdpdGggYSBDb3JlIFVsdHJhIDcgMjU1SA0KKDA2LWM1LTAyLCBt
aWNyb2NvZGUgMHgxMjIsIEJJT1MgMS41OSksIFVidW50dSA3LjAuMC0zOCAoNy4wLjE0IGJh
c2UpLg0KTmluZSBoYXJkIGZyZWV6ZXMgaW4gfjUxIGggb2YgdXB0aW1lLiBVbmxpa2UgdGhl
IG90aGVyIHJlcG9ydGVycyBJIGdvdA0KdGhyZWUgRUZJIHBzdG9yZSBvb3BzZXMsIGFsbCBp
biB0aGUgaWRsZSB0YXNrIHJpZ2h0IGFmdGVyIGEgQy1zdGF0ZSBleGl0Og0KDQogwqAtICJP
b3BzOiBpbnZhbGlkIG9wY29kZSIgYXQgdGlja19jaGVja19vbmVzaG90X2Jyb2FkY2FzdF90
aGlzX2NwdSsweDAgb24NCiDCoCDCoHRoZSBmaXJzdCB0aW1lciBpbnRlcnJ1cHQgYWZ0ZXIg
TVdBSVQ7IHRoZSBmaXJzdCBvb3BzIHNob3dzIENvZGUNCiDCoCDCoDw0Yj4gMWYgNDQgMDAg
MDAsIHRoZSBuZXh0IHRocmVlIG9vcHNlcyBhdCB0aGUgc2FtZSBhZGRyZXNzIG9uIG90aGVy
DQogwqAgwqBDUFVzIHNob3cgdGhlIGNvcnJlY3QgPDBmPiAxZiA0NCAwMCAwMC4gQSB0cmFu
c2llbnQgYmFkIGluc3RydWN0aW9uDQogwqAgwqBmZXRjaCwgbm8gdGV4dCBwYXRjaGluZyBp
bnZvbHZlZCAodGFpbnQgb25seSBPKS4NCiDCoC0gNDIxIHggImtlcm5lbCBCVUcgYXQga2Vy
bmVsL2VudHJ5L2NvbW1vbi5jOjI2MCIgKEJVR19PTihpbl9ubWkoKSA9PQ0KIMKgIMKgTk1J
X01BU0spIGluIGlycWVudHJ5X25taV9lbnRlcikgd2l0aGluIDAuOCBtczogTk1JLWNsYXNz
IGV4Y2VwdGlvbiANCnN0b3JtLg0KIMKgLSAiI1BGOiBzdXBlcnZpc29yIGluc3RydWN0aW9u
IGZldGNoIiBhdCAweGZmZmZmZmRmOGRhMDBiMzAsIGkuZS4gYW4NCiDCoCDCoC5lbnRyeS50
ZXh0IHN0dWIgYWRkcmVzcyB3aXRoIGJpdCAzNyBjbGVhcmVkLCBvbiB0aGUgI01DIElTVCBz
dGFjayB3aXRoDQogwqAgwqBzdGFjayByZWN1cnNpb246IGEgbWFjaGluZSBjaGVjayB3aG9z
ZSB2ZWN0b3Igd2FzIGZldGNoZWQgY29ycnVwdGVkLg0KDQpFeHBlcmltZW50cywgb25lIHZh
cmlhYmxlIGF0IGEgdGltZTogQklPUy9taWNyb2NvZGUgdXBkYXRlICgweDExYiAtPiAweDEy
MikNCm5vIGVmZmVjdDsgaW50ZWxfaWRsZS5tYXhfY3N0YXRlPTIgKEMzX0FDUEkgcmVtb3Zl
ZCwgQzJfQUNQSSA9IE1XQUlUIDB4MjENCmtlcHQpIGZyb3plIGFmdGVyIDYzIHMsIG1hdGNo
aW5nIHRoZSA3OSBoIHJlZnV0YXRpb24gaW4gdGhlIGJ1ZzsNCmludGVsX2lkbGUubWF4X2Nz
dGF0ZT0xIGhhcyBub3cgcnVuIDE0IGRheXMgLyAyMTEgaCAvIDMyIHMyaWRsZSBjeWNsZXMg
d2l0aA0KemVybyBmcmVlemVzLiBTbyBjb3JlIEM2IGV4aXQgaXMgc3VmZmljaWVudCB0byB0
cmlnZ2VyIGl0IG9uIHRoaXMgU29DLg0KDQpUaGUgQ29yZSBVbHRyYSAyMDBIIHNwZWMgdXBk
YXRlIGxpc3RzIEFSTDAzNi9BUkwwMzcgKHVucHJlZGljdGFibGUgYmVoYXZpb3VyDQovIGNv
cmUgaGFuZyBvbiBDNiBlbnRyeS9leGl0LCAiQklPUyBtYXkgY29udGFpbiBhIHdvcmthcm91
bmQiKSBhcyBGaXhlZCBmb3INCnRoZSBIIHN0ZXBwaW5nLCB3aGljaCBldmlkZW50bHkgaXMg
bm90IHRoZSB3aG9sZSBzdG9yeSBvbiBjdXJyZW50IE9FTSANCkJJT1Nlcy4NCg0KUXVlc3Rp
b25zOg0KIMKgMS4gSXMgSW50ZWwgYXdhcmUgb2YgdGhpcywgYW5kIGlzIHRoZSBBUkwwMzYv
MDM3IHdvcmthcm91bmQgc29tZXRoaW5nIHRoZQ0KIMKgIMKgIEJJT1MgaGFzIHRvIGFwcGx5
IChzbyBPRU1zIG5lZWQgdG8gc2hpcCBpdCksIG9yIG1pY3JvY29kZT8NCiDCoDIuIFdvdWxk
IGFuIGludGVsX2lkbGUgcXVpcmsgZm9yIDB4QzUgKGUuZy4gYSBuYXRpdmUgdGFibGUgd2l0
aG91dCBDNiwgb3INCiDCoCDCoCBhIHBlci1tb2RlbCBtYXhfY3N0YXRlIGRlZmF1bHQpIGJl
IGFjY2VwdGFibGUgYXMgYW4gaW50ZXJpbSB3b3JrYXJvdW5kPw0KIMKgIMKgIEkgY2FuIHRl
c3QgcGF0Y2hlcy4NCg0KRnVsbCBkdW1wcywgdGltZWxpbmUgYW5kIHN5c2luZm8gYXJlIGF0
dGFjaGVkIHRvIHRoZSBidWcuDQoNClRoYW5rcywNCk1hdHRoaWFzDQo=

--------------dm4eBQn81l0LFU4NrsH250Y5--

--------------hjPi6vFZ0oCe0vihVl6mGuwM
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQRHaFHhDulNezFMsZLEpu64yREfJQUCavGYGwUDAAAAAAAKCRDEpu64yREfJYIO
AQDg09hEQeD649T8RC9fI7EdIRetM+rSptU3VgY7ecsIQwEA+NHMv6fd18lrgF0mHE8uIYYY/yNt
wUwUSC6nrTnCYwk=
=4diG
-----END PGP SIGNATURE-----

--------------hjPi6vFZ0oCe0vihVl6mGuwM--
