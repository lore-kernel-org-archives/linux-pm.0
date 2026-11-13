Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794551230;
	b=3O/mF/FgnKkAJivQwqYw2onQF96aO7IAN0iLV6qWPNKdnbDwwrGRh7PdIhKjVlBNaEf5
	 g0nW6mc0UyXr5tmQf4A9IpdbpczlBBD9yqMXDfmgBuqqmsMuE/Fe3ND4x56fVMm5gzZFE
	 xVhEAZodiNvjFH6gIEGraFRw/Qb7o/ypWwst/mutI60iTG3wzXPeZ2mCBReqghJYvagIS
	 ff9VTfZsqoYeylewMWfkXZwcPVDdcNlmrtvWVSF9RMlNQSTeZgYxFx6pWATzflWVQyovb
	 exhtACwzQ4FlK/H3L/evHgWLmx0HGAsq7vMFKwqeCL5QxS0XrO8EWZL7WEbtMLsHnRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794551230;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=XltNWiKtwG9iBw8+GH1SYk3VMgJFEJVDDOL9ejVnQFk=;
	b=b1Xoc1WfZ+fncRBJz0/QnY5SL8T4zh7GgQpcWS9UxnP2e+8omT5zjrhu4oPgiHLHpcVR
	 AYqQ6pIywkwI2HWSbgPZWFlpwOhsPuq+FaUeyquqjQ2TAQ4GR7QGcnhyg5KLPhqsSAw7G
	 1qOgtZZSQUnxqnFLvHc3TPVhY7XSagigHEN9CojKwgiz5LCV3NxfwvDOv55qPUJkwosIq
	 jG43y0vLjKxinCa36bLj+YgOOnE1f3wuWsZHao/7Bu1Bv8G+RnB8oh3KDS5zhA9sdydSg
	 kv8gvM8AEG77S3LFXmVjfWyCWHDxybw8MP5ZsCXrSRm3wQzLsrF2m9IinUPhkM6KDag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=MUvxZhYm;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B451606A321
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 06:27:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B451606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=MUvxZhYm
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a59100fa83so3681875e9.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 22:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794551229; x=1795156029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XltNWiKtwG9iBw8+GH1SYk3VMgJFEJVDDOL9ejVnQFk=;
        b=MUvxZhYm5+xi+SJfP8nHhsZ1GXHZRgKcmtYpFlDoXTjjRpAAhHrxK/sL0p5zR3UDxZ
         zoFe6J+qpK86Rz4t3v2DUKvCLnSK0WziR5goLmM6ybJ96s52a7n4l6ssjhqsUYaR+Jm/
         Xs9hOLXj9PE+uwryRlkvLuERCrqJTf3zLvvS2FCslyTZTd9wswIAMULtnwF8vJn7f2H0
         3wTzjD8Hp6/wsmtQJ0eNgdgUe4JwuhUhUM8UnvqdKeyZwp2YYRSg+jZBqsj6tEhsE3zD
         Pz/u5C9YRb5rfcke4Gy7OJXnRI/iCfjiVWknhEe2HE/M51peV4kwHUDOt1TkMoov2shs
         xFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794551229; x=1795156029;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XltNWiKtwG9iBw8+GH1SYk3VMgJFEJVDDOL9ejVnQFk=;
        b=VRvt4bdgmiYIKZ/zc3o1npSjNnRXLE4HF8rNrZOyDiyH3hZTJB7nuOgw+WMq1U8o9K
         uibcskhm83+jGqvzKH4lK9JAUUuYaduU8SILrOEfZPL7G1fNEjRUst1twEObyZZzwLy8
         iYzUfASixPLfhzybwzVso+lFd/UXoBi8eeIrsqBYaESrRuJK5fMyQRTm9JGeHXmMq/GX
         sQOfYofXQXyv4rya37E8+iZZw19uwt3SHPA2q3WJth5+uQRlXRb1joaDFb6a+K2ZT6tL
         5kANgw2FgabaN6GylnKdrEMqFvnbrdNTwgyjHtu7A/bDoPl5C9QbbI/ZMPT2qdEywiOz
         KSmg==
X-Forwarded-Encrypted: i=1; AL+hErFhWzh0g5Pi+1vgvBmHHpW2O4EbiuDmi+qdVJivwlDbysHLofQLdqI6wSlsKnXt55UxJUNrK3F7NQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9bHD8cd4X/ITNiuZ6nlvsWsbO6/xsOru8BUWJkiYYupun46XzJ
	esBUoLJCsZy6QIzO4AkB5FtYHPCw4+jh1QhJxC4y3MV1bkgjHIBLDqJQ0Il5OTKJpYY=
X-Gm-Gg: AYBFou1OXxrF0C451eCbhJH8sP7+e1f3MAi6g75oC1mWEJeilxWUXbr9XPa9y+3cxTV
	9+ifl6YwR6ABlz9n+/EVt2DYYAuhX9xFOTXK0HhQt5AX9vB3kvNK+XrLpzYkjEBPfe8WeB8kJUY
	RYHiQmuMYHu2wsgNLsLjyTJohq7Q0+9DCbeOpO9HYgQpyTHtoX5KgF4FyplwY6cScVDddkuhu4f
	brCaHBoEfHLwvAgMQ2JyWVSMVy8Cu6NuDFYmZjkossjI1/L7cwpz57De3KRZ5lSR0Yd8P1XPoVH
	nTe+5ol09nRTFuCcrux4J5ex93uIZjTvMuDjuVH37acFbZi/2fj570PjuAw/O8lnW9Joa/d35ac
	r59KI3AakYzjjVCS0pasLFGhyyINTVeL+1kKuOynlTg8CWSz8PPK/72oKN+4A3owRn21KrB+kEi
	jXDmRnT3x63V3rtnQGRtijCqJfyq+lbp8Wbgl/DhZ+K2GQcWRoWx5uLGpzMf+HXvFSiI/vdRltc
	h6LLZPqTcyOb+fn2Fc7E6r58R+ZcMt300mNvcc6kROoEzfDlxF3ZVcz7tMpoHCytnAS3y1C0EGQ
	QxLjKm307+eZCgYnaoihQHvTPXI2ow6+BHchu3v4YzjukZElPrgie7FVeFA02Jb1t5roKHHIyQ=
	=
X-Received: by 2002:a05:600c:4ecd:b0:4a1:e6a9:4086 with SMTP id 5b1f17b1804b1-4bb5599a73fmr36037725e9.0.1794551228841;
        Thu, 12 Nov 2026 22:27:08 -0800 (PST)
Received: from localhost (ip-091-089-005-024.um28.pools.vodafone-ip.de. [91.89.5.24])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb4e29daa5sm133039875e9.12.2026.11.12.22.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 22:27:07 -0800 (PST)
Date: Fri, 13 Nov 2026 07:27:06 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Val Packett <val@packett.cool>
Cc: Sebastian Reichel <sre@kernel.org>, 
	Marc Lainez <marc.lainez@gmail.com>, Luca Weiss <luca.weiss@fairphone.com>, 
	=?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>, Danila Tikhonov <danila@jiaxyga.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, phone-devel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] power: supply: add Qualcomm QGauge (qcom_qg) fuel
 gauge driver
Message-ID: <avatRCrAgoPjV7rP@monoceros>
References: <20261112170841.2189322-1-val@packett.cool>
 <20261112170841.2189322-3-val@packett.cool>
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
	protocol="application/pgp-signature"; boundary="mwyna4jkd5v6s5iv"
Content-Disposition: inline
In-Reply-To: <20261112170841.2189322-3-val@packett.cool>


--mwyna4jkd5v6s5iv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 2/5] power: supply: add Qualcomm QGauge (qcom_qg) fuel
 gauge driver
MIME-Version: 1.0

On Thu, Nov 12, 2026 at 02:07:28PM -0300, Val Packett wrote:
> +#include <linux/mod_devicetable.h>
> [...]
> +#include <linux/platform_device.h>

Please don't include <linux/mod_devicetable.h>. That introduces a bunch
of unneeded build dependencies and of_device_id is already provided
(without these dependencies) by <linux/platform_device.h>.

> [...]
> +static const struct of_device_id qcom_qg_of_match[] = {
> +	{ .compatible = "qcom,pm6150-qg" },
> +	{ .compatible = "qcom,pmi632-qg" },
> +	{}

Please make this { } (i.e add a space) to match the most common style.

> +};
> +MODULE_DEVICE_TABLE(of, qcom_qg_of_match);

Best regards
Uwe

--mwyna4jkd5v6s5iv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmr2rbYACgkQj4D7WH0S
/k7nbgf/b6/rA4kIW1NyMoOtnNVBeGIHHHNfMkct33HHb1h0CiT6Hd1RLEJ6HH+F
sW4pjg7G0QStID55MbOeFsfsHKUaOEsaLwutZ3fATturnz7k7RZRvLfAjNtR3k18
hiWFbFdsTjH6SuQ/g7OijXpDO+E2v/5FHg8g/V0U5xwL0w4sWAME2Gxrc9Aed+1Z
yb1H38UcmdaYkNs0WgAyYt2rGVtGDyt5nQqLm9gBfrCvoxDzCIxgiXJ61C9JMF0t
UIk/sLbujBcPF2qrtmodX0CUE07kBKD7PV1TOWjB7Gcz+f3E/X3eQGPNNOk8mEQn
pqgA7hr5DNGO6zRenFbDHgtssAhenA==
=HgBt
-----END PGP SIGNATURE-----

--mwyna4jkd5v6s5iv--
