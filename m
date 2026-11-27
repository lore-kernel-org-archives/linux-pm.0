Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795796870;
	b=YrjGdLwH+TBLJrEb3OzesRtflWfIXIEJG1RBzIB0X8NofPgYqVMLG72Lgj4yPKxM2IyW
	 bYhYYo4P/wBqKMBbuwAN1k2uZn+4CpM/dnTEDNYC30/wgF0f2PigFHleP0POqNyPknl8E
	 mXRJfbsBQTSMPpoAbBAAbX3kMO6ShKTU9zVekfRCw3ZXFKphG/YoZSaszhbydT0zpQIMO
	 izNI4Y0rNHxhvPlwkCdGiAo6mhBEdWFQXd1lp/jcJ/F0I+sLjB0qory3wroo4EZV9qtQ/
	 Y9HSGhkx74vHJ/XD97iQo+AXLAC2lVJdvIIrFURsbtMkwdhHPqHMoW/126uTtyEd2DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795796870;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZbLOVBxW+TbmqdrtSMWDiPpH1JDX0i5iTnMkxU4NifE=;
	b=DRt6PI0z+nIqlSVN6UuZESR4jOwkqWY+hqISsGnC5JM2KUZeTNOajadaK9dy4qWsyagW
	 sEirXZt2dekBP+rlFN1+Zd0qVNMBpcuC5mXMQndoyVpqGrIA8fTBbkZhe+3ujC2MEwaZd
	 4xPWzkvi356/HQBlgIxHxemlZSqX/cq+S59zqZbhxg+ALjOGbkO+JeH/QrcXDv/qNZ+v8
	 LJSPfMGQw45+p12X6/nHQ51nve+sgKattz4Ju2J4MbsJ8qjBgcbQfkN0gZXT/4w0i/hbH
	 FaHVIfv+LYFmk7Ys2utwAPqWXjKU+CjAWt3Dw/eNZYBw55Af5+EsmGyM160sE1Q0wdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DRiHoQtP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44669606A321;
	Fri, 27 Nov 2026 16:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DRiHoQtP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7451F00893;
	Fri, 27 Nov 2026 16:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795796869;
	bh=ZbLOVBxW+TbmqdrtSMWDiPpH1JDX0i5iTnMkxU4NifE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DRiHoQtPRD7qCiFUCtBbeVhrtAQk5EjxAJ5I1xxaBeA51ybKlU4ABRQ4LyEyXyztc
	 oiReKad1nvrfaZKloLRokDalQlpeDeXFtc2g4bMzMVSwWq+oePd3k5Z0/4krVI1/t8
	 75NBSmtUPJM7/Jm1rdfjhZcisW3Y+yOnEiUyCOyd1QZUF/XWpwDcld94yr33K9W3Hs
	 sHafcqA0VyYWxIjN4P3S+isxUA56xbdsOGlNohR1afnq0YJ8IOS86O6JygazaZz8Qp
	 cii+N1WTfKpKbWM0sDZuQjt1cnQZaJty5Y2B995OY4iBop7UlY/kaAvHYiGNqiiL+k
	 3uKBAkgqae6DA==
From: Geert Uytterhoeven <geert@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
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
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Paul Elder <paul.elder+renesas@ideasonboard.com>,
	=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?= <clegoffic@baylibre.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v6 07/14] reset: Add reset_control_get_from_provider_exclusive()
Date: Fri, 27 Nov 2026 17:26:52 +0100
Message-ID: <6ba13f4ab5bf268259b60ae857e98c6be70f598a.1795796064.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795796064.git.geert+renesas@glider.be>
References: <cover.1795796064.git.geert+renesas@glider.be>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geert Uytterhoeven <geert+renesas@glider.be>

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
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
---
v6:
  - Rebase,

v5:
  - Add Tested-by, Reviewed-by,
  - Move of_node_get() after for-loop that may fail to fix device node
    reference leak on failure,

v4:
  - Check for overflow when converting (u64) fwnode args to (uint32_t)
    OF args,
  - Document that reset_control_get_from_provider_exclusive() must not
    be given a reference to a GPIO provider,

  - Let the dummy return ERR_PTR(-ENOTSUPP) instead of NULL,

v3:
  - Replace reset_controller_get_provider() by
    reset_control_get_from_provider_exclusive(),
  - Add kerneldoc,

v2:
  - No changes.
---
 drivers/reset/core.c  | 40 +++++++++++++++++++++++++++++++++++-----
 include/linux/reset.h |  8 ++++++++
 2 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 7679480644e7ecda..649c1dab543805d6 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -1233,6 +1233,7 @@ __reset_control_get_from_provider(const struct fwnode_reference_args *args,
 				  bool gpio_fallback,
 				  enum reset_control_flags flags)
 {
+	struct fwnode_handle *fwnode = consumer ?: args->fwnode;
 	struct reset_controller_dev *rcdev;
 	int rstc_id = -EINVAL;
 
@@ -1245,18 +1246,29 @@ __reset_control_get_from_provider(const struct fwnode_reference_args *args,
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
+			for (unsigned int i = 0; i < args->nargs; i++) {
+				if (args->args[i] > U32_MAX)
+					return ERR_PTR(-EINVAL);
+
+				of_args.args[i] = args->args[i];
+			}
+			of_args.np = of_node_get(np);
+			of_args.args_count = args->nargs;
+		}
 
 		rstc_id = rcdev->of_xlate(rcdev, &of_args);
 		of_node_put(of_args.np);
@@ -1348,6 +1360,24 @@ struct reset_control *__reset_control_get(struct device *dev, const char *id,
 }
 EXPORT_SYMBOL_GPL(__reset_control_get);
 
+/**
+ * reset_control_get_from_provider_exclusive - Lookup and obtain an exclusive
+ *					       reference to a reset controller.
+ * @args: Reference to the reset controller provider with all the args like
+ *	  reset number.  This must not be a reference to a GPIO provider.
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
index 9c391cf0c82298a0..384273ec0c7cbef7 100644
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
+	return ERR_PTR(-ENOTSUPP);
+}
+
 static inline int
 reset_control_bulk_reset(int num_rstcs, struct reset_control_bulk_data *rstcs)
 {
-- 
2.43.0

