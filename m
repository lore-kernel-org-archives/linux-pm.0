Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0643C2787
	for <linux-pm@vger.kernel.org>; Sun,  3 May 2026 16:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777825027; cv=none; b=YLg6ZD+c7RLOE1isTm6YOBDhKu4pt5la6TGcIHsymRypRM6T4fAhkEsQzUJlXGSDOnOubXc80JoxvrxQKl+NC7VkLo1rBc4zb3UA/KQRp7MNcynXkdhvlweQ0+lIfQ/3MbTcDGSkeKoa2g4EEhRNSag5mUqu0U1X2llZNLG4buA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777825027; c=relaxed/simple;
	bh=C9Bb/xr9LEyl0DLoUoc6Oee6qrwLzKXIYPnV3SsUoXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LezkjR0TxAHyZtoUmy3uqH5ZkKrothQrSX7AeebgFpuG29q0x3WTNLmjoayB67QIdQrywam4+hE0Amc9OB5V4161qBIDlJ/ukNAWcCb98iyFZMnlmUTfMlI6UzEtwSnMzgnQSRgAZ5DkEXllHAkCMRjnZISOYbdk6Mu+e+N0/CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Swg7jVk7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SmRwTVGL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Swg7jVk7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SmRwTVGL"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 643AwTNi1842319
	for <linux-pm@vger.kernel.org>; Sun, 3 May 2026 16:17:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=R2p9Q2Dqngt
	iV//zzqrVL9uTJq7yFojPLMMFu5Kk8Wk=; b=Swg7jVk7I0E+JhAN7sVSoY9LvUi
	6Fy2ffAC0ZtI5lJLugzJXsDSew2POCX4Rx/z9iTdtwrNYOfOSdDlRndJHL7q3FjW
	Od2hqL0FkYhP5P230k8Jf9i9SsDYp9XVE4FWkl/tP5aBWh/OUUQc8rckOeAGGlsk
	/POOCobmEBR8Oh3nqmtB6GU/BMIMFbBWHv8IboPE7IJqx83PQgeQHhFS0uIU+X6f
	7JSGfvWstjMdF748b6O7mUfTSzXV2bWgtyzoUkyDd0sBds4c8dKkwtLlBkP9+GCZ
	ZXb+IxlfPfMb8+6AKcRzfAOsJQr+MswXDgk4Qh/LbFr1q6V2wdlGdOrC6Xg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dw9n8b49k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 03 May 2026 16:17:05 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50edf0245b0so77399151cf.1
        for <linux-pm@vger.kernel.org>; Sun, 03 May 2026 09:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777825025; x=1778429825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2p9Q2DqngtiV//zzqrVL9uTJq7yFojPLMMFu5Kk8Wk=;
        b=SmRwTVGLGwBvzw5tXGlTTWCJoNH6+X1FgNJeZViRg1VCfAz9mOnZa6YOp3lSo3Kej9
         iL6diRsJXmZfZwFCWMuFLmzDFRM8V9EqgkeCF3K9AU/4pjnhzlYaqRWHXAHhOCPZyhWU
         tV5T0KcGV35GWscmmXseWjT4IsJM0whK0M1vMcEPGng/wv1viNePL35nX5TnXABwq6sz
         Wzfv+YIAwbCpa9YLuFVzbN/dn2QxCXK1tBHUeZQQyTT6d3MnA2tQdjpoO2a1Asf+oLor
         +U2732z4vyw8IklDp/7zhkPioI1vq1JvXAt99THMWGC5+hqdY0ni9jgZMiEeG9ZJS+p8
         N2kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777825025; x=1778429825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R2p9Q2DqngtiV//zzqrVL9uTJq7yFojPLMMFu5Kk8Wk=;
        b=n5E6w+DpagYhryDp8Jl/InCMYf+QMgsYgXLGMjaS9+ZLRT0U9sI5blXK1RbldvKVo9
         cDXgy53+MwJ8Q+cP2fRhoLPSFVvGdS5l3F13GZjT8EjQ8T93YbAm4u2iJrO55w83o8nj
         SZWcCGS4AzVd6BG2rIjOsIGHScerELl8YrxzE+3ParHw2xPEaEsXaP/p0KOhXs4NRb4A
         RXtDSvFkAo8KGcu9SIoUQtx5SZAvRsIRY6nYx5R/WwDdyKsKhnDEOBMiVDFkMa1JfR4S
         VySin+ERcGAqIVwzP5fvrJ+VT45BLqrNDpTRfF/nW6l0XTqkOPwCpeazSWeMKKSUWgL0
         VrTQ==
X-Forwarded-Encrypted: i=1; AFNElJ9UXISErIZamErJN9Cdqe2jidNz8WkIiJEsL2/tkhC+nQ6VHZxluAfQzCKoYiaq9W+NfQ7tGSXigw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4hg/p79ZwQBSOIc/8fXQ20CQM8CRYkPuWRJk6S9O7y5oxbYsg
	yvvqjypmrvPuuMKqC/Iz4nD8piKEbrr5iOq6jAQNZQdbMcaV46/1C/6EOf7yxvQPPOk+/Ga1cJv
	iR2yCEdqvvWi4Zb3D+VT/0eQvmb7JhagNoeRh8ZTQsrXYzg9U2dE7uMZMmW1yDg==
X-Gm-Gg: AeBDiet3XPBPRntCZ/4mIQcjr7a6Xky9fDAG4AuR1TGCrzG6WKQREZrQkdM+r107wcn
	FbzMNWTz0M/teg9pF2/MDUQkD8wAWRcbQNyg8bnFJpP+UBuXWY/gDTgNwtRPsR/FXmAlK9RAa7M
	gETNVMPT2e84n81GWoYbmuLLQzwLEQ7jdY3H5t1Hr7w5LFJfETseeiDWuC4t4vLBcxMUmWWAmfl
	9g77/QereEen5Uf+opfqry3yfKIsQ/NipJAUXOeOw4avuRF6+i97j24OU0QMqriWajvLmyWahi5
	tEkdPFV9OpS2ROfBvHhExiOcIWYWIN8tceP1Z6+P2qfmfm4DqUW9zz1wMHOu3nUYEPnqIvc6HSX
	dA11yqgZo4HiCurFWdUVGuE2lz01O5/j6IC1P6ucegioKepE=
X-Received: by 2002:a05:622a:509:b0:50e:a1ab:67e4 with SMTP id d75a77b69052e-5104bf8056amr97586211cf.40.1777825024774;
        Sun, 03 May 2026 09:17:04 -0700 (PDT)
X-Received: by 2002:a05:622a:509:b0:50e:a1ab:67e4 with SMTP id d75a77b69052e-5104bf8056amr97585791cf.40.1777825024367;
        Sun, 03 May 2026 09:17:04 -0700 (PDT)
Received: from quoll ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb69800sm198912675e9.2.2026.05.03.09.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 09:17:03 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH 2/3] dt-bindings: interconnect: qcom,sm6115: Drop incorrect children if:then: block
Date: Sun,  3 May 2026 18:16:55 +0200
Message-ID: <20260503161653.60785-5-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260503161653.60785-4-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260503161653.60785-4-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1421; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=C9Bb/xr9LEyl0DLoUoc6Oee6qrwLzKXIYPnV3SsUoXo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBp93T41UUDcl4BWhPrmCowzEEwn07/4gg6yMBKI
 4TF6tWtNX6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCafd0+AAKCRDBN2bmhouD
 13sDD/9uAX61r2PXqZRA/fZnGVxg1jOvisImmjP/rFVo4emHMHlggk5T4WPuQ1xPmu4HdulLbjI
 f1W1PugITqNT/TC/47f9HzMcAIU7JoFsga3tJhW7+Q7sT2xcMmGaCmz7x2F4YFGdYhWSOhxSM+I
 Ao4WCN13p+8VVS83mrlHEXMvn6Aw5WY+ckIXIhwBLBFRimL/P8h4+khnFN9aASFXSdR1f5mQ+F0
 Ul4odPQsLt4UPwk0Ae2ItnrUdySFoSJYPe4zIE1ai7TBuXmCSQ2IDe5MvNJzkAkQrW1HszPn2Sa
 Nqc6Rrf0Nty4SCt5zflhKD7IHMbS9o4weWKIo1yOUZV6HfHb5zpFVHkxd83aEm+/YdJs7RhI+TR
 QbaMc7oujajx2HQRR/dY0N+VRpCbwst75TQVwI8V7hd+vLTiMHZ1mYubEVtYgjNKyfnrjQLp/H/
 6kReNzX5bgzogGPkveXAhM00lxc7meMKrSkkWbKbxEmmyczhGPgUm/h+Kr77qZ2ObDR0W5nHxme
 oqGzqlZwM1sURTEX0xYGdpVG5N7/uE+JW1Sar6fGi94jLIrt1eOr/5CjGtj0S5QZ5M+PuV57rxa
 HyeEETnYh48sOX4eoCy9xeoQeN3jWXHa1mAP//voZP8D1L9BgrcqM5gQF/iMC+TxpT0y3Q/Rabf bcfeG53SxbFc/MQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: BNhqjZq21moFAQoWBmExoQQbDJkqYXw0
X-Proofpoint-ORIG-GUID: BNhqjZq21moFAQoWBmExoQQbDJkqYXw0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAzMDE4MyBTYWx0ZWRfXynntRjq16BFu
 fTqq1pKrVq08DGAgYu7Aex9L63MflgawZq91aHNTjkoJp0U4Px2UrS3r75fs4ftGekriquXX6dH
 Ch9Z128zXQwZf9XZEj13c+s27bGwzj6iDzo+XXbAPMybBGEDK03xHXUTCWZapqtQJOtgJpqf3c0
 a6TdMFPRMTidNP4pyqkijjKf5zDET9DdN/Wz857SgT2zm++3vdjXgYGh8QCSPMUiEH4eYjDslDu
 pQL/tGUce5+C2gisIqhnkGnXu1EaIbPEubzNRXNVI/a/7V8iZO6z7Hjoy2uIDQJbLHQ40pAQpSG
 pD3xzgUuUz/F3ePuZ1SC/BpBUFXj+rXWVWEu/Lzp18+Sy7l08E9mVc0g55+vVHHBbNCQZHThTK7
 pR317hHDNIbFaL4RlbzXjIxq+pPfM+NwuKHuodcWJ3X4Q3n4UtDZInIAM/5+qogf+bZ5nts7q3y
 D0b422PFcChKOmaF1Zg==
X-Authority-Analysis: v=2.4 cv=ScjHsPRu c=1 sm=1 tr=0 ts=69f77501 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=OhMZvQ6Gcaex14dD5EMA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-03_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605030183

This binding has children, so any if:then: block restricting them,
cannot be defined in top-level allOf:if:then:properties:, because it
simply does not match these children.  The block, if it was useful,
should be defined within patternProperties for the children, however
since child nodes do not have clocks at all, there is little point in
disallowing them in the first place.

Remove completely redundant and ineffective piece of code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../bindings/interconnect/qcom,sm6115.yaml         | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sm6115.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sm6115.yaml
index 14b1a0b08e73..67c1705af50f 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,sm6115.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sm6115.yaml
@@ -95,20 +95,6 @@ allOf:
             - const: usb_axi
             - const: ipa
 
-  - if:
-      properties:
-        compatible:
-          enum:
-            - qcom,sm6115-bimc
-            - qcom,sm6115-clk-virt
-            - qcom,sm6115-mmrt-virt
-            - qcom,sm6115-mmnrt-virt
-
-    then:
-      properties:
-        clocks: false
-        clock-names: false
-
 unevaluatedProperties: false
 
 examples:
-- 
2.51.0

