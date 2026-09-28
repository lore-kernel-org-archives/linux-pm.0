Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FEE4E06F0;
	Mon, 28 Sep 2026 16:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613747; cv=none; b=iYSy6Nud5fibS+pS0SKPYpZM5YBvLbRDBanrwfwXYzUmu30M/082AqVb9du8XMWubU5GkX1ot/V/yHml8FkBNAZf85BelDrdG+0+JBFCkqkeue8XNSPwjJ1eLZ/kWchmuJhi/abqm0reSMquYBMBlBA94EEXpGb5LsE5UIydej8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613747; c=relaxed/simple;
	bh=9BqCHNPPTdYFXoy1hk5TULMVIsNOW76LwKuERLplq/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bx5aIflzRWpJilNX86yXTc4HY9GZ6+N8oie+tYwzKdmSp9OgwNeH+Y+EZWPo04bNj1Er9j7UEJeU10ztdpfxs8kmNWnnAT5DnO7dWzjdkgILUXPpDm6E+Jf+akzMHnUaHl7TwzzndaXEoxDCXV3yA4g5i5FfacnJeVeRu90863Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cl2TgGCx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cl2TgGCx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0481F000FF;
	Mon, 28 Sep 2026 16:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790613746;
	bh=9BqCHNPPTdYFXoy1hk5TULMVIsNOW76LwKuERLplq/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cl2TgGCxWBo2PJMF4CaE/O9zxGyfo4l/Lm0fjWSFJpMhq/2plrMhF6QJUeoVhpYha
	 xaLQZwvKfuy8r94GbzTRmXeaNvKgAMB4IpiQRA0GvRzM/baWysgEc2WpoNiV6p4/nS
	 M3bQPe9bCFXzgqiOjRMgzqMbZG+3Y5yIW9t17veM/1n6j+01bDUGCoGhBjb1icU40P
	 wpVskLCgWj0OgxSYfCGhMnxWlXBDK5b/OF4vsmNWgKhHbamZ5Dw09Qopn2v7msvchK
	 xbQjai5f6k3AyYxtZhLhUZ6PaeDqloEB/P/h2JZSay7FK+kmV1EDokCCRPFbWwxY1p
	 dXj+I8Ncn9g3w==
Date: Mon, 28 Sep 2026 17:42:20 +0100
From: Conor Dooley <conor@kernel.org>
To: Vincent Cloutier <vincent.cloutier@icloud.com>
Cc: sre@kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, Frank.Li@nxp.com, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, daniel.baluta@nxp.com,
	shawnguo@kernel.org, agx@sigxcpu.org, angus@akkea.ca,
	Vincent Cloutier <vincent@cloutier.co>
Subject: Re: [PATCH v1 2/4] dt-bindings: power: supply: bq25890: Add input
 voltage limit
Message-ID: <20260928-smilingly-reliance-200690971794@spud>
References: <20260927145538.233548-1-vincent.cloutier@icloud.com>
 <20260927145538.233548-3-vincent.cloutier@icloud.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1zONAhv5n6jgA1PY"
Content-Disposition: inline
In-Reply-To: <20260927145538.233548-3-vincent.cloutier@icloud.com>

--1zONAhv5n6jgA1PY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--1zONAhv5n6jgA1PY
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCarqY7AAKCRB4tDGHoIJi
0qtRAP4t/U8p4EyBjwU095f1YrvSRY3s6+rbhV2BOUxhNwdiKQD47xy8p8NL7N1+
/5gY9vQzht780ZeVMy17zcN/Po6AAA==
=MnFc
-----END PGP SIGNATURE-----

--1zONAhv5n6jgA1PY--
