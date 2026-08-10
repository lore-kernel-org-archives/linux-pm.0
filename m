Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388973AEF46
	for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 09:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786354685; cv=none; b=rVfdxzrxeFAvfmIB5xJMeYTAFglRSVxZSyGTIfHLIWge4/F53BZc6+P/GgU9sdvFdb1HM76MuPbXrKJidMQZUSszQW1Ubkol9fW5I2yTpTqP//FpzjY3y2gX6fDkqX1+Io03AqBZmKOXCMUtqq+UHXBM1A/v6h1JUgSqUUnLYqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786354685; c=relaxed/simple;
	bh=xIcVYX0/9wf5NDk4ZC0V2d1DNB2jwH5MbDCYWw3Ll+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mcgrlJ9W7vCCXr4VBfDZ9sRfjV9qoaUjB8udrmkSiFBkRgCAIgUmesXXov6MBTcEw598K/Yd7HsJGnbJU7VI0ZHGIgAwVeorCmXjJ74XGt02MC7J5e2PPCEVGkqSXEaLa+CfTYMtK9cIhDu+63hT+jlTY8K7jpo8cgN0IfkNIjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=X7WQzG3z; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="X7WQzG3z"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-480001972b8so602933f8f.2
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 02:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786354681; x=1786959481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xIcVYX0/9wf5NDk4ZC0V2d1DNB2jwH5MbDCYWw3Ll+E=;
        b=X7WQzG3zYN2tH+5v3xjFipwf/LyyZ6ev6TwkMKo9w2LmqL1nj5ERVc0V+oitt+6Aij
         m+hcj+gK1FTFvPO8wV4Ooo6BiUcfmlOtIqrJUTn7mhwLJoXddzrEIkKsNjUi+qte5Xbi
         6vbh3HaODe/NlOafSpAe7w990wEUUo1Y14XVCZJMLYo6NK3qnMfRoW1dNxg74ABHEovP
         A++eaPx5yMepnY3Debr5lWfC8T5JvR0DzfeRewSgA+OmlmxMEyRxJYfVrjK22THCl0bn
         9ozKU+OV2/Ph6HLey3EuX5ttzTsjMtYK7VJl+UFs6i2ilQMFVwuGv68h0nNJoKjl2UzV
         AWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786354681; x=1786959481;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xIcVYX0/9wf5NDk4ZC0V2d1DNB2jwH5MbDCYWw3Ll+E=;
        b=Fxc5DfO1ktTMlXiaDt9QXeF075UK0Vv/XDIklW/rSy2x7DnbDhc+GisD9lwUbm+zxW
         ojEH4t266BJCHveR6aWwPaP0KABvS3Y252eq+tqqcaN7OQ3t4Vx22hd2PdcOF8qwGgXH
         MY51Gj3dkvN7Dq3qRYRE6f+0diK0tfLfGFoG6W6WZY1cdEkA8o3+b/aOv4A8D2tqHoZj
         EcBon2WhwnwHlEc6vwGLfsodrS27+LlLvF5psrtBwf6CBq6Fi6L5dfQa1Vmfs4UcwMgF
         Z+7uzPKSOjgwp4vHhmac45S00inKnsU8YYbkWwj3ZekJoQsnKRXiROPuthIZrHE4Pg7G
         phTw==
X-Forwarded-Encrypted: i=1; AHgh+RoQVWLbP2HPmUNau/nXrMNWX+RLGVUq0yT3g7eA4n4HaVvk78GW5yFm77PWCQpBDMos+Y/ZoEOImg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp3lTstGmozCTJmKhuQ1ekBv8egRC+4kKTZA5SRdJLQKUmIl3v
	gXVSO5+Uw1XZek68sE5RzHnBnuCOscIFIYZeya1NIUvIscFLZUCfOi8P0Mg8kg22na0=
X-Gm-Gg: AR+sD12Ju0FMhjWyaI4VR1rvOM6UihD7maU+z0SM5TAmOlfAxXlktOV5lxxySFtHyEh
	Sr931sbraCSKR4g1d6ohHH/h02CcU9uuw0lTDQSvYoyglApnyCsVJSiyTy9qN4QK/dHWhl+/4qz
	MlaZr8aFuNEkgFpnwQuOtmW85MWbHNejKgL5C8RwLzp4ksaLn7kk4mEzkRFqmLjKiIr+a8bsFFg
	qrWEzWWbEYJN7HGmII0Ig+W4bFvzGKZKHhR+cwCcovu+noxriwOoBuxgs0Red2qIQZU3eoogr3S
	bMUkYmL0/PqGBASQ/VF1q4f8kqaUb4d+GenP/Bk2QCQTTxnHpE3s3xXzmyEmtNG4sTiiZxa1QWY
	CTO4vQuPs4tEui5FErbIO5bNGGhYf7mn0mYhtSfoOk+u3zC9M3ItleK5dnTcB+cKhoTpE2Rr2+5
	Pu0cxj3k042vqGcUcYRuNE2TH2o/9ZAs73c8xYLA2+YXRYcdnnFFdOd7uttwld7yv2ftijQihEg
	5EryKW8LMlEOHaKDxSwP0Kr/LamEwWC2PfPM1CithoyjMVvTHru5/JCwpL81ek=
X-Received: by 2002:adf:e194:0:b0:47e:aa3e:e75e with SMTP id ffacd0b85a97d-481455df4f3mr803199f8f.10.1786354681431;
        Mon, 10 Aug 2026 02:38:01 -0700 (PDT)
Received: from localhost (p200300f65f017104988877d75683e2e7.dip0.t-ipconnect.de. [2003:f6:5f01:7104:9888:77d7:5683:e2e7])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-480021e7b3fsm35703729f8f.20.2026.08.10.02.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 02:37:59 -0700 (PDT)
Date: Mon, 10 Aug 2026 11:37:57 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Taniya Das <quic_tdas@quicinc.com>, 
	Georgi Djakov <djakov@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Robert Marko <robimarko@gmail.com>, Guru Das Srinagesh <linux@gurudas.dev>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 07/15] interconnect: qcom: Add Kuno interconnect provider
 driver
Message-ID: <anmbi_gXKslOw0bP@monoceros>
References: <20260809-kuno-soc-support-v1-0-5e0ede4a0c72@oss.qualcomm.com>
 <20260809-kuno-soc-support-v1-7-5e0ede4a0c72@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3xac63pr2vji44lb"
Content-Disposition: inline
In-Reply-To: <20260809-kuno-soc-support-v1-7-5e0ede4a0c72@oss.qualcomm.com>


--3xac63pr2vji44lb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 07/15] interconnect: qcom: Add Kuno interconnect provider
 driver
MIME-Version: 1.0

Hello,

On Sun, Aug 09, 2026 at 12:57:06PM +0530, Hardeep Sharma wrote:
> +#include <linux/device.h>
> +#include <linux/interconnect.h>
> +#include <linux/interconnect-provider.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>

Please rely on <linux/platform_device.h> to provide a definition for
struct device_id and drop <linux/mod_devicetable.h>. The latter will go
away soon.

Best regards
Uwe

--3xac63pr2vji44lb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmp5m/IACgkQj4D7WH0S
/k6R5Af/ZHauc3SyLK+PyzhuAVo8KLioCnH6hR3DN0mwmmRoImnIwhh/fZ8+bxX6
4sjLWVHk3LNdw7myepDx8m5LApUqxoXGF8MFr2ei4fdCiuGploizmUZTp3Gk89n6
i05o9xebgzD7+GHFMl3dkgkR8Dlgwhlkiu/eQcM68rZlB+dcqBWwmTIlNam/Ns6h
DlMcTTmlbkteGx2LreH2BUe4x/5L5HKGnzdEbtkBPY+G/QxvT+BXS3TFwkfblKBF
KvzW5xksFzfP6mNdXxofjZ1Az5JBPefKwO2VaVRTfH90dspMqIqaB4zuscwYL2J2
gYsqyFDe+2fuOzTFDh4IeXloKHG9uQ==
=FHMs
-----END PGP SIGNATURE-----

--3xac63pr2vji44lb--
