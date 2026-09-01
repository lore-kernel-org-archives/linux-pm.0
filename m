Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C924943F4C5
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 16:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788279321; cv=none; b=Q+qWUqW0S7N8SkN3DzgikaTVhQc/NeOzt4ww1iS2/Xba3qg9zoL5DcPFDHm5D2wR3fmT8P2A//fTX2c19yhCib7g+lN8RmCn+JBVUb+N2QJOw86almjWv8yUIPTmdTntbWVRwR95/8lTR3Sw5Ks5Hz7VnBmBlu1iJVhnK+/NPdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788279321; c=relaxed/simple;
	bh=sVmVzt8GgzZn8jvrQuxVaR7Ad1O+lxZF27bkoLHptvs=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EI1vD73ouTVAKlBX5GZRm7XCWAN/iLFmdr07tyb9V2jVgqMQp3eRfsU9cOyKMWWlz1pOLSm89OUDg/adsaS+V/6WZUVybbae9b9eElyxqOKdw+OKOPwoSLS6RP8ElrfOriwupWFfjnj5Zbj/DIhBBRob7yCmLxRzS/X4Ibr8mGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LaJEwRm/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LaJEwRm/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E94D1F00ADF
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 16:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788279318;
	bh=sVmVzt8GgzZn8jvrQuxVaR7Ad1O+lxZF27bkoLHptvs=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=LaJEwRm/DFlOnl1mYgCfRGzrC6JfPIkqeYk365T6HqHO+6kNq0afbytV07e6G6NZM
	 4vtiM8QynuwbmFWstf7U6GSt4JirFqIjezl+BkPM54F8fOmdq2Rb5yF6DJ8l0hwGLg
	 26oCw4CXK6P2qzd2jRTz9FAKelpvVHeBofhEglVi41HU0dW/mAQIAUm+05hXN1/QTM
	 mAUbi5R+6Ka+PCYSZcFTw0Pq2w8v7/sQS3gMrPrCYVdlsRrQIz/4oR6j6iNVXvwkj3
	 0bRsnFV1luxdcFuZUy6GLpZ4evgJT+jQeOc/TG7dHHAq7HSggYPRBWaglc9VcgBkOZ
	 P7WcwVUbIMlSg==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b0115b9e17so1067819e87.0
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 09:15:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwhbMBskGg0LPmx1GMSYPQYpS3XF17coFre5JgtroGUOaA210+qV6QU2WUIdtRKm+HWVJxhTWOLOw==@vger.kernel.org
X-Gm-Message-State: AFuF++lMb3cr4eSpr+pyGOP5e1yKv3cLFNNI3xNV2R6VPjFMW2wYukDv
	S4cGrygLDQ2rDmhZvWk0DdxVaodwvS88DGAf5FnM9qRv1AvLpHlRIC8jRWwTk/U6xFPSNzJnPA0
	iTVDccSXkaCzhBLpzlv60jLEVVs1LYVb23K/a5VuFgw==
X-Received: by 2002:a05:6512:2522:b0:5b6:4b1:f8be with SMTP id
 2adb3069b0e04-5b604b1fb1emr1186371e87.31.1788279316943; Tue, 01 Sep 2026
 09:15:16 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Sep 2026 09:15:15 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Sep 2026 09:15:15 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260826122742.153643-4-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826122742.153643-1-biju.das.jz@bp.renesas.com> <20260826122742.153643-4-biju.das.jz@bp.renesas.com>
Date: Tue, 1 Sep 2026 09:15:15 -0700
X-Gmail-Original-Message-ID: <CAMRc=MfAdTMb_4ii=up-ESwc322YYjzseyvAxshM6vUcEGfxcQ@mail.gmail.com>
X-Gm-Features: AcwNN1V8DuvVovyhVMeiT0SihZ3OVkh2HoH1hRxjyitBpeUT6HAacUJvV22owPU
Message-ID: <CAMRc=MfAdTMb_4ii=up-ESwc322YYjzseyvAxshM6vUcEGfxcQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] power: sequencing: Add Renesas RZ/G3L Power Ready driver
To: Biju <biju.das.au@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-renesas-soc@vger.kernel.org, 
	Bartosz Golaszewski <brgl@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Magnus Damm <magnus.damm@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Aug 2026 14:27:25 +0200, Biju <biju.das.au@gmail.com> said:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Add a power sequencing driver for the Renesas RZ/G3L PWRRDY module,
> which signals power readiness for various IPs (USB, DSI, CSI etc.) on the
> SoC. The driver binds as an auxiliary device to the parent SYSC driver,
> using its regmap to toggle the SYS_PWRRDY_N register bits, and exposes
> {usb,dsi,csi}-pwrrdy pwrseq targets.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---

I would prefer to see a stricter .match() but since the parent is the soc node
we may get away without it.

What is the merge strategy here? Are patches 2 and 3 independent from 1 and 4
at build time?

Bart
