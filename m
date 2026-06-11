Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053EA403AE7;
	Thu, 11 Jun 2026 13:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781182979; cv=none; b=klbyMcdjEDiGQrrnw/4okWBSsfI9/Ywe93dHgvprvCBinDBcyuDovY6SFZFkQBAJKzO2kB+wfTAVGL5UYoYP/6VmAEX4DE6h+6BJjxZNmYA6IScjGJ0g4g5N1FofG6VvxqZQ6cjJnExqMo9bSeoOf40+InOK9hHeJBupx8MFPCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781182979; c=relaxed/simple;
	bh=3W5wFRe+urc10i12LtOB3bH3rgts0U54xCpl1kI0ZhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JnZmNhJkEVPcTkVfp8VlWaLyY+EA5e+MLJAQjtrzTwlsCAH9/vCG+RWzxGJZqrb+Mi6g+XcIf61bqxzSRlF/S7lvhp6LGPy47Eg/9U4yE9QGCAegvmqbb/Fucs6q0O3Q0f027WUD61SpwBsc6fRjXE6AP9JYq8GrYbsT3ZYzBqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6A81F00893;
	Thu, 11 Jun 2026 13:02:52 +0000 (UTC)
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
Subject: [PATCH/RFC 8/9] firmware: arm_scmi: quirk: Handle power management clocks on R-Car X5H
Date: Thu, 11 Jun 2026 15:02:12 +0200
Message-ID: <570914c18b34684dd41a1b7b7be9bd7aa377690b.1781171706.git.geert+renesas@glider.be>
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

On Renesas R-Car X5H, power management of on-SoC modules is handled
through two methods: module power control and module clock gating.  The
former is exposed as an SCMI power domain, the latter as an SCMI clock.

Currently the SCMI clock protocol does not support advertizing
power-management clocks yet.  Add quirks to mark all module clocks
suitable for power management, reusing the existing clock_rcar_x5h_4_28
and clock_rcar_x5h_4_31 quirk keys.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This patch is included as a PoC.
This does not build as the quirk keys are not added in this series.
---
 drivers/firmware/arm_scmi/clock.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 42e666a628c732e5..c2648f9f283f2488 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -355,6 +355,18 @@ scmi_clock_get_permissions(const struct scmi_protocol_handle *ph, u32 clk_id,
 	return ret;
 }
 
+#define QUIRK_RCAR_X5H_4_28_PM_CLK					\
+	({								\
+		if (clk_id <= 818 /* Last MDLC clock MDLC_GPIODM3 */)	\
+			clk->pm_clk = true;				\
+	})
+
+#define QUIRK_RCAR_X5H_4_31_PM_CLK					\
+	({								\
+		if (clk_id <= 814 /* Last MDLC clock MDLC_GPIODM3 */)	\
+			clk->pm_clk = true;				\
+	})
+
 static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
 				     u32 clk_id, struct clock_info *cinfo)
 {
@@ -410,6 +422,9 @@ static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
 			if (SUPPORTS_EXTENDED_CONFIG(attributes))
 				clk->extended_config = true;
 		}
+
+		SCMI_QUIRK(clock_rcar_x5h_4_28, QUIRK_RCAR_X5H_4_28_PM_CLK);
+		SCMI_QUIRK(clock_rcar_x5h_4_31, QUIRK_RCAR_X5H_4_31_PM_CLK);
 	}
 
 	return ret;
-- 
2.43.0

