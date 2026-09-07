Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C2B38E5FE
	for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2026 08:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769698; cv=none; b=LBEjQvAjbltzQUuF+xQYa0/3s9wbaH2h4O+HIcrOAATxwgiHH/RWaO/l97Nm4zEkS35+HW5lMcEC9t0YmfIvCqPi5aH32Z7x3mU6cu2CagEoJwACrYQjUD36IqnHm9CMWu+aUCnT1RxbAW2B0F5aS/5Pykc4G7ce1QSJEq+4E5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769698; c=relaxed/simple;
	bh=huFQlCxAjSKXrnS0hP6aD8uVwJipgrrBkGwCQxbjol4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMA9atYaLoPshwunhLTWM/3Tv5I7Kz2TcnVnQtM+Trhj40ERnzm8TJUZhf5ZXlTVSK8qPav2GP7408rBWW7WeMfgzptFtCjl6nCWUSKDB5gK4nY476iL1cmlujUWsLOyWc/5TY4gnrMHpJwmXvQthVb+Pfxm5SvORGp3oE20LMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=CcvQogcS; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="CcvQogcS"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49557167508so39755415e9.1
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 01:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788769694; x=1789374494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BVJJYbJWb+cBOU7Yim8Nj+TVsMe2MibjBMdU5cRQacc=;
        b=CcvQogcSuce4cB8ZNWEOQq8LN0+Eo9KvYFLDuY3fM6GB+zdGMQP7s2oos2ZX+OipLd
         aLqHzmN4PmyuZzLBemu4DSB/sZrs1DYfZUtI2O7Hi8WyutkhUvSeDKaSv4Yr7lPZ+IjH
         LpqlD5KmElqnTum7ohW7NvjuBwahiMxJwMh2BNFKsUcZqsoCX4A9B9A6/x2Ko+fnBDBh
         +hgfUBg2yTQ5uORA7nrB+tuIhCt6cflGnjgzUy34h8PZS8M3o5bEElHjk82ea6n8Q3et
         nRin8ay2//iZAzZV+0/FfTgx9Z2YPJCI/66KhhBUyx/DVaPGYxenEsQgogQ5MafBEUOT
         OE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788769694; x=1789374494;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BVJJYbJWb+cBOU7Yim8Nj+TVsMe2MibjBMdU5cRQacc=;
        b=Y9oGtNu/sCmQh+1aK/20MO1jjs3Hqz3wu1Khc5Hd1G/a36Kbk2XqpOO5t7B9E0Ms1j
         GoCPmqZhR9dUrODsg6NANcarowQNl0e+AYJqEB3zt7w2rhdOFwziD2W+11Fi+msHZzdy
         QWC5W11SPcs1Gg875X9rGkUjbluEbp8aXR25cV/o7MZEfxU4atdtm85b9ZGYe/1zXeno
         7IzVE8Ti7++as4zPmW3mWLvrQWcxcnOL5g5TKcu7QWjJvjx5PhPOUzLtypM2QbnjroW6
         UKPtV/Zc/QDUyti35r65wqSEfb/OxXmuX9InvsmwcLSYfzunxlHdtdMnC1OHOTKGb6/t
         68gQ==
X-Gm-Message-State: AFuF++mFXkrJwa4pLgljpBye+nM4LUxGt4w4oJM6BNVaA6rrdGaicRHt
	4gt+vKyGRKGl3bTuKDhdAgBasK+tNPmVtL8qJ/UXdvPMONe9T/ly1tHAPMD+r/AVH1sn4yLZBE+
	JmmQpQSU=
X-Gm-Gg: AYBFou05CWaMkUbjWG6VBXtDuueIpw60vnsCIBh2qnf+rcol9KEJgcyb2yrSt5x3qSg
	2Ug5le/qNLtO1OmzBKHp5qauR+JIAFY6186kGvem10FwnXhCICYEhHx88U1fe3GOc9xT1Mq7ai7
	xS4k2MsEIx5YBGqGAAHLU27w30LnuNYN3ctfYk8Oqpoxwnvbn9qn4h/LilShT1LqxQ2RXFKE5li
	D6jA+EKbiMquWplYa3ApXtDe8M9r+L4/mVmozVC2O302hMwdNvefcUojGJONP7KuyQGpnxfLfG2
	dfJ/13XuY2KI6JgW6x4ePPT9hZv0M9ylxCtlgRSYvAzA3hbzKPldXiiXjlL8PqgxeC2nH+XQZFt
	Kn2QLRpugHXg9nYTzIg+O8oOPSDwrD7L+NPiJH0kRwxZYFqu51l+AADWocxRx6el2pTQScbttTf
	2C/mrmGWbdMaOvaxSat6Gecod7q8Nydao2JpdC4aWbcyABFx1DYF6Xw39B3tcXAmgnxa4EjVEQ8
	MfqlY4ZaI2qOgOI+N+FH4R1KIkg9WLmyF357F9fM4coadaFHb/5W6J/11DBlw==
X-Received: by 2002:a05:600c:8b09:b0:499:b65e:49c9 with SMTP id 5b1f17b1804b1-49cf823f57fmr438673975e9.10.1788769694367;
        Mon, 07 Sep 2026 01:28:14 -0700 (PDT)
Received: from localhost (p200300f65f19a9047ae53bb37ada872a.dip0.t-ipconnect.de. [2003:f6:5f19:a904:7ae5:3bb3:7ada:872a])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49cfd3f8192sm253287995e9.3.2026.09.07.01.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 01:28:13 -0700 (PDT)
Date: Mon, 7 Sep 2026 10:28:12 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robh@kernel.org, 
	sre@kernel.org
Subject: Re: [PATCH v2 2/2] power: supply: add LT8491 battery charger driver
Message-ID: <ap501OIVvkOg_sAI@monoceros>
References: <20250110080235.54808-1-johnerasmusmari.geronimo@analog.com>
 <cover.1788432152.git.johnerasmusmari.geronimo@analog.com>
 <9c260e1c2056c69be1cb7a05abcd10ba657c1548.1788432152.git.johnerasmusmari.geronimo@analog.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="izx6zmq4uugxibrs"
Content-Disposition: inline
In-Reply-To: <9c260e1c2056c69be1cb7a05abcd10ba657c1548.1788432152.git.johnerasmusmari.geronimo@analog.com>


--izx6zmq4uugxibrs
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v2 2/2] power: supply: add LT8491 battery charger driver
MIME-Version: 1.0

Hello,

On Thu, Sep 03, 2026 at 06:46:37PM +0800, John Erasmus Mari Geronimo wrote:
> +#include <linux/i2c.h>
> +#include <linux/mod_devicetable.h>

Please don't use <linux/mod_devicetable.h>. You can rely on
<linux/i2c.h> to provide i2c_device_id and of_device_id. Alternatively
include <linux/device-id/i2c.h> and <linux/device-id/of.h>.

> +static const struct i2c_device_id lt8491_id[] = {
> +	{ "lt8491", 0 },
> +	{ }
> +};

Please make this:

	static const struct i2c_device_id lt8491_id[] = {
		{ .name = "lt8491" },
		{ }
	};

(i.e. use a named initializer and don't explicitly initialize the unused
driver_data member.)

Best regards
Uwe

--izx6zmq4uugxibrs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqedZkACgkQj4D7WH0S
/k6enQf/cfgn/jeJDnqupXKlB2/USBaFWX79CznAQSEq9RD8PL62FsicUxR2+EYM
YxFRNZ6DQgf/g393cau19HSDv00Z0cL636rC6Dv3LlWCLCYNq7Jplo4SI5+whggQ
HwgKNmEJh//evjDVWxGJSGTB1PyukASl4x4PmfHQ7P2YU6TKez4yfp8/iQq5sJwM
mBX4qJgmb0Rm7VPBFkt2zWyE/CG72+k5IhRVbGlsQX22XXEisJQkz9xahR36JKbG
jMzjw1loaw6AqTayi6V6fXvYzSBNisqYPgi72x9tqS51QIMINZ50AbTnWudfcoGx
krCzDhwGe3oLzrceCDGLiBcmTu8pJg==
=anpd
-----END PGP SIGNATURE-----

--izx6zmq4uugxibrs--
