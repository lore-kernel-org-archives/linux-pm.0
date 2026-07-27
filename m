Received: from outbound.ms.icloud.com (ms-2005d-snip4-11.eps.apple.com [57.103.72.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05298242D9D
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 01:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.72.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785114880; cv=none; b=sh7lyZzabEAFGrIOgm0N3O9xfwXIIsW9wo2iwJIv8l/av+rvsdlsW9t3WpXpfoJSKiSKdam+9c8LDG+hy4DFjac0kPL4f5lbJadgV7ZZo6fahen8diR3WGcFfmN9l1Nj6fOpu+w6aY3ogspLxWt35c4o6VKFzNktVyfQwhgc+KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785114880; c=relaxed/simple;
	bh=Zx2O73ey8p0KZT+sKmVRhOzDcvFD1FE08Ai24QHfgoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y5Yt/pE+yAdILXELs3zNX5HRLme/DO/c1tE5XDFUZ4H+YFxEY5hdBNmL6RjFtGRMrtEqsf2js8YtqpU0OPSRw/rDwqoAQ9cCCpzwS8ihAAvnq0UkfdK284UYqfMN9KyikHB3Y07QQ0j4ovlWqJra2RbAQTD//NDAGRwBEKzeXro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=zJu2bAP2; arc=none smtp.client-ip=57.103.72.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="zJu2bAP2"
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-10-percent-1 (Postfix) with ESMTPS id AE91118000A2;
	Mon, 27 Jul 2026 01:14:33 +0000 (UTC)
X-ICL-RepId: 019fa123-4ee9-7a9a-92c8-4de526b2513b
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhPAEMGXAVeC1YBXwFLVxQEDloDVA5cBBcbXwJCH1sVSzhaDlsERxQXG1wAFw1WTVAbXwJCDxwTVhUTH1RWA0IZEFYBWFZdBU0aXBhZDxwdSlZaDlsERxQXG1wAFxtGAgQjAl8ARQJeCVYBMBcPVk1QG18CQg8cE1YVEwBeDw9MC0gBWwdcAEcJSQJeBlIcRgtJBFQDRgBdTxFdDlIFRl5aFFwYQwJXAnkRUAFYHlZeWhdeUxcfSwBcRVoOWwRHFA==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1785114878; x=1787706878; bh=vg9Xn12IEm6Gm3ex9VT8k2FI4HQGohYc86GWzZEqMFA=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=zJu2bAP2DGx9fO04TTxQZzNDZvXhFEczVbS+RfGkELpZIrAZNUFNl8SNPva62KsJiddN6pklTYOYVWsnjJiVAxLQndtsCi2VNuJ4ygfovA2GJVa2fISCnO6GJiAFr9J3uMIeA6IW7r5K5hZpG3bRGlgwbvdf7YoTFxpAP7pPEIwsTIvIOGtb9SmWQEe4MhFjOfivg4hASKLkF7JW51dKansgZ7zgTDShx6u+4c+A0PXm4BL9PJcyRTpZoqOhRu94efyQgatfWBHJ54khuWaz0FQW1IdtZtfv4WMRxZhNmYNXnOjiyEL9qjq1/XQVd0G11oMspXjBA0bGUYQW6wzJ7Q==
Received: from bigre.localdomain (unknown [17.57.154.37])
	by p00-icloudmta-asmtp-us-west-3a-10-percent-1 (Postfix) with ESMTPSA id 7981D18000EF;
	Mon, 27 Jul 2026 01:14:23 +0000 (UTC)
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
Subject: [PATCH v4 01/11] power: supply: Add registration init callback
Date: Sun, 26 Jul 2026 21:12:59 -0400
Message-ID: <20260727011319.621794-2-vincent.cloutier@icloud.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727011319.621794-1-vincent.cloutier@icloud.com>
References: <20260727011319.621794-1-vincent.cloutier@icloud.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: XlYTSMEBmS2K_KkvE6y1KWhTND4Gw2Z0
X-Proofpoint-ORIG-GUID: XlYTSMEBmS2K_KkvE6y1KWhTND4Gw2Z0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDAwOSBTYWx0ZWRfX0zQK7ElSubwU
 XzjMtvpXzuRQQhjpBpoaemPMKInYp40LqgPgY920LrUL2tk015V3oMFLpzEvPenD76WWzDuDSgb
 df2Oy312x8/n76xnrtCOoa2vOIn8Xix9KNAhOEuR3EW22BWJX5qNknCHzFmtgOixZDNi0YuYEsI
 EzVZk4rk28MIlBZUgBDlY0q1/NkiMVomgltJo46MFCF3tLyP1rbGl867BamRkRpyIssDO3pXAXD
 wd37ASTZnUuONaIX0Bub31WsKj/mdPT9f8JvNBHkPAPJEDtz72BhmE290Mg7qP+ygYGCUw5PU1J
 KW2f/M3AY9a1nYUvbHCMlVMeoK1uOaxa4bCht027sdL95sJG93CPGWt5NM2tXQ=
X-Authority-Info-Out: v=2.4 cv=Hvx72kTS c=1 sm=1 tr=0 ts=6a66b0fb
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=RAioF0-LDSMA:10
 a=x7bEGLp0ZPQA:10 a=5j__JWfIoqoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=liNZ_1K84vVq4_E33D8A:9

From: Vincent Cloutier <vincent@cloutier.co>

Some battery drivers need to consume monitored-battery data before their
power_supply is visible. That lets them prepare hardware configuration from
parsed battery information without racing userspace exposure.

power_supply_get_battery_info() already runs in
__power_supply_register() for battery devices before device_add(). Add an
optional descriptor init callback after driver data and battery info are
available. The callback runs in sleepable process context while the power
supply is still unpublished.

Keep the callback synchronous: it must not publish changes or start
asynchronous activity that can access the power supply before registration
completes.

Require callbacks to return zero or a negative errno. Defensively reject
positive returns so registration cannot return an invalid error pointer.

Assisted-by: OpenCode:gpt-5.6-sol
Signed-off-by: Vincent Cloutier <vincent@cloutier.co>
---
 drivers/power/supply/power_supply_core.c | 8 ++++++++
 include/linux/power_supply.h             | 9 +++++++++
 2 files changed, 17 insertions(+)

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
index 7a5e4c3242a0..de5599458176 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -281,6 +281,15 @@ struct power_supply_desc {
 	int (*property_is_writeable)(struct power_supply *psy,
 				     enum power_supply_property psp);
 	void (*external_power_changed)(struct power_supply *psy);
+	/*
+	 * Optional registration-time initialization. This runs in sleepable
+	 * process context after driver data and any battery info are available,
+	 * but before the device is added. The callback must not publish changes or
+	 * start asynchronous activity that can access the power supply before
+	 * registration completes. Return 0 on success or a negative errno on
+	 * failure.
+	 */
+	int (*init)(struct power_supply *psy);
 
 	/*
 	 * Set if thermal zone should not be created for this power supply.
-- 
2.55.0

