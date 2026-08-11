Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F8D429029
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 09:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786441689; cv=none; b=PlsgqzvuRkAZZXBI+Ckpeh+B3DJUqRYM1FuyXkMpgSfbu0mQmq78vDb/sELCfpsCRcFSClTJlKgbT2h4YCaLDfSWGnqoprTced040UdKhQLBA5QFuhK329o7/TjKGJfcGcwwRzxGvYjzIjWaPeQxFIe0tEeAA/TBGB3N/uKiOQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786441689; c=relaxed/simple;
	bh=QzmCUnjK2xK6h6dcf9afMQk3FbBG7sQSvgg2J6eiaeo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fpwumcYVAYDldbuIATuqt81tDiqQI9FDizMXZRjVNin9A5qGfSKLA42aTvPtpCcJGoKhwS503EaOuauDZKHI10dJG8MShxdclJapwiSOvs/yhCSMZPEFJDCLToA+AUrHN8WREKhwc5vvOY4GwJ2J7e8GLmaGjDDtp9k6Sddmy9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fkx+OICi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g/TBbO+x; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fkx+OICi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g/TBbO+x"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67B7Cb4v2253080
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 09:48:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=XRRJf27PlMRl2eUNhoseK4
	/8lRsT3z/R0NPruWur/XQ=; b=Fkx+OICie/TUk2ZZiEMDiD0CGod7vNBdmReDWz
	QDSB/+VHmbuThQQ3R7RSCTKneG6srmGbRVyzi0lcR56szcVVuRUWiGkq/YbIDr3W
	M5rZ9YNl1flxeLNbNHeRozpmJ/9xIEPdXMa4BvdFOPMvvaua8zWK7VcsKn63f9g4
	Dl8GsMIixfjqv880IrZ/TbtVwTHZhbC5WmZ8WJ98+llo7QUV/qb8oWo49XVuQdeR
	9a4RVVAI/5Hsf/sRy5KXhYmizrX3TPJthaBrtQ2Ps4Cm/zryg1DzM9s9yfeFP6Ho
	4xYi+P3OnL0ozSrYpIqxcLTz6dN28TY4Xz/H8lExP6/Q+s6g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjk7bj3x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 09:48:03 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c1a9764f0so3307231cf.1
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 02:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786441682; x=1787046482; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XRRJf27PlMRl2eUNhoseK4/8lRsT3z/R0NPruWur/XQ=;
        b=g/TBbO+xQNkubnFU0ygEQN7RLG/pW9kBiG9iTtDy7E3hrt0flKUkeTLi2w/CyTt++E
         XmkcapcMtAunJjczIpqly+H41j3qotr2S1VULYFVPUrPQ0K1k4wyqf8A6+tsuPqwtnXm
         Jv61UJOnpUhuP3djpcQM/N6AaRd99+gdTBqlbiPn1BceNZPEG/huTz2nsVmBm0DbJgwN
         mMb99WPOUoaQMUdrVeQHRNxU3ywZ2hfvdtLdufe2ItXoz/1IYbID81kE41jCLymA1ace
         GxrfLMDBI1KBX+O25l5DkvMCZ6vTzsaOBqlGDWC0sqS2kw+HCMffUAmUUr1UUmGiC/Kk
         lI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786441682; x=1787046482;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XRRJf27PlMRl2eUNhoseK4/8lRsT3z/R0NPruWur/XQ=;
        b=ei4D9nd0O/eWyC77vxzI7MCjsVw6/7pAubzABXX59SwiQQWBmYgLBme0NzURiSUhvq
         ga2UuCsH4/cT2HgPUlRxXhQfIsqlFWSc5V6OpzdKT1ZS/hpRcoyibtoyb7MV91e6T+pd
         d0eyowwvmWmkdhDA2D2yJL8cFbScL7NxE1QHVu0AmHpnE/Raa58t3ldkTRQU4AMJX4QO
         2JFxmkIzY7gEnLkOMv+LQEBIre3A/Wye4taaChzzcCHmplos9Dq0YzCoBSw7Vih5773q
         eQCNiNQH2mvKPQVS0+DHseqwOfDf0sjiiXn/Kw+39y+CFHjLqJJ4XG6+6JZ62xiMZ/ho
         yn7w==
X-Forwarded-Encrypted: i=1; AHgh+RpsW/FqwhP0alpmcZDfcZWpGTJh92svENlj2otk0A0deugZgbwJRAgLV9RZ5Rlp+8V3VoUvLxoTgA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4M4kAPf5/lRJKwtPXi9a2MhYfUARnacsSNO1JcMLvRSA2Cdgd
	VLZCPb61ti3N55cASmNuYx9LjimONGMq2lp8vVZ8+4qeZzv2kcH5nyTEB8UxdiNsOwCWW8pCnSb
	1Ap0mTx8I3E/5budcYv/N2QGapsa+qH6Cnd7ZXYlKqAorPZv56+K56olWvMXCtw==
X-Gm-Gg: AR+sD11oLb9klLK7H3Qtv33XmzvztxHv5ntBJiBdecXnSwxM28Fj6ZZgWde9czN+UMA
	zNupX7g4s8Bff6aaXVp8g2n/haa+sqiD4FXz2QBeD+9U/BDyo/E5rzs6ch4QeRQ2pJglgPNoLKN
	fX4WEZyJJOvc9VbBZez+cHXpmbfkzxiGz2B/aufZGWBDhn7GoDSzL3iVNeI+WzAoycma9kv1wxf
	KqN3xyM9W1lgAYB8dFNCvSVytTsr0dDHlUikhTH/pItLN0gZuVT13pYui1A8JBlfolru+em1kvd
	6dDYpZ1IjL3tJy2FSeX9A+0RzxxBV06D4JR2/eXtwciBa1gA0+WWlNXsIoCoY0heRSsQRSTYVHS
	u9X3j2myu8mxN0cp7iWcb
X-Received: by 2002:a05:622a:5912:b0:517:7b6c:4465 with SMTP id d75a77b69052e-52d585d9110mr16175931cf.22.1786441682225;
        Tue, 11 Aug 2026 02:48:02 -0700 (PDT)
X-Received: by 2002:a05:622a:5912:b0:517:7b6c:4465 with SMTP id d75a77b69052e-52d585d9110mr16175761cf.22.1786441681821;
        Tue, 11 Aug 2026 02:48:01 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:b467:f322:cd3a:615c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499740a6e84sm61394535e9.1.2026.08.11.02.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 02:48:01 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
X-Google-Original-From: Daniel Lezcano <daniel.lezcano@kernel.org>
To: rafael@kernel.org, daniel.lezcano@kernel.org
Cc: bblima@usp.br, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        kernel test robot <lkp@intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH] thermal/drivers/armada: Fix missing bitfields include
Date: Tue, 11 Aug 2026 11:47:47 +0200
Message-ID: <20260811094747.2940616-1-daniel.lezcano@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Yus/gYYX c=1 sm=1 tr=0 ts=6a7aefd3 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=-xDyalwZenwiwzsvlq8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: nF2PYFHzxW5fXGlJvLKz5UJCW4mLQ7lR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA4MSBTYWx0ZWRfX+AbsCTVIPs0I
 Ukj5ccax7LubFR+CLWbVIz/SsuwVHRfsipleMeNT+cQ3jnzJGMdvtGX/gq6+CbOroOSpw9KbSSW
 gYfJasdVnmm4mWegHqTRcnOj9foddiqx+vhLoetRfigKfM+IR+h5cen981D9nR0YCwreznot6lV
 P+hrhrTRwJaISAYJNz392e+5lG3qVvJxxzXAsVzBrItQgUt9j8xpsL5Ej/A0PFvGXMl+cRt2ihw
 H9rXDM7SnJg8nzoNIZ1rupTwkkUNNsv0/43TR+tJVOaEDSS9L59G3hRtirKhPA/CsVEExF1VjfS
 wG4AfQPGaQAjQ/Ut0OFR7ZvsHPudr1LGSaS1sSmaCs6ueHm+lGQID1drRnKc6t+vtNg6te3c4oF
 wFWtF8BQB8/CCYkde3AAC3sy+sOZH6Kvmw3cH+6bdbYiSePRC8N3O7QnJrzd5EjwZfew0gLImLV
 TQLRrneEqmumruKahSg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA4MSBTYWx0ZWRfXxjeb97xWGC0A
 m6gBuFFMDoAHQZh1B+S5dtYS1UlZxz7Cw6ooZeKj6O/TZmonjUHP2TpSWR8McYQV0voVIzuWjmC
 lOqhr4hfHiiA4JeS+c0qXbfPjb5MeKA=
X-Proofpoint-GUID: nF2PYFHzxW5fXGlJvLKz5UJCW4mLQ7lR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110081

From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>

Add the missing include leading to the error:

error: implicit declaration of function ‘FIELD_GET’ [-Werror=implicit-function-declaration]
  184 |                 if (FIELD_GET(MON_FAULT_STATUS_MASK, val) == MON_FAULT_LVL1_UPR)
      |                     ^~~~~~~~~
cc1: all warnings being treated as errors

Fixes: cbe31d5ce498 ("thermal/drivers/armada: Use bitfield and bitmask macros")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202608082242.drjXuzsN-lkp@intel.com/
Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/thermal/armada_thermal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 912c68a44bdc..ff63b4f2b977 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -4,6 +4,7 @@
  *
  * Copyright (C) 2013 Marvell
  */
+#include <linux/bitfield.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/io.h>
-- 
2.43.0

