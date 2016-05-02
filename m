From: Pramod Gurav <pramod.gurav@linaro.org>
Subject: [PATCH 2/2] MAINTAINERS: Update the files to include the Qualcomm DMA folder
Date: Mon,  2 May 2016 17:47:55 +0530
Message-ID: <1462191475-30904-2-git-send-email-pramod.gurav@linaro.org>
References: <1462191475-30904-1-git-send-email-pramod.gurav@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36050 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753306AbcEBMSR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 May 2016 08:18:17 -0400
Received: by mail-pa0-f54.google.com with SMTP id bt5so72751873pac.3
        for <linux-pm@vger.kernel.org>; Mon, 02 May 2016 05:18:16 -0700 (PDT)
In-Reply-To: <1462191475-30904-1-git-send-email-pramod.gurav@linaro.org>
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

