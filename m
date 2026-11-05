Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793884092;
	b=LL+gqse+S/P3vhSa6V1lSY6glaWE05PAzHG6WDebLMbDY8NhrlvDKeEvZ5By7OMlXCFN
	 PQOM8eiKSGUM4ljvXM7GFciYKuKYC94+bT+Ycs64PW0m2qHnYujT5y1ID+0R4lxfLz7L7
	 QBudNZVd4WHeekpkmp0XEQdxQOcU9AmOHrnC1gvpXos0JTUYwB404x0ZvKfTmKVA0do6T
	 VZQz44qsH5bHIwzeIYewsrbhedzHg+g8A8zJFeWIbdJd5Hx/RXo1IDmb6AU83qZUgIEtJ
	 zLt4cLmWl8NuAczA+1urR5eMvT5J3tWo18yiYxs02OC828IO8sf1O/aM8+D3AWRmcJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793884092;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=HEpBBwY4m5scDgU0RA4B2noBF/zAsH0ctz5E1VEmcHc=;
	b=WAWho48mxrPwIjy4GOBdZlkxoOhMem9WfjijJPceQTtD6j1dRzoQXd7QyaprGvEGjRK1
	 KM+jcO6cMK6/nAALLPhCLQsjqB55WPOMbps5zCz8rdmf8261WRGI/wJxCCyIOxgWkHNqA
	 InEsVwHyj13JtIn9F34h45qUZawOznSc4GOIraSNCYxNAR380Gy7XaVQr5scwH2HO0nJV
	 wqeMlAFShwOhrSnvBJBcwXzBOEYXgJZT4odHWK3mkJcSrf27Rkruq6monGdIHYcsjRI70
	 YJRk21gaBxuIQh9GLbApQlQ39U8MwehBrFdtK3u0G3t1RrVjR8S5G6xjLUeSjuftNfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Of5qfoBT;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=auzTYsO0;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2279606D808
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 13:08:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2279606D808
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Of5qfoBT;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=auzTYsO0
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A59twhJ3532336
	for <linux-pm@vger.kernel.org>; Thu, 5 Nov 2026 13:08:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HEpBBwY4m5scDgU0RA4B2noBF/zAsH0ctz5E1VEmcHc=; b=Of5qfoBT2tN7w9SS
	eTfmrVcEdQLOeJ91QDApW8Q9Q4pmu3QFKUx3TLEJMqG3ONm5Yy57CYpyoFrobkJ8
	WtAWOsYmjaf/la3Zb7FvCsf4hcgqFv3zc6krJ+B1FlKFUNSzdRXWUkIlhhJstMKX
	JgPQoaf1ghM0u5rJX/6nx2LBSeY4+HnbiEj/HPSHHXGnrbT/N1VqBHcHnRiFtkGI
	+q4I6AmA79Lo50xLbVWEqTa7pGGOrq3uoxT+Z+uxXUgGBq+z5XIPxisa1r4NHd5B
	yTP6sCLSh5MuVT3lUBwe/x9CSG4t3g8UxETuoILb7cfw7G15prvoNHD1aCQbwnNY
	dW6aKA==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrksq9s10-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2026 13:08:10 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-8b30ffeb2f5so28305457b3.0
        for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2026 05:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793884090; x=1794488890; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HEpBBwY4m5scDgU0RA4B2noBF/zAsH0ctz5E1VEmcHc=;
        b=auzTYsO07Gf82IGBM4HQCJeK4r+1Tx39J7TN4AzBsKE4Z+z055djmpmoYbWmwICJZ1
         uaaF541w0zXF1jDQDPS5frYC7XmQn3c2H91y7myAsH3ApN3OtDp6GXkyEqFtp1IVgKMU
         WzrSGcMzsXsdnt5/SAii2ciApwza0oXE8WuaI2ZvNevxefjSQNQ1p5lQtTkZ1LEkgCKr
         h7ETG6CaSGKvT8k+0cLCNlpEJog/nNZfF+9GVzQ7jdBkdltViBuH/Zl+4z3jo7oaICsQ
         LOH9upd//8jByHO1oA7oan3m75svpM2oxw9sTkn4raYLlunVh0CG6n9+OoPcKtvimD6x
         mI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793884090; x=1794488890;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HEpBBwY4m5scDgU0RA4B2noBF/zAsH0ctz5E1VEmcHc=;
        b=QM+moIymNZHvYihZPKW4JLRHrDSB+BAm9bnH7ViGGUGCBBu3RNekGgoEYMatfuv8lt
         c6apqVRtHQJggoVVd+cPetawWUF5lQes31goyG+nq6s6uAArheuZtoXAqO9c0AnbXdzy
         xiOAwsAN76N6Ky/LR6+Wd5xUc6BpyeKclX4tYgByuNfdrW+h4982Oee1csgZ/cx++jyj
         GOJ5wnpeWVX9/39FmXyY5Iqaw38IBLwi8XGSQtMUStn/BQcDBClTidpy/eWXkrifbhm1
         c3cuDXTq1NrJm6f6a5MxzwrSVkiYdFE3WXk/6XF2boTIFwhzUANmhIG+/sVME+5CFjE0
         V9HA==
X-Forwarded-Encrypted: i=1; AKwUvBzBdy4hKg5gFKymvVstYQ/rMvXL1+DOR/cTNjjUimr+lkYuOk2sW680C6n6lYZLEr+8QmEwloDQZA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+svXQbtrhZTe6lWZXx1emwkEUcvg5rbFyTlkerf8zjZsqGsr7K
	jdrhk1cHDlDQ9N4pTtlN3pDy9kWzp7UKD4wMvmHYq8EjGDaw/D7FIJ5zSIROq5U/dRlXggh6pOL
	49/lElKTLHN48EG/YqbxB12EF0C8MyLif/f/baDdJfKdDb2zMLbMc7BIOdl5CVw==
X-Gm-Gg: AYBFou3Ntno2bSlPk4Qmq8RftNlKu36LEQ2sHEag/flC5iOodMJF8sUbYs20MLjIxy7
	2VYFa0Xkpxx6IqLwyY7F/K0LRW25VQb5DxVYo5AouC34dBm+Ud8DOLbJ1Kag6QsHe8Zvc5e/ip3
	ew8Rng8lq8Hkh+KgqkFMNFfFVNR+oENqLZ0IDMwfZwzrPqma5FkItHwaljjCijtTP1Cj0PzpdrQ
	0wTfRVUlZP915LRh+J/T1Y5cZT5VoVdITeBNW/NL3jOuBIzHdMWePh8WNP0n3kp4oALEFEeqjNQ
	9uijmfXmP2xNtt9eSCAYOtetgbacqfXMTMPvCiHrsOjLwBFyFkvJBnVx9gehk38/g8gt5nB8yKB
	kV+pKDb2lhzcR4IHifj+D8DGAuJRaBUTxfUyCwe4mukOTHHS11ZqR2JsqDXZgMFT/MF8qx8CzBO
	ux1WGg17Q/ufuEIqZr
X-Received: by 2002:a05:690c:4992:b0:8b0:e680:616a with SMTP id 00721157ae682-8b2b66f45dcmr147057817b3.24.1793884090192;
        Thu, 05 Nov 2026 05:08:10 -0800 (PST)
X-Received: by 2002:a05:690c:4992:b0:8b0:e680:616a with SMTP id 00721157ae682-8b2b66f45dcmr147056237b3.24.1793884084340;
        Thu, 05 Nov 2026 05:08:04 -0800 (PST)
Received: from hu-luoj-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b309bb4406sm38915937b3.40.2026.11.05.05.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 05:08:03 -0800 (PST)
From: Luo Jie <jie.luo@oss.qualcomm.com>
Date: Thu, 05 Nov 2026 05:07:16 -0800
Subject: [PATCH 5/5] arm64: dts: qcom: ipq5210: Add NSS clock controller
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
Message-Id: <20261105-qcom_ipq5210_nsscc-v1-5-d4fcb5c32b51@oss.qualcomm.com>
References: <20261105-qcom_ipq5210_nsscc-v1-0-d4fcb5c32b51@oss.qualcomm.com>
In-Reply-To: <20261105-qcom_ipq5210_nsscc-v1-0-d4fcb5c32b51@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, netdev@vger.kernel.org,
        quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com,
        quic_leiwei@quicinc.com, Luo Jie <jie.luo@oss.qualcomm.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793884066; l=2069;
 i=jie.luo@oss.qualcomm.com; s=20251128; h=from:subject:message-id;
 bh=V7tk6aEtOPhfOk+VPI7cIHGev2spKigLOSXp8SeaGFM=;
 b=NQZ0VnXNNs5TVcS/GfGIp8OMqr4bqDVVREAqgfRdanu4y70VLhmGeYPMpHa85TCG6ztA5t6gu
 bw6K2g89zZUBmx9UG19aSrHFqkgmyhdbqNUcRDDR5s47APAPUsRdBd/
X-Developer-Key: i=jie.luo@oss.qualcomm.com; a=ed25519;
 pk=gSsYMDakxtd6UDFYDdA9y9yjIs5Etp5GK/3DoXWPyS0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1MiBTYWx0ZWRfXys0EpVZqdPHI
 B23qaJgGcNc7uAnBwKipL96g/h16chnRFgGbD1IssIlnjMp3s8AZtEKGlY+jxlTP/M1NcAYrmvF
 WdFCyJ+oMkQ2dR1Q+zqBuas5afJsexjzLGB/twULFiBmNq0Y/PtRUYe83TGk0wfjc3wfeXYmlWj
 JXPT5mUDleUdc1fA8i3NcDkAe+oqLAD/ZH6sr48wkTj4C2L2Ts9Bpt4YhSpw6zhkxzthD01hW4j
 jSYqCovMNQS48Ud7b4jwz3yyYtkf8/ju7czFaUXLUZP32Jj6Er4FgfuuzZ4f2USvLHN5cozEzE1
 xqWcbgJlVZp1E2NESZco4NF0cIRakN0ZkS0QozLuvfPiEm9eDBAvNMKJHpcJge+caFfaT0t2IJi
 z70b3Gv1192rr1B29taKnc/PXETVxxVOC55BIPE3mpUC/PWHC1Ry5LjmBJxOuX7O8JfDOtjsDaz
 r7XiZe3PyEIHAbNkf1w==
X-Proofpoint-ORIG-GUID: BkyB4vsf70krPOX1YotUpQ9MBzTCpTZD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1MiBTYWx0ZWRfX/WMA3PeLdS8q
 RzuRNKWI6dNtJ9GjcwaP4BVeu7LulhgV0SrorP5Bx7tycf6sND5Sd8jONPycWPlErvzW9oy6Gcy
 XKysgr/nNEM0QjoThJQQkTKY1UvhYhU=
X-Authority-Analysis: v=2.4 cv=CIe/zhrD c=1 sm=1 tr=0 ts=6aec7fba cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=6SnK136Pe_QpXSRpRBcA:9 a=QEXdDO2ut3YA:10
 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-GUID: BkyB4vsf70krPOX1YotUpQ9MBzTCpTZD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050052

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
index 0c1ede0f73b2..11915f8eb156 100644
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

