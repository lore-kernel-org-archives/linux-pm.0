Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8441449EA8
	for <linux-pm@vger.kernel.org>; Wed, 17 Jun 2026 14:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781706465; cv=none; b=aF1J1m9T/X1Ekiju6juX76rvWi3kRXDWVETJN5o0mq+KpnAhXPlTCb2dlYIa7yGhdEdfNaAs2prKxcD0QoJa9t+YULk53J33lH0kdMdvE6zIIMWCE+IXwlNCRWNQBdu7Jqr5/Zylxe9OeTyksjGlTsMVhGMLpcOApEWAkkY3cxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781706465; c=relaxed/simple;
	bh=Z3UHLEz+y1SdtaertQwQQoSqSykYCh5B71oIzAAnEIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3QGk3TFJDwbYfoq44TkWHXiqIDDJUWV4j8tuOdTK+Ew2zuYg7FJrxZraxyx7Zf1a9NCsnN8HYsCwLJJrXJT7oBH6cfgbjXHvxvarO8ehvJ+P+ZAoaLR9tw1H82S0Gpup7n73kDxuxe2PQUnajX8OOV1bB8ZwbWj7jdMGRQonwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=T+Riabok; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="T+Riabok"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490b211ee6aso44459945e9.3
        for <linux-pm@vger.kernel.org>; Wed, 17 Jun 2026 07:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781706462; x=1782311262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V9sraqOdRVmI6MDGXZxWeHpZgfbvpy2FjfTccr96thk=;
        b=T+RiabokJTYURPfkAqThUAzk1nUoyswka/lcz3Rs9E6JG1wMCtdeFymZuFhdGad8jJ
         +XjZMruAmB+9pT4lBF30Rb9Z1I51DHJHK+e/7a5mdaLEOiKejRr/BkbrAy1jmBvuPGOs
         8p2qLLZODY7sTnym7My+AaQgcCcqWc5fjCfBf5r6cLyk/QsFl0D+JV0NBmUF0cQXQJ5r
         hXgmzmbx7ZV0/18seAhISzef5JkLjvrEg22FnVsB9hU1mw2lFJCpXNz9Cq2uz7OYGNA+
         mvytZ4kR+ELqqdl4sUaL3/Rl7m2ISgl3ojQudLsm17mbMic9r2CkYyowpvsRRIxbKW02
         RvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781706462; x=1782311262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V9sraqOdRVmI6MDGXZxWeHpZgfbvpy2FjfTccr96thk=;
        b=KjwKFPGrClwGfjX1/DOx2huza90rkQisNRFRxQ7Kw5X5M2DpBkiwrIYz3nTyhW1vOE
         IWgZBP7IHBetB/CGQ8lan48Tlz23iC3ZTA80IjEsJqDRyElaGf60WlV9Y7nGJenwS6dO
         NhuPOp39GL0DQjLvobuIBZpvbOCucspqL1aLw+pk7ip1oR1WshLYnW1LfcxBVusWu2fy
         u1PxMbSdOhH4ZPoi7TZ3ks3HhKE7MD8P+uMcDpWroNfA7+178MojzZG9F1cMmMhYPOoM
         JzdcxfTsC0e/MdHY/w54ao86pvoTlcZhSRdCrL9ev6PW3ITSAXGe2+G2bfAADGEwybf7
         z6Yw==
X-Forwarded-Encrypted: i=1; AFNElJ+NsFG3EbY1YHmXMNIAy9+WviLEWItYgyIfvsSA7gistHdUIc3ws5gX1t7bh7mTZljQ8VnrltSHVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwE/xzK4x75Gl3po0uWADLNyvvyCv9EwjKKMFhyF8YHuHSulYgC
	IOrfbwDQLUrVpQvsGDAaEgPQ7VCO7bfr8BClueWv+YjZzNZm7+6/aeASgCTUAd1b2go=
X-Gm-Gg: Acq92OEeUk0QUrse1e03y0VQk2GbaY4iG9zhC3fLZsP1FuZDgfHwCiLOKZ272Q+I57G
	JL0KVku5fETlDgU9mlU1A+AuUlreDfJmvwWCNj2pJ/I/xfu6/Kv1ux1xrYuLVwI3tVv0qiu6Qct
	FnC7Y6360NG8rgnaUEn8I2d3SpmEw0f45/Y2wiFU6oDfFX4z8xBho1QUdTgHSQkX4V18zw5mX/Y
	XG9LOWaWo2OqSV/mNH084J8WnX9/6lYX4ZxipEblZns0OCU6xRIfAfyubESQ7kIKyM6ejQ/YXZZ
	D7F5BQLHM99qm0L8f68vr4jFaZZZV+2LnnM/3Cli00EYdC20TMIocN8V5cSXcAIFtvrf0okVSBy
	HuO+N7Cfax2Gb7eQXOjnZZUWnpHidccQOCsgiDRvHQCLv6CKT4CoXGufI7UpBYVyayBN2BwpveO
	q0Zkx+pXOcqbP/ITRxjl9JjeJ9iL3CdZtVFg0RGffLlXPOhQMUZwgjf0lGHrP186kKWxUi1KowT
	EL46EjM+7/fsgU=
X-Received: by 2002:a05:600c:3b8b:b0:492:33a8:5499 with SMTP id 5b1f17b1804b1-49233a854cbmr77052255e9.17.1781706461860;
        Wed, 17 Jun 2026 07:27:41 -0700 (PDT)
Received: from localhost (p200300f65f47db043b42891e8adbe9a5.dip0.t-ipconnect.de. [2003:f6:5f47:db04:3b42:891e:8adb:e9a5])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4922fa890d8sm182900215e9.10.2026.06.17.07.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 07:27:41 -0700 (PDT)
Date: Wed, 17 Jun 2026 16:27:40 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, 
	Sebastian Reichel <sre@kernel.org>, Greg Ungerer <gerg@linux-m68k.org>, 
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] power: reset: add MCF5441x RCM power-on reason
 driver
Message-ID: <ajKuoZQxRxp4ARDa@monoceros>
References: <20260607-coldfire-rcm-power-on-reason-v2-0-d0039d8a91e8@yoseli.org>
 <20260607-coldfire-rcm-power-on-reason-v2-1-d0039d8a91e8@yoseli.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o43i2oqf42myx2f6"
Content-Disposition: inline
In-Reply-To: <20260607-coldfire-rcm-power-on-reason-v2-1-d0039d8a91e8@yoseli.org>


--o43i2oqf42myx2f6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v2 1/2] power: reset: add MCF5441x RCM power-on reason
 driver
MIME-Version: 1.0

Hello Jean-Michel,

On Sun, Jun 07, 2026 at 10:49:53AM +0200, Jean-Michel Hautbois wrote:
> +static const struct platform_device_id mcf_rcm_id[] = {
> +	{ "mcf-rcm-reset", 0 },

Please drop the 0 here (and the , before it).

> +	{ }
> +};

Best regards
Uwe

--o43i2oqf42myx2f6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoyrtkACgkQj4D7WH0S
/k4HWwf7BWoWJEnsDOdF1eUd+yk0k0Vk7VN5aFqkdSwTdLhR603P2fSAN0RU2OWO
vZurzDc8U9lu7TyzO/d9I8eu+OjbU1QF46pGYJg9CHBYusTSmvrQNAG2LxjyxkX7
mhqfLCgOclh3tA3bcp8QEzALPxv0CyBKoZNAMUQhcUACeZL3Sdc0Pq4KNIHKnHjF
9XnUbG0SI/RsR/6nsBzXIH9cjTpY2yYt4RP50zqG1IKnAU2Z7asCHK34hO7mKp9z
fHMbgzLlZpGjFJoY830x8A9keoqRl0e8WzJt5JyzgJEj5qclK/RSQkUssSzU9anW
cwBO34/pyuJmx3yWFeohpayzJ0ithA==
=BRr1
-----END PGP SIGNATURE-----

--o43i2oqf42myx2f6--
