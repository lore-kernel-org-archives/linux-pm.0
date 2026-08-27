Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC3235C690
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 17:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787853116; cv=none; b=ogtf7r+0jVangKqR+UnT6IoiflMghvWDSMDMU19PpqpFX2dwF2bHMa4vtmcNunW2+ukBUSuszbenUqx+aEF6zGF0wTqBGaO5gkNk2WXTQm163Bg82ARXiG0DTCxQhxqjgq/yZmYAzel60l1r5SBmsLLNXO5n9d4yrxq6PXeBh/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787853116; c=relaxed/simple;
	bh=PwVD29DtUH4dIGkOMbXE9qMjiF+K6OUxLIjMJeof/6o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T4WdgSOfIqplRkvyFMbexyhinLw8sGMWmzQndk+bFZfin7M2kivfOfW7Cl10NNPtNfdgKfl5vERHVRmyFaKeqAy+rsjRdsz1mI+hPmtEmOXS0O0gjj1C90M3y3O6N7jnIYzmGnYgjPbTz3AdPkR3x57aK0KdtqLNc47bcjy4I2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OrkbTqbq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vqxf4+Q9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OrkbTqbq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vqxf4+Q9"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RHY9DU420278
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 17:51:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zPYfTHbFrfi2XEod5q3VXPMVscV9WPdiBhHDyk/uC10=; b=OrkbTqbqWLWzXeag
	Y6XXLkqEaCKKrZXZSJD6fFjtW+arBtUSejC8LlmqYkZGo1Frz97/GS1qSFnEmtLp
	YhrS3g+zXKYkgfs1iz7sBl3HodoWvnfSxpf3d3QydT3ID2gs/poLNXfgasgEgg10
	t+YK2IuDEzUmvUKW9QjXGbXwuvWLH3IeXv99ppVoX0J2C2ppS54vIS3+q3ZdVudY
	m0SKc4O5tMYH8nOyLYvthdbfXn9AbPA1yXp2B+SjKwFpFdAi0xOGqA3yl5XOTNYx
	Ci3O4TFE+r8M9WC7Ms4Byt5ElEsXMDCIoIeBuEyNX788p2kTP1/3bvUN36Zvjosg
	JgAG6g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gagjftkwh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 17:51:53 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d6f75c1219so1667765ad.3
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 10:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787853112; x=1788457912; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zPYfTHbFrfi2XEod5q3VXPMVscV9WPdiBhHDyk/uC10=;
        b=Vqxf4+Q92MctupiPADBLZjeOED9mwvhAgX6482IhIK2+2jpKRSdusIL/uAL65lJWSe
         WC0E+B1MnRztc7g9iVuFg4AbmybXr7aUX5/kdNuoPidNOqM76MU+uq+ZWd8FCRa9Fh5o
         k+ItmAGImDDxTHuuuXVmiv4CzYSdHOHrkWeGCNbH9851+fQoVqWMeCaGry32QRDH940Q
         KzwudAX4Q7b/cSPDsAv1u8jKEd1L+deWyzNtQ9A15Aqlz1E3dGGT/HWdrwAal5tcdQfh
         iFbAI65bCf7Xe5Rrh2nHtjX4drIQWayWeZ11rrQH48Os4NnwlicgpMsMeIGzNpADIvdO
         PSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787853112; x=1788457912;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zPYfTHbFrfi2XEod5q3VXPMVscV9WPdiBhHDyk/uC10=;
        b=cjuAJYejrJU6Y2z5lbtd8KlcClttgMb5eP7uwlPcr/yA/ayWQysEwghco0fkVvDiqm
         A5CN/CrIXsvMKfNwds4vaS/KUg7kiQE5dLBqdOxmGSv6oijBnrh+wZ4NvaVF83sIiz/l
         s3DSR6kn/npKeBgwFBRHkwvrvmU4esK5aDD1wetNDEUi+lcpV6GATwCHCIpZCpJ+vcMM
         oaT1KlBp7/jzOyT4JhH4X1OwhR/ChR0Ql7443LEqRqmfeyQjG7RXpR17bOkp+6xWi2Xj
         /mfphmIaP+M29nlRN+Nwx1mYQ48i3tQWOQnGGzMHy5zPO1AhF65iwMIdu4MaUYTXZZg6
         ohkQ==
X-Forwarded-Encrypted: i=1; AHgh+RrxV8cK8t+yXxQlaXONn0PpSlXi9VpTxCGJBv0IYKwM5kqZ0lqDgZShFGEHQBUsabQGmCGDLa9fcw==@vger.kernel.org
X-Gm-Message-State: AFuF++lqS/2mS4Yr6zLEGTXLnuZquXtu0FFV/FDyTSE+31PIjdEcr8tP
	i8sjJnn0lVLMP/VR3lAzPjFla8Oh5GLe9M+PesWi3K7Ey92S/mBNwo5oxnkS91LG+bKY3vzWIZn
	Zxy2lDDotEERXwqfcwJc4VjOApGNa1H2vl6DeqfEHa+vPfcBVPwWjegyL+w4jaQ==
X-Gm-Gg: AR+sD10/mvimA71QPhcWfWmBLlNJntODzlR4mNXVhJUGRQ6qikwX5r93cs+R2H/WSMR
	E+X5Nc3sNMNqIIuV0aPzyY+kVaVy0kcMu0kVn2XcjtSJYBBwCWoxT6Nn5HkcBqvM9K29+Zcf3Zn
	XMzby9NrPU3LRgym5Ai41rvf33TVJbpjxWx7oTCfYRf1blcJjWyV4jXz0rgiZM3KKyijW3t6f3n
	5OSFKILcuKPF7a5DwKLGVX7aROGB3mgmij14kykNk4h2jcBXLL5TM/RGhMejbUlAa1qFmjDb0Bo
	ZaGp7gIfeSr26MO4nEn0/+aJ9RbMVr74KI8u+mrvnugtqZOLSrPl7hdqFL8JY8LNBBTaHM+359j
	kPax/P0hqceaJ/Z6tMxGjNdE1vkqQMrlGdbxSANFjT5il76BG/vyAwx0SwIoBeVOG6aLQN5uDEX
	yg+hSRN7O7wZybvjbDxTOVs+M=
X-Received: by 2002:a17:902:d588:b0:2d7:1e07:4859 with SMTP id d9443c01a7336-2d74dbe40e6mr13925205ad.2.1787853112435;
        Thu, 27 Aug 2026 10:51:52 -0700 (PDT)
X-Received: by 2002:a17:902:d588:b0:2d7:1e07:4859 with SMTP id d9443c01a7336-2d74dbe40e6mr13924515ad.2.1787853112019;
        Thu, 27 Aug 2026 10:51:52 -0700 (PDT)
Received: from hu-hardshar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d60d25esm23889316eec.4.2026.08.27.10.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 10:51:51 -0700 (PDT)
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 23:21:07 +0530
Subject: [PATCH v5 04/15] dt-bindings: clock: qcom,rpmhcc: Add Kuno RPMh
 clock controller
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-kuno-soc-support-v5-4-6d47636a8f09@oss.qualcomm.com>
References: <20260827-kuno-soc-support-v5-0-6d47636a8f09@oss.qualcomm.com>
In-Reply-To: <20260827-kuno-soc-support-v5-0-6d47636a8f09@oss.qualcomm.com>
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
        Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787853069; l=902;
 i=hardeep.sharma@oss.qualcomm.com; s=20260204; h=from:subject:message-id;
 bh=PwVD29DtUH4dIGkOMbXE9qMjiF+K6OUxLIjMJeof/6o=;
 b=624VoE6RT/CK7yFN44c4vo43lHBpjAc7wHgne3hVVyn8wYeeopVl6LTMwJWZJuoDMQFApxSf7
 MCtWLZ/tVAvDZQGkWqsNg8O2BvuWsSs/K3ckjUs5KoziGaqjuojV5us
X-Developer-Key: i=hardeep.sharma@oss.qualcomm.com; a=ed25519;
 pk=IvwPDKA2xr6jWaCIBBY2ran/H0124QUzVfun+CtEikM=
X-Proofpoint-ORIG-GUID: dOpS0Kwnz6PY8mYdaGN5whzr42I_ns8L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE1MSBTYWx0ZWRfX0cW+jMUFRHMv
 log6mydgnWU99tj1T5i81LVDS+RUFxEmwmo8vnbIdzjK1fYTbktc51muG4bZMsujw7eFt7QS/6u
 UPXHFJJQZRmTbvaLYzqn88BrBXfzDCtpjtDYsG10O0UOG3wKMNrphRM1t8yAHRzjt+40IxePMzh
 S7pbmWL451dn2RXipIpOLdHNZ4FEELgMfWM63Q7iZM6up9lvTHoqp9zSfPpqamu+Fk+t8MlnUj/
 lT1y58MXQPT7ETLBNljTDbFuTpwu3xsvwuI751w5Q/Q60ppgWtUYqGpoJn1Xntt36DjB4D7NZJG
 b7dAIkQfRHVsDeRDrV1JFWzqwf5dmOb7o8Txnn5oKjufQ4cqS1uLV3G4a/gRhGPXnfIGMECFWLV
 V+qUFyzQjghJHr9rFQCzja24mprW8xaq+Fi3rTPLVqiRMKwIxyC39+dYDY+7jqV8binJnHAlgdr
 D9bby5sAcEDiVAmnfMg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE1MSBTYWx0ZWRfX8TwKjHa2WrVv
 ak+JLSMEe4Uzu/1N4S+YPDYbTBaMv/LA/WIsGLsGuXHjervwbw9e27MKWm/umbCAqhtqelQYaLg
 KLYWrx9h/Kq+NTc/nr/4cVMSRU3u8vA=
X-Proofpoint-GUID: dOpS0Kwnz6PY8mYdaGN5whzr42I_ns8L
X-Authority-Analysis: v=2.4 cv=dd+wG3Xe c=1 sm=1 tr=0 ts=6a907939 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=VE4QQHX-7aIn0oL__EwA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270151

Document the RPMh clock controller compatible for the Qualcomm Kuno SoC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
index 2b446aca5207..9d521ac9c33f 100644
--- a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
@@ -22,6 +22,7 @@ properties:
           - qcom,glymur-rpmh-clk
           - qcom,hawi-rpmh-clk
           - qcom,kaanapali-rpmh-clk
+          - qcom,kuno-rpmh-clk
           - qcom,milos-rpmh-clk
           - qcom,nord-rpmh-clk
           - qcom,qcs615-rpmh-clk

-- 
2.43.0

