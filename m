Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9223047ECD1
	for <linux-pm@vger.kernel.org>; Tue,  5 May 2026 13:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777989172; cv=none; b=bCIdZmxFOQ6UfaE6eQYH1t1lcukg2RWnCdC9OK2fDtKcnDQ9y4y3VHAhomcJdWhAuNO6INw9SGq74NpViirY37bPPjqzOs4wE/El/p3z1DpyqM7vxjDkVUcs2R97ZiBhh23ywv2FgYcDFu8YKqs5FZ5o/bXQZ6HLVQjj1FS/3OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777989172; c=relaxed/simple;
	bh=16crbpE+fo9e6NqCvKQRKG+iiqH3XIXLq7L/8lqbgiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s/DQLgKbSSwvnoMBnD/AwytobWJJiii2GsuzP7fb9a0eYBL1f+owjoPvyNLbnj1ZXYOl5pNsVS454oUJtCVscExzyV9UApVLEfY2zBrrEQ7tF9yDGxk52hnLPGEkmiOh1kmX1bLwTQ13XPdGfMPDBIeC3n39DTgZQ/o6r1Nqliw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzd+lenk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzd+lenk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F7BC2BD04
	for <linux-pm@vger.kernel.org>; Tue,  5 May 2026 13:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777989172;
	bh=16crbpE+fo9e6NqCvKQRKG+iiqH3XIXLq7L/8lqbgiU=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=hzd+lenkIMEVcvFwN6XXY/tuY5oA+9X322v8bFhDINbThAWerGAdEQW+ldLKDn3FP
	 D1e7cP/NwtJw+pjK3hpjKGo96j3HK4eOJTZ9GFbgfsgjXhjkuLQ10PRq4cxnBuxSR8
	 rEfBJT4nidKWMISjVu875veccvSMvxbXz2inBZCc0TnqQFYmAV88ahSLMhrO/kX/am
	 FSTXsArL6p58mCna/BtGv3YDGYOrDHUeUoVWx37rIfvxAS6KGyXdTk+psiPRzqZQ+u
	 pbU9o38l/axINVOX8TOA13UDEgYIqJjGsEVJw8L+TAVtJS2p9sYA6ANaavdlzA+lYF
	 F5spwNTB2ADjA==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-38a01c80c34so52879411fa.0
        for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 06:52:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8dfdGaQUcwQtVXoDk9YZMGsbblKaUyI60zB/hw7HkKz3XbRPq9G5y4g3CMIeBjXJFHFDGa81NZdg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUg7M9bH/7F9Jnvf51cEvMnCg8cC0SGEz7aks+v2ukGeKogEZA
	OAWW8EHGf8FOqrg0ctvL5rSvfOu6llcmx2LqfZMLJh0720hpMYCeaAPq/Cb1ugHuV/n7/amwisk
	5TJUpeFxJWg8e5jDcqe1FIZxOkSt6hrk=
X-Received: by 2002:a2e:b0f9:0:b0:393:975b:5634 with SMTP id
 38308e7fff4ca-393975b5741mr29824471fa.11.1777989170742; Tue, 05 May 2026
 06:52:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504050245.646078-1-iuncuim@gmail.com> <20260504050245.646078-3-iuncuim@gmail.com>
In-Reply-To: <20260504050245.646078-3-iuncuim@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 5 May 2026 21:52:38 +0800
X-Gmail-Original-Message-ID: <CAGb2v675Pw3a=8VkNc_ztYtQcCdezG9PrntXLHO8YgGx5bJjxQ@mail.gmail.com>
X-Gm-Features: AVHnY4KSBoJLk7nvV-NLPC9NRZBgg446WsQhRQL5baEYgZM1ln_FGyUdU8wzQSg
Message-ID: <CAGb2v675Pw3a=8VkNc_ztYtQcCdezG9PrntXLHO8YgGx5bJjxQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] thermal/drivers/sun8i: replace devm_reset_control_get
 to devm_reset_control_get_shared_deasserted
To: Mikhail Kalashnikov <iuncuim@gmail.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li <tiny.windzz@gmail.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 1:03=E2=80=AFPM Mikhail Kalashnikov <iuncuim@gmail.c=
om> wrote:
>
> The A523 processor has two temperature controllers, but they share a
> common reset line. Make it shared with the shared variant of
> devm_reset_control_get(), and also simplify the driver by switching to
> devm_reset_control_get_shared_deasserted().
>
> Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>

> Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Update to:

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
