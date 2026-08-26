Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32338361DA7
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 13:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787752548; cv=none; b=QbYbI3BsnyV/PBHNy/o6e3wiW9LYyitI0qm6k5vg94+r3T2UBIhmu9ZpAq9Myo/AmTrsbj9rPiYawocLxBKFnQD9dePWYHB3QpcpzWr/kDwTkIDFVlKvx2+Y/IB64F4qgNQFmKsdABjWKo57sLLVfo53jaPMbo6NVF+pcnZCcJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787752548; c=relaxed/simple;
	bh=5wPjaxtMp1EHMGKTxlI06Ij5iAmSt2E0j+sKRMrOd5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WCYgQFKsShECc5uU1oEmIx3XMJAYNoF9vC8pxvLtFbLENnlGPMqpnLadPOScsKTOUPtS2sDAM+U6BVI7dJitdmVLVyCiNXnU4SmfOl5kaeomj8P+DY5NTVwglhndarUqtyWed3Q4hYgeehAYAaYFhVewSH+gZYRNz5Aq34ucXXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UrBvDCsE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X8cfmfJX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UrBvDCsE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X8cfmfJX"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QDHbP51617701
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 13:55:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=UQO1dGe3cg8EAKayarH9DjqZHYpySqBTnoI
	XACsELTw=; b=UrBvDCsEQlaa8965zjpCp7JLorVgE23f6gC/PYVNep7GlZCGFiS
	2KkMw4aba9FsBzQ0aFqGODeJgwY56b1cXrYbZpNB9/+CE4RThAN6/x1NqOCb5WQV
	9KdCCoSzWZfEC920A1qhlIa8andQPtGGmLRtMawXT3zKnI7l2xeT1SLbMZHPTlJp
	wvVD8vBftmx3tWt+Z9uCqFBudz9Bq088x5ur+ZW08GvpxipnNfMBHwJsdRJ5hR0R
	n4lEJQCyl0fKFcefLlVpw9nUku7JKB5NTQ76WmJBCxvM+2Tya5EmVuTuqW89Vd/w
	9cbm5fAgo6WjogcUA4y/bg5sSIiOjEjt32g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga0wbr53g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 13:55:46 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38dc085b0a7so2047737a91.2
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 06:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787752545; x=1788357345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UQO1dGe3cg8EAKayarH9DjqZHYpySqBTnoIXACsELTw=;
        b=X8cfmfJXtr6EOlxNYNX195IzYsC9vD0NyCLGJGISOmBdGYrMTSTQ9wyf4mU8h5+px5
         5cmOBCerONeLYkk3XPx/lQhUZwoQXoH/bJ9+YYhJ+kNbOsDv3Glwkl5TY1qU79kn2xjR
         77a/RjmtCMfszlmcgAVDbEs0NanbM1ue+ZrLtNGW1/mdZ4ApQZSEwur64qWYEHLhcrSB
         ml6u1hJrr3n28dnYcVFJdwUAytCepz8kVa3MEaqZFvHvEdN0tn+EpBCI72AjqhG6PEMr
         iSMYf6keu3QNLIe6rA9Ih35oTdUTfr9/TlileHTb1Z7/xraUn+c8cs4GuJ3DlMfdaNNI
         TAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787752545; x=1788357345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UQO1dGe3cg8EAKayarH9DjqZHYpySqBTnoIXACsELTw=;
        b=VQtC4Idl+Zck6Xb1lhlbP94+aATvx7Zt06z36BBlRecveY1lQKp7M1TL+u4i8jmso3
         V5NzNLMxuGjhy/YG2r7aIuOuRlD+NICCDrro3wZLms/Oz4YPz3jcLTgrI8zgZpoV9PYw
         8s/+8I3porKyeFO0i0YkjdaR0DzMI9gbDK1wUniSEBuU+E91zcv8GTLXENhrb0pRvWkR
         JAIUhYTK1GIBwDBNeoN79gegcOqk01KHkQAZNj310lEQR3q6SiAjgCKbIaz/V5Pzj8tP
         PURgFEV7nMSd23kQrQEUcHoJ2ggGLUZ93+oE2Q4qUrHJlkacouAug/1Q4O/9i10aN55k
         gg8Q==
X-Forwarded-Encrypted: i=1; AHgh+RoO4pP+sfkaIYUHlCSTONTuDqP3vW8cswcEJM82vHhvQcdBhW8UASCH/EZdNEli8kbiFIOWZGxVbA==@vger.kernel.org
X-Gm-Message-State: AFuF++m7OciXgqcv+052zgaYLDkEANANzOAWh43PHAhCi3yE9C7NmLYZ
	OEKPVB0qrzGEbnnPTF7mBD9wOEyNjPfOWNfvNb8jrrGr4ZKJ4JtjYQbJE60KVHaqH0y/Mf2uCNw
	O84IMXGjAkba1FHeXyiXGCBK6XTkQIujvIvueN6JPo0FXEYpJlKfFT3mSDomKpxFBnkOG9L5B
X-Gm-Gg: AR+sD111xQdk7+xTSe1WhLQ8kNtQdIvRgHDVvSa2fR5ipsw2Dsoz3u7xJiBw0IQlJMW
	CZiAAPDWJMjOlIkYQ1s7pgAKbBkjgvxuamGBoVazRzFjfFskssIn1iXApS2jHAEm5FAYLzB6pvz
	epFKrDeqoLZl4ySwXreM2w5t/u/mQakAwem/edELSUF6+tJyUK5bTsseLGD0Zn7dbI26Gila9HC
	FQUHyJZkyAfxGysF6wx0Tuxj6WHG9ihvki05aSp9QIkQyE+O4J20NpRXMrkT7lhddvKuqF/+0xO
	an9ymkruLU2mjjGo34GZa1e4zDz8IkjKNubdL2vIcs++3wla+BshG618G1RlZSGsTOKpf+/236I
	bf2mm4bZYDNw31+Z5jRLYq/gtKyx+61UZtSR8GT6+EeX44pWXHKrWP38DYhM3
X-Received: by 2002:a17:90a:d2cb:b0:36a:5d1f:7b6 with SMTP id 98e67ed59e1d1-3966d36df78mr15644628a91.2.1787752545460;
        Wed, 26 Aug 2026 06:55:45 -0700 (PDT)
X-Received: by 2002:a17:90a:d2cb:b0:36a:5d1f:7b6 with SMTP id 98e67ed59e1d1-3966d36df78mr15644505a91.2.1787752544964;
        Wed, 26 Aug 2026 06:55:44 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39668a573a1sm4347911a91.14.2026.08.26.06.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 06:55:44 -0700 (PDT)
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Anurag Pateriya <anurag.pateriya@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>
Subject: [PATCH v2 0/2] Add NMXC power domain for Nord SoC
Date: Wed, 26 Aug 2026 21:54:52 +0800
Message-ID: <20260826135454.658615-1-shengchao.guo@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: bphJFGFknbEN-JgUYSVsJ-p5CSLvLl1R
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDExNSBTYWx0ZWRfXzg8upi9zFg/w
 Cmy9W9tUewDPIrhuCAXoTmHwD7fHaW/pOwgJwizY+ewwD15a6N2aO6oJP1vdO6Jss4pyJPWfMF8
 PLh5RK1GCUyluzfr0UN85RSgUP7yvXU=
X-Proofpoint-GUID: bphJFGFknbEN-JgUYSVsJ-p5CSLvLl1R
X-Authority-Analysis: v=2.4 cv=SoCgLvO0 c=1 sm=1 tr=0 ts=6a8ef062 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Y7D3pg133TmPf0Y34y0A:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDExNSBTYWx0ZWRfXww/oAm5NaU3B
 JmS1lMMT/L9YVUeYKvJw5N8FwCVK1PorRhUSV4oa0htojVsXDG75kjCMUs9hTcgAGv+Iw4w9mp6
 wNqiziok0ScKQuJeNSPyNc0iu06QC9eeaHtaFrTV1Gx+xKBNBJQQGTXbo4eJDQLK9CiX38AYoe3
 GHeJRy97+6493iF65I+FcbFMNDcFZvdJYDhnWGIScMYhbyGmUztowfHKO0MWrAe3Hgs0MFhMxs3
 2YB/26mlNngiiovUp7w1t9FNOBd8+QX7BCH6EbLVn9KhudBsKg6bmWdk+5cvBeEQ/eZ6KAR6wHe
 as+sLoOzjJw+/3escdwrCR9CdsCv1yUpy67HE797QhLol7qQtxxKMlaw1pcSqLYhlh/vIEri41c
 v0xX4S9DHpvr5civuSlFexo5d3Nay6P2XxzxNt6HfvYGq0BvbYxveNC5t/d8MUTfh6uEM8MY8T2
 uJbK+RE1lYThTq3Lyqw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260115

The Nord CDSP subsystems do not take their memory rail from the shared
MX rail like all other Qualcomm SoCs, but from a dedicated NMXC RPMh
resource. Add the nmxc.lvl RPMh resource and register it in the Nord
power domain table.

Changes for v2:
- Drop remoteproc changes since "mx" of remoteproc is just the name of
  memory rail input which can be wired up to NMXC power domain in DT
- Link to v1: https://lore.kernel.org/all/20260826102746.633076-1-shengchao.guo@oss.qualcomm.com/

Anurag Pateriya (2):
  dt-bindings: power: qcom,rpmhpd: Add NMXC power domain index
  pmdomain: qcom: rpmhpd: Add NMXC power domain for Nord

 drivers/pmdomain/qcom/rpmhpd.c          | 6 ++++++
 include/dt-bindings/power/qcom,rpmhpd.h | 1 +
 2 files changed, 7 insertions(+)

-- 
2.43.0

