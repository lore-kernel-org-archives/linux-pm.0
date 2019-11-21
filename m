Return-Path: <SRS0=nqDD=ZN=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454D8C432C3
	for <linux-pm@archiver.kernel.org>; Thu, 21 Nov 2019 03:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06EA2208C3
	for <linux-pm@archiver.kernel.org>; Thu, 21 Nov 2019 03:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574306471;
	bh=Ez6X3EKrkxhppyCurfnzf160xqaEmJGUUDMp8vXIXhM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=nU4ps855Bz2OuEG2T0TRN12n+PRV8CYv0hYw+neOvmnfll02fi5zcteOg6W9hpo/F
	 h1LXzEJTgyGVmU4+tvl8Z7hjgSUGtyMg8P0NNK/rLj9AxP9XtNEtMvCP+O6JJADdZH
	 DGWafZBMtVFuatYydkOmaYyYaOw7G83kDpPokRTc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfKUDVK (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 20 Nov 2019 22:21:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:35208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbfKUDVJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 20 Nov 2019 22:21:09 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A76FE208CE;
        Thu, 21 Nov 2019 03:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574306469;
        bh=Ez6X3EKrkxhppyCurfnzf160xqaEmJGUUDMp8vXIXhM=;
        h=From:To:Cc:Subject:Date:From;
        b=VSM9cNglHXCjUUaiqDjqpR/fymL0/I82COgAM48NBfhZasH1dtOnuncvPzVEjP4pT
         /YRk2IO0fs1Rk/ZzgX/Vu6L3nwO0cJ4TLYl3tuOQ6ZNixaJJkCxvRzOc0BluEuQN6y
         prEDEdTIUjEYj1R42AEpy43SAS1O1UQ+YIhw7Juo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v2] interconnect: qcom: Fix Kconfig indentation
Date:   Thu, 21 Nov 2019 04:21:05 +0100
Message-Id: <1574306465-8959-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Fix also 7-space and tab+1 space indentation issues.
---
 drivers/interconnect/qcom/Kconfig | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index c49afbea3458..2f9304d1db49 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -6,13 +6,13 @@ config INTERCONNECT_QCOM
 	  Support for Qualcomm's Network-on-Chip interconnect hardware.
 
 config INTERCONNECT_QCOM_MSM8974
-       tristate "Qualcomm MSM8974 interconnect driver"
-       depends on INTERCONNECT_QCOM
-       depends on QCOM_SMD_RPM
-       select INTERCONNECT_QCOM_SMD_RPM
-       help
-         This is a driver for the Qualcomm Network-on-Chip on msm8974-based
-         platforms.
+	tristate "Qualcomm MSM8974 interconnect driver"
+	depends on INTERCONNECT_QCOM
+	depends on QCOM_SMD_RPM
+	select INTERCONNECT_QCOM_SMD_RPM
+	help
+	 This is a driver for the Qualcomm Network-on-Chip on msm8974-based
+	 platforms.
 
 config INTERCONNECT_QCOM_QCS404
 	tristate "Qualcomm QCS404 interconnect driver"
-- 
2.7.4

