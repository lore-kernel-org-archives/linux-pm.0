Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F78D23D7E6
	for <linux-pm@vger.kernel.org>; Mon,  1 Jun 2026 06:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780295890; cv=none; b=rePUQb3Qo9NftYUHRdzIgVuy9ZszwDTmDY4sKTMTAaGhRUrgV2lh9ps5K0+m+7VNiqtf+2iru1BMPRViWuVTw7eRtn4Vypwo9R3e5k4M/9Jt7/y8r8853NW+DfQ9v11nOxzNc96aKKrryFNseoHjCf7w1eS8GaRI/mQ8K8cDQaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780295890; c=relaxed/simple;
	bh=NxsmgpXqtgg+7aG586diJbRcKlS0Itgqio//rv0yLKs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lQXGQ3jMitxbtGiWmERJUZA9WRDdO5YFQmK9HsFAUJU5u6gagDn8mJQHca9FzyJMj7p/kJZp0QW8YCB429jvDFNczjS7in7gFdT0snV5QCzR78H8TkFxW0YzhJ3le8rhiTaVPrXFdfQJCheTZ/MluuIc6X9MXVPD/1Iz+gpmBgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kz0QVYzZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O9IIB1XK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kz0QVYzZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O9IIB1XK"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64VM23sJ2734613
	for <linux-pm@vger.kernel.org>; Mon, 1 Jun 2026 06:38:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=yAcgauqzFdzXcLgv0t2zyO
	ijWIG8IzV/EiR5Mvck0ng=; b=kz0QVYzZR8trlEbdUydtH3pszPoSfNYmdlUXAj
	9OX21Dgv1cW7NjVPFeSNVoLQJ2mDYLIC1b3mUSsV/y1/IKpmhJz7kyb37sJRFimh
	ZHkjlx32nC+oniQ9gj1yj/dgbRmwzkjHlrDp8UWtCqKogGCpuyinhbQlU0M1xDfA
	ArgiSYaqfT9huRxIeNkvArG0lslF5koD9zkbTduv7hi90dg/fvWZE7B1tsum7zh1
	+cx4VIaG1bXGv2FYGdMRFGPutnAJKld2anghkYzwYtkwqAxP82SBZR+UWSDb5K3L
	XaWhwRC4/2IV8OsSdC68aT/CKXgFXR7z8e06BJm3Z2wh+fRA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efxy7wchj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 01 Jun 2026 06:38:07 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84240b58211so789328b3a.1
        for <linux-pm@vger.kernel.org>; Sun, 31 May 2026 23:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780295887; x=1780900687; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yAcgauqzFdzXcLgv0t2zyOijWIG8IzV/EiR5Mvck0ng=;
        b=O9IIB1XKmRVaOojI9WcgSi0yX1x5yskIBXsQCkptFt6I8rm/08e2vihdtPzyDNu5eU
         VdP5i68eKD260C3Jd6kbHj5lpf1KUYyEQFK/XHCN8/dAhIEUt5VpGd82eu/ZOyQZqtg9
         tChG8wuTiKpKG8ql4ABjcGaqyojrS2kM9l64Eb/zmHavset7gv0JpcQYwwPaMY7z552u
         peNfqo9OnIugNpzVko0c/NRcsBt2O2Dm9ViEuSL3anTQbA84lWqmaY96t1yqgJkBJWln
         TmRpxmAjm5kiKuYZtQ+9STfwwMNVgygTxhursC2TIgE2RX9Tn69e1j6bCCsh9LVOgT63
         ivWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780295887; x=1780900687;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yAcgauqzFdzXcLgv0t2zyOijWIG8IzV/EiR5Mvck0ng=;
        b=Q4GV4hwopSbpFJKf8d/rJ05+IWRcY2EtAsKi063nupZhvfmV9NsnTcNMKTN+sHqkbQ
         ZfQMVei4Cnmy83p8yO/msN7xuM+dsTgM6jdSdJ3/tqJJnnpO6HgvOzn+aPcLL9Fx20bT
         0iVl/4ArvtQGqpFH9XN9f2k/GRM+6Z7PfMFlGv8PZIDFY7tyiRWtJI7Gp6gI+5DuNIHt
         O7PFOhEF7YMo0Ouf5YABHsL5KQFK7UqN9m7joN2TcmHwyORwaIjgj03sfA0oAmY5m8NA
         5rtCD1oBU0Tm9wsAkV11xdA38ktybV29uWshEKzchSosc1XPLT79S8UBU5ZeoVTUB7GG
         pnMw==
X-Forwarded-Encrypted: i=1; AFNElJ+t+DZD0+mUEPv+q49l75RYVxUYA0Lub7ZigM+yt2MlgjLrBoC/IIm3U+ihDUYWgE56kH3wiWQBVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDbsGMioKC1JXG1WMcG3TSyzm8qhYvvvczhosJq5qxESCSlche
	Wj5P68yIKEywr807jnTxuNEmpEKRBhbs1R4NpF3c6K4QqFDS23wxzP+x1jHn7ndzUp3cgEpE05H
	JwvGYYfcTXNpz+L6v7ihZWmnFFfz0g12Cd+0eV3hZxKoMvOaODfAIn/62BpRL9Q==
X-Gm-Gg: Acq92OF3qoBJLwgq+hkMNPBIxoBhCZUoV5XzGIBa7KxT5pwrCsfr9stT3A+PiiWeiiV
	pWfl6s4D7jbW9ETjsOc/B7YG+IYiRWhHFAkI0UjZCxNoq2+9UErBDTFuWDC9/GbwMG50l+uSwdI
	cQLbQU03HrsKPfepYV3DsPxnhHKcN0BjsRTHqDmzyjLYy7GXDiD2y2N7rnsIHs+T1Sd9HpD58D8
	JmrEc/KSPo6LRCDRGVkvcBdBhTnSmtQDfQFTW2g8+tor6mSKeEqIjfTBCkJqcKWNy1XyLD5q/Zx
	/aAS9c8ocfTHk8sPDU9Wnp/XHL9YGguWm6zs2bq06x/V0JkQwWlRgxjSWFjvwxWPGPH7j3Q2Anz
	LR1ZOVzn4HjQegXIrFoy846OsrcqJh16U1lGnNu/pRa4FGM2G0c6wxdwqHJfzGVQbzw==
X-Received: by 2002:a05:6a00:2289:b0:82f:390a:69df with SMTP id d2e1a72fcca58-8422548f610mr8955719b3a.35.1780295887004;
        Sun, 31 May 2026 23:38:07 -0700 (PDT)
X-Received: by 2002:a05:6a00:2289:b0:82f:390a:69df with SMTP id d2e1a72fcca58-8422548f610mr8955683b3a.35.1780295886519;
        Sun, 31 May 2026 23:38:06 -0700 (PDT)
Received: from hu-priyjain-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214c9252bsm9321358b3a.39.2026.05.31.23.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 23:38:05 -0700 (PDT)
From: Priyansh Jain <priyansh.jain@oss.qualcomm.com>
Subject: [PATCH v2 0/2] thermal: qcom: tsens: refine wake IRQ handling for
 suspend
Date: Mon, 01 Jun 2026 12:07:55 +0530
Message-Id: <20260601-tsens_interrupt_wake_control-v2-0-ce9570946abd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMMoHWoC/42NWw6CMBREt0L6bUlpQgG/3IchpI+rVLHF3oIaw
 t4tuAHnY5KTTM4sBCFYQHLMFhJgtmi9S8APGdG9dFeg1iQmnHHBSi5oRHDYWRchhGmM3UveodP
 exeAHymoFlapF2RSGJMUY4GLfu/7c/hgndQMdN+e26C1GHz77/1xsuz+v5oIyKqTRpipTVHPyi
 PlzkoP2j0eeirTrun4BZeDryuEAAAA=
X-Change-ID: 20260526-tsens_interrupt_wake_control-08be7b86591d
To: Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Priyansh Jain <priyansh.jain@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780295882; l=2081;
 i=priyansh.jain@oss.qualcomm.com; s=20260515; h=from:subject:message-id;
 bh=NxsmgpXqtgg+7aG586diJbRcKlS0Itgqio//rv0yLKs=;
 b=pMvH3R5wSVeUdrd7RfL4fJ5VOoEHi/fZm/+uieHHSCC5PCk8C34F0mYSOVy6bPOImgW3PzPOd
 RlCrzOKjKUcDgaOUsffu5C2E4ugQVPL2v6XbIl2vbu2i5rhsJFfuTV9
X-Developer-Key: i=priyansh.jain@oss.qualcomm.com; a=ed25519;
 pk=xe57jjgIoTuNHN/Dp00kZl1mAJjmROaH7JV9sRxEoEQ=
X-Authority-Analysis: v=2.4 cv=POg/P/qC c=1 sm=1 tr=0 ts=6a1d28cf cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=QyXUC8HyAAAA:8 a=7CQSdrXTAAAA:8 a=kC-WkVMnToTUk7kQOxwA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=FO4_E8m0qiDe52t0p3_H:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA2NCBTYWx0ZWRfXwjsIeP2kdZ91
 ypoX469CJ1SVM3VUTxGAJgRec389Rfn0kzz0wLrOQb3Slqcv6hHztUMMImZql17kSiVLhckVFew
 82K7hPO+imBKl92SPYlQXasXjkAQTEwYrXrZfvOhaXBRjsx/LHUA/9cjkpPvTC+S1kkxpw5ZV0x
 FunO2LiZOrKF3ziObv1XPaihbH7sYgtAd1XYOqaIAKRJbexkWFRKOhxKXwgJtxhHzVMJ8QJpLDb
 rRyTxqrlkqPhNJk52X9JrXe3IisWb2/SLr73uZl8qNctrp9RuL04UEJ9Ze4K2iHk59b14crihZo
 3/PwAdJxQdwrAat7LBiZs29Y8zrEbQJtLA2wfWUL0Xrd1LwOC5c3qWV5kMvvi+ugH2kzoJMA5Pa
 J2QvNbkR1HMvjXRRzXGKhEZ89bqhTVuzLTFDfhHJRWCN79UUVjk238UIEGm0gm4d7wi8Dgfaumx
 muhbXQK39GKisfoTOqQ==
X-Proofpoint-ORIG-GUID: 4JC_cpWSf8zqNFh5mCJMt3CBRWMg_yTT
X-Proofpoint-GUID: 4JC_cpWSf8zqNFh5mCJMt3CBRWMg_yTT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 impostorscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010064

This series refines how TSENS threshold IRQs are used as wake sources
across suspend/resume.

Patch 1 moves IRQ wake control from registration time into PM callbacks,
so wakeup configuration follows the actual suspend state instead of being
left enabled during normal runtime.

Patch 2 adds a platform-data opt-out for wake IRQ setup and uses it for
automotive TSENS compatibles (SA8775P/SA8255P), where parking suspend
should not be exited repeatedly due to TSENS threshold wake events.

Series highlights:
- store and manage TSENS IRQ wake state in suspend/resume paths
- keep existing runtime monitoring behavior unchanged
- disable TSENS wake IRQ setup for selected automotive targets

Signed-off-by: Priyansh Jain <priyansh.jain@oss.qualcomm.com>
---
Changes in v2:
- Fix indentation issues
- Remove redundant checks for IRQ numbers since device_may_wakeup() already
  ensures interrupts are registered. Simplifies code logic.
- Patch 2: No changes, LGTM from Daniel Lezcano 
- Link to v1: https://patch.msgid.link/20260526-tsens_interrupt_wake_control-v1-0-6adcd75555b9@oss.qualcomm.com

To: Amit Kucheria <amitk@kernel.org>
To: Thara Gopinath <thara.gopinath@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
To: Daniel Lezcano <daniel.lezcano@kernel.org>
To: Zhang Rui <rui.zhang@intel.com>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Priyansh Jain (2):
      thermal: qcom: tsens: switch wake IRQ handling to PM callbacks
      thermal: qcom: tsens: Disable wakeup interrupt setup on automotive targets

 drivers/thermal/qcom/tsens-v2.c |  9 +++++-
 drivers/thermal/qcom/tsens.c    | 70 ++++++++++++++++++++++++++++++++++-------
 drivers/thermal/qcom/tsens.h    | 23 +++++++++++++-
 3 files changed, 88 insertions(+), 14 deletions(-)
---
base-commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7
change-id: 20260526-tsens_interrupt_wake_control-08be7b86591d

Best regards,
--  
Priyansh Jain <priyansh.jain@oss.qualcomm.com>

