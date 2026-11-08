Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=94.231.106.230
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794149173;
	b=T1XEa1ScnG1iu8To7tGQkCK558BNA6VvfiPj64S++L5EV3SlCLlQ1TPWWTGIEUQblEvR
	 ztp5Z7OTp5BJ9k+4ROzck3+hQTVtxxkAAttu7fuFZawxjON22xhWLfISBTZ4mmo30UdaV
	 Rq+mT85/RcDowQhh8AegURMdxLUNDgLiBzWZ/EFC0AbnyJjXyQawZG7//gvFVq4tzKhrP
	 VHlR7dqm8ksuYjlS9XZ5GTM02EGCEVoLEOGO8CcDYnCsR8B0TVkNKaaJ4fNKc/UDeEaqR
	 mFHbPhjOLoIW9v9jfXxkq2wFnHfib/blstbAxqACTwEgYlCaIhJnRdrT3QYHaN+6hPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794149173;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=bsxNgTzNgJB2xWQa4hLNl48h0PrbifHfCY0FD++wrQ0=;
	b=miRhobE5R9XwGseGrY93ATYH3yrrcP5+sbmZgw57s2WX+soJ0RCKKxM5gbMsPGidqGtM
	 IOPgXdoyEL8zRfXlX1S9yID3rzjs4Xbo+T/arune+pK5iTuE7XNti3Z9jQyIuMLJNfctx
	 uUSem/U9FUkvIAWr2KQUhO6j4lv5DzPCp9CWEFi2OhF8CDmuFJVwjXN1SBIRSEUtZ+Gn7
	 x33GgSqFlu0dq1mGacRyLV3LUjBbJgmxqt37K2+ueeIKTml/g3p9rDfO2Sv2n2bBorTIQ
	 4xcSyg/EDbYHi8e3DqjtJPuQNl374qzrWT2If7Z/WUmxKRAfwIpa3fG2RY7IwP2ozPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=klattorp.se;
	spf=pass smtp.mailfrom=klattorp.se;
	dkim=pass header.d=klattorp.se header.i=@klattorp.se header.a=rsa-sha256 header.s=simplycom2 header.b=QWrn2LoF;
	arc=none smtp.remote-ip=94.231.106.230
Received: from smtp-out2.simply.com (smtp-out2.simply.com [94.231.106.230])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22DF606A321
	for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2026 14:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E22DF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=klattorp.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=klattorp.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=klattorp.se header.i=@klattorp.se header.a=rsa-sha256 header.s=simplycom2 header.b=QWrn2LoF
Received: from localhost.localdomain (81-228-203-110-no2102.tbcn.telia.com [81.228.203.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4jMwhV1jbyz1DQsp;
	Sun,  8 Nov 2026 15:46:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=klattorp.se; s=simplycom2;
	t=1794149167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bsxNgTzNgJB2xWQa4hLNl48h0PrbifHfCY0FD++wrQ0=;
	b=QWrn2LoF9NWuADeg6eiR+lrPiF556rWLL3ydKtQvOLsvWS4NxQc/96jlxRPjZ59/1EWByb
	Eo4qrpfAgzfKpzCkzMY3soeInBAhNKjkkeQvur6cOq4mly2axM101uZHjZnsZLkHsIdWgP
	wFudwN16AnFHBT5ufUI/6izDe4wweRO5GcTHwntoYyIx2I46bIQyDmfL1BJtdNT53955/2
	Uj71Isi6C67WRGAF7P6LJpg0u7drEtXzZeqBCvKA3yZx13xvfjeo18IrAoG2GPk/JD+DjE
	kEDQT9St//uX6WSToDxFP+czSySTmme63pL3tuqO7E3uLyszsQl5dGvtvg/JeA==
From: Hugo Karlsson <huggek@klattorp.se>
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org,
	matheus@castello.eng.br,
	Hugo Karlsson <huggek@klattorp.se>
Subject: [PATCH 0/3] power: supply: max17040: report charging status from a gpio-charger
Date: Sun,  8 Nov 2026 15:45:45 +0100
Message-ID: <20261108144548.190622-1-huggek@klattorp.se>
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

