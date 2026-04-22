Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCD53F0AA6;
	Wed, 22 Apr 2026 19:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776884999; cv=none; b=PlqVOJN14MozxIrpkA4A59RKZusWNPbh/T7VZwaph0x4FffOXlNb801MJ8B+VJy/92OnoDvIw6mTCBqMDaikUThhuI1b+PZusAs/yMIaim4u8NzSvbHp3faHYfGqTzeTLZdnKEGb5UCv8PbUOKq0yqcq5byWxYdLhoiIXViMULA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776884999; c=relaxed/simple;
	bh=TBf7TmpiLrOjFz1uYFwP8HW9565Eo2G/9mS/oOBxeNo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F36B4fOp6lQBsV8/YeQcjTnb2BwRXCTIe6DOu9hhRr8SSGhWaS5AulZwEULyZpi6emQHnvS4+3twuXV1PZWuZqPQPJG7rf/3BkO3LraXBPynb2sY4zqwGg7AUHH9m+bHhuXd1WvgUOiskrFnAM8LzhBONisYfzhqcI7JAs7bOgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SoLzVJJF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SoLzVJJF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38AB1C19425;
	Wed, 22 Apr 2026 19:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776884998;
	bh=TBf7TmpiLrOjFz1uYFwP8HW9565Eo2G/9mS/oOBxeNo=;
	h=From:To:Cc:Subject:Date:From;
	b=SoLzVJJFz2ltqnRFTwdN9H1izK6SgbR8porrSawjzQ/pzmxRA7Ff6FWx23jVXlYhY
	 LnDGNnmrFrVn61Z2UblmlRFCWMIBuFcZ5/CGF1p2MPlQKKfWulqtDfGfJcY2TZM5TK
	 Uj1VyyAGhWMf9DdhlGKEEsM7QdKe+HnV+5xB36N7I+Ms1T8DPOah8g95YcnsOhR5Cp
	 J4RbJldD6NUnHIgHUFAnHTbdKmA9uoAvmuA8YknmIEwYwnjyOb5Y72kJBOkLBRP6p9
	 vaR4LsGCuoikGha3TH630u/ukC/rM/8THFBN5rEbKu75R4WctRFDgx7ACvsDCeGNq8
	 WWo6v5X5/OReg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Armin Wolf <w_armin@gmx.de>, Jiajia Liu <liujiajia@kylinos.cn>,
 Marc Zyngier <maz@kernel.org>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 linux-hwmon@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject:
 [PATCH v1 0/2] thermal: hwmon: Rework of automatic hwmon device registration
Date: Wed, 22 Apr 2026 20:53:20 +0200
Message-ID: <5100596.31r3eYUQgx@rafael.j.wysocki>
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

The first patch in the series reworks the automatic registration of hwmon
devices for thermal zones so that one hwmon device is registered for each of
them.  This is done to address a thermal zone removal deadlock related to the
sharing of a hwmon device with other thermal zones of the same type (see the
changelog of patch [1/2] for details).

The second patch simplifies the thermal hwmon code further by using the
canonical mechanism for registering extra sysfs attributes of hwmon devices
instead of manually adding files to sysfs.

Since this is a quite noticeable change of behavior, the patches are targeted
at 7.2.

Thanks!



