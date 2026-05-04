Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC25329E0E5;
	Mon,  4 May 2026 16:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777912891; cv=none; b=ttE9tPh1lUZwQcNupL96jGwcBYpY176qCtBE4Be0ufWo4UUDbmm0QqAvWwnvpbZ7yrMyNAVY/JcEvatt8jTCS4L+3OK9y1yIYo4sYZ4uadm8Yc6kAN0kggMltWuKeo7zpR9Y7CnEort8EqhRqPtqfC6ORbL7AARIsfEOhXdGSIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777912891; c=relaxed/simple;
	bh=DemJ9uDqYDerpHS3vTzRACyWjAx52Hy0NBE+nAwe22M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=fxjPvwQdn/1KECnm7j7h05BjeelDPUqStRJWH4dKhI0zyARdn01WsDoirAtsnrJTPlZnzErYHQyxgE5mL3+dHbRKSQHybNWwOVBmT5LSZamf6KwVsUYyqaDVpQB0gS4+F5+d8KI33WQcdByABbEr8oAK/LP67DiwcgRIgOINDUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=rurVxbHH; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="rurVxbHH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=QYscOqw2L1uI9rV7SC0mQP1jPPE0pT+2LBoKgOqao/g=; b=rurVxbHHITYWf8iFYQjmePGtsY
	uC0DmijYdWiID7V6EXFGyaS15H6uAbChh+7ssJ2LB52rKE9+JUiOimrYPxz0PX1FjZawL9+Q+njJH
	xRNvud3k7WWh3JFVihy3ZLHwt1Tnd4fFN5fCKdkhoZu2Y9cChoN/e4C8NJqabLMYs+vbOo2acZ8xA
	k+xabYiv9iTRTSHWRu5nnEe+jNm9CRB8YXEDufA/IydPvyhMTp8nl5cGWeOpEzNr2o5xhn5TsQF0L
	SYFH0AHfy7YXzQrS0sUbIvFG7edd7+gLZA2kIw74Ew+t2wVjaUUCYzrZlzHliDvQ8fpLGGvDptW5k
	alNwpQ1g==;
From: Andreas Kemnade <andreas@kemnade.info>
To: sre@kernel.org,
	andreas@kemnade.info,
	mazziesaccount@gmail.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: bd71828: sysfs for auto input current limitation
Date: Mon,  4 May 2026 18:40:17 +0200
Message-ID: <20260504164017.467679-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the possibility to disable the auto adjustment for input current
limitation via sysfs because it gives strange results under certain
circumstances e.g. when powering the device with solar panels
resulting in no input power usage at all.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 .../ABI/testing/sysfs-class-power-bd71828     | 12 ++++
 drivers/power/supply/bd71828-power.c          | 69 ++++++++++++++++++-
 2 files changed, 80 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-bd71828

diff --git a/Documentation/ABI/testing/sysfs-class-power-bd71828 b/Documentation/ABI/testing/sysfs-class-power-bd71828
new file mode 100644
index 000000000000..2d451e1c8336
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-power-bd71828
@@ -0,0 +1,12 @@
+What: /sys/class/power_supply/bd71828_ac/auto_dcin_limit
+Description:
+	Enable/Disable automatic management of input current limit
+	(ILIM_DCIN_EN bit).
+
+	Possible values are:
+
+		============  ===========================================
+		1             automatic adjustment of input current limit
+		0             no adjustment of input current limit. This
+		              helps for more unusual power sources like
+			      solar modules.
diff --git a/drivers/power/supply/bd71828-power.c b/drivers/power/supply/bd71828-power.c
index 5e78faa0a4aa..8c251c2a15e2 100644
--- a/drivers/power/supply/bd71828-power.c
+++ b/drivers/power/supply/bd71828-power.c
@@ -12,6 +12,7 @@
 #include <linux/property.h>
 #include <linux/power_supply.h>
 #include <linux/slab.h>
+#include <linux/sysfs.h>
 
 /* common defines */
 #define BD7182x_MASK_VBAT_U			0x1f
@@ -25,6 +26,7 @@
 #define BD71815_MASK_CONF_XSTB			BIT(1)
 #define BD7182x_MASK_BAT_STAT			0x3f
 #define BD7182x_MASK_ILIM			0x3f
+#define BD71828_MASK_ILIM_DCIN_EN		BIT(6)
 #define BD7182x_MASK_DCIN_STAT			0x07
 
 #define BD7182x_MASK_WDT_AUTO			0x40
@@ -1099,10 +1101,75 @@ static int bd7182x_get_rsens(struct bd71828_power *pwr)
 	return 0;
 }
 
+static ssize_t auto_dcin_limit_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	struct bd71828_power *pwr = dev_get_drvdata(dev->parent);
+	int ret;
+	unsigned int v;
+
+	ret = regmap_read(pwr->regmap, pwr->regs->dcin_set, &v);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%d\n", !!(v & BD71828_MASK_ILIM_DCIN_EN));
+}
+
+static ssize_t auto_dcin_limit_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t len)
+{
+	struct bd71828_power *pwr = dev_get_drvdata(dev->parent);
+	int ret;
+	bool v;
+
+	ret = kstrtobool(buf, &v);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_update_bits(pwr->regmap, BD71828_REG_DCIN_SET,
+				 BD71828_MASK_ILIM_DCIN_EN,
+				 v ? BD71828_MASK_ILIM_DCIN_EN : 0);
+	if (ret < 0)
+		return ret;
+
+	return len;
+}
+
+static DEVICE_ATTR_RW(auto_dcin_limit);
+
+static struct attribute *bd71828_ac_sysfs_attrs[] = {
+	&dev_attr_auto_dcin_limit.attr,
+	NULL,
+};
+
+static bool bd71828_ac_sysfs_group_visible(struct kobject *kobj)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct bd71828_power *pwr = dev_get_drvdata(dev->parent);
+
+	return !!pwr->regs->dcin_set;
+}
+
+DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(bd71828_ac_sysfs);
+
+static const struct attribute_group bd71828_ac_sysfs_group = {
+	.attrs = bd71828_ac_sysfs_attrs,
+	.is_visible = SYSFS_GROUP_VISIBLE(bd71828_ac_sysfs)
+};
+
+static const struct attribute_group *bd71828_ac_sysfs_groups[] = {
+	&bd71828_ac_sysfs_group,
+	NULL
+};
+
 static int bd71828_power_probe(struct platform_device *pdev)
 {
 	struct bd71828_power *pwr;
-	struct power_supply_config ac_cfg = {};
+	struct power_supply_config ac_cfg = {
+		.attr_grp = bd71828_ac_sysfs_groups,
+	};
 	struct power_supply_config bat_cfg = {};
 	int ret;
 
-- 
2.47.3

