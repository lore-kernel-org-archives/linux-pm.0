Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3422736B92A
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 06:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789971634; cv=none; b=S4IGNguUCQD2Ko9hAPWQx568pzhV99wZ1k/FKn9GbgdFjXGesw+sQW1YFnsJX/bM9SkYadJyaQO9TWP9X0jF1bbdknIIrIJzMaFuzIsEgl1A53IdYFYvbkDU8EMItZJSABdMYQ3VJGi0AzJM7a1h4iJKT2s1//K5M4LOyDFrJdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789971634; c=relaxed/simple;
	bh=xwyDh/gqIKThBIDqDIaDn1f6CWzTkjln6k/sldLENWg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ozd+MzggZj2UdNsBhYYQHmLEinAcpvijNpbke5WmC2FKdMZNq9fGxube5jvM2eMfuUZUP7em96W6YcCvbVaCdaFJKe5Z+ZE9E79hhuHtcOWP3kL5J6HpqT1ei7wmH3OlkzILu+Be/53f59VUPnTJMdyz/jvtGP7SzoWP8OTx2ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kFSdfblI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HpJQd/nr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kFSdfblI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HpJQd/nr"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L3ZS4Q635381
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 06:20:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MM6fxEdC63BYt4I9p9mHc3crUkRM0DfxDxmdNan0WwU=; b=kFSdfblIN84CxHNo
	/E1xDSz9N0L1oPeatOKzBH4/3eF5j6Z6ekWOb++EYnCGGHpX21Jg7N+CC2wsU5KI
	sdhDzIrMPL6eolEw2DUSTzjca3WwplAlDpzMfR4+IcBOLE/ye6ALxZCHrh+VoXe6
	pVNJCCZ8dxnzg4XOQ4OxtEmLIH6cHgPI8R5zF7B3g80yfxxeleZtp/AvEpTcEozO
	WHLGDEs32Cs0o6gE4hiDIlvCRI65VMhFDPB5fGE2Ai/eUBFWA+XbHJpACUMFWZmA
	sknvuZXoe76rPwaiCD3odFh+uUKUh1ADMGZw/hQmguQY7mj6Qlct0K6+raF1ycGy
	++CGeQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gshyxw1hw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 06:20:30 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d02df2bf09so26572925ad.0
        for <linux-pm@vger.kernel.org>; Sun, 20 Sep 2026 23:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789971630; x=1790576430; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MM6fxEdC63BYt4I9p9mHc3crUkRM0DfxDxmdNan0WwU=;
        b=HpJQd/nr2yHmoBjmC3IY0/zdjTQFmhap15sTThwadxtx+ajuGu3P5yRcatsk2Cln2x
         NldGNl8TZTTMSSpna0Ti6sog0K8593sS0O6X+0+fDKBPxFOs3TdTUTun+E5oi7DuD/UB
         UYExv+17v+9qYPRuQ6Lhq7kIhUd1+ocx5UefueCebLfTJiBev4AHDF35kMWQPXhfHdV0
         AagCOx1qeHGjIrgNwk1J3kHYBRGYDfNSe7w9eE6LauT9RRjUJs05+emnb8Q32pIFesik
         eRkJY4bA2wQW8Lq1JEjaxhkqDcC2m7cJ++daVBei6xn3CKTbXQOdW+tLq+nuQ5F56rps
         JRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789971630; x=1790576430;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MM6fxEdC63BYt4I9p9mHc3crUkRM0DfxDxmdNan0WwU=;
        b=ZhYwonrlj/pQlLPCyWCweiQnPi1O/NyJobgfZtcgxlhhkBjCx2O7nLdJTmBYuvlfCE
         iH07ZpYYn+oMvhn/grbtg52FqYthp87DRjbdyksTLqUQXx5OykY2gtPmnIs4zALuGD61
         5A3ulS8r0vdWxlDXuF6ioZeSK9+6qNz27MMmvpzV0LQ6e9yvTDeUi56uoWGGqXdXk+wu
         8LUS/CJpkmSHBrTn719h0DllA2xMcvf7Z21cVLNrlUU7tV9BTCkTuIK4e1A8TRPT1dFl
         m8MzCsaCDzDKl4ufKYMdwLBT+mmivLPnIfXitWa0y9EBZpvF38sg8l41AA0bXZ+VU7Tw
         38qg==
X-Forwarded-Encrypted: i=1; AKwUvBwl10gP6IL/o0jofCun0OwK8dacU/zhp/gUNOgrjGSwlJNvsTNF8lKrH3bdkCtXBGNywjGiMVHlTg==@vger.kernel.org
X-Gm-Message-State: AFuF++lwk+5ljxkY7rd5gxIc9BqqTY1qs3EDENH2aTcD9jZuiDXhh6NZ
	FqsJmV4ofG8Emm68MgHrmxDHwhDRBKah/hGJEN+az+E8ZAF2exXJLR/eTL/8pyqNqbfNjM70EUY
	TEbrpQN3IlOX1NrDrm143Sf+tS5y8RkWz+JklpJoY9rxfGmaeSuDftC+J38ZdIw==
X-Gm-Gg: AYBFou2lTV492xHknkRS6cbLjFLBiv1vgOl/sswHak3YZk0RdNefR58gXoVQ/zEJw3I
	OMvMszTMhtXg26HFo2LK7FBMRyfgNzQ0IuBt7sAKswKFo69Vm/lfkpUn7QiGxbn/wqXsvyBvNg5
	uaMaftMhokWXg1+64ANA/a41r22XwKLlx2lInDPt5n6ADIY5X3/bYZf5QMB6z6q6qq9hrv53sbO
	6YkdnacMwqTniYb7UrhIrhIqQoz23nVJY5Epu9SjgbO3/mAYcZcljlM0Y0LGbjl8SOvCM4Ou706
	sjK6SqD8frher4RUIBaTS7sd5DthXRfa1jaO/y3hq0WoxNStXKRAvFFrvjTw1Th1M3ZE7NjdTpz
	0nidMdIR289pGK7iopqTAWr5g59kc/HEtLnriqiWl9P/iPpZQOeFpxu2N7kM8mFQ5gWEysLNOUR
	JALEjQcALcmEtaa31nVULLl5R2UQXQgKa/QA==
X-Received: by 2002:a17:903:94b:b0:2d5:2f49:b3f4 with SMTP id d9443c01a7336-2ddb1ac1c03mr132240325ad.2.1789971629722;
        Sun, 20 Sep 2026 23:20:29 -0700 (PDT)
X-Received: by 2002:a17:903:94b:b0:2d5:2f49:b3f4 with SMTP id d9443c01a7336-2ddb1ac1c03mr132240005ad.2.1789971629268;
        Sun, 20 Sep 2026 23:20:29 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c331d3f2csm14091444eec.28.2026.09.20.23.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 23:20:28 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 11:49:39 +0530
Subject: [PATCH 06/11] arm64: dts: qcom: ipq5424: Wire up USB3 PHY PIPE
 clock to GCC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-ipq_clk_changes-v1-6-d242e3d49648@oss.qualcomm.com>
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
        stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=PaRqFShd c=1 sm=1 tr=0 ts=6ab0ccae cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=0BHkJw7pG0aoMaekWq8A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDA4OSBTYWx0ZWRfX0hi2dx9XLGNE
 1BabWM2fWMEx8hvX5OCA3APXGCZHGKxtnUBYFrgWgqaPpn1U7/P/sAhcgFm/sPnvKIGJldZEG7S
 iBH5QO9KYu4BP/u+y5CivSl+3ZH1Pck=
X-Proofpoint-GUID: PtA9rio4HyMs7FzoAC1-8gfrtg4t3JpI
X-Proofpoint-ORIG-GUID: PtA9rio4HyMs7FzoAC1-8gfrtg4t3JpI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDA4OSBTYWx0ZWRfX5cC7OOkqgJEE
 1Qc8xpuId/96Ysa/Aby5kVRveJSKv12MsTHoQ69MAwfhfaAxcJMu5D1zPEgmLft/qN9BluV76nX
 QXDXPyw/psLLufuPKCqBbOB8j35twonm3MPWD/T84oIBWZu8U/gsTG6toNru37TxABWX/GMj/8j
 xfU49X9+TZovXx355ZIvTU92HBNouLDhQKwA5V6waIvO2nCdmRXgwBVj40CBi7Xfn5mOH+IGI5w
 yEc4/k/vIHxuylbXePu7vGh4uPsCPiWduiaK7ZuaX5fI2C4BmG/dRERhToRJ/7QOK9zw6+M0sYi
 OAJ5veQflI51ZdXOSSuDjIPS2NdgXrGWRCwa9KxUgunn8hy7loqH5As/K9RP736hD7A3ZgS3sFE
 58sbNdV1aLosZboCGiGEB1m7JYQsHE6g+GF4GI71aNtXt1gj23RVekVZIi5cHsTgCx1X91YoZRM
 hDrdFAgYA8IhTzwCdsg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 clxscore=1015 spamscore=0
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210089

Connect the QMP PHY USB3 output to GCC so the USB3 PHY pipe clock
can propagate to the USB controller.

Cc: stable@vger.kernel.org
Fixes: 113d52bdc820 ("arm64: dts: qcom: ipq5424: Add USB controller and phy nodes")
Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/ipq5424.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq5424.dtsi b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
index 702061e16a58..95e2508ac145 100644
--- a/arch/arm64/boot/dts/qcom/ipq5424.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
@@ -486,7 +486,7 @@ gcc: clock-controller@1800000 {
 				 <&pcie1_phy>,
 				 <&pcie2_phy>,
 				 <&pcie3_phy>,
-				 <0>;
+				 <&ssphy_0>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#interconnect-cells = <1>;

-- 
2.34.1

