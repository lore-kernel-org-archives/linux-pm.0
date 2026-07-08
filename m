Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E9D394461;
	Wed,  8 Jul 2026 10:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783505824; cv=none; b=VjW24n6MSzItIYb88ZLDursOqfqMhFvYBqIjn5DTHzJHU7AGsVQkFEKU09amPRQovfnR9WZaBWIhK31GdAxItQAOlMvNntWn1QiQDgvPWe0NRCHyrlo6sRzLMP5EEFNxXIcvoSkFTc4jr1Rew3Cp+Cz7SiJgAFCbANDiRAkAD/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783505824; c=relaxed/simple;
	bh=aBrFcOxUNEeztFhzZB+sFJBaznGhAsuXoLVaTLabbYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZIy81nN6nAy4ucRAabvZXUU5Irhf36V9blJwOJ0KnQfiY5jP+hMoPXOE2EGs2cSZMxrDkM9znjT3GOva1Q9nDnE/MWdac7KwMX2bGlxQDJelTVAhCyotLMd5tbQ7GRZFot/T/p4RBEP9eNsEwSPJ6tf0hvi+pZY2fpKTj8Mx5QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC5A1F000E9;
	Wed,  8 Jul 2026 10:16:57 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Vinod Koul <vkoul@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 02/10] of: property: fw_devlink: Add support for firmware
Date: Wed,  8 Jul 2026 12:16:20 +0200
Message-ID: <de34ac0c52695d92c67cf950b3d8e9b30095d305.1783505329.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783505329.git.geert+renesas@glider.be>
References: <cover.1783505329.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let fw_devlink create device links between consumers and suppliers of
firmware, and enforce these dependencies.

This prevents probing of drivers before the firmware they depend on
becomes available, thus avoiding unneeded probe deferrals.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Written for the upcoming R-Car X5H Clock Pulse Generator and Module
Controller drivers and their dependency on SCMI, but the existing
Raspberry Pi power domain driver should benefit from this, too.

v2:
  - No changes.
---
 drivers/of/property.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 72cf12907de034e9..1a40a4f7db01f0a9 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1401,6 +1401,7 @@ DEFINE_SIMPLE_PROP(dmas, "dmas", "#dma-cells")
 DEFINE_SIMPLE_PROP(power_domains, "power-domains", "#power-domain-cells")
 DEFINE_SIMPLE_PROP(hwlocks, "hwlocks", "#hwlock-cells")
 DEFINE_SIMPLE_PROP(extcon, "extcon", NULL)
+DEFINE_SIMPLE_PROP(firmware, "firmware", NULL)
 DEFINE_SIMPLE_PROP(nvmem_cells, "nvmem-cells", "#nvmem-cell-cells")
 DEFINE_SIMPLE_PROP(phys, "phys", "#phy-cells")
 DEFINE_SIMPLE_PROP(wakeup_parent, "wakeup-parent", NULL)
@@ -1550,6 +1551,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_power_domains, },
 	{ .parse_prop = parse_hwlocks, },
 	{ .parse_prop = parse_extcon, },
+	{ .parse_prop = parse_firmware, },
 	{ .parse_prop = parse_nvmem_cells, },
 	{ .parse_prop = parse_phys, },
 	{ .parse_prop = parse_wakeup_parent, },
-- 
2.43.0

