Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795716556;
	b=zH5tpKhj8mVLNAwUnsbaPbQcgjtDNCVg3Cd6DA9vb/djXBE5sPVzUre9vp5Ra1fI1IE+
	 XcOz+KYj7muttn49DtykFALICccuB351Wa11NGBNO38sbGc9EfH42THQ8tQvcDmfeQBvQ
	 i/BSgflBa8hD9KbV2QvCRQ9CShEDEXFrqmmRAKeISWUvZC7Z8hYUF+2GeMh5OHr13VspT
	 vo3x0Zw/CerSY/I/iquGgZj1rRM3KMYTOoMsLlyXqgnbm35ZPAQG4Z4XhSV6vYvSRb4hK
	 Ewe382EtehKaVj/jppNA/llkwI71E7gltDHiQnZJnXKkreI+hdkN3Hq3AeEeYMSPdmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795716556;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	bh=5Ua8eli/eeePNuHrLso0Ijy+DWauR2C0WdOXLlgWKW4=;
	b=gQU3Wnjj3QAxztmovHZT1o2KxLKNsvAj99a2ix+puSzOAe3gxoeH23eUNrLHRka9mP1S
	 YAoCpNhINRSdySVgiOhWI4be3UINFc28nq4i0UxEDCMgLfhFGqThmmoU+ByZZfgUe5Vkg
	 ineL0s5eFG+3WGJ07tiLI/++N9w2u+RapmBNrQjrejV5Lun3ADeaeaxbAhZtvL9DTbWv3
	 NJaZfSnjelLezhjzfl9dO4EDi1EpX6ukQAzY7Y2hllCZMu8KPHctTRKlq4GY2CTHMAm1w
	 liAg/9EXl5uDNX5opTU1QQJH9C54IpEgOtaFeO3BtLg7790P7DRmGIGuQXREZ3vXrjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z4ysYqZI;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37E3606A31E
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 18:09:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C37E3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z4ysYqZI
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4a42b34e930so6397248f8f.2
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 10:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795716554; x=1796321354; darn=vger.kernel.org;
        h=content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Ua8eli/eeePNuHrLso0Ijy+DWauR2C0WdOXLlgWKW4=;
        b=Z4ysYqZIi8yTtEsGaz3PJPdELo5yah/1bnKBGrQNdDouR5yhyfZgAiqVpFk2dXVvNR
         saVwKIPGbZ0WHF7+ScrB7Nn+ThzlMcjK4sI+u9ysAQpkDXIRhGd5iGa5sRNT5BEVUHlB
         51yQUuvr1KzVN3EJl2MorHrHyXgbCLCyqu0ZAJMTHy2RlgdvtAa6A+w1+9nkA5RU5Jkw
         zAqsyMWKeR50HjRN65BXcOyLcE615jvvZHikjzc/kq2xvqbbMYrUQ8mRrYd4LbcZJye8
         dsDComUeHBZAMqWWwMe+eda/TqBmk9RUDBNQ56KOGC4Zf2HZYQIDV2KFGcx2+oYZP+f9
         K7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795716554; x=1796321354;
        h=content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5Ua8eli/eeePNuHrLso0Ijy+DWauR2C0WdOXLlgWKW4=;
        b=A/SCxNjzuTjZ9Z6Iok9VsZsuPGEBT2Ulzi2fWmWR7vz9ZoxB0ikPKkDKxj6cCReWYI
         YvzRd5UK573OG90xCrKhkbtJOl7F5auBD7Wk0jGxV+PCzQAjlG5B15lRVgv4ojlZ/DX4
         ma+e6hmt2kFxV3ZNbMXxbDfYVq4hqzdl2Ox9OaCCaQe/fWTbN/dCAE26SwChfybt+4Ri
         kaOQz/qcmMU3HbmqHKwrIzYRA2YlrPg6Mi/BI9airca3Imekr1Us0JX4HjKZ6P2Sj/kr
         kdJvDKoaWvqdJ4Q1jbRaa7hHgMOLWdEb3hE7TO4ly2ryZhqYlPCa8ZGDJLpwDROmqAFh
         FRSg==
X-Forwarded-Encrypted: i=1; AL+hErHEsvm/IYyzY/MwTyIM7iOCPbTXqg6WrF3yDs2bYqoiuPenhfJKlV/XOcYWzWHfTjf2uXwIJHxnPQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+isoR+NRt9oCIelueyJj4p+bKe/mM683yfdSqjh7abYVZ6AQdi
	AEBYq6gqKRcH6ZQgO7XV43vk2y0PuvNrl+fiQTbhKh1MPechYIhFrcCb
X-Gm-Gg: AZFdTZc/02ThTxUp/AAugtJmFmit3pW/Ex9Kf+y8+cEjWqqMQ+TMjG69UukXIVxU1uy
	DMQo1yy0BK1vlfJlL69YrD6cNLvtfYku/Fdr58QXLq+CLrCezC/kVpN3J7je+q9XlyqS5z9nKtl
	X/QBRChBTzUXGBmRcTaV74rr8sWeGbyTvWurnIpuF1PIEXVApCZS2W8rJXgJyx65yUnFS4aG6Es
	ir6lYU7bACoaO/njKkzgDdpf19+CM9+MxTSc7MCs9aIKEcsJ3kRep/2IrTeHRIIkv/zlFZcbIdD
	ko0T5wiCfTYsYdmvPtlOf4BySQasf3tbff0byLb4L3a+zJB8mMYRtQpSURmruGjuku8xSlU0uHX
	d4ewIhiTzlSDuSoUCK5cMtmbqdWPauobiyrKAL3L8Q10zGZIoZY8JngNTxNEP5sMIFaMmYImNFE
	Ek680bwjZpUfr0ve6BXp1I9hDzeRHPGqvZDWNQ7lBvjUVdg5EvSAx6bcJfMT5dqZO95bmwSuU05
	FTDdcS13at1yBRH24uXcp/vb4ad0u0ohjfCmL74DqX4lgH5cGOTrvWmqxZiLg4l8AmuU8dl8tuB
	VUXXZaB9DuX7r5094oROXkcszU3/eOmWV9t88NQJ2w==
X-Received: by 2002:a05:6000:2506:b0:48d:ba3b:af36 with SMTP id ffacd0b85a97d-4abb47b0f64mr52009407f8f.37.1795716553993;
        Thu, 26 Nov 2026 10:09:13 -0800 (PST)
Received: from strix.localnet ([197.250.160.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67f204sm50447904f8f.21.2026.11.26.10.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 10:09:13 -0800 (PST)
From: Stefan =?UTF-8?B?RMO2c2luZ2Vy?= <stefandoesinger@gmail.com>
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Lee Jones <lee@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Agustin Santiago Isasmendi <isasmendi.agus@gmail.com>,
 Navid Ghahremani <ghahramani.navid@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 mfd@lists.linux.dev, linux-pm@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH 3/6] pmdomain: zte: Add a zx297520v3 power domain driver
Date: Thu, 26 Nov 2026 20:26:25 +0300
Message-ID: <qBBdBMwWSaK2Eq9RGMmPfg@gmail.com>
In-Reply-To:
 <CAPx+jO_zuvcNnBWqUKJHJ246xEDb=FbN6FYKcrN+p6ERmjg2tQ@mail.gmail.com>
References:
 <20261120-zx29usb-v1-0-b0433258e51b@gmail.com>
 <20261120-zx29usb-v1-3-b0433258e51b@gmail.com>
 <CAPx+jO_zuvcNnBWqUKJHJ246xEDb=FbN6FYKcrN+p6ERmjg2tQ@mail.gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPartfY-J0jcIRweO3vnQrxe_bQ";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPartfY-J0jcIRweO3vnQrxe_bQ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Stefan =?UTF-8?B?RMO2c2luZ2Vy?= <stefandoesinger@gmail.com>
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Subject: Re: [PATCH 3/6] pmdomain: zte: Add a zx297520v3 power domain driver
Date: Thu, 26 Nov 2026 20:26:25 +0300
Message-ID: <qBBdBMwWSaK2Eq9RGMmPfg@gmail.com>
In-Reply-To:
 <CAPx+jO_zuvcNnBWqUKJHJ246xEDb=FbN6FYKcrN+p6ERmjg2tQ@mail.gmail.com>
MIME-Version: 1.0

Hi Ulf,

Thanks for the review!

Am Donnerstag, 26. November 2026, 15:26:20 Ostafrikanische Zeit schrieb Ulf 
Hansson:
> This doesn't belong in this particular driver, but rather in the genpd
> core. In fact, we have a proposed patch [1] that is being discussed;
> but the bigger question is if we need genpd provider drivers to be
> removable at all.
> 
> What is your use case for this?

It's extrapolated from the clock system maintainer's request to keep clk 
drivers buildable as modules. The pmdomain is even less critical than clk and 
can easily be unloaded and reloaded, even though I don't see much practical 
application.

I see the following options, in order of preference:

1) Simply remove the device_link_add() call from the driver and add a line to 
the patch description that this is deliberate to maybe shut up Sashiko.

2) Set .suppress_bind_attrs = true and make the option bool.

Note that the MFD parent is tristate and unbindable, but that should be ok as 
the pmdomain consumers target its own node.

.suppress_bind_attrs = true combined with tristate isn't going to help. Unlike 
the phy subsystem, pmdomain doesn't hold a reference to the driver, so you can 
rmmod the pmdomain driver while there are active consumers.

--nextPartfY-J0jcIRweO3vnQrxe_bQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEQxb0tqoFWyeVMl1sPRO8yFRPGiIFAmsIa8EbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJED0TvMhUTxoiBIUP/05AbhnlM2LcacFX58EL
N7rFiT+lhfKkTk2WyMVEI10KwIOop+Y/Am5zrnL5YXQPyLWu8N+pfkUki9SvJSBH
iKKDQAncXwJ7lWkBISVb2/BxeqJxIHWfDJ0GYhYsaHxLyYo4PWMjT+tq9s+Naqvv
gu5WXpYb3F5sqS0qshsJicHYiU4z1vU9hg4Qazrs61AjDU46L6XpevR5L8mONzHZ
piLakQdu+Hp1LFMtu7mMqniIc/RnlRoL76NDcjP7BZ5iS9l+INN5R4bIYGP5uCJR
84bozcygfkiO6tlkIIcumE/Z5DtZfUlC+u4vvpy1X3jbtMokGZ9K+hpKLCVOQkqq
nklQEfe5EwJVW55bPLRj8LD3npSlBNsAWI5BdgyEqvBf4RuLdbVmodDK5dT8p4YM
/u/o0m891tAX9tp9dMrkPPJyyhHe5rmRoV9mSBNDzqLuOUfQcvhsHdyPgi/xFLY2
FHugaTeVu2QhrRUvurddqz6liNm5+sfy7uzYUtjVjQWxAQZ0GBnDKaVkIaYYUHnv
i1VRm13aavhPdH3WgQh//hh7gZZxc3zO4ioU9gRtxWGwOoCZOYhM43WrTmImaRMG
EMld6KpU6bCcuWmK9sC7u6W7PXOrExL+8Z6bO09no49EU90SimbONtaWrHM9i/jI
0jucOU5MLX8n7BJ4G4cwpoor
=3XcY
-----END PGP SIGNATURE-----

--nextPartfY-J0jcIRweO3vnQrxe_bQ--



