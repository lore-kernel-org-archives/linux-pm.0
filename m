Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4111637F741
	for <linux-pm@vger.kernel.org>; Sun, 12 Jul 2026 22:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783894979; cv=none; b=s7AWs1BbiNuncXRDS4SIM+kUFLvUsIkfKV64wR5iofyCv1mmkhy+yGE2SSViIug1zj46ICPDVYSlscGQOH6fj51uP0nhCbtMkUEvCh800l3ANtdD62S0uit345KNwD81VWGWDpn7ueU1F/OfnU4w4homp2V9qe5eoOay63xwteQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783894979; c=relaxed/simple;
	bh=8WRZxD4H8+tY9oaiz5xLvkGilYbPiA92y2Jesbmxnro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OlHjr+xw/L2w/JLT4xJvGYpSjSs4e1myAZB11+Otk0hGm4LjfISoXR2S1D29HV6wwUugncmzuS6UBrlvoJSU/bKuMGHHJm5Kq9XynnD0/TE1yTLxvFMFVTQDFY5nMcRzQ7z9MyP3LCYHEMls1kfPCzxB82C4xcou1omkheTzoNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=nAhAIMZo; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="nAhAIMZo"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47d6c634f45so1288634f8f.3
        for <linux-pm@vger.kernel.org>; Sun, 12 Jul 2026 15:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783894977; x=1784499777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8WRZxD4H8+tY9oaiz5xLvkGilYbPiA92y2Jesbmxnro=;
        b=nAhAIMZo/IvRqATdC2+4nvuMHx8v/2qJHt+WGnwWhoB2TXIYWixQot20r9o2Kl71Ve
         OjeTS1/8o9ZU9FZ0U9+lb/qkfsq0RiND+FlpB/oaOCDe5jn6WCq6+xbESWEaEv3/o+7q
         ZB09SviaIZgOp9H1KhmDf4a+j5lMng0+XN+5lFDzHcHxnP/hXhlkNdQNx9tCF0CXgthr
         /jT4xh6YWYOynhr+KjB00pqQ6vnGlqRDqQ7pG1Q91JpRh49Y256fYjdMxqxvA2DtAKQp
         FUBIKCNKN4SDMU6hE2T1zTCC+Q0BjX0E7Stjj0RUQdT1t8Gv5Iv5V6jEUQN2vp2MQuyG
         qlrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783894977; x=1784499777;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8WRZxD4H8+tY9oaiz5xLvkGilYbPiA92y2Jesbmxnro=;
        b=O7xtaK3l1jl6Gu5beG5KQpjneHhZ2piP/D/gNFiUxWAHI96Fzj/4ZVvR7N/pWeUrQm
         OFNoOBis+XMg905x7Z8m1iaSa0lwpwtq1CAKbnCoSlfMIC7fkP8LKuSLqVHf1Pj/opWi
         q4p9OeJ+xKyMmKRHGsyoRcCHE4fVa8taNhfHObrHU9ckSOJdnQklOmE0D/1dWoYC28Em
         sj8Q01sXAopTUHeKVXBfdLnIqb3D6FpIKeInd2UxxrTnDKDdVFxWmd7JUcChSa7wtbRj
         f91vY4Xc5sicboP++uhujWieolNuPbrpEFe5OL+LO3/mfiXs67Dozh+y4hoWEMvcrkb6
         /URA==
X-Forwarded-Encrypted: i=1; AHgh+RodfbO9SeSAyhOyJpVOiCqYgRgyj7WpiMxKJODjuU6mWrTnID79OlOPF0bO5VRBPICksnFcus10fQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrRd/4VX3NyO4YVLpxIV8ruR27c2qHAqqI/cagX+THIR4sDf+w
	kaGnsM+NFQUZnTN/FKOf6r5P6wMzrJAT6z5wUg9g+vTbydzbkEm5DZJZLi14vEhaPJ8=
X-Gm-Gg: AfdE7cmToVTlseLUy76HeLO8NE9MQTY/9YvCwnsfk8zzb9joK2/fAB9GbYy3r4pwwcU
	v6dTED3rBTIMlBm89j6yR795dSJVtfSJRT2am+0XlUbmFEXjTLsqr985W7nYXvlUPzVyj/hVimB
	ZNO1dUQgnKRkSPp3QgFjVlPXrL7k+OxCYVkRg38RLNghPfcnOsrz3ixwDqrgIZIPN72p9c8sSgX
	eJ+CQKYC8AmG8G74jUXSduoQb3Ow2DctB37d0h1FePY5wY5GLs2s6WjQ6bl1V957yxmtT4ZjCzO
	/2yJK14IOVZxLhMEl1FL+MnkkDNgRNhPC2m9wSM26iv9Ufb3ukMazOTVPeHDqjvXfAGVJelmWFt
	3JfbihggwDkjrbDubd3vYAKtjRLTfSMWARA5MCqtnyRGO036K77mitAnYih5Ae+xLTibbYEE8zG
	SzSXPX5r4nKBbYIXAPoIJc4uazCGCp
X-Received: by 2002:a5d:59a4:0:b0:472:9bf7:2f58 with SMTP id ffacd0b85a97d-47f2dcc69e2mr6731266f8f.36.1783894976653;
        Sun, 12 Jul 2026 15:22:56 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47aa0f213e8sm78667437f8f.34.2026.07.12.15.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 15:22:55 -0700 (PDT)
Date: Mon, 13 Jul 2026 00:22:54 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Ulf Hansson <ulfh@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] clk: renesas: Add R-Car X5H CPG driver
Message-ID: <alQTnZwVRwpVTVUf@monoceros>
References: <cover.1783505142.git.geert+renesas@glider.be>
 <50f5804f00c55cd60604d00da1bf1f1dc912ba8d.1783505142.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ak3qgcbynp5sb6ym"
Content-Disposition: inline
In-Reply-To: <50f5804f00c55cd60604d00da1bf1f1dc912ba8d.1783505142.git.geert+renesas@glider.be>


--ak3qgcbynp5sb6ym
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v2 3/6] clk: renesas: Add R-Car X5H CPG driver
MIME-Version: 1.0

Hello Geert,

On Wed, Jul 08, 2026 at 12:15:08PM +0200, Geert Uytterhoeven wrote:
> +#include <linux/mod_devicetable.h>

Please don't add new users for this header file. Only use those
<linux/device-id/*.h> that you actually need (if any).

Ditto for patch 4.

Thanks
Uwe

--ak3qgcbynp5sb6ym
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpUE7sACgkQj4D7WH0S
/k692Af/VsqjHq8LAyiXwd69+QSwZHSG0U4MEBmnqkTcJ6mPo3Q1tfbuac0TZGpR
buYByMLca9o6W+7RHLvf+/Zr3Deak9AlTYe0KCuPpU7D8l92MkJ9qyU4qaQWyxrI
Hv1YMMYA5G+C8pvTfUspprOv7ql6Xa7cYPsIo3jLpjbhJL3dg7EiCHHjEt/TyipW
XDBbz9nhJzlzRZZzwDROzHctrH75sRADO/UfFjRhtDmkYC4qRs2tvJk7mEMQ9TG0
ZBnRKl3liOyOP0apWQ9wSU/MuVwRJ+l7pTHIihy3BPhzxJM+7fQFIzy3bdjFMWZY
qnwvvfAtAsXvn3SjgrZe5nuPmhpk5A==
=z1Ow
-----END PGP SIGNATURE-----

--ak3qgcbynp5sb6ym--
