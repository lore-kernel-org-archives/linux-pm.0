From: Pramod Gurav <pramod.gurav@linaro.org>
Subject: [PATCH v3 2/2] MAINTAINERS: Update the files to include the Qualcomm DMA folder
Date: Wed,  4 May 2016 14:12:03 +0530
Message-ID: <1462351323-29530-2-git-send-email-pramod.gurav@linaro.org>
References: <1462351323-29530-1-git-send-email-pramod.gurav@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462351323-29530-1-git-send-email-pramod.gurav@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, andy.gross@linaro.org, ulf.hansson@linaro.org, rjw@rjwysocki.net, linux-arm-msm@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, stanimir.varbanov@linaro.org, okaya@codeaurora.org, Pramod Gurav <pramod.gurav@linaro.org>
List-Id: linux-pm@vger.kernel.org

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
