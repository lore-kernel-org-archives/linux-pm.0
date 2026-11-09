Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794187382;
	b=P9lmr9KbXbHs+GeT23r5UhekUgwmEzCnFsHLwcHrDR0HfHiHc5jpeC8dioLOd/hx5lCR
	 I0kxXw5Uq1GjRjeNNc0uYw4dm/z2YQTJV5KWAznUkRz3oMO/YyxrdE7YhjvbLVM1mUzxE
	 92RQxFjz7hbEIYkXfIkw2tznjuK5Vo2TiQaOBtUxHaNmqLgNlkH6Z0hXn7AqTKCWNiy6f
	 9IEy6B6yxN429zUPaCL5tgIQsGDfusv+OGFbJqAiIPzXisHetta6dQ2g5Y7E/6NlW8CfM
	 nCu2esB9HWXmlcjPkNu2D9MLtRzI5GtkE1cG/96LJx5XeIvwbgynEu/QUkeww5p9jnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794187382;
	h=Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=waudoZWVty2lmv81R2SwtZes1qt0YbskRwRdzdBBv30=;
	b=1jIzpNSTzntkdgrylpy7kCVtS4gAENuKGKt/DM3LOCWTxhhdrnYPz8FTyIr4w+3d5Q5o
	 Jd763vGwW/kQw2IXdt0e86YTuWjDJwelccd6M8OC5j3NhqunkdqOR4DAWfrnGeaZnCl3e
	 huQTtg2oIN9B+/p+W9zvMY4eyoQBnj6ALeRMfSWcDbmxjaL5L83P+QCcLHuFYD+d86exP
	 fPNpBfFXLVwFTwCEX+Vx0y4t98/+y7KFmGu3UznbCC/lGOfhaO+bjWNtNfOJwViFOiH2U
	 2JYjOUFVCcqjzOYh1TCLVZbIYwSsj73Uq07gCNJCtNn+3I59OKwGu8mvNpOzVo4GyLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8076608361B;
	Mon,  9 Nov 2026 01:23:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216361F008A4;
	Mon,  9 Nov 2026 01:23:01 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 3781A182C54; Mon, 09 Nov 2026 02:23:00 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: sre@kernel.org, Hugo Karlsson <huggek@klattorp.se>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 matheus@castello.eng.br, me@iskren.info, krzk@kernel.org, 
 m.szyprowski@samsung.com, clamor95@gmail.com
In-Reply-To: <20261108154241.198160-1-huggek@klattorp.se>
References: <20261108154241.198160-1-huggek@klattorp.se>
Subject: Re: [RESEND PATCH 0/3] power: supply: max17040: report charging
 status from a gpio-charger
Message-Id: <179418738021.1255445.3214315853336545090.b4-ty@b4>
Date: Mon, 09 Nov 2026 02:23:00 +0100
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
X-Mailer: b4 0.16.0


On Sun, 08 Nov 2026 16:42:37 +0100, Hugo Karlsson wrote:
> Resending with LKML and the remaining MAX17040 reviewers in Cc, which
> I missed the first time. No changes since the original posting:
> https://lore.kernel.org/linux-pm/20261108144548.190622-1-huggek@klattorp.se/
> 
> I work on OpenFlight [1], an open-source golf launch monitor built on a
> Raspberry Pi 5 with a Geekworm X1202 UPS board. The board pairs a
> MAX1704x fuel gauge at I2C address 0x36 with a GPIO that is high while
> input power is present.
> 
> [...]

Applied, thanks!

[1/3] power: supply: max17040: pass the device fwnode to the power supply core
      commit: d7dc0a8b24674fc902fac8b66f1affb32cefb9cc
[2/3] power: supply: max17040: derive status from an online supplier
      commit: e41d85503762f5526c640de07ad8631906eae68d
[3/3] power: supply: max17040: clamp the reported capacity to 100 %
      commit: 7071d4750856abbc68dfe431acc58a1d45dd42e8

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

