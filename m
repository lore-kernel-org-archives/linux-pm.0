Received: from outbound.ci.icloud.com (ci-2001k-snip4-11.eps.apple.com [57.103.91.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB93F2066DE
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 01:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.91.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784509933; cv=none; b=SWwAoI9+8RNVmAH7UmYLrH6nI+GCHOFrlyMDZ6QXkiGJg3kdFsDmZK6PYZTzBmqeiW0wOJt+ClbYyketxK/BpOGNnIKs6QEsrZmft8DPSLDuITdekXOXIgombt96ReskCgGur4iRun3Sg7bF+xTURAgrwX5ZqdDTj3Y2uDSZuWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784509933; c=relaxed/simple;
	bh=WuWCkEdvrb2h4vS91JHngedGnQPfvRM7UhLzbRwVLHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=imhGeulsN1RDCC8l42rYqGTDLPrclNUyPKUfdIiRIYOleJoXAASsB/j1r6P50BnlzM7KWQ0egFmUTa6MRdmQz8Gem5kiVohAakXWvlUgIsGvjOTfnU9yixM7xY6Mh9VlUH/d+xQwDNyvCHgkFKeRiSgzQhjPTGoyCckU/i4MWSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=VjtoIe2Z; arc=none smtp.client-ip=57.103.91.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="VjtoIe2Z"
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-1 (Postfix) with ESMTPS id D632C18000F3;
	Mon, 20 Jul 2026 01:12:08 +0000 (UTC)
X-ICL-RepId: 019f7d14-9572-7b08-8d1e-40d5255d4b78
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhPAEMGXAVeC1YBXwFLVxQEDloDVA5cBBcbXwJCH1sVSzhaDlsERxQXG1wAFw1WTVAbXwJCDxwTVhUTH1RWA0IZEFYBWFZdBU0aXBhZDxwTUFZaDlsERxQXG1wAFxtGAgQjAl8ARQJeCVYBMBcPVk1QG18CQg8cE1YVEwBeDw9MC0gBWwdcAEAJSQJcA18cQQtAA18GUh9CFA5aA1QOXAQXG18CQh9bFUs4Wg5bBEcUFxtcAAlLRglJHQ4EVAddBV0=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1784509930; x=1787101930; bh=i8a/m1R9oqsx6t0nI7k2MPlYERLMh/6Ev5E/3vcDxuU=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=VjtoIe2ZksE4gm/hPr3wkUZDH4Se80zAUaNE1eiFcjjrfD4ZcUt02wa19CEwTmmVlaAPpTyRNGzg5Cq+EMU59FvhmqlOgUgaEtod/5SRM9JLQGYXbLXwIYCtYuUNHTmLC3nwk3e8NZHXRnljY6FAFeUeileIlMUFwW1YRslDomEWxo5njcB8BemkEt0VZWNffqDCwLi9OFbPTvrPYNhzqEQHYxc73QQIrCYGg77RgSJu+MRHrVKokv99k/qg7s+32h+4zOsnjSyopTNHH5VCfWn1OrUeRIoKNLRcrEbS2sNpYnyQTlhsm0CGppAvRyqi9+ft+oGC1YBVsqvHCT6VSw==
Received: from bigre.localdomain (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-1 (Postfix) with ESMTPSA id D9B791800096;
	Mon, 20 Jul 2026 01:12:07 +0000 (UTC)
From: Vincent Cloutier <vincent.cloutier@icloud.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vincent Cloutier <vincent@cloutier.co>
Subject: [PATCH v2 1/4] power: supply: Add registration init callback
Date: Sun, 19 Jul 2026 21:11:37 -0400
Message-ID: <20260720011144.1280219-2-vincent.cloutier@icloud.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720011144.1280219-1-vincent.cloutier@icloud.com>
References: <20260720011144.1280219-1-vincent.cloutier@icloud.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: wMXmgb0c-kUkJ7eoY8hNL-V5Lp7AI4a3
X-Proofpoint-ORIG-GUID: wMXmgb0c-kUkJ7eoY8hNL-V5Lp7AI4a3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDAwOSBTYWx0ZWRfX4Gy+6QqrNwhU
 QiNMHwFHNe0hiNBiCNl8kgv2Vo3uKDANk5P0NaCyckXNmCJ+FAcDC9jYJzFkGJOZH9/iTlM2KA/
 sqNkW5VJrLoW7RHk3C+eyeSXMvra5Qwq5XYTg34JA3xpfaWp5MmI9/vhRB9Ygs3d8XiGysrK+8x
 kLCwySdGfYSj7BwgBZ9XsAratMjZDCoRKhKl9gLaVjWH/qsV4J91FbkzYRzhFT5W5+SezOX8WFh
 oFwrAr9Tok2MP/DYwffPIazzgNM1ifMOkXsw7592Bb83tl51NWUhTJ0mxB3OuJgYoMBIWPLsqxO
 0g3qeRkQ7wgBmLZCTOe

From: Vincent Cloutier <vincent@cloutier.co>

Some battery drivers need to consume monitored-battery data before their
power_supply is visible. That lets them prepare hardware configuration from
parsed battery information without racing userspace exposure.

power_supply_get_battery_info() already runs in
__power_supply_register() for battery devices before device_add(). Add an
optional descriptor init callback after driver data and battery info are
available. The callback runs in sleepable process context while the power
supply is still unpublished.

Require callbacks to return zero or a negative errno. Defensively reject
positive returns so registration cannot return an invalid error pointer.

Assisted-by: OpenCode:gpt-5.6-sol
Signed-off-by: Vincent Cloutier <vincent@cloutier.co>
---
 drivers/power/supply/power_supply_core.c | 8 ++++++++
 include/linux/power_supply.h             | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 2532e221b2e1..3ed4c253706f 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1624,6 +1624,14 @@ __power_supply_register(struct device *parent,
 	init_rwsem(&psy->extensions_sem);
 	INIT_LIST_HEAD(&psy->extensions);
 
+	if (desc->init) {
+		rc = desc->init(psy);
+		if (WARN_ON_ONCE(rc > 0))
+			rc = -EINVAL;
+		if (rc)
+			goto check_supplies_failed;
+	}
+
 	rc = device_add(dev);
 	if (rc)
 		goto device_add_failed;
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 7a5e4c3242a0..6042f5e1fdc2 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -281,6 +281,14 @@ struct power_supply_desc {
 	int (*property_is_writeable)(struct power_supply *psy,
 				     enum power_supply_property psp);
 	void (*external_power_changed)(struct power_supply *psy);
+	/*
+	 * Optional registration-time initialization. This runs in sleepable
+	 * process context after driver data and any battery info are available,
+	 * but before the device is added. The callback must not publish changes
+	 * because registration is not complete. Return 0 on success or a negative
+	 * errno on failure.
+	 */
+	int (*init)(struct power_supply *psy);
 
 	/*
 	 * Set if thermal zone should not be created for this power supply.
-- 
2.55.0

