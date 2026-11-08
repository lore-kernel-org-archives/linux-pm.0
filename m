Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=94.231.106.230
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794152590;
	b=QARGOJlDQpAxJ6HTkgme9sWDf7FpsVfX4tkpg+Vua4P9Q/Hh712RzEg6IjkeXPycTRUH
	 Nouh9Ip2ANUd6GcA7qJwt3fBu4bWplMVruQCuue+ykhNXCm1IdwifZunEOcgIhSikC1xY
	 4J2sOd1e00OsYW/5XR2jmij1lWNOWtK7YhlQTo0pRL/XbGUuCI/QBIdxa8b7xmx7Ii1v8
	 wVopYbsxD7Zl24b9zbrpx8L/eXUAbUEN6/KqoEim8zCRb5gUIfe+xCCPkw1NzzVYu8fTn
	 P8q7UacAc/3z7cXckhH2Ny53F84xHArSWoZPX0Dh1sNn34PTTBOGyBC/iybZz4Up7rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794152590;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=QkSaJ9U9xhzjHIKE511S/szzh3t0nK5sJNojzs+tzIs=;
	b=5NTsgH9vFbCpHSSruPNiqQGgbGEvjBb/i4RXRUq28s9aenxg0DkrrkRLf6dLa3d2Rcww
	 iUTW8qiAnIU/ucOLzuosMgOinpFZokWtBQ8yZXeQnsebhZ+Jl/tn1meSfwHCHSyVXKcLj
	 1ZrWiv7ZlNVpQfGIlX0S7uDFhY7G5y+p0AFWnB3xrjPxqL1f0D6DD6dgqkIBN7/yN5gij
	 Sh+8YmE1vjqABFNHlWSGXtSxq+Ewfg1ZHjW4LsXmQPRj3OBf1bW4MzGWcMOZXXOKVzNt3
	 6akpOcU037enDqT1mSYO6ddDQUb4D9AhQ7SpsKyWctaTRyRdonc4rk0EhnbkklyD2Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=klattorp.se;
	spf=pass smtp.mailfrom=klattorp.se;
	dkim=pass header.d=klattorp.se header.i=@klattorp.se header.a=rsa-sha256 header.s=simplycom2 header.b=jMjQAyGf;
	arc=none smtp.remote-ip=94.231.106.230
Received: from smtp-out2.simply.com (smtp-out2.simply.com [94.231.106.230])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931B0606A31C;
	Sun,  8 Nov 2026 15:43:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 931B0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=klattorp.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=klattorp.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=klattorp.se header.i=@klattorp.se header.a=rsa-sha256 header.s=simplycom2 header.b=jMjQAyGf
Received: from localhost.localdomain (81-228-203-110-no2102.tbcn.telia.com [81.228.203.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4jMxy842Cmz1DDh3;
	Sun,  8 Nov 2026 16:42:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=klattorp.se; s=simplycom2;
	t=1794152586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QkSaJ9U9xhzjHIKE511S/szzh3t0nK5sJNojzs+tzIs=;
	b=jMjQAyGfC8hGZ0J+pZE0mMPJVb/i/omEq9UTOJ50eAUt83eHRzc4z4123Y5mRbOsuvfMwT
	/xsI1CUS1HZSpZ4FkagwX1oc8sNj/Cn92OinbFZ5irUyz9CNRrxtED5BZZgMQgG9wNSdWw
	cOjy89jv3NLoM06/bny/IVBV6hbb0RCb/hiF7qB3RigzKewW2qCx4JgWwo/fPeqbo1spSR
	bLLAsqnyMeWyIMg3IU0MUxZLKFCRQ5eU+6Qug70FuklCViKNhI2SW85NhmpKs3OuYp7ZYr
	hFeSX+c2LYBG/w8ywZI5CzyOvuEFMgQOEcKZ3da6PeAC3hcYLV9DlCnlL1FbQg==
From: Hugo Karlsson <huggek@klattorp.se>
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	matheus@castello.eng.br,
	me@iskren.info,
	krzk@kernel.org,
	m.szyprowski@samsung.com,
	clamor95@gmail.com,
	Hugo Karlsson <huggek@klattorp.se>
Subject: [RESEND PATCH 0/3] power: supply: max17040: report charging status from a gpio-charger
Date: Sun,  8 Nov 2026 16:42:37 +0100
Message-ID: <20261108154241.198160-1-huggek@klattorp.se>
X-Mailer: git-send-email 2.55.0.windows.5
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Resending with LKML and the remaining MAX17040 reviewers in Cc, which
I missed the first time. No changes since the original posting:
https://lore.kernel.org/linux-pm/20261108144548.190622-1-huggek@klattorp.se/

I work on OpenFlight [1], an open-source golf launch monitor built on a
Raspberry Pi 5 with a Geekworm X1202 UPS board. The board pairs a
MAX1704x fuel gauge at I2C address 0x36 with a GPIO that is high while
input power is present.

With the gauge and a gpio-charger described in DT and linked by
power-supplies, the battery still always reports status "Unknown", and
capacity reads above 100 when the cell is full (103 here). Desktop
battery indicators then show the wrong state, so we have been shipping
a patched taskbar plugin to work around it.

Patch 1 passes the device fwnode to the power supply core. Without it,
power-supplies is never parsed, so the supplier status lookup added in
commit f4b782af61ae never finds a supplier.

Patch 2 covers suppliers that only report "online", such as a
gpio-charger without a charge-status GPIO: the status is derived from
power_supply_am_i_supplied(), and the battery now sends a change event
when its supplier changes.

Patch 3 clamps the reported capacity to 100.

The series is based on for-next. I tested it on a Raspberry Pi 5 with an
X1202, on rpi-6.18.y (6.18.50), where max17040_battery.c only differs
in the style of the i2c_device_id table:

  stock driver:          status Unknown, capacity 103
  on mains at 100 %:     Full, capacity 100
  unplugged:             Discharging
  plugged in at 98 %:    Charging

The battery's uevent follows the charger's within 1 ms.

Related changes for the same boards, for context:
  - Raspberry Pi overlay that links the gauge to the charger [2]
  - Raspberry Pi OS taskbar battery plugin reading capacity [3]

The patches and changelogs were written with Claude Code
(claude-opus-5-5) from my description of the problem. I reviewed them
and did the hardware testing above.

[1] https://github.com/open-flight/openflight
[2] https://github.com/raspberrypi/linux/pull/7744
[3] https://github.com/raspberrypi-ui/pplug-batt/pull/17

Thanks,
Hugo

Hugo Karlsson (3):
  power: supply: max17040: pass the device fwnode to the power supply
    core
  power: supply: max17040: derive status from an online supplier
  power: supply: max17040: clamp the reported capacity to 100 %

 drivers/power/supply/max17040_battery.c | 28 +++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

-- 
2.55.0.windows.5

