Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66603B9DAA;
	Wed,  1 Apr 2026 14:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775055106; cv=none; b=Sdir5LOx94Ix/UAP+jL0+RFcFZphw4xZpUxrYkLW+FNvJ6KoDrQa6iSgdP7fmJ6Uswon+MaAHf491uS4e3I0AQYcXLDJ/9LiwVNmBGIr6l69Owh6MUogleejT3ACWq4StftBknMHyGh7k+xlygw6xAbvHrEEVIFWQGfAziCyRCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775055106; c=relaxed/simple;
	bh=qC3pqqL20WPD4j24+FqyUnsgjxX6qkBp+hFH+T15ZDY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sMeMC4BR6ITwZLA3qP5xacovy10/P+f2O5l2oHY/SoEfXF7Q2qxexHZ9h+seogGOHW08M4mPnJD1UkKIf+wkDN8DfmDuG30jD1qPySMfD7Scodp16i/OM3KH7jerlm2BQ5F+fJdVAPaCTqfTxaGKtpaThc+Akz7ci/+hGXaU2jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfgY1gR5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfgY1gR5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F112C2BCAF;
	Wed,  1 Apr 2026 14:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775055106;
	bh=qC3pqqL20WPD4j24+FqyUnsgjxX6qkBp+hFH+T15ZDY=;
	h=From:To:Cc:Subject:Date:From;
	b=hfgY1gR5eu+oNf8TXGlmVe7KkFTVwlBeCMFGOGC3Xubi+ItRfWH5GOXOlaAtiDjUf
	 yxjXcMLJ+uckL8F4xajufbJO8LNdH8oqo/u/jwrJsDWxm5lTXf3K7DZc+oQRt00IpD
	 UdkoLlqp1JLIh0ZjTVx1Eps2cQ66Sxjhu0IwmqZ1lTXhzoyklLWuMyJiWbQL+qTm3Y
	 r7FSkDSQ7mW5lgABoFSzgXkn0WHzEolbMSkv6rSAlRytFukF2C2AX25k76VB+cNyOx
	 yJthsBKuWh7tV+hgDSZpFvuVTyCzqkrxAEZQEdT6dJZEblmV2oCbeIJTTyfreySvgb
	 omq+eJi4gPRFg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v2 0/4] thermal: core: Simplifications and suspend/resume relocation
Date: Wed, 01 Apr 2026 16:36:24 +0200
Message-ID: <6277980.lOV4Wx5bFT@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi All,

This is an update of

https://lore.kernel.org/linux-pm/4745677.LvFx2qVVIh@rafael.j.wysocki/

that reorders the last two patches and modifies them to address Sashiko
review feedback.

This series is intended for 7.1 (it applies on top of linux-next).

It removes a redundant check (patch [1/4]), changes the thermal workqueue
to an unbound and non-freezable one (patch [2/4]), relocates the suspend
and resume of thermal zones closer to the suspend and resume of devices,
respectively (patch [3/4]), and changes the allocation of thermal_class to
static (patch [4/4]).

Thanks!



