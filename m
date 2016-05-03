From: Pramod Gurav <pramod.gurav@linaro.org>
Subject: [PATCH v2 2/2] MAINTAINERS: Update the files to include the Qualcomm DMA folder
Date: Tue,  3 May 2016 15:07:17 +0530
Message-ID: <1462268237-29508-2-git-send-email-pramod.gurav@linaro.org>
References: <1462268237-29508-1-git-send-email-pramod.gurav@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34040 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755495AbcECJhl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 May 2016 05:37:41 -0400
Received: by mail-pf0-f171.google.com with SMTP id y69so7626236pfb.1
        for <linux-pm@vger.kernel.org>; Tue, 03 May 2016 02:37:40 -0700 (PDT)
In-Reply-To: <1462268237-29508-1-git-send-email-pramod.gurav@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: vinod.koul@intel.com, andy.gross@linaro.org, ulf.hansson@linaro.org, rjw@rjwysocki.net, linux-arm-msm@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, stanimir.varbanov@linaro.org, okaya@codeaurora.org, Pramod Gurav <pramod.gurav@linaro.org>

Recently all qcom dma drivers were moved a separate directory. Update
the files to include the same

Signed-off-by: Pramod Gurav <pramod.gurav@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d826f1b..2327f92 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1407,6 +1407,7 @@ L:	linux-arm-msm@vger.kernel.org
 L:	linux-soc@vger.kernel.org
 S:	Maintained
 F:	arch/arm/mach-qcom/
+F:	drivers/dma/qcom/
 F:	drivers/soc/qcom/
 F:	drivers/tty/serial/msm_serial.h
 F:	drivers/tty/serial/msm_serial.c
-- 
1.8.2.1

