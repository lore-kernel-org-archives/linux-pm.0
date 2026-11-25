Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795564899;
	b=KAMPVl+JtRzykOXZELnGOrehHyofRicshxy54AK6QUlIkjAyyiKQYrc/JH2d5C5ebuj8
	 8hzDtj6TfNfxd3MDxgZDzSiRBjvXRh2wTOU6zQMt5lRuX/yJPKUUvtvU7YBoFqQeCTpYu
	 qNUh+5Q8f80JbKXd2hgV5r6Gp5DOlPYHcmrVhFQRkD6OTJSvAtFmtt61hTdk/xrRXnZZI
	 KXomqQEA8tlzp9Fwbs4xbgqQ3sfTSOylerKvAD8G4pV46FlsZeXW4SDOh4WNxJEQmSVkU
	 6SMf+dPBbrEqOfm9kEYszuQ2b9Tn52XddEVM8SeXHY+7JuQVdcM1jlMetAVGW/ljMJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795564899;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=8DK3yldnIUojdVzCr2+XwiNL7LP7CGhb9/YkbV+PBQY=;
	b=X4MXZmjksysj26uNoF28qrySGJ5BlWqcGLlbafp2x6srDbWMe6FlkAUSu8yc1iVQXfza
	 +hSI/x69v5t7Vx/IAiYXNvm2a/r6R5259P4UnBdAbCt664JtSAsUQJyknIPdCayHeQdfJ
	 ZbyRu5DlP/7ciUZnVKPAeno/kJPj6LLClA4tA7Ur+O0D8YsqnrAAQ7Kpi6DZqGXDghktp
	 fgYTV7ME58snlzZseQuXXZY7esXmeCygzFZ+6rtiMH6+StY2ZAXSJdcJtBpGkEN0HzgOR
	 9qw94MbtNlnWwXuOe/rB+X+EtVVXxUhFG7p6eOfMv9qZP4IPQfw/SjmGvEyIe4aopUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=jZqCF521;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4662606A331
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 00:01:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4662606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=jZqCF521
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-386c4d2e2ccso2021149eec.0
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 16:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795564898; x=1796169698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8DK3yldnIUojdVzCr2+XwiNL7LP7CGhb9/YkbV+PBQY=;
        b=jZqCF521yDr09fUmzi6RgygaLzmw94KaaOKAsaY89oBxs5KQC7DkwM/NuNnQC9xAQP
         EBFLieZm4OZnZCHp6SACkT2ki+diJp/jYfgr4rMm5srpcb6TGFVh44XYpWVz894XA+zV
         NslcaQ6iro3zpioeo7TmXCxnby9VDCBgIBWO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795564898; x=1796169698;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8DK3yldnIUojdVzCr2+XwiNL7LP7CGhb9/YkbV+PBQY=;
        b=XWeWySAqxYpVvrOd9y5qkXiqstiHach75cPYaf7m6jBrPL631BW3Va9bZid6JdIjSV
         DK3ZM2Pw6y6VxRA+IKI892Fzvj8Mv8I6Rlcz4e8eqGR56cl1UvJdKkBFd2ch+GrTh6ek
         N3dM0FlZ9MlSvx7UeYrGvP5uH6AhqdDU0OzQfuXTUM8sPldBKusBfBO64/XwjVTXhJM6
         hMncACbtdsiHuhlEFm2xYE0+/tptLip6MHFhDFgV54+AlpvLOhLlEyyogsjzIuGac+H6
         ws0L3CS43rd00UqjI/pSuG4dRp7GjyWB68b/NBk3dwXvKTfu00HaIoirSw0w7s3QEzaj
         ET5w==
X-Forwarded-Encrypted: i=1; AL+hErFetjRFBwwP1/7XB6Tvxrnvb2IZgU1ThdkW+NlOaQXYkf+cOpz6AFjX8+d+8fRR/LYdteliwYnvjA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+Pv9+hBnVFhyctFv37omQcKnr3q3Q2CFqwaKc2IIticBlKwqhk
	YyaBPzfWaBdhY/sNjUxHzDCYzaI3LA05UbF5qDcMI8e2aQqOzGmEQbCFS5lwzE19DA==
X-Gm-Gg: AZFdTZeKWM2XI8u/RVjK9Pr9KQpUVKPL0OpJaA86ZXXGhMpEEamoHzPIL+h2jwm6HEN
	EHJNRdWJQlOj4SFVB9H6aFu20FcAJebG3LlFY/8w4HglGp55f8nMAVeUHlrvejLd8jbyojbu/9c
	fF5xUjW7Z3D8TKBRWLo8iB2JuDR6OekLU8r9+2YRgEJVAgfIwjQ1j6J48/ag1Jxeq74Q3hqalDj
	owuEUZDA4cd7XGb9lLCutOyJzjJDkToBkbKJ2f9QD4L2i4hG9sTI0+buxCCD4oMv5dciM4YzKl1
	aaIIDvAQpDvyzaVSKZwcTZQwMPK53JqOQa7EzKLb7Bycmxh4HXf7AHxd1yjuPdZSPrBMZWVG5dA
	b/9KjbBPaiLyVEGPGrWFPwldzmP6ksQPPIUKQq+tYv4Fxw/9xwLr78eYQaiEl+naf4l+/MMkzKt
	mC4gbc2Zx9jBEl7NA/fqNblROD5SXtKROdrMQVZX6liE64RtRSZ7KEIR+n4eulYnJ8ETseseCz4
	JsbQ5jeTCOYC/HmDkTVXzLe8MfrJ0sOHqGOv19rts5rFGG26SxcViPnOyZ8asZSRYtfWV/NEcP3
	A8MQoeEwPHEXczBHBFBXPtJB1gP9jMouQjIwRiYPs4RbWkHMjwL0Ut/qBFgcz2+K1cUv
X-Received: by 2002:a05:7300:601e:b0:386:1e2e:ce0a with SMTP id 5a478bee46e88-3861e2ed1bcmr15600970eec.27.1795564896357;
        Tue, 24 Nov 2026 16:01:36 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:ea9b:d8a3:ba44:2d0a])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-385665f21aesm59652400eec.4.2026.11.24.16.01.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 16:01:35 -0800 (PST)
Date: Tue, 24 Nov 2026 16:01:33 -0800
From: Brian Norris <briannorris@chromium.org>
To: Peter Griffin <peter.griffin@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Thomas Gleixner <tglx@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, devicetree@vger.kernel.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Radu Rendec <radu@rendec.net>,
	linux-arm-kernel@lists.infradead.org,
	Mariano Marciello <mmarciello@google.com>,
	Douglas Anderson <dianders@chromium.org>, linux-clk@vger.kernel.org,
	Jakub =?utf-8?B?R8WCb3dhY2tp?= <jglow@google.com>
Subject: Re: [PATCH 3/9] soc: google: Add CPM over MailBox Array driver
Message-ID: <awYlXdfJcciCy1Cn@google.com>
References: <20261026214359.3122870-1-briannorris@chromium.org>
 <20261026144346.3.I7bc547c83b7bf677a62670099f481a91ac737073@changeid>
 <CADrjBPqnRrFeYT9J6NGxy+Xzy1PTZEz+BMs1_u2md7Ra6xPPDQ@mail.gmail.com>
 <awXf86suGgKeazZx@google.com>
 <CADrjBPqG_TLwgOTzQ-o5pM7k1DzkeVxNkV2xDHsU4OBAyYOofQ@mail.gmail.com>
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
In-Reply-To: <CADrjBPqG_TLwgOTzQ-o5pM7k1DzkeVxNkV2xDHsU4OBAyYOofQ@mail.gmail.com>

On Tue, Nov 24, 2026 at 10:31:11PM +0000, Peter Griffin wrote:
> On Tue, 24 Nov 2026 at 19:05, Brian Norris <briannorris@chromium.org> wrote:
> > On Tue, Nov 24, 2026 at 12:28:24PM +0000, Peter Griffin wrote:
> > > Should we also have "depends on OF"?
> >
> > Why, precisely? It's not actually a compilation dependency (I tested),
> > although it's needed at runtime. It doesn't seem like this is
> > consistently done simply for runtime dependencies, and instead work has
> > generally been done to ensure everything builds fine and fails closed
> > without CONFIG_OF.
> >
> > Anyway, it's a bit academic, since ARCH_GOOGLE (ARM64) selects OF.
> 
> I was thinking more if COMPILE_TEST=y && CONFIG_OF=n &&
> CONFIG_WERROR=y is set. I'm not sure if 0-day performs such a build. I
> guess since no 0-day failure has been reported in this thread, perhaps
> it isn't required.

Yeah, I can't tease out any warnings/errors. I had to resort to arm(32)
to get such a config, and I can't even fail with W=1 (I end up hitting
arch/arm/kernel/signal.c -Werror=unused-but-set-variable
warnings->errors first, but...):

  $ grep -e '\<CONFIG_COMPILE_TEST\>' -e '\<CONFIG_OF\>' -e '\<CONFIG_WERROR\>' .config
  CONFIG_COMPILE_TEST=y
  CONFIG_WERROR=y
  # CONFIG_OF is not set

  $ make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- W=1 ./drivers/soc/google/google-cpm-mba.o
  [success]

Brian
