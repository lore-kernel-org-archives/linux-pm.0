Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E2F542EEF
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 17:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792170433; cv=none; b=fWRNvhEiz3aeNiS9ZxHKbgNwPbmkhMUVH5thO/xM7H5UzFGpeq5hz204CDXDST51+uqPENhZHRjCkdVyZRv80/AR8HfQM+w2Id1RZ9s1fvpFT/f2ZBHRwwMd7K7RPdc8CMTS4AoEk7uVAlS3ZVQB2qJoRPkNy9CSy1iyrY26D6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792170433; c=relaxed/simple;
	bh=av35yw/tPNIZ6bmTa7I9FYsH9ICauSAMAtNkRo5gNH4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=syRmt62ojJ7xlI/Z48rF1jXqX66AWhWi6fTOfNNWYCgEaCZ4ttV5ks99wB/VJ6aVoQe7LFVMvkjFd3RHIFrA+XO2Y6MmZdKMYhitgUV5k1jf4dBUWDUD/J+UFN1PrO4pID6P8tCMkjHvosyPOFOY853nfcpAoqhIkOIivcjSTzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cDTyUuZ+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bpxeR51r; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cDTyUuZ+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bpxeR51r"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GE5njK1450308
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 17:07:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=H/v7E4REpsa5bmBQG91aAh0T7SxEeeMHbaM
	ObWJqWE0=; b=cDTyUuZ+QFJoG6Yts5m9386fXyOOaETHcD/SZmHV3GjXiDKc5S5
	/UrIwIB8ihqY2IsWwXNgV3eYzeA7gG2O83Ov34dK23ox2033THOZoOJQY809j8h7
	DdPS7dL3Q9v9X+yaC8pkyo8lgZJSOiqJyRhapFYH1ih24qO0M6zWux9SUQOfmyZA
	lzJe+2ke2jw2Tuuyn90g6ed5j4hKpXboXo4Hc/MRJClCc+4lsZJ9kbQx9xc/kMMz
	UHNSXk8Vxb7VDkkA6vUTbjUd8vKxnePwAsAcEWO37Eu8551fy4ukByrzRnKM7ogj
	7iLLQm1xeI+DPDyEFWi6X9IscaXmMe6Gv0A==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbhur1jjr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 17:07:11 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5de9d3d00acso151811e0c.0
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 10:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792170430; x=1792775230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=H/v7E4REpsa5bmBQG91aAh0T7SxEeeMHbaMObWJqWE0=;
        b=bpxeR51rO9oXMzfh7XwROkZFG83dMUrazmnZTqnVXIX/XYsSDyUw6niK6zN624HhFN
         Wi7bhH4ZQ0mAI/UuLPrVHAfUQUpWTax77Wz1dnPzWCMTAjfAkxN3ZIarE0px4sYmtC2v
         lyk9OVN4MSSTd07kK2pkD9LuLqbjqmMgxViS7PnmgpLHqRUgXSS3E44ferDzGrWAWeYG
         SN5wcadX3569E3+KtAT8ldZdrZp8MwVivdhx5aUKfYtVZV1Y1LnS4FUK0gJO5Txt9byd
         BiRH68viQdfpyJp27onmrtbgIhWftXtlyeHvTu5tY3Ew5LHjqrj3VlcRgSTdK/5Bw4Py
         53sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792170430; x=1792775230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H/v7E4REpsa5bmBQG91aAh0T7SxEeeMHbaMObWJqWE0=;
        b=qP6hehar2+jIixSYOOxVYglBANhNVN4epng8Uhc8uJMdZgSWsApj0Dqzk+1vsjOHnX
         pqkwZbI6w/QDX21RHoBH+fn6WKinnDGc9+lZxvHYHwsw52rfYmHnB8e84Hx/umiNFl/c
         bhik4NB1oLV5ChqepkPELWQ8LwVcbl2alBtVeT1pknc30yd3Tw3YzZp+1PwE61w7wkLs
         JNkP1axslTcsMouKP3EDFAnhB24xX4800v6yj0qKPlLwwkDRltledweBidMoUfiSEcqS
         i8M1fwIVFJaRACR94jMSguLHN7FPwbdmyH6fhnrsUW6Jn3ppehQWZYWomXmDwBRCZH/V
         FDxg==
X-Forwarded-Encrypted: i=1; AKwUvBwjcEdYr6N6fsjY6w38iWJHSU7A+NTsKm3+gQxv+s66a9GHJNR6+a72IZlPsroGce1+lT3XmtVcTw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLYPwNpJRYF7rJoqwqOnd1+AFayeHu3MCAweoPh3feYrf7zWGUR
	3/DJacHdhcHOObqB1X9g7TBwMbH/3pvea7HpHfc7R0pzKz3IY9Aegv5bKPYvny2RWwRQS2+bLDJ
	tW4rFBAugG7jd1D8aBjUjg9MRdK0Ndopzq+urLxg2vHL9C/CrlGcMZfylFp4+0w==
X-Gm-Gg: AYBFou3jOAjEh8wLOUX/Jv7tQM/lt84fwZkMJPEn6k8MWHVUnOkCwCg2iQiO0F6UxJ3
	aKPnl63b2MO3dnNBz3WEvvOhHd+/dJVWWqsNqiEJFFYYaQj3nW17qSpHaPKNsTUQwEzt2Vol+CB
	4h0xaqJdm+2BhHqsIZ+klgH09IfEJNKjC3LGJ2OKAQL3TG5V+ypNa06TurD6kbV6qVLf3HmVhWQ
	wKPxtltVezdz6nb3qRozION4QEkyEowG/AfyTqLBJwBfbk5ZaP9dTpUz6Uw267jBD+pA2tHFzH1
	MIutRRDMONsXE4PKOmOWsG2Zk+UfFo04A/7vKmQ++wUg7oYpOxjgrGIKC5FLCYuDAR9lZZvGwVd
	AtPsDqRbUTZlsyGaJX24hkhFB
X-Received: by 2002:a05:6122:681b:20b0:5dc:d0cb:7d80 with SMTP id 71dfb90a1353d-5eaaa910279mr300672e0c.11.1792170430454;
        Fri, 16 Oct 2026 10:07:10 -0700 (PDT)
X-Received: by 2002:a05:6122:681b:20b0:5dc:d0cb:7d80 with SMTP id 71dfb90a1353d-5eaaa910279mr300662e0c.11.1792170430029;
        Fri, 16 Oct 2026 10:07:10 -0700 (PDT)
Received: from lin-0772.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4f5b2dsm6630571f8f.31.2026.10.16.10.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 10:07:07 -0700 (PDT)
From: Atanas Filipov <atanas.filipov@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>, Bryan O'Donoghue <bod@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Gjorgji Rosikopulos <gjorgji.rosikopulos@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, atanas.filipov@oss.qualcomm.com
Subject: [PATCH v3 0/3] Use icc-clk for the SM8250 camera NoC AXI clock
Date: Fri, 16 Oct 2026 20:06:58 +0300
Message-Id: <20261016170701.1504338-1-atanas.filipov@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA2OCBTYWx0ZWRfX3lnDKW3qy1T1
 ZXTE6EWzkyg3PjKHOcfgDT7Sfe5pOmddBzt7irY/7CN1jhM3NDMoiqW33glEw9dgPxtJDGnq7DQ
 VuMyl+/m32noxKKoQUcmuRmupf/KwbdIoGGlz1XVqmOGCBU1iSQwtweXSzN1PgSv8cXnwRXNwHg
 mplUGId3azWz7dAG2OLCK6ZSRHuDWyoGIXBVctn+eJE4hTyGrMNLP+AkJzemRkAqcF6Sz9OZboc
 mrO1f7pbWhpyd7hR/jz5VcxJMqj8KvfLpvEmOc9Kggf47yUtHzF0eY6Ijc0Y+pqbhlP4XBfqVmC
 vE0O/lBqhtcp34Pi5OnAWGyg7SSkeLDfL6PnMXRbp0GPvv93k9DsleuQ2VhFTqg3mMX/dfu49z2
 vr1vHqvoTI0DKqrkTzIYtH2gqoCTMmdkQejtyF2k/TZSmv5lxJ3O/GISW2kCsrPxAm/mXwPWs+/
 wgxmhQHxWr3eDTKUB7Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA2OCBTYWx0ZWRfXy52rVyQOXbSj
 Xuo4sfrsBE4KHqPxx99wfkXhvs4PMlUiKzvk/RrsDMXb0SYInQWgvneB1C0IjaypKOtMzs/tRxy
 TwdFmvZxwjsxSO4kbqvM0ixDU/IWi0M=
X-Authority-Analysis: v=2.4 cv=PqsG/AM3 c=1 sm=1 tr=0 ts=6ad259bf cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=BpzU0WzKPDsf9x-kR2oA:9
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-ORIG-GUID: yJlhc7koDzj5DtpFXZSeRjm2okaltc1e
X-Proofpoint-GUID: yJlhc7koDzj5DtpFXZSeRjm2okaltc1e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 phishscore=0 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160068

CAM_CC_CAMNOC_AXI_CLK on SM8250 is shared by several independent
camera blocks, such as CAMSS and the JPEG encoder. Each of them needs a
minimum camera NoC AXI rate, and setting the rate of the shared clock
directly from each consumer driver means the last writer wins.

Following the review of v2, this version drops the custom CAMNOC
interconnect provider. The camera clock controller instead exports the
camera NoC AXI clock through the common icc-clk support
(qcom_cc_desc.icc_hws), as gcc-ipq9574 and gcc-ipq5210 do. Consumers
request bandwidth on one master/slave path, the interconnect core
aggregates the requests, and the clock runs at the highest requested
rate. A consumer can do this through opp-peak-kBps in its OPP table,
so the vote follows its own core clock OPP.

The icc-clk path is backed by the RCG CAM_CC_CAMNOC_AXI_CLK_SRC rather
than the branch CAM_CC_CAMNOC_AXI_CLK. icc-clk enables its clock while
the provider registers, when TITAN_TOP_GDSC is still off, and enabling
the branch at that point fails with "cam_cc_camnoc_axi_clk status stuck
at 'off'". The RCG can be enabled at probe; the branch has
CLK_SET_RATE_PARENT, so the rate ends up on the RCG either way, and each
consumer keeps enabling the branch itself after powering the GDSC.

The JPEG encoder and CAMSS will use this path; their changes will be
posted separately.

Tested on RB5 (QRB5165): the camera NoC AXI clock follows the
aggregated vote, votes drop to zero when the consumer is idle, and no
clock warnings are seen at boot.

Changes since v2:
- Drop the CAMNOC interconnect provider driver, its binding and DT
  node; export the camera NoC AXI clock through icc-clk in
  camcc-sm8250 instead (Krzysztof Kozlowski, Konrad Dybcio)
- Drop the per-master CAMNOC port IDs; icc-clk provides one
  master/slave pair per clock

Atanas Filipov (3):
  dt-bindings: clock: qcom,camcc-sm8250: add interconnect provider
  clk: qcom: camcc-sm8250: use icc-clk for camera NoC AXI clock
  arm64: dts: qcom: sm8250: add camcc interconnect cells

 .../devicetree/bindings/clock/qcom,camcc-sm8250.yaml |  4 ++++
 arch/arm64/boot/dts/qcom/sm8250.dtsi                 |  1 +
 drivers/clk/qcom/camcc-sm8250.c                      | 12 ++++++++++++
 include/dt-bindings/interconnect/qcom,sm8250.h       |  3 +++
 4 files changed, 20 insertions(+)


base-commit: b810335a0699d1810683796b0e3ffe8827ddfe6c
-- 
2.34.1

