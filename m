Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC41448C8D7
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 16:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787848830; cv=none; b=IScQsplIsiDMCpFHbQua0oHoGupNi0RKxG9PADfo6USmnmF7Df2Fa/Z4m64NTQsAk14J4dH7r5rgnQRrxUFMYyLrUESnLOn7VA9kuf/X2cI24ticZwQ2lj6PFCca8a7QM4wYp5G3KP7xe+a5kaZYK2pmw1rf1JkHaYXxYTPwIYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787848830; c=relaxed/simple;
	bh=ItYoLNnh/itsBdfqIb42AjjkJMdlnXNAkIHidF5zyeE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sERAo0I7FG+S6Pk2c5eiGekXyAngte6+hi1mdZJkoP5ZHfaEhWGTadmVHbSd0rgMbkjyKU2fNtMGZmD6xS9cyRFrXezVBaAS01qE+byNbX/K03OPKxPifyJwDUkrIsqPUEDpoPfiKotxa6/SCB0ymarht1hOKT4FWDvzXZdCgsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UqZLxvK2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z/7J3Fqt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UqZLxvK2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z/7J3Fqt"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RFc1F8164324
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 16:40:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C6e0CuKO+gMRclt1VJTiG7s7VdbGf2b3bc5vZVAaf7s=; b=UqZLxvK2vO91YEUi
	pJZnqFrtif/Sbdlr6t6TuICOpwkSgbdXgQ+/OLP7JsZwqsX3aL5SzqHIEeALUdlJ
	AG5hY8cl7fg2lpLy373f2qCApuqXqgTSLOYAnszoNadgMgKliyrvkUaQzKui+NVQ
	iw3cgKnn5is+D70fa1MM5InWm9/Yh8ZmqJMhXRF7dCwNeMrcKS4RpzdxIN5JNoO+
	/iQodhKyFHYTul/D5tehAjUKxrDsHDzuTo4d+YiPVvq/MTvMQJI2flei/dQS0R0B
	xOC3cIuB7K/9wJ79jwwQNPmywFSK33dgwGltmE6WT1a0NNL1RMsPTldsIxoXMBXE
	sIbhbA==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gagjft7ph-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 16:40:27 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-44aeefa1c36so124617fac.3
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 09:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787848827; x=1788453627; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C6e0CuKO+gMRclt1VJTiG7s7VdbGf2b3bc5vZVAaf7s=;
        b=Z/7J3FqtRYJTTJ8G+9/MZykr/qj9H63W0LwXiPKkQz8mzJwnFe+puaVxizT36Lmgyb
         nEy8tYPfJyNvKBWYgQ8HqTGHHwygNJLy1l8cLFINcNHVjwAgYmqjARe4B9jxifYVCfbd
         69naVllSn7bZ6CudzvJACPwpG38D2Y6jGhlH2a8u3s13VqBmggfqpgVFsXpnzQuiFT+B
         SPJrXPwZahWGdEfsSJgD/p11S7IZ5oeCweWaiC9BLfy1ucXrxtrAInWHhcEfkjToJQrn
         t2De9YFFzFb1oBXjhW+NsirFFFpqUbdtBYg/TkqVi88Evhe3MS0ejWFE7h4hCY2JzJ60
         OAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787848827; x=1788453627;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C6e0CuKO+gMRclt1VJTiG7s7VdbGf2b3bc5vZVAaf7s=;
        b=Nklk6oPzye4QMxa0RQN3jGIlw/cr3YkdQ61SV74QXlIfbQnybyVhZF6O4HnP71IMap
         RC57Rvu7B9E2cIPaT4KIfjE24wqEdNz7jq1yPCNwt4B0DT2t7vjKM2qXSqRk2Z8J0jC0
         jvcu990e6g/WFwNJ+LZZAxaHtE3RNFAwLtOdtMiNLneB4C2k6AbLU+b3aKbR0D+BPpXK
         rERAPQ2PcqbSbv0unSTl9azW8BjfZq8cLB/Hxbz0JBq8dWJ5oDCJRTT39BXvugd+EyAT
         UiIWSN+fF58udXHzwoXdovLb3+X49p29wAjntq5M5rW6M9fDsTdewGebMNYQK1u6jsPi
         bfYw==
X-Forwarded-Encrypted: i=1; AHgh+RqNItvpG4k/1nPjj+1c9qHFcnhFaiaQAi57Syfi8mlnRI7Buw46nJfrL8q6pVDEvo7WoTDTUbY3gw==@vger.kernel.org
X-Gm-Message-State: AFuF++l/6kF7l/AFK9Qn7whJO58ix7BbNJFC6Mjq2PWIrW1K5V0tiVZC
	43MC3Ls9HX6ShUdN7i6eOrwSqRmyDX+O0lgWxhkAapgRNfIaHFDYyUEmpE1kUCsId+g7ovgGAJx
	zrv9C2sK9fmC7tYVqQT9Qp+x7c42M6ruvShD89CelBB0XuEweAUvpeqd3+GW7Iw==
X-Gm-Gg: AR+sD11/1ZJJYaVnK6cu7FqPF1ThgUcO/frJ9Ilm6MnhJjuj2nIvJkN+oMnfwCVO4zD
	qIKQ98vMWKJ76aJs5OWqYnrrnUTGyxg2HFE72UfqEJA0TjGo1Q3V74EPrwogO0WTGmAuG1HroAu
	ZzH93NWPAXSfv9n1nZSkU8qIPZFG33FB7sp3Y+JsofMP1Wi5D0EUFExPB5sKJ/8bKq4dQFPCMwD
	S2OocWfHxuNOwP+91tlETdLZNBigxbE7TYtXVNyoqhfjWrCf08bPzTsBRxE1y17jfy9L6llSXep
	y/YR54kKMFB7HI4bhGXU1pVMfBYAGXXsaAZncQ9onHY+MhNi13f4eYHjSYYjTtXDQDEabW4RT78
	NEBLKXlus0ipOT1Yp7l6RRMhhoPaqjOfkbfqGV3iqW+13Q9xYqKq/0AGJBY0OXJ84Wp1Xj74pak
	2i3aderLqQQSrl+BLk3ExFkrc=
X-Received: by 2002:a05:6820:708d:10b0:6b1:56cd:3aba with SMTP id 006d021491bc7-6b1a049949amr12074795eaf.18.1787848826570;
        Thu, 27 Aug 2026 09:40:26 -0700 (PDT)
X-Received: by 2002:a05:6820:708d:10b0:6b1:56cd:3aba with SMTP id 006d021491bc7-6b1a049949amr12074748eaf.18.1787848826104;
        Thu, 27 Aug 2026 09:40:26 -0700 (PDT)
Received: from hu-hardshar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b1a24bce78sm4253171eaf.3.2026.08.27.09.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 09:40:25 -0700 (PDT)
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 22:08:15 +0530
Subject: [PATCH v4 14/15] dt-bindings: arm: qcom: Document Kuno IDP board
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-kuno-soc-support-v4-14-dd34f235fc1a@oss.qualcomm.com>
References: <20260827-kuno-soc-support-v4-0-dd34f235fc1a@oss.qualcomm.com>
In-Reply-To: <20260827-kuno-soc-support-v4-0-dd34f235fc1a@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Taniya Das <taniya.das@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787848688; l=2321;
 i=hardeep.sharma@oss.qualcomm.com; s=20260204; h=from:subject:message-id;
 bh=ItYoLNnh/itsBdfqIb42AjjkJMdlnXNAkIHidF5zyeE=;
 b=87A7RM1KwSY1nYcjjTADj26yrttlOs8VbML+sC4mpHS4sR2pDHR62sHHEgj/sbMN8OGieqOo4
 BGSVUijMSaLD/SZXRClKti/MQbD+R2FJWPXbUf62hOHrYAp4gB3IEMc
X-Developer-Key: i=hardeep.sharma@oss.qualcomm.com; a=ed25519;
 pk=IvwPDKA2xr6jWaCIBBY2ran/H0124QUzVfun+CtEikM=
X-Proofpoint-ORIG-GUID: d2-3cJVtZzlpZ3WcY4mNk7abmU2Glidh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE0MCBTYWx0ZWRfX36h60ttQ6PMc
 kBlgIzeFLKrjO5mAOTj6M6UXS0WN/NfRzxy8FIDkEh/2tLE+fVdkWvYA4yeXE201EI0yc+WNmkh
 f/QEd0q1iBMY/iUodXeQImow8FgqPR9EwlczqEMRI/TWj4DxkubZ4H7zkszg5wO0ujaAi7tSDIw
 vViaGGFXwpuJNPRG2TqqqQS7mRIot82s0wNDJm6kH16QsvowGnYZLhLbsqgHNAqd0g2hB3Ii5AL
 C8B0AekHS6TzA7RQCaXYH03uU+VkgFzZj7pCvjxjkVQyNg/iivGXge7Y74SnK6YrQUZI2bOqnfd
 IpmwwtKBuS5LFux3i7rdnhun4EfMRYscM4FK/DVaSrt3xNv2z9gQH/mN4uD5zShj61rUBeOxTD7
 d5rJgaVXjCbA9qeZgRzMU7kUUoXYsAh/ZrMpD8jyXSxisZrUyrV/cquH3OTbWoPY9wWaZ3L5zpR
 s1rZUzaF61flk/uNNhQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE0MCBTYWx0ZWRfX1Cs1L+Rs33/2
 m23RA1NC59/gyoFYAXR4XIyMhs/rQJIgPqLCazG2nEC+6MS74dHbpEjI0ExSjAFwlgxuAd/XMIk
 LTKQ2iN6b676ll/OsenJgQtqkHLe4Kw=
X-Proofpoint-GUID: d2-3cJVtZzlpZ3WcY4mNk7abmU2Glidh
X-Authority-Analysis: v=2.4 cv=dd+wG3Xe c=1 sm=1 tr=0 ts=6a90687b cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=vXfy1ps2I0IJequeNBIA:9 a=QEXdDO2ut3YA:10
 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270140

Document the Qualcomm Kuno IDP board and register the "kuno"
codename in the SoC naming convention schema.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/qcom-soc.yaml | 4 ++--
 Documentation/devicetree/bindings/arm/qcom.yaml     | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom-soc.yaml b/Documentation/devicetree/bindings/arm/qcom-soc.yaml
index e7160b63d814..179aadc86a9f 100644
--- a/Documentation/devicetree/bindings/arm/qcom-soc.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom-soc.yaml
@@ -30,7 +30,7 @@ select:
       contains:
         oneOf:
           - pattern: "^qcom,.*(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sar|sc|sd[amx]|sm|x1[ep])[0-9]+.*$"
-          - pattern: "^qcom,.*(eliza|kaanapali|glymur|hawi|mahua|maili|milos|nord|shikra).*$"
+          - pattern: "^qcom,.*(eliza|kaanapali|kuno|glymur|hawi|mahua|maili|milos|nord|shikra).*$"
   required:
     - compatible
 
@@ -42,7 +42,7 @@ properties:
         - pattern: "^qcom,(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sc|sd[amx]|sm|x1[ep])[0-9]+(pro)?-.*$"
         - pattern: "^qcom,sar[0-9]+[a-z]?-.*$"
         - pattern: "^qcom,(sa|sc)8[0-9]+[a-z][a-z]?-.*$"
-        - pattern: "^qcom,(eliza|kaanapali|glymur|hawi|mahua|maili|milos|nord|shikra)-.+$"
+        - pattern: "^qcom,(eliza|kaanapali|kuno|glymur|hawi|mahua|maili|milos|nord|shikra)-.+$"
 
         # Legacy namings - variations of existing patterns/compatibles are OK,
         # but do not add completely new entries to these:
diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index ff8a35df7862..ca02a2f0396f 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -175,6 +175,11 @@ properties:
               - qcom,kaanapali-qrd
           - const: qcom,kaanapali
 
+      - items:
+          - enum:
+              - qcom,kuno-idp
+          - const: qcom,kuno
+
       - items:
           - enum:
               - qcom,mahua-crd

-- 
2.43.0

