Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794186687;
	b=lIQxG55NlAM9JLe+F0hUarO6qf84ckxGtGo6UpsG0OaDbBKMNYb6o36UAXACQdOEI+Wp
	 KXhApM9GXqeHT56SY33C1mygvWWS3pivEte5e9Yg7tMInyj770bdnEop1LSbA0DLub8Nt
	 3NbjRmkunEzOLYEZZ24s3T9MY8F8KnYIc+O+4gfAd4XZ6o/6wLA5tH/tuuuMsBZJYeEoD
	 5p/t1FRPj/KZpthCvFWnSfVvpcw+242lrI2OUnnf2fYRsD/VzJjAX8wgIYYWEI5hj3U/o
	 Dj8zO4peQz8AT2jB475XZVJGrpvoL42Z7cNzGwuMYC6PKQKGZ/IQyPrsyh1IWmmn4Cg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794186687;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:
	 X-ZohoMailClient;
	bh=Frm8Ld1QHHVrzUA5GQZVw3rqE7QJ68oePOVoIDDUukc=;
	b=I2MRAw+5tv6c68Y27t4dTvgahoubC5VH5ZPX0nGx7UqZ47eMY/yze8n+AX6Ac5iqxCBf
	 TiW+2+YGmhVJ/vDE+3Dm33lFFV55hCod/bP8w58xZM20yMimgPB1HU5iZ/J5jCLgYsiGV
	 n0z4w7uRMiIeFFhG+/qebTJZSa39A6z8o/E9TD6S7hNe2T2/H6L6AGwkq60gkw0+As9D7
	 uEMxjWrYLvVWUR4fFvUVPX7NUy1yAVwGyIPE+QXVaVv3B+HAln0sFi0kH1PI0J/WoLqg7
	 qGbKvKMz8Ew+/2kdJO8IIiJvFb+Md7+dLSwP7uOBHHadw9aqENKYh+yU5Mw7Xq5Xi1w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=b+Id5PbC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314A5606A31C;
	Mon,  9 Nov 2026 01:11:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 314A5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=b+Id5PbC
ARC-Seal: i=1; a=rsa-sha256; t=1794186680; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KP965G8gNTMXnOxdmYqv3VegVDyYxZjTMCfqdCMlwasTJEwk082tTk6NmHHdc9KnNzik3brm/jt9gb9ttHgClIG3pK7Ccq2ZWPRfqtuQMtM0AmTpPB53xvLpZPzWtVb6Sdd+YHDr7wtYpb4qtrdkV4Z97rBsbg3ahTG/pxk33xo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794186680; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Frm8Ld1QHHVrzUA5GQZVw3rqE7QJ68oePOVoIDDUukc=; 
	b=KBlG6TI5MZffl2bZP/tJRVMEsmjF2moYAiNOpxXdtvC7uZG4H37fKKljMEoKIK+THaskaVVZ5igeYViASIgvFbxNS9+RBTMhtxB6E5tXqLZPWv5o8+nEEPl3EXXFfJcY6ozSv9cEQSbpf8gvrA/aGrx8o1A90xaaTcrIqceLPEs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: a=rsa-sha256; b=b+Id5PbCX3AVSwyxjoQuhreG3Ca6WHoor5xr6ydh4NCvgX1mXdZzCKuEK52ttJARkqW2zhYXgo9Gd1CG1gXWigvMer+/oxX5eGSzvwi9egn1/B81yQ2J8cyb4k+lIgEsJEk8nW0vCeNjijWfClExtiFNtLlglVf9WVeXU+frkh0=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=Frm8Ld1QHHVrzUA5GQZVw3rqE7QJ68oePOVoIDDUukc=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794186679307914.4749060070615;
	Sun, 8 Nov 2026 17:11:19 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id D5A5F1808E6; Mon, 09 Nov 2026 02:11:18 +0100 (CET)
Date: Mon, 9 Nov 2026 02:11:18 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: hyunjungg <hj351016@gmail.com>
Cc: linux-pm@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] power: supply: fix work-vs-devres teardown
 use-after-free
Message-ID: <avEdYFDUHIj6mq0Z@venus>
References: <20261106160057.2754689-1-hj351016@gmail.com>
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
	protocol="application/pgp-signature"; boundary="3sgy7kbr5gvb4f26"
Content-Disposition: inline
In-Reply-To: <20261106160057.2754689-1-hj351016@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.182.33
X-ZohoMailClient: External


--3sgy7kbr5gvb4f26
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/3] power: supply: fix work-vs-devres teardown
 use-after-free
MIME-Version: 1.0

Hi,

On Sat, Nov 07, 2026 at 01:00:54AM +0900, hyunjungg wrote:
> From: Hyunjung Ko <hj351016@gmail.com>
>=20
> Three power-supply drivers register a poll/detect/charger-detect work for
> device-managed cancellation (devm_[delayed_]work_autocancel()) in their p=
robe
> *before* they register the power_supply via devm_power_supply_register().=
 devres
> unwinds in reverse order, so on unbind the power_supply device is release=
d first
> and the work is cancelled last. The work handlers call power_supply_chang=
ed()
> and dereference the power_supply, so a work instance still pending/runnin=
g in
> that window touches the already-freed power_supply device -> use-after-fr=
ee.
>=20
> Each patch moves the devm work-cancel registration to *after*
> devm_power_supply_register() (and before the IRQ/poll that arms the work)=
, so
> teardown drains the work before the power_supply is freed. No functional =
change
> otherwise. The relocated devm_[delayed_]work_autocancel() still runs its =
INIT
> before the work's first queue site, so no queue-before-INIT window is add=
ed.
>=20
> This is the same class as the recently-applied cimax2/extcon work-vs-devr=
es
> fixes. Found by static analysis / code review; none is reproduced on hard=
ware
> (each needs its charger/PMIC/gauge chip and is not QEMU-reproducible) -- =
treat
> accordingly.

Please don not send direct AI output. You need to drop useless
comments and trim down / rewrite commit messages to a sensible
length. Instead of huge amount of spam.

Greetings,

-- Sebastian

--3sgy7kbr5gvb4f26
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmrxHbIACgkQ2O7X88g7
+poe5g/+ND+IudgGMavaYHWAq7LCDjhvxcm1V3Vn7sBhoNzaT22/LDNlL7a5VbPa
TX00osbNQCELsH3CwfnCx46PmOAqWvQiLMz1yoTTMBxM5XSi4wRCEnUmvS0QJRP/
KhDAeGaR+0t7FpgtTjKlM2AJP9NgjVB2NK4F5rlcdlKBUAyfHXGfp5kxVh2hv0ns
Yo3wFquqlYxzXbHKVGUH9OsE/f3vuiSLhZPZh/UbUFGzzKzn+SmRDx2edMCTXYSP
zNCDXhwqfclvwErrnEtCXxCYtAY9atPJr6FtSVz9SqYfI72n9Ms1QSGUikvv2fZv
Iy2qmGFXqEuzIz5GboSvaFZN1+QsDfXXMe1+IlcutSsFOPi92uymSLFfoItLnw0b
vOfSQWg2WmaPa1RfjwJhIaqS4UuGj9GXL9+GoIUNPw6coaA45Pqv+EDwY/j6mYwl
0wsb8WUXnsZmcbIAZ4Rau5nsQyHU0FVQKajapECVLELodWIbKpV8nbijUMrUKlHf
hbFnaJPST8I42E+tD3HG1W0n72viZ5smTUsBwh6P322430iUnGtAFmnI0Y7FJz9f
CwHxdD0KEmiFJWjcGwUv+rhQVdhisCdv0b6wRS4YGrHHA/cypYsjbNxW9RyQvEQp
1kvT+ScdETMReV5gctHUFd010wS0NcoLUc3syx1+ZPTYEQvfKH0=
=yLSK
-----END PGP SIGNATURE-----

--3sgy7kbr5gvb4f26--
