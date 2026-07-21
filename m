Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A8A46AA94;
	Tue, 21 Jul 2026 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784648395; cv=none; b=b3MjiiHzs+JaRhzC+WvYvTTJJyyYUEo0aCv37Jdtp1A2LPX9u9HeNNAhqgvESrEnDY0OW3DJpMSPLvLa8VbaOTEBw31cDINewj9RsmKmlfYu/7jhckvFziqsn+y4x20k/1X6wbnkLX3mOpYUURpEoXAQ69VM6UwuyP442nqVh1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784648395; c=relaxed/simple;
	bh=41hq+9axVE1hmuBkU5OfbqB+YBzt9qMiLQgpKmcKMW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fblZW0ZeaiD0ojMeaZB9PT+7tLMfQGbG2BO+tfBl4SU+b4oYvAcRtu+uslqLGDaqMAC0VVyLoOZwLdkfDSoyhIxlIpCxb08tykTl/jaF6JlOVYcxrG4tTyQCRvZoSr2T/2nrm4rMW3M8a+Qw5PjI4KwlAXlaygigsHyR8QNZP6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQnIe3r/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQnIe3r/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40DB21F000E9;
	Tue, 21 Jul 2026 15:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784648393;
	bh=41hq+9axVE1hmuBkU5OfbqB+YBzt9qMiLQgpKmcKMW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hQnIe3r/MwxYOrpphq4ERSK7cjE10T3Z4xT8FHrOplKSlWpx4g2hDnt1/aR5AYoNm
	 2AMdj+WpmrKoAiQBodBpD58GROWpFPK/YmlMd97xKT3xJmTtELot90UVl1hM3ZONxi
	 DIKcAU9cYg8uhpsNIi2NM1k4ZrcdJFRMzoItfVUsdI51ci+v6twFHrPADA4whBak+l
	 HY2HA9uOyTKNM179i0KuE/CzsgUaSCL7pfpnYjtwszidTUmb8fS5IqHpNtvxVeeqEY
	 YKQpBL6g+nkHEwNfR+zcfE1z8Smy/nKa8NeU5VqvMl8Kmp0kvReSJa1vVxKiWsyxAY
	 trlCZfyj2JH1Q==
Date: Tue, 21 Jul 2026 16:39:48 +0100
From: Conor Dooley <conor@kernel.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	zhanghongchen <zhanghongchen@loongson.cn>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
	mfd@lists.linux.dev
Subject: Re: [PATCH v2 3/4] dt-bindings: thermal: loongson,ls2k-thermal: Add
 compatible for Loongson-2K0300
Message-ID: <20260721-broadly-unlikable-9b71a062b2d0@spud>
References: <cover.1784619512.git.zhoubinbin@loongson.cn>
 <a87ca6afc11399dbc8c5d99d979aa6ed815b8542.1784619512.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rhyr2B3oFZFLBThF"
Content-Disposition: inline
In-Reply-To: <a87ca6afc11399dbc8c5d99d979aa6ed815b8542.1784619512.git.zhoubinbin@loongson.cn>

--rhyr2B3oFZFLBThF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--rhyr2B3oFZFLBThF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCal+SxAAKCRB4tDGHoIJi
0hnvAP4snOXjjBg1vE8ro3sHX2VwzoR2CEvUV7rftT9gZqb6YgEAyZ7O7xUvLm+6
NM9cN3rN37tiwdn3KVe4h5P2udJGsgc=
=s9Oz
-----END PGP SIGNATURE-----

--rhyr2B3oFZFLBThF--
