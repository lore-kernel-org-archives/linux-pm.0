Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6AA3CB8E2;
	Fri,  5 Jun 2026 20:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780692947; cv=none; b=gReanTgcFOmFGzVQ4AijlC6aTH8iJSMqTNvrzm73HR27SWqlRsHdboYZ8YObkqxvyKxLInn7on6dZPV6yrHcYZuu4C9GGzyvTDnMkq8ncNeLw0Y+idba6SQRPO3GgljDZNKP3scMEosLsW0AiJdU4dDfHsmEZL3+EjYU9Vr6KbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780692947; c=relaxed/simple;
	bh=AyzA0eml0iOYyTflY/tllt6lB/K5fOrM6scBdgLQgf4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=obHKYIjIRsK0tJyieHZqBnf0+7o8RXa5Z+WlFXvBv6L9ekOQJKwTha/LNZynBCZDCaMDzCfWg+82Kxze53JD5k1PRZOHf3tGAXNNh7id7P8qTWY2OgCeW+xxWxGVx2JbLEmTLGfGc17LQ/QZ21Yu8T9SclLmB9HpXSgMS9cXel0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A0D1F0089A;
	Fri,  5 Jun 2026 20:55:46 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id E298218385C; Fri, 05 Jun 2026 22:55:43 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, Vincent Cloutier <vincent@cloutier.co>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260604-max17042_battery-fix-unused-suspend_soc_alerts-v1-1-3562a68e6f36@kernel.org>
References: <20260604-max17042_battery-fix-unused-suspend_soc_alerts-v1-1-3562a68e6f36@kernel.org>
Subject: Re: [PATCH] power: supply: max17042_battery: Use modern PM ops to
 clear up warning
Message-Id: <178069294390.3296539.5725010536034064179.b4-ty@collabora.com>
Date: Fri, 05 Jun 2026 22:55:43 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 04 Jun 2026 22:52:28 -0700, Nathan Chancellor wrote:
> When building for a platform that does not have power management, such
> as s390, there is an unused function warning, as
> max17042_suspend_soc_alerts() is only used in max17042_suspend(), which
> is under a CONFIG_PM_SLEEP #ifdef.
> 
>   drivers/power/supply/max17042_battery.c:957:13: error: 'max17042_suspend_soc_alerts' defined but not used [-Werror=unused-function]
>     957 | static void max17042_suspend_soc_alerts(struct max17042_chip *chip)
>         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied, thanks!

[1/1] power: supply: max17042_battery: Use modern PM ops to clear up warning
      commit: 4acc0138c4f2fba453da5a5076ad2bba08a7463b

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

