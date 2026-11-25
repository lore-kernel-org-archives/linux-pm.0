Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606707;
	b=F0a1K+CkLh0f45GlWrdgkeyGBSRFJJUH18Rrsy7G9wC8MYUdzEx9jzctbV6QxLTWEVoe
	 O8LkR4ZlR7jgrB1agY2xJmSSlr4jjhQ+jXoLtMO1uFNYlk1KmspzeqDvQ/+7L3I17He3T
	 3qwU5mzEkwHizn/fLa5p7X5Glv5oVmrGaF+/pGga5MmwKNNid7rKnKq10V+WifZ/DIExs
	 Fd5AfTUYSkTGMnPU9LNEF0sTwF9E+n8hJq8eRHeUl2ECp1EV8Xov+nD606x6bK9LAv39A
	 YG4PggF/+HB/FObM8Y2SszFyB6dzTwEkBhX6rD3/1zKX6U4VkLQkQ+asheU+IBmWaag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606707;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=s2BIBd5zd4VkMYRFZWl5QkRuLP5x9yc/zhRV4K5hm78=;
	b=IZQrAZPuFlp2uDlL4fWM7xQ01EGfZ9SECuIdgoRFeDXhmCWnbrICI+az0fPsVXjtuTPD
	 xkwufulo2mmlruU+PiJ3S/xmhSS+LTt0135nlRfi0yMED89pOwkFp9pUrbFI0WmGhXVc2
	 CzUKDR+ffb0cz4aKnXYdT1DrF1+tzbFlQKom3+5x3LJWlUbVNZ4waK9Cilwtdxra3KEPY
	 isnKnGVlctj54+89N0UeLuK0wjkOy91zyLqvJsb1M6G59nZtCZKOI08zqEGsVU0iTQnCZ
	 LzVGbEjb7dDFOlaKTQvrv9H8tC2lNP1zfTDx8snfGWKD+ozfAQqGdXQQEa8MDZsIk4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=KSxpaI54;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272F4606A31E
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 11:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 272F4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=KSxpaI54
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4bb6adaf0f1so49472985e9.0
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 03:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795606700; x=1796211500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s2BIBd5zd4VkMYRFZWl5QkRuLP5x9yc/zhRV4K5hm78=;
        b=KSxpaI54cIcKWf5gI0gybRkbKbqSsHskJJaBtu8FGJyA041yqykOD7fQ7w3lxItY7U
         U6CzI1hyJ6Cd0TwEeIMuK2GqFa7ZGy6jeJYyriiT9Pm1rEEm9+AD0ZzBiYOLhYoxJ+dd
         hKnF2s1f+5La/ykPimDFzAdMVZ6pZWXxNM7ay5wXp7vTEJZsy3bWMvF40GmEyWrpCWly
         geI2oIjjuq6B1hzzAHee75BiFkBTh21rh6ALomuOeq4UHC59IrsGSuy/ihOHZw2OWVEN
         NN7m6KUEML1LnrZHyGTzVkBPtKTkPsyBhX+8XMjy6wD2emnylX0cmeoEtgnBbjNh69G6
         MNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795606700; x=1796211500;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s2BIBd5zd4VkMYRFZWl5QkRuLP5x9yc/zhRV4K5hm78=;
        b=PfTkA88P5Cke6k2L3VgsHjdmkdFkX6D8VNUINtXd+ZLpyM7BIhZ9C/RKFWjeWgfsy+
         htI0ALX+eIuDMALtmqk/mp6dlQ+9No4PmjuRyrSM/NfrFSCyskxIU2ZNDcV1nVBp3BRC
         XzuwHjAfVxiVtnzKRUl6mg2Ls2UMYMK+virUVXg3QxymT4QhOW7K9DMBFFF+4RnsBBbU
         24EEUWnJe8xd6Zp+DQKE4Dbv6rx5V1DhXw4cvvT9RU3rb3PL9cwSmCTQ06z9Mnbtddlo
         r9I45Q/4bCd0hsJF1dbgQ6reUJU2J8BLze/rcVPhDvRfR8LbWd7gI0dk+T/t+EZ2tcSH
         urqA==
X-Forwarded-Encrypted: i=1; AL+hErHPVOuVoeyUYwC6AYv5oRWq06tITU9feb+n0WhINYHMb3qULHbz1H0bC93AjjcOJ5GjWC6HmvJoKA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/GfvsmPS3QwNqJmyY86FytV5sVsjx/XZE8LFmV6f47uBDx4W17
	Ka8coU5vjIvVj+VOvg51/lp3D8z6oDHwC+EiqF6nudiqFmxrYnKgOjy3NRa0VK2CRK8=
X-Gm-Gg: AZFdTZeaGZC7ncdCdTkhObnqIF2Lr+Bjqkjn+sX23t3Qzd2iN0BlgpfNbms5fRiqRCM
	Ht90xfZQwoP/nwbzo0Gunv0OWgXSdLRFTu6kxxlQO8d1U8pOnBJSHtB78mBQ5VyUjdOxBx2vNpg
	5KL7iB+pxQsg4K7nRyu5jDMY4g/qX5NG+WIX/j8Wl9pxn/SvenhIhtvUUIJkcLBgnWagNfxGHmk
	dtzMmbNfGGykDRCAFZn+rPyzr4HCMUh6AKuYccQZM9ix6d3oE+tvpmKsMIzY/tUpcFsgoif+clP
	cXnFAFzMRQ2oEcOE0d08Smy17Cgmmw03F13/XBh5g4ZWBnwgx+s/TKxIOwMRBy6BVLiP0FUDYCR
	aTJBG3nwrM7ck6SWS2KxOcEdRVI6XFiTvEQYmTRUDtU2Tpi8zUBKpwVLAVeNP1mwu9cSqsYejtB
	l7tabdN4k5ffuH3VsN9q0tAvXrJ3chnx26Et9pb8C4uJs5lWiDkL2O+hTFWn8GgOICdVi+s1wHu
	2KMIgAQRSLLGEq/ehOKlvHauXNqe2oEcAOCNoPe/rOajpf9ypknmR9FuiQpAkBprKxWL4eD1onE
	nrIpzpQty6u6SJ94Mrb9nZtetDzo5WSVD106hr6mraqCK2GZ7loJY/cgqGd7tyb6Fc25aL9sOBn
	Cwb4pstYsSZNCkziltoh4O6I=
X-Received: by 2002:a05:600c:1911:b0:4ba:38a9:85e3 with SMTP id 5b1f17b1804b1-4bb8880eecbmr389740405e9.12.1795606700561;
        Wed, 25 Nov 2026 03:38:20 -0800 (PST)
Received: from localhost (p200300f65f19a9043ef7230869dfba63.dip0.t-ipconnect.de. [2003:f6:5f19:a904:3ef7:2308:69df:ba63])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb9067846esm334115195e9.4.2026.11.25.03.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 03:38:19 -0800 (PST)
Date: Wed, 25 Nov 2026 12:38:18 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: armandas.kvietkus@proton.me
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] power: supply: Add Maxim DS28E16 battery cycle
 counter driver
Message-ID: <awbIT7KY-jYiaTBe@monoceros>
References: <20261124-ds28e16-v1-0-bed431df0578@proton.me>
 <20261124-ds28e16-v1-2-bed431df0578@proton.me>
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
	protocol="application/pgp-signature"; boundary="jjrec77j6abl6thu"
Content-Disposition: inline
In-Reply-To: <20261124-ds28e16-v1-2-bed431df0578@proton.me>


--jjrec77j6abl6thu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 2/2] power: supply: Add Maxim DS28E16 battery cycle
 counter driver
MIME-Version: 1.0

Hello,

On Tue, Nov 24, 2026 at 06:43:21PM +0100, Armandas Kvietkus via B4 Relay wrote:
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>

Please don't include <linux/mod_devicetable.h> as this file will go away
soon. With <linux/platform_device.h> already providing of_device_id
<linux/mod_devicetable.h> can just be dropped.

Best regards
Uwe

--jjrec77j6abl6thu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmsGyKYACgkQj4D7WH0S
/k5AewgArBYfMFatnNpL8Psvv6tkIFRXFQrumMJZWzm4TrNGgZ0ChTINBtd3d+lq
eqw4N7FpU0I0B4hHymNl941aCVGDe2ChNrN2Vj57ZJ6kNh+XTomH5r+t9wGiYKNi
MZN+bNJdFCE+TSaeTTfkFzCmC0V6A/49lGho05mZSMOZaS8uOaLgvFQ5nE+eExZZ
o7Ynyh+REbs0ZriffD7bKmsvAuvRwXualNrIxDqg7/b3sEvknF4q6ibG59zVnv91
UGWjbKo1NNDayvISHATU2tiZdXL/ABRCIUPz5YxQA2uULskx/y6b67213Mv/B+QI
F+Z+tiGP82oeKZyu4hdSbd3Fk1APsw==
=Up78
-----END PGP SIGNATURE-----

--jjrec77j6abl6thu--
