Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D675423EB9;
	Wed,  2 Sep 2026 11:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788348629; cv=none; b=Woa/KpvhxfgrSi7c4j6T9HFc4QORq2y6ruVP0vlQD1Ib15WUEOPEg76reWdUjsS4RcHQ3lUi7CGt8t3CRLcPkYx+Jw9V7qzVLu1tEoQzWZmUYHmcOv1bSTgZepFmgDVlPzYsBqMSdxmTuBiDPTe/B8+2R3Z+RYR2GZSDbwVzWfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788348629; c=relaxed/simple;
	bh=zcVbdUoSNiQ7hM4Ue5lG4uC//foCmUswTkcwBzDtwWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KYjo8MQJnrh2t7rc5eaAsz8SCPT95KdMOIrIyZfxRYnmePJfATXC4rdK3uhR5NWekaz8+2tn3IMZuoegRqDq9YjREzcd7XO+TgQH8dtXGC16sKkzyy9y/xRITBi1V1tlFtZP6rsiXW6xi9oWHfxeeNXdvhISL/NPeAeVqrAQwjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4953E1F00A3D;
	Wed,  2 Sep 2026 11:30:17 +0000 (UTC)
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
Subject: [PATCH v3 07/12] reset: Add reset_control_get_from_provider_exclusive()
Date: Wed,  2 Sep 2026 13:29:23 +0200
Message-ID: <619a6e41495adfdae3e2e6c0fee97e0550a5c404.1788338320.git.geert+renesas@glider.be>
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

When stacking two reset controllers, the upper one should go through the
proper channels: request exclusive reset controls and use them via the
reset_control_*() APIs.  However, unlike the clock subsystem, which has
of_clk_get_from_provider(), the reset subsystem does not offer a way to
lookup and obtain a reset from a reset provider.

Hence add a public helper reset_control_get_from_provider_exclusive()
to lookup and obtain an exclusive reference to a reset controller, based
on the recently introduced __reset_control_get_from_provider() helper.
This will be used by the R-Car X5H Module Controller driver.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - Replace reset_controller_get_provider() by
    reset_control_get_from_provider_exclusive(),
  - Add kerneldoc,

v2:
  - No changes.
---
 drivers/reset/core.c  | 37 ++++++++++++++++++++++++++++++++-----
 include/linux/reset.h |  8 ++++++++
 2 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 8af7cd2e8a5029df..6d4c95b3edb18248 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -1141,6 +1141,7 @@ __reset_control_get_from_provider(const struct fwnode_reference_args *args,
 				  bool gpio_fallback,
 				  enum reset_control_flags flags)
 {
+	struct fwnode_handle *fwnode = consumer ?: args->fwnode;
 	struct reset_control *rstc = ERR_PTR(-EINVAL);
 	struct reset_controller_dev *rcdev;
 	int rstc_id = -EINVAL;
@@ -1154,18 +1155,26 @@ __reset_control_get_from_provider(const struct fwnode_reference_args *args,
 	if (WARN_ON(args->nargs != rcdev->fwnode_reset_n_cells))
 		return ERR_PTR(-EINVAL);
 
-	if (rcdev->of_xlate && is_of_node(consumer)) {
-		struct device_node *np = to_of_node(consumer);
+	if (rcdev->of_xlate && is_of_node(fwnode)) {
+		struct device_node *np = to_of_node(fwnode);
 		struct of_phandle_args of_args;
 		int ret;
 
-		ret = of_parse_phandle_with_args(np,
+		if (consumer) {
+			ret = of_parse_phandle_with_args(np,
 					 gpio_fallback ? "reset-gpios" : "resets",
 					 gpio_fallback ? "#gpio-cells" : "#reset-cells",
 					 gpio_fallback ? 0 : index,
 					 &of_args);
-		if (ret)
-			return ERR_PTR(ret);
+			if (ret)
+				return ERR_PTR(ret);
+		} else {
+			of_args.np = of_node_get(np);
+			of_args.args_count = args->nargs;
+
+			for (unsigned int i = 0; i < args->nargs; i++)
+				of_args.args[i] = args->args[i];
+		}
 
 		rstc_id = rcdev->of_xlate(rcdev, &of_args);
 		of_node_put(of_args.np);
@@ -1257,6 +1266,24 @@ struct reset_control *__reset_control_get(struct device *dev, const char *id,
 }
 EXPORT_SYMBOL_GPL(__reset_control_get);
 
+/**
+ * reset_control_get_from_provider_exclusive - Lookup and obtain an exclusive
+ *					       reference to a reset controller.
+ * @args: Reference to the reset controller provider with all the args like
+ *	  reset number
+ *
+ * Returns a struct reset_control or IS_ERR() condition containing errno.
+ * If this function is called more than once for the same reset control it will
+ * return -EBUSY.
+ */
+struct reset_control *
+reset_control_get_from_provider_exclusive(const struct fwnode_reference_args *args)
+{
+	return __reset_control_get_from_provider(args, NULL, 0, false,
+						 RESET_CONTROL_EXCLUSIVE);
+}
+EXPORT_SYMBOL_GPL(reset_control_get_from_provider_exclusive);
+
 int __reset_control_bulk_get(struct device *dev, int num_rstcs,
 			     struct reset_control_bulk_data *rstcs,
 			     enum reset_control_flags flags)
diff --git a/include/linux/reset.h b/include/linux/reset.h
index 9c391cf0c82298a0..09ee47b27f88d3b1 100644
--- a/include/linux/reset.h
+++ b/include/linux/reset.h
@@ -90,6 +90,8 @@ struct reset_control *__fwnode_reset_control_get(struct fwnode_handle *fwnode,
 				     const char *id, int index, enum reset_control_flags flags);
 struct reset_control *__reset_control_get(struct device *dev, const char *id,
 					  int index, enum reset_control_flags flags);
+struct reset_control *reset_control_get_from_provider_exclusive(
+				const struct fwnode_reference_args *args);
 void reset_control_put(struct reset_control *rstc);
 int __reset_control_bulk_get(struct device *dev, int num_rstcs,
 			     struct reset_control_bulk_data *rstcs,
@@ -173,6 +175,12 @@ static inline struct reset_control *__reset_control_get(
 	return optional ? NULL : ERR_PTR(-ENOTSUPP);
 }
 
+static inline struct reset_control *reset_control_get_from_provider_exclusive(
+				const struct fwnode_reference_args *args)
+{
+	return NULL;
+}
+
 static inline int
 reset_control_bulk_reset(int num_rstcs, struct reset_control_bulk_data *rstcs)
 {
-- 
2.43.0

