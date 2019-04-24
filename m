Return-Path: <SRS0=aEVV=S2=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1197FC282CE
	for <linux-pm@archiver.kernel.org>; Wed, 24 Apr 2019 07:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99D22148D
	for <linux-pm@archiver.kernel.org>; Wed, 24 Apr 2019 07:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbfDXHol (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 24 Apr 2019 03:44:41 -0400
Received: from shell.v3.sk ([90.176.6.54]:39532 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbfDXHok (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 24 Apr 2019 03:44:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id C6C77102E3F;
        Wed, 24 Apr 2019 09:44:37 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id yiBaIRYjWK8x; Wed, 24 Apr 2019 09:44:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 1328A102DF4;
        Wed, 24 Apr 2019 09:44:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id iLATwcmFneD3; Wed, 24 Apr 2019 09:44:06 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 1970E102E2F;
        Wed, 24 Apr 2019 09:44:01 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v6 07/10] Platform: OLPC: Add a regulator for the DCON
Date:   Wed, 24 Apr 2019 09:43:50 +0200
Message-Id: <20190424074353.458446-8-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424074353.458446-1-lkundrak@v3.sk>
References: <20190424074353.458446-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

All OLPC ECs are able to turn the power to the DCON on an off. Use the
regulator framework to expose the functionality.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v1:
- Use idiomatic form of return on error
- Avoid mixing bool and int

 drivers/platform/olpc/Kconfig   |  1 +
 drivers/platform/olpc/olpc-ec.c | 67 +++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/drivers/platform/olpc/Kconfig b/drivers/platform/olpc/Kconfi=
g
index 559f843199d7..858ac1d2290a 100644
--- a/drivers/platform/olpc/Kconfig
+++ b/drivers/platform/olpc/Kconfig
@@ -1,4 +1,5 @@
 config OLPC_EC
+	select REGULATOR
 	bool
=20
 config OLPC_XO175_EC
diff --git a/drivers/platform/olpc/olpc-ec.c b/drivers/platform/olpc/olpc=
-ec.c
index a91f78245f5e..8566bcf2938d 100644
--- a/drivers/platform/olpc/olpc-ec.c
+++ b/drivers/platform/olpc/olpc-ec.c
@@ -16,6 +16,7 @@
 #include <linux/workqueue.h>
 #include <linux/init.h>
 #include <linux/list.h>
+#include <linux/regulator/driver.h>
 #include <linux/olpc-ec.h>
=20
 struct ec_cmd_desc {
@@ -36,6 +37,10 @@ struct olpc_ec_priv {
 	struct work_struct worker;
 	struct mutex cmd_lock;
=20
+	/* DCON regulator */
+	struct regulator_dev *dcon_rdev;
+	bool dcon_enabled;
+
 	/* Pending EC commands */
 	struct list_head cmd_q;
 	spinlock_t cmd_q_lock;
@@ -346,9 +351,61 @@ static struct dentry *olpc_ec_setup_debugfs(void)
=20
 #endif /* CONFIG_DEBUG_FS */
=20
+static int olpc_ec_set_dcon_power(struct olpc_ec_priv *ec, bool state)
+{
+	unsigned char ec_byte =3D state;
+	int ret;
+
+	if (ec->dcon_enabled =3D=3D state)
+		return 0;
+
+	ret =3D olpc_ec_cmd(EC_DCON_POWER_MODE, &ec_byte, 1, NULL, 0);
+	if (ret)
+		return ret;
+
+	ec->dcon_enabled =3D state;
+	return 0;
+}
+
+static int dcon_regulator_enable(struct regulator_dev *rdev)
+{
+	struct olpc_ec_priv *ec =3D rdev_get_drvdata(rdev);
+
+	return olpc_ec_set_dcon_power(ec, true);
+}
+
+static int dcon_regulator_disable(struct regulator_dev *rdev)
+{
+	struct olpc_ec_priv *ec =3D rdev_get_drvdata(rdev);
+
+	return olpc_ec_set_dcon_power(ec, false);
+}
+
+static int dcon_regulator_is_enabled(struct regulator_dev *rdev)
+{
+	struct olpc_ec_priv *ec =3D rdev_get_drvdata(rdev);
+
+	return ec->dcon_enabled ? 1 : 0;
+}
+
+static struct regulator_ops dcon_regulator_ops =3D {
+	.enable		=3D dcon_regulator_enable,
+	.disable	=3D dcon_regulator_disable,
+	.is_enabled	=3D dcon_regulator_is_enabled,
+};
+
+static const struct regulator_desc dcon_desc =3D {
+	.name	=3D "dcon",
+	.id	=3D 0,
+	.ops	=3D &dcon_regulator_ops,
+	.type	=3D REGULATOR_VOLTAGE,
+	.owner	=3D THIS_MODULE,
+};
+
 static int olpc_ec_probe(struct platform_device *pdev)
 {
 	struct olpc_ec_priv *ec;
+	struct regulator_config config =3D { };
 	int err;
=20
 	if (!ec_driver)
@@ -376,6 +433,16 @@ static int olpc_ec_probe(struct platform_device *pde=
v)
 		return err;
 	}
=20
+	config.dev =3D pdev->dev.parent;
+	config.driver_data =3D ec;
+	ec->dcon_enabled =3D true;
+	ec->dcon_rdev =3D devm_regulator_register(&pdev->dev, &dcon_desc,
+								&config);
+	if (IS_ERR(ec->dcon_rdev)) {
+		dev_err(&pdev->dev, "failed to register DCON regulator\n");
+		return PTR_ERR(ec->dcon_rdev);
+	}
+
 	ec->dbgfs_dir =3D olpc_ec_setup_debugfs();
=20
 	return err;
--=20
2.21.0

