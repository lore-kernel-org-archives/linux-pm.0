Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792502007;
	b=BKaxruDn9fCrH3cV+zPrKGb4md+z8LTgqqb1uE5DgQgmz2dPm4Y1emfmXiqjd60PaSxQ
	 jA8ur7V6PMzr/ETpPXibSzEnSV6rlleRv14Gw2L8vP6NE1u5x9+7yA8UpsQRChvSFK8+R
	 dYU3G2E0JJV6lTMf6ZRlv7/fBp3fsArjAiz84myN1J2PxCyCTE1f25heOeKNlM87sLWlM
	 55WidLeZzryr/o1/w2Ul/VAP1HXtp+51M70NcDRJXtF9Qyq6oUJ5E/hLtOhvf6ILrgh4i
	 3X9KONE7sxhXa/ELpQ2NrVGrd272MHt2rvV9WmP7We0T4U7nynNk1Tbk4oqtN3gGdgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502007;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Received:Received:From:In-Reply-To:
	 MIME-Version:References:Date:X-Gmail-Original-Message-ID:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=7Xz5yxwYccCRdcBBh2Atm6NcgygrMQamQyqFOlgMgL4=;
	b=gn1W0DS9XD42NyKA1VPnG4D5n48OQccjMBsFEDjYVq9aACsphOP60OT1r5COTZr3WK1M
	 JhGazAAtufL4ZhuwWbpNqWrigibfiPJeYcojoI0jUx8CZTM3sxYlfxk6oTTYXa9ImveyO
	 gRniEj/g0o2R2lcXPNjuuWmTANfBOF7chJLZ9a5MbjXMw/Qi4LYFZr4UaxCVpOSqMgTqC
	 2AEBxgPhXqny0rkCGZSmX6xsKDr3ElyiZ2APKEz4QRz3/AtvX+QnE+ojxbRrVnApckh/L
	 s+wNQiAerDuQ4/IcKtVljLs7rDHFS9b0KlOB66MiIJZk4sgkGcVVMwIbk4+hCTd/5dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dnDWpxa9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B03D606A319
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 13:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dnDWpxa9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1B91F000C4
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 13:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792502007;
	bh=7Xz5yxwYccCRdcBBh2Atm6NcgygrMQamQyqFOlgMgL4=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=dnDWpxa9l97VSPrUOTRkA2Xsba7JqFur9sXZcDCXGjJfy0OQyv4T3nV14A7oMEfwl
	 85/t8eWFPmE/KXIf3RpnD6++Ds5cB/2VP1KUzUNVipjJLxjwrtASlTpS7k4Itt7jKI
	 Sthg7BN5LZKfG9BQ+wk7KutGBqQLa8y7XV+sXdzlivCU4kW0NRCAKr/Kl9din2IwQE
	 +Tcj1/IWKQbXhjTZoB3mdo8ZO6D8dRFu19gGN8SlKeeHyj5a0exVvfg4Nki7aCDUKi
	 i7mGMJnBjQt5cOwQBaIWFlwsUA4XPiRMPQOhNBeJsENYGA2ZMQ4efq/e8XaDibURvg
	 apqVgoYCUHU4w==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3a9a1ed66b9so19353531fa.2
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 06:13:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwogU0L8nmxylRu2ButS1AnmSc2B8tgYCCHGCcjlvfgxuygv1NJvKnygZgd390nFkTNz8Q1fJkjiQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYK9X0R+q0SeUrKKwsMmB9Nk2hXcY1Ic2QWXqRwR1iqcoyZKKwZK
	Q/3v2/uwm9LQ4SKwIArVvnQBobiXKhij2iyNBKx8g1PaLylmZKkb9k+iTW790lcdAHJOpTX/F3e
	SjwX/YK0HJGkBJ3nh3NOYW+AANZy+VLWZ6twbSJBCfQ==
X-Received: by 2002:a05:651c:b29:b0:3ab:1fc4:8eb6 with SMTP id
 38308e7fff4ca-3ab292aac57mr24128571fa.5.1792502005805; Tue, 20 Oct 2026
 06:13:25 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 09:13:23 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 09:13:23 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20261019093911.3199891-1-linghui.wu@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261014121910.1509541-1-linghui.wu@oss.qualcomm.com> <20261019093911.3199891-1-linghui.wu@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 09:13:23 -0400
X-Gmail-Original-Message-ID: <CAMRc=MfNYiKG05SH=1iu-=5=-udUZ8D119FW4NWYv6OONz0_Xg@mail.gmail.com>
X-Gm-Features: AclHuK9cEPruM3nikBKdX3c6tCX1jD7CMOwmmVs7mWGQbc7Fpw7kzXpuklCrV3Y
Message-ID: <CAMRc=MfNYiKG05SH=1iu-=5=-udUZ8D119FW4NWYv6OONz0_Xg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] power: sequencing: qcom-wcn: support SW_CTRL wake IRQ
To: Linghui Wu <linghui.wu@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Oct 2026 11:39:08 +0200, Linghui Wu
<linghui.wu@oss.qualcomm.com> said:
> Some WCN3990-family devices use the SW_CTRL GPIO to indicate that
> resources need to remain available while the application processor is
> suspended.
>
> Teach the Qualcomm WCN power-sequencing driver to use the existing
> SW_CTRL GPIO as a dedicated wake IRQ when the power sequencer is marked
> as a wakeup source. The PM core keeps the IRQ disabled during normal
> operation and arms it for system suspend.
>
> The series documents wakeup-source for the WCN PMU binding and enables
> it for the Shikra CQM, CQS and IQS EVKs.
>
> The series has been runtime-tested on qcom-next and kernel 6.18.y on
> Shikra hardware.
>

Please don't send new iterations in response to previous threads. Use b4 for
patch management if that helps.

Bart
