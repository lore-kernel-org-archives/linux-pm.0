Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E4B470426;
	Sun,  4 Oct 2026 17:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791136014; cv=none; b=kHGbZsVP+i41w1XvttoN1Ny3FA2EdiaFo+u7GZzlgg5kIug15kPYG1I7jWpXt4bU0VVm9H0lzG1YKdpIvNMe7sfl6ZIcQlNHMgql+eYv1PLz4mnpLk96W+hr9awKD2wYwLSZm6qkCHXeRhnY0a9bILHEMTWVWoI3X+0H1H43srA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791136014; c=relaxed/simple;
	bh=ofjkt9D4k37eU5fD6ruuf9VfJsX8+1EfLO8pEpkOmDQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=u2hpmAC5jTj99azNj6tuiET0ZWeVjstUbahrrlsjjjLvjMAIOCbqw8YJk3qR169ajr1UFZGhk1OSjsm55B9Wfj/fTwUA6OudIRVpVkHlwuxMgCSuuiYfkri1OetGWDl1uIEjxWygY2GAta00itAMVuyqUZvM7sM3F0Un3d/cyAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF0F1F008A1;
	Sun,  4 Oct 2026 17:46:43 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 49544182ABF; Sun, 04 Oct 2026 19:46:38 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: rafael@kernel.org, krzk@kernel.org, amit.kachhap@gmail.com, 
 daniel.lezcano@kernel.org, thara.gopinath@gmail.com, talel@amazon.com, 
 hayashi.kunihiko@socionext.com, mhiramat@kernel.org, mmayer@broadcom.com, 
 viresh.kumar@linaro.org, sumitg@nvidia.com, peter.griffin@linaro.org, 
 myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com, 
 Frank.Li@nxp.com, s.hauer@pengutronix.de, matthias.bgg@gmail.com, 
 angelogioacchino.delregno@collabora.com, sven@kernel.org, j@jannau.net, 
 marcan@marcan.st, casey.connolly@linaro.org, sre@kernel.org, 
 wens@kernel.org, t.schramm@manjaro.org, 
 Sumeet Pawnikar <sumeet4linux@gmail.com>
Cc: bcm-kernel-feedback-list@broadcom.com, 
 linux-samsung-soc@vger.kernel.org, kernel@pengutronix.de, 
 imx@lists.linux.dev, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260912191156.185448-1-sumeet4linux@gmail.com>
References: <20260912191156.185448-1-sumeet4linux@gmail.com>
Subject: Re: (subset) [PATCH v2 0/5] PM: Use %pe to print error pointers
 symbolically
Message-Id: <179113599828.190565.13465201522154084612.b4-ty@b4>
Date: Sun, 04 Oct 2026 19:46:38 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Sun, 13 Sep 2026 00:41:50 +0530, Sumeet Pawnikar wrote:
> This patch series is a cleanup for subsystems under power management
> (linux-pm) that converts several instances of error pointer printing
> to use the `%pe` format specifier instead of explicitly casting with
> `PTR_ERR()`.
> 
> Currently, many drivers use `PTR_ERR()` paired with `%ld` or `%li` to
> print error codes returned as pointers. By switching to `%pe` and passing
> the error pointer directly, the logging subsystem will automatically
> print the symbolic error name (e.g., `-ENOMEM`, `-EPROBE_DEFER`) when
> `CONFIG_SYMBOLIC_ERRNAME` is enabled, and gracefully fall back to the
> numeric value otherwise.
> 
> [...]

Applied, thanks!

[1/5] power: Use %pe to print error pointers symbolically
      commit: 8761a4577c4fd489fb7af435f4b11ab6762dab66

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

