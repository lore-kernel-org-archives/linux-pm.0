Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2DB4A5C3C
	for <linux-pm@vger.kernel.org>; Mon,  5 Oct 2026 15:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791214207; cv=none; b=d/o7urBHK7S82U5qTwpzWMHZqGcxvcuFLGWuaB2TxdoUJALMAKw7YcXs7YMS7gxDfbProJ9OkjPdnFSWfNmOnmD1qnGDPayYQ6f1jj0GtwCUFdZK9d9YVavYY4MGYJrVkCj6jkmxmDL0YKZJa5gYtlvUOCW4oeqN83HBkLIF4yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791214207; c=relaxed/simple;
	bh=uqTHWyaK670j38VSC6Vk5jxeyMj2fpngghwnVdDV3Rg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mBg/25LE8t/wt0u1GCeizWkiq8eI2br2RBXKhFcMraUPmmlZtFq9FD+WsTTdDVmfSUnCXBCZ4Ai76rOvTxmc1YzplNxAdOQ7IccQkdANm1yFaXr41XJf6hme+v2h9SKgVWwvAaJm+HZHdhprNqLx4cX2lXZGouF767ihLdt9yEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WTXUDG/I; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gBtUnzgA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WTXUDG/I";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gBtUnzgA"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695EPxRF762354
	for <linux-pm@vger.kernel.org>; Mon, 5 Oct 2026 15:30:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ivmk/W1sZczLgwsdJr+S+hTa3Q0SCc61+BfePbAr0sY=; b=WTXUDG/IkHx/8NHQ
	UrAFYQc90gAae+vBsuqmPRZ+uPD5rWfKoZhZAKdvpM/zn7m6rE4FdfUw2sHNxLA/
	00gRuNXC/7yBWcEfHWH98gwcd88cNl6G4RcewGMOzBWOuxyYK56Ipc+gBC7lsBMh
	0qI5LTgb0qlAJxm3qvOGrE/6EHBEg6StBgWG4ei58w9T376ugxVmQ+mqkjsepmuv
	nKPYanEB90p/lNI8FjukSR1TW+UwbqTpwQvc0sWICparH1IxBoWGMMIfh5OGgv4I
	8g+w+iGFUXd+bkqYMh21BaA3SVTb9vVLR/nPt5WtYSeETheCT2ohnLr4GBemA+9q
	XEwPUA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4dncg95v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2026 15:30:05 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-88d2d26a8d5so4195b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2026 08:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791214204; x=1791819004; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ivmk/W1sZczLgwsdJr+S+hTa3Q0SCc61+BfePbAr0sY=;
        b=gBtUnzgAWrZPahbXrcSyEk647TvBdISnEvn4SBd/puaBCb+l/5XDmx+s7Hjm9Sp6Tb
         nu9EpzDzcqssVLX6QotTQmzJOx2RIJh4amXzCV+aBeOzgTfDXU3T+Z8AmnImHd3K1x3R
         QnpgG2OqSgDtCHmNJ/MFThUAcCyhWmQNhOphxeGLyXHQLe2C/BKII1vvG3mJCTHo1YRU
         MXliGPSJfyQi2HZyco/DPBUKDKZ5XsmMSekeEqFJnxPSDopI+8gFJ1KnDChC7SmIEeQ4
         8lfmN+FKaNSatL32eZju3WP/rEoMpc0ju7WypZ8vGodyrs5Ygy16go7Rb0C7HyShkE+Y
         KmLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791214204; x=1791819004;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ivmk/W1sZczLgwsdJr+S+hTa3Q0SCc61+BfePbAr0sY=;
        b=GxEYnBnL1haKNwNEknX7AUps6np3qCF0rhwvq7l85MvGwyvUgjxyNxfsMp0bTHeOfe
         mcWdPrFJzmJARcpVHwDNcnS3puf/0DpODxioe2fDB0TU55VhDxWqdoCRyJMFkguE80cq
         fiSA8pkC90srTwBsvxKWBK6kxtoRWKO9jaohrcWzvmXYsWt/+Eo/UJWBqyhKCELraabL
         UfmBNWIxeI5nb+gCTw/2LrY23WDBuyB3UJpzlTJFxXBvaaUe/trsXH1sXrCK8KyY63l1
         K/yvyXRon8xGP3g0xbn5jrZnm7UbG+AHoHdllJbnIQCDFewjE+gJf+yQgOP1y9/ib6VE
         2/Sg==
X-Forwarded-Encrypted: i=1; AKwUvBxEtRhE0f10xnG2VOpXaTEqoGYiv41Jrchkj4mbk2f6N6ycNq3O7vIk4ub3+bsyjHDvBt3Va3mpnw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJvd1Hb6xweJj/n1ZNF0dtrC/EK4lqTPZmI74MerXJ4Jk1Ouc5j
	IV5OwRCZUUI5Rl5YgMUDIqqZdyJaeHSii4QTse5vM23o0/iK2T9nuDxy84QhmJ1ywALQOA91iZT
	OzEVyCFOp7bHrIAlgGN2SnhOUiGO8mCQnIa0FNNxeuqC/oDxa4BsrmNSGwArdmw==
X-Gm-Gg: AYBFou1bb8E1Ncu2xcN6TS5BSOLvyl1Dk+Gx5pHaAHBD4Y68LiJU6f4N8vfyOC7JV2+
	0T4Pe146SZQAOyGCOpOh4oOu4cuqnnCVLEpjoK2CkkBMjlMfwEVtCuE7LLERfyP5m9mADJ/rhze
	U4Zh/GKEQKblYbs1605Pd1li7CbSgdnyL7+G8cXBBP/nOeENu4JFl5/ZBlRame0HuTxH0RdgieB
	l6YpbVPqFWE9uIWy0EZkgIDop62y/r30qqCJ2QwdiC1sLWlZj6iLTZ3ffIIkwLe4B6r0hw/cAT9
	y3pd8j0phnKT2mgzDcwyVSm2STaysmrceufbJkuIp1T43yhV4RX94xuqkDRRqus601UbSPzzxGG
	vPNysww1nNA9tZdx4pNzCWnjl993e
X-Received: by 2002:a05:6a00:1399:b0:87d:b6d3:256d with SMTP id d2e1a72fcca58-887fb7b519fmr9162866b3a.2.1791214204287;
        Mon, 05 Oct 2026 08:30:04 -0700 (PDT)
X-Received: by 2002:a05:6a00:1399:b0:87d:b6d3:256d with SMTP id d2e1a72fcca58-887fb7b519fmr9162835b3a.2.1791214203805;
        Mon, 05 Oct 2026 08:30:03 -0700 (PDT)
Received: from hu-mkshah-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88b0c792ce7sm3681528b3a.41.2026.10.05.08.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 08:30:03 -0700 (PDT)
From: Maulik Shah <maulik.shah@oss.qualcomm.com>
Date: Mon, 05 Oct 2026 20:59:43 +0530
Subject: [PATCH 2/3] pmdomain: Add support for system-suspend-only states
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-s2idle_state-v1-2-3c402c66f388@oss.qualcomm.com>
References: <20261005-s2idle_state-v1-0-3c402c66f388@oss.qualcomm.com>
In-Reply-To: <20261005-s2idle_state-v1-0-3c402c66f388@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791214188; l=2399;
 i=maulik.shah@oss.qualcomm.com; s=20240109; h=from:subject:message-id;
 bh=uqTHWyaK670j38VSC6Vk5jxeyMj2fpngghwnVdDV3Rg=;
 b=DS9eQ9mrSjJ6h49oPLT0m/ne5pIR7xiz2qq0Bdsl7rVRRBxBjDV695swIh0H5xqpJl4eMqzQ3
 wmWtvAaaEDsAX5dYshhcJIbeEZlZmzMgMV9ocFo5rTKXRY+SIbw5a4b
X-Developer-Key: i=maulik.shah@oss.qualcomm.com; a=ed25519;
 pk=bd9h5FIIliUddIk8p3BlQWBlzKEQ/YW5V+fe759hTWQ=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA2MCBTYWx0ZWRfX5JXlM7KBxoty
 r8Bt3RHH7WPjbiE/cpO6IvSKwHYO3WEy3wjFpyyDtTIyate5ECkaYMeyrSt4fHQ6ueSt/XCqAqW
 QFpZTEdFfX6Vy/V5hrNWYZ7fGshabiM=
X-Authority-Analysis: v=2.4 cv=Vdxir1p9 c=1 sm=1 tr=0 ts=6ac3c27d cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=XIWP2vTyFktR7zITobcA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: FXIwdMl09SDnbB2I4Zh_kZ4RxHjX2rKc
X-Proofpoint-ORIG-GUID: FXIwdMl09SDnbB2I4Zh_kZ4RxHjX2rKc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA2MCBTYWx0ZWRfX9AYLVACOAHzU
 afejjOCq9vbgtS61wWuMTKTh2UrLRkYaid+HrGDysXFsrWjma+CvjBtapI+bQUmm246uu3yV3H8
 0arbRoFyp2fHOvBmRPLIQXwYUNnoeus960ZkQk0d/QziTsmMsgJ6iJuJi/iB6WKdfwR/2VMhlol
 3NRGRhaWB/TpsmFRTYdE0ZI+ONjRaBxODyZLkOaPMQrbZ80yUfS0nV5nwXNu/KyL0jwiruIyMAf
 QlyQ1gSCI3niznlwaQ0cqhaXtUcaH53NRwmFFhKknPzOnOU16ZBllTwDSWqcec6IWznV7CwcMhs
 zLSVb65FH05b64D7m4xVLuXOaRhjHmpybk+Iff+BMBpF6QzyoimFIihJ86Gw5jrZJbjm9mdF+XJ
 lI0BWBU85HVCf2Lm7FKDS11y8iY1VFqXEbiKUB/h41HKCG7lWOSjCl1GDtGG6jKsf+IQdXP2zmV
 o9rhJfHHnkY/FeF6X1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_04,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050060

Some domain idle states require system-wide coordination and should not be
selected during regular CPU idle. However those states remain valid for
system-wide suspend like s2idle.

Add a per-state system_state boolean and populate it from the system-state
property. Make the genpd governor skip these states during CPU idle. Leave
the system wide suspend path unchanged so s2idle can select them.

Assisted-by: Codex:GPT-6
Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
---
 drivers/pmdomain/core.c     | 2 ++
 drivers/pmdomain/governor.c | 6 ++++++
 include/linux/pm_domain.h   | 1 +
 3 files changed, 9 insertions(+)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 964e44c2f78f..288c0deb2340 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -3701,6 +3701,8 @@ static int genpd_parse_state(struct genpd_power_state *genpd_state,
 	if (!err)
 		genpd_state->residency_ns = 1000LL * residency;
 
+	genpd_state->system_state = of_property_read_bool(state_node, "system-state");
+
 	err = of_property_read_string(state_node, "idle-state-name",
 				      &genpd_state->name);
 	if (err)
diff --git a/drivers/pmdomain/governor.c b/drivers/pmdomain/governor.c
index 38bba24ec26e..7684f9eecf85 100644
--- a/drivers/pmdomain/governor.c
+++ b/drivers/pmdomain/governor.c
@@ -185,6 +185,9 @@ static bool __default_power_down_ok(struct dev_pm_domain *pd,
 	s64 min_off_time_ns;
 	s64 off_on_time_ns;
 
+	if (genpd->states[state].system_state)
+		return false;
+
 	off_on_time_ns = genpd->states[state].power_off_latency_ns +
 		genpd->states[state].power_on_latency_ns;
 
@@ -407,6 +410,9 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 	 */
 	i = genpd->state_idx;
 	do {
+		if (genpd->states[i].system_state)
+			continue;
+
 		if ((idle_duration_ns >= (genpd->states[i].residency_ns +
 		    genpd->states[i].power_off_latency_ns)) &&
 		    (global_constraint >= (genpd->states[i].power_on_latency_ns +
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 14e0e346c610..d9b3e67042e5 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -188,6 +188,7 @@ struct genpd_power_state {
 	s64 power_off_latency_ns;
 	s64 power_on_latency_ns;
 	s64 residency_ns;
+	bool system_state;
 	u64 usage;
 	u64 rejected;
 	u64 above;

-- 
2.43.0

