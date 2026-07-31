Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC607403EA5;
	Fri, 31 Jul 2026 13:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503355; cv=none; b=fWqpqugunjDTdNdHqnIKb+Xwcbwb3WJT2MKz0J1cUcmX+tMymJ+m4410ZrzwHUa+7NC373tLOWtKyz31IsJ/pAiuCFYFwdHy4N0U3a2Yp2DuKKRHOvTOoy1PaDKmga0Mh+/yErEEq5m/aNua9ENO/sMu/dDc6kTVYlAigOyh7wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503355; c=relaxed/simple;
	bh=96X9AoyxnneXOLahB3ETfkz5Kc5Yjkb2nEafHiBJQPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jknKnK3IFXDNqr6d3NereKQgwN8IYkt6rt3suPrCwcCyAMplpLo+nmpMZy/e//ssGfgrsKl+gX/eLDNAV8F4G894AXMWu2/ANA0mV4Wc3Uc1nSdCivWsZfMIzQNsKi6/76fdwW80SbIFlVTIZ6ItTtoKdHfVmnctnHZg1f2j8VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/ESbMlG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/ESbMlG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B911F00A3A;
	Fri, 31 Jul 2026 13:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785503353;
	bh=96X9AoyxnneXOLahB3ETfkz5Kc5Yjkb2nEafHiBJQPI=;
	h=From:To:Cc:Subject:Date;
	b=l/ESbMlGknnRus02mWmGU8iRpM7vwWkthV3M8M1LQyCdydYAEKRLI0sIFz/dMffKZ
	 W/aioRQVgbg2qbMqeJtpx19vL0sxTgzyO2+NlDiy2fdiuUnXrDfoqbtGG3W7xCfwT8
	 wFnQBq6sPQxaqFkpf+GWIlix5U+l3j31Xk3Z/t8wV312VUfqCjz+GcqF7NHxtJxlF6
	 /8XSJYce10jtrJr4uSxC80WGhPHrHcszhbYDrX8za9PkpcpW1n5W5/3KR3wHM0LB0S
	 /PN/oGH5NAEgPrKa8g1hTDXACEXVqvSnM0rOiy2t3ypfIfAnJpOrxtPOBz4fOXFgmy
	 CXGlhtytBI/uA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Armin Wolf <w_armin@gmx.de>, Jiajia Liu <liujiajia@kylinos.cn>,
 Marc Zyngier <maz@kernel.org>, linux-hwmon@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 Oliver Freyermuth <o.freyermuth@googlemail.com>
Subject:
 [PATCH v1 0/2] thermal: hwmon: Restore automatic hwmon device registration
Date: Fri, 31 Jul 2026 14:59:06 +0200
Message-ID: <6319276.lOV4Wx5bFT@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi All,

This reverts two recent commits that changed the sysfs interface for
hwmon class devices automatically registered by the thermal subsystem
that were part of the series at:

https://lore.kernel.org/linux-pm/6017595.DvuYhMxLoT@rafael.j.wysocki/

Since they generally have made user space unhappy:

https://lore.kernel.org/linux-pm/cafd8af9-c6e9-4bf2-b496-23e796fbc9a6@linux.dev/
https://lore.kernel.org/linux-hwmon/ab8b093b-46e6-4738-afcf-4b97c9ad5af9@googlemail.com/

and it is late in the cycle, it is better to revert them now and
address the issue they were attempting to address later.

Thanks!



