Received: from outbound.qs.icloud.com (qs-2002f-snip4-1.eps.apple.com [57.103.87.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC6F22B8DF
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 18:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.87.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784660380; cv=none; b=USE+CvxwSn+kkWA+86jfLhvJitQsA02PF0Vvo6yJpxdxnK3v4T2lhDgCwk6W3mjIdDnXiLxLHHFeRwfwqXPvwUO95qwI0+eaj8G0+nb9ULmKbKbtYHeh/1QteMx0clTskcorC/E0OGOFZgN+J8iiYBbJ5sUldQUaiDOSMUPg9jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784660380; c=relaxed/simple;
	bh=WuWCkEdvrb2h4vS91JHngedGnQPfvRM7UhLzbRwVLHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QPdN1JZM6gU5Cu94YE9wYye9EuFQdqyr5/YyII94NL/FJMo22z/ZkNieIvJb1ebhvruhhBLEVtd01FjUCZ/O0Nnq0t6DtE3QWOJU6uXikHj7mnVZU5o4LR6KnIvhT3F2PfQg0BLU/IagNqW9xV2a+Y/BzmxrjyCE6WtkGpeJTZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=yj20YK3+; arc=none smtp.client-ip=57.103.87.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="yj20YK3+"
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-3 (Postfix) with ESMTPS id 63D9418000A1;
	Tue, 21 Jul 2026 18:59:35 +0000 (UTC)
X-ICL-RepId: 019f860c-36e3-7c8e-9a03-49e6f4402c20
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhPAEMGXAVeC1YBXwFLVxQEDloDVA5cBBcbXwJCH1sVSzhaDlsERxQXG1wAFw1WTVAbXwJCDxwTVhUTH1RWA0IZEFYBWFZdBU0aXBhZDxwBSlZaDlsERxQXG1wAFxtGAgQjAl8ARQJeCVYBMBcPVk1QG18CQg8cE1YVEwBeDw9MC0gBWwdcAEEIQAZUB18cRAlPBlsaWR8GUBZQCFkfHBNVF0YZXg5AMFAbXwJCDxwTVhUNTUMSQhUEEVABWB5W
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1784660377; x=1787252377; bh=i8a/m1R9oqsx6t0nI7k2MPlYERLMh/6Ev5E/3vcDxuU=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=yj20YK3++VdZQzFgxdvpYJN7cGI8qC0No/DpR7eRErY4xuJ0kfnQ1HMaepUbmgvrqMVzGCpVBbdohoQFml/7LzZW806sPzTx2jUkJlj8wO1dDKBcvTa1p/UCJRKGUhlU7kDqn1t/JioOq8DE5K1lSWED8mzJ2vZVnNBw2jSjFHMhB8qgBRQcRHG5KNbrVkWpai0FGeNvtOrx40Xr9VeT8MwLFGFK/d47A2A7a3TjghpRGL1NLwx/C+R/g9Ldta70stjlmJwv4VeKdSSImv65eBwDEH1Nh0wc48rpBzLWjR21aJbfmajN71cxrn995FUtg/DDiTem+IOKVDi4wiBA8g==
Received: from bigre.localdomain (unknown [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-3 (Postfix) with ESMTPSA id 0D7FA18004C0;
	Tue, 21 Jul 2026 18:59:34 +0000 (UTC)
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
Subject: [PATCH v3 1/4] power: supply: Add registration init callback
Date: Tue, 21 Jul 2026 14:57:33 -0400
Message-ID: <20260721185904.40756-2-vincent.cloutier@icloud.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721185904.40756-1-vincent.cloutier@icloud.com>
References: <20260721185904.40756-1-vincent.cloutier@icloud.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: hd58LFtUmY4QWRoH42Dlk6pe886Zw-iV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE5OSBTYWx0ZWRfXxq0b0a6yrEe+
 dTBvR8/RhoF3y4ji9W8cd34iHTrEMMt6Mv1zfgNiX2g3kbygFpC28vR2i7+H5o+QmhGf8Zb+hgY
 wLzeTfHq+BnE9HDPtEMTtuSa27aNTob3ma9lGcyAXi1Quq2wk72Ce86CDjXKQLvwVwupCJF3vKR
 7HZzwRX89JSs6pth1S4UStR8k+6ldF4KUo8nQbLM9OyLMp9sECh1zqFpt/+rt8septrz9jY4GkK
 IyiIXT+RAPGUKRT2AZcI2LI2iGDKP9cvmGjg2zkRBMyWPNKUkDl3G52nX6jqxJy1TYMXD2AZMyY
 J9u1IR7xWn6+aZQ07WQ
X-Proofpoint-GUID: hd58LFtUmY4QWRoH42Dlk6pe886Zw-iV

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

