Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.36.144.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795293704;
	b=e5lIHULY1hfPXgRH6fvz8YEjmO+uf844hhuz8vvIfKw/GG+TdcrDqrWvKnMUP8vNFz0Y
	 3h+Lv7+uRElseqiqo7h6sDByh9OWzBFMveuunvaTw2VUsLAqBkH/bBkk3mpo/uDN25nix
	 JB/osCMmxLja8wYn93hWzHxFPQWn2uTIQi6rHv/bPY5dwp3vciMmZi8f1U1YWI25/54dG
	 p2bN5a75r5IBiDZ+w3rZC8vx4bNUNXGKzrlI7HMpFLXB6xwV/yDt/syxzKFypvfZXXTzp
	 hdcqLT2in9bRsvthNzXouGaHXHjrv32adqndq+SgSdqZEDaZuuMWU5wqvmDUo1ENGAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795293704;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=hxznbjStejhZ+qN3tZXdcsjGqDjQRxYMb8Gmd/IAPqs=;
	b=BvW30LKREx/3BrNJ0jiIw5DCSlXF2uQy20C7PrXOT0VrFUrB5fNT4omgIy+LP5GYXhf0
	 Aok0F6RorwYelw7vmZH2lJwWOGeO9L5c9SqqrW01Lmve1Iz3Umjwu2+laA3HrouAVhlNi
	 qv0hDzUZD46W+PbgD2dfgi5tfOM0RO4NhsrnLYb2p69xBmEvaRy2RosNyg7Yu9QGEyjAW
	 BtYB1FS1NRfBf+PDY71z9CxsjfyOG5p6boRXyc1RxFnuFokt2SwKh6EKft+eEodZ6wXHB
	 LnTbEmAxe7FeYDI4MGNeO1DRC1PNLggZT6oksDyA5kDc3JHMz8bCP6XUAoKqspU9XvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yoxcu.de;
	spf=pass smtp.mailfrom=yoxcu.de;
	dkim=pass header.d=yoxcu.de header.i=@yoxcu.de header.a=rsa-sha256 header.s=dkim header.b=J4qe7ogC;
	arc=none smtp.remote-ip=194.36.144.171
Received: from morty.yoxcu.de (morty.yoxcu.de [194.36.144.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338DE606A339;
	Sat, 21 Nov 2026 20:41:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 338DE606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yoxcu.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoxcu.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoxcu.de header.i=@yoxcu.de header.a=rsa-sha256 header.s=dkim header.b=J4qe7ogC
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2C6071D87240;
	Sat, 21 Nov 2026 21:41:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoxcu.de; s=dkim;
	t=1795293702; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=hxznbjStejhZ+qN3tZXdcsjGqDjQRxYMb8Gmd/IAPqs=;
	b=J4qe7ogCK0yswDjkhHFZpPpMnWuspeDWi8esEl69I+QG/Dit8PNPn/iAWxVCukFRZQ/JkN
	W5sfm0nwm/xv3GGYWF+KE+A+4MjMNFv+42z9xUPA6eEUnSVuXmXXjWTib9NpNcWr2qaPcr
	EcN+dKkarcRnAUFAqvRVxaAOfbPzp5jZiegxP57BOb+DDSdrNXxwaOE8CX1Zxj57g6HKqQ
	5CTQWiQzuBDgui3+xGw/Kl+F9QZg4JDAui7j6XHCQUsK3Il6BtXCZkq8pjfnmEiJXaXlVq
	uMFEBVucOn+Pvb6ayGApY+u6MVXAGaAUc830gq7OCewq84PKAro16xsBsR0Xyw==
From: Michael Auer <mick@yoxcu.de>
To: Sebastian Reichel <sre@kernel.org>
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Auer <mick@yoxcu.de>
Subject: [PATCH 2/3] power: supply: bq27xxx: retry a failed register read once
Date: Sat, 21 Nov 2026 21:41:36 +0100
Message-ID: <20261121204137.848173-3-mick@yoxcu.de>
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

A bq27541 on a OnePlus 6 now and then NAKs an I2C read right after
system resume (-ENXIO on i2c-qcom-geni). If that is the flags read of
the update queued at resume, the driver caches the error: for the next
5 s "present" reads 0 and every other property fails. UPower then
reports the battery as missing at 0 %, and the desktop starts its
critical battery action on a battery that is at 25 %:

  power_supply bq27541-0: driver failed to report `status' property: -6

The I2C read already retries -EBUSY. Retry any other failed read once
after 10 ms, in the bus independent read helper, but not -ENODEV (no
I2C adapter). A gauge that does not answer at all now costs 10 ms more
per read.

Signed-off-by: Michael Auer <mick@yoxcu.de>
---
I did not put the retry into the I2C read next to the -EBUSY retry,
because the error code for a NAK differs between adapters (-ENXIO,
-EREMOTEIO, -EIO).

 drivers/power/supply/bq27xxx_battery.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 032eea030f2f..dccb0f84ea1d 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1141,6 +1141,17 @@ static inline int bq27xxx_read(struct bq27xxx_device_info *di, int reg_index,
 		return -EINVAL;
 
 	ret = di->bus.read(di, di->regs[reg_index], single);
+	if (ret < 0 && ret != -ENODEV) {
+		/*
+		 * The gauge can miss a single transfer, e.g. right after system
+		 * resume (bq27541 NAKs it). Without the retry the whole update
+		 * fails and userspace sees the battery as absent.
+		 */
+		dev_dbg(di->dev, "failed to read register 0x%02x (index %d): %d, retrying\n",
+			di->regs[reg_index], reg_index, ret);
+		usleep_range(10000, 11000);
+		ret = di->bus.read(di, di->regs[reg_index], single);
+	}
 	if (ret < 0)
 		dev_dbg(di->dev, "failed to read register 0x%02x (index %d)\n",
 			di->regs[reg_index], reg_index);
-- 
2.43.0

