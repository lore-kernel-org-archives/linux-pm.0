Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388A834A3BF;
	Sat, 17 Oct 2026 21:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792274196; cv=none; b=OOvTm1I5mwcFk/oQ0tYwQobZbyvQEBm5pcXL+MxCyinUVq1usVXARugRDGLXcphdnvAjVYdOgmjTPHVLgASt3AmCKJUcllVxw8SmF7CGU2drGyO81/7Cf8NlqwgfbwDtdQhZNh5RQrAgcnc6hs5pr92oDwUY4ESfg1yTYWknybk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792274196; c=relaxed/simple;
	bh=vG+dbOO9Uc39dHC3OykJb9JysrYH/d01DcFh6v+3gk4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UN5O8VHLEk1BQnLAoxIpeKJ6rVJoz2hdIB1UPuYZpHXf+6dYLKjwMsIUON1C1Ln2tzyeTORK/YhY4N+Jd5i5H/Lz4mrVz4uFxK2eySTDEk/tMaLziRlWqd17yAfYSEGraWefGE4ub6gHfICc+HqUGZzhTXdZnyE61NCGrnTpruc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19CC1F000C7;
	Sat, 17 Oct 2026 21:56:34 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 73B171824B6; Sat, 17 Oct 2026 23:56:33 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Robert Killick <robert@killick.dev>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261005-ratelimit-enum-warn-v1-1-b77b48de3c47@killick.dev>
References: <20261005-ratelimit-enum-warn-v1-1-b77b48de3c47@killick.dev>
Subject: Re: [PATCH] power: supply: sysfs: Ratelimit "unavailable enum
 value" warning
Message-Id: <179227419346.76434.539527530029783625.b4-ty@b4>
Date: Sat, 17 Oct 2026 23:56:33 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Mon, 05 Oct 2026 14:56:45 +0100, Robert Killick wrote:
> power_supply_show_enum_with_available() warns every time a driver
> reports a value that is not in its declared set of available values.
> For usb_type this happens on every sysfs read and on every uevent, so a
> driver that reports such a value and calls power_supply_changed()
> frequently can flood the kernel log.
> 
> This can happen with drivers that pass a firmware-provided value
> through unchanged, as qcom_battmgr does for usb_type. On a OnePlus 10
> Pro (SM8450), whose firmware reports a vendor-specific usb_type, this
> produced ~128 warnings per second and kept systemd-journald at ~30% CPU.
> 
> [...]

Applied, thanks!

[1/1] power: supply: sysfs: Ratelimit "unavailable enum value" warning
      commit: 4d49915df53ddde71556e507bdc49b81cd4609c8

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

