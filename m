Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590182;
	b=jiFti77aTURUjGB5txB8XuaygH70+qCJrv6o45BGIaA1EG8fTud9uUtB1e4cE0bvxFmo
	 PgnE2T5P9Dhx/Q2tcsqO/Koh9eAceJH0hHmvpirobHMp2rfeccxwbg2sq5oWY8PDxd9ki
	 6Iazdqnt2L6/W3oSl3TQGgAF9Drolgm5b3f6Db+WGySo7X3Ot3QhvbSEWI76KNpl9TNQI
	 b77qoFTBCikf84gIxOgjUDsuSgwr7LkZ+Z7sDj1FHG5rlbnvgFw4Id7Z3nsZ3eCLRp9Rr
	 QovXQb9riNrYdkEKZV9a3nMobgqVD0wA95zQi/xlctH5OYTnd8SPxZ0SPJ7jQgH9TnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590182;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=zF9NZ8zldpsm3Sxh+HJmBn1FGdadQNBwM4F0LpqXvtQ=;
	b=vns8Te6kwo3jRUiEQ0LuX3onWgRqZ6YaAEQHVmU16u6Zxhko/ANUlwOnDEtW1rWLRjrc
	 7tF9G3lafQuRVYk+znZHYViKDIvtb/9hFiOKcPRdvdNLb2L2jYvsGR2JAiRa0P9CW737k
	 QF8tensGtYK8FEVWEU32JeFumB2K9VgluCMbJGeVSn9J9U00qTcZd8zLWK6TZmXMk1iZ2
	 c/K1j41h3+DvcFHf36eMRXWmSDnp1A3s4NIIXXeeAYgeOqOBD+s8NHqgEB2+q+auA2brc
	 I8i000czvkNwz6S8st4fLl2l/JL4aDZ5FnQZNoDnRNlnNKeUJZuOkfpnmohNUtD/ymA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pLF4V1yV;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QBdOHoOv;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8845C606A31D
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 13:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8845C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pLF4V1yV;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QBdOHoOv
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LBgM5o4168152
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 13:43:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=zF9NZ8zldpsm3Sxh+HJmBn1FGdadQNBwM4F
	0LpqXvtQ=; b=pLF4V1yV5SxgrLhU4KqgqrqQMMYHGCxNNptCrHC5dd+Xd4YH1zP
	oR+maJjpJ8yn7+UUPCoN36mMMwmUcoDOSDe66fr0EqxqGfNut5KG0CXaaD8ExdI7
	WzbKVxl9FrHLmxvv11Rf/kObj9/7cN1xs6OPdALcPiWQ96ml9/3YrxD7bnYi0jXd
	t++kBG0DS2u1jY8SGS7S9oSTEljcouD7ppF3ob8R/jieXQVjT3SwRHIEJ0wrUX4U
	lSJeO7siafAOCqkE2jRWA0sna0HC0h/zjHmD+wCGZOinlMgiRc0awmyFC00X0vt8
	/MUFJOJ8J9JMMNYXdgZN3B4n5hEIVQGfbFw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heda0m6hp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 13:43:00 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f37c94ceeso329274885a.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 06:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792590179; x=1793194979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zF9NZ8zldpsm3Sxh+HJmBn1FGdadQNBwM4F0LpqXvtQ=;
        b=QBdOHoOv6yLG1bEOrNEqZYxU5EZzTYYwBXPUs+IWZtSyoesj+MRovjtbgjoMVOvUSk
         EPM7cDyY6kJybeYsY73hFG1gy0K/DZ9YyZgQzkpTxYqoycSKWmamL8Qo91HbbpbULvWh
         Mda59Vmi12GWlMxuBra1CWsRG7HUvNFonf+oKSgUFcjK+Nta2dd0O9KWsiNplYVrCEmv
         QoxtN7PpkH0Qt02pKr8ftOi+QTsl6kScHVGZd5NedNdUt3SdZY2bqJnADyf8yD8LtRUT
         OzvITQhuTbxgvBBx2zrOJp8csNqryrbsJ8pfLiZeujA43Ohsi1H0ilhIruWDUjQ0uBa0
         4JOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792590179; x=1793194979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zF9NZ8zldpsm3Sxh+HJmBn1FGdadQNBwM4F0LpqXvtQ=;
        b=dcZqfoDN068JSE2/sP9C1YAaYCyDncCDMHiI0D2fPxdFhQhEkBM5NQvEq00ZkYJxWk
         vCEWfm4wKJNTJF6M/heF68AWq6nQWn+IP+OQQYYEmyT+9dOm2qSgkFwNr0Cfu8C6LIpc
         KWbi9MVVivxz6WqpK/djpbOdnQNE+fcSDxb3sEul1M1UjR9hE5UOa2soJp9QqWydmWAQ
         jkYqTGhkD+dJba2oIje4AbLkM4W//FwWh8jwqUNwE1j6QYgMw9hzCB9T2AZwxfEB3Jyw
         qLe7Dt5cw/VSwuv2K3DKvP+qLZaTjYFW0ArBut/y3ZDP/w6TleSIqb+GlZHgftK3JexY
         XtSg==
X-Forwarded-Encrypted: i=1; AKwUvBxVRUcX+fXjxgjlGUetHMmyY4eaTxvfXdKtw5C2n3+48WI7N6PDz/weuv1FQ2L3ClLVjAm+HFWnqw==@vger.kernel.org
X-Gm-Message-State: AFq9FYKLpSOibVlziWpbazXEAWxkvGEMSIhXO3MtLK2DaULdHojloT2o
	aH+rS4YezFkqP8a2qIH0O72GsFuk0od5OGk2GO1t2eVmjr8USngHh0dkDcKa0s+4IBKPQRIq4T5
	4vgo+bN8lPQIFujI3+Hzz75GxtBMfOTf7dtf6L6LC6vzt0CH3pw5ciyzsbmqnMg==
X-Gm-Gg: AYBFou3utJTo3LFXp0GXQ9If3sLTClErlk+ZfdbYDnK0beukb2fvXNzCv6ykhxdPeNX
	QiHRHhY4vI0iv45ngIbg7WR632C7AXgZ/+fP29PI+7g0b6JRVpInPAbr22mg/+iYRSy0nzs9Duo
	u7ZokdRbM8ltve5sq/Us0wbBZ3rax8budynXCaRyBA732AEWsCuFmefVx/+xc0NYkP0gTaYFtk9
	wmx73cvaUW9fREnUY+BX8OWqdXZUtvGm7C9gC3OyYeNE6myXlX2aJPhlObkpUPJF72HVKA/wVb0
	VlWTtYprdZuVhtH9d9PufKhPH0NMavOXBy0pVUVaxJR9CJuMpwJuJrTbWAyzNu7yWYWmmIixDiv
	R2VQRxXa+N/NG03hVaXnj3VxoL5Fxfq4naw==
X-Received: by 2002:a05:620a:1a19:b0:93f:36d8:5334 with SMTP id af79cd13be357-93f4c66bce2mr859700885a.21.1792590179493;
        Wed, 21 Oct 2026 06:42:59 -0700 (PDT)
X-Received: by 2002:a05:620a:1a19:b0:93f:36d8:5334 with SMTP id af79cd13be357-93f4c66bce2mr859695285a.21.1792590178874;
        Wed, 21 Oct 2026 06:42:58 -0700 (PDT)
Received: from juillet.box.freepro.com ([2a05:6e02:1041:c10:297a:d3e4:3ba8:fbfd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fb845dc2sm73536425e9.8.2026.10.21.06.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:42:56 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org, daniel.lezcano@oss.qualcomm.com, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: Share THERMAL_NO_LIMIT between kernel and DT bindings
Date: Wed, 21 Oct 2026 15:42:43 +0200
Message-ID: <20261021134243.35103-1-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA1NCBTYWx0ZWRfX5DNb5eNLP1Db
 Tu+ogV5HGBG7OqoZU7TFs5XWYuvRf0ZtllNBKuN4lKqpmv8sudE+av/8/JHxQqqlR0CPl6+BDbI
 aJL+F6GJlOLLTzfqkzW8ofB/kA+RnaOgfy8v8zP4ePpzo9Z8twMtLSN9wktes4hxS3Ujn7q9dDk
 AekM/P4QvL1OBtKr8KRgKAdt9ofQdE9HjdI70hgnHMfUutyw8r6X+7Zj+z7d1v5/L3KLRH/IqBB
 E8Ehwt2p96IXs9hTB6BoKa2Uv1oTy7YgrN6arWfbvOklznMV3UFHqsUJEHzD2kjtLOICm+di/3u
 OIK3LtWQwcqWA8ldrwN9Cz3UxV1gpZduc3wU+5F4jpbjksECCZ1RJT65tMHEdQ3v4p8W9guIek6
 VsSbxKPiIeiyb7dnCo1Jgi/1O80o8oH9w2tTJRdBw00d76U8G3ASM++rIwusyXsiNyvPlFfKsab
 06cCQMdmWuSJFw+X79w==
X-Proofpoint-ORIG-GUID: IxdtCIVi5vh28Nrhzhyk9hYogasR-qUf
X-Proofpoint-GUID: IxdtCIVi5vh28Nrhzhyk9hYogasR-qUf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA1NCBTYWx0ZWRfX4/kcCIaCgoMU
 ADVt3JYpvyUMS/+tvZFpFA3AzFGwBFTktjA+fM9p0CDuR6bwT44AVdkzgZfUk9At9vonGXJeLBv
 VHSMVx8Zn+Mj+cLi+54iwI5O6yzGTRM=
X-Authority-Analysis: v=2.4 cv=HL5WhYtv c=1 sm=1 tr=0 ts=6ad8c164 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=DIsPBAb7muRbsDREbf0A:9
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210054

THERMAL_NO_LIMIT is defined separately in the thermal core and the DT
bindings, using different expressions for the same no-limit sentinel.

Define it as 0xffffffff in the DT bindings header and include that
header from linux/thermal.h. Remove the duplicate kernel definition so
both interfaces use the same unsigned 32-bit value while preserving
the existing DT encoding.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 include/dt-bindings/thermal/thermal.h | 2 +-
 include/linux/thermal.h               | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/dt-bindings/thermal/thermal.h b/include/dt-bindings/thermal/thermal.h
index bc7babb1a67c..018f75febb9f 100644
--- a/include/dt-bindings/thermal/thermal.h
+++ b/include/dt-bindings/thermal/thermal.h
@@ -10,7 +10,7 @@
 #define _DT_BINDINGS_THERMAL_THERMAL_H
 
 /* On cooling devices upper and lower limits */
-#define THERMAL_NO_LIMIT		(~0)
+#define THERMAL_NO_LIMIT		0xffffffff /* ~0U */
 
 #endif
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 083b4f533933..a6f635f0e1f8 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -17,12 +17,11 @@
 #include <linux/workqueue.h>
 #include <uapi/linux/thermal.h>
 
+#include <dt-bindings/thermal/thermal.h>
+
 /* invalid cooling state */
 #define THERMAL_CSTATE_INVALID -1UL
 
-/* No upper/lower limit requirement */
-#define THERMAL_NO_LIMIT	((u32)~0)
-
 /* Default weight of a bound cooling device */
 #define THERMAL_WEIGHT_DEFAULT 0
 
-- 
2.53.0

