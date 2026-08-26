Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359A83B840F
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 10:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787740097; cv=none; b=nSQXo0dVo8Dv8I1YB5At80HL5G+X50kgTikGPhjPFm1hLDLlzcB3qYXjJ3Vt21TqN5dxyp0MCUhXZ2SJrhCeaX7LCWzUPjlUcsp8jmHapHZquJdOaggVnrMFjr/gG97TeDh1XbZvmJpn4PPQMiM4AKIKr1lFsqLzQNLAYNIpzog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787740097; c=relaxed/simple;
	bh=S2k3ZhNSQ/vLOZXXH+Z+7+1AZTJCES9Wlt1Lk5LN4Xw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pph/sqcFWVyQiryUjCBj/Q5uM+75mCKzOU9077HFNq2lGT01/rVckmo+WPDXo+DSxKeO6hWoZkLkkpghtvkhtjFqUfivxhQ3n99VYyS/Q9tDKLM6K6nwNX7uQeP19B5gRmSOIa9aSkf2acixmEBRbN2pLhETpKs84bDNOgmqB6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D6/gitVG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OXR1/ioh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D6/gitVG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OXR1/ioh"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QAGf0H121453
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 10:28:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=97J5N0260/ppHZA5UMH73C5bAHn5Gr8e3Sb
	2NHrXZtM=; b=D6/gitVGtb7mpL83F+9JpDzq1hM7XGt0vcGyYVFFcZe+EhS363I
	Ao/R1azAjetnvAtLq3WaFRYLHum3reSuzKSWfXvBrhon+C341JfIY72ZuvE/NwTH
	5xOQs7rThOdDGw4QvZafwsxynbK4igUXRdBFrc5wzymniI1PfBpNNsVGi7vx5Apm
	Jx92WoNu+YG7sm3VefmW3exv32HgzkblynVPpZ+TtqOCVxf31mwfTMwGjSIwXCCb
	juYKrP00iT2Fgd5uD5bkbw68hlSUAWzEjMiTGODgRLcOQ98jU+RYfo4TgKXpWstz
	RQ40G1Inqq5B13HBlRgvuDjdX/h2zt8nBHQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9smx9aq9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 10:28:14 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb11535e6a1so1069319a12.0
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 03:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787740094; x=1788344894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=97J5N0260/ppHZA5UMH73C5bAHn5Gr8e3Sb2NHrXZtM=;
        b=OXR1/iohNID6SwYSryqioPu+5K0i6fe3VPmEyAFPs9U9xIg1+JJnTJz4YcHgcDZBPY
         U/IUep2lt3BC0GRJqmLH/qB13Nke7Iap/X2Kmg6rIZidspV/M4AjC7asEt3ib1psY34z
         /61nNne6nknbOzjixlRtes+uPhKyI3CaPh4cMjsXZlpU26sn7ViPlZO1EP1+1RBedFxw
         P7Nbo+pY0nIMGYGKEDvxiVTpl1ERnJU0wxrdMmngxU3Z8/guDRr9eQ6qfxUsfQeHczdv
         9aYcHT3zGKElFzL5SuYGGzO6W16A4rWzdysg2xH3ZzuxNQyyfd2/0TFGyF7uje3Gzskl
         efxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787740094; x=1788344894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=97J5N0260/ppHZA5UMH73C5bAHn5Gr8e3Sb2NHrXZtM=;
        b=lBdavWM+8uYl6k+bNS/KLK/PZ/dAw0cgN5xzAjb1IQC7qNu40Jp97q8g+Dk6OhQhSG
         XvYHrJlH+XJSQzdfEj5smNHnZcqyLvJw06svXNiKgwp6l5hqq8wnwF5Vj/Pz7SUr8nng
         BqypSmfjGLmophQwSKnR1lCd7WeXH7NAJcS/JRnLERW3doDhtPk2hCws9cHGxbm8VckD
         +u2ndbneLSWUHv69qd5IfA4XR7uI2taoni4oCKBlRYAWT/gtsq5hvSSRU5SbiG4Ej5SY
         vThFFDFIU7CHwop1mN5oi8FlgsiA89Ug+ucUdIqrQNFfR68PIw0Ofo1b3E2hUnpWgZQq
         WVMg==
X-Forwarded-Encrypted: i=1; AHgh+RqrGD1caFelq4HwsxSupDbxasC4sU7F0Jy5e+eviySDFSWN+wNtVeimQv9qqiEJpc+hQvM/XS5gpQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mpDu2K0d8B6sGyuuru83ncsJJqzI/ZZIViJUMMGql7yBwklyWb
	5ZMcL/7qpDMJA2hFxVgKYw9SYD/tB0gLoORWAMP0O5KlKiQRFzk5rdJwotQtgMAzBKbApcWO+Tw
	9JgmcsTpQAA/T737EXqKoJRIIGgmrVRAqmwxLmr3Q2zKOYVPQrbKjjKv+LgTJkQ==
X-Gm-Gg: AR+sD12ry4jZ5Ll3PGr2Lm3ttS3E+KWxKcytgh+9MtOXGiAWOfmd75H8fzWfxKD/+oT
	FJQN0YAYtv9nj70PXC//8lBtKDCsQZ5t+rYGiICIzwv/Aggx7lbCvJwKrKFpGsQkIpjSDH+qi2f
	b5c+B8/9eKSZygs23dRTG6MJXruCxyFV8kjaZCV8bJo1oGHgZ4M5V1UBBbNbM6cthRZPu1wiLzb
	avIKPpa+UcCAjnj+cg7D69wvBcqomCnXc+eRuzflxRUviPtGzSHJycrOti34Gc/8UvcnDkroHrM
	jVsioVBnsJzLuqI6dJQgrZxby7q6+RooUpvQMrqlHTUc4goWVIvFf57mDGqqHvIzGw+byXZizf0
	RqSBIhM9lgPRKwb5f8tKLgT5nAcIGeJVOGPF3hcz7O9rSMOgiP/l2sr7RFKLB
X-Received: by 2002:a05:6a21:a382:b0:3c8:f342:132c with SMTP id adf61e73a8af0-3cf83b22623mr11070437637.11.1787740093734;
        Wed, 26 Aug 2026 03:28:13 -0700 (PDT)
X-Received: by 2002:a05:6a21:a382:b0:3c8:f342:132c with SMTP id adf61e73a8af0-3cf83b22623mr11070346637.11.1787740093281;
        Wed, 26 Aug 2026 03:28:13 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d60c291sm12935669eec.6.2026.08.26.03.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 03:28:12 -0700 (PDT)
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Anurag Pateriya <anurag.pateriya@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>
Subject: [PATCH 0/4] Switch Nord CDSPs onto NMXC power domain
Date: Wed, 26 Aug 2026 18:27:42 +0800
Message-ID: <20260826102746.633076-1-shengchao.guo@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=O/oJeh9W c=1 sm=1 tr=0 ts=6a8ebfbe cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=KT9lYBbIbgBItZ0vMVcA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: rZN1rMVa2fF4-4F5EoaJ4E_1QmJZl-mt
X-Proofpoint-ORIG-GUID: rZN1rMVa2fF4-4F5EoaJ4E_1QmJZl-mt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA4NyBTYWx0ZWRfX4ehguTd0M21B
 tCm0sAarkhC4nfiNc+HgffjRntQRAyAhyyNI7wZ7bCmHTEqxWhMYJaR4SUMrjBttWceX8NIsZc4
 uny3gXu9ndgEbQ1P8aEbRm3guYeCJqGj2Dwncgk5b3R1T5JG4lq67oAB9DtugM4u8pSisCN4kJ+
 gUQp7XMhPSb5fdZbx2dYv6bHl+3mEGom6c4xqE6P02gPTlIHopCDa/MX9PAptPJvkaYhPffKVF2
 6k68NBToUOxDw2tjhQp82GPoBE3wgwL6lYiC5HllFjv3E/tC02ZE1uG383xCQ2rUz45eY26JS6o
 G1MSq5tNABtqyDIl2WqSDpTnb57+GRRsEpAnnX/fj5oi8bUO0ILMz50jLKgr3wbyB3kWto7/5WW
 bwPvaWFzYz/Z3y+2JW3PouQDjTCpLVBlxS47v4thSm2OFKbw8WgeXQ1ZTSzct3pK0vBmbPMqyAj
 bt5e+X+0A3hpVzW+Lhg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA4NyBTYWx0ZWRfXzmUOnyHch15n
 /HWhWiExjZdyD9ieqKbigryFvP6dHqwjVbS2t+88BwIp8wZReElTjTxwmAeF3umB+LveMp5vmvX
 rqfH6NGabkEZA32jDPf/EpQInq6haQ0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260087

The Nord CDSP subsystems do not take their memory rail from the shared
MX rail like all other Qualcomm SoCs, but from a dedicated NMXC RPMh
resource. Nord's initial PAS support was merged with "mx" in the proxy
power domain list, which leaves CDSPs relying on other components to
vote on NMXC rail.

The first two pmdomain patches add the NMXC domain index and register
the nmxc.lvl resource in the Nord rpmhpd table. The other two remoteproc
patches correct the Nord PAS binding and driver to name "nmxc" instead of
"mx" for CDSPs, so that the right rail is held during PAS authentication
and boot.

The pmdomain and remoteproc changes can be applied independently -- only
the power domain name string changes on the remoteproc side, so there is
no build dependency between the two halves. I send them as one series to
demonstrate this is fixing "one problem". I can split if needed.

There is no ABI concern: no in-tree device tree references the Nord CDSPs
yet.

Anurag Pateriya (3):
  dt-bindings: power: qcom,rpmhpd: Add NMXC power domain index
  pmdomain: qcom: rpmhpd: Add NMXC power domain for Nord
  remoteproc: qcom: pas: Switch Nord CDSPs from MX to NMXC

Shawn Guo (1):
  dt-bindings: remoteproc: qcom,nord-pas: Switch CDSPs to NMXC rail

 .../bindings/remoteproc/qcom,nord-pas.yaml    | 28 +++++++++++--------
 drivers/pmdomain/qcom/rpmhpd.c                |  6 ++++
 drivers/remoteproc/qcom_q6v5_pas.c            |  8 +++---
 include/dt-bindings/power/qcom,rpmhpd.h       |  1 +
 4 files changed, 27 insertions(+), 16 deletions(-)

-- 
2.43.0

