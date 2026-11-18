Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795035851;
	b=W9XrZDr1XtJrSraGwaUqFd92waR0+JSzOesyWT6KQHRd0cWUmaKIr9zDxBVTeBUHbp9S
	 6s01Xer4JGMhTobHIOrAHCQcyIUERcWnRd9IFkNAr+3G4TehSMXaM9XiHSVErecYp15IB
	 nh3GHUpCp4iDeTVxOBv7n8UF15vWDWPpf4L+RfevJiNhHKKr3qRAyFT0hOFP4A2psd+UB
	 nw9ODolVTuyFf7je4pOD/TaIbdyFLo+Ycg8tIO541BiCKZUHCey+PaNZviV/bxUYxv7kZ
	 UxR5fPcCMZ0bSejl219hsd/1tWHBtCWX1MMyFtVLem+OS8S6bihIiFRdTDCrv/kKVhw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795035851;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:
	 X-ZohoMailClient;
	bh=dLelpa7Ur+2lYbuxtI4MMSCNnQruI8JNBFJnmaiXdUg=;
	b=eLFVncgv0mMiyvYC4fVgRdYpF7PntQcSN7YYK5ePFo3zV0hASkxZGzmujskr8siZ8EEW
	 8rEvPfyS5znJrUGI5tHDSwzYgJrY+O8JJyimJMBG9E9R1z+5vl971nuftFwA6PtAJknoR
	 gr/Vk8cyFF2NxItP23vYcu5bqtEaP8ig9sFVcKLLdcblTeJaC/6FLsgvld9tSXR3bUq2/
	 eeY8GERdr+Jb1cCpQCyC3nT5GWFtsocpgQNxSY/YO4cw6zGTdk5vgMevYeNt8NhNENqXL
	 XDzR7XE6cgkvwxSeKqEM+oFqLBNnrJSu4I4vLl58oi4bHTyl+bxsnUrXFb4NlYST/Gg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=A+sUyO8s;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4FC606BE17;
	Wed, 18 Nov 2026 21:04:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E4FC606BE17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=A+sUyO8s
ARC-Seal: i=1; a=rsa-sha256; t=1795035823; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hc4ewlGfHygjkjHma7t2hBesu+p+lTd6AfgxnMiGRSkxewr3hqXdbJbTYGWO+bQBoH4sXv2//LOMhZgdJECVIOGu3RROZRpMsHlQKoGGjy6HO7KVqSTygO4xkbwYNCp7k7dFy1f2Gpq1uYXHpTjXxVYtQJXXyM149p5EpJxALFU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795035823; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dLelpa7Ur+2lYbuxtI4MMSCNnQruI8JNBFJnmaiXdUg=; 
	b=AsdypB3cqX+AvLVGi7GI8UXF4ult2Lg8+UMeV6vKaqQKrIIQJvah3CJo1GbCaWlwnMYmrh6hdvu/wsppfa/Chjx9ppGb1S2tqwZ/nj5kYzuQHlrpQeprcauY4D+dFhoprO7E1MI29tBT5AS8df3tKCkqmmvLSxtz5AvXmbYBFDA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: a=rsa-sha256; b=A+sUyO8sq4pk5d0jrPE4wRvNsK5aAQYae7sfxIbHiCHuwjof0HgqNWOF0TRFxM8gv5OUi/1rWp6SLVhNrZqqxX7SyOtSws+jJcU9xkuISTaq301jh7G1HiQNjw6wBT5/CjpZ0DdcFPPyf+keFkPeLyfKzZYsRflkYgOAMwDsX0M=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=dLelpa7Ur+2lYbuxtI4MMSCNnQruI8JNBFJnmaiXdUg=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795035820106725.7828212239302;
	Wed, 18 Nov 2026 13:03:40 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 5734618044A; Wed, 18 Nov 2026 22:03:35 +0100 (CET)
Date: Wed, 18 Nov 2026 22:03:35 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
	MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v3 0/9] PM / devfreq: rockchip-dfi: cleanups and RK3576
 support
Message-ID: <av4SU8KEtldHnJeR@venus>
References: <20261117-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v3-0-32ff1546b0e4@collabora.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3ekhknmpesexcibk"
Content-Disposition: inline
In-Reply-To: <20261117-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v3-0-32ff1546b0e4@collabora.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/295.17.74
X-ZohoMailClient: External


--3ekhknmpesexcibk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 0/9] PM / devfreq: rockchip-dfi: cleanups and RK3576
 support
MIME-Version: 1.0

Hi,

On Tue, Nov 17, 2026 at 04:35:36PM +0100, Sebastian Reichel wrote:
> This is a combination of the DFI driver patches from the following two
> series to ease applying to devfreq tree. It is based on devfreq-next
> and there are no other dependencies.
>=20
>  * https://lore.kernel.org/linux-rockchip/20260921-rockchip-dfi-cleanup-v=
2-0-43ff34ac8599@collabora.com/
>  * https://lore.kernel.org/linux-rockchip/20260921-b4-rockchip-dfi-rk3576=
-support-v2-0-04f847016321@collabora.com/
>=20
> Changes since PATCHv2:
>  * split out DFI driver patches from both series and merge them into a
>    new one; clock controller and DT patches will be send separately.

Sorry, I accidently took the v1 patches for this. I will send
corrected v4 tomorrow.

Greetings,

-- Sebastian

--3ekhknmpesexcibk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmr+EqYACgkQ2O7X88g7
+ppGAQ/9Gt2sZalCruHyi9gTFVOa94sbuNWqb0I7PxB66i4FTrom2gql22oOX8j8
a/w/Sn7iEzdUqpOxECjrCZ8D1XwNEI1x1KMqLqQhZsHLNcicrBE+LX4ss0wItIJ8
GxoSlqlycc2UL7NObovUeY+WgXG5kX+WAGpy4sHLKllRR3bnby/MH9vTIstRTS9/
IpMad1rH8EgEcnSga47gpjxDwJXnxkHTnQW2U4J4QpOxcJ5vCTK8tMVPC21rS91+
eUM0i/LF1JmE/GseIARua1DQEuxv2NWHDDIZhe15ykV+UIcVwlNt8l7BoFUBk2tq
1CitNEs/OzmBK/LdcBsB2evwo1J7Bj8rwrfqXYfLThArwH6pCKO61jEDRfocGujL
Jrr9e7dQYxcIWm8z/V9L6E40y+G3ZawVmjGy84npYFU2bm9g7Ww7A25H7+2EWAxa
9eomyY25G3BejRCuWuYk6ZY7k54tgHc3mwAdg8QjKst43RAIOX/9xrIcme1UYz/s
/3Zx9bFmmeTF5Uv5tBEsA9s7gOVG5yROj3hxqqbooEHu+cGmuIiaHP+00Ud+V+V0
w2pMKFe7gXTdMG9u2am86+kuiOsN2RwtHUBqrbf2qeCBFgtjzunKOs33Zp7XtWXB
bcR/7557fhD/MPlGQpFsmLCTCcq9fvsKQb7ECs6tNauASMYxwXA=
=5zr2
-----END PGP SIGNATURE-----

--3ekhknmpesexcibk--
