Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FBCECAAD5
	for <linux-pm@archiver.kernel.org>; Tue,  6 Sep 2022 15:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbiIFPlf (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 6 Sep 2022 11:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239140AbiIFPiv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Sep 2022 11:38:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9F06C7432;
        Tue,  6 Sep 2022 07:48:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29BCC1AC1;
        Tue,  6 Sep 2022 07:24:37 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6E023F7B4;
        Tue,  6 Sep 2022 07:24:28 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        daniel.lezcano@linaro.org, tarek.el-sherbiny@arm.com,
        adrian.slatineanu@arm.com, souvik.chakravarty@arm.com,
        wleavitt@marvell.com, wbartczak@marvell.com,
        dan.carpenter@oracle.com, lukasz.luba@arm.com
Subject: [PATCH v2 2/3] powercap: arm_scmi: Fix signedness bug in probe
Date:   Tue,  6 Sep 2022 15:23:36 +0100
Message-Id: <20220906142337.1697569-3-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220906142337.1697569-1-cristian.marussi@arm.com>
References: <20220906142337.1697569-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

The "pr->num_zones" variable is an unsigned int so it can't be less than
zero.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/powercap/arm_scmi_powercap.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
index a91438867f8c..76200c004cad 100644
--- a/drivers/powercap/arm_scmi_powercap.c
+++ b/drivers/powercap/arm_scmi_powercap.c
@@ -389,11 +389,12 @@ static int scmi_powercap_probe(struct scmi_device *sdev)
 	if (!pr)
 		return -ENOMEM;
 
-	pr->num_zones = powercap_ops->num_domains_get(ph);
-	if (pr->num_zones < 0) {
+	ret = powercap_ops->num_domains_get(ph);
+	if (ret < 0) {
 		dev_err(dev, "number of powercap domains not found\n");
-		return pr->num_zones;
+		return ret;
 	}
+	pr->num_zones = ret;
 
 	pr->spzones = devm_kcalloc(dev, pr->num_zones,
 				   sizeof(*pr->spzones), GFP_KERNEL);
-- 
2.32.0

