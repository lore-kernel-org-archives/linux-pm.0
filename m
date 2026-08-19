Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4A0442FDE
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 09:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787131945; cv=none; b=rSmPKhc0ObMbP6iMRYMkhytE+dV0lp55JT1vhbGrkMmIodwrPAwuBdJm8HlhUUBHWd9csCfCHr4luwjUQNO3VpIZDBdIuFsI7TYHDktWFVHRevcvAAEn4pNKnTh6+pmlpPJoBw3uzJMbo+VIieCDGvznIMsLXV7OvPBLXuS5Jbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787131945; c=relaxed/simple;
	bh=TXkhaj/Jl6oCkpT6g5dVdv+O/7W0Kl0Yxxkn1XRDfDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=omo/NOEfDTHN5e48U0nILUvg1rXyT2gnp7DUevI+Nay//JILLaznPaZiPxrHdDPWzqEA9Tstws8gt/wFG+MfH1Tesf/yd64JkWmMFprP4m2mzIkbrPbmdhPuYlBBlLIQDrNsXCVX8RKkWTSnPliaqqJEaoSFGNK9ft9EevgTYhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eyOk6Iyq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QBi4iJ2M; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eyOk6Iyq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QBi4iJ2M"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67J6ZIGr3240396
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 09:32:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=DLMykc1Q8hx
	xzMIFfjk6jSgbJgX197Qfs4s9ZG7KS58=; b=eyOk6IyqQG7MTiiki4Y2lHHg5Xk
	l4ggwEvpyyVVGfmSQmMM9CSUIGNYzlJ5mNpR32SD5SD49Fs+GEj1BDEMT7OQACKp
	CCVUqK4Fm0RLUr6wcCwoLrtDb/tLDPzj7KjHVvcs1YK/GLzoScSHZ/ih9byrH7xW
	QxEKiEHCB3PAVMNibLU7X/ZEhZjBYoq7k0g6mR0cxnASMNC1s+RjajqSkdtt4SJE
	JpL84AdNwjCBBIOJDonBL0Zp/oQYjM3AUaVlOZaxFKLEDeMm/82WIy6xwzru8pBY
	OMRuUpD/tRsylr2NxAmK5k8fbeunS36NwgGqj+3qmSGL5HiReAA4zkKHvAQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfmae9r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 09:32:22 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e5e38fbc5so107663285a.2
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 02:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787131941; x=1787736741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DLMykc1Q8hxxzMIFfjk6jSgbJgX197Qfs4s9ZG7KS58=;
        b=QBi4iJ2Mn33hzCfNjRKzzDddIMK2AYyztc4p29j/9t8livM7OY9mFSdn7QyN2EJUo1
         nBs8+ZkHp1a3spBK3d4mVupneuvoex+d91qp4nsP7gnGafj5qV5uyB9SLnnTjiGShufw
         cUGLhZ64d35WkKbIzFT8/1LI1QXQVf58sDTzMMHMQZIa5amzZO+ivpvNWlyAA5H5acNH
         FZTOy/9cO7EU90n0uUBgZBamnLGw1hUuOZ2QNURPfjseHxkQRFDqww93H4U0y+6K1U2w
         IqnJYMDT53KJeErgX+aGz45JMBaaALrmrp3aYSbjgRAZWYVE3xvewP8Nh2k18IPa7OPT
         09AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787131941; x=1787736741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DLMykc1Q8hxxzMIFfjk6jSgbJgX197Qfs4s9ZG7KS58=;
        b=pSiKWv9KN+h2QXOszyXLkJZ91BnZaVl+2XprcVG0LY952ZkVtsnvSqvWA8t3eLv6I2
         y+Y+ZYbJRmJXgoxfX/47nAfe2p2OU+LNXqI8JLIy4qQuVh4lYds/m1YcGT+piDaxb/LP
         9q0rHq6XKyvhsZNRbdgK7fxaxMbhB9EqRYQdk+rU2AyfBD0Nf0Fejk7KpCTfOHfsd+/c
         3IxhF/fL5BtycvNubcjXcWx1DMwXNNqsN7bwzn2EL0PLrDCopOCyROvGI80k4OofOUOI
         CQjHT2CmULlkO65EoGqLfoSAqp2s23bi64Y77YYroMT+G7MXtJ5jc3r0cOmexcFaUGnE
         eamA==
X-Forwarded-Encrypted: i=1; AHgh+Rrp9A7YSfDAQAiNMrcy4kauMLgGI217xcdseLypQq71xYMwzmopjV5j+eqAxKtUkgs5r6QsXbsH3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YygPsB/4to2PT3v7g84zAYzvHjtcmkLO2isn/ETA1fK6FxeEwZR
	YkCvIeOAqqmgoHYHwNQPIrl0rYgcUScKC5J81r4wI4eBPh0llw/fCcexcQJibC8rWR5PVOxRiMq
	giybnTk7m5PydCZx7pau+TeKZJOcckZXGUT/sGfzaORL5F/Uo3UEB4pEbNFDXmw==
X-Gm-Gg: AR+sD12PcbZoBJYCmBykRvpVH+rI51nZg+rLExCCaSFLejyKVMMTEOEWTXOKdBOMBy+
	kggnp5vH+lEXmIKfpE4+gWL+qUEIAw9/1c6Xx6vObS9fo7l6HiFaSRdTNpRGMZaQSHm9uVTOaAg
	65As2WKC2SqElt61HJtZBrsnSvaKV6feu0GZA8nV4Rql44/a0BHfvxTJO8yMb+tm7GcGhbn1JOo
	rnXg4sIswvna0O9a7myxniS/L3h4eBCtRI6gfHd4QZxvcVimY5V0ehszrC6tU3bvnuh8ZOk5L7A
	bj5RMlD1EFUmjInvUSLUx7pxjKniiTHwno52RP3o3fISeL1dbP9sLjD2on+/xwJlNtIkzwGSxBo
	jqfILe5N30D9XOCZ4bnd94ZRH
X-Received: by 2002:a05:620a:6cc2:b0:936:dbf1:f4bd with SMTP id af79cd13be357-9371e6750admr268880485a.47.1787131941086;
        Wed, 19 Aug 2026 02:32:21 -0700 (PDT)
X-Received: by 2002:a05:620a:6cc2:b0:936:dbf1:f4bd with SMTP id af79cd13be357-9371e6750admr268878085a.47.1787131940639;
        Wed, 19 Aug 2026 02:32:20 -0700 (PDT)
Received: from lin-0772.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14b8050sm4402835f8f.19.2026.08.19.02.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 02:32:19 -0700 (PDT)
From: Atanas Filipov <atanas.filipov@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Gjorgji Rosikopulos <gjorgji.rosikopulos@oss.qualcomm.com>
Subject: [PATCH v2 3/3] arm64: dts: qcom: sm8250: Add CAMNOC ICC provider node
Date: Wed, 19 Aug 2026 12:32:11 +0300
Message-Id: <20260819093211.1436275-4-atanas.filipov@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260819093211.1436275-1-atanas.filipov@oss.qualcomm.com>
References: <20260819093211.1436275-1-atanas.filipov@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA3MiBTYWx0ZWRfX5P7rzzOhfxAE
 nYWjOd10v9xA4/JSvEAgl9EqFDnKGFokagoIuw/Um3K2QdNnxQ89xtl6J59dSYdEUs0iiCpI7Kj
 qHr4ox7UeDqnzoOSPMlXpMHMcHLuit/nYA5PqKFWmzokmUkDxVql+VqeSEpbYsHysVdYL8WWI0e
 08EuReC2uZDVHF4ny7bDTTqh5Y+ISW7ZfEJzF4kQGXeCtBUe9zYNs8kRgVynS9jSTX6sdY22Z5+
 8gvHf4SMqOmW1mh/PvgjzCF5rBsZREtN2XAGQHV62iX+6aiK+2bhL3O8a0drhf+AQTHApU+zP1s
 IaOGvmoEX69olezsK5yUwoVYlyq0FqEfLVhsPJ0bYDGQZTRvEYEdYkN2yV/mnBUghb56JbFSf4Y
 hOdn9o47ptkiaLbIaknl5PnZu1uXJWyBTsFtfUZihUZY+d8Tzx5IE5+VupZU3qLeqh4hBzGuImg
 uYAHxsJSGQxuGydD6rw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA3MiBTYWx0ZWRfX/ogBesnP9Eyj
 jzM5RpMbtudtp8H1m/Fj/9nzUXOJN5N3+bqpiIyesuo2CwW4O+0LfF565c15GVmgh6olkISzI3A
 o0YIHE1SBe70/IdmsGzXkCS8FiZSvsg=
X-Proofpoint-GUID: HMXpVfkwTeM0MFts9yBq8VOJ5lB5qI9L
X-Proofpoint-ORIG-GUID: HMXpVfkwTeM0MFts9yBq8VOJ5lB5qI9L
X-Authority-Analysis: v=2.4 cv=J+SaKgnS c=1 sm=1 tr=0 ts=6a857826 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=2QlPqw1KTIhM0t8RAAMA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190072

Add the cam_virt CAMNOC ICC provider node alongside the other virtual
interconnect nodes in the SM8250 DTSI.

Signed-off-by: Atanas Filipov <atanas.filipov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 7076720413ab..33535c83a4d9 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/dma/qcom-gpi.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interconnect/qcom,camnoc.h>
 #include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/interconnect/qcom,sm8250.h>
 #include <dt-bindings/mailbox/qcom-ipcc.h>
@@ -377,6 +378,13 @@ qup_virt: interconnect-qup-virt {
 		qcom,bcm-voters = <&apps_bcm_voter>;
 	};
 
+	cam_virt: interconnect-cam-virt {
+		compatible = "qcom,sm8250-cam-virt";
+		clocks = <&camcc CAM_CC_CAMNOC_AXI_CLK>;
+		clock-names = "camnoc_axi";
+		#interconnect-cells = <1>;
+	};
+
 	cpu0_opp_table: opp-table-cpu0 {
 		compatible = "operating-points-v2";
 		opp-shared;
-- 
2.34.1

