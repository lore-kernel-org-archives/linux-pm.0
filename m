Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7B04C10FF
	for <linux-pm@vger.kernel.org>; Mon,  5 Oct 2026 15:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791214200; cv=none; b=hRfICHZvG9+5YPN1pCahpPhXFqLunORm7+CVe4ILBAdHZSYCfX0F79T4WA/WUVTzvnW6FpG44IS02zHrgQHsaIo2ZugbrbnODkop0o4qakINkEFd4ERRnxDDs0l23Oh58v1XLLWRryS9B0ODx36HIjoeLTHAuCRt9J1gYChGblg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791214200; c=relaxed/simple;
	bh=0rZMtbqx4OJH/ZRZnVtsTEJfbEO8f/Oy8uSFfMNquXQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=l3xMqZ5ZhZcTo+CXR1Kelj1WkE8NyfT0YTOTJDtpS9Rx4RC6C8AG4aGaO4SnZEUKCVpZEZSDBOj3Y7p/00iYtGsmMHt2VW7dGZqQahma5XhUfs+zQr5bmrLnntSvTeN4MR8XnX/FhVZ/662cCaK1NZeDYgC26Q0g5wV+V0KtxXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QKtfxl2B; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jyVDRvtV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QKtfxl2B";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jyVDRvtV"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695EP4G72214848
	for <linux-pm@vger.kernel.org>; Mon, 5 Oct 2026 15:29:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=rCXw8A2I1UeDoK1QSfdJN0
	EuaLobUdXeGbqPzaAGUk4=; b=QKtfxl2B5MEPWQPK/JhdHjkpmV6cfy2eE9mmrn
	umzA+SXBw+eL9JGvBdsBacHrXg5xlIu00YrZjyPijB9ZFQXcE2ZSEvY2uAvIBMO+
	qW5UKs3H6QJnNeu4EBZqDSPkOgABECXe2bhIpRxQPr326jKFF/4os+vf1lwhOQIg
	HTjkKa2wvhFEtdYjgWL2YaUjSswYMHtxubz23JYz1ObI//9RcgSdU+peaU9gwFmd
	GmIxwEQJVQkoCWUNEUFA7Ph3i+4N7WGtg89iWQQRF/v/FkDgQOGqrwRJu7j5Z9QL
	uPJkuiNvmQhVAkz9tLiD2xeNjs42ID/kjokmvjG+cH6IXLlQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h3xgytusj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2026 15:29:54 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-887e45c7063so1482528b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2026 08:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791214194; x=1791818994; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rCXw8A2I1UeDoK1QSfdJN0EuaLobUdXeGbqPzaAGUk4=;
        b=jyVDRvtV6cuhqiZ4DihK+rM7RxdLl/acsJov3KjHqNnl5YzFWyyFof12++hILSFe8A
         UOXB0GX3NUPLDbN21gtm3f19XraBbKpp7vl83Hx00/tIsPbACjAVugM7JOBy05LGZjD/
         0JcUt3q5d+r523Jt3OtLssgOyo7GMNDbAxy4GlzGtpd/fWLMMz4lROU8XPxhD3mrB/DB
         VB+X9lBPtHGo9eygoP+yl07Uz5vGnzFJZvl6cvrM4y8eNSV7SBekOX+LXVKZ96AawX6y
         8ByN+brj7+RXwv4uWihesBvLAjXtiyJM99DRqQUUkEZm7GBFd2Q6WIHVv6NAlcbCp2Fx
         Nw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791214194; x=1791818994;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rCXw8A2I1UeDoK1QSfdJN0EuaLobUdXeGbqPzaAGUk4=;
        b=SPMWBJhgxQzr3lRACktXtr5QOmgXWtXvixNFILYJMctVeT9U0ITwn12tgheF1vZ/ny
         S+Xn2e0hX/ToJXdvVLWYy+JGLm1hxUMvNsTtnn1aLBX/qdN9VBcqdQp2xKrxTStADEbS
         /tIgY1Pdx+FxQPy4wevK6HO57MgMiSt07As58ctb3OqQzEZ9H/PtEJucnRhDGUzFWcc8
         kal2rI2GKyMcW8rATV/lJeR28f98TMjcEfwU4A+3d65GxmGWbLuHHd6xvhCABz7t5u5r
         HZfexLidf2tuoW8Ra6NYF5VOwi0RcNkLtw0NZjSYc9B2gg2oj8F4YihUWvtPiUB2NGNL
         YNKg==
X-Forwarded-Encrypted: i=1; AKwUvBxAFCwHP/LUvcwKCdoOD9cqspNNkVuLDVw8+ZuHCf3htTm2XHhuHwhBqWcD+0o8cJcNC1drCwRAQw==@vger.kernel.org
X-Gm-Message-State: AFuF++mFjWbzDn3tCd1AhIz5fZUW8ZtfXZUvUu95bUpX24VdYZDDDu2r
	lSPckl7C0BcLxrweZaIbUosZTxT6wO3qJsQxUUu+1YFrjQJeRqiJsPk/+K2mp6zUxTvcp8dGfzA
	jNNZjKF8VK4QFNxHbMIsedovhEM03tHECwO8BXOrIaWBQmUiKzwPr8EPZB7CH3w==
X-Gm-Gg: AYBFou3gdd/2AsQPVtHmn33GH43KnKBFoEG9V5q4rAyi/1YOOaz/fndLsf70dTn8LZ/
	ujS3FyGrSsF4jMDVAi+xn6ti4mj+c+1TrQ8FENXWsFxC0GYoKA4HzK2YH9XufaiCEJqsiUrMfdd
	xJtdilJjDX12ooOlQpIdLqfHnweHdIsStGrwpDt9Lc6u89yf1WNHilsgxWhqgUL06N5Qodccxlz
	Sj7MFEUb0SCpECUA3crSg4rT8zQsVgJYecSUjQ3Ql6WIq2YmqUE1VaaTRbqg16lqDCbyEztn4o/
	L4gDqHqG01b+nNRBthhNoEixh7TFW6dOxtXvpNN+qDvkYND9W0IYhfjhc8cDW3pBdvkM7fHnEod
	iOHU/CotE/7SAWqxsoKhvwMoHFCHP
X-Received: by 2002:a05:6a00:f87:b0:882:2b16:c314 with SMTP id d2e1a72fcca58-88af59ca53cmr10814036b3a.52.1791214193877;
        Mon, 05 Oct 2026 08:29:53 -0700 (PDT)
X-Received: by 2002:a05:6a00:f87:b0:882:2b16:c314 with SMTP id d2e1a72fcca58-88af59ca53cmr10813997b3a.52.1791214193388;
        Mon, 05 Oct 2026 08:29:53 -0700 (PDT)
Received: from hu-mkshah-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88b0c792ce7sm3681528b3a.41.2026.10.05.08.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 08:29:52 -0700 (PDT)
From: Maulik Shah <maulik.shah@oss.qualcomm.com>
Subject: [PATCH 0/3] pmdomain: Support system-suspend-only domain idle
 states
Date: Mon, 05 Oct 2026 20:59:41 +0530
Message-Id: <20261005-s2idle_state-v1-0-3c402c66f388@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGXCw2oC/yXMQQrDIBBA0avIrCuoSAi9SgnFScZ2SjHBMaEg3
 r02Xb7F/xWEMpPAVVXIdLDwmjrsRcH8DOlBmpducMYN1hirxfHypruUUEgPfvSIGP0YEXqyZYr
 8OXe36W/Z8UVz+T2gtS915QdEcAAAAA==
X-Change-ID: 20261001-s2idle_state-6484bbbf48fb
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Maulik Shah <maulik.shah@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791214188; l=3514;
 i=maulik.shah@oss.qualcomm.com; s=20240109; h=from:subject:message-id;
 bh=0rZMtbqx4OJH/ZRZnVtsTEJfbEO8f/Oy8uSFfMNquXQ=;
 b=NXMdRjPVdkOUnvkOhaWn8LlA7qSPqn6e0LdgcJn7ZsRyAQYK7Yn9r9hCj6ymhwui4iheXc7QH
 jjC6DXrjIZLD+pRghWt75RLPFmT1twrqOr24XA5x6nWVKNoIF0CIdf+
X-Developer-Key: i=maulik.shah@oss.qualcomm.com; a=ed25519;
 pk=bd9h5FIIliUddIk8p3BlQWBlzKEQ/YW5V+fe759hTWQ=
X-Proofpoint-GUID: QIWJfn0NJiQurLl8Q78hVh17yeq1fAst
X-Proofpoint-ORIG-GUID: QIWJfn0NJiQurLl8Q78hVh17yeq1fAst
X-Authority-Analysis: v=2.4 cv=A6b5rKWG c=1 sm=1 tr=0 ts=6ac3c272 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=CdNNJpWm79WUBrjYsGcA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA2MCBTYWx0ZWRfX5YYNc1ZWrxKJ
 HzvDTLbw8xXEAdRYSmhm0O2DkY9606xV2DmVCA6Tg9m5KyEakCkJbs+7OVJ4O3QaOS4VIPpcBZO
 FoUvtSfXjhtk+hg5wgP5cB7WUHdBcVVqCUuYXJ/40aoL9x7fPm69jYOaYHkEyjei//K9O8URpWA
 RIeMO2+vJllM5aHQxZq8TzkBxNV52EYbJXU4dH6aRfV8WE0FFTbh0FS0psjDRsfh+AVoV9PHdxl
 /TrSoUk8BKz6/KvB8LYtIlG+k1lYPlAg923798xHxLrqO+73Gjw7ZcOARkqnn4BIJN7CSeO1BsL
 CWxwPS/nEhLO6wB7P3a8hM9gHxCys53UXLT1+lqE3XZrcvMn59oxetM1DUy9VhuYhaWkpMq4ezG
 75x//fGbB3qSsqPjS4JViHxMJwHFuGjo9yeCPHjX4dDT+qYKymUThdLCKc84KdC8XA3SWYCb4r4
 XudNsukMlZ+P6vY5Dwg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA2MCBTYWx0ZWRfX4LYu4j8IzAav
 yapTsp22NTnMeBmWtt4K2NpGl5Jy/135yNyWDu/jb12ZJsRkcNElzRPEpln9jt2Y2s914XpN8SL
 0F5p74GZ6MG8bsSXY8dXBf3C5QH5Xow=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_04,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050060

To achieve the deepest CPUSS low power state, which can lead to chip
rail power collapse (CxPC) on SoCs such as Lemans, Monaco and Nord, the CPU
subsystem (CPUSS) and the Safety Island (SAIL) subsystem must be powered
down together in a coordinated sequence. The Safety Island (SAIL) is a
dedicated subsystem responsible for safety-critical monitoring and control
functions, and can operate independently from the main CPU subsystem.

This transition is divided into two stages. First, firmware requests SAIL
power-down through IPC, after which SAIL waits for hardware low power
handshakes from CPUSS. If an interrupt or another condition aborts CPUSS
entry into the deepest low power mode after the IPC request, firmware must
bring SAIL back out of its low power sequence before any CPU can resume
execution in the OS. This recovery can take a second or more.

Selecting this state during opportunistic CPU idle can therefore cause
substantial wakeup delays and repeatedly interrupt SAIL operation whenever
the CPUs become idle. SAIL must remain operational during normal system
activity, so this coordinated power-down state should be reserved for
system-wide suspend such as suspend-to-idle. Shallower domain states
remain available for regular CPU and cluster idle power management.

This restriction concerns when SAIL may stop its work, in addition to the
transition latency. Idle-state latency and residency values alone do not
express that requirement. System suspend does not eliminate interrupts or
aborted entry, but provides the context in which coordinated SAIL
power-down is appropriate.

All domain idle states described in devicetree are currently considered
during the regular idle path. This limits which states can be described in
devicetree. Due to hardware constraints, some domain idle states are only
applicable to system-wide suspend, including suspend-to-idle (s2idle).

To allow these states to be described in DT and used only during system
suspend, this series adds a boolean system-state property to domain idle
state bindings and a corresponding system_state boolean in genpd. The
genpd governors skip these states during normal operation. The system
suspend selection path remains unchanged, allowing these states during
suspend while retaining the existing wakeup latency checks for s2idle.

This series applies to cluster idle states with the "domain-idle-state"
compatible string managed by genpd and its governors, but can be extended
to CPU idle states with the "arm,idle-state" compatible string if the same
restriction is needed for CPUidle states too.

Assisted-by: Codex:GPT-6
Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
---
Maulik Shah (3):
      dt-bindings: power: domain-idle-state: Add system-state
      pmdomain: Add support for system-suspend-only states
      arm64: dts: qcom: monaco-evk: Add suspend-only power collapse state

 .../devicetree/bindings/power/domain-idle-state.yaml    | 14 ++++++++++++++
 arch/arm64/boot/dts/qcom/monaco-evk.dts                 | 17 +++++++++++++++++
 drivers/pmdomain/core.c                                 |  2 ++
 drivers/pmdomain/governor.c                             |  6 ++++++
 include/linux/pm_domain.h                               |  1 +
 5 files changed, 40 insertions(+)
---
base-commit: 6c2cb8b8b843d216ab549b678a0d8831c43153e0
change-id: 20261001-s2idle_state-6484bbbf48fb

Best regards,
--  
Maulik Shah <maulik.shah@oss.qualcomm.com>

