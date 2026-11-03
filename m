Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793671668;
	b=JXAR3SUb/HQaJEWjUVlXfPSatn6L9HZSylLfaAHNt/WemUSLaWSsvDOdrkonU/+htEm2
	 qKOVz6u+82PqRpJlGkki5whwVf+wVD5eMlSgaGe7FGshpiV4uzSxnIDCKaero017UrVcg
	 XGrPSMj1oUqvZE0GAydbdaNFtIStnd0QZf3yMT4p2vKwCoupsRcp2A6birejwXE9Fbt0N
	 jQQMEt1gkoyeClitrRVSRGS0YDOjhPstN5csdY/MaFN8sjHqG4RK0muQHms59w/cpkCSl
	 EDhw0BHG2dzV5sNfQItLVANk6ZPE7C6uHk5Z/D/FGwtaWrAyhGKtoXxzM5SO+WDsXUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793671668;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=mnCMgi1Mjc7rqcgOPGVHBPcSRGGmUVFCpLTaHePthjU=;
	b=B0QnNfq7PBTfcU3doyk4OqBc4swrUnRR8XXL6500HwxPQpNVTI4GUzKKUaI7vZUlFasI
	 xyKQ/iGSRa7QPbDK57Yw3j7rBC4rNIznxptPkUutgl+6mi02acX9n3QOxkm2zyu/GxiT5
	 yXMQHfWzR05Y6Uzoe9rPQq1gyAqovzUu+9auda7bwgs/OaW9ZeTkVWzb6iMJd+GKge/40
	 89AZ78BgKtIsZT8bL5mYZTp8FjksW9lvsbUyIctCx16OT6u/cNkuO8X9qfoCPKPp48RAy
	 EEsf+FlH0V0mEd14LskGXH2E0j9OfQobV1dIVHFBsbrw6FBebZoMJa2HmBvCoEttCrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=aLjZ44wG;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AE8606A32E
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 02:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18AE8606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=aLjZ44wG
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1ae18eb9ad0so3650142c88.1
        for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2026 18:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793671667; x=1794276467; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mnCMgi1Mjc7rqcgOPGVHBPcSRGGmUVFCpLTaHePthjU=;
        b=aLjZ44wGmMHqn8e7JX/I8P1V8VARuQh9o/ia1bogyOm6JOCislA1YcxOmIPAwzWMj1
         IStM6BfN0n6A/Mi7nmKeP+I/YEQ4JUI7eoCX12cJ9HDCtLihrgNPebZlvOTpH2BmP9dD
         jawS7ea3vQz4o3ANdgnbSTDQswDHEQkKX/To8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793671667; x=1794276467;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mnCMgi1Mjc7rqcgOPGVHBPcSRGGmUVFCpLTaHePthjU=;
        b=pd/iTN7bs22tmy2yaQE+1r1gXk4zg5CRe6FuBiI4kh/B0B+cIaY4rG5VdP+iJhZBf1
         w8nBVjtcb9+V9K+9c56rM6vJF1+OrfdB9Xn3z/IfULTBe8LoFYz8RvaCtkolsmwr6Yd0
         gUa6lv5Zs22Z/PKOLKtHxfK+rxYytyI6v4pN2zR0VG/9QUovQEoPfnwzYG8EyHNjBLMS
         rXE1H/7YYb1QJqfOM14QMIbgEqSEXa5nhEI4NL3m+cRmTgJ2kWrLzi8IRYNhXnhdMFdP
         WRWIU63rLw1dvCvOVXUuP84b9U4A62OAt36lfF2Hr7lU3uGMQ0KfXvG4W+BoCPop/ATB
         YhNg==
X-Forwarded-Encrypted: i=1; AKwUvBxYYeeRpoanUUFXZfltayVXsI+WEUkZrRXMiqTeIsjhg0C4xNGVmEJNmZE8HTniyEiv3XEPFhDIHg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLP+LxfF2sJT8WzfkpzyOWY89h2B5yVFeIbtIzenHtDPwPE7exa
	3q98jJ50KgSwp4CkeK3gmC9y+EBtOhwc2Qx2vUR1fJrtnzeUV6lDpWB5NyH/VOx5Ww==
X-Gm-Gg: AYBFou1gCzzMZNOFpnUraJUKHKv473qocTPRKDE7wwUMOm+mkDZlVB8lOu5yfGRUnfb
	NArB/goOm82UCvzS2blp/gJiYjGXEl6Zbmh/3vDe3GWfw8G7GotLy1OoUPtgQBY2m/e3btxnb3X
	BOk2H5kTRQW41Xmer3BZcxfwXJFMrsTLX46u/V423+4MAxFe0IAbFLxYnMi/qCYpszRCoi+jxJU
	dQjcTwaRFk/VJaOZKbSrtQW7Fg73b4tmlvNztd2e9Xq4w94IlVfXWjzC3xxB95zn10vbYaWuk+O
	hQE6k8onSxU3qYWFpF5K+uIE0L9L/Ag4jJGqE/cOVWp+8iZJj6bJewY0csrMHsKI4Xr6S6mJnyz
	04wUwLpdWeA4uLrYrOLOORZE6MkW8U3HiEaCx1okay1K82/Nwpf7FkCnHzVcvKjpSZS+WEC4Zy9
	ZS5l7FhSAES+nSCAo22qh2i9dW314QQ+qkCCkCxaLNIEN8wq4S6P8BfOfsNJ2Cy6Kgi94BGjr9F
	VJaIGAQJveCtOlAQ6J0yaWmAfKzUf2A0fmDGi9RhKpdDb9MHeCRVL6HNJuzLAcUgwicIznenKaH
	NDp9HBMNnZLE1crNrdXO4V9+ZFEYnq0jLfxLJqjljQ0yLG8Pj5SxebbbeJbQ6mFvu1c=
X-Received: by 2002:a05:7022:f105:b0:168:e942:4e62 with SMTP id a92af1059eb24-1ac601d2f3amr14793852c88.40.1793671667220;
        Mon, 02 Nov 2026 18:07:47 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:c57d:c93d:3543:aab5])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1b23b847348sm4090158c88.4.2026.11.02.18.07.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 18:07:46 -0800 (PST)
Date: Mon, 2 Nov 2026 18:07:44 -0800
From: Brian Norris <briannorris@chromium.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Thomas Gleixner <tglx@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Peter Griffin <peter.griffin@linaro.org>,
	devicetree@vger.kernel.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Radu Rendec <radu@rendec.net>,
	linux-arm-kernel@lists.infradead.org,
	Mariano Marciello <mmarciello@google.com>,
	Douglas Anderson <dianders@chromium.org>, linux-clk@vger.kernel.org,
	Jakub =?utf-8?B?R8WCb3dhY2tp?= <jglow@google.com>
Subject: Re: [PATCH 3/9] soc: google: Add CPM over MailBox Array driver
Message-ID: <aulB8F6hc1eDvyfj@google.com>
References: <20261026214359.3122870-1-briannorris@chromium.org>
 <20261026144346.3.I7bc547c83b7bf677a62670099f481a91ac737073@changeid>
 <20261028-literate-pony-of-valor-3209fb@quoll>
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
In-Reply-To: <20261028-literate-pony-of-valor-3209fb@quoll>

On Wed, Oct 28, 2026 at 02:27:05PM +0100, Krzysztof Kozlowski wrote:
> On Mon, Oct 26, 2026 at 02:43:41PM -0700, Brian Norris wrote:
> > --- /dev/null
> > +++ b/drivers/soc/google/Kconfig
> > @@ -0,0 +1,13 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +
> > +config GOOGLE_CPM_MBA
> > +	tristate "Google Tensor CPM MailBox Array Interface"
> > +	depends on ARCH_GOOGLE || COMPILE_TEST
> > +	depends on MAILBOX
> 
> Can it be compile tested without mailbox?

I don't think so. mbox_request_channel() and friends do not have stub
implementations for the non-CONFIG_MAILBOX case.

Brian
