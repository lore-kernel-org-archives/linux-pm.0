Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792691264;
	b=epIl4YgenCX7bj80lXJIBJJRP/JrcCY4cb3eoxm0uYucQcvoZ2SuFBKvFzmWdkdj64Xj
	 BqHqNDXS4jm5xI4u+K0ezFa3IriUL+bI1FGFsKIzAIqfPpOSJlP8UYq8BOHQscgZcyXhd
	 TYviiyYMKOE5pxXcCA2HE9m31QrUfI8HPmZrSITQnB4peHWQYy+faO1eznljDG1rtyqDS
	 a3huKgu8CmDQrI0VB5cQT+fYXyZ/Jzg193sRBaKDmHGMtcClm1U6woVmt9DWyfZhgQIVT
	 ykVEvoZ9m1ZayNn8faXDaVimUYFC6JzjUyvWmO8FvZnaqOhbRDFyQD0xgnVI4/M7k8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792691264;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=SCWBGn+DbuJPekfhEu4uXLYMGCLHZ53aEkUTCOxglzU=;
	b=pFyU9EW19YZ/gt/mzZUj8psbU7tTSFAKUm63llzvtVt8VFE3JsTKVeeR/piqZiJxeDO7
	 OG8fGD/naRbkP4iPMH8iyhjwnfDdmnbjjqVQlrbasaXUuUMY/Epip225PbyVimWaRHA77
	 HVOtfXEcx78w+Yb23MlFhEvdmr6UybqTZo755vXb/J5KLinDjcJKxZegfYsk+nhNhFqpe
	 Z/eBPBHQhk+1lJ0wnbzy3FA6AeW4Z3MKsgcsD4B155GT/pcxCjIVUp9NLCchnZJEwpnLj
	 wtXkcqSQragAttljHHgWk1Oq/wqkeexWaY3Zc8HsoWUwMzL6cY88Au3GSv+N+QJ9yCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=RRvkm1u8;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B31606A31E
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 17:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24B31606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=RRvkm1u8
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-16079d54c17so74490c88.0
        for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 10:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792691258; x=1793296058; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SCWBGn+DbuJPekfhEu4uXLYMGCLHZ53aEkUTCOxglzU=;
        b=RRvkm1u8IQ2Mlv0vsEHcUE6HX3QGyQ0zuC17cFWJH5zKzqe8B2RbjaeRf4virWKdfi
         BxvSMALrfPAT1sQvmdnR9hn0E8NkF0DPFeIIZicEO8qpgQ4YIQGxDGKxo0a7LhN0KIAb
         qrpZ4ahpNCVhO8d1q5QeFzajGWihKNT++R1NU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792691258; x=1793296058;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SCWBGn+DbuJPekfhEu4uXLYMGCLHZ53aEkUTCOxglzU=;
        b=QsRvfD4iAArXKnywD295PVCuV9Ta8HLLdW0LJg6ZAO3NzL+qluenxTRQ76Yu67Jx0p
         J/0GKapCGeTAf6FXYUWQRFIsbs73p8Bv1IX7uOtzabqElHiPWdzfcR7n2h1fB3u9DlUg
         FSbjEsOF3qcOkVvEd34zpGsoMgFDhvWJql0q1LquGCwocuZZun8/cBeEI2w+UKy2jR5U
         3BaezevHP+4SHyeOXNtykGq7Ngk5czbCzTK8LQHnWceEfsnzVCtfpGDOEnYSogB3PEje
         D0K4pL7vov42CAO0PewOHGApt0KnYvaGj4LMXdgAXX6UmmkBo76m5ryvMWPBusxhC1ad
         NTRA==
X-Forwarded-Encrypted: i=1; AKwUvBwM8DvScjoU7a3H1d2l6jNoqAz2XKSFTZ9H9C121MoOPFjwejuSjCVp5Ea9ItxrJIfQ8ie1oZVoMw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJQqUaNlDJKZ4jaHdyXoGSLniqta0Y2VyJ/goIUFta2YkpC8k1E
	5dahwmnjxvX15qEaC1oUtRPsbvAWYZMLnzecnoBA4QBhLsajtKe1xkkjBG+qNsX5ug==
X-Gm-Gg: AYBFou34Zo1YwTdh6u3UEkwP+3/ZFau/WHEqbsBdgJoB5TDQ3HbHVzz4cZ6MQHnp9EQ
	n12Ikuz44XOAvn/81lA6QiIhMKX5tK6TPJsyrm2UgGnW79Jo22OJLu082AcqrvSEmW2YuvjXRmy
	U0BRZkMdDek65679WEtrvmCaLW+Hl3scH3NslYW6Xu9j5YRsxHbYxtz0G7fkbt0x49kLl6MsGfe
	uBTcwvKYJyPo8/1kp9I38dMpVx0cp4fb+HThjjhg5hqC4YjYKlxoRyhbHyhHOc6PKVGDSUeuMBe
	XaYUPtQ7ZczTM2U03FkPR6QleTDRxxzI9VaHXFufww8lU6CKMX8iKSysPwMwTExFRgUFrhPLjRB
	LdhZLDu5AgUdhoqt4atE1R0vs/0Kd4tCCVFbIkeUQPtDWvi2wcrtHpNkoamFUM0S+AtOeh7+z4d
	1qtkwWkSdukwavOlf3fRVZ6eNoWcET1NWyfKedBvqO/5AGTg6DmESz8uwEJpeYpREas8GivtwYr
	XWhPQnK/QL08hgCW4YMzlgUpFvbPNVTujakYnyApCY1hQK/rYO2bm+MrVnKU/yBwJyInJIP6o6H
	olgE5ELnEyXHFfpwfnc=
X-Received: by 2002:a05:701b:2608:b0:144:c127:dd1b with SMTP id a92af1059eb24-190a7f02797mr6894593c88.39.1792691257861;
        Thu, 22 Oct 2026 10:47:37 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:4a1d:784c:3fc4:37a2])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-195a7f4432asm146724c88.6.2026.10.22.10.47.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 10:47:37 -0700 (PDT)
Date: Thu, 22 Oct 2026 10:47:34 -0700
From: Brian Norris <briannorris@chromium.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Rui Miguel Silva <rmfrfs@gmail.com>, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 00/17] iio: Stop looking at
 pm_runtime_put_autosuspend() return codes
Message-ID: <atpMNk6ymCpC5BL_@google.com>
References: <20261021235818.3059519-1-briannorris@chromium.org>
 <atm0umwtxZlQSAhy@ashevche-desk.local>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atm0umwtxZlQSAhy@ashevche-desk.local>

On Thu, Oct 22, 2026 at 10:01:14AM +0300, Andy Shevchenko wrote:
> After three patches I stopped because it seems more works needs in each of
> the individual drivers. Yes, the series can be applied as is in exchange for
> a bigger additional churn in the future. My preference is to see everything
> settled down in a single step.

There are limits in how much work I'm willing to do on a bunch of
drivers I don't use, can't test, and frankly have no actual interest in.
I'm sure if I spent a few more minutes on each driver, I could find
another dozen things to try to improve.

I can go back to the v1 approach (fix only what I came to do) if you'd
prefer.

Or, I'd prefer to stick with the sentiment Jonathan expressed in
optionally requesting additional refactoring:
https://lore.kernel.org/all/20261018211807.66bfea0d@jic23-hlaptop/
that most of these changes are optional, and that fixing 1 thing is not
a subscription to fixing everything.

Brian
