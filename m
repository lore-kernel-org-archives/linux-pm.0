Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795471944;
	b=tN3/WlCyq4lvwSdFhBhjworfzFcmD2cKzbIN49j6kxeR1P3REdHHTcy3s0lqor4abiAZ
	 +Y/hM+TAUYjVQUPXt0M1PKN3q9XVosjpcIGXXDGc+ivxJUEcphBGYwqW7bjB517XcZ+L7
	 vEa9C9zEJsfq4JI8Zn5PlL7J7BpcAppOCJheMl6WOfeiJ+FtQZVUnDJ/2seYPu4kg/fpb
	 7XuLtE0DzELHNwaSm61HpyAeki/7+YBTtdbBOkXYpk28XCrmmpUAOPr7XztN7N44SuJzJ
	 e6kP680VYDtzN9HQFQ/9xlIm/8p0HNe12JmFXeOyXAbxFLhCi+Ctsi/VAJPWBTByEBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795471944;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=vAR5+zSsownz5t35od5w2H9aLmJex5vLwmm0AzMVyS0=;
	b=hXT++JQgMQ6hWrsuGBUxVwQ9j15lgPylp4TvoqDWt9OgNEe3wXtWLqTEbP3jyQBKnZdX
	 1iJhTy7AULIddtPnnkJXgHodKL8nNfok+inHpPD9uGChDRh092DsrVAF4ThtiBAJnHMkU
	 igvQvuMVxJQhsTOsImTUAKn9pqTvonxb2MezSjruQV6w9EjrtEcIYmB8KWX/JMXLXA9po
	 PI+GeO7KHBdE+mSSbqjW5BOtTz6t0eBRa5fOyLlP+luz14iiHZwNUOW449wpjBMmOQ3OP
	 cG1vBEJaMOwoWGfKewzcYOoABr4tFW6ZJEDvOffxwRW6AsA3Ixe7+N+RCaaS76Nr0bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UO52xKIt;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YISgUhDu;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD13606A691
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 22:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AD13606A691
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UO52xKIt;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YISgUhDu
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANJuY081579764
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 22:12:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vAR5+zSsownz5t35od5w2H9aLmJex5vLwmm0AzMVyS0=; b=UO52xKItNj5Iayy3
	s4XevmllE0jqlx9CoG+WqvSZuoyU0bGOSxtpY3t15Yj+lIXZrCrqSYkrAW26CEL6
	3OOfdwUZ8X2yMtAxnmuFq+GlbI0xXODD8N1gdqh8qs3jZ4U9XLhciJohvXEm4dKO
	Uy3sDonNjw5uu/gYGIbaB4YWnPe16ktIfiThwW0479EskRAU9uL7MZhf2fq7GPgz
	p8H+HcFik3HEQKYoXgCsPwFuMtUlRiOyGHSGJnpmSu+/mnO9ilXk+M38AEN6bqBQ
	LGcir6VOefD7M97NGNKFtJzBLB+WnclutXPXqPir2dkmCjiRe3NDs08SAmH7nIRM
	uLLb8Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4ma0tkvj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 22:12:22 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f6f4fe531so609494985a.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 14:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795471942; x=1796076742; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vAR5+zSsownz5t35od5w2H9aLmJex5vLwmm0AzMVyS0=;
        b=YISgUhDu2cqcVDBpoKXKWYzbgrxRjfyFZHsamLnMkVrJJVKH/EqFCtSXVaU+Y76Ipp
         zMUVMTv4IZvdhOoU8Of1Jwh+Oy1DTAiuuEPwOagH67CGVsfmi6mPGEmAKsu/qFu2HwrX
         YsDeoxsWUhcypHFM2CGnL/ssumNBWsI1c8LgvzDaWBqQFPA/XrTDJAUanW4i5t0sHhZs
         kyJCH/ZAutkLz1ADQ7/kvv3Nuii+LyvV9hHoiJBTdzLwE9/KLvkbcF9CaK8clLFUb2bx
         ntwoVDPECSDx6CrmHixo7mRcv5upvFc9XAVYqJb7liN7FxAkuYeJ3LIVF2mr7njEv0Sz
         /zlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795471942; x=1796076742;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vAR5+zSsownz5t35od5w2H9aLmJex5vLwmm0AzMVyS0=;
        b=sVylR3gmaMbhHThWQm3saLp9pYWDY4eU/o7G394SJr2lxGYUjt0fbngxMkvmjcCXxI
         m1Vbop1rV5vvV+fXsf6gyyn6paNVEjRLRcL/DwG7i+2FJN8UJFkZMEHRt3d3tsfjK1It
         41FeH52v2sRDB2iyQVCCEAPEytb7DGnijggvlZuG6FO4O+KfZTT4z/DLrGZUaXebNyfn
         L7F/nxMZ2O3JmJdnpFokBvA27HJjPfh3cmjk77bnEOrhyIh3GINNfihY+90YuRGaGOVq
         mzOTxBOyFvEyD51Nr9UtJd5fVQwVHS+GsYJpQ4R3MmCWDbWT+bohLrOFdvU1fDZ1p4+O
         uUNA==
X-Forwarded-Encrypted: i=1; AL+hErEHdShIuAo+VtaZCoEiu1uqQ6RAFoGXeATCx+0ZbSe+xsGo5So/LnRmtFKf4m7nJS2kzA/XKgkJdw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8xgcmIQHm2omMB6V32MXzHGAcWa5FPlC+apt7p5uv6BJm9yH9F
	UAovUzPapkgdWwfTvoimnJ6+9W63YDzZKXrUzhhoOev7db+nWKl6qiAuFQZqPHu0DpT903a582L
	JPxftpFJ2mG7OJLVoDsuGCmqCruegkxmBn8YMvTmdImrgy28KC5gPcF8THIE9ng==
X-Gm-Gg: AZFdTZdaRFrdcjo3TjYCmW6VAM1CNtkaSLCay06PgT0ubpwIhPSozUPiaotNaW7iguN
	wbbJcmJL80KC9w0hKixGzpZDuZQMdn1U60e9nMqdqztaqKqnUbQACd3lGmdG6+ErNcX5BP8p1Y1
	MkmuwGRqBQOopeu8GHtsVwYB2G1LhBQgPbTtVMqHitpT6NBfj2FxvgEn2aqwPbzOP0NTC5vnj0n
	hY4EwvlB1nKhkwNFwqXMDlTfGWHVlaXfUT/UN3zvVb/gf2pLOs9VBiFS9ZWb97Bn4Sbrm/SLCHB
	JlWO6xHE3ZmKOUMXqucsGL9vgW01MI/2O2Qt/PKBE9IbDO6GjyyXjSN77rPRtHaudVZ2/N46/Bf
	ZscPlet75ridJQ+v84sm+lKxJpgPd/yXyvzy25Ic5hx+6l6iYSFk3uByChe1YZF4Yv5U=
X-Received: by 2002:a05:620a:2907:b0:949:6bee:1b4a with SMTP id af79cd13be357-949baa04ac4mr2324965585a.64.1795471941887;
        Mon, 23 Nov 2026 14:12:21 -0800 (PST)
X-Received: by 2002:a05:620a:2907:b0:949:6bee:1b4a with SMTP id af79cd13be357-949baa04ac4mr2324960185a.64.1795471941414;
        Mon, 23 Nov 2026 14:12:21 -0800 (PST)
Received: from localhost ([178.197.218.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8526cbd0sm500012825e9.0.2026.11.23.14.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 14:12:20 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 23:12:11 +0100
Subject: [PATCH v2 2/2] dt-bindings: qcom: qcom,ids: Remove unneeded ID
 constants
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
Message-Id: <20261123-qcom-socinfo-id-dt-bindings-v2-2-4504c1ce869a@oss.qualcomm.com>
References: <20261123-qcom-socinfo-id-dt-bindings-v2-0-4504c1ce869a@oss.qualcomm.com>
In-Reply-To: <20261123-qcom-socinfo-id-dt-bindings-v2-0-4504c1ce869a@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4216;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=K+HF+Osd+hPnuAw+6Z8+zElC+vz4XRee9p0SrByTY4g=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBrBLo9ZiLiSCHGiOxePFC250k+Ad4lftkkiPlfM
 cHgtyGjZVSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCawS6PQAKCRDBN2bmhouD
 10U2D/9zHakAfW0uIhMlZUEe3iYazF4w3BGMgqAwSPuKUPDux1EUPsRET90xW0NzAQtjPcKyeX4
 QP2mdmtsiKnR1Ga6BrF2OWz+bWUVjEC1Gks5k3LRQa9VOcibz/q6z2+ivqEdGAJzJes2nQEgKnh
 HriWmIc/nwoT3G565FeNQvLmDxX/5cGiuYZAkH+4EGnihmsTS6XRnXDwtZYRh/vs+lytfmxCXM+
 EWZPmKu5AiV/Ehmi/yPCzSjrKnqua0kwcQrzhs/R4/iVN8FTxVPdyQSAeHISeH2M8S5s6U+XOO9
 lEQNV1IDfzPaL/WZnusQZLJ+IyJHUnOAiX1oddz1gTygtexssGG+NHFePCY9niWuOed0W/+6HG1
 anMfNFY1BHdmEv1RZEys2vwd9nOMplOOBf/afwhZhOrDDDrfe1oIYtNpSAm28rE84cz3IaLmwg4
 aQGBvOnG0jaBj74Gt8v02gQMvcthXwEvOyUubPChzsBwYcTDHNRCX3LE47lX5epj02oz1G+lpBH
 SW52ZwYY/3r1+MGqGuo4v0549bMb4SFD6zUaVbeiA46/RcAbndRPiRT8oQ75GGYvIPpQboCJsId
 Pcnr8IGJ1j8hziRd2dxpP69Wp04KHhWWifGURSDTBahFy+tic5d1u0O5eUUwzo3A0idY9xKLIPs
 gQh7HPjz/eZolGg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: X_VsDxlMZPDUqu5Xxamp4yFVT7ux2uN9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA4OCBTYWx0ZWRfX+cc59Ikayffg
 wHhTXb26oQw1kbcy88Od6p0bkr71TxfD6DaI4eUhiZk1QIOyn7sCeIuW7CfsTKDo2TlbnbXS2aE
 0Cr49omueN8Hi9PUkRTMM+4wfyZwOiM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA4OCBTYWx0ZWRfX7EMRq8QwVBJb
 Tx/d/Tc1dYCaxSnvAyExeKb67LvU1X0hcxbtBXIajfanSRK97g/IYWKO4Tj0ugf5nQqw7uTBHO6
 UJUUMnAC/9FfEz9lqn1TZkJ0uJeCFznb6FXz+MbrhOeXJV3Jikr4yoXiarA2h/0g1ZebzmDlOSu
 t4CgQw9aoadj4ZU2sma6aeNl1oPzBJdpCTh971NLv8qnSr3/H9/jboJZr1GXcZaYGWHxh5SAzfn
 X9xbluLox4PYR6/UJIR/WyJhG+x4q6ohOzVFWh7qSdStS4ozbXhutfWttzeWqhiI+ymuEldclLe
 bqajBqnzDLpc89LzOtkU9ubgEeiy34SB3ZzI32+Eq4gmz1jRIUHsLVJ1euJVNndWRG5JF5klzBb
 Z+zdI25FFMU641YBv4lC8acDdZiAt2AiT0PyKA2LPnVGGEpN9Q29C2B/soDGlPx5dcwOqBgh3EC
 nH6lB7TuJzs4Sp5hPmw==
X-Authority-Analysis: v=2.4 cv=Yr+a1IYX c=1 sm=1 tr=0 ts=6b04ba46 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=9Iw9l5jZwusWHIt2LTYA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: X_VsDxlMZPDUqu5Xxamp4yFVT7ux2uN9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230088

The IDs of newer Qualcomm SoCs, as reported by hardware or firmware, are
currently used only in the socinfo.c driver.  There should not nbe and
there is no in-tree DTS user of these, so none of these constants are
really proper Devicetree ABI.  IDs of older SoCs were being used in DTS,
thus that part matches the concept behind DT bindings.

Drivers have local copies of these defines, thus these can be dropped.
This has no impact on in-tree ABI, but any outside users would be
affected.

Note, that DT bindings do not allow qcom,msm-id ABI for anything newer
than SM8250 or SM7225.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 include/dt-bindings/arm/qcom,ids.h | 91 +-------------------------------------
 1 file changed, 1 insertion(+), 90 deletions(-)

diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
index d89d3b5dd00c..ecf99553ddb0 100644
--- a/include/dt-bindings/arm/qcom,ids.h
+++ b/include/dt-bindings/arm/qcom,ids.h
@@ -230,97 +230,8 @@
 #define QCOM_ID_SC8280XP		449
 #define QCOM_ID_IPQ6005			453
 #define QCOM_ID_QRB5165			455
-#define QCOM_ID_SM8450			457
 #define QCOM_ID_SM7225			459
-#define QCOM_ID_SA8295P			460
-#define QCOM_ID_SA8540P			461
-#define QCOM_ID_QCM4290			469
-#define QCOM_ID_QCS4290			470
-#define QCOM_ID_SM7325			475
-#define QCOM_ID_SM8450_2		480
-#define QCOM_ID_SM8450_3		482
-#define QCOM_ID_SC7280			487
-#define QCOM_ID_SC7180P			495
-#define QCOM_ID_QCM6490			497
-#define QCOM_ID_QCS6490			498
-#define QCOM_ID_SM7325P			499
-#define QCOM_ID_IPQ5000			503
-#define QCOM_ID_IPQ0509			504
-#define QCOM_ID_IPQ0518			505
-#define QCOM_ID_SM7450			506
-#define QCOM_ID_SM6375			507
-#define QCOM_ID_IPQ9514			510
-#define QCOM_ID_IPQ9550			511
-#define QCOM_ID_IPQ9554			512
-#define QCOM_ID_IPQ9570			513
-#define QCOM_ID_IPQ9574			514
-#define QCOM_ID_SM8550			519
-#define QCOM_ID_IPQ5016			520
-#define QCOM_ID_IPQ9510			521
-#define QCOM_ID_QRB4210			523
-#define QCOM_ID_QRB2210			524
-#define QCOM_ID_SAR2130P		525
-#define QCOM_ID_SM8475			530
-#define QCOM_ID_SM8475P			531
-#define QCOM_ID_SA8255P			532
-#define QCOM_ID_SA8650P			533
-#define QCOM_ID_SA8775P			534
-#define QCOM_ID_QRU1000			539
-#define QCOM_ID_SM8475_2		540
-#define QCOM_ID_QDU1000			545
-#define QCOM_ID_SM7450P			547
-#define QCOM_ID_X1E80100		555
-#define QCOM_ID_SM8650			557
-#define QCOM_ID_SM4450			568
-#define QCOM_ID_SAR1130P		579
-#define QCOM_ID_QDU1010			587
-#define QCOM_ID_QRU1032			588
-#define QCOM_ID_QRU1052			589
-#define QCOM_ID_QRU1062			590
-#define QCOM_ID_IPQ5332			592
-#define QCOM_ID_IPQ5322			593
-#define QCOM_ID_IPQ5312			594
-#define QCOM_ID_IPQ5302			595
-#define QCOM_ID_QCS8550			603
-#define QCOM_ID_QCM8550			604
-#define QCOM_ID_SM8750			618
-#define QCOM_ID_IPQ5300			624
-#define QCOM_ID_SM7635			636
-#define QCOM_ID_SM6650			640
-#define QCOM_ID_SM6650P			641
-#define QCOM_ID_IPQ5321			650
-#define QCOM_ID_IPQ5424			651
-#define QCOM_ID_QCM6690			657
-#define QCOM_ID_QCS6690			658
-#define QCOM_ID_SM7750			659
-#define QCOM_ID_SM8850			660
-#define QCOM_ID_IPQ5404			671
-#define QCOM_ID_QCS9100			667
-#define QCOM_ID_QCS8300			674
-#define QCOM_ID_QCS8275			675
-#define QCOM_ID_QCS9075			676
-#define QCOM_ID_QCS615			680
-#define QCOM_ID_SA8797P			690
-#define QCOM_ID_SM8975			707
-#define QCOM_ID_CQ7790M			731
-#define QCOM_ID_CQ7790S			732
-#define QCOM_ID_SM8950			735
-#define QCOM_ID_CQ2390M			756
-#define QCOM_ID_CQ2390S			758
-#define QCOM_ID_IQ2390S			759
-#define QCOM_ID_IPQ5200			765
-#define QCOM_ID_IPQ5210			766
-#define QCOM_ID_QCF2200			767
-#define QCOM_ID_QCF3200			768
-#define QCOM_ID_QCF3210			769
-#define QCOM_ID_IPQ9620			770
-#define QCOM_ID_IPQ9650			771
-#define QCOM_ID_IPQ9610			778
-#define QCOM_ID_IPQ9630			779
-#define QCOM_ID_IPQ9640			780
-#define QCOM_ID_IPQ9670			781
-#define QCOM_ID_QCF3211			801
-#define QCOM_ID_IPQ5211			802
+/* Do not grow the list with entries which are not used as Devicetree ABI */
 
 /*
  * The board type and revision information, used by Qualcomm bootloaders and

-- 
2.53.0

