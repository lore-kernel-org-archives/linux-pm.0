Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D648C433F5
	for <linux-pm@archiver.kernel.org>; Fri,  1 Apr 2022 14:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243139AbiDAOJL (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 1 Apr 2022 10:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239154AbiDAOJL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Apr 2022 10:09:11 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472A3276801;
        Fri,  1 Apr 2022 07:07:22 -0700 (PDT)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KVMQM3DNMz67m6h;
        Fri,  1 Apr 2022 22:05:47 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 1 Apr 2022 16:07:20 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 1 Apr 2022 15:07:19 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        <linux-iio@vger.kernel.org>
CC:     Paul Cercueil <paul@crapouillou.net>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH v2 3/3] iio: chemical: scd30: Move symbol exports into IIO_SCD30 namespace
Date:   Fri, 1 Apr 2022 15:06:05 +0100
Message-ID: <20220401140605.31871-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220401140605.31871-1-Jonathan.Cameron@huawei.com>
References: <20220401140605.31871-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Avoid unnecessary pollution of the global symbol namespace by
moving library functions in to a specific namespace and import
that into the drivers that make use of the functions.

For more info: https://lwn.net/Articles/760045/

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Tomasz Duszynski <tomasz.duszynski@octakon.com>
---
 drivers/iio/chemical/scd30_core.c   | 4 ++--
 drivers/iio/chemical/scd30_i2c.c    | 1 +
 drivers/iio/chemical/scd30_serial.c | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index 6c6c11c2772a..682fca39d14d 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -543,7 +543,7 @@ static int scd30_resume(struct device *dev)
 	return scd30_command_write(state, CMD_START_MEAS, state->pressure_comp);
 }
 
-EXPORT_SIMPLE_DEV_PM_OPS(scd30_pm_ops, scd30_suspend, scd30_resume);
+EXPORT_NS_SIMPLE_DEV_PM_OPS(scd30_pm_ops, scd30_suspend, scd30_resume, IIO_SCD30);
 
 static void scd30_stop_meas(void *data)
 {
@@ -759,7 +759,7 @@ int scd30_probe(struct device *dev, int irq, const char *name, void *priv,
 
 	return devm_iio_device_register(dev, indio_dev);
 }
-EXPORT_SYMBOL(scd30_probe);
+EXPORT_SYMBOL_NS(scd30_probe, IIO_SCD30);
 
 MODULE_AUTHOR("Tomasz Duszynski <tomasz.duszynski@octakon.com>");
 MODULE_DESCRIPTION("Sensirion SCD30 carbon dioxide sensor core driver");
diff --git a/drivers/iio/chemical/scd30_i2c.c b/drivers/iio/chemical/scd30_i2c.c
index 7c332e4e8e46..bae479a4721f 100644
--- a/drivers/iio/chemical/scd30_i2c.c
+++ b/drivers/iio/chemical/scd30_i2c.c
@@ -137,3 +137,4 @@ module_i2c_driver(scd30_i2c_driver);
 MODULE_AUTHOR("Tomasz Duszynski <tomasz.duszynski@octakon.com>");
 MODULE_DESCRIPTION("Sensirion SCD30 carbon dioxide sensor i2c driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_SCD30);
diff --git a/drivers/iio/chemical/scd30_serial.c b/drivers/iio/chemical/scd30_serial.c
index 8664f3ce6b33..3c519103d30b 100644
--- a/drivers/iio/chemical/scd30_serial.c
+++ b/drivers/iio/chemical/scd30_serial.c
@@ -261,3 +261,4 @@ module_serdev_device_driver(scd30_serdev_driver);
 MODULE_AUTHOR("Tomasz Duszynski <tomasz.duszynski@octakon.com>");
 MODULE_DESCRIPTION("Sensirion SCD30 carbon dioxide sensor serial driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_SCD30);
-- 
2.32.0

