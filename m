Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3093AD503
	for <linux-pm@vger.kernel.org>; Sun,  9 Aug 2026 07:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786260546; cv=none; b=rJsxsQncpa6m06Cps3FscFzvkr1j5KW/ljw+6UlksvuzNcwRxkbYyQlKI/3rB9a4cvuOLGVackfWyBPLmpwiMEvezLeQYMUWNXXLFOEj5G133zlEouiwIW0EfkiMNfQtaLSJ8utW0WUxje1Wyj25ibB99EjBy63pvy36m4Jlloc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786260546; c=relaxed/simple;
	bh=cOmOJ5dbV3GIQe056RBD75wdCBDJKgyApOIxb4F6H0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ukv6YcFOjJuIUadtq8z7Kd1p/AusIoAxYiSgVXj0/2SxNraPTY7/Tc87oRXnnIEpXDfsF/arPO8A0lGkpHaQsbLCrttxCgHVSYsIK9XDAU2WB6IIpsZdWxJkI24VVohiqikDjQpnSs3GDgm0FwAzU40//NdhCzQ0xqMYevskUdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GqwJwB+/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OBF8MDD3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GqwJwB+/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OBF8MDD3"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6795er7V3071336
	for <linux-pm@vger.kernel.org>; Sun, 9 Aug 2026 07:29:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VilHWKEJkx3EHlqeaLXr0SbhU/0AlNwgfKBvkLnh058=; b=GqwJwB+/+9nhdaGB
	ZAhT2ftoHgMggjeUqgrE+gwShf03PhpseCsxHpmiwbIgqgxyReeUssghItdM4uEG
	Rl1tQH9uDo4wdeLDuMUDiOUV61OrhVXdXHaawHsZ/eMVi488Qgw0uRrAl/CofYCG
	ghhhrfhvWUfSGbajJJyQ+49mfRWrKUs5awC+7X2JiHUZ5Zz4vhMYJDteMyj5rNs/
	z4yBB7EXaP/0LMgzr00n/mlVdaq3WOvIS3KqvW/9D2kAFTfSq0tCzdttzFwQB2oI
	VIMjGLrkQazqamga42pZdKhSnONe6E+gA4U8CfH9ZdEBBPsnQAWLYY19ieMkRe1y
	FSZ27w==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwt5gjqkh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 09 Aug 2026 07:29:04 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cbe77d6864dso1747643a12.2
        for <linux-pm@vger.kernel.org>; Sun, 09 Aug 2026 00:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786260543; x=1786865343; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VilHWKEJkx3EHlqeaLXr0SbhU/0AlNwgfKBvkLnh058=;
        b=OBF8MDD38zA9TDACSBvzWbhGFsowAFXN8tfp7kHCt/a4scAFOdrorzqavoTx+Zh5/h
         PQGoNF5wM3JcNJ6E1VHfwGY9iLyEZiWZb688ebaCZkJTbpd7tojqLPCDNJ+ifMq463Xv
         NpHMYIha6K6t4Ek3NeJ7q0OpptE0xcJn4j2fKZFkdzw2ROFwHBOA6TYs/XM7+7KfnP2x
         bzpDYoZpoNv+KPe9a60j4IwgWHAkZMTudQXL4NbMNEBh7vqE0cGABwNbQcW2f59I/WS4
         BjAJ995VOZLVCKstA9qm+9ygu+dwWQPV8tSvA5j0o9P7Yh+hmvjK73mRr9MEchuoxFqT
         Lz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786260543; x=1786865343;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VilHWKEJkx3EHlqeaLXr0SbhU/0AlNwgfKBvkLnh058=;
        b=VjWHxceKWyBWcm2BCPbgExnevpvBmwczo0O6Pgw8nnftUHg/N9xFodj/6iFBALPZVW
         CLYYT58Ze7nOm6oPzR+kVnnc0nslM+oYGm81yl3GkGC0BLtrYIIktu3WDc5TmtF3xawa
         9dz63hfUvwegAVR39hovcxFoIiODRTpFbRXxIDpV/08jf+YoWeWcu0MV6uXiIF/Li+sh
         41eI5ht4Af9IXPxKCfYzA1LAd8786iA8B/DZ1Fl0ShWQq7AcJNmleaFpY+YTQuALFw8Z
         rmQ5DHnd6XRwe/587+KlBUr918qyeK2KBxCmwe5Q3cja+LrDCsP7vtpDSfxLmLqMI4US
         Cssw==
X-Forwarded-Encrypted: i=1; AHgh+Ro3HWVBHy9qRYB8d7xGU7A0+HIEGtFqd2IGClAdm0ziD+VI/iTrv3BUUM5leKVKwQYZNX9NG+5b5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgivCyl6ovXqsQsuqHsr4BPaVrCaR+D6UIi2wqDYq/OyU3BZBw
	bCR7lBMr2aAD5P5WBRSihEnvXwXfjOhZGHp0iwVhsAXcIfkdgAZMrHGRM3ksvNpxazHetqR+GHY
	WnymZADSFtinBXS1c1mKQFZ9VOJgkSDkUUbkDp0SX7ZfrjS5gCKezOXBoawZiwQ==
X-Gm-Gg: AR+sD12e9M01eENm1UqzZy7FUSiP2WggrSDbdPX94nfwDlpbbs3iBsiP7bR5AUz8YIw
	vUaqR7L50GAxxUaxNcivNU7OTcZ+Rrw1USi6cDho0+y5fYsmfm0WFGkaMkUGXefnWYweJT/clfV
	NKEzhVTBIhPYi9lVehH/DSPmz1Wd42kX14acU2yDWxDMfC8SHuGnl3fl5DjryO3NJJfKhF6pNgL
	wUWupDvrE1pSlM4QuaT+94s8bKSINsS1v45dbH/tifkRfLESmwKWf+Z359sVpk879dhmY1w9ZBh
	xuv6Q/EJjChLwhs+1RZ3EAWFa76qy7ZIxvk+MgCR06o1h5vsqZTuWEE5JuoTv28Mn1dMPlVLucp
	RXVQXpbpRsM1JF3saL84LmVIRA25hm0CjZmVzc8aUZtA9++8V+fZxEPvLX8JLEatfA8E7EWMWO2
	pDMYXCLTu8sh+eyXo20Fda1aQ=
X-Received: by 2002:a05:6a21:511:b0:3c6:62e4:91eb with SMTP id adf61e73a8af0-3cbc041f1d5mr18614633637.24.1786260543530;
        Sun, 09 Aug 2026 00:29:03 -0700 (PDT)
X-Received: by 2002:a05:6a21:511:b0:3c6:62e4:91eb with SMTP id adf61e73a8af0-3cbc041f1d5mr18614587637.24.1786260543008;
        Sun, 09 Aug 2026 00:29:03 -0700 (PDT)
Received: from hu-hardshar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141019b4eabsm22655630c88.6.2026.08.09.00.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 00:29:02 -0700 (PDT)
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Date: Sun, 09 Aug 2026 12:57:12 +0530
Subject: [PATCH 13/15] dt-bindings: firmware: qcom,scm: Document SCM on
 Kuno SoC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260809-kuno-soc-support-v1-13-5e0ede4a0c72@oss.qualcomm.com>
References: <20260809-kuno-soc-support-v1-0-5e0ede4a0c72@oss.qualcomm.com>
In-Reply-To: <20260809-kuno-soc-support-v1-0-5e0ede4a0c72@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Taniya Das <quic_tdas@quicinc.com>, Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786260433; l=798;
 i=hardeep.sharma@oss.qualcomm.com; s=20260204; h=from:subject:message-id;
 bh=cOmOJ5dbV3GIQe056RBD75wdCBDJKgyApOIxb4F6H0c=;
 b=l9PLOYb4vo1eA2JQoI6YE2Ad8LxymxwZEW6f34g3FTwoT5FQ3BB/16Tuu5NJ8iklopEAY/w0L
 LUVNBTE2SBZAMvWNUOoGpSC7suV44JRDq7COOt5gSNJL+BHPAxztARd
X-Developer-Key: i=hardeep.sharma@oss.qualcomm.com; a=ed25519;
 pk=IvwPDKA2xr6jWaCIBBY2ran/H0124QUzVfun+CtEikM=
X-Authority-Analysis: v=2.4 cv=c6Cbhx9l c=1 sm=1 tr=0 ts=6a782c40 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=01DA1dDmEfGoSNMvxaQA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDA2MyBTYWx0ZWRfXwZ6/u/R9O3at
 YKmI3Gi3oSn/pR7HfEg+Ua7nadqkQCdhr24CH9I3UfaxZWcJznsOzB02dWuqIrtyo8/6g8/spgN
 0n0SBJRxhIGLbgPY/kPLYPUpRnhqkqY=
X-Proofpoint-ORIG-GUID: n-IiHTdznDp8dz-X2o9LWybV-45vmWFk
X-Proofpoint-GUID: n-IiHTdznDp8dz-X2o9LWybV-45vmWFk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDA2MyBTYWx0ZWRfXy3IgRouDTd+Q
 Yx7INXyr0LtdoY6lB/IQY71cv6/lj+agc1csC20OHeUfoZvovKs+K2NTorAwzrVHOCNlpI9QEs5
 ydp/GSNfgmvSf5rjLMBtkpyFXCsk3QlUIyNMHocTV9tBLL+0YIB3hz7cZeduamZ5Wy7yhFWnf1r
 WEkATbSc54QHwxi1GCWHi6mN3lh2SNlU1s4hQPlN+uEAt4vH4ZeyyQAJQhqq5My0Z9IlnS7JN07
 uO/Jfb3W/I5usv4Tj6/r4ZzafDUAGeS0hOwMbhb+MpIRGRBokx4+W7mPCsdpmqGcfAVZ7yH7W56
 Qgypuz4yZacmKdTqpQ10uuvyY2yXJ0L4mTxHkS+UcPdumChHjk9lv6pEabtn2raHtlhVCG2Nx3e
 2um0wjqY6CjW11xhWbk8gNq1ZXEDLZ1IGRFpIrXzYllqen2y9medV91R0XOY98nmLJIfCP9QA4O
 4BMMsjDfKVChLay2heg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 phishscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608090063

Document the SCM firmware interface found on the Qualcomm Kuno SoC.

Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index 037d4ad8f718..ecee5aef65a7 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -37,6 +37,7 @@ properties:
           - qcom,scm-ipq9574
           - qcom,scm-ipq9650
           - qcom,scm-kaanapali
+          - qcom,scm-kuno
           - qcom,scm-maili
           - qcom,scm-mdm9607
           - qcom,scm-milos

-- 
2.43.0

