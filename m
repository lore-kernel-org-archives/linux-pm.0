Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFB32931D5
	for <linux-pm@vger.kernel.org>; Wed,  7 Oct 2026 06:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791355856; cv=none; b=EI/tPNcsIJf2fVokCWL+62ns438Qdg0HtDEztYPw6KW2fktxHWnNS+6cShiOV07JQ8Knr4dm3f9vfX9obvBq5j4pWGiA12ezx5ttUEfNJbwpbqgZ3KRdfbJH7tlfwMOZb+S9OaKWH+DjfnhlkHRbYCkByitRXIFRaIJdc24ggCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791355856; c=relaxed/simple;
	bh=Ni1lTQeRbFImYjymCCxoP08AlDfxpAcx3Qkva4hCzAs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CXy0lt8jo6O/j6RHklNWzvb9ERrGXaLIP/eRHQ9M3Qf6LSgWhBHnKtTtw3dvdKV01TnWwviYlK9EIkP4Thanzqbi8xKRp0631/mnUwOR8+iCnNIuA22UrHSQnDccoe1X8N4eEXpkpqeqAzNezWwW/7Nt0Cnm0pbArKPWFPgRgAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VtFDngL9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NWMBs1Xa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VtFDngL9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NWMBs1Xa"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6975OANo1567533
	for <linux-pm@vger.kernel.org>; Wed, 7 Oct 2026 06:50:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=a11M7BngOPJoTkOyICJz2w
	OVpKy80IFCeWDMdq/5uas=; b=VtFDngL9Xd28E4NoJrmFjjGzr8Pqu+AS18g+VG
	pc/DFFYbIeE5u/mrUv+HZbP54JaRm/ov0XbVnhBk+LN5KFugFz009bRIZVH/b+NV
	vOeR9HzpHfeFxPxkYvSokviYum59woQIRHfF7iLVyi63SYW7dYR0Zu89eJmiww+o
	K2SwUQrkO6E62J+Nze89Srv+G13AVSBl49gX6uKaOv+ehrZO1wmrJb3krvmb1Zcv
	P5dW0iPbbX+0zPgf1XzioqKLAWS0LJfuuZgxOA3X7sop/uIpS3AofjTuKwxHTS+G
	DjL1ekgHlog64q6wJ6LQ9HdalpxhnqXL2QlgdGj+ZVFK4EjQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5fw8r88f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2026 06:50:55 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-139b62317d0so13097943c88.0
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2026 23:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791355854; x=1791960654; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=a11M7BngOPJoTkOyICJz2wOVpKy80IFCeWDMdq/5uas=;
        b=NWMBs1Xa0pgD3b2GRK17XW3ZGUOw2q268Uykawfp7PEFuAPWyEKsbmw2GFfFo4MFmT
         lOfLERAZDZgF1vJPOYHrN0gIYRPFwtgp0k2OX0CGmu+R0DqfKmyfOsBz8awU0YDrTPLV
         LWX9wOubQv8dXSLE/fu6HL4ZWnn5HC3z1HNPB+XHm9FQYg79LdUGYW5JnEWeTHMaUuGA
         90HsAO7DM7zschlLAn/Srmcud1uqkhVld1lZBjDGbpI4ZZTb8G7qclHZGcjt+x9LQDzm
         WGv2oyc92Wx6Ausrl+e5A9yVWtUjoUPxDHXPVpWNulSvumDzR4tbkHWZJicEVniHfmR3
         gEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791355854; x=1791960654;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=a11M7BngOPJoTkOyICJz2wOVpKy80IFCeWDMdq/5uas=;
        b=Jb0gU27TvCkn6lIY/RPxB3/OhmtUqs/3bpurBCQ9fxiaNU4+v5M8nvPSSMFsYTXOoL
         qfY15yq1y2TrAecXH0oGRKGLlchdAB7+isgg3fw61yXp622gai1OkULtlDOauY91AB1X
         h2iexr6Ah5RErhK0iT723OR/t59GYWgZwWwgr8N3Cc8r7flYFFwBjn5jnNTrYJ5WzzvJ
         yQZARwnXVppeBD+wrezkFkn3DsNFD7Y/8FIKowUafaARMb8RtKj5Al7+I0eeu9sf7E8h
         JDUBetCd+XjnUMJVWFllmwwvg9ikws/BylHmSR/E8XZr3NT5kMN1cPt1pby0LilwartK
         wzwA==
X-Gm-Message-State: AFuF++m7CRVIlkyrR2GiWUhRX9Bvl/HMWMRHzhdqPxJgpqn8qHsPPxPE
	RgYj6wTP+dHgLrWBSZQgvlDVhcjH08eHq07RHc0mnej2X6AoGAcLn4QWTuQJXz4E7jjvaSQjy4F
	z+wOcIwfyRtHLmaV4cp/yzNVGTLZNERyruo2z66lP0gMi3YKMSwtoZkS5/L0G7A==
X-Gm-Gg: AYBFou3JaS96fhe+VKoIagAWCHnO2HY+cvqTn1bKmHfszqOi0GAWrzxwYTxP2TcuZnr
	tG49h4KdIh+tO5f66BZ5Z6i3R8d272/I28nwoEJQplANoAszUaAMc/k+i3W25SpD0VLEcKvBov3
	wlaG+4f2SyOVy3C30mX5V4mGG/ae0zNJcoBCA+p48VlZe1lM3RL03eCFU/ja1uhoSyfL4b5d+Po
	rweGOJJEAO7yboEx+OzQd3KOG3XPGE2B75XEk6LzXRvTKQWTXToF5HWycuJJrUW1SKYsJEKmfFw
	n59Z9AmNb9rN9np30pOT+MrBPGpoAc0ugWw+OJa3pzp0LaquBr3LHkpx3GiwpJNIU9hNUEvA8AW
	X6F4YDPzOM0y4xe92iUlG6LytM29z2vh3y4dUdjabUGjDQ7eNLwo+iga5OGl9l1Zp0EadN0EUdh
	X+4+PDCkzFWCCF4sD2l8DGzkOVGF+LTC/p8I4=
X-Received: by 2002:a05:7022:3a02:b0:143:26f9:33d4 with SMTP id a92af1059eb24-162079a5f27mr1774321c88.34.1791355854427;
        Tue, 06 Oct 2026 23:50:54 -0700 (PDT)
X-Received: by 2002:a05:7022:3a02:b0:143:26f9:33d4 with SMTP id a92af1059eb24-162079a5f27mr1774273c88.34.1791355853728;
        Tue, 06 Oct 2026 23:50:53 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1615f1ac8c5sm7374730c88.2.2026.10.06.23.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 23:50:53 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Subject: [PATCH 0/4] Add Qualcomm's IPQ9650 APSS Clock Driver Support
Date: Wed, 07 Oct 2026 12:20:43 +0530
Message-Id: <20261007-ipq9650_apss_clk-v1-0-fd4c2b3cbdea@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMPrxWoC/yXMQQqDMBBA0avIrBtIItHaq5QiGic6VWyaURHEu
 xt1+Rb/b8AYCBleyQYBF2L6jRHqkYDtqrFFQU00aKkzWWgjyP+LzMiy8sylHXrh3FMbTNO8UQp
 i5gM6Wq/l+3Ob5/qLdjo/sO8HEqeygnQAAAA=
X-Change-ID: 20260925-ipq9650_apss_clk-ff825e337d11
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAyNyBTYWx0ZWRfX1Gwx9eUBMOvB
 25EMILOW9ydKigp4eUTtTTAxIaHVDtgLGXMzggnCgbJz3kHOJwdixi8N+KCEJkQXenKdaE2Nx/D
 FBCqEU9S7wj2xXhadNUNi4OT6K+1pG4=
X-Proofpoint-ORIG-GUID: DzYrDAcaIgnuSbRe38eFYBu47Bj-AAPw
X-Proofpoint-GUID: DzYrDAcaIgnuSbRe38eFYBu47Bj-AAPw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAyNyBTYWx0ZWRfX5MADK8mDmqNU
 /RILijw6DE3+9V7LBEujGJFniQiOZhO7C2Xrscm9BiEvMkDW/SnTjlo3JMwYXVVUAFD98sLzq1F
 54CG6gitPS91oxEd/qsDFfumhYUgSxampTS++RXhBo6LRARYZbRNcfuByJCGAIFAXzdGPQzRclz
 ZmAdhdecS4AR2UJhPSDHJ6hYrjtXvaCbi5Vbzsu1YbymhQFehFtZBew93fnE5BMlQamWYY2dhAd
 qT/GiGPoRH1kVgPJZkrFDNpKZ4jlFt83z5VwTON0N7fB6bi1wgxMJxd2n2QMWGe5KRLQ1Erwa+0
 EUPAhVO+a4Q3VMGAtCoL+VyQyJaZFJhxzBCYooumXHeRHywHB6JhbM6SzzcW5xSY/AjV5FjWy+O
 beQhMSkO7iLShGGwcEQoM1GYB96xNK03KeMnxjV99g5L5IgF4DsJtvIpYTodkOS+NiN2Y0I/cIM
 0jxsM/fBF+wJfL7Ljkg==
X-Authority-Analysis: v=2.4 cv=Af0kjHXG c=1 sm=1 tr=0 ts=6ac5ebcf cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=mshoYkgwlum6hxNOkgkA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_02,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070027

The APSS clock controller on IPQ9650 provides the CPU and L3 clocks. The
four Cortex-A55 cores (silver), the Cortex-A78 core (gold) and the L3
are each clocked by their own Zonda PLL, selected through a glitch-free mux
whose parents are XO, GPLL0 and the corresponding PLL. Since the L3 has
to scale along with the CPUs, the controller also registers an icc-clk
provider in which both CPU clusters vote on the L3 clock.

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
Kathiravan Thirumoorthy (4):
      interconnect: icc-clk: support N:1 master-to-slave topology
      clk: qcom: clk-alpha-pll: Skip Zonda PLL configuration if already enabled
      dt-bindings: clock: ipq9650-apss-clk: Add IPQ9650 apss clock controller
      clk: qcom: apss-ipq9650: Add IPQ9650 APSS clock controller driver

 .../bindings/clock/qcom,ipq9650-apss-clk.yaml      |  58 ++++
 drivers/clk/qcom/Kconfig                           |   9 +
 drivers/clk/qcom/Makefile                          |   1 +
 drivers/clk/qcom/apss-ipq9650.c                    | 385 +++++++++++++++++++++
 drivers/clk/qcom/clk-alpha-pll.c                   |   4 +
 drivers/interconnect/icc-clk.c                     |  45 ++-
 include/dt-bindings/clock/qcom,apss-ipq.h          |   5 +
 include/dt-bindings/interconnect/qcom,ipq9650.h    |   4 +
 8 files changed, 504 insertions(+), 7 deletions(-)
---
base-commit: eea3fef32a9cf36abcb5975a5a594e4135a6b026
change-id: 20260925-ipq9650_apss_clk-ff825e337d11

Best regards,
--  
Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>

