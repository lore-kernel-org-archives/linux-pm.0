Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794824397;
	b=Pak24pOYfQK3Zd7cJQYcMMLUnu76r0dEt1xpw1N9xurchwWy1Sqe0Y/PxR3AMCPtxwur
	 4ng2bLxB77kGMtNmjC+rBwZ0U5QX8OhNmtOlJ6QdnQ1KfIH6z3lgZyA7Xg4txpeidkyni
	 toDUZTwyxqUjwm5Z2Un85LeFgpNA3quWpZJGsCOUyhlfhq428hKZ7qi9uPFrRra14b6xw
	 nHHDghorrFN/y+LI5vgPAGIjPZSVqgSCad0BhyOiaPLQ/s+b+iX6bniQmfeHwNqGxgy2q
	 UYEgXOrOMem2367lJ2DXRpsAJBAenaS9ylrK71RpO6DM3pOkg4+s0WgzShUIyBzFVjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824397;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=wsTtCStfZOEa8ZGHTWImCLz++db4z8y5qc0EyI6LI2Q=;
	b=SCbCxM5rw2tDLWYBi6jWzGPZWWkn2ggNoo7tHS2jI4BO5hAvjF/tv3SJUF/5NTk0ZdE1
	 42v/v6kmXXza+F77nUSjle6fIVe7PXsKwlvTPGQOhNSihP3+fKiVb7W2AQZZezehJPaw7
	 IBsSiOspIa19i+5td4hzH36qGUCG3Hj/qA7i3OgBuYqpWiKileLS1BVdTd9H3Q4A5Z5mp
	 eLBkaaww8y0sPUrBUXc45c+FetnFuHoG3nTnHuGL/AC4PI3KO3RPSlXjLPmDFroV07qoG
	 FBINfG18YNSWX5v/aGLbTqxGn9rX2LbIgz5iM6St414yr3C2nnC4b2DczEElvnp1NSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a2oxxKUs;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fRlt6cpA;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CC1606A329
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 10:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1CC1606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a2oxxKUs;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fRlt6cpA
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGA4Ocq1228075
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 10:19:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=wsTtCStfZOEa8ZGHTWImCL
	z++db4z8y5qc0EyI6LI2Q=; b=a2oxxKUsSlkV5lSLbkFaayR1AEBYjRbmxTL93P
	8yygEooa4QQkGmWzsklBE8YUgcTmH5vKOu1s7//vpsM/Ji1Y2szQ2Yuz0XttLAbC
	zEYVp0y/geHtnJiZhNZYtYLM/b6oilJOLrZ1EP/Jx3nQSh4A5glco3mg6Io79rMj
	EjJIGfpVATBKCaajF3UJExxm/B9NoTPMTxzwbyfiie/UYpaqM+rCz6blZ4PUHZ/H
	vasjVW4Fr3u0mUzPxDjZFAp5y71Mm9Dj076yEkz51O0g+ky7z/EXsDsJ5bHuMlqP
	rPlIqer3FgQRbtm1zfOEEokAxAHldg8jqcbkShlOv03xR0iQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyyrqg1uq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 10:19:56 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33713e5e6daso3057548eec.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 02:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794824395; x=1795429195; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wsTtCStfZOEa8ZGHTWImCLz++db4z8y5qc0EyI6LI2Q=;
        b=fRlt6cpAgE738SYlurG98Ppez407MDWPebNBOFBD/fQ3+Do7ZerUXAgzR8/ccB06Hy
         DENAB94tcViY6rdUxatVnldzKbJKehYmfjGc26HUde8RWMLwfUNnPHOpQ0SVbgqNBLFh
         jSILYM3vIEK9V3F6GLm953qEm8ej7L9Ez+1g2EQ1KbwgnmXkA7sFNA2QosPBCDIgJZEa
         Fi4sa3iwBXIoc9jHd++f4LFJEdB2QEOqx5bfZzfIovHOpSjIbSgNikWPheD44lH1xA/5
         qiXNVsAptau7TWfKhX5DRNBSZPeJUilt9pd9vqE2fIiFNUvnoIRgRTtcA0TUPIqiXXT8
         dY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794824395; x=1795429195;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wsTtCStfZOEa8ZGHTWImCLz++db4z8y5qc0EyI6LI2Q=;
        b=GoQJTyGC91LZUhTpq0/T8rQOHA/k/ofR8/bvBp+eR2Czt41bp5pcQqDczc6v9dgHj8
         un3G5JdtCb1lzPY377+D94KB3xlZPAxAkcquIJ08edM4HSauYyV/DE2dot5R6kvVk9Q4
         oWc1IRR3lLAX6PHTkP9/fi4bGeXwiCaoZ9YhL34/cLmo2WauwpzguahK8ASMRCKWpLk+
         QKfKLaMp/3qqJLG8MWCyV3CphXJpUP9HkS+pjL8buZIVUUY9A5tAu+SNbyRMVDrPMYjI
         gVUmk0/GiAWM6uE0ktfXD6op0KgaMiUHq0FII/wDRP9knrmiv1sbszw9iHQyN150TXUo
         TNZw==
X-Forwarded-Encrypted: i=1; AL+hErGNgWsnG208I6Kc+1nwN/lmm1320+qdMbMQgr4Rg9scppa15KqgAcMc4497XbV+tRi9YeJAWzBBkw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+GmYHjBPcLJ2MMv7NiVCFrt0yyEdAsEEi0DUqbwgIctZRrfFni
	eLrSqOUTC6fkB+rd0x71Hsscr0booOEaFExzRE8nnfJuS6ehcf3lbyJn6+pFNKFL+JZhANdK14L
	DyDeW1y/XlnJVXp+EEdcpbNeBSAwTEiS+adwNwRPSTki1bWOCh/rBmsBosbbx3w==
X-Gm-Gg: AZFdTZf/bqo87YSzkQvCJAyWmLR71v+LKPyXJhvYDhsa5+YOQxGbMbkVivAIJRk/nHV
	dVudzmKgf9o2npe9NNbl32cgtrVrZMpYZCiYyrR4ePOlYAFWKMGsRMcdYZNcAB5blaTOZDFNuhc
	QhsLA8jKAP4JVWqxYQS0CMDRrOIAZR/ZPYmrZUldps9QlLmh+0iT44rIBasuhmhDpdcNDCf1PEN
	ZjLXYYT/T2aCSjDTBF9fuQIO1DGo6LA52Sg3oxGIIOo21cMBCrgVnmVrhCSBt+huTNtHTCxnrzM
	RvCdnI1bALCzCVe9pGgTmG96lQAHPvslkMyUM0geEmqolqC8bZLV6sd7582z+RoE48PzSnnr7tc
	U5LdyrKxstA/HA4whp+DuYGQKwxHfvgJy9LNeIY+gl6HJ1809XTJnyX9dXoqHToXXTtua1U5BJa
	UK/K+CyHVCv3Qy7E9z
X-Received: by 2002:a05:7300:f694:b0:376:203e:7d7b with SMTP id 5a478bee46e88-3796337436amr15671274eec.2.1794824395269;
        Mon, 16 Nov 2026 02:19:55 -0800 (PST)
X-Received: by 2002:a05:7300:f694:b0:376:203e:7d7b with SMTP id 5a478bee46e88-3796337436amr15671238eec.2.1794824394601;
        Mon, 16 Nov 2026 02:19:54 -0800 (PST)
Received: from hu-luoj-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bad6casm32599557eec.26.2026.11.16.02.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 02:19:54 -0800 (PST)
From: Luo Jie <jie.luo@oss.qualcomm.com>
Subject: [PATCH v3 0/4] clk: qcom: Add NSS clock controller support for
 IPQ5210 SoC
Date: Mon, 16 Nov 2026 02:19:47 -0800
Message-Id: <20261116-qcom_ipq5210_nsscc-v3-0-1eaf92698379@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAMPY+moC/22N3QqCQBBGX0X2uhVn1JKueo8I0dkxN/J3VArx3
 VuNoAtvBg58c86shHvLos7erHqerNimdhAePEVlVt9ZW+NYYYBHgCDSHTVVatsuRgjSWoRIFxz
 lSImJDCTKPbY9F/a1Sa+3L8uYP5iG1bQuSitD07+36gTr7heI9wIT6ECbqKA8phDzGC6NiN+N2
 dNtK98dtXYm/DMB7JrQmU6MBMZkIRvcMS3L8gEj0kE7FwEAAA==
X-Change-ID: 20261104-qcom_ipq5210_nsscc-fe4b2c8d4d18
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
        quic_leiwei@quicinc.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794824393; l=2532;
 i=jie.luo@oss.qualcomm.com; s=20251128; h=from:subject:message-id;
 bh=3WMMLf5nFNS4ZIF56t2dXflK4rsLx1axqH/8+3GQJi8=;
 b=C01jZMPRHCEeDXYE6TOqGcOQLUxRLAyRKMkL6pQPPT4JJlAKNA4L2j3J9MoMPvlerQPS0/yGD
 FYdTdEzggZUALPnzRM+F3Q8qyUSZIRE6CvpLbcpw09ihK5L9/IXh63W
X-Developer-Key: i=jie.luo@oss.qualcomm.com; a=ed25519;
 pk=gSsYMDakxtd6UDFYDdA9y9yjIs5Etp5GK/3DoXWPyS0=
X-Authority-Analysis: v=2.4 cv=VcJir1p9 c=1 sm=1 tr=0 ts=6afad8cc cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=8DxjrM3GApEK5qXUAGkA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: lyKE7wWaTC75NWCEqj_SggmN4tHKSEW-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzOSBTYWx0ZWRfX/Z3lMfWESq4x
 6CeUXtlvAxiQiE0NtJPWZynBclDzLDRHfuDik3ltJY+md6uA6Z3jtdtX/UIYbn6NEI/OiAmrL2H
 B4kXEcPjE8y9ejD5qkCkdamw8mKaC6cr7DMQA4KCk2oSd3ZNUUIvOkrhBVv4H9fJ/dDDPbicSCn
 5Sl1qkdlCBMpNb4gLUhnUpMW6viFdUOfMV5Cum+XTOWSSRxvGUgxm4J6IKK0WA/vgDuwbvxo6Wb
 FVhnRP9PbOaYA2hYvZCcI9SODtUb1trrN2QBNaEgJWvqQfOXqeDhXOt52RbgcV74riUGSZbwgfE
 yIwQ8Mbks8EjOeb6RaN3KYl4uwiIsK1sq3LPUAga1RjFLUirj91wazjME9E9+hpucIGSiZ4VLjp
 Sq55O98NESqoitq+AP3lt8YqXY7AenpFd86uB1zBFmICAOpPKPgSd4a1Yp8qGmSziptBlV7KaCy
 VR1PSRe2yvF6OfqkNPw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzOSBTYWx0ZWRfX//uiYA0lb290
 anVEIWbzUaQv6O8aArA+iozsA94nNdLP1BdRTUQbHNKMqDWi4cud0Xx95d7XVJLASv0w4lK79Vm
 jD461HDhyW0jvGoxz1UlN7CqDaemki4=
X-Proofpoint-GUID: lyKE7wWaTC75NWCEqj_SggmN4tHKSEW-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160039

The NSS (Network Subsystem) clock controller on the IPQ5210 SoC provides
clocks and resets to the networking related hardware blocks such as the
Packet Process Engine (PPE), the six ports, XGMAC PTP reference clocks,
PON, EIP crypto engine, and the SoC-integrated EPHY (2.5G Ethernet PHY).
Its parent clocks are sourced from the GCC and CMN PLL blocks.

The NSS NoC clocks are also enabled to use the icc-clk framework, enabling
the creation of interconnect paths for the network subsystem's connections
with these NoCs.

The patch series is organised as follows:

1/4  DTS: fix xo_board parent clock to ref_48mhz_clk
2/4  dt-bindings + clock/reset/interconnect ID headers for IPQ5210 NSSCC
3/4  NSS clock controller driver for IPQ5210
4/4  DTS: add NSS clock controller node in ipq5210.dtsi

Changes in v3:
- Add patch 1 to parent xo_board to ref_48mhz_clk instead of xo_clk.
- dt-bindings: Move minItems before items for clocks and clock-names.
- Drop CLK_SET_RATE_PARENT from the XGMAC PTP reference dividers, so
  setting the PTP reference rate cannot reparent the shared PPE clock.
- Collect the Reviewed-by tags.
- Link to v2: https://patch.msgid.link/20261111-qcom_ipq5210_nsscc-v2-0-7e2c1dda3ed2@oss.qualcomm.com

Changes in v2:
- Use RUNTIME_PM_OPS() and pm_ptr() for dev_pm_ops.
- Rebase on next-20261110; drop the CMN PLL DTS patches, which are now
  merged.
- Link to v1: https://patch.msgid.link/20261105-qcom_ipq5210_nsscc-v1-0-d4fcb5c32b51@oss.qualcomm.com

---
Luo Jie (4):
      arm64: dts: qcom: ipq5210: Fix xo_board parent clock
      dt-bindings: clock: qcom: Add NSS clock controller for IPQ5210 SoC
      clk: qcom: Add NSS clock controller driver for IPQ5210 SoC
      arm64: dts: qcom: ipq5210: Add NSS clock controller node

 .../bindings/clock/qcom,ipq9574-nsscc.yaml         |   47 +-
 arch/arm64/boot/dts/qcom/ipq5210.dtsi              |   42 +-
 drivers/clk/qcom/Kconfig                           |   12 +
 drivers/clk/qcom/Makefile                          |    1 +
 drivers/clk/qcom/nsscc-ipq5210.c                   | 2201 ++++++++++++++++++++
 include/dt-bindings/clock/qcom,ipq5210-nsscc.h     |  106 +
 include/dt-bindings/interconnect/qcom,ipq5210.h    |   18 +
 include/dt-bindings/reset/qcom,ipq5210-nsscc.h     |   60 +
 8 files changed, 2483 insertions(+), 4 deletions(-)
---
base-commit: 84abb955b1015477aa11a96e2f3ac1b938b77f48
change-id: 20261104-qcom_ipq5210_nsscc-fe4b2c8d4d18

Best regards,
--  
Luo Jie <jie.luo@oss.qualcomm.com>

