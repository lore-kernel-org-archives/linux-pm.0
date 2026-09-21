Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9480036B93D
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 06:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789971652; cv=none; b=SRhQ0mF+h6B6zRxeKHxzfon8uqVvEro4jIoPNVRjubazgGRzBdFdrbzZjVNhz86SKkdwnqIWIx6hzttYAh8iBNb136KV8tWTxXfxmrbVR7DlWRIFMTlpgTvbyqaq/+E/huBhi7wbYXiX1bJKHO4nsqJerv15S4FEzocvSRVgaDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789971652; c=relaxed/simple;
	bh=wLv1YZiGVAIfGkU8hNTnZBE7kQceQYpHHT9BZGMZsIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u5WXfYRFySyIbLO2OGcx1wYG5K7ANIOcJoo6/HmC0UJWTxk0POhenru00r7w9d7VcTTpkDoQLGSDPLkACvCmuws2hJNkcXyewH16wHW8nHkF7gj1eB8l+GjSVRuGhvL9cJoK/ZgvM8jYFpWdF46xp8KMazEF4D/U7JrrdUP6EtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a0TsWHir; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OklFSOD4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a0TsWHir";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OklFSOD4"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L3ZlxC2888767
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 06:20:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nDfCMBzk5C/jCeqMsCboIT1j7/GdYpI29hLh3WDtNcE=; b=a0TsWHirCjDXGyef
	V3GM9vQm1eIzE4MGCzz1A9VLNAq7STEJcVHMmJlEs8lqdXwtBZWJtDAgbH+9w+7d
	6RGLFIqGRvtvqBLu4ZQLMT3eI9mtbHZurGW6X2E58y1ryqgqTEdE/TTyxwZrg45K
	rDrBN6NSa7cK0E8MYc4sUX2+QSPDrVphg877wc9sAlyx+PGENncNvvPKZcPvob+o
	fwXMVoZ5iNa9FW3VJvjKmkl2jfubvyNLI6587SpD0pEN7SX6zgz2AEXmL/apwMyB
	ox3ZXQHLirppJqECttDlEg8GYxa0Defhlmk7jp/806cdit29eCK09aZgqcbIB7lU
	Gnfi5g==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtq7996gt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 06:20:50 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c89704da8c7so3559462a12.0
        for <linux-pm@vger.kernel.org>; Sun, 20 Sep 2026 23:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789971650; x=1790576450; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nDfCMBzk5C/jCeqMsCboIT1j7/GdYpI29hLh3WDtNcE=;
        b=OklFSOD4szqiEnUtqy5tww4dgrUUvRy2C5rZ2lNFdYG6WWsEVeOhho4xYE4Owuqjvj
         h1BZ4CvpSTs+S3KC4sj7x2gmlWo0CQzkonRSsRPCg9BmX8vZWMH/qRY3uc2wZCsIfHhl
         qO8v63lvrxBTRxtqrNPFL5LGzBYWNQTNg2W+RB+sV0bUBGpUjexQVlDyH9Ul6zFJS/vl
         uhCGduVXgLfnfnAS6kWI56wMmXNB42S1H3igLFBBZSz9c22CSoEKbkP4PiAWXuCpuJ2s
         Z92GpXpzx11ki9PFNYT/GzZz+3TO+OeoEhRsoDt/Uk2Od+HXdFo12SW3kgoMPqMVvQT6
         qouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789971650; x=1790576450;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nDfCMBzk5C/jCeqMsCboIT1j7/GdYpI29hLh3WDtNcE=;
        b=C61GhWiZDCkpTdeAiWM0e3z89ldXiQL0MmT6jFhNgyFEWdLnRkdEodGVpEIkWaA7QX
         NSRrMkWFIqmzxfTiCHMkwVwsI9B5aQTe03MpI/ZkqvuFCMIrnsRPr9PqzNdSrEsiK9It
         6yzXq1XHSALpZ/eOMuFRd1h+ALUBdxk8OLzVY7MqadMvkEBEXFNa4cf25XGGDbX11aKb
         ghbbgXRpdlYwV8L0v46EibzyvYTFM7ZzonfXoG5EDpZhqORBqHu0j1hGptXr0ty5PEFY
         H4yDdshPQ80j/8WRHltcHIZc8NC6Yh6FVotYIUZMXnWEFJBLoub28Bfqx4XP8uPbDYGD
         zk+w==
X-Forwarded-Encrypted: i=1; AKwUvBye5vIOaKcH3HGjjQqb+zjP33Y92drvps+PKHattDop666kQ5eyjCkZ7guzXpYc9g2UOCC1JxWENw==@vger.kernel.org
X-Gm-Message-State: AFuF++kzEW3h/UZ0vpN7/mlbXIxDBxh7OTPenFbi8nhB28Twu05xuBoT
	hH5qDcvUham6l1y8YDX4FejEc+Q2N+OxrFeOxQqs3INBSJ0KrVvzin2kTLrEPu9eTbW/JRJZeW9
	JXeRDn0mjQb2UeW/o6fOuMoPHWc0lLMmzI725tnsTvOQ4Irfwl8pm70RDOtCsXA==
X-Gm-Gg: AYBFou31s8n7PBcPpY0oOmjL6jCyhPbYllcYT3KskiptGOLvqx18eImsm9j3DJvOu7S
	ZqL6JMwT4ilXJ0NLerkaTzlxiSGZcq03TvaxHsE84jVZqctUR7kzgc0IzRG/nBfce4l1tkjJBxU
	vD18A6ayJuyP5kF2LyQpFzBvntBbaCbsvQ37ROBbjbPhgAe3W7R4QLK0HA7wAuLj62EohAQF5b0
	p+UPtrnI57LgXYWIl9WPnNCc3cEicmqUy48BnPzBfgXrKXXWEc1u9hSUYQHKTkC3a8EJoD5O8dC
	ZLTBA9kKIj4NtUkRSbZSz1oroGdJMw20kZhtqAUycCmbK1Of4I7konTRtDM/Scz557j5ZQPXA3j
	IaoIEihHZCP483wRsTFuxNfZlixMuPP29oqORkm0dmsLDm/2sGc/0lkq7pTsNK6XaWtZkkOTicf
	leWCf/0YuhrzSvFigIVemmf7Ont4IW8Tsjgg==
X-Received: by 2002:a05:6a21:918c:b0:3dd:85a8:cb7e with SMTP id adf61e73a8af0-3dd8c4c8cdemr16602885637.33.1789971650131;
        Sun, 20 Sep 2026 23:20:50 -0700 (PDT)
X-Received: by 2002:a05:6a21:918c:b0:3dd:85a8:cb7e with SMTP id adf61e73a8af0-3dd8c4c8cdemr16602851637.33.1789971649712;
        Sun, 20 Sep 2026 23:20:49 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c331d3f2csm14091444eec.28.2026.09.20.23.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 23:20:49 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 11:49:42 +0530
Subject: [PATCH 09/11] arm64: dts: qcom: ipq5424: Wire up PPE clock to GCC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-ipq_clk_changes-v1-9-d242e3d49648@oss.qualcomm.com>
References: <20260921-ipq_clk_changes-v1-0-d242e3d49648@oss.qualcomm.com>
In-Reply-To: <20260921-ipq_clk_changes-v1-0-d242e3d49648@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Kathiravan T <quic_kathirav@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=aJ9lOr9m c=1 sm=1 tr=0 ts=6ab0ccc2 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=W7I2jtZzSWFJvz47EOMA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDA4OSBTYWx0ZWRfX82rmef8M9bEr
 nZZtaKKkAXT3C2c01Syc3e+3Nsc6nmOvXSOAUcuAk+ZBzwsmTHx3mfPvN6QD+fqMj4gce6VXQWN
 h6LU0DJUwfTRlGksF9uycfxbF/Hz9oI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDA4OSBTYWx0ZWRfX0sHWG1GOJs/x
 1ni2D0rgANTyU+/m/Oy3cfYuBzusY65pZVPtCBGoukaWvHHgDUd+OCFe1VCdKXO9QCGKVkhl6rd
 j27Ny8AlLrsjpdiOEIQ2qmoKhCBq7ustec1LLtu/Q2Ektx/NIk2ZgEtbkYMVFugGBu/5/n/R7sc
 SBBkwo/kdQBPxggKQFAyClaJ/QiKEKOu2BAk/FH1/riib4MWFTNP0ZQzTtmVduSphvamJUsLN2h
 B3dKwpiD1ZRqDprpl2OaV90Ed19XZZQcCo4vVznGKfM0L72d3qyxYeUJmMmh+228xz1Fjhq7q+V
 UnWL9yDhsReEp6rsl2KFznMYFGyFlklpKWOczi5G5zcfxjUEMNqk/bME3abUAELfX2fEEPcs71f
 W9sqsf3ETs5HyPF3yCOzkAb0dEknRbuzBW49ufFxAgfVSDSaRDkinRjej/WcQZlKwRKTpU5mxGe
 woX0pfN62XIAtqrluJA==
X-Proofpoint-ORIG-GUID: n_YWgmGLrxu_DjEFGJZzm4a0R2FEGu2t
X-Proofpoint-GUID: n_YWgmGLrxu_DjEFGJZzm4a0R2FEGu2t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210089

Add the PPE 375 MHz clock generated by the CMN PLL to the GCC clock
controller inputs. GCC uses this clock as the source for the NSS
MEMNOC clocks.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/ipq5424.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq5424.dtsi b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
index 95e2508ac145..64a06d615d61 100644
--- a/arch/arm64/boot/dts/qcom/ipq5424.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
@@ -486,7 +486,8 @@ gcc: clock-controller@1800000 {
 				 <&pcie1_phy>,
 				 <&pcie2_phy>,
 				 <&pcie3_phy>,
-				 <&ssphy_0>;
+				 <&ssphy_0>,
+				 <&cmn_pll IPQ5424_PPE_375MHZ_CLK>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#interconnect-cells = <1>;

-- 
2.34.1

