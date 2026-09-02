Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE8747B43E;
	Wed,  2 Sep 2026 11:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788348609; cv=none; b=AymGjhVqTbmbN9EHEzde4AIt36d1CHIWGNdP9Vcqyu+vCG0LfSDwhaqOvMXc4NfI7Ef0LpRKACNAReXpGihXMgIntFTwZHgkgypNeWV/vtbV4Mj4qwuHfaVawIQwam8HYXAvQBWhIbDtIkHPzShXd8WZ1B4zzcCi/wkkwN7FKlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788348609; c=relaxed/simple;
	bh=9YsujQnpLKBd9iylXRIYgUWGHFw2cNgDVBGpcd+eiLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xx3itJKpV+J+TUU0MCsBXLa6MIXbXktxKQoa2risJ4aj1oRiUZzN+D4YaFhnbzQAje1DR6CnPK9B3e8vbNj6BV3FT9TNfqHlE3XcPN6HlW0312r0QePNNciCFS2i+RD+Ycp+0h1IgFX5wQxlGRezt4nLeY1uVJt8ADB41smZy/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98EE11F000E9;
	Wed,  2 Sep 2026 11:29:59 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Vinod Koul <vkoul@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?= <clegoffic@baylibre.com>
Cc: devicetree@vger.kernel.org,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 04/12] of: property: fw_devlink: Add support for renesas,scmi-firmware
Date: Wed,  2 Sep 2026 13:29:20 +0200
Message-ID: <1d5c56c80291e447208ac8777aaf90ad6f0a4f4d.1788338320.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1788338320.git.geert+renesas@glider.be>
References: <cover.1788338320.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let fw_devlink create device links between consumers and suppliers of
SCMI firmware on Renesas platforms, and enforce these dependencies.

This prevents probing of drivers before the firmware they depend on
becomes available, thus avoiding unneeded probe deferrals.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - s/firmware/renesas,scmi-firmware/,

v2:
  - No changes.
---
 drivers/of/property.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 72cf12907de034e9..e79cd3cce4e2e41a 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1417,6 +1417,7 @@ DEFINE_SIMPLE_PROP(power_supplies, "power-supplies", NULL)
 DEFINE_SIMPLE_PROP(mmc_pwrseq, "mmc-pwrseq", NULL)
 DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
 DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
+DEFINE_SIMPLE_PROP(renesas_scmi_firmware, "renesas,scmi-firmware", NULL)
 
 static struct device_node *parse_pinctrl_n(struct device_node *np,
 					   const char *prop_name, int index)
@@ -1574,6 +1575,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_regulators, },
 	{ .parse_prop = parse_gpio, },
 	{ .parse_prop = parse_gpios, },
+	{ .parse_prop = parse_renesas_scmi_firmware, },
 	{
 		.parse_prop = parse_post_init_providers,
 		.fwlink_flags = FWLINK_FLAG_IGNORE,
-- 
2.43.0

