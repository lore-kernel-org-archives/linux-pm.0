Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793726359;
	b=X0aHJ9jaVQ4LfUjp/yqVCh3W/20wBLQJyCWff4BgcNqNoO8z3IfyCy0IXkn1XmMKDmXY
	 WxYrhoOfQmWn1EJCC5UtlyNhYEXFL6o5TYcq7NIX/MLPN9Fcv5o7YJR0PdIoo4Cv3ZNGx
	 9KFtXzkj4ufQa+CQCJh8spdV3GP8bOtX4iVgy+kII/ybp+Ghnz+tW9lP0qSnBQFLLluiz
	 mv/jx3NHck8cgK44ONI0GzRQnSkMBsFZ2ENQe2AnHPhBGALNPuDndN6qiG7zXt4QzZLW9
	 6giciZBkXMB/uAqIPgHb/RlrY0Ly8VK6g2gG0uLMuDIpgewa03m0k6HiqldokyqHRIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793726359;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=E1AIQqXxMElr9XYHIFcSfJejuF++6x4Nf+fj72eanNY=;
	b=q8MldBD/htuYzMMgsO7dFF+7Zz21zVQNV+NU4JrpG65cO9daX02M+eURzjKWU1q8RqnK
	 JZxYEDv4C6SiuXNgkEjOuC7tXJ7uemx4bL+aI+WMZ3nDQCeC8Xve4gjtwxcMHCZ1A0ivw
	 EWy0DU+qAgzjjOiNrnzr+LDVbTHEBDcMplR/1/d/U9OJErxLgb6ENqNKRNIdGKksufBhU
	 WZIYstLjCCLqdE524nXhWF9tVxE03wdIl1EJ5WHGwwMYafDPjLUfJ/eAkW94uDr8CDfbx
	 QcjZL/D0vADf9KohS+QLiimbG2XH1R9CQ+apOCTHlAsOHYs/MPUYWxqKQkpes48B2Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b="R/YhAD4c";
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64A3606A32D
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 17:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D64A3606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=R/YhAD4c
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48c4d870d54so2704096f8f.2
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 09:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1793726356; x=1794331156; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E1AIQqXxMElr9XYHIFcSfJejuF++6x4Nf+fj72eanNY=;
        b=R/YhAD4cjF5HWZDS12Mmaz+AKtQwFDm5TTdP7WOfrT+BN86ErsKgMJuuD0p6wMvdgb
         uqWg9OIBWW/0jQlOjEM0nHsDOEJKBU8o+MrsPV8Vz862UFKNSEW/xRNOO8aCGJroh5fA
         KuX0NmF0thJd1pgxQzW3+xWBCAPflB3KiPmww8fLaPznA8ilgAyad4tCLgjsfN+etHaX
         HhvCLHebKXO5C2YdHrvuPZ/20HTlx6rRE1RcliE+Uyy3yrjmdv+ESzBlTiU4kGZbNpa2
         X8QEbssT0s+tVG+09Si8g+Ae5Jqrd8c4s9zoCAdw6JW1YaDGxc00om1YhvkHkUbMj0AK
         BG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793726356; x=1794331156;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E1AIQqXxMElr9XYHIFcSfJejuF++6x4Nf+fj72eanNY=;
        b=NA5xV4MYJkjoiJwW7HraZAH0zRi8T2Nh4NGrML3MYMcAr7bSOzekpoO1rNKgI60ymt
         NmRY4t+Hhsmp62bspS0Mk8Q3y6SBCs+846/SXUyoxzrWBiUKsRPmx0CD+mJHdwXF4B22
         5hvd1HHo4PKe7veb6GCBF0OzcN5yXzjUOLSsQhkPDE88IZXKeIuicR7GagzeNAxgoGBm
         4gb13UV47ynF37Xem1utrcnXK0AKE/fzR1nhSpzNJ7eDuAsgNjE5/NG/w/++bKwldeg2
         d1HBwtF9AM5a88HHUu9ofcZxPsbWGta7yx7iCuAabczTA6KIlYX2tkhsh4qLtLWckBTD
         ce6Q==
X-Forwarded-Encrypted: i=1; AKwUvBw53sik5KenEuZPUr3FJkR8KWBrYzEYwYvcFnflUI1EN9OUAF/ai6kP0vDc3cxdM1b1A8hzv5SziQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+Xlvmhi98tCtBsPp1z0NtvxCJ4hPwttEC2GPfP8eTYwuD8L3Oj
	//Z6QkRzaFv0piUOy5KCK0S1URtPALQbxnA3Hz8AtnBqWOaCovxuXwGpzaIN5/QMgmQvxi09x6f
	XUqoO
X-Gm-Gg: AYBFou2PwEnYkPHROW+s/vAmmOas5yeXaCXXnDLmLPQEJ+a+5q+IDL6Tgl0/A0pbUM6
	aRZfWyiHkk1fdZQQpNsSkr+h2Eg4PpzB2QKm2b55oxWi91x1Z2NESCG32WGWNThwC5jdNP5eUBc
	Wpvk5hqZQB8+ksEVQiiug0amRZrW5t/OeyELBLxfMcK+/mGF8gtYYt7PGRpun+BE93VFihn+8Kw
	7ofAjVA3Z25uS9BVYj9wv6CYI1xLKEvgKlVgHCZPW+a5m3qparT2rwldZ7uUKNFykT1qvuWfCAw
	nBlX2AhCSqRS4DfIr0HtvHGBabfO4ZoC+Ftgib+w6pgisCiOipPODVQRwQ4XZ/UnoulXvHOp4K7
	PcgV9137a06Kf8tV+9oJDuUDoE2Tb79MN/o0Z/EImevmgmeqTxvSrZtCDB892ro/o8llrfWbBU6
	iigVRArOYKMSEylNIMvXn2LR/m3CmRcdXKTIkUjpM2fhxu03ZJGb9JuHqbI8VKOKrwoMMWEQFZn
	Cd7q8BDvDjy5NHIJIwoC38oTlosKaCHdodAAbHEhSGGP8z1439A71ETrodDecQJLvm6EoeFje1X
	9yFlNdbt6ci7+0BkzUVPeQzeQweE+S+UWzONDycHiCKHH1dr
X-Received: by 2002:a05:6000:4711:b0:48e:2371:3835 with SMTP id ffacd0b85a97d-48e6e309f7amr31462901f8f.51.1793726356301;
        Tue, 03 Nov 2026 09:19:16 -0800 (PST)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b80eb1sm27856601f8f.34.2026.11.03.09.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 09:19:15 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 5/9] clk: google: Add CPM clock driver
From: Jerome Brunet <jbrunet@baylibre.com>
To: Brian Norris <briannorris@chromium.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Thomas Gleixner <tglx@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Peter Griffin <peter.griffin@linaro.org>, devicetree@vger.kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Radu Rendec <radu@rendec.net>, 
 linux-arm-kernel@lists.infradead.org, 
 Mariano Marciello <mmarciello@google.com>, 
 Douglas Anderson <dianders@chromium.org>, linux-clk@vger.kernel.org, 
 =?utf-8?q?Jakub_G=C5=82owacki?= <jglow@google.com>
In-Reply-To: <20261026144346.5.I82dc05365979021379fe730d6d52792a87ff15ed@changeid>
References: <20261026214359.3122870-1-briannorris@chromium.org>
 <20261026144346.5.I82dc05365979021379fe730d6d52792a87ff15ed@changeid>
Date: Tue, 03 Nov 2026 18:19:04 +0100
Message-Id: <179372634472.2573818.17532943286609086157.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2561; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=fqTcKnieuf7JekGsRwrFzLg18sNZNXRDB3ktfvrRuF8=;
 b=owGbwMvMwCW2VtK+WnvWU3HG02pJDFmvxLvWxKwtTKye09bOcqL677Xz98LyWeKzJO0s975wd
 7Ja9XReRykLgxgXg6yYIksNd7X4O0mtL7Om69yGmcPKBDKEgYtTACbSsICR4VV9nuzFk3pBi2Zr
 S330mea5O3JtmtSmJXnzDHZHnFB9YMPIcPdp827jZbrejwUizdSOlxd4HP60etnkLR9Dtthb55w
 N4wMA
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

> Google Tensor SoCs (used on Pixel phones) manage many resources
> (including most clocks) using a Central Power Manager (CPM)
> co-processor. We communicate with CPM using mailboxes, abstracted in the
> cpm_request_client(), etc., API.
> 
> The clock tree is largely not represented fully by this driver, because
> CPM hides most of the divider, mux, and parent details, instead
> maintaining its own internal table of mappings for divider and mux
> values. The one exception is for some of the DPU clocks, where several
> clocks and dividers are exposed directly, and the firmware API works on
> divider values instead of clock rates. I attempt to represent this
> properly with dividers and parents, although I don't have the full
> display stack running to verify everything yet.
>

As you say, the clock tree is not fully represented here. Beyond that, CPM
owns the clocks themselves, as the driver acknowledges by setting
CLK_GET_RATE_NOCACHE.

The driver keeps a partial copy of CPM's state in the kernel:

- Rate tables below hard-code what the FW has (or should have) instead
  of rounding the rate, even though there seems to be a ROUND_RATE_OP_ID.

- kernel handles PLL parenting and divider math for the DP clocks, while the
  firmware can also switch them to what looks like the oscillator, out of
  the kernel's view. So the math is likely duplicated as well

This middle ground cannot be kept consistent. CCF assumes it knows the
topology and computes rates from it, but the firmware makes the actual
decisions. The DP clocks already show it: the tree can report a parent the
hardware does not use, and .recalc_rate()/.determine_rate() can disagree
with what CPM programmed.

I would advise to follow a model closer SCMI. What you are doing here looks
a lot like it.
(see drivers/firmware/arm_scmi/clock.c and drivers/clk/clk-scmi.c)

 - Put the LPCM service protocol (request word layout, dst_id, timeout,
   error translation) in the CPM firmware/soc driver, behind a small API
   shared by clk and reset. Philipp asked for the error helper on 6/9; the
   whole request encoding is common, not just the errors.

 - Make the clock driver a thin CCF adapter: each CPM clock is an opaque
   endpoint, and gate/rate requests go to the firmware. Get rates from the
   firmware (round-rate op) instead of local tables. Model no topology the
   kernel does not own. If parents must be exposed, the firmware should
   describe them, as SCMI does, rather than the kernel hard-coding them.

-- 
Jerome

