Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C95482D4;
	Wed,  9 Sep 2026 20:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986996; cv=none; b=kVvf6n/ePhk4knZMdDl0QrItt1mIxvtk/Lf3TiZ37IUnSgOoBDg4UGQxFqFSOu3o2y97racmc7pwZEleQVNeXuuliduVlG3h0hGOQsX77OX/uxqHU6B9/x73hCKYLmZm1TuhYkrWvNfplDxg/HRDgp8cbtI7AURS5+ryxy01kJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986996; c=relaxed/simple;
	bh=Az6R6HSt2zg5EvIM6TeasZD548ZeBo/zw10xbogSfq4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=miKh7M4Gk9DEMzoKaqUsFNozP5ABcHqY7e4qSgF7RiiGgucb1ay79gSFPKvugUE+bWCftStTJ0n14o9fJTeee3ADdCeX1d4yx3UId9TcPbYPaeX87MrMNZMeyqXUwH9JLuhcKggLmN+V/AURz1D/k7zhCYa05Hx7sgdkZrqBRo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0991F008A0;
	Wed,  9 Sep 2026 20:49:35 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 1E0E4183381; Wed, 09 Sep 2026 22:49:32 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Mark Greer <mgreer@animalcreek.com>, Liam Breck <kernel@networkimprov.net>, 
 Ryan Brue <ryanbrue.dev@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260908-rbrue-suez-upstreaming-bq24190_charger-use-wake-irq-api-v1-1-c3f10ae2a34a@gmail.com>
References: <20260908-rbrue-suez-upstreaming-bq24190_charger-use-wake-irq-api-v1-1-c3f10ae2a34a@gmail.com>
Subject: Re: [PATCH] power: supply: bq24190_charger: use the wake irq API
Message-Id: <178898697211.883277.12562040233246462716.b4-ty@b4>
Date: Wed, 09 Sep 2026 22:49:32 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Tue, 08 Sep 2026 00:35:58 -0500, Ryan Brue wrote:
> bq24190_probe() calls enable_irq_wake() on the charger interrupt and
> never calls disable_irq_wake(). That is wrong in three ways.
> 
> It is unbalanced. free_irq() does not touch desc->wake_depth -- only
> irq_set_irq_wake() does -- so after the driver is unbound the descriptor
> is still one wake reference deep and the irqchip is still configured for
> wake, forever, for an interrupt nobody owns any more.
> 
> [...]

Applied, thanks!

[1/1] power: supply: bq24190_charger: use the wake irq API
      commit: 00465cb99af254dee479be51b793a49a0af442bf

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

