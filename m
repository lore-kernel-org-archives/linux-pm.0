Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED513A7F70
	for <linux-pm@vger.kernel.org>; Sun, 30 Aug 2026 10:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788084637; cv=none; b=mqrhr9vDNfiuK5VGBgvcdjRk0ZVYxaqID/yno9a3gHDSOd6jYDf9IOtSsCWx4jlXdVe/PEZZWQ+9fyqkSOvInkwsYWfchpA7epmNYCZuupjB697AdGRK2/y1FJSGLesG7Ll/OtAyjREAZY1c4JXplfeklRiP9HP5RC3RF3l1hIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788084637; c=relaxed/simple;
	bh=j5xquh3YmyWbm6HinwSL5zCuhiJDnGPgbOGMgZZ0rMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rD9iJSEFoQE0tNaHPExvEsIb3bKCyYqsSLauHRK0dUYWIoLL1icXHAIJHuOsU/WC2ZlZhDouNHGWvDaST7YHWq7fVa0bRnPO7voPF6W/+hdbLpwxb3PRSzC7DhkAGQ1OVYN0eP18mYg4WDZ8yQubIXAORYo/VRHSMX9URZi9l+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PgprtML1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DLJxuC6n; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PgprtML1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DLJxuC6n"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67UA7Euv917193
	for <linux-pm@vger.kernel.org>; Sun, 30 Aug 2026 10:10:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=tsnnJ/6NpmZ4Kbv6OZKO9KkoG7EvkwFyG/j
	YSMybLiM=; b=PgprtML1Of3Mrfz+/Vg6qVghym1G7jiEme2994tYitEWpsew6FS
	+40XKqY+85rJclL/shx6d8B7P+VvEd2DPvCJmHtt8BZf6pLkRJoS0mTeV5cH51I5
	i3PJD0MdEzpAqXuqWAl7Xn2ZUdiFglr1I2KowgWOFgIPJgHBd3kz8g6d/fJtFp8e
	jU0QzzKNFS+dTlGsoPLI9WeiML9fPVGcSabpBHRx/eXu41lBPsEzG9my0KJ7In75
	mP9Bigp5Rp0pLtSuZAS2OFATr5VDBcsAUUiDZbcfMuJRWpYw0V+Sw4DmKDp0A5EI
	2LyNz7o+CtxGh2ToSQFHZeiIn5ATXzo9Lww==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbqdfjsrs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 30 Aug 2026 10:10:34 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d001671a54so45899465ad.2
        for <linux-pm@vger.kernel.org>; Sun, 30 Aug 2026 03:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788084633; x=1788689433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tsnnJ/6NpmZ4Kbv6OZKO9KkoG7EvkwFyG/jYSMybLiM=;
        b=DLJxuC6nTd11mg18vuDKvYjjxN8UGsqOTjqRl7y4Z8WIlgpB/8w7rXt6Wx09jdisyL
         zV36lNAjQmNIDxA6PEgT0LlDl4M+TA2P2718Fx+9Qnw435fDLnVVe6WnpFUUNqCqsVCr
         lnmlqnZG0kMxXNwQpL7V+OsA6mdyVuV/ZvlR9r5ABCPIaQZvDzR2aswtPjdSlfaO4QZp
         wGOh/LcvZ5z6Eq3nS3e57T9gegQdCGcZqukhTX/uy9vnrT7n84YAcn7mQe+DJlEJD3Kv
         JfMl5oWBOq2HrwruV2naa7Hd2eY3vLVL0c4O+1z6g6naSHdHDJqD2VI1COqKNyp8h70q
         YmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788084633; x=1788689433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tsnnJ/6NpmZ4Kbv6OZKO9KkoG7EvkwFyG/jYSMybLiM=;
        b=etiz7sNY4kh/NUjRap3GYnxS1cp0pcZe7d86YxSS7JoQtppSunArvYDbNZ3ilni2lA
         LhRh03rVkqO1jqI+e3tLNdAmPdDSTx1NcFmocMTAOLMlqPTH9s+/w8yTXjR6ppiCgAmQ
         3RVZwnM72uoS4RhxLoH7yK9Xeh37zCjTVYjSVxmNLpyldBfHQWxQCk9ZOAmJh5DIBVUW
         KsKuCIo1v7hmDeW4TC3SQqDR393ZF94Yia5PBy4qvcHhrHfChBHTZtxXyYO4Ni7Kljph
         AlbYC/zJ3bQ0/50fQi0lzDD/NqdNy0swrYbbS9InyUgsIWNcC7z1NWs/g5z/4aiRyUOG
         wx4w==
X-Forwarded-Encrypted: i=1; AKwUvBw+r3ujSHurp4vO9wWNbNV/H9/7d7Q7PKAdPJDm7sgKpIZrExNkP3nRReXHhDhaETIh4QMo2CNH9A==@vger.kernel.org
X-Gm-Message-State: AFuF++ncsIlBLVuM9nHbQbBRbl4oDiDdfKXwSGGe7Nplb9gUB2aNAXYP
	UeEqR/i5uwnLY8g2XqOv/dCiK05kKFe+H7RcZIXQ0JCqeNsiyoCpr/i0RDsFGpge3j+RDn4gNLW
	vLfBaiaMOSf9geZYo5gc9OfYaRolA/kKmqQCWgVVyRWhsoqXFmyNSm5Yw8Xp55Q==
X-Gm-Gg: AYBFou0NtalZ+7baZLPIRzDbeTb8e7RO6j82YgxQI1I3XJ9sErVmBbiCOrRkDum7aiY
	1xkusnNgJ/fqCd17Z4KURdG3R63BI6TS27qr3HKqBBjyaVmoBuPVdkqkpItCeWEty3g/4b+/ONs
	cUOLVXRQdkPdQLXzhAiXZpaGT0wNMR2d5mmPH0HP+QVB3ik02dZQoDDQxWw/0+fR7bXZs+naj6U
	pvHNxqzMszQPZ3GR+zw2vVY8HtOnI88EoDGxXrv4chROp4vqi7TrLl6sEwQ2TA09jKWkY847zgA
	DXoq9zgeXErZjuCDRMxECQ5LRMJRiqQLtmCrbUKP2/Du3Wrs8G08QlVDKR6Xdmo/3g/7jp4L1DL
	GzlgGS7TRRZlwRYfzcX7vmPIEPkgl+Jx8A6qcEONELFaja79eF7VTx6zww29n
X-Received: by 2002:a17:902:f78b:b0:2c9:df1b:e948 with SMTP id d9443c01a7336-2d74dc78debmr313679715ad.4.1788084633423;
        Sun, 30 Aug 2026 03:10:33 -0700 (PDT)
X-Received: by 2002:a17:902:f78b:b0:2c9:df1b:e948 with SMTP id d9443c01a7336-2d74dc78debmr313679155ad.4.1788084633005;
        Sun, 30 Aug 2026 03:10:33 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f7be440sm25312274eec.7.2026.08.30.03.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 03:10:32 -0700 (PDT)
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dhruvin Rajpura <drajpura@qti.qualcomm.com>,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>
Subject: [PATCH] dt-bindings: thermal: qcom,pm8775-mbg-tm: Document PMAU0102
Date: Sun, 30 Aug 2026 18:10:25 +0800
Message-ID: <20260830101025.191697-1-shengchao.guo@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMwMDA4NSBTYWx0ZWRfX2vadVtuQwAs3
 FS24nO1AQvgKWjyssrIOeonYgcYG8h8LV9lNG/jEE6jBGtZgAIK7YYynce0o8asfFiou0+rTYI6
 3lJDeBJtMOdcbLaDzsguOrFDERmj2NyYBieaD3ldZYoxW3xKCdvuXoK627SocyN0p3uklWzpkIW
 b3AwYjhBXuYZzrMM/K2M8zSdfb4zbzea53mYk11DYRNevKoJJGwxeXFfbR/8b6HgxEx/yq8Vnhm
 jJy8YnDEbmnSIlR9uqghnr1PrnEESlcd6EleBYojOofXjJk/4jyYxnEouc2XKNo5XqRjU54sRJM
 68VBbjzoXKrptvRHYYTKGc8+asAxNNcblvp4j68KRppbZJE6vcnQ5wbjspkbPVC2s7qWoYSbFWj
 1YV1O5Xm3pATcFfdynokGOa7NCr3yX19UTercfW2Nq3AnagnX1rRVJdovdZJEEvzqYVRFz3W/wV
 5SVTiuTJSgw3eJUxL5g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMwMDA4NSBTYWx0ZWRfXxr8ORR9tAJC+
 PI75WaSg8WAPS3f5CONj0vIcTIW+1Ft9/nN250Z/ON4/MHPXMy5SzC9OD+ohlKFThCCVfKKs9CN
 MwKUppJIQxsBgoMEt7/jElat6clPFgE=
X-Authority-Analysis: v=2.4 cv=B7eJFutM c=1 sm=1 tr=0 ts=6a94019a cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=DV00hUf6onYBliZHTqcA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: BOL95WPoc5xrJn6Wx-9rRcABh0gWz-Ph
X-Proofpoint-ORIG-GUID: BOL95WPoc5xrJn6Wx-9rRcABh0gWz-Ph
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-30_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608300085

From: Dhruvin Rajpura <drajpura@qti.qualcomm.com>

Document MBG temperature monitor on PMAU0102 which is programming-model
compatible with the one on PM8775.

Signed-off-by: Dhruvin Rajpura <drajpura@qti.qualcomm.com>
Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
---
 .../devicetree/bindings/thermal/qcom,pm8775-mbg-tm.yaml    | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom,pm8775-mbg-tm.yaml b/Documentation/devicetree/bindings/thermal/qcom,pm8775-mbg-tm.yaml
index 2e084d040625..ef8361a55389 100644
--- a/Documentation/devicetree/bindings/thermal/qcom,pm8775-mbg-tm.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom,pm8775-mbg-tm.yaml
@@ -21,7 +21,12 @@ description:
 
 properties:
   compatible:
-    const: qcom,pm8775-mbg-tm
+    oneOf:
+      - const: qcom,pm8775-mbg-tm
+      - items:
+          - enum:
+              - qcom,pmau0102-mbg-tm
+          - const: qcom,pm8775-mbg-tm
 
   reg:
     maxItems: 1
-- 
2.43.0

