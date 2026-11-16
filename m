Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794824403;
	b=y+xqSyY4NRAIKrn77GxgCb8FkHcu1jE53aYUVCDwkosxiCvRe2nNu69NXxcslR0NM9yM
	 4ZP2IZqNq5qyeYl04StTNcNXQFa/cfv6/DEcquiy8FGzDuahuIYfCacjL4VLDCGnTHJHx
	 cQLVyu2qB0V8sLaYWjkR2JInYaGRJWKP9uPvvo2WNQAap53AlSXu+hS0qUfav5X5ayaVg
	 CDKKU4x9Fp1h/6JSPN9LCgO/Wq1Rz+UXxlh54gG7/JMRao2H7GIxQdn+KjaOywtArNKyq
	 cd4IdiMtQF/ZT+N/1su1o5oNpPT/PBlDFUWTy2PVoOsza1mXHntC61enpAVuJt1hpZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824403;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=vITkXUOIKwIz3F/FjsZXi+qjCvbdxlE0z38bkytrMaI=;
	b=dMz+xtwAiLGYnwSRZuxyx5OfmWR1obpYV3xtSwoKJTaGsjcdsAKw9RkUZrC9bbFsg/BG
	 RuLxsaUj27PUpK5IFHx3G9svMKeZOsCC8ubD0z+vd4fu+BQa9drDYoIu8As+irWUHeCRH
	 Y8Fx34oLNOafrrY376m/sYApIbR+aufeHVUuLAaw64jiZ2Nplp99gXQQ3x50SjtBLAbCD
	 sGhJmth+vHfskbe7RnEC/YJOYEmdOls1Mb85DjNvn2IfCZnJYUTi6ETnAUONLHJFx55eK
	 ksYPL3cALzQy30cnWAbvJOj3l/jkV9cEf8r4weThQwhirRsRZ0Pn7tvTbg/K+/Vg0ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hM5tp0fB;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KKZIGoJP;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4274460A261C
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 10:20:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4274460A261C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hM5tp0fB;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KKZIGoJP
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGA2cU1953343
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 10:20:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vITkXUOIKwIz3F/FjsZXi+qjCvbdxlE0z38bkytrMaI=; b=hM5tp0fBHV/jKh+O
	3uuQVrORrHiHG9eua0pHNlVRvWLW9YsMvmsQRLRLIe6jPDTDjlelJThigIj8OqpE
	o4JsbnRCc68SrR0MIVMyYSVy1IwZm0v+Z5FYByDrjDZKCMFemKCROY3UAe0aw/jz
	kiS9DTi3cC7FB/ouxl+abIqfaO49R28TgFnRi+AilGIXOam1iOK9FKUAbqbLaQdB
	i7MZJFH9K8GEhDnwJ6lfzIYHnZQb0inMcCAY68KtQdfFbdXCw061OAli6vASJ0HW
	nNC50bhR7mFasPiEmwQlH/m5snl4KUpGvdWH9tecD8gHpD1RPCeDShd26JowsHbD
	CLOGDQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyyqy827t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 10:20:01 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-375bac6bd21so2685401eec.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 02:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794824400; x=1795429200; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vITkXUOIKwIz3F/FjsZXi+qjCvbdxlE0z38bkytrMaI=;
        b=KKZIGoJPBK+zbWBtjKofURWti0lUYU4eysl84RA99BAwZcfpDSzS/yfrDyYrp2DlDO
         Nmzn/7U32spcnELXTfyA7eWPLTm0dNyEQCyHHCPScAMVKWhDZV26uwl917Lbk8hmK1jY
         wn2HpzEpaEZMdtHV8QDNvF2kmufa669TDEdKCx+4esnCYIHw1bJq2+mWKTIXp03+kMWt
         zvxuhMzV60nWeM8qt/fZo3H5hw8wdZ1xsw9G7p1jV0NElt8gdWP54xnxQcmGYiopfOhd
         1fVuRWU9MODwK4QJ2XZVIYm71oSZ0OtCMkone9CGiG2+wtNwnlqPu3+YdGbVweANgb29
         KCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794824400; x=1795429200;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vITkXUOIKwIz3F/FjsZXi+qjCvbdxlE0z38bkytrMaI=;
        b=rDuI857Cnp/kVt+e2TJRcbuGccAsI9oMhuWN9j5tonTGR/kyQ43bhXu6GZ/ne8c/Nb
         4p32xYTgSGam0Yc45HHMKJCNP8FQcWmqeuGGebBYxs9QW3zlo/KjYrF8ASmppdtqzMrM
         O6TbYJcqXrG6zefuq/5CI01seuoiD4cVgCL6tk1hMFTV4jpCHVmbZ5GF2PXHvj67Qxr8
         QmqgJ+M2FEyvaitoy16tUi2GvczUPlvjTuNSZpnRo24SpCoAVdIzqklxZeN+E+8QqlVl
         WJLTWNC+3cUuWtcYRfrV/1HkB3btvfnlBSY5CfLkpi7qAxI7+oFnzHOHlW5AE6wVrDFM
         dOSQ==
X-Forwarded-Encrypted: i=1; AL+hErH90duKS21+Mbe5PeiHUaZa2wOuhwWiF/lFi628nTJkvs2iy8rICpIVGCxMwxC1L5hxf94b49CDAw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8nxEVFvTMn3fAKOEEhcttHlWjMmsYT+ZJqx1xcwF6a6ENemrHr
	OMT0VjKXCrZSpo8RGj2hh7stZEeJLikwNDcS8qU39X1621IIidrSk9sFQ61ulq+GlZx4JKBBoN8
	XUWfWchfmwMqur/ue8v9mlYCMKiZRNcKg4/Q0gdi5CImHwOj0d/sYOqTttkD4zg==
X-Gm-Gg: AZFdTZdUtyVA5i/25tCD/ZJuJoUihgP0k6Xh2gfm/wUWUbVakZLdm9G2ILwHU2qMUKC
	4Q5Bi94zSDGkecXTuXVj3poz8o6kZ+ajeBrWLzGXGp4Xz4E7WXqNpUV7IvbLR4UDF/OuKNu5SRn
	Jw3dTCD9X/Duv6pnYXwso6zqlm95HMgK2wUjx41HnGTR3fIPqf2/0eQgDeF8TkYaM/fIaVcbO/u
	6Mm2hNB7RQbMAPcee52cqOjzQv6BAlcaee/5IuEzIj9H9bIyKJmhdkD9KQbze76bTMomsUIMIas
	rZrMBgGyPkNqNQ9tto0kcnLMWS1v/qYFDFzP2pjc6C2n/ntlFL2qAPVWyfOVEaMyftOxxe64sId
	GEkiBbwWsXrxCDftDHlAJMyMMwxzBwX8M6Xrhpk5UKkyFrjqHWfVblzzeYS9hG2LE+SZiTybve6
	t5G6oIG7N/QSBeaz0C
X-Received: by 2002:a05:693c:20c8:20b0:36a:37:1404 with SMTP id 5a478bee46e88-37966e3af34mr9607554eec.13.1794824400232;
        Mon, 16 Nov 2026 02:20:00 -0800 (PST)
X-Received: by 2002:a05:693c:20c8:20b0:36a:37:1404 with SMTP id 5a478bee46e88-37966e3af34mr9607524eec.13.1794824399552;
        Mon, 16 Nov 2026 02:19:59 -0800 (PST)
Received: from hu-luoj-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bad6casm32599557eec.26.2026.11.16.02.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 02:19:59 -0800 (PST)
From: Luo Jie <jie.luo@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 02:19:51 -0800
Subject: [PATCH v3 4/4] arm64: dts: qcom: ipq5210: Add NSS clock controller
 node
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
Message-Id: <20261116-qcom_ipq5210_nsscc-v3-4-1eaf92698379@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794824393; l=2069;
 i=jie.luo@oss.qualcomm.com; s=20251128; h=from:subject:message-id;
 bh=beU54FXzwyrnuCcc7U/sv8QlVLauZi/DeLqeFsbtHI0=;
 b=LEg1pPKNgDy7sbq9s336DvRligY97/kGMaXfeVIFPu5Rp3TB7F1OSLTGzJQIA7vg+t40R3AJt
 Fa/hyNai5yYC9d+RQlGxM6nNX8kO8YbJkpwkAd1UeYdcAOd3KRBPD98
X-Developer-Key: i=jie.luo@oss.qualcomm.com; a=ed25519;
 pk=gSsYMDakxtd6UDFYDdA9y9yjIs5Etp5GK/3DoXWPyS0=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA0MCBTYWx0ZWRfX31A7X+Tjo6CZ
 s6gQ0vQmC7YpYk1V0jNtwWD/urcokWcKZ6NfOE/hiQzubD25yz8Dwv2cAxAtT97VNUje5EhBwxK
 SQETjLqixwC2Vj6UG6bwh8ButHpW94Q=
X-Proofpoint-GUID: MXBUyPx_Us5EiSoF1DYI1H7RfzHBTgTl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA0MCBTYWx0ZWRfXzWlVl9jZ6eZS
 5Jh9j8kPRBdaMgsIuTTvrkQDK2e/fxiOK8x7ter4roOLzr/2g9DFA6iZy50+9MvzH8QdqjDpdv/
 104LNxTyy7fclOTVnIXLlcdbkTz5XCi42nIwN0iW4/saoWfY/FszrqWo7aWjMHjtljp0GHVC5JK
 XcMr8dyW0+7SlHb0Ui/QlR1SB1yyPaNQHScYWLNVOPfCDu99D6xkwVc+XMQHxKVUMOI2lqC20R2
 /P1MlKCqcFAPBP9zyoXCUQHTFTpka3y7xlx4lRT27ZvTtm0kHBvA+B5milMyYa1Zf4UMQfYCMaL
 OCH+fmsNmMPMIIpTuNITC5v3P3Yb27PFbKlCfHTrJ4YW0m917h72AHY8Gqx+x3yrA2scB7HvIqP
 IpzO5TxY1bCA5yVdX1rYd1ib73JLB5TGwRrKDKgjlVvcSmAk3aSiZ0vznx1Yyc0pefzw5BXL153
 U3E27SLT1fGgtUQyBaw==
X-Proofpoint-ORIG-GUID: MXBUyPx_Us5EiSoF1DYI1H7RfzHBTgTl
X-Authority-Analysis: v=2.4 cv=ePeGH3p1 c=1 sm=1 tr=0 ts=6afad8d1 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=6SnK136Pe_QpXSRpRBcA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160040

NSS clock controller provides the clocks and resets to the networking
hardware blocks on the IPQ5210, such as PPE (Packet Process Engine) and
the integrated EPHY.

Note that the CMN PLL output clock names are reversed with respect to the
hardware block they actually feed: IPQ5210_PPE_CLK is wired to the NSS
hardware block, and IPQ5210_NSS_CLK is wired to the PPE hardware block.
Documentation is added in the DTS file to call this out and avoid
confusion.

Signed-off-by: Luo Jie <jie.luo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/ipq5210.dtsi | 40 +++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5210.dtsi b/arch/arm64/boot/dts/qcom/ipq5210.dtsi
index 6e4de7c29d29..575c06a8e14b 100644
--- a/arch/arm64/boot/dts/qcom/ipq5210.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5210.dtsi
@@ -331,6 +331,46 @@ frame@b128000 {
 				status = "disabled";
 			};
 		};
+
+		nsscc: clock-controller@39b00000 {
+			compatible = "qcom,ipq5210-nsscc";
+			reg = <0x0 0x39b00000 0x0 0x100000>;
+			/*
+			 * Note: CMN PLL output clock names below are reversed relative
+			 * to the hardware block they feed - IPQ5210_PPE_CLK is wired to
+			 * the NSS hardware block ("nss") and IPQ5210_NSS_CLK is wired
+			 * to the PPE hardware block ("ppe").
+			 */
+			clocks = <&xo_board>,
+				 <&cmn_pll IPQ5210_PPE_CLK>,
+				 <&cmn_pll IPQ5210_NSS_CLK>,
+				 <&gcc GPLL0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <&gcc GCC_NSSCC_CLK>,
+				 <&cmn_pll IPQ5210_EPHY_RAW_CLK>,
+				 <&cmn_pll IPQ5210_EPHY_RAW_CLK>;
+			clock-names = "xo",
+				      "nss",
+				      "ppe",
+				      "gpll0_out",
+				      "uniphy0_rx",
+				      "uniphy0_tx",
+				      "uniphy1_rx",
+				      "uniphy1_tx",
+				      "uniphy2_rx",
+				      "uniphy2_tx",
+				      "bus",
+				      "ephy_rx",
+				      "ephy_tx";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#interconnect-cells = <1>;
+		};
 	};
 
 	timer {

-- 
2.43.0

