Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795607024;
	b=MXhgLaJMYUpbsGBfpJ7RXI2RYrC13oj2bG+uGr47VaYFLpQ4dS2Nx38D+6yqQMMxmUqU
	 tDyCQndj81gn/xFOfgZFk6qmKG3Kn8elhPPcv2ptPlZA78i2ex8kNjK4lUpPjqE5Ij87o
	 RGfzj018URem2xmC9OEfIsakFpb/ZKeFas2L/NfEuV1+kfLL4QPz2UyJOXwAdNQLzINLz
	 xBiZWXMaec+pG2Ile9FnnaxorTpF1bvqd1g8BZN1EmP4YjjWpdQqJedws9XSwoBBV8df5
	 1NjDtUr2DAFM0t/HZB3tAFIFnEiR+qt/NvnNJwHIMsemtZm8wGToEqFtW8jeWdpfU3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795607024;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=orbQl2N4vlIOWiLrIf8SUWQ1uKxLJ8cjnJYad+kaD0M=;
	b=aRtQYm1fUkSDVUYORr91/nMMjfluYaNwrfnFDUh0qe5kSdq9blTBopfZ7ACg8c3grycH
	 Q23nfSOtLFR9yTEvH0hFk6qbjhape9hTTq4nFn/jstzq8WXbf6SG07FMjP0TKN6o8Cr+F
	 n7YPnw1KDnHhwWvxfU63i1U5wDUN3bZ1AlylMO+hVIbsN2C8BrTGBJHZU0qPUHsUXbzp3
	 WOH5tdRIXmKP1wYqm9FMUCS0LlQ0YT+oorUtOmK3gkBGC2R3vkBhPeg6i3IjycRkli9h5
	 64EXGeXDubiVLxAygKQCSI4MV54ZPM2xCa1Zmc2TZ4blYoYupWcg8liMfNhuckG9MZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=CMRkec4k;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3F2606A682
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 11:43:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F3F2606A682
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=CMRkec4k
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4bb6ba3b244so58025065e9.3
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 03:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795607023; x=1796211823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=orbQl2N4vlIOWiLrIf8SUWQ1uKxLJ8cjnJYad+kaD0M=;
        b=CMRkec4k5ljHKroiikKHK4JTT+TkveMrUsH8OoShvX5KDi5dPTXWqpP2Mbk0Pfj+6J
         Er7ZpXo+2y75226hO+joL+YszbhdM1NRWuxPLKAyEB8pQpjz1DidQalEl4a1lQ4YS7ED
         PL4+0pNUumQ8wO10YMUGsK6lehpVDiG+BMkjoy4YS4BfEUqBSeD2540gXMl05mjpyHvn
         Z6XMOy1+V20r7LVyADNHTgzJf7i9eoIe0AWaBGIGdOli5cuI7uHYFKWZYtWm8k16wUcQ
         m7ZJwnhUp3g4R6xsVYm7WvLZ4+yPkzw5DHQ8jmCE/dx+daeVXeaBXSP0HABTudNC9Z+O
         S0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795607023; x=1796211823;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=orbQl2N4vlIOWiLrIf8SUWQ1uKxLJ8cjnJYad+kaD0M=;
        b=ymZNm5p9xZCYbMRihQ1WKbfHjCrm2PR7oMkD6m6OyZVlANkJ4K2jO2WE6XkxNLXhhT
         t1hJAOEd89zySSiWjdZP5wwBp7/PrpJT1DrOIZ3Prpa4TDHOp5ZWIaYrtgB7vwflmEj5
         7EN7wIIaeXg+BwxKtAziomRko/+xKkVJ9m299yWu7US+8BhD+h1rVEQaJ3iQiIhGJZyF
         /FWtUUm50ENPUWD+50NrbOlfc+I7PHOFYwfvYV55rHdzlyyRT7iJTQnyBhW3FdbDG87s
         XmAg0z5f2tCzNUI+krYzDKgQQEITRhdXEStkAsvp7vO3A1f8JxDC3PnVvRwbT6xOdE7x
         daAw==
X-Forwarded-Encrypted: i=1; AL+hErFLvsRJyhAeRm3MHyuBpUeIiShumPVX2To8w8+E8knGEKsmmogFnSu5sU4aNgFIIz0LJP6+ynGTmw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+QDNIFwqSaNZFMD+N99Q9tsKEOr3Aoc9tVlLA+d/LZ9P2L2OHE
	o0+mhxShF18r8sKHXe1kHSImd20OfOsX/n0ANchoDfhmFuLBpC8Ndz2aPrfdWEAzk4g=
X-Gm-Gg: AZFdTZcb0mFfDuyGwS3qL70P3ql7dfRJcfEDOaohy+/rMaxY7mfK14ve779yN93i5e5
	XQ7wPhiRy9oLezCgFE3HVYSrJEBCskhq9htakQPGOXQuh2qczIKVhdkNkwYq68/cO61sUZKS7p5
	Npbt/UfjR/kry69ZbPzHc3ly2Xrl2TKCrELgE1tznCoRPm6ydHcCbYnsdl2s5Xskm6rJZQU0wg8
	/SwZt8/WAtvWBUv+nqzXfwqnmuZKybcTqQdQ4mDL9AciMRc3s1XmC4vWXQ9ty2tXsCtt0Qsksdy
	63hwa2loeeLEwVa1NyYtAC153IvsImosbnO3O3je6jPDaPidY0X1dfiGwEzmeOSfV3m2nkFwh8F
	kriEzzoe+QkuzAlawzNzUWV13u8rp9QAYo0yXodEOhzLNfv8fscKyPZHCMJNoLQXsBglm+CIcwT
	fduH78kMumetfwBkP0tE7CvnMm6OEezgGmdKh0MbkkdSEgxSusMTuoCUBptHtEvNKsJchTazeXb
	Syh6nG3Bilb7RekCRW8HQkx2slb4ejb74/oS6B3Xjz/SWp9G2u0uncPWOiFvdPR9B2zxkIMzXWT
	IB20qnmKySkwDzMiizW/PYPszvKa6qhhi217yhANsT8kKgWQWhMcHO0DJqZTEbCqcP7X8ph5CbS
	0rR8G8g4qiuxvUf2t
X-Received: by 2002:a05:600c:4e0d:b0:4bb:69b2:d3b3 with SMTP id 5b1f17b1804b1-4bb8881eea5mr364570665e9.27.1795607022789;
        Wed, 25 Nov 2026 03:43:42 -0800 (PST)
Received: from localhost (p200300f65f19a9043ef7230869dfba63.dip0.t-ipconnect.de. [2003:f6:5f19:a904:3ef7:2308:69df:ba63])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb884865a2sm527753115e9.3.2026.11.25.03.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 03:43:41 -0800 (PST)
Date: Wed, 25 Nov 2026 12:43:40 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Brian Norris <briannorris@chromium.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Thomas Gleixner <tglx@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	=?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Radu Rendec <radu@rendec.net>, 
	Jakub =?utf-8?B?R8WCb3dhY2tp?= <jglow@google.com>, linux-clk@vger.kernel.org, 
	Douglas Anderson <dianders@chromium.org>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
	Mariano Marciello <mmarciello@google.com>, google-soc@lists.linux.dev
Subject: Re: [PATCH v2 5/9] reset: google: Add CPM reset driver
Message-ID: <awbJUwrBQw5TnowW@monoceros>
References: <20261125000349.3385325-1-briannorris@chromium.org>
 <20261124160343.v2.5.I0b1ad34a718a9b5f667d2481041970ea45989dd3@changeid>
 <f89e293688feb3f9bcdce0f1b6fed0ee424e5cd8.camel@pengutronix.de>
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
	protocol="application/pgp-signature"; boundary="huwbq4lvetfh3uwf"
Content-Disposition: inline
In-Reply-To: <f89e293688feb3f9bcdce0f1b6fed0ee424e5cd8.camel@pengutronix.de>


--huwbq4lvetfh3uwf
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 5/9] reset: google: Add CPM reset driver
MIME-Version: 1.0

On Wed, Nov 25, 2026 at 09:48:04AM +0100, Philipp Zabel wrote:
> > +#include <linux/mod_devicetable.h>
>=20
> Please include the specific <linux/device-id/*.h> that is needed
> instead of all of <linux/mod_devicetable.h>.

Or better still, rely on the bus headers to provide the needed
*_device_id structures. (That is <linux/platform_device.h> provides
of_device_id (for patch #2) and <linux/auxiliary_bus.h> provides
auxiliary_device_id and of_device_id (for patches #3 - #6)).

Best regards
Uwe

--huwbq4lvetfh3uwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmsGyeoACgkQj4D7WH0S
/k7XEggAlcj2TrM3p6EXOwI/xsUxWXF252CxwyEWI8ZmPEpI6bAu6Q2vo1jWzU80
RgNMuXczOoZoJ6+hJdkMeoqHuhp2FPvl718ZM9+ZXmIzmzCoBNWIn7I/StnNApVp
CRTaJoMc3RQ58/iAEYs4Bd6kNCpJoojOnWxMnprqZsXFWDmYDOaKauDIqnRyeGSd
Y/roBTL3HpvnWDZxm7b51fG8984ltXAM06Db+ZRdnLxyged3B5xdXwcFGLlqeoKG
ti6pQXYhQnxuxJFTg8v+DdOAKp8wPe6CkjTN92KfVvWDgxJYHe7zwZ1V0TrgDqMQ
p3mJ8Bmk3uxwBcQfM5lzAgDW6N8h4Q==
=fqd8
-----END PGP SIGNATURE-----

--huwbq4lvetfh3uwf--
