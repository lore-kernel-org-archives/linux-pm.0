Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A62285066
	for <linux-pm@vger.kernel.org>; Sun,  3 May 2026 16:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777825026; cv=none; b=mxzb7izOAOLQ6F7hmWMumuXs3BfAMys2aJblgcI9IXdb+t6urHgD+GICojS0Ng2z6wFO9HmIyIsbrgjm5PRU1Ho3KUBVyJANjtCewsrRwyEzDREYb0Az6lpXWi32ycrk8qUjuLts5UiKPa5DYoPQQStOHb1JW3XcDc0psryIFr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777825026; c=relaxed/simple;
	bh=/ef+sgoQOWXOXPdyN92wCIRpnQq2A3OBMfT5ya6PtLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JMOxe2StwQKLGPwRDHtF/0Z2YLJBs5hggI1efeTqhrArnxQePw65/OI2mO6BWeRzkEP6bi8lX4o0dagzh+c9XE0jMCpOl5bpXhCFK9p3zi6hFJBHwbLdGrU6QgzZO2FwpO5zu6D9CYzdXsWiGxTmdyiBEbuR9ZDmioCwxkFLA88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CklEnEMY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ahl7QrDz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CklEnEMY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ahl7QrDz"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 643BF6rQ1989551
	for <linux-pm@vger.kernel.org>; Sun, 3 May 2026 16:17:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=0bmyaD3uAgX/uuXOEzZXuj6TTSN7pzuzEPK
	/fky3AfU=; b=CklEnEMY9FCKNyBAKrQkMNBQPdYq/1wb0TcjXgSPvJlA8NzqlmX
	/FUW6OUtz0R7d/7fwlONyza2WSZeMW/0IqBxdS4VHApvCcZQS7Wf5VH6qORmMSgl
	x6SuDIkI6AxK2MQqE0nAhRvLCzGlYa+8nl+jxy6fZKg+vOYoIQbyGy0n+Tf/nZWX
	pLfyS92tZaZRZwby9n9lDyaNRKYbyEKVq7KfiQYYK/k0HDrHc0RTKlmyA0392+TQ
	hultzBocuXHQeAzp5ZqLbhC4QIFvXJTaCmwTeMnGCrlrr1w4vmrKOZnCA9dVTfkl
	l7y7psYTOqpUaO3hP66PlwOypH3ZAXNSkJg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dw8kg38p1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 03 May 2026 16:17:03 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50edf01172bso95120151cf.2
        for <linux-pm@vger.kernel.org>; Sun, 03 May 2026 09:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777825023; x=1778429823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0bmyaD3uAgX/uuXOEzZXuj6TTSN7pzuzEPK/fky3AfU=;
        b=ahl7QrDzBzlpJiOfThObwiX47e4yNjdXlmLJMIQKPKlx27JSxcFVzBkuSH+EEQq0Is
         2nvVHBCwK6bNzxRbESQKcK+kj71mQvMF4Q0srnA3mmtS4pGs1jegFKnCP787Qgf1XNA8
         P9pQEZczqHEHLSq/DtAHeuVx7xoBhDSqVaU3v8t1YuHMPU+G96OEE+ewX/msJ8MVznZN
         fBRtSlViwCcOjUSMqRfCBoylHbPeFMimizDRvzBGnDeMYYpIqJgS4oIdae1x4eW9WWuQ
         1KpEzyIwyNwA/iWJ/rkBY9LC+w/SlEt9g7IqMe2N9pBTPgjzZXYL9xwkUMDeyb0nAW6Y
         LiXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777825023; x=1778429823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bmyaD3uAgX/uuXOEzZXuj6TTSN7pzuzEPK/fky3AfU=;
        b=i0Cu3DsW6w6xz5pWFmXCwSXCSPCy5py5YTxOX5h6/A5EGQzE5R13Isp0F+g45INszZ
         CP4b3HvLvFK0waD/QWBAhyiOtZtFi9jAHZFVNlN+jVdL849C+byHTTAnyVn9+g9DA6Fc
         Has1/KOdmfnMUxRymrUUS1diLoRMcb6X2TWBZ3xinDxWoItiWsIUeJ/RKOodf2nH+KBD
         rXLp/vTUKZ6LByymTOakcFZIX2h363lsCSq2aaquWMQ5b/nJcAWhWQ7UYk5FwYKJN4rZ
         579kf0NkmbB3x7nZpvkO4s4jkM3520QKOUmp+KIUYilTWSGwEY5IwZ/lZcoKgRnB5OrB
         RLeA==
X-Forwarded-Encrypted: i=1; AFNElJ8Xw9O7YH6pfxHVbO7F7op39+2IKK5VrVgzkhfjUU87WA5PKci4syqEsRTGp2nwPhtoAlyRaZ7yTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YytkoN7wztLf/tUkBM66XUjU/8eCk8m7uxpvyNryhrA64nHB/Fh
	Eyuu/TkiIJ6OTvjBGTmonbthOIycNqJXVNgUB+X30x2PXpXRDJ3NRlNEvnIOsaYCPXRrK0RQ6WY
	LBg5m+ktA8/+F2PE2Kl/CB3AZc9w8+gM7JedlzQKPCKgIx5S88uY6umwIWVzXGg==
X-Gm-Gg: AeBDiesyCd4t0TeRP85dhg42IIrL/oWqJpZDu+tNdmg6KsGzbMfkZjVXenaUkzY66g9
	HP+c5OWI/8uGBD7zCj9zNahVb4Leya/Vrhy0ariZi0fDZTWN0pykrJmBEe3P9HS/vijH9aE1/2h
	z6EvBHGS9mLJ8fjwc759JsITSi/8DQkEXdH/GArvcXu3GCCs5MYPbBvGqIFhQ+NxQgASKrCJ4BJ
	YkHR7pmYePYIpBVuJ4XhHd+66Rc1IArcWlGzbhJD6pwZL9L6axD4tlTsldWAaCOOyZo2pBp68L2
	26urNJ+KbPgd1qeE9PcZeYX4h/GO8Ym7fYrax0nZNLmGfR0T5CrpsoupdSakb7FdbrLx9W1APsW
	flbxUwRSpALxAG4iaZyDeK1GAHEp2ZmZck+oTZRBC6BVzJzY=
X-Received: by 2002:ac8:5e0b:0:b0:50f:c65f:a4fb with SMTP id d75a77b69052e-5104bdf14e7mr104171281cf.11.1777825022694;
        Sun, 03 May 2026 09:17:02 -0700 (PDT)
X-Received: by 2002:ac8:5e0b:0:b0:50f:c65f:a4fb with SMTP id d75a77b69052e-5104bdf14e7mr104170811cf.11.1777825022199;
        Sun, 03 May 2026 09:17:02 -0700 (PDT)
Received: from quoll ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb69800sm198912675e9.2.2026.05.03.09.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 09:17:01 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH 1/3] dt-bindings: interconnect: qcom,sdm660: Disallow clocks when appropriate
Date: Sun,  3 May 2026 18:16:54 +0200
Message-ID: <20260503161653.60785-4-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1169; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=/ef+sgoQOWXOXPdyN92wCIRpnQq2A3OBMfT5ya6PtLY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBp93T1/mgkJXIyF8nH7/99Fz0TrMFkYF/MKQIrO
 PlQG9aKiyOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCafd09QAKCRDBN2bmhouD
 1xzKD/0fZtDTbF3NbziunBoudBqh6LR9RT2tf4w+iykeU2jYhIUC1LOdA95VFObAJqJ9gaieMDx
 +0kf9vzWlMgQavROoik+uqrkGMkCNZW0u3gVUTrAMzKpDV5o+t0DTYiZr1Z0RSmLDXcO92ONmtY
 zydDfcLxVX12MP6QKEWNhgfSDktrOVkBT55d4tvmS6uzpDHgX4kWchPJg33jWtoJCVdYlhB+Im/
 +E6zO00qqPV91VvykxlgnK4jUQ/iQv6LeR+pIoMglBneY6qEZqVvo6jJdDrQQOvEnEiFs+X8sHb
 X4GAlC6RXMtBus26iCOsdMyKfTRvVnYTP3Xrk9kSMM7KPUVZJjo8xE6LEOPMn+uebb7b1U7ee4v
 6ORuQ2g+yhPKKy2h+mKLKVe73s5555Cv9dCUgxR3enF/bum581HXtpbslnJOTJyKo6FdhvQvQuT
 zBjrKl7tK9YGX0x5hEexzdqJzk83a455aqsGB8oGmXN5QKjxRPkdAYE3/HzbC8J6uBY14GeKmMk
 4TGqRlVwyzW+XneoLoKI1KNB8bAvTI3pn9ITsbUsMs0Nfp3YcE0kpxY4ANzHRBuQHnNS54MosZ3
 KEDRIete5PkhRW8zzRH3hPVnJJ2ZDCG5umYAfQUduSkyMlvWQdtHtDMmzMg/PJl66YdNbVYiozN mpnxMxEu4Omr3aQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=P8sKQCAu c=1 sm=1 tr=0 ts=69f774ff cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=PRagh5j591ZQoFbOC3AA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: QBx_GAgQJkEzfFb7_yteOHJdDzUU-l2H
X-Proofpoint-ORIG-GUID: QBx_GAgQJkEzfFb7_yteOHJdDzUU-l2H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAzMDE4MyBTYWx0ZWRfXxZSPGjsi1SmL
 /E9aN6PCGvwSkhTNK/FOdyBSA+pliRg+m4Cs85deIXLsygqdGQ4n5yrN1sLZrIfllvtw+kkPHpU
 7/mQ5oBL267Uvr9aFgbZdxiYZnG4WpFUryzuft1jSHNYEwFnmULlFLBzQ8MnNRH/hkKJk+oawPX
 4XKBoyfF4CNpEIBqqq1YKL8CMXjeZTXdHydB8koIfarsmrO60QcGHKyl/e24f2zUELHgEQdUYpv
 SShqpFwp51GWSx0M/47ezdA+0UGiIPNxuF4LY1SA3cbT7WNjRItmJymJX/5n6RUoDscA2KTNMCg
 ApJqFlpSzwmEpdKSLgfRJVZaxS+zyevVu5Yts88JI758Ont6Ybdb6GGYE9fmNRpmhLkR7GWCEwv
 +OpIsSGKhiWvqh2dptB+kn6Do2XmuNNe1KYn76V87IYELc9FpTzXXQjKChI0J7HKl/siHg/5zrV
 zgLpxS/rTJofOUVQ55w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-03_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 phishscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605030183

Only qcom,sdm660-mnoc and qcom,sdm660-a2noc devices from what is covered
by this binding have clocks.  Others do not, so restrict the schema to
be more accurate.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../bindings/interconnect/qcom,sdm660.yaml          | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml
index 8f6bc6399626..51428a2b0ce0 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml
@@ -79,6 +79,19 @@ allOf:
             - const: aggre2_usb3_axi
             - const: cfg_noc_usb2_axi
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sdm660-bimc
+            - qcom,sdm660-cnoc
+            - qcom,sdm660-gnoc
+            - qcom,sdm660-snoc
+    then:
+      properties:
+        clocks: false
+        clock-names: false
+
 examples:
   - |
     #include <dt-bindings/clock/qcom,gcc-sdm660.h>
-- 
2.51.0

