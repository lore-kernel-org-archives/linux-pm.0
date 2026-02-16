Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70DC1C69D;
	Mon, 16 Feb 2026 18:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771267661; cv=none; b=ag3tIKbocgD9mzHwEBRR3mbEe2XUbzOzaU05LDQGXLo5LuSlkVJmyx2Ucic1W3Br/WgThhXpAjf8oGtgLO6ZxnPhHvhqxb0uiM4TWeFX2DewiO/UEPiyjJGdQvpxxQKWUSj2XxQTg95fuQHcorP94V7YxrEzzaDtFGnQAF5s2ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771267661; c=relaxed/simple;
	bh=KVrYVr+H4K/US0lmg7X6RoUdNhAZhCplem3bcYs+DXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m2lQhSDxe9zLbXyek64V3qHQ2NSntkzCc5rCF1RnlnUPj3tR7GrGOJbuwY6KC6YM5vXdVVJSBoswG6vcI+h1R9zyMPIf1UZiG2O0/kXofyNFj2l3eG0nwT/BiFZL/cGng1jD9iYNq1aErYM9JrCJQB1QDBrzDSOTu0xPyxCUwgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D20FC116C6;
	Mon, 16 Feb 2026 18:47:39 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC] pmdomain: core: Support pd_ignore_unused with sync_state
Date: Mon, 16 Feb 2026 19:47:34 +0100
Message-ID: <1cfa86b72b2a5aa2ade92f247dd318c9cb6ef2a1.1771267504.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the introduction of the sync_state mechanism, the
"pd_ignore_unused" kernel command line option doesn't really work
anymore.  While genpd_power_off_unused() still checks for that flag
before powering down unused domains, the new sync_state callbacks lack
such checks, thus powering down unused domains regardless.

Fix this by adding checks to the sync_state helpers and callbacks.
Factor out the printing of the warning message, to make sure it is
printed only once.

Fixes: 002ebddd695a5399 ("pmdomain: core: Restore behaviour for disabling unused PM domains")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
RFC as I have no need for this in upstream.
---
 drivers/pmdomain/core.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 7b563757935071dd..1f7d90bcc30d12e5 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -1366,6 +1366,16 @@ static int __init pd_ignore_unused_setup(char *__unused)
 }
 __setup("pd_ignore_unused", pd_ignore_unused_setup);
 
+static bool genpd_ignore_unused(void)
+{
+	if (pd_ignore_unused) {
+		pr_warn_once("genpd: Not disabling unused power domains\n");
+		return true;
+	}
+
+	return false;
+}
+
 /**
  * genpd_power_off_unused - Power off all PM domains with no devices in use.
  */
@@ -1373,10 +1383,8 @@ static int __init genpd_power_off_unused(void)
 {
 	struct generic_pm_domain *genpd;
 
-	if (pd_ignore_unused) {
-		pr_warn("genpd: Not disabling unused power domains\n");
+	if (genpd_ignore_unused())
 		return 0;
-	}
 
 	pr_info("genpd: Disabling unused power domains\n");
 	mutex_lock(&gpd_list_lock);
@@ -3510,6 +3518,9 @@ void of_genpd_sync_state(struct device_node *np)
 {
 	struct generic_pm_domain *genpd;
 
+	if (genpd_ignore_unused())
+		return;
+
 	if (!np)
 		return;
 
@@ -3544,6 +3555,9 @@ static void genpd_provider_sync_state(struct device *dev)
 		break;
 
 	case GENPD_SYNC_STATE_SIMPLE:
+		if (genpd_ignore_unused())
+			return;
+
 		genpd_lock(genpd);
 		genpd->stay_on = false;
 		genpd_power_off(genpd, false, 0);
-- 
2.43.0

