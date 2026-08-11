Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ECD42CAEF
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 09:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786441821; cv=none; b=SsUha8EV+7PQRk+EMsPuPXUvTigTlsKbiclFig43ie+tSiZiPjeAq8h0rb412XY3RaY2bEKEepboTPDqBr40rLO+CNwGe6I3gDFYaw7lvgbMxDDcLxoQHpp3Y4EhmKGMEQjtg3FPB+SH0XZxYHClCjVfVzsW4bDPQ65VwwxgZRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786441821; c=relaxed/simple;
	bh=Pl2kUdKJ+qYOpSfTxMWy1zQLAiaqKA2y+j5AXFxthao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xc61TYxG0a/kaa+JDx9qwe1g5TASVH97LHvla/C6jqX1TMpP0Y/VWOZkEJTdmhVHpbwR2OLiIcVJhzIHIz0lOXWQKbLXMp7maX7TDPWRvB5yvTLR4/zmGFSqHAgf85XTItuFgYnQ4ppCoaUGsBPC+nL/SGrAYPsJvlYcBZ1Jimw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OT40Z+3b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MuZ0ifAh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OT40Z+3b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MuZ0ifAh"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67B43sAp3320866
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 09:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=W29QAFLCXAWo2HXPQA3yl6dvDbG9PPbbnxu
	UkjonBlM=; b=OT40Z+3bMb9EzJc4sDC57sACN/E5HP0ULhrInLvC4ad1dA5bErK
	YpoVy5Ym4GrbaoYBx7yswvZRwxIYzOaY7FoedzHNHVugUZJ8uUGfFbrQZNy8TZ/b
	iHUXUIS1so4hwz/pyEt00pHmU4GECebf5bkhT6UOGVUyPkeCg9eUPLDMe3czihs5
	Mjsh7PUsnHYAkJC/xpCB9FwysMwsZuOVmABJiOs6hA+8SL2cTUPNDfUtqyo+BONO
	W6IfxD64Vu7bpkkEVp3J0W/b/weVJ9iWkx5mIh7QoVffgAW9siw+kSeJlUCsi9g1
	cpaePL61BjAfnH3GX4efh+zXaWP+W3lC0sw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyvcr97xp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 09:50:17 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5283df62d68so34275131cf.0
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 02:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786441816; x=1787046616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=W29QAFLCXAWo2HXPQA3yl6dvDbG9PPbbnxuUkjonBlM=;
        b=MuZ0ifAhmpk5Iv8tnxo6JyqBoaJ/EBDEnufwR1b/97n93rxKoglzYB6JMy+zY0HEqZ
         mywwx2s+tBIxFKoM2m0cmJRKMZGOs6IuygO4BXNbmr2dDFi+zIjGAm1Zc9KNFaXW0Zsq
         V72HsHK080iNF6TabvIIypfqyIy6YcjS/oyf+zQC2F+LoOlIzn+/aig9vLU95inp+e7P
         bTurpWjJd5GRNMx8sxhpH41WEIvSLLAPW+01P9twiplVfxdMp3w5+FqQeIy8TuOgqKI2
         xcHJDdejvnqsk70RR6C4PVtt0cnmSovaWfoFxiwfdN3ptzWuy7ee/h265SuIa+zP3ja/
         lqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786441816; x=1787046616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W29QAFLCXAWo2HXPQA3yl6dvDbG9PPbbnxuUkjonBlM=;
        b=FkTlO+SZVt8vgwAS5wRi+Hx9xKwWlRB2U2d7Bz3r4LXc4as0FSjWvCOUGq1ekPvKWJ
         ayA8gZOXRJUNSuPs1Laejnt2jaohR/PZ/RSG/NOcd3E0JMcHZGVEDIrtmqcMaI63juoJ
         LZj5szTjbnHC2p2CUlHFjv54k6eJFl1ousqWFSbfy+b1UM62Xj3tJ6zctk1U5OOTUogP
         RCBbxDyRdc1A2XW17QDLe1gn6ttOBheJoQZnb1C/BltQ38Hs/UWqLMYXgJ+uQVQ4JnxL
         ohVKxmwJ7JcY03ujDZDeWtHg1hVJ2P5/s2GBmvy7LkD+iiudGK1adkQPg/vaST9yFZvA
         EchA==
X-Forwarded-Encrypted: i=1; AHgh+RqtKHdfUKjnybAGMQRKdzNSyHVACBDvzYDIwqZcmZvIQSrhm6FuWqyWiOrZXdrU2Fkg3VZDqdbScA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz81YX6twuDnbE+jPtcfJ2Oa6bMfZ9K9rDmclT49penH/Sm5o1+
	8/THMY93dWRx+nwN5SW1YvOko0+X3MZdSjhf2Z7PGI+qeCHP+6Zc/w225Sd6IRGNqQLpsqCJ4M9
	p33jrZboqicvqowv7/ccox0lgHMEIaUgFqfhg7BVRV1/KQBYnKfw2jWomyj5AXfgwogR7fg==
X-Gm-Gg: AR+sD12hHFzXdghPse1DMkUk3PloypEe7Q3++yHghGkXOyHN4lSzWaI/oIJqc4MFd9e
	LOFfUPPXNAjvF1DYxZzoM9jmmwUyK9zMuAxnaOV1uR9vIAD915kyYp0B9Rft+OOxjW8zvvd/JQx
	WdLKeAxt0NpT4+Fd49AacZR6+dEItsBbhpgA7FMgeXclDaU6/kaOc5QAVzxpGFqEkqB50IrakkP
	kMGeuBtQaFaeYnWISElrq4m+FtNUWGp775uOhb9z1vgqpHuucrASwpArGKTq5e2t3kf+rMA1LdI
	ktPyqlasBjRMQHhRPfCeDVgodAV/LQrRTl3pREt5fcLDeCzx6UlgvmeUwe+CpiHKV3MHAl9jHNc
	c3jKw6sJiRxLYicC9aWPS
X-Received: by 2002:a05:622a:4c06:b0:51c:f3:34d9 with SMTP id d75a77b69052e-52d58617feemr15048591cf.27.1786441816123;
        Tue, 11 Aug 2026 02:50:16 -0700 (PDT)
X-Received: by 2002:a05:622a:4c06:b0:51c:f3:34d9 with SMTP id d75a77b69052e-52d58617feemr15048301cf.27.1786441815626;
        Tue, 11 Aug 2026 02:50:15 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:b467:f322:cd3a:615c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49977e89d68sm25843225e9.3.2026.08.11.02.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 02:50:14 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
X-Google-Original-From: Daniel Lezcano <daniel.lezcano@kernel.org>
To: rafael@kernel.org, daniel.lezcano@kernel.org
Cc: quic_skakitap@quicinc.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        kernel test robot <lkp@intel.com>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        linux-arm-msm@vger.kernel.org (open list:QUALCOMM TSENS THERMAL DRIVER)
Subject: [PATCH] thermal/drivers/qcom/spm mbg tm: Fix missing bitfield header
Date: Tue, 11 Aug 2026 11:49:35 +0200
Message-ID: <20260811094935.2941313-1-daniel.lezcano@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA4MSBTYWx0ZWRfX2FNgaEopwS45
 W6QwvexSFQgPe2+QZ+o4y07K9F49Hw4HKJoVawrv+EgQzePX2rQ/a820kaXgstHjEjlqV7aG52L
 sGPfv6rhSi35mbsW2MWootUPJFS1Ld86kRXTPehL8KpYYua5KLCt8zqsS1PEwXp0eVFc0NoISbJ
 c19lKoR0aCdXKzv9iZal/gSuCGP0g8vC21ombxnRrLEn4/VL5pN8ltXlU6KDQIwyWlsk69l7Ll7
 NFAdNJakfralGZ+SR+X0xT9WFA2ZfTz7ILYYilPpgl3of7BEWHjHor/xntJPpb0r1uum5d6TfF9
 h2SSVrUJoDNKMniipcghTVwxOWdP+NrEE3209M+XoNYLCpDBBaa2WRyshZ/cnSjlj7li9RBK/rG
 O5+FAx1XCnPswdPhlElGTJbw6PmS0FRzGFY57/CqoM8+vg54GLgMlH0g/Bph5jLe0LVHTGYCzbs
 9jHuzj5YORstb32QvqA==
X-Authority-Analysis: v=2.4 cv=e/A2j6p/ c=1 sm=1 tr=0 ts=6a7af059 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8
 a=DMto2hupFwl-eosNTDkA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: czHzP8SF3JxV4McRZsQEUcX9Yc6G6EC8
X-Proofpoint-ORIG-GUID: czHzP8SF3JxV4McRZsQEUcX9Yc6G6EC8
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA4MSBTYWx0ZWRfX8VJxS4hEj364
 t3QOjvzmLpgjd3rTCyhKpgH1mZruVBjajN4+TMxmB2tK6z5IR/9GfCDZl2r3cp6yBaUGOcxJs1b
 UMC+nLNp4rctl27tzIFHIhFwRDxxNs4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110081

From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>

Add missing bitfield header leading to the error:

>> drivers/thermal/qcom/qcom-spmi-mbg-tm.c:184:21: error: implicit declaration of function 'FIELD_GET' [-Wimplicit-function-declaration]
     184 |                 if (FIELD_GET(MON_FAULT_STATUS_MASK, val) == MON_FAULT_LVL1_UPR)
         |                     ^~~~~~~~~

Fixes: c3dce117333c ( "thermal/drivers/qcom: Add support for Qualcomm MBG thermal monitoring")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202608080800.RfxKb9uR-lkp@intel.com/
Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/thermal/qcom/qcom-spmi-mbg-tm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-mbg-tm.c b/drivers/thermal/qcom/qcom-spmi-mbg-tm.c
index fa2f10002253..0492d5eeca01 100644
--- a/drivers/thermal/qcom/qcom-spmi-mbg-tm.c
+++ b/drivers/thermal/qcom/qcom-spmi-mbg-tm.c
@@ -2,7 +2,7 @@
 /*
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
-
+#include <linux/bitfield.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/module.h>
-- 
2.43.0

