Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F2C3314BF;
	Fri, 26 Jun 2026 08:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782462073; cv=none; b=jz3jSntru49kmBBCB56wg7HKzWW74zbaT+rxu2VUqGcB83B65UXX0uI8sphA/RP8wCfDFvrtVanjCByl/++8EwfNHy49RJqQDeBFWvOKOL1XCpeC3/9SZC5cyxrwhRQsfjXEnMaewWZa8reINlgDe7a83y9ImYfLms8gxVl4j2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782462073; c=relaxed/simple;
	bh=fQ5QPBIlRXuwWqdYdV9ssqCWmUSDxWbJSPaWIIOFzKg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S7Fq+JK67prEqBIO9wgewR3DAh6jkJDUVAQQIpxWvQLPgmudUibUYyiVWLWqPo+O6JYgXFzUILM+6W3IXUTLkJJnkzVrv5pboKZHTCFHztetnuThtfsoXq5Ragqwy4rpqFHO0aRduiWpdCVDxhF9Rf58MddZQYC7HoU9BuUjT8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEW0CG/9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEW0CG/9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1993C1F00A3A;
	Fri, 26 Jun 2026 08:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782462070;
	bh=mKdovRIrKfyxu635TzziBG37YLmIxh49GjmLAgAIHUg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oEW0CG/94G+fLSDLCrwsou32pQbWB6aRMjW87zHUXlLuzZy/K+I1NDQCu52QeCv+N
	 0TPRnMW9bKrWxlzErKoh6Ecg83BOIz34dfafwUDpyS4WrAIzV9XM9DaMzJmeazcnfe
	 gUXg2/NLVqviD9vIVFfepRpzSJ8k4Nn7zXmbkbKknP3/7bUrWk6ngWdpkmPqFQAU0z
	 I5gzfoLdLWMLSFKa5DFSxK35JX+mSj0pTwSe4jpHtdfI5zxX7n7EX7oYXx7eVo+Q8E
	 lmzcE1dniK06SAVV710pZ1FtvT+xV0UEHP2v9FGQvH7XiEITgiIpEdibHF3Xr4Hjoy
	 cbujCc5RGAtIQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5697639389E8;
	Fri, 26 Jun 2026 08:20:58 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 0/6] power: Use named initializers for
 platform_device_id
 arrays
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <178246205698.3816447.10450599511697138681.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 08:20:56 +0000
References: <cover.1780048925.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <cover.1780048925.git.u.kleine-koenig@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29_=3Cu=2Ekleine-koenig?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	=?utf-8?q?=40baylibre=2Ecom=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-riscv@lists.infradead.org, sre@kernel.org, visitorckw@gmail.com,
 bleung@chromium.org, groeck@chromium.org, linux@weissschuh.net,
 krzk@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 hansg@kernel.org, m.szyprowski@samsung.com, sebastian.krzyszkowiak@puri.sm,
 kernel@puri.sm, dlan@kernel.org, andreas@kemnade.info,
 mazziesaccount@gmail.com, sven@kernel.org, j@jannau.net, neal@gompa.dev,
 amitsd@google.com, samkay014@gmail.com, spacemit@lists.linux.dev,
 asahi@lists.linux.dev, imx@lists.linux.dev, wens@kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Sebastian Reichel <sebastian.reichel@collabora.com>:

On Fri, 29 May 2026 12:18:15 +0200 you wrote:
> Hello,
> 
> this series targets to use named initializers for platform_device_id
> arrays. In general these are better readable for humans and more robust
> to changes in the respective struct definition.
> 
> This robustness is needed as I want to do
> 
> [...]

Here is the summary with links:
  - [v1,4/6] power: Use named initializers for platform_device_id arrays
    https://git.kernel.org/riscv/c/e28f7498dd81

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


