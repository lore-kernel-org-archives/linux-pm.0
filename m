Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794551961;
	b=Ljymguzcf05M4Anjy5qdu2W59c2eBxHfsd6qW1FBdhYYJY44HPy63e1dPZ7B3LAW1o3S
	 UhSVjKeCqqElyvuRyoVG0LJv9molTPd+gh759oskD5x6vjp0XpaHNXWZ2CulEU9/LCKuQ
	 NbeeEBETXcY2uMm0DUyDPkblsnqwJp6vBawiiWJ7hA8MB7csHdZk5Et0wo675f9LpuaeF
	 D9J77lpu6SxXVChZNt/rFW3QwX2+6Lem5f2hE64755Gmu3dBMUoczShbfzhVyTHQQQsp2
	 Yf801bZvhmiK5huwh7DT+jNqPdOPHXHj8K4fB+T03AzrFzhdvl+zugO7QOjWdW4Kp3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794551961;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=9PYy+AI7ISaofzRlAmqw/89jmgnLGap/scippqNlemU=;
	b=mWXfQaUQBYn/mTDuy1whRwFMl7WjCzSUqhlXysiuNVhu91WYggxje/aNQfLQFj3dReOL
	 0BS8Uw22Z8czNH0k66UcS0FVAeIFiWVasr2Oqmr5t4v6LwkwPAWj46M1YFD1qcEsHharE
	 eOACZG8/vDwKx/KPXQ7R12/+hu/CjH5gyakTb5RYd8iVIXnDtZzkNV2uJWuf6Y9j4csBu
	 VmgTUOvWTfCT86LL9kZ3NO5vMMuVZaapLqHRO6/eKeEQLgDRm0G+0oSfT/b/InJ9o0ozd
	 kzC7ZFfxaJqiARalz5iownsdHb9pDbXbuOWiYAWX+Z+kq2pV2PUwJtUZmw+nuaCQ/5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=EZjagDXF;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DE0606A323
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 06:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00DE0606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=EZjagDXF
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a210470b49so3938185e9.2
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 22:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794551959; x=1795156759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9PYy+AI7ISaofzRlAmqw/89jmgnLGap/scippqNlemU=;
        b=EZjagDXFCK0Lo7oDVmBW7cCcjuCk8KiSMHEydT/OlW8HQAD9HiP/sZ4CU7ohuoGLfr
         QkfMqAucR9MAv/tDzZCLc8MYXF7BZamqo+8spP4P+QZnOHR2gR5RYC/ujaCRkjQcFB0I
         gYuLaSGsSnwI2oervcbwErgkqd2v+6vyjGSVXv0txkhVC3BUq3D6MyCBcjmU0LsWI7mk
         r0zNwasI9g6yncFSdbs+7hzh2L9O3N2u/gis5qnQOChwAxfJjlK+mxu52KVzJAObVuMk
         SA5ae+tCgmAelr++YsRnu2zv79byx93dzB1hYoEM0dv2XVJmV+N1WubJCaViWnE1GoRb
         /qDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794551959; x=1795156759;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9PYy+AI7ISaofzRlAmqw/89jmgnLGap/scippqNlemU=;
        b=YexwllkRXt0kl5KEJNvGtL6j8MtIoZozZImf5wI/tmwfLGGSpXTf0HtOWhd3wykSWN
         xzBAAuli7lHwQgkchKonqyDgyJ5+9gDyJfu98KRCF8vLH4cdH2Ndkv6GrD62LH5/fX/C
         OSd7dZyPRYNsFR9g+N5OB96zmLAXsv7z5pwGveRe+S8H1GvwSOSg63fXFdKPAScBb49P
         wsfivWlRSe2HOfCbLSL0v9EJw1MPHLIRPvgpqOY7MxrjuIibfXZHWn/thzz7W6zFr0Wo
         jwh97nbqHaEHv6357gx/qMfYm3Elfyi78w2aEM0Z4pXyC25OVnx4CAqJfP2kMVOgiadF
         LsQg==
X-Forwarded-Encrypted: i=1; AL+hErE6T7NGIQYtpkMg3E3XWI3WBq9m2fbyFZO1d9MUI2/TZRx8mC3aBsGAsu+MbXsJesRFGJgjEIkrhg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/E1bmuGA2jzl8U3CMvmheIGrVOerqpFus8Xf6AhmtGDVp8srU+
	bjTNm7L4nv9ctheFRhhr3Z4XildAXBi6V0EbhzdrM3JO7ATY8tJ+f8m6cWR1b3Z2XNM=
X-Gm-Gg: AYBFou2aoyNbRS1PMbItMn02O6MjBMJqsx0i+C55DnOia1CMNGok9PnYVUf5ZzsKuyi
	yyxKFSIKycC2lQ0TsTbLnOLoM3M5IzgWdLbaqIuFVvOjtRpuBAL0Mp1nhbcahMfiAp0wD8gP1yO
	UdkELkSMtJrp9iPacW4Zh0OWAiCNkgj4d20hYYgOPSJrPSqYs215EtdjkMrpIIVILD7iT/KUs8y
	6tsGFX06qEx5Ch/do5hETZroU7sQsnrW75MCcyza15E80aFCqlGWI2Cp90fP0Zxgsr1D+/OUBQJ
	EefmAlvS4beJfOwOSzWqmkSOzLGiEYImJ3ZypQzhT3JynGXFIF90KOPsI23Pok0MfPVL1VQeKBC
	INJTI6ZfOFFi3tZp4omb/nBysgnYXbg/n7Pq4HRkZ0A7tsNOApFtnt/wUGD85k1GxS4b2+i3ZPz
	YsvFXFNCAfxQM2ACH1QG1tOq1U9Hl3lpJzQKE73VVamIrIPr3EX70LszvkzHy0bHNUKt++L0H4/
	illZ8FwxV2GPnikMu8fiiK7y3jqvr7veRbmG7DPuimWYTMXYPLmE6VuqMDjjmxL3kHxY6p5P+XM
	8siIw85px5VgMW1hJVMP9VPDkK8DWssBq9uu9pyPaNTdAOnE0Jm7GUqB
X-Received: by 2002:a05:600c:c105:b0:4a2:150f:1613 with SMTP id 5b1f17b1804b1-4bb55a66006mr23009675e9.7.1794551959351;
        Thu, 12 Nov 2026 22:39:19 -0800 (PST)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb4e294420sm121574605e9.9.2026.11.12.22.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 22:39:18 -0800 (PST)
Date: Fri, 13 Nov 2026 07:39:17 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: korryasdlerto@gmail.com
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] power: supply: Add Silicon Mitus SM5714 fuel gauge
 driver
Message-ID: <avawPqDGPEYPWTEg@monoceros>
References: <20261111-sm5714-fuel-gauge-v1-0-b9d163fff6ff@gmail.com>
 <20261111-sm5714-fuel-gauge-v1-2-b9d163fff6ff@gmail.com>
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
	protocol="application/pgp-signature"; boundary="2r6ji5mtzotwcfxp"
Content-Disposition: inline
In-Reply-To: <20261111-sm5714-fuel-gauge-v1-2-b9d163fff6ff@gmail.com>


--2r6ji5mtzotwcfxp
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 2/2] power: supply: Add Silicon Mitus SM5714 fuel gauge
 driver
MIME-Version: 1.0

Hello,

On Wed, Nov 11, 2026 at 05:35:00PM +0200, Asdlerto Korry via B4 Relay wrote:
> +#include <linux/i2c.h>
> [...]
> +#include <linux/mod_devicetable.h>

<linux/i2c.h> already provides of_device_id and
<linux/mod_devicetable.h> introduces a lot of unneeded build
dependencies. So please drop the latter.

> +static const struct of_device_id sm5714_fg_of_match[] = {
> +	{ .compatible = "siliconmitus,sm5714-fuelgauge" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, sm5714_fg_of_match);
> +
> +static struct i2c_driver sm5714_fg_driver = {
> +	.driver = {
> +		.name = "sm5714-fuelgauge",
> +		.of_match_table = sm5714_fg_of_match,
> +	},
> +	.probe = sm5714_fg_probe,
> +};
> +module_i2c_driver(sm5714_fg_driver);

Don't you need an i2c_device_id table, too?

Best regards
Uwe

--2r6ji5mtzotwcfxp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmr2sJAACgkQj4D7WH0S
/k5y8gf/bVX1KSrZP9ZVVaVPusWdsCZBWZ+d4JVqPpF6oSNJa2Q6ZDZ/OOo2nKxA
a0dM4DiFeiMba5iq/37djbjc8Rtubmpul2v7hZbj4p+OQ59Lopm/9e79YCjrwisZ
SRdXQ6vG9oelZv+uR2YGT94QVjqw4Fq+Cd0VuqlhqL25l9rkhuNWkEWSwfRPpnzp
voMo8iSpMRRg/Ty0xDT9z4iZPH2UG5jxKJ4seN1PLOfOZt3pYo+9Bh97hjZtIR1j
R79pD+VSw+OP7i+LbFRMwcZ9PHPqSrHZB+av72B+gMfP+GBItgYp4seVLJceH2pl
FZfM1hdZ+icIbbO7MFyIhJRCKJ0amw==
=+err
-----END PGP SIGNATURE-----

--2r6ji5mtzotwcfxp--
