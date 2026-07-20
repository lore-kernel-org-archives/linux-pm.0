Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1621D266B46;
	Mon, 20 Jul 2026 22:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784586222; cv=none; b=G9u8KRxsWyFs/igkAl6Fcnu2sQabDcqBUIQaHF5PWa6RtAYRbCV7YJWl5zNR86uqB58m42z6jmz6jCO8d4L7s9F2G7e9ANBeTPPRG1RoLrztggSrhhc5ZKiTtTgAvrXopkhI0flTTBw2uGt5Di09uGh0zVZq3scHFsMV54leLoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784586222; c=relaxed/simple;
	bh=xQOBhCjSVyP4iEh8rj8xe7/y+eeDChaJZ5kbmIWnhZ4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Jm7rRzqTf2MuRKfR2yn5uT3Hz5IrOBmiHDqv1VzFVxZSq6xFGFu/9v+yaVOIgIBsJJi63Ny1P+ISBI8HSF8AshnCfJ/V5rQ2NRihJYJrLSJ5Os+vgQJUyUEUoS5pazGffuTVaXvXCQoQHhjxuO5qFfHgEnMTaV2z+ICY+p87I24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12CE1F000E9;
	Mon, 20 Jul 2026 22:23:40 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 1F0C7180A25; Tue, 21 Jul 2026 00:23:39 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Steffen Dirkwinkel <lists@steffen.cc>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
In-Reply-To: <20260625-std-power-supply-triggers-v1-0-d80db570d329@beckhoff.com>
References: <20260625-std-power-supply-triggers-v1-0-d80db570d329@beckhoff.com>
Subject: Re: (subset) [PATCH 0/2] power: supply: leds: add triggers for non
 battery type
Message-Id: <178458621911.342392.13043795519489176747.b4-ty@collabora.com>
Date: Tue, 21 Jul 2026 00:23:39 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 25 Jun 2026 19:07:33 +0200, Steffen Dirkwinkel wrote:
> We want to use the power supply leds to show a different led color based
> on ups charging / non-charging state. For this we add support for led
> triggers for non "battery" supplies and a "not-charging" trigger.
> 
> This is roughly how it would be used with a device tree power ups supply
> to have a violet led on power failure and green on power ok:
> 
> [...]

Applied, thanks!

[1/2] power: supply: leds: create triggers based on properties, not type
      commit: 439262f91f9832b42a978cda935ca3c955bdde1e

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

