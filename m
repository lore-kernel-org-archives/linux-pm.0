Received: from master.debian.org (master.debian.org [82.195.75.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C828524DFF9;
	Mon, 21 Sep 2026 10:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789985073; cv=none; b=nthvPP8ieCNAIgEU/MoQ1v6hS0TfChNLbXm/92BjYv66hYoJqBSDpj9emAUb0Y3kLkvt0llTckbFIxsgTgWxPO0z7lzdf+k3ZZcCjMysRDSiaH0eZ71potNuOUG8MFaOdVtueq1SQ+QyFv7jvWeDw3XOdyMpKAcEeUpau/QOjXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789985073; c=relaxed/simple;
	bh=guIzjU+DNLL7ubPKDYqbgqMXg+Wtg1CXpKpij7HTUdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tpLXcsYy3tJW6XnvE2Pax3iUISyqODV9D+wa3pDeozo0rJhEZsxLbBvdDr5sFv2Y9fyGLPZ+yagrLP/eGj7gx8F+mQZ4I4q5eNbT0tM+wVZ1MEiD4qwhVXPXCbnQLpNn3zNNl3fGa4IXOWFqqCI5Y0XFnTnGavBbsSU4TPoi7Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=master.debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=QgHB7TRS; arc=none smtp.client-ip=82.195.75.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=master.debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="QgHB7TRS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.master; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description; bh=30SciPvdgNF2o66DRRScNlCvwze0H+1S2lAwk8P6jxk=; b=QgHB
	7TRSDL9m4fueqtqolBf27Vd4FlOnnfHCYhW1PG11HDRBu5v2tNyXI1qgWXDLj4qYkEj/qBy38y3dL
	SLaf8V6biwAfJu+PjNH20h0ujbvEZ6MfhIaAJuOO9KHA0U8VGKo31Jc8xobOYpKRRFqhBOlifukbP
	miVlLbg5nhn/LsIXldXa9Co0DjgE0hft5f0JsOCa1AssmrCWOHS2i995UPQbcnobjU9JR1OD9TXjA
	MD7Kt0lXTd0jWFPcrfpOQiP8Gpd0NlBRSmbsMKDK9Lld51wek8JzugHIigPmuqh1eGrkUu/pW8sbO
	akfs6hThy24zlnRQ4JAqC6l2sILXGA==;
Received: from ukleinek by master.debian.org with local (Exim 4.96)
	(envelope-from <ukleinek@master.debian.org>)
	id 1x8aXb-003NLT-2G;
	Mon, 21 Sep 2026 09:42:27 +0000
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@debian.org>
To: Sebastian Reichel <sre@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] power: supply: axp20x*: Drop check for disabled devices
Date: Mon, 21 Sep 2026 11:41:47 +0200
Message-ID:  <c17a6c915abdb99612a52d2bb8cff78050f6b0a6.1789983244.git.ukleinek@debian.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1789983244.git.ukleinek@debian.org>
References: <cover.1789983244.git.ukleinek@debian.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2128; i=ukleinek@debian.org; h=from:subject:message-id; bh=guIzjU+DNLL7ubPKDYqbgqMXg+Wtg1CXpKpij7HTUdQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqsPvhqwF3EAkOmLw6OP1gK9f93vJmWAlfDTbpg e0M5KZpGJ6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCarD74QAKCRCPgPtYfRL+ TvdACACj8QLLfiDrwwSpTrsUb10HR4yusExVME569XPqfDHv1/HIh18JQTjzmrHQTBlYqSB4wbq Jx0IsjShuKOSImB5TZTYRYI7GIByWwIk5NdSUtzFmL0+Qt89718xBCdY8qZKkltEK5u+x6P6Q9K +arfMNPflaoWkIlIyrp6+lGPaIEKj7HTbFLCIVKUXIRJYraE39yxe/NWJKWnMht5P0erwba7Hew HXc+PcVxHkKnV8JVN3YalnqZhc78vnwHubOYJFs0Ez0eBo/vdHlvhligctS7AFTtLqsiNwDQU/h bXcHyKGG5AGRU+ZpUcV4DKPASZQiePUAZewZWwEKD9JN3ZbC
X-Developer-Key: i=ukleinek@debian.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Since commit 6b5c350648b8 ("mfd: mfd-core: Honour Device Tree's request
to disable a child-device") the mfd core checks for disabled devices, so
there is no use in doing that again in the mfd child driver.

Drop the check in the two power drivers.

Signed-off-by: Uwe Kleine-König <ukleinek@debian.org>
---
 drivers/power/supply/axp20x_ac_power.c  | 3 ---
 drivers/power/supply/axp20x_battery.c   | 3 ---
 drivers/power/supply/axp20x_usb_power.c | 3 ---
 3 files changed, 9 deletions(-)

diff --git a/drivers/power/supply/axp20x_ac_power.c b/drivers/power/supply/axp20x_ac_power.c
index d9892b351621..46889567bc18 100644
--- a/drivers/power/supply/axp20x_ac_power.c
+++ b/drivers/power/supply/axp20x_ac_power.c
@@ -326,9 +326,6 @@ static int axp20x_ac_power_probe(struct platform_device *pdev)
 	const struct axp_data *axp_data;
 	int i, irq, ret;
 
-	if (!of_device_is_available(pdev->dev.of_node))
-		return -ENODEV;
-
 	if (!axp20x) {
 		dev_err(&pdev->dev, "Parent drvdata not set\n");
 		return -EINVAL;
diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
index ee8701a6e907..c119014b319a 100644
--- a/drivers/power/supply/axp20x_battery.c
+++ b/drivers/power/supply/axp20x_battery.c
@@ -1097,9 +1097,6 @@ static int axp20x_power_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	int ret;
 
-	if (!of_device_is_available(pdev->dev.of_node))
-		return -ENODEV;
-
 	axp20x_batt = devm_kzalloc(&pdev->dev, sizeof(*axp20x_batt),
 				   GFP_KERNEL);
 	if (!axp20x_batt)
diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index e951b2b64b25..463f9fe35cec 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -924,9 +924,6 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 	const struct axp_data *axp_data;
 	int i, irq, ret;
 
-	if (!of_device_is_available(pdev->dev.of_node))
-		return -ENODEV;
-
 	if (!axp20x) {
 		dev_err(&pdev->dev, "Parent drvdata not set\n");
 		return -EINVAL;
-- 
2.47.3

