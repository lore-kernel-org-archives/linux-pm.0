Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794925023;
	b=hlvNBtjNx4cSccrOr1lkkE5Px5qoXRBACIiqP/eJDa3Lo9IxEMD7hxCREKVLVzYndrTr
	 1XJezR2dpQiUMuTz/d9Fsood0e10vpdp0sidwHQ3v+3uFcVx5WIrGfBXIPh76+GSVOtCQ
	 phkWohErGX1R9dmZKiwckElzTSEZnxv4Z2yLTIalp4hrTPMvojOMAQUFUQtzK9ApcTFnq
	 mNqT2fKc8+TEaWwOp5ABMaFivXrY2gQcdyXsl1UoIXvpS0Y+QHYxKoraGOlNtWOVTneSx
	 bsfz7NRyhAmgtq1DiSNf7w/Ue8hotVeAaVKBsv8boRpdwe0ftwmV2R002SHM1OkfmOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794925023;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=x9JO29Zxu9psPYe2B227ZLOS3zhz79wNDV9hTXqot3o=;
	b=TsXhbY0w4hiKtIkwNpcXkb/2HmHLlXaMcX+Rojl0/AxvWFMGF675WxFIQ+rP+VbDClhO
	 LvQqg60NOHMZYMse88QByytWp6OGBUUxfwwS7NzF/jfBOwvoHrqjpyuyHbL5nxPCjwo3W
	 e/8s3ayrwymL/bu5lBKmqQ30gw2ZRC1deJYGX9DZsDASIpG5/EauWlkLl5y4U3eyHr0uH
	 o50ktvqroc9zIx89TEEIRt+zLyYYSXQLdr8ns/S8vqfn9ej7kBX/Dk9m0W74JLK1DF8IB
	 xSAFNXqZ855VZXfS4SKcmjqqpbBWvuY0ciqcFK4fDGNtynZw1H0tpxQVNNf6Zz+AeHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=RhiufrUh;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467D9606A8A0
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 14:17:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 467D9606A8A0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=RhiufrUh
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so33533365e9.2
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 06:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794925021; x=1795529821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x9JO29Zxu9psPYe2B227ZLOS3zhz79wNDV9hTXqot3o=;
        b=RhiufrUhYJjBG6JUCzddjd2k82NGjiJeZaYoGiaT58Y7S+fVxjIS54WriGq1omtvWM
         PA7cZQqfLrVWs1Gh+LycF2b4oeoWhq7JnbPNlOoPWzNjhgEH0AF7+PLDOu6BDrVBNuc6
         LSiAkOFjys13B/uRMy8s4B2tsTv59JmsOtzAsfz/dL08Zojbw+It48Y/TplltTPIAPhQ
         85vJmubk0JRqhSYOSfPbeax/RRYgzGEzSJ0uo5K6T2gXNxtxuWO0t9rhEmE2mXAGQTvk
         j42MgJvjz2VicHJxqMnFubHTuOCspZLJpyxvpwwjGa0BmsNKWEvdS31u0G0iwXW3orlT
         LtAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794925021; x=1795529821;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x9JO29Zxu9psPYe2B227ZLOS3zhz79wNDV9hTXqot3o=;
        b=HZcIgyqyDWZizJV16QLXpWKtVfRuEL3aGXgWDAZBhUV+U6Q+nLV05lwNismABBdnDU
         NmopJcojaf4uFRtpNZY8m9teiSl1xPGen4q6yXgDe5MfXBP5Wc59Ly0qcX8n3OereMH6
         3asTbzZes7DT62rjQwRZzLa/CeANCyRKeqqw9vJlNUDYx+Alxzey2rEl/S9nj4yBCGnR
         a4S0oKIF48S2h9K7vg2jdmRgZOfZor/ZcRARcDdXy/S1siQ/9ef72w9R3VWXffg9Labs
         hCdvg9I/uaH00sv+iy3dHTp1d83Iv461hwKP93VEwPPjM75/qaex1E46aynTb9zEynTK
         1s0w==
X-Forwarded-Encrypted: i=1; AL+hErF52fdf8IXLEnMbcnRS99KWuCHj1BlvVKufROlMSNJh8AS3vCpxehRFL7rfmIYT0mhEeEdYv3YM2Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z+Fq10Sk6SDwvB0E9PH6PMZxVsNUaxLUicyJuLSqlSnABLvMbq1
	abjpFrXageBs0eGaX3mPFHiHb+OACgR2YMfnocCid/kJWa9bq6/iHw8FZXBk4KqEM64=
X-Gm-Gg: AYBFou1EPy4DwUlfW8W6FVv92hsyysdPq5MUQV/yixWLfvAsi/OJ62eTvo83bs7NXBv
	vIaKYLC+r9ShYuGJM2N9NUKZubGWZZFH2eG1k2TjkK3F2NrQU+VqQTmBqWIsRLP4avqL0U6BpSN
	/Qb5Ro3PcSKgdEfDCWpcuiX0itcnns3bnsa9uH2hq+GQumBHNA1AO3e4iDy7+U9Tkfw5Cqf1ZCp
	L11ouBihRDbdW6jA9TDGHIphNnOFD+FFI/0VwfxO7YGtWQs2tz560VzbEowOFOWAz3gFhKyxeMs
	FNMRSwU5VctTslHEM+vASdqQlCCGod7famTY8sr8XHZWNvKvXk9v4Ym/cd9kblHkrXhGHfnCOF9
	lmmZhTnBCFAZ1Xb22d+8PQ86aSX5CO0WeJGQxB+sOR/m2W7OmB0lFdLvBWN/nivlVAR4XrCijZN
	+1abys7edY80OumQ08fzBpPJ9OyWpRUfv/nRPz4cgeO24IrDTH5/nuBNBkxf+kyrlW3Z50PbXkM
	sZrsV3FZsr+iuq3z53Jdc7gIPlpBhHLAa4QrLeLmgcOvP1FMgR5OPpf6DxUk16YAwavHlISg0u/
	wLWA2rKIIxFP+HVvEgX+7mldQjBLDkogcUboGcpe8uc+BNtU8HlCb7NQ1+YVPVkPXOmfs3wvbq3
	8/sUwfP1uKUmvhQk=
X-Received: by 2002:a05:600d:2:b0:4b0:a307:46f8 with SMTP id 5b1f17b1804b1-4bb55a57c2cmr223922505e9.10.1794925021592;
        Tue, 17 Nov 2026 06:17:01 -0800 (PST)
Received: from localhost (p200300f65f19a904a5ac91f50e61369e.dip0.t-ipconnect.de. [2003:f6:5f19:a904:a5ac:91f5:e61:369e])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb5f350d51sm125990395e9.4.2026.11.17.06.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 06:16:59 -0800 (PST)
Date: Tue, 17 Nov 2026 15:16:57 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Zi-Yu Chen <zychennvt@gmail.com>
Cc: rafael@kernel.org, daniel.lezcano@kernel.org, ychuang3@nuvoton.com, 
	schung@nuvoton.com, p.zabel@pengutronix.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] thermal/drivers/ma35d1: Add Nuvoton MA35D1 thermal
 sensor driver
Message-ID: <avxhlPnmjDhZlUmt@monoceros>
References: <20261117060501.2611071-1-zychennvt@gmail.com>
 <20261117060501.2611071-4-zychennvt@gmail.com>
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
	protocol="application/pgp-signature"; boundary="qlzj55hqn4bynrzq"
Content-Disposition: inline
In-Reply-To: <20261117060501.2611071-4-zychennvt@gmail.com>


--qlzj55hqn4bynrzq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 3/4] thermal/drivers/ma35d1: Add Nuvoton MA35D1 thermal
 sensor driver
MIME-Version: 1.0

On Tue, Nov 17, 2026 at 02:05:00PM +0800, Zi-Yu Chen wrote:
> +#include <linux/auxiliary_bus.h>
> [...]
> +#include <linux/mod_devicetable.h>

<linux/auxiliary_bus.h> already provides auxiliary_device_id, so please
drop <linux/mod_devicetable.h>.

Best regards
Uwe

--qlzj55hqn4bynrzq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmr8YdUACgkQj4D7WH0S
/k65jggAtbkfrltbaO6eNfAgtd7yBmZsvKQs9ZqNLrv/4BbdaUEN9BpWSES8c8TU
8A28wC5BGe+pBDAUyMn8DquMXd9blMhvyFP+4MFFbx88o6fVpv9av+03ek1XBeSb
s75G4PhGBqkTX887zZAsGLJlbHctBxujR/+IjNM496gRWStwZ6dqjd+ar6GcTdDC
I+QeQmgJl08pRBwC03L/nY9R0n77kzF2oj3u1zOO3OOnyzkdGER1z4P2EDYpsI3f
LU58xgiNfDdY74WhBJPcEY0ZzD8o6CU5N8xms4Z1ry3OCh7/QN+QiuFyf7ZYUj7c
wc2kMsQbp4G56o8VwLMzjqTwTjKdNg==
=gJWw
-----END PGP SIGNATURE-----

--qlzj55hqn4bynrzq--
