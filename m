Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591994746A8
	for <linux-pm@vger.kernel.org>; Fri,  7 Aug 2026 11:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786103413; cv=none; b=WwYX0VyLTqIRbr70wrSWY/tn3cwH/BobX9ohmz9Iq0fKOGy8XjLYZHMvlRcxXcTFXZ4SSq4BsTMSgWhAaeAOMdkbFdi4pZrYdvVCdFuW8YgfEU74yxetTmoE8fu+8/61oDURJiLYCEz4Oa6AOYBwotvPuqG+cMtdl6FqZIBve9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786103413; c=relaxed/simple;
	bh=mPDF1SlEMQdjw+ueJ/HclnaM4zDdbSA8xnmKyLwl+PQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o6cTWypBVDxx8nsu5eazUInXeuSxpcx9ggBJ7331oILm8QxFTBP9xR/rcrJNBelhraSf2EJJUEUCpuGNQG6fTHKa5W71PnSEAsSdNS2+URBcVstu9pMwCWQ4c0iRWvGfts1uUmN4+US1ZIBTr0w+i0hGeJYNuKTcwqrwOhVNrKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g5tg3InM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aTDQ/oin; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g5tg3InM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aTDQ/oin"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6777o5OA3822033
	for <linux-pm@vger.kernel.org>; Fri, 7 Aug 2026 11:50:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=KkZyAejonYu
	VZwLADkzVeCeYi2RQWrl55Puf6gMelew=; b=g5tg3InMob75DjO38W4J0skvdbU
	PM+DjCnY92Cc5ixzlE4/aFlRxTWmibfBLtvSO2Z3ZB9QuCezN6pOZ8nUL06TbbAl
	SWxxqpQdsbQtNf1+g+88oTsOWCiQ+XyTKDgsA6EXn/HakXxO622TDQliC8bKJHeq
	5w8lY/13ewmVED7VXt14qRLdXF+j00dwL+0v7VlzlDrssXwi6bzayQ8XfW9xIojZ
	o/tXvBdwAbDyqVKfZV/y4WbcHH/T2FFTNMFwjpiCS4kGj+wCttNTO8ig8ZS6+aqY
	XFc4QW81RV/pZhtU/vxwhrRKGknH+G9is2ugO+1Z7smE9FINsZ3irhWedww==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6gusaj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 11:50:03 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c0e702df8so38441471cf.2
        for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 04:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786103403; x=1786708203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KkZyAejonYuVZwLADkzVeCeYi2RQWrl55Puf6gMelew=;
        b=aTDQ/oinjxxvdwlmMIhW8Hwsf6Em+6HJthcRb4yZhHP/2eO1+BseTbSbMjXYihRVMf
         SdOq2IcQLSNQHbxBWJzi1UQi0C115Kb+GM6z4J1ZeM4tIvHrGw8GuKwl991tbHhiIhKl
         AOGxFbV4Nk06o1cRibWEssrcyHSQNwDk29BgHkdnV1LqGYkfckHo4F6ZM2F+KBOSvnRu
         3outdZUCYJsz1XQmxP4ikHvPyH8MFJsEk3ncDRTAtjy6HBsYme5/c/Za+z5Dd3NO18fr
         mslDKz61vNJ0PG/cqiokuwUIBIidRtokXg2p1gS2aFAdA+yKC89SmyMapgv1ueGQko5q
         f2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786103403; x=1786708203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KkZyAejonYuVZwLADkzVeCeYi2RQWrl55Puf6gMelew=;
        b=jhDfdSfwORYkXDmTwVbHsCHaUKZ2U9LwUQMLBswAMMmWdtvyf2nWUiTvmERcq5vAbJ
         vjthAKQYLku8JyRPE/aidzkY1pdxnYUciH3MjdD6klt+JRgcjL5So1/7kT9h/Su1djyT
         cHBdwVBCgERwam56Dei4vwhr6BbTfJe9vcBL9+QVRVuK/ZxKzGUExX7sJWaWiNymsA/b
         VQ/2aKSXn0uYpGQLTDujBxwd9w2OE05JdoosqSY8iKWWk+RxHhXpwU3LV6sg6F1MyQZW
         B5ZyYWKQaxhQKO1/BTMzWIqeRHcfAChr8Bjtdt5Yi5FH0/Xgsb3Ra+vYRK3yDowWhDPQ
         heQA==
X-Forwarded-Encrypted: i=1; AHgh+Rq5l28WpBqW1bIh1z8njkObeIYcNR0Wr+UxsYWZb2mZRcO12GfNK4QvmRVGgPrCnEN8o4zrON6kRw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzicXQ5eLO60SC24vReBvcyD+DM2yRDuM7s6s+a1XnPNZElVi/m
	oeSoCd4CP2NoGylz+/0eQSr1eiL/Ig1PsRGKBW+ct5jPNVoawCTHqhYpDa3lV0v6icIORwJojKM
	jVhWmfk/H47fa1CqyRi/zH2Y6XEltaUqgHVY+nfEATVfnPYlOX9WQM5a5NqSP3g==
X-Gm-Gg: AR+sD12WTDPDxhY37i+zs4vbWXuk5DEt1auhKbAYpguFNBRglnCUd3zD8CDvKknxs55
	od87HdT3Sutyc4GgHyph89FlayWOa4xu6aPdVj4GDKiQP2MMLXgQ23GCFNyOnA2jUyAELt7dBQ1
	3lSdBjAOvgVMH/cnWNsfRN586UEx2w71GlW7wKtiG7T9TbpBW2hlCOz3STKN/xL+DQG3uiUqUQC
	91IsMngX83LxraHCN4I9xATdqPZHXEAVkBX8RNCmX3b+2+egOpbgWK4txtA8rpOfSTSGcvrl0l+
	KPBBGE5Rr+L+o/gPA55jnwUlqq/UysYMhbBRp/kVmo8YMB941kG/+rRx7CY6Z2uhzh5EeSTUUlE
	srHvj8xOTq0Oo/dhX/c+ampYd
X-Received: by 2002:a05:622a:5918:b0:517:87bc:9b47 with SMTP id d75a77b69052e-52ce61f095cmr244386531cf.39.1786103403172;
        Fri, 07 Aug 2026 04:50:03 -0700 (PDT)
X-Received: by 2002:a05:622a:5918:b0:517:87bc:9b47 with SMTP id d75a77b69052e-52ce61f095cmr244386081cf.39.1786103402790;
        Fri, 07 Aug 2026 04:50:02 -0700 (PDT)
Received: from lin-0772.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080c9047esm43046266b.33.2026.08.07.04.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 04:50:02 -0700 (PDT)
From: Atanas Filipov <atanas.filipov@oss.qualcomm.com>
To: djakov@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: dmitry.baryshkov@oss.qualcomm.com, krzysztof.kozlowski@oss.qualcomm.com,
        odelu.kukatla@oss.qualcomm.com, raviteja.laggyshetty@oss.qualcomm.com,
        vivek.aknurwar@oss.qualcomm.com, quic_afilipov@quicinc.com,
        loic.poulain@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, atanas.filipov@oss.qualcomm.com
Subject: [PATCH v1 3/3] arm64: dts: qcom: sm8250: Add CAMNOC ICC provider node
Date: Fri,  7 Aug 2026 14:49:51 +0300
Message-Id: <20260807114951.4164439-4-atanas.filipov@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807114951.4164439-1-atanas.filipov@oss.qualcomm.com>
References: <20260807114951.4164439-1-atanas.filipov@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EYH4hvmC c=1 sm=1 tr=0 ts=6a75c66b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=Mkk9YIhY_DRy1CQSCJMA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: RFYMdvGcQv2hNcxEXYf4sDlvisll8qEh
X-Proofpoint-GUID: RFYMdvGcQv2hNcxEXYf4sDlvisll8qEh
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA5MSBTYWx0ZWRfX0VJRNowxROD0
 QKIaJ5bncV66kC+XlBc+Iz0R3gjEQ9LKYjfD+RmZGPbxdD4hJCyMpAeu0Co4OIFteFDNN9dDIH4
 ZLb83R2TkCdyhF9EULGIHV1RM7AK7RY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA5MSBTYWx0ZWRfX7APhDwsF1Coc
 avVh+60aoiyheuO44rahltTV2uhaAFKoPoGuGN5yGQTDwGv4+EGtDZxbNdI/S7s2o341+J5S1WX
 bsFKmy2pqvzreYzPyZZeGXRyx5V+Cuh5n1mS9JpteJDd3sQHo5zB2fE04oioY5hwI7uOxdInJuK
 jUNJWn/gdOUeAKJYRosGAtkn64N4YZJhS6xWz+ewgCrgOqzQTepa5VpvXAAmByQ8BnX+i10QAqc
 MkJeUprQeEJD52DMpBmqQ2eCIQBgjPf1qLuQlox6h3XakwXNBC5z5zcgQVuqOIqcBZpRbBQfmaU
 mV4GCF2ae6bq16nnZ7eEJ3ePgHECkdVd68YUWBI1EYT8NW6NO0cZ2tukLaOPHj9uYu8nwHYH94y
 4g0ZPkm/MnPWSAQDlNadZKNL37PVFjBqYd9c3AcNoGKd6HhVBDO+iP35kbOadGiPP1AJKSI8DlX
 64lSW4mtn/IvKFOukpw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070091

Add the cam_virt CAMNOC interconnect provider node to the sm8250 SoC
DTSI. The node uses the CAMNOC AXI clock to aggregate bandwidth votes
from camera sub-devices via the ICC framework.

The node is placed alongside the other virtual interconnect nodes,
after mmss_noc.

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

