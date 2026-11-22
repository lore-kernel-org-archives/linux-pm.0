Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795369593;
	b=oTnVmq4x9zDezF5AQM0J3kKtGE0Z8ICz1LB6HOWdjpXv38XdGlzhgvwgLpZl+zLlYhY6
	 LGTSRLHewHI/2neVYlpr5ZZFJ4i5EfOziPBIUPTCR1IPI5IkSz7UqDguR89oMblusHpVL
	 /d/a82oolynLbvzjhEZFYblVdHfFPvyYzejSHhy0Jk8pQx2i1hepJkIFdLgf+1/nfv1QW
	 kjmo1ibA7pj5f2Q1M4Yg/FSILf3qSPHYNblu6xkfjj5OwUDlmS1YJlErEo+6rwzBG5i4y
	 hG0mUqqpZvIMmr0ou6Ytb6zeQQO6mdQLJECx1PLaHyTmQGfW7e+ATk9yJ4WWbMpnyBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795369593;
	h=Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=MX4AuuJoMYSxYZiHUPqc22C4eimCc070RG8xpdnYVMQ=;
	b=MZxEWaMh5Jqcu8Mld63xAtGvxBfoJDxayf3zhx56lOf/AyIfUK8Lnq+E2HdC1w45tsrA
	 rMpMK76KG5RGUcFLsPuxR7eF+jQ1H6Rq1bkCDLOdkzTPYh8DTfcFqyFN0XKezEirRu44X
	 HzbcMYM9RWsApL/VY5eGp9yyIwKHhV+NAvUv5l8LJueulEDrH0TQAO14c2Ct3gMI+63Uh
	 hoKTvZpeWF1OL6xQIBGgEQ0fOcd4C2sZmENinJ6VYHGNGMIsrKtMrXqiNkvL5rvwyEO/U
	 v/947gMPZIs57rIWyL/mTLiS4R2ccSJt/sCwNSkJpVaBMlZdCSIR3P2Gq4wu/RBEmgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A6A606A32C;
	Sun, 22 Nov 2026 17:46:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B5371F000D2;
	Sun, 22 Nov 2026 17:46:32 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Sun, 22 Nov 2026 18:46:20 +0100
Subject: [PATCH 1/2] soc: qcom: socinfo: Copy new SoC IDs from bindings
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261122-qcom-socinfo-id-dt-bindings-v1-1-eeee0ffa25da@oss.qualcomm.com>
References: <20261122-qcom-socinfo-id-dt-bindings-v1-0-eeee0ffa25da@oss.qualcomm.com>
In-Reply-To: <20261122-qcom-socinfo-id-dt-bindings-v1-0-eeee0ffa25da@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Ilia Lin <ilia.lin@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5036;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=8/xtmPULKzx0ql+F/v4X8s5yyktKMq8PdtriG1YsHPg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBrAypvngpuRNic4fIUibH9BLpRCiYwUp3hdbJk7
 SQ/rit/V3GJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCawMqbwAKCRDBN2bmhouD
 1912D/4tusIeb1uxw8GrECU1mqjhrAGQfWdDB/FPD4bM91y/58QfcjR6kXO74Cz6wWBG2mmjBF0
 QQNenb5PMC/hvPegGep4avjNEpH3vM8iT47dHye8MFPNPx07qpaSrWCRS5QwRJWPNVFLYiYhQ7u
 NZ9gq6HAw1IrtrW33ZFfhqxTmCZ3xx4FvjIkXUb5V5Q8l0t3f+sOoDmOWMu7TBE5DUZRSH8bS0a
 i4t7jSASsO0yutScileyKOR1BcXC0XnRdUCf8Gy20MzUXAAxKnri0lAC8NZhcYXUqY4Xv0w0Oha
 NdvjqpgXpvBaU93K8DfV8WZG6WMPJLSM6A041gHuO5DW+9MK3PHuJiQ8MfEL2qg9k4oc5PBlxTo
 bMDk4+rVN+uM7fE7u6LXvfgkiRRtBhbJQhZrJ++Fl7dAQ3cG4inHrPvlUvSmlUgsTJRYPIXmTnE
 UYch9P4Yy39OufbiUDNTGsFbog6171Bgal0NQ3TdEblKxFsfFZ4N8PEI/5DhqnCuTISoO+ogl6B
 wXO+9yLc+Qaw5tJ+fOigYvnWs9VxO9Z4oujNG/nz4zRIvWl2jXy+x4F6hCbW0k+FszX3hVErrTJ
 zsQdYwFixbw/hzI1NJC/5BGAmQHp9CWKfPhBHH5hmDAIwSqicJkPl2mp1+hZakiztjlBOkoTpEW
 rDHsBdwxYyxaorA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The IDs of newer Qualcomm SoCs, as reported by hardware or firmware, are
currently used only in the socinfo.c driver.  There should no and there
is no in-tree DTS user of these, so none of these constants are really
proper Devicetree ABI.  IDs of older SoCs were being used in DTS, thus
that part matches the concept behind DT bindings.

Copy arbitrarily chosen newer SoC IDs from DT bindings to the regular
header of socinfo driver and use it when needed, so later they could be
removed from the bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/clk/qcom/apss-ipq6018.c      |  2 +-
 drivers/cpufreq/qcom-cpufreq-nvmem.c |  1 +
 include/linux/soc/qcom/socinfo.h     | 94 ++++++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/apss-ipq6018.c b/drivers/clk/qcom/apss-ipq6018.c
index 32347e6d8775..b4babeece2e0 100644
--- a/drivers/clk/qcom/apss-ipq6018.c
+++ b/drivers/clk/qcom/apss-ipq6018.c
@@ -11,9 +11,9 @@
 #include <linux/module.h>
 #include <linux/clk.h>
 #include <linux/soc/qcom/smem.h>
+#include <linux/soc/qcom/socinfo.h>
 
 #include <dt-bindings/clock/qcom,apss-ipq.h>
-#include <dt-bindings/arm/qcom,ids.h>
 
 #include "common.h"
 #include "clk-regmap.h"
diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 2b458ed1f6cf..3f933a434526 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -29,6 +29,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/soc/qcom/smem.h>
+#include <linux/soc/qcom/socinfo.h>
 
 #include <dt-bindings/arm/qcom,ids.h>
 
diff --git a/include/linux/soc/qcom/socinfo.h b/include/linux/soc/qcom/socinfo.h
index ba823a0013c5..cd2e8eddf3b5 100644
--- a/include/linux/soc/qcom/socinfo.h
+++ b/include/linux/soc/qcom/socinfo.h
@@ -112,4 +112,98 @@ enum qcom_socinfo_feature_code {
 #define SOCINFO_PCn(n)			((n) + 1)
 #define SOCINFO_PC_RESERVE		(BIT(31) - 1)
 
+/* SoC IDs */
+#define QCOM_ID_QRB5165			455
+#define QCOM_ID_SM8450			457
+#define QCOM_ID_SM7225			459
+#define QCOM_ID_SA8295P			460
+#define QCOM_ID_SA8540P			461
+#define QCOM_ID_QCM4290			469
+#define QCOM_ID_QCS4290			470
+#define QCOM_ID_SM7325			475
+#define QCOM_ID_SM8450_2		480
+#define QCOM_ID_SM8450_3		482
+#define QCOM_ID_SC7280			487
+#define QCOM_ID_SC7180P			495
+#define QCOM_ID_QCM6490			497
+#define QCOM_ID_QCS6490			498
+#define QCOM_ID_SM7325P			499
+#define QCOM_ID_IPQ5000			503
+#define QCOM_ID_IPQ0509			504
+#define QCOM_ID_IPQ0518			505
+#define QCOM_ID_SM7450			506
+#define QCOM_ID_SM6375			507
+#define QCOM_ID_IPQ9514			510
+#define QCOM_ID_IPQ9550			511
+#define QCOM_ID_IPQ9554			512
+#define QCOM_ID_IPQ9570			513
+#define QCOM_ID_IPQ9574			514
+#define QCOM_ID_SM8550			519
+#define QCOM_ID_IPQ5016			520
+#define QCOM_ID_IPQ9510			521
+#define QCOM_ID_QRB4210			523
+#define QCOM_ID_QRB2210			524
+#define QCOM_ID_SAR2130P		525
+#define QCOM_ID_SM8475			530
+#define QCOM_ID_SM8475P			531
+#define QCOM_ID_SA8255P			532
+#define QCOM_ID_SA8650P			533
+#define QCOM_ID_SA8775P			534
+#define QCOM_ID_QRU1000			539
+#define QCOM_ID_SM8475_2		540
+#define QCOM_ID_QDU1000			545
+#define QCOM_ID_SM7450P			547
+#define QCOM_ID_X1E80100		555
+#define QCOM_ID_SM8650			557
+#define QCOM_ID_SM4450			568
+#define QCOM_ID_SAR1130P		579
+#define QCOM_ID_QDU1010			587
+#define QCOM_ID_QRU1032			588
+#define QCOM_ID_QRU1052			589
+#define QCOM_ID_QRU1062			590
+#define QCOM_ID_IPQ5332			592
+#define QCOM_ID_IPQ5322			593
+#define QCOM_ID_IPQ5312			594
+#define QCOM_ID_IPQ5302			595
+#define QCOM_ID_QCS8550			603
+#define QCOM_ID_QCM8550			604
+#define QCOM_ID_SM8750			618
+#define QCOM_ID_IPQ5300			624
+#define QCOM_ID_SM7635			636
+#define QCOM_ID_SM6650			640
+#define QCOM_ID_SM6650P			641
+#define QCOM_ID_IPQ5321			650
+#define QCOM_ID_IPQ5424			651
+#define QCOM_ID_QCM6690			657
+#define QCOM_ID_QCS6690			658
+#define QCOM_ID_SM7750			659
+#define QCOM_ID_SM8850			660
+#define QCOM_ID_IPQ5404			671
+#define QCOM_ID_QCS9100			667
+#define QCOM_ID_QCS8300			674
+#define QCOM_ID_QCS8275			675
+#define QCOM_ID_QCS9075			676
+#define QCOM_ID_QCS615			680
+#define QCOM_ID_SA8797P			690
+#define QCOM_ID_SM8975			707
+#define QCOM_ID_CQ7790M			731
+#define QCOM_ID_CQ7790S			732
+#define QCOM_ID_SM8950			735
+#define QCOM_ID_CQ2390M			756
+#define QCOM_ID_CQ2390S			758
+#define QCOM_ID_IQ2390S			759
+#define QCOM_ID_IPQ5200			765
+#define QCOM_ID_IPQ5210			766
+#define QCOM_ID_QCF2200			767
+#define QCOM_ID_QCF3200			768
+#define QCOM_ID_QCF3210			769
+#define QCOM_ID_IPQ9620			770
+#define QCOM_ID_IPQ9650			771
+#define QCOM_ID_IPQ9610			778
+#define QCOM_ID_IPQ9630			779
+#define QCOM_ID_IPQ9640			780
+#define QCOM_ID_IPQ9670			781
+#define QCOM_ID_QCF3211			801
+#define QCOM_ID_IPQ5211			802
+
 #endif

-- 
2.53.0

