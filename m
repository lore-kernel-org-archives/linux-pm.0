Return-Path: <SRS0=aEVV=S2=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFED2C282CE
	for <linux-pm@archiver.kernel.org>; Wed, 24 Apr 2019 07:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF0E218B0
	for <linux-pm@archiver.kernel.org>; Wed, 24 Apr 2019 07:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbfDXHol (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 24 Apr 2019 03:44:41 -0400
Received: from shell.v3.sk ([90.176.6.54]:39540 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729759AbfDXHol (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 24 Apr 2019 03:44:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 058C8102D4D;
        Wed, 24 Apr 2019 09:44:39 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id XoMVVkQgKVeA; Wed, 24 Apr 2019 09:44:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 84CCD102E79;
        Wed, 24 Apr 2019 09:44:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 113I0vnT6q6y; Wed, 24 Apr 2019 09:44:07 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id C890D102E41;
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
Subject: [PATCH v6 10/10] Platform: OLPC: Add restart support to XO-1.75 EC driver
Date:   Wed, 24 Apr 2019 09:43:53 +0200
Message-Id: <20190424074353.458446-11-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424074353.458446-1-lkundrak@v3.sk>
References: <20190424074353.458446-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This hooks to arm_pm_restart instead od utilizing a restart handler
notifier, because the reboot dance on XO 1.75 needs to sleep (it pokes a
GPIO and waits for the EC to initiate the command transaction) and the
restart handler is called in atomic context. Sad.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v4:
- Split off from the driver.

 drivers/platform/olpc/Kconfig         |  2 +-
 drivers/platform/olpc/olpc-xo175-ec.c | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/olpc/Kconfig b/drivers/platform/olpc/Kconfi=
g
index 858ac1d2290a..02b232c34444 100644
--- a/drivers/platform/olpc/Kconfig
+++ b/drivers/platform/olpc/Kconfig
@@ -4,7 +4,7 @@ config OLPC_EC
=20
 config OLPC_XO175_EC
 	tristate "OLPC XO 1.75 Embedded Controller"
-	depends on ARCH_MMP || COMPILE_TEST
+	depends on ARM && (ARCH_MMP || COMPILE_TEST)
 	select SPI_SLAVE
 	select OLPC_EC
 	help
diff --git a/drivers/platform/olpc/olpc-xo175-ec.c b/drivers/platform/olp=
c/olpc-xo175-ec.c
index 997e6b7813de..12dc82f5e2b5 100644
--- a/drivers/platform/olpc/olpc-xo175-ec.c
+++ b/drivers/platform/olpc/olpc-xo175-ec.c
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/spi/spi.h>
+#include <asm/system_misc.h>
=20
 struct ec_cmd_t {
 	u8 cmd;
@@ -578,6 +579,14 @@ static int olpc_xo175_ec_set_event_mask(unsigned int=
 mask)
 	return olpc_ec_cmd(CMD_WRITE_EXT_SCI_MASK, args, 2, NULL, 0);
 }
=20
+static void olpc_xo175_ec_restart(enum reboot_mode mode, const char *cmd=
)
+{
+	while (1) {
+		olpc_ec_cmd(CMD_POWER_CYCLE, NULL, 0, NULL, 0);
+		mdelay(1000);
+	}
+}
+
 static void olpc_xo175_ec_power_off(void)
 {
 	while (1) {
@@ -649,6 +658,8 @@ static int olpc_xo175_ec_remove(struct spi_device *sp=
i)
 {
 	if (pm_power_off =3D=3D olpc_xo175_ec_power_off)
 		pm_power_off =3D NULL;
+	if (arm_pm_restart =3D=3D olpc_xo175_ec_restart)
+		arm_pm_restart =3D NULL;
=20
 	spi_slave_abort(spi);
=20
@@ -716,6 +727,8 @@ static int olpc_xo175_ec_probe(struct spi_device *spi=
)
=20
 	if (pm_power_off =3D=3D NULL)
 		pm_power_off =3D olpc_xo175_ec_power_off;
+	if (arm_pm_restart =3D=3D NULL)
+		arm_pm_restart =3D olpc_xo175_ec_restart;
=20
 	dev_info(&spi->dev, "OLPC XO-1.75 Embedded Controller driver\n");
=20
--=20
2.21.0

