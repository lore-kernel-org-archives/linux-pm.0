Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C043FCB29;
	Thu, 11 Jun 2026 13:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781182953; cv=none; b=rc8IMdZSjaXGtewa9spAt2grBmfnDZF+DOX0/qGzumeBGDJbqABroeNqpCT4ilttBTQago2Q4RSwJlyMuT/Uq/cNcyywky8zw0fGnvDNgf+OXPYWRfJmo+l9AwTIXNJipIUtVPG1EmNGeF6AOWbnvV0BHLM80ZdW1AK+HuhrTe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781182953; c=relaxed/simple;
	bh=fCPdT5a1P8Xqb6dbzmB0BEipK53CY4w1cQGDZWKswJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OmcS1tj0jVVL+0EfMlvC78Xb8Yht0XdC7Sm2596bI5il6AWzYKfy7XPCuMmq2aZmfDVBUwNpAaUubyJUX1dlAys1XhVbIR368PhjsAjg7Pouhp/6dk+IMqmD8merGEAhq7o7Kwv4KLUkPb7nW2eoPlNA0eqrvH40BSxLEwg2TFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6086E1F00899;
	Thu, 11 Jun 2026 13:02:29 +0000 (UTC)
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
Subject: [PATCH/RFC 2/9] firmware: arm_scmi: Advertize always-on power domains
Date: Thu, 11 Jun 2026 15:02:06 +0200
Message-ID: <1cbd6383dfef1eb397b52a4ff557f66b2064798d.1781171705.git.geert+renesas@glider.be>
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

A power domains indicates in its attribute flags if it supports setting
its power state synchronously and/or asynchronously.  If none of them is
supported, it must be an always-on power domain.

Make this information available to SCMI protocol drivers, so they can
make use of it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/firmware/arm_scmi/power.c | 4 ++++
 include/linux/scmi_protocol.h     | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/power.c
index a00f7c298efb74f9..11ca8c9965110b5a 100644
--- a/drivers/firmware/arm_scmi/power.c
+++ b/drivers/firmware/arm_scmi/power.c
@@ -8,6 +8,7 @@
 #define pr_fmt(fmt) "SCMI Notifications POWER - " fmt
 
 #include <linux/module.h>
+#include <linux/pm_domain.h>
 #include <linux/scmi_protocol.h>
 
 #include "protocols.h"
@@ -147,6 +148,9 @@ scmi_power_domain_attributes_get(const struct scmi_protocol_handle *ph,
 					    SCMI_MAX_STR_SIZE);
 	}
 
+	if (!ret && !dom_info->state_set_async && !dom_info->state_set_sync)
+		dom_info->info.genpd_flags |= GENPD_FLAG_ALWAYS_ON;
+
 	return ret;
 }
 
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 1c17515ba45d1fd4..1d55374bc8cdcc72 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -193,6 +193,7 @@ struct scmi_perf_proto_ops {
 
 struct scmi_power_domain_info {
 	char name[SCMI_MAX_STR_SIZE];
+	unsigned int genpd_flags;
 };
 
 /**
-- 
2.43.0

