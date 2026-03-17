Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702883E51F7
	for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 22:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773787337; cv=none; b=gMA/HQcUTkK8ijQTcF+FNCCgtRgIgc4p65IYR4JPTCS2FLqlv1hKuF9kMnbhKSw+meLUFnOPT3QuTSH3Vnjq8Fk5FqDzTvKm5ZJoA19g/BphqmLh1qFkcron3OGSZ331VZ5L1SLGEuRoixK/FeZy2Xi9b7T/9fThTmSPTbjcRA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773787337; c=relaxed/simple;
	bh=CmmPaRCr2hx1pUoOyiaFLoF4fRJRXNq/GTA2ITgum2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mu3Gb8+4OFWw9htcnV9ryToYz7WBC1vC87FFpLS85dgyRjUuyoxOKE+mImGOx3Xr28Th0HzNg4jMKU7RBUN9idWZBumXddbB3XWX7aMqsZ4v9Essey9WDEAycH+mhBOc/DXfLuZa9X3wArJVm0XXWAZ6ZQwjbOQetpkE8on7yTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Xi7S8mCV; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Xi7S8mCV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bzAPEKG6So/PDOGgY059VUp1RC8xXZ0CXcJWrOlWZks=; b=Xi7S8mCVqyoEHR9EBCuewJZyHn
	NzHGkJ1s9ukyv7YF6ovfBYxFxMMg5tJ2h7VzPYXL92/+8Nyr7gDx/Fdi6GgnwDv4rR/iZz3LJSiE5
	t4Jw4Q/9TiY6sHxytsQS8FayNFYtktC2U66Q5jk9fXIjndlFwOsGmYZ7W0xDdzntk4izGyPMx+ysM
	sisUeyoaZBvWyfhMSkfSkSSzjyZQ7363H21xDDSMycSJEJmD+jNhR0h3ac+xEF3U9PzGs2S06cdW/
	tgtEErCn45gVht5PDdBht9TKaqpZ+6xeYkwaV4TQPUR0zLOaiqxabRSKHWHKak3QhrSSVhiZbC60X
	TFlG0Gkw==;
Received: from [189.7.87.203] (helo=janis.local)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1w2d77-002VQv-4b; Tue, 17 Mar 2026 23:42:13 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Tue, 17 Mar 2026 19:41:50 -0300
Subject: [PATCH 2/2] pmdomain: bcm: bcm2835-power: Replace open-coded
 polling with readl_poll_timeout_atomic()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-bcm2835-power-timeout-v1-2-19db323c51f9@igalia.com>
References: <20260317-bcm2835-power-timeout-v1-0-19db323c51f9@igalia.com>
In-Reply-To: <20260317-bcm2835-power-timeout-v1-0-19db323c51f9@igalia.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Stefan Wahren <wahrenst@gmx.net>, Rob Herring <robh@kernel.org>
Cc: kernel-dev@igalia.com, linux-pm@vger.kernel.org, 
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2198; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=CmmPaRCr2hx1pUoOyiaFLoF4fRJRXNq/GTA2ITgum2Q=;
 b=owEBbQGS/pANAwAIAT/zDop2iPqqAcsmYgBpudi5JcsfXMgcYcCBw1ClEm9HvzDKFJ12jR84F
 CKbxS6s7haJATMEAAEIAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCabnYuQAKCRA/8w6Kdoj6
 qg1NB/4gfFS+FHmcdn144QE3wxtqYM2Owhhc7uvEYX4wodH2DVlkoKsz9mmm0xttspRbSecwFcy
 GdXw/l/zyLjLRvTmtNe/VsPievQTHdV+dHePobKLBYGkR3dmttheD9kLTuzOrhl8EJp+mIDPh+A
 bcOtlF4fSv2U3E6Y6WDW/B9a6gxvTbInZoXMzCPsHFhlwF4YG0/6cWwWqWcBO/iJ8D2yfqcVsLc
 n31QijEtmxo95XsSZ0vWvfhyGEnbKyOc/K4Rp7RxNHYkNjrRAgfFv+kkJ48oqTdhIjqSTK6VIHs
 bO09U34UbqMIK73X+1DkqzjSXIP74lO1heg5aFkpoKgnVmmG
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA

Replace hand-rolled ktime_get_ns()/cpu_relax() polling loops with
readl_poll_timeout_atomic() for the power-on (POWOK), and memory
repair (MRDONE) waits.

No functional change intended.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/pmdomain/bcm/bcm2835-power.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/pmdomain/bcm/bcm2835-power.c b/drivers/pmdomain/bcm/bcm2835-power.c
index eee87a3005325848547ce1f5fd729b168a641460..b76d74e3849be0aff226cfbe311970c9557eccfa 100644
--- a/drivers/pmdomain/bcm/bcm2835-power.c
+++ b/drivers/pmdomain/bcm/bcm2835-power.c
@@ -215,10 +215,10 @@ static int bcm2835_power_power_on(struct bcm2835_power_domain *pd, u32 pm_reg)
 {
 	struct bcm2835_power *power = pd->power;
 	struct device *dev = power->dev;
-	u64 start;
 	int ret;
 	int inrush;
 	bool powok;
+	u32 val;
 
 	/* We don't run this on BCM2711 */
 	if (power->rpivid_asb)
@@ -239,12 +239,8 @@ static int bcm2835_power_power_on(struct bcm2835_power_domain *pd, u32 pm_reg)
 			 (inrush << PM_INRUSH_SHIFT) |
 			 PM_POWUP);
 
-		start = ktime_get_ns();
-		while (!(powok = !!(PM_READ(pm_reg) & PM_POWOK))) {
-			cpu_relax();
-			if (ktime_get_ns() - start >= 3000)
-				break;
-		}
+		powok = !readl_poll_timeout_atomic(power->base + pm_reg,
+						   val, val & PM_POWOK, 0, 3);
 	}
 	if (!powok) {
 		dev_err(dev, "Timeout waiting for %s power OK\n",
@@ -258,15 +254,12 @@ static int bcm2835_power_power_on(struct bcm2835_power_domain *pd, u32 pm_reg)
 
 	/* Repair memory */
 	PM_WRITE(pm_reg, PM_READ(pm_reg) | PM_MEMREP);
-	start = ktime_get_ns();
-	while (!(PM_READ(pm_reg) & PM_MRDONE)) {
-		cpu_relax();
-		if (ktime_get_ns() - start >= 1000) {
-			dev_err(dev, "Timeout waiting for %s memory repair\n",
-				pd->base.name);
-			ret = -ETIMEDOUT;
-			goto err_disable_ispow;
-		}
+	if (readl_poll_timeout_atomic(power->base + pm_reg, val,
+				      val & PM_MRDONE, 0, 1)) {
+		dev_err(dev, "Timeout waiting for %s memory repair\n",
+			pd->base.name);
+		ret = -ETIMEDOUT;
+		goto err_disable_ispow;
 	}
 
 	/* Disable functional isolation */

-- 
2.53.0

