Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875973603D9
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 06:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781505295; cv=none; b=ACTmoackW3Dkf+2vYPiGWqdgSE+yWux0ydUp4oUxoxq049A4fj2pBZR1YhFI8IE6YLidmKnzWcZghRXiyV9C5e9e8YDLJPgddJfbvTlqQfCg9N+Ho9A4cMshDZczLQnqsCs1obj27uvCXSszOOE2y6woUxTn6ekwP7/HSTiH/Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781505295; c=relaxed/simple;
	bh=S1Oly4VRINHCM1QG4R4tTGNPNvyYOvpI2d0QTuC1ElI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NhP5DmHYULQUeXj43BDsqqANaJnklYJAQxn9Vf4/2nnYpNprR8SbYLueJ0VouZmXcMm1CpSNs0HxrR2gmQxna+G+hCHQXplWVmevNeeSRvDzcu0pyQbgiL5qSSKpPs+kmwu3/oRhpemdAk6cMUwTzYW5y5nLStuYjvtxGaSNR+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bu7gzQE/; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bu7gzQE/"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8423f626a65so1314239b3a.2
        for <linux-pm@vger.kernel.org>; Sun, 14 Jun 2026 23:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781505294; x=1782110094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kpTWnKEfXWiCzl373nMMsDrR/prBlQwjYUYc6wVEFfc=;
        b=Bu7gzQE/0pAqv46HKxrhQS+Px/CCeemm2CNiDL1UgjUoXGTNyiUHbWmK24VL4IjJhB
         haYgjyUGWO7UnGaHWzlGaJrlk9UvQ8Xb1nlblRCEfsyzqwtQxzHpoOw8UX1xEAKGBgI9
         7YRgCUutQPJURtWRv8djDAyG/VV5ywXQnI8n6B8/k2l3VVNgyMR+TDur7BBXflzH9uJG
         QNOOuxsnhLo1ijo91FqWm18cDTZ0KNBr+7qA2+lhVEzff6J5+vgVtfx0k/bOBFxv8g76
         NIYKFxeca6gtPxo8x+GYngiDHrxX3IDIdZQaCz0+CrwNtDIUv9yjECFavC4w01h/IIZ2
         TBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781505294; x=1782110094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kpTWnKEfXWiCzl373nMMsDrR/prBlQwjYUYc6wVEFfc=;
        b=CjtYIoeIbYDZZHvauT24A4HwfEmRYaRgMakPLlmHHG81p3rO9avn9pSV9Y7MbDDGPx
         dI/qRBqhy+qBTDCTTqOEuju/pN2fxFbeQRFldKwrkIP30c5MCXAeEggHqxbQMBzQedcn
         mt403c/zPFfNgudihQsB+L6NM/aAGxtTs79k6ANTz+TdFnfsAUQfFpjnoLdH7sb7KK4L
         RYMRR4iqon5xmC9px+qdPU4dOxSOu3fa+En4hytz/JaaMmFvG7X8DoKB/OUp5b//2RTK
         wbNMESq+uhSsOYofiFMWcGlLYxxNSvsrO/yMntwbUXxvokRUgDhsMP83cTgNrQE05H29
         m0Sw==
X-Forwarded-Encrypted: i=1; AFNElJ8uSfqRaRY+lxNPqjo+77cUpVVWnSmwdA64iNdJLSJJHtUFXigwnmZ1YEpD+MQYGrNgcvGpS2gSTg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFy+N6dm0mcFFy1WOygJ7PmTgiflLhTskSs6JyrVWALLOVsgLz
	CccaWl4BX1GmrhVoiEY6660S9xoV/gcsSMkhqH5e+c9Ji1/Ed2XP3fgC5LwqRRRs31E=
X-Gm-Gg: Acq92OGcj6NYicXuePuZTZNkFGn2IlAnn807hbof6Jhr/ANI1BtVLvkfivhT2pemOY2
	0yozdW0TD9KXIB8QXTtwlKSHuNrHvffRHP/ztVpHr0KrZzbA7VUtXYnfvqxTgF5fzwIObOwKkLQ
	OBKtVy9fjfZK8glxO8NmYic/H0n92FpPpcDEOD8IvWi7oU59G7g2vnm3PV8b2UkMDO00XUBYxvc
	DMvPQlaBGR+zSb1nJI9cB/otyyNEqdsnAfxaRtpAr5NaMQrR4wRE9dBJhQYs95VfWJ4BGUmj/Sc
	4TGCtzoRFDW5wthemxA4YSvWDCU0GcU5S7afOzm2dEaaWqknRv+ABzlcZxR8sxssFErFeFwgSSm
	MJLMzY1BYgCquGyDnoEoeESC5TCUx30wKygK68/R1ZpEblz/uqX5TLMJdaY4EtvQB7F+wsvIkHH
	D253CfED/pImGWwdNB/bUYzRWtcWYhUb97ag==
X-Received: by 2002:a05:6a00:891:b0:842:21f0:5114 with SMTP id d2e1a72fcca58-8434ce784abmr13630133b3a.30.1781505293590;
        Sun, 14 Jun 2026 23:34:53 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b040718sm9297405b3a.51.2026.06.14.23.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 23:34:52 -0700 (PDT)
Date: Mon, 15 Jun 2026 12:04:50 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shuwei Wu <shuwei.wu@mailbox.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] cpufreq: spacemit: Add K1 cpufreq driver
Message-ID: <wjwkykv555gkeqxabsqcdfn4lomcopawsv7bgm4bydc5likhjs@p3ca3p7wbri5>
References: <20260612-shadow-deps-v3-0-2f3ba88611ff@mailbox.org>
 <20260612-shadow-deps-v3-1-2f3ba88611ff@mailbox.org>
 <bd4s2icqgusnuujvrpoag4cniy3g2e4bumecqxt5yffl77aqpq@kxg4dj4c2wk3>
 <DJ9EFPG561VZ.1WGRYYHJ2W9J9@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJ9EFPG561VZ.1WGRYYHJ2W9J9@mailbox.org>

Hi Shuwei,

On 15-06-26, 14:12, Shuwei Wu wrote:
> The clusters have separate clocks, but they share the same voltage supply.[1]
> So two independent policies would be unsafe: one policy could lower the shared
> voltage while the other cluster is still running at a higher frequency.

No, both will vote for the regulator contraints using CPU device and the
regulator core will make sure it doesn't break any of them. This is what all
frameworks do, regulator, clk, etc.

> This means they can't use different policies.

This is incorrect.

> From a hardware perspective, the eight cores of the K1 are homogeneous,
> so using the same policy for them is relatively reasonable.

Right, but this is inefficient. One cluster can be idle, or in low freq mode
while other can be in higher. They MUST be two policies.

> I used a K1-specific driver because cpufreq-dt only manages one CPU clock
> through the CPU device used for the OPP transition.
> On K1, the policy needs to control two independent cluster clocks and one shared
> regulator, so the driver has to update the second cluster clock explicitly and
> keep the ordering safe: raise voltage before raising either cluster, and lower
> both cluster clocks before lowering the shared voltage.
> 
> [1] https://lore.kernel.org/spacemit/aeaXszeaE62rM6BJ@aurel32.net/

-- 
viresh
