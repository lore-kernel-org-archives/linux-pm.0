Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.36.144.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795293704;
	b=gvqQA9cR5cLksoRJeODhRxPO7OT0bUEKHbtmWhwCuAXRR1ydaSEZHOj61sUgaOYJHA97
	 2hslUCdob6dSYcFYoOm4rocIs750jO/ffMCNhLKlZ9IYGEW2I7L20lMKIEOu6KyoB13dC
	 n4v127hrJZdh6wv0mgHPyDho5r+erp8+BQwkmdXlRxUgpYpjPw5xugj7akkYAThKK0pZJ
	 pBMKFaTh6iu9gCgSlr3JmlmEB3C+/E+HK2NVPc543fH9+uNHiccSwRp/GqOOgxTtv5KDD
	 QXhmjCVazO+ar6axXdwMW0JiuJDAgTQRrsVWigUjTxnMHDRCd2vMJNSJFfDQNW3Ibgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795293704;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=PDCvLMGwM11MK3WEkdDTeME/kwH28+87zeqhQ6FbLP4=;
	b=ltC1GT2BM+f7lj0XIBDf2Q+9u1Y7ypspSfD7rOf8h9wL81ISUDYrfXVjNq+TGNSFkI1T
	 nUJJaGlEdD3+u0hp7JpygG3xS4a3NWO5KEC0XE0PvgLI95Yrphp5wvdaVxopQknpl/3KY
	 O9HVP+UgPm3yZPuRnQkW/W0LyR6Q5VhZRQQioOgreXX0oV+5T5VbG78gagZ0FjvxPIILD
	 3Fg+18B/dMgs5WN3RWNXgLporUOCqUP6vjRDO7+goYJsSgjOb8HKCeQgckXuGBK6TwBeu
	 ySKU2lS7iF4c08AVZE4nDW7MBh7v4iMQ1hgm3HTCpYjwOV9tFWdUjie98Af7Dpabxcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yoxcu.de;
	spf=pass smtp.mailfrom=yoxcu.de;
	dkim=pass header.d=yoxcu.de header.i=@yoxcu.de header.a=rsa-sha256 header.s=dkim header.b=ABnx6ix+;
	arc=none smtp.remote-ip=194.36.144.171
Received: from morty.yoxcu.de (morty.yoxcu.de [194.36.144.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D795606A331;
	Sat, 21 Nov 2026 20:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D795606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yoxcu.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoxcu.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoxcu.de header.i=@yoxcu.de header.a=rsa-sha256 header.s=dkim header.b=ABnx6ix+
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6D4801D8725C;
	Sat, 21 Nov 2026 21:41:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoxcu.de; s=dkim;
	t=1795293701; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=PDCvLMGwM11MK3WEkdDTeME/kwH28+87zeqhQ6FbLP4=;
	b=ABnx6ix+8oXQAynS/NA64vi6Szw74GhE5Y/XsR8w12VkoHxxNACd9f7Sg7sq67+9l/M0Bi
	KbSksxP1ipriSJzTaRfDlpZvg78D4SjwdfH4JugbmNPzxnubfUcrn/PGtOXDBJBdKT/Nmj
	34dMjTTLb/vguX5c+Ja6KL0ijykZCyT3J8ipXywLSzBeZUy9Yq6zkuyNS0PnZEQbHy3rjY
	0EPq2r6J6bf6mz1HLqGo6mKKV3frLwT32fvDsv01u8ryFTdR492inLQKah0m1/y/qa8E8P
	wz1ZT3Fkf3LJ6Tg/xoM9RRsI5MJNIq/UXIc6nhQFJho7YjbQFjqixxi6BqY8UQ==
From: Michael Auer <mick@yoxcu.de>
To: Sebastian Reichel <sre@kernel.org>
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Auer <mick@yoxcu.de>
Subject: [PATCH 1/3] power: supply: bq27xxx: report discharging at zero current without a charger
Date: Sat, 21 Nov 2026 21:41:35 +0100
Message-ID: <20261121204137.848173-2-mick@yoxcu.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121204137.848173-1-mick@yoxcu.de>
References: <20261121204137.848173-1-mick@yoxcu.de>
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
X-Last-TLS-Session-Version: TLSv1.3

The status is derived from the sign of the current, so a current of 0
is reported as "Not charging". On a OnePlus 6 (bq27541) the first
current reading after a resume from deep sleep is 0. User space then
sees "Not charging" while on battery: UPower no longer reports the
device as on battery, and the desktop plays its "power adapter plugged
in" sound after such resumes, until the next reading shows a negative
current again.

"Not charging" means a charger is present but not charging, so report
"Discharging" for a zero current when no power supply is online. Do it
only for the direct property read: the cached update runs under
di->lock, and power_supply_is_system_supplied() also reads properties
of this battery.

Signed-off-by: Michael Auer <mick@yoxcu.de>
---
 drivers/power/supply/bq27xxx_battery.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 747a38d3390d..032eea030f2f 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1942,6 +1942,14 @@ static int bq27xxx_battery_current_and_status(
 			val_status->intval = POWER_SUPPLY_STATUS_CHARGING;
 		else if (curr < 0)
 			val_status->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		else if (!cache && power_supply_is_system_supplied() == 0)
+			/*
+			 * No charger online: |current| is below the resolution (e.g. after
+			 * deep sleep). Only for the direct property read: the cached update
+			 * runs under di->lock, and power_supply_is_system_supplied() calls
+			 * get_property() on every supply, this battery included.
+			 */
+			val_status->intval = POWER_SUPPLY_STATUS_DISCHARGING;
 		else
 			val_status->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
 	}
-- 
2.43.0

