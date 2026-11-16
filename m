Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794824397;
	b=C98+8vAWVhSyKDrxtBlsS1LxCKRs7z2PjbwUldiFeDZ25+GcyaQJxN8TjdRycEMbrSbn
	 /cy4gEjSGENDoWfxofbomkm0gQf04jLVWcxFga61v2CQksnV8Q8m5v7Ln0bOOY8JBqGbl
	 Jpe7nrM+kXVxslVjzX/B036IDUWtoBtfzpEarKdgtz8BQGBwg3X/PSf/W8HBwdiHknkBj
	 VxluOLwExx97JHPRelzLbvOdjWPED1MXYAq2qYpJTw3ALHZ3Sn27JeSX3W6vmQT5WnOv9
	 GCFWl02uWpC2dSEoHUE346ydVwyPsugFrRN4bV5GtOhrmY7trSoJMNalrkabTnkr6iQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824397;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=/29wzYL5hjbrZK+L5pG+5RIKtZiSHZ80bCt20C+U4BE=;
	b=ONRhkW3t5lTVzVdCI0RfasWFCNJcOf5r2GVBy5FpQtNfxEz8XltFTA55gxqfGPj15n0y
	 Ysac5VhGCqE2ADMvZmNvYRwrpHIxP4JBv2js1pgUZ9j48n7tA6s9VzYiaFcyAFquGwUCQ
	 9f6IOs1Od+WRCauNRL7aBh+wIgexbeeeLkTc8SsVAg0/nQDY1k8Q5idZiryjEojeYV2zf
	 j4EmEnOTzha0oMhESln5JZXpETF5XRu7atDakNrH48XY3Wrct6eA/sk0HUloFoNsyMmTD
	 Z0M4ll/KU3s6+jkmlpeKHCOYF5bG3KWKHj6AMcza+sqCM9KLzhztYXtPb6OzpDw5t8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=InxAuCdu;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WHe2RQLM;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A899606A331
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 10:19:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A899606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=InxAuCdu;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WHe2RQLM
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGA4LMm1228044
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 10:19:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/29wzYL5hjbrZK+L5pG+5RIKtZiSHZ80bCt20C+U4BE=; b=InxAuCduqqhr67kM
	4MJPcxWu4F85hnhTRnvzPEvilUprntVB6Kg5G5C0e2j1MukC1gT8XHshX3ZpcSjx
	yZl3CL1jRAawSvzM1+L5yt2X0FfE9++QzR4daG/WynvLzqEtyTmdsDXLuM8cHtuA
	CfFuYt8HtMvFMLCz841idpNhbM+xsGxgPlizvvQCIry8QRVCXEWJx+lz/43WCS4x
	bOWrfxn+kF0f+eQmRQWNfsqslkeTcBj2grCyZ5HS2YzeLp+4BYGtq5qgt4DfNGc+
	6lwsvK0R4cJytb1FSB+OHyg4/jRSNX13WCY9VSkhQpOqkiDfQ4tJI2Sr2hDhXdT7
	ZrsPFA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyyrqg1uw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 10:19:56 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36f479b9819so1627429eec.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 02:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794824396; x=1795429196; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/29wzYL5hjbrZK+L5pG+5RIKtZiSHZ80bCt20C+U4BE=;
        b=WHe2RQLMJ1UqrhUcVdDirp9poHsvHsIbOr9ZIuYsVnuCHADTBETxx3T4XH4eEjCeyj
         VsHKcBGt3je5IMNYCVCCcq/krX4i8+K0TjgugXwTvB4+3s6uzITzf8Id2JSznvbiF6yu
         aXnxjAbgA6mzoXlGJo8ymKU7heY89CK0nI4CbCUgsQeIgbO7JZpAbzS2DGaiF70w/e95
         oQ2ZP2HYqNfFAaetnPyHBB9dv3WG/OM5hGUox8jxdWgKklHD6x25Pnik4oBpz2SRpTky
         0rCmBH6Bj7ZXVLmo4vgwjRFFVBMmaHCGywnT0abGtQD+fMcKNlPuwbi7LFyFx45mW7jK
         7HZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794824396; x=1795429196;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/29wzYL5hjbrZK+L5pG+5RIKtZiSHZ80bCt20C+U4BE=;
        b=dLSqSK6IzHghuatsV0IeXq42pf3IKbZ/GrUZ/ZlEleqwfQYixhbIbmu/I1/D+c2+tT
         s2O77bDMy0sDBBhzzyZ8KBuk7/ZlAvnwSqUZjpBz0QimYG2pzyFnMzvHnEtlb0KnhE0t
         CjxshS+HBrBQ9xPsisMuxQ0Piqiuzzs8SvbJp9q452yKW3A6xBnyJCw7zSjCqVatRm9K
         3lDQ0l+0x2qSdXrOdIIL2T/e8HnOAj72aBqi+Ze8D4zyJ/y6hZmhSv5nW2BVAHbBF1Pw
         Mykp/6wVW5rFDToN4dbwzmNq3XPsswTyXhuXuWXdb8HHHGsWLwdsNHyFrwpxiiV1egIx
         itRA==
X-Forwarded-Encrypted: i=1; AL+hErHWDiuIjQAgdLOB55N++4mvMhW5V8gUSp6mRnPmzfBAJeRo4X0y1H+tTX/5Pt7xfeZvC6QwX49UYA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+0qU1deXp9R6kZTUknABgNPhUILJKej04Kir0q+k2EvXYG11Dl
	24NMtYDwWj67nEv4RrSDhRnDOqW8DkV4nTW+Ah9kZ5h5iGjSRBdqky9N+LBeOy8gt2SR6x5xVIi
	eCo5kS1/HZa7NIGfyoY9PkqhOyZ/kupajNpmMZXY8aUNg1N6mJjyujNrCFjgd+A==
X-Gm-Gg: AYBFou18nXYl3gik+dA8dDbGFaHvxqdgX1zmB6+ZrDqhqsxeY5UqNWgMRDwRLfCN+Ey
	jPbVvCRmJn5cz6VCOZyZYqPiwAKS+n7cpnzfR7Kz9gFJgFpx9dLE8GmTg54hrHfZ1Q+nU+8pUgH
	mOUtiBbyJi7ljSDIO/hmCbtzB4d/zefVLGdvOoBZujHwdzoMkjk1QF2PlYPGV+wKTPDXULoFCcz
	ZlCANCep4ZVoFDwfskZXgFLHtcMvASYYDTEHN+RmOPmUzdAZ2x4/hX4eRfadDt8ThBlYDUXsnns
	EINgIku4HI4B6Soxc9+nwUGsgzkYYkzRdqUy7fckTHn5E3ROiuoM0POIilI6WxJz40htal8ouaH
	kBoVCvqLBKhiX4Wg2jmXe1LCBvuKV7QA1w58H473TxOLuGkrWsFyvsIIPtmnLDYLoi2VrCvk06B
	MwVlzhI/yUydGvnpXp
X-Received: by 2002:a05:7300:cca2:b0:36e:371:8255 with SMTP id 5a478bee46e88-379603825bemr9380718eec.0.1794824396186;
        Mon, 16 Nov 2026 02:19:56 -0800 (PST)
X-Received: by 2002:a05:7300:cca2:b0:36e:371:8255 with SMTP id 5a478bee46e88-379603825bemr9380690eec.0.1794824395719;
        Mon, 16 Nov 2026 02:19:55 -0800 (PST)
Received: from hu-luoj-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bad6casm32599557eec.26.2026.11.16.02.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 02:19:55 -0800 (PST)
From: Luo Jie <jie.luo@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 02:19:48 -0800
Subject: [PATCH v3 1/4] arm64: dts: qcom: ipq5210: Fix xo_board parent
 clock
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
Message-Id: <20261116-qcom_ipq5210_nsscc-v3-1-1eaf92698379@oss.qualcomm.com>
References: <20261116-qcom_ipq5210_nsscc-v3-0-1eaf92698379@oss.qualcomm.com>
In-Reply-To: <20261116-qcom_ipq5210_nsscc-v3-0-1eaf92698379@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Luo Jie <jie.luo@oss.qualcomm.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, netdev@vger.kernel.org,
        quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com,
        quic_leiwei@quicinc.com
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794824393; l=1065;
 i=jie.luo@oss.qualcomm.com; s=20251128; h=from:subject:message-id;
 bh=Fb14u3Uh0Gv0knlh6Un+7Vkp8cbUQBriP9GOv5lWagI=;
 b=V7YGsYPUpWsnuewY1heonI3tkDNpBSFcmTeztXkuS9EiJLIyVBfXfSuDoPS9v/cGCSKqOYtuH
 0LQ3NeruA1QApWabdBPl+ID0VuXdZVdkjV14rNqW7i9WmV0H9FJlWO3
X-Developer-Key: i=jie.luo@oss.qualcomm.com; a=ed25519;
 pk=gSsYMDakxtd6UDFYDdA9y9yjIs5Etp5GK/3DoXWPyS0=
X-Authority-Analysis: v=2.4 cv=VcJir1p9 c=1 sm=1 tr=0 ts=6afad8cc cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=VEHikqRv1_aYAJNswC8A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: Kms1MKGbsIq_FbodGpu94-7oFAaORBx_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzOSBTYWx0ZWRfX3NYBtVLu/OH1
 e6QcbfAwg0QbGU6AV3TVLqDI1QTQseQdMbCL1Eg1qlnirCVeISFKRux/kMydKDW+itjFbtTuEoo
 kXeVZEMBB0iPE0wyxQ628KVjGA0mRPxBptD0TEiJ/pXD/bv9ZIL0JxJCCs7+4iJWgob/15ex1Zn
 ojIImMOTL7m4g0uKNPy0w+0H/7Blj7dHhgFAM1r2U1P05Rb/9+1/yJvLKGxPAi1/1zO+QZBPALX
 p+wdzv+pAhn2rN/MaITSaa2H3Iewn8f4nd+gQQq4mTLjG53lPRCKJWoG4DcWxBfeW7sUkanR+yw
 r0JGc3cQqjJ/wFpKjwc7fz+0nXD+5G0LtZbCT6kUeqiZkeaoMFCfRvjYJJLboGvusvp8cFAOCzo
 bh/aevtSuvdlOsbYqMUfnAT8ZTSSgOCGBcUMqgz2m3X/z8KtYocAR0GHjMD8lI+j0fbe8q3gjc7
 ajOqPR61aX5BcEdQjFA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzOSBTYWx0ZWRfXxvutAcax4rsO
 uAjIkd7146BqATZRpN9ZH+Pe8h2CBNUmOleRXC/8PW2qb2DU3RUp6y2oeMmTXwqBLWXhxj8e7wf
 wowHnkcE/fsUlrD0Uop6I4lq/EFZP1I=
X-Proofpoint-GUID: Kms1MKGbsIq_FbodGpu94-7oFAaORBx_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160039

xo_board is fixed to 24 MHz, which is routed from the 48 MHz WiFi output
clock (also the reference clock of CMN PLL, ref_48mhz_clk) divided by 2.
However, xo_board is parented to xo_clk directly, bypassing ref_48mhz_clk.

Parent xo_board to ref_48mhz_clk to match the hardware clock routing,
There is no rate change, where xo_clk is 48 MHz and ref_48mhz_clk is 1:1.

Fixes: 1d6abd242b45 ("arm64: dts: qcom: ipq5210: Update xo_board to use fixed factor clock")
Signed-off-by: Luo Jie <jie.luo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/ipq5210.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq5210.dtsi b/arch/arm64/boot/dts/qcom/ipq5210.dtsi
index 0c1ede0f73b2..6e4de7c29d29 100644
--- a/arch/arm64/boot/dts/qcom/ipq5210.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5210.dtsi
@@ -27,7 +27,7 @@ sleep_clk: sleep-clk {
 
 		xo_board: xo-board-clk {
 			compatible = "fixed-factor-clock";
-			clocks = <&xo_clk>;
+			clocks = <&ref_48mhz_clk>;
 			#clock-cells = <0>;
 		};
 

-- 
2.43.0

