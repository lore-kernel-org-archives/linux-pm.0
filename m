Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2F248551F
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 16:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787158577; cv=none; b=klYtCQtL3fHcyZK4lTmtfO1IPc06dvD/xHY9a2/FqaodBbhNTm5I5UiumFh/jBEE7dGSps8+P8MzfTct56C1jBsLl5lbEvuhF3xBFdzoMkycviPdZfdtUwRqHJ5ONiLtL8balyIn1bg4WhQtxnx6jiEmwC/E4BR+lK6cNzpuJnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787158577; c=relaxed/simple;
	bh=pX3Ie4Ya62N3/oqBVmuHKdoA0H3h7jQSu5Qb2mHmDDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O8ln66muWVa6Ndokbo7OETRlfYuGEWuVsfH3wP9ub0UiFiaT/tysSYLawYvJVcDaWvye46/dKsF6jTfU6iehLAO/MZ8SyTvaxbpq8L+IC+SzlN82tJ0lc6DqhTwLz3e6f5piIlSVsa8yvBUUh/Lu+yNGX2Cne8ieJYtPnZjnJCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AZb+hGXF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ab4lzU+c; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AZb+hGXF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ab4lzU+c"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JF2dmZ1174023
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 16:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Bjo5GuHFt7lUxCfOcsl2N+PWYjEn1hAmOiV
	rUjXzaUM=; b=AZb+hGXF6E8dJm+i3ozN4oS5Zz39frXk9SoKJYg6q/MOi9ItbNt
	GvjpKX4lbPgnxLeXjrD2nSpUHJ++WM1tjl43NuOr67lBzVQvFY87zgW4Ur93igmg
	BPGniChIbRDfcqjwWj6DrgY/B1sO0LXpA+Zt/mIuufOb+sDYJLGVzqZ6UNODeGsP
	3Id6M+lazzCNqahsOv9aw5a6XaMLhqHyoduyr6fyu0zXUYU27ip8fg4tHpkZKBRr
	KjyJK32B48YOyF0w2j9okva0ss5lFuEHgwPJNpNwUAiVJGzMLkBG6SVt7wOjvblQ
	DH3cWh4wHDA1Cs8XGEOjdcqprCmkYCn3Xbw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5esj0kxk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 16:56:15 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93494527488so221697585a.3
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 09:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787158574; x=1787763374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bjo5GuHFt7lUxCfOcsl2N+PWYjEn1hAmOiVrUjXzaUM=;
        b=ab4lzU+cXpCUzVq4bWsgl2BUyfcCUT7x3z0nRPfCBlCxlxa1YvGxNhZtzxpM4nxQVk
         GLEKKfPmiWZKahNAlqX0xAetYPna5uwp4umPIRrm1J0i0MqyfiqX47MAJ7w1OnK4w2JA
         EZ5rp82hlpATu/F2WGKWLP6v/T++8NySYuXccHW1avu5Zj0KKKYADKN6HCS63Ei28THQ
         5xHZtbbZfTxEB+jnmOeI63dNBAQ0ewA/Y/9AicDND6AZyQvFpL8I0mKRIevCAHshQxvM
         I34jJJYwy9y4/IcpC5sPa4egw0M2KhzUHKR4jXZTVXwj+WJTTbLjN5lHA1n7Wb8zS0Sk
         /2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787158574; x=1787763374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bjo5GuHFt7lUxCfOcsl2N+PWYjEn1hAmOiVrUjXzaUM=;
        b=gS2puxEQB5KtBYXxwReR6leYdW49e05+U5cRQTj04T5PyPOWBmZ1vfdOnzdcm3QL1Q
         S4LnE263OvpompytOAq9w1klJA7MVpuOhTohrPBfFGejf+WGJx0OXfIQJJlCGceHSIKd
         NUF7XGJkkwMYTNWj0fVDiXztaDFlhK6I08u16cZTk+GzNoZKIG6mWjehEtOrWKx03HVA
         5K4U1X2erjbjEII41cuAOX3zjnhuRfPD4wuILJPXn93yPr6l0jKVRMxOrHhf0Y0qCDkj
         wvnco8JbeMaj2C2Sv4hPWrWphPVmdhb9B6axr9G0z5vu++uglmnaalta17V5q6z96PI8
         Bw1A==
X-Forwarded-Encrypted: i=1; AHgh+RoX2xmKTP5n+RiN2iZII2YEkRiObL6zlh972cuXI3doISHZtHQQ2EtgOkfD4ddtWJzWrdN+hMuIfg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz74ft9IF0lvSjTxVCWHN0TnY6dVUoO8u6D4AX1QQFeNRXf4Jxa
	Do66Anp8nMmkT4FFepL39b877Di/FJgrAyp/hS6SqJlfBao1XoHM0hE51f/htNhJwACOB1lYJOt
	v91i42XAtd9sBluytlyKrWmgI4Gd0EIPAD7oDMPGMf5loEkMUY3MOj9xOMWiX2Q==
X-Gm-Gg: AR+sD11urUn96Re8JqDNZkcb6/Mm/d7FjygVFbcmRdZXHU5vdX3D/VW+Z80EMf+W5/6
	iOSA85QUX7eiP7LVpyk+5zrlWOftLQJnRmmTE3pF1fgxhL6yQkugxQ/IKDRFgE7KcPAvoke+HLI
	gRAzbtDw+HiTQqiXQrAQ2qos2pQOhA3/DotfKqHt6s4qr0vIymXhW+ptF1K9UpnIlOIwlrMdkJe
	LFXv9KmTDRueu8N4K8HLek+/FWekFad29dnU+qVOqahME9ARL7cuTpBxMkkDJsYZD2BBFDTAxKU
	thF5aq0FldHvhnb5GOZcbU+qPkVytw31sQjHU0Aw5sa/TxMD1/f0DBQHAngQ6qbm8BiShtu6fVZ
	eNALpuhdmtL8WSB+5KHfKjLMc54+3
X-Received: by 2002:a05:620a:2608:b0:936:7967:7955 with SMTP id af79cd13be357-9371e676bf5mr667306685a.21.1787158574014;
        Wed, 19 Aug 2026 09:56:14 -0700 (PDT)
X-Received: by 2002:a05:620a:2608:b0:936:7967:7955 with SMTP id af79cd13be357-9371e676bf5mr667301285a.21.1787158573548;
        Wed, 19 Aug 2026 09:56:13 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:2e33:a343:bae0:905b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b1441c78sm6952317f8f.2.2026.08.19.09.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 09:56:12 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: daniel.lezcano@oss.qualcomm.com, rafael@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v1 0/4] powercap: dtpm: Use generic hierarchy helpers and add RK3588 support
Date: Wed, 19 Aug 2026 18:56:01 +0200
Message-ID: <20260819165605.1398880-1-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: rPSGvY8k3rRJyme7ipbeaIik4hC_cSlH
X-Authority-Analysis: v=2.4 cv=EaL4hvmC c=1 sm=1 tr=0 ts=6a85e02f cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=LySqVBEvZzPPvKoaIr0A:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEzMSBTYWx0ZWRfX6Y+fjiLL1tnY
 4DYi4lEoO8Fs/4AwQcCI63srzEsO0jzzHBD40TOXgDqhi0gmPRGvcwi9FG3fCrDfxk+uzoz0SF+
 l1SidJ5OCTp9hx8ZRCUEM0KOmtvypM9BRDJouVYDVnS91jNHcy4zg+D4sNl1utw0TB5LuVsY+eZ
 6QTtXFl3IAUbVK+Ox3aermSPDta6IG+JhJfjTvmEEMZGZpld5soIjH122WDYLn01YtncWekczQT
 rCG0SSHTbnl8cqrdeJkOf4fRmgwVRwVE773UreYk44EqWfCV8HGrwbD9lbiffBI22VoLv1x9qlb
 1+qaYnTO5cS4c2zBvUPqIUWg6YJe+AWSHA3ZMWW3MXza+a1cgIAwSxvISvEClRDM+zt0l0n3RCY
 VjVcLx+FEaBRezjpyV5WjsLKArSFdhvm7PmQLxolsMLIRLerWrmy/UZErDPXpSIrsIbFPzUz2aL
 IQ97+hOBrAAEJO46Ixg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEzMSBTYWx0ZWRfX11cwgCmxxYDC
 iq2B6aF55jW921TO2cnxs5Zps5t0yOCvaMWkw2QSlxlDMPbCrBmbnQQuyKl+emtmpBo1nDhRYqL
 EC6gOHYXcWacn7ECtf9MH8CCsuvwSeM=
X-Proofpoint-ORIG-GUID: rPSGvY8k3rRJyme7ipbeaIik4hC_cSlH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190131

This series builds on top of the previously submitted powercap series
introducing the generic powercap hierarchy infrastructure.

DTPM currently implements its own hierarchy creation logic to walk a
platform-provided description, create the corresponding DTPM zones and
tear them down. With the generic powercap hierarchy infrastructure in
place, this logic can be shared at the powercap core level.

Convert DTPM to use the generic powercap hierarchy helpers. The platform
hierarchy is duplicated before use and powercap_hierarchy_create() and
powercap_hierarchy_destroy() take care of its lifetime and traversal.
DTPM provides the callbacks responsible for creating and destroying the
DTPM instance associated with each powercap node. The CPU and devfreq
backends are adjusted accordingly.

As a preparation for this conversion, simplify the existing RK3399
description. The CPU backend creates one DTPM zone per cpufreq policy,
so describing every CPU belonging to the same policy results in
duplicate zones. Keep only one CPU node for each RK3399 cpufreq policy.

The Rockchip virtual node descriptor is then made SoC-independent so it
can be reused by other Rockchip platforms.

Finally, add an RK3588 hierarchy. The RK3588 has three cpufreq policies,
represented by cpu@0, cpu@400 and cpu@600. These three CPU domains are
grouped below a virtual package node:

rk3588
  `-- package
    |-- cpu0-cpufreq
    |-- cpu4-cpufreq
    `-- cpu6-cpufreq

This series depends on:

Link: https://lore.kernel.org/all/20260806110159.69690-1-daniel.lezcano@oss.qualcomm.com/

Daniel Lezcano (4):
powercap: dtpm: Remove duplicate RK3399 CPU hierarchy nodes
powercap: dtpm: Use generic powercap hierarchy helpers
powercap: dtpm: Rename Rockchip virtual node descriptor
powercap: dtpm: Add RK3588 hierarchy

--
2.43.0

Daniel Lezcano (4):
  powercap: dtpm: Remove duplicate RK3399 CPU hierarchy nodes
  powercap: dtpm: Use generic powercap hierarchy helpers
  powercap: dtpm: Rename Rockchip virtual node descriptor
  powercap: dtpm: Add RK3588 hierarchy

 drivers/powercap/dtpm.c         | 165 ++++++++++++++------------------
 drivers/powercap/dtpm_cpu.c     |  22 ++---
 drivers/powercap/dtpm_devfreq.c |  22 +++--
 drivers/soc/rockchip/dtpm.c     | 127 ++++++++++++++++++------
 include/linux/dtpm.h            |   5 +-
 5 files changed, 195 insertions(+), 146 deletions(-)

-- 
2.43.0

