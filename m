Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB8F403AEE;
	Thu, 11 Jun 2026 13:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781182967; cv=none; b=HqpBGTkMRHTWPRmiMwIelkPtvUAQu+yY8J4Rb16gnF1OWv4YX0TjYttvYTk/AtfeJ6lw8IS6/beylJNG4NH2rrtGW+ndt+/2UXb2ht0rRoz+svcVKd0Tj1iUxSLtw79UJAbcwu28nu+z5Rxs2DiEdoLTduJ+u+33EX40mgBweVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781182967; c=relaxed/simple;
	bh=BZYRUafz0PZfiuP8RjO86Iw2TkwMsiuvbgKc02CLGKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t836jEJ/j49hiTXMamZ+XsB06Msz6++Ei/aDlaxUwbvRTWcLrQeUZ5kcIZZNqdXIz+Gk2kVddyULKbmgdVC7VjMTjE7KEmtr+te5WwWRO9sZyWGBvyfjksYxboJeXhS58SuA4ovFwt1T4BJyHu6kPuqH4m88wdWgRm5xNSQ3ykg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40ADF1F00898;
	Thu, 11 Jun 2026 13:02:41 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 5/9] clk: scmi: Add scmi_clk_is_pm_clk()
Date: Thu, 11 Jun 2026 15:02:09 +0200
Message-ID: <af9666e8fb841606b42d865d42adcaf472099ce1.1781171705.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1781171705.git.geert+renesas@glider.be>
References: <cover.1781171705.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a helper for querying if an SCMI clock can be used for
power-management.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/clk-scmi.c   |  9 +++++++++
 include/linux/clk/scmi.h | 17 +++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 include/linux/clk/scmi.h

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index 7c562559ad8bb47f..20e6da1859290b75 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -7,6 +7,7 @@
 
 #include <linux/bits.h>
 #include <linux/clk-provider.h>
+#include <linux/clk/scmi.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/of.h>
@@ -364,6 +365,14 @@ scmi_clk_ops_select(struct scmi_clk *sclk, bool atomic_capable,
 	return ops;
 }
 
+bool scmi_clk_is_pm_clk(struct clk *clk)
+{
+	struct clk_hw *hw = __clk_get_hw(clk);
+
+	return hw && to_scmi_clk(hw)->info->pm_clk;
+}
+EXPORT_SYMBOL_GPL(scmi_clk_is_pm_clk);
+
 static int scmi_clocks_probe(struct scmi_device *sdev)
 {
 	int idx, count, err;
diff --git a/include/linux/clk/scmi.h b/include/linux/clk/scmi.h
new file mode 100644
index 0000000000000000..12c338598d09296f
--- /dev/null
+++ b/include/linux/clk/scmi.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0+
+ */
+
+#ifndef __LINUX_CLK_SCMI_H_
+#define __LINUX_CLK_SCMI_H_
+
+#include <linux/types.h>
+
+struct clk;
+
+#if IS_ENABLED(CONFIG_COMMON_CLK_SCMI)
+bool scmi_clk_is_pm_clk(struct clk *clk);
+#else
+static inline bool scmi_clk_is_pm_clk(struct clk *clk) { return false; }
+#endif
+
+#endif /* __LINUX_CLK_SCMI_H_ */
-- 
2.43.0

