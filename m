Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.254.200.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794292921;
	b=oSReb78sAROi+YgPF5LnciJdUqpEQnMsvTfDPeF5OYHnOeazIB3hs4a6KeTkzXImD9za
	 5w1Trqqhor9YYwH0UHH+PyStsFKbtjtBNvLR6VrKZbidbUA6T/bs+bNd2racIGwecyOL6
	 bRUd9lgCEvQShchPFtRxZXHM+yxp2Q13VRF1+EuRTr5vW3SBCkYW2M5zp+g3KDxgjM3yd
	 LeOHhufU9D/6i48fDa8w3uvYT98zOqMK+Ou6ubVkCuWlsHaq1xkSg9Bmo9phn99qQwCDD
	 2WU4cRaODRUTx4U9S0tqBSesIea2ViJEcHUnCx03499urZWzOc2Oq3wK1xem6ZFWA+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794292921;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:Mime-Version:
	 Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=KDDnULezz0lYOy8E8UC/jFsEQulCu5gvg3BMNhfnq08=;
	b=B6BNcxEtY+yTX7E8yBfVZxvNODhpdXzHszbcpCihhwnDXGSPObtHPAptxDUR/U+ydacT
	 VhMpdnVTPSYkViJjaFz10ZyooTVAK5Rm4FSHwVsZFnDf68HYb/VwmOHKvdIia9jipisiU
	 g7aVsA9L5r8HG1uS0wQx/8Sf1Bp6z9MjqSzymigtbPbxmLzoTdFKYLOFd7EQKLMBG2vZX
	 nAJMBuzl+3oBk1TMbXhl7HoQ8qgsHLnHbgiUPDD8OwkNcVYOp+njjGrxwF2+Ipj+nJVdA
	 v2RAgJQxx4xbCSCo78fRVoCf4R8TZx2neODTAI6iCavFJ3XeREntkIziP7dBQEyBTjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux.spacemit.com;
	spf=none smtp.mailfrom=linux.spacemit.com;
	dkim=pass header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=rM0VSJMi;
	arc=none smtp.remote-ip=54.254.200.92
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B19F60A2604
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 06:41:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B19F60A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=rM0VSJMi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1794292909;
	bh=KDDnULezz0lYOy8E8UC/jFsEQulCu5gvg3BMNhfnq08=;
	h=Mime-Version:Date:Message-Id:From:To:Subject;
	b=rM0VSJMi07Ks59CqG4txz9ViZDx3Va0SZEBUMovsTq7ChfPX8Xx+5IMbHjRkH1ziy
	 Py+pToga0BAAFNWKxI1RP/xiucRfAzxfEtubUEATEEDmI647niXhV7dZVULujw5ByZ
	 WksN/8BV2jyqx51PuYzeKnY8X+XDaa8UxXClFjfg=
X-QQ-mid: zesmtpsz1t1794292906t134bec0a
X-QQ-Originating-IP: oveHQlJZS5x70FgvyEUxF/FxqKq+xrb9z38Pxn3Oj8M=
Received: from = ( [183.48.247.17])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 10 Nov 2026 14:41:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4058580149435769383
EX-QQ-RecipientCnt: 12
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=8b303d3f581878ca74b7956765d7a47b0d4702373ae20e17a1f1330f5a6e;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 10 Nov 2026 06:41:43 +0000
Message-Id: <DMRBR0ARCU5N.1WRTDA5GN4OG5@linux.spacemit.com>
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Anand Moon" <linux.amoon@gmail.com>
Cc: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>, "Andi Shyti"
 <andi.shyti@kernel.org>, "Sebastian Reichel" <sre@kernel.org>, "Yixun Lan"
 <dlan@kernel.org>, "Aurelien Jarno" <aurelien@aurel32.net>,
 <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <spacemit@lists.linux.dev>, "Alex Elder" <elder@riscstar.com>
Subject: Re: [PATCH v1 1/2] i2c: spacemit: Avoid sleeping during bus reset
 in atomic context
In-Reply-To: <20261110061429.2036-1-linux.amoon@gmail.com>
References: <20261110061429.2036-1-linux.amoon@gmail.com>
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: Mf2c2cXG8XEidmgGOqexfkjsa1/0+ND7gBJHCp4BVBaKxXI5fwuu4wU8
	VF11lwVEms7rYUU7MgssckxreOt7+d7WK+7cSxz1+mLw6pCwize0oTV0YD7EwGev+BUX1pW
	fpVJIoM58P68WmiMkfg1JVvk3S99MW5+RWfcn+mR5fNnfJfHO0fYXk4GPdYaC1SjK0Mnmmn
	TawYgZpj/QVkoZR9Ck3wSv17Bo/oRndfSYkc4aq2LNkoqmMjdi/XSIdx+tIq0wgRsKyl5sx
	gjfmLsN4ssKO9U183XBM0UTA6Z4ex1uyU4Kfvm9Ouf/pIQZlvWN+qewnx9VAEaN0km6XcMt
	y9nLe+hRiKaDH9DyduSqYy/PI8nskV/FB+FbCKPMOrlkd9AOG13I/tzu+6coWOmlRbEckUu
	Z4XDy9YbEsrtMZ6JtxUhvH/rtSBdqxXMPSIowCvYsby3qV7W4lbORfjGosNPLqIqLndHtsv
	ig0idUta6tFem4W4j+qreuGbCb+K3Nd7eiiGJ+sp104nNmcc6ORQYC/X4J/fV922wuCDrrh
	NUfskU1VqHJ8HR6VskaXtGlO0fiRs1hm5LiTvwv/5Zfm2H6PdWCD6J+yRxVSAPvqxViay9+
	PiLEb+vWN2aKr2plhSG0yKuHkstB4IUd88C3EEweO2rNuDXGzX8iTuh42n3BJ2XiPUIZvMe
	XFpVX2AFD1ht+uRplTK5bEsR8/notava7lJQjpAQSQOtvCZkaFZ+WnylrIf2Bh1Q3CZhe8l
	6r3gHwfHIhI3AQyxcjBCigyBncdLa1FlXWTvL0S+Y/jN+um5LnP4F9TXO43mvDIfUXtF9Qr
	X2NHC+K5XpOcK8uoxh0Vsid15qfBMcCMDQLD8I/OaFjVxuwR24pgRkrZLstkzethsOeLh9/
	ZV6qzhl+ze4oUqW+M+8Ez6rLUDxpse6n2hPSwugpUXJtTVdyBUmy0M6McXnQS4Ddgy0K0mt
	4vJhNs6ob2j2h8eSKe4ymt4gnXJ0WQ7dM0w+m0dyQEDSVZ1fzQwxN2tqJeIa7B3YyLDmHWb
	gqdKf/E4u0N9PZWl7cXTAYLXSMM+Y5HlA3ziI/7pLb+oKAre/KbT5zV9AYK27+XH2sozeZf
	g==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

--8b303d3f581878ca74b7956765d7a47b0d4702373ae20e17a1f1330f5a6e
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue, 10 Nov 2026 11:44:26 +0530, Anand Moon wrote:
> The spacemit_i2c_conditionally_reset_bus() function uses usleep_range()
> to wait after triggering a bus reset request. However, this function can
> be invoked during atomic I2C transfers (such as power-off or restart
> handlers running in atomic notifier chains), where sleeping is illegal.
>
> Replace the sleep operation with the driver's internal helper,
> spacemit_i2c_delay(), which conditionally uses udelay() when running in
> an atomic context, avoiding "scheduling while atomic" bugs.
This usleep_range() was left behind when the PIO path and
spacemit_i2c_delay() were added, so please add:
Fixes: 5dd75dac1b35 ("i2c: spacemit: introduce pio for k1")

Otherwise, LGTM.
Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>

--=20
Troy Mitchell

--8b303d3f581878ca74b7956765d7a47b0d4702373ae20e17a1f1330f5a6e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJcEABYKAD8WIQSL4Ay2cExaPXAQcU2YCe+A+TM0LwUCavK8pyEcdHJveS5taXRj
aGVsbEBsaW51eC5zcGFjZW1pdC5jb20ACgkQmAnvgPkzNC9IdAD/cSnhy/8EVYiM
iOg2ZBk126QEPmIPly5ZvxvY7dIXMt8A/3F0j9wcXPKP/DGUvY9SzSto1m3OYAr8
vnOgFrFuFiAE
=GBnh
-----END PGP SIGNATURE-----

--8b303d3f581878ca74b7956765d7a47b0d4702373ae20e17a1f1330f5a6e--
