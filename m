Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253C448A8B8
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 15:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789398129; cv=none; b=KUUrAclEwWdbZKxFcWhXWRs0ipWo2NuRkZA65zINHbyoOF/1/j8+/BsYd3FiLANDq6In/zt/WNRC8yvTJZ62op536Qu1dBGuaNFcQI4RBtgBsDTaSDS08vsVFmm702diKfbl38Wavpc+HdN0uw4VeuWdbGEfnUi9s5kW3ud8K2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789398129; c=relaxed/simple;
	bh=7l1jH4YEwwaB9bVTubCiHOrHrjM7s2t+ualLZn24p7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FXZytCqFPJuo+A3vrwTQxr7jG46xXD+jW5pBQwISXmhTPz9l3JdrYI/X8fatB1QWpyRBsAPDDEU48pEe+iXgL8h7cdvnYdB2AaKXRMPtTABcktCPKIaEA6QAI+AstcWEj7cj4NGxOoSHaGclBgljgCCvzO4YODWVMiP4W2tC61w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PNNrgj2x; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZfHwhixb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PNNrgj2x";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZfHwhixb"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68ED0QAn1761282
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 15:02:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=HKDK43ay9zY
	tKdxpkhmpR5tzBLdv8wVtA8UrvJmZbMs=; b=PNNrgj2xk1EVdX4xt1Bn2RFQdPV
	ZNGqJ/gLtlYrw2aAyZoshur384XYsKMYZI4sopxxebhppb2J6ILJDyG0CRKzGbg1
	NbBxFWFs9ivdli9ZMrqm2WTuX0qayLTIQYBZhN/kCRC7clqpogcQ1L7JsAmNeg8U
	5+syTQqoiQhhwHfuRCyOs20S2AUGq0Z9hCXJEO2ZP9kRoOA+sYNgWhpOR4iLayUS
	bz0q3Y81tGiWtfVVVmi9fCIUIrHFWBL/fQQo3xvbjoax4p+k5BgK/c/sK2uZuqpI
	xGCSP+wwwriu2zzTsTVIeESb+foFYkHAZ2JTm75BVfH03C3sHalj060/wow==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpeex98n5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 15:02:05 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-6c2474b64bbso2350991eaf.1
        for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 08:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789398125; x=1790002925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HKDK43ay9zYtKdxpkhmpR5tzBLdv8wVtA8UrvJmZbMs=;
        b=ZfHwhixbVQo4sXwjP25apIwRiB+Pwd95LW2Tm4sHfafNwuUlKBXCkBQVmreKPkvHJD
         AzJiqnNhVDK0TTiL2IrlJ3FWIWQzjKusXBiwe9PxqAtmPvwZT1gHg1jHCdoZgm96CT+v
         xdugM0uQrWJOihE5ADbyFUg1ItTvhsU70I1oi0r2FFeVvyn9XsATx2/r+W4KLWC766c3
         QotN+MFRNexImtPcxSFMe4zVe53eVPe2Xq46T4Nm0Js1mTkDPyx+JnKsKw0OSSltI6/S
         5JHRaN0PwfbdMqVIFZQlJ8TUshqoeErXEIAOUrXuJ8zxgVyx4l33WUDOTaT8QBcJBA9N
         ShMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789398125; x=1790002925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HKDK43ay9zYtKdxpkhmpR5tzBLdv8wVtA8UrvJmZbMs=;
        b=YsOKlWskrhBt0xXW1Zdd96LnBWni1l4SIIj6cgO4tUxi9MZvs1nngs/GRYhqyDSYSx
         VFrBs4gi0Tc8qIVm1ZEBa4ZJyZ+SuatWRcM10pX/ihDw6iII+lEdDaJtDzm8Pu//4buk
         wVpfoz8Ze6ibZGzTYen0SAXCA7mf4WlfArZYOn86bK6HDrHTDQUD/gGAoEHLXvDrWRrI
         SEMh+KggSzFAjR+NM6yRTu3W+bP4RJ8v5ZXBW7JIUjuRpwTLj+gL2Ep4i0FYoiH4hYPM
         1SZjVIskAIouCMmjCa8PPQHcZByJy+xc9pYO77plv+PgdLWvfHKNV3Qq9r1o1pw/Whwn
         7RqQ==
X-Forwarded-Encrypted: i=1; AKwUvBzCu4Thv0Z6GgNSJDCTJnFDbNH6tzxs/dZ10BJNrkbO4FdbGuvT1ytbrQ8H4wdmadfyz5YHVBa8Rw==@vger.kernel.org
X-Gm-Message-State: AFuF++lbOftpl/13o58+RfCqpwPu6JEmfwZxtLHDC2EENayEBrdpbyFe
	NlcI1o5GXBudUSZWNGqg/RSwuOnQpkQ2yiuD99cXqIVew0InU2UwS/N6sBhWS/Wpguhvn7/YRsE
	7W1Y8a7nPb8ycgnGzNyDgGBIklSYXuwO8ExU/FR80G3lAPs/d8odhfp17KpvZFQ==
X-Gm-Gg: AYBFou0naF7mFmfVZrGNQ6DgQLtUvq7eXrAE3r1Vka4mZWMJs/9FA4B+P884rLt0e9L
	0jrAyV4WhGGY4tk9VU3P6h17ivwQ7Yr5VvDirgujdYOWHnwGb4B8HT+koXcy7m3IuB3KJPtQrxM
	WjNK0cTyPmP9uYAsTu4xUwU6MrTgUPul23hBBhOmOE4lwE8g2O77jVXigDmUnahInBFQVX2GNr2
	+Rr39y0L/FPaVIOoWAwcpZQIxXzldr6DJr9XPFODvykkF2Trj9a0SWEB20+D9r3ioYxvcukAy9c
	vNvllvZQqML6ExGv3Fe+FQ5CYRKVsDlK04m89TPPyIRA3JB6nSi7RP5wjk11Qa6N9aBFyljG/B/
	224RkpXeMzOInjl5eRg5wQENlHaFJV6Hw0WxOhuyqsasskVCRJGrEvsRbBQ==
X-Received: by 2002:a05:6820:6ad0:b0:6be:dc4:13f0 with SMTP id 006d021491bc7-6c542926f3emr1546466eaf.49.1789398124759;
        Mon, 14 Sep 2026 08:02:04 -0700 (PDT)
X-Received: by 2002:a05:6820:6ad0:b0:6be:dc4:13f0 with SMTP id 006d021491bc7-6c542926f3emr1546403eaf.49.1789398124319;
        Mon, 14 Sep 2026 08:02:04 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c296608480esm468632666b.36.2026.09.14.08.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 08:02:03 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
To: Sudeep Holla <sudeep.holla@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>, linux-pm@vger.kernel.org
Cc: Dhruva Gole <goledhruva@gmail.com>, Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Maulik Shah <maulik.shah@oss.qualcomm.com>,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>,
        Sneh Mankad <sneh.mankad@oss.qualcomm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/5] cpuidle: psci: Initialize the PM domains in powered off state for OSI
Date: Mon, 14 Sep 2026 17:01:40 +0200
Message-ID: <20260914150146.187622-5-ulf.hansson@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914150146.187622-1-ulf.hansson@oss.qualcomm.com>
References: <20260914150146.187622-1-ulf.hansson@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDIxNSBTYWx0ZWRfX5Q9NtKvtPez5
 fVdmE37Z0hDRLfGN0l0x66d4Zu3X86ZY0aw365DOqwgfyLmof8DUREskuWe7cGJHR0MKuy3dAaW
 VCHGI3A7uCq5f+43lfm5LHz8ojAdy5gmhnW5KGRvcFZXUiBchwLZyhU+zjcexug6mCnEcp8JcNy
 nAvukj4E0J2Ty2JcHDHiWKgF4+TrJYeHsu29TGR8elqk502YX/L+H8AHe89dCTksZM1q7iUTPyJ
 NcUmH1B8bJWtx1+bLKaiptXpUt2tugXpuD3c+7zB8hoMBgwNH/UBKBWJxCIKhM1gOJZBXYRa+yy
 84UCzGNeRIibc/5NjRRXwN4u5VnN6et6fuTd/N77aqpYYM2skc9YKPCif8Q7yXcG4EMiMdznH32
 7ti40u6nOCY/MnlmV0qqFHuK3Nsj8i73S0tsu5+XoP4SmMsVjdBrCOZXju645EiTAFwG6+noujI
 Mpj1mHE4y2v0DTvIOLQ==
X-Proofpoint-GUID: KhujirzTxbaM2VpBE9cx2yFiSebyvIRX
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDIxNSBTYWx0ZWRfX3dWyBMDf5UcI
 cLqCemZyKo65j2XlE1LMCMcpJycVKLy2C9SCuoLkgQqVJsbSJZikt/BrAzCsvDy+YEvUbRvoLvC
 GZ3rchCUhva218ioQcr+DmkyuoQT+5Y=
X-Proofpoint-ORIG-GUID: KhujirzTxbaM2VpBE9cx2yFiSebyvIRX
X-Authority-Analysis: v=2.4 cv=MsrHeGae c=1 sm=1 tr=0 ts=6aa80c6d cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=h7aNHqOhPKB91FvYUefsSA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=GddhhVl5-a8N4MGu71oA:9 a=WZGXeFmKUf7gPmL3hEjn:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140215

At the point when the PM domain and the topology are registered through the
genpd subsystem, it's not really known whether corresponding CPUs are
online and thus if the PM domain should be initialized as powered on or
not. Instead this information becomes available when the CPU devices gets
attached to their respective PM domain through dt_idle_attach_cpu().

This is a problem when using PSCI OS-initiated mode, as we may end up with
a PM domain that has the genpd's status indicating it to be powered on,
while it in fact may not be the case. In the less severe scenario, this
leads to selecting a shallower domain idle state for the PM domain than
necessary. A more critical problem is when a non-CPU device shares the PM
domain, leading to their corresponding drivers not being able to trust the
status of it.

Let's fix these problems by initializing the state for the genpd's to be
powered off and in the deepest possible domain idle state, when using
OS-initiated mode. The support for ->sync_state() is maintained by setting
the GENPD_FLAG_POWER_UNKNOWN for the genpds in question.

Reported-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
Link: https://lore.kernel.org/all/20260811-domain_off_ss3-v1-0-6a0a0fc023f5@oss.qualcomm.com/
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Tested-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
Signed-off-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
---

Changes in v4:
	- Drop GENPD_FLAG_RPM_ALWAYS_ON.
Changes in v3:
	- None.
Changes in v2:
	- Fix a bug in the call to pm_genpd_init().

---
 drivers/cpuidle/cpuidle-psci-domain.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index b9e4ad7d43a3..5722365b943e 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -68,9 +68,8 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
 	 */
 	if (use_osi) {
 		pd->power_off = psci_pd_power_off;
-		pd->flags |= GENPD_FLAG_ACTIVE_WAKEUP;
-		if (IS_ENABLED(CONFIG_PREEMPT_RT))
-			pd->flags |= GENPD_FLAG_RPM_ALWAYS_ON;
+		pd->flags |= GENPD_FLAG_ACTIVE_WAKEUP | GENPD_FLAG_POWER_UNKNOWN;
+		pd->state_idx = pd->state_count ? pd->state_count - 1 : 0;
 	} else {
 		pd->flags |= GENPD_FLAG_ALWAYS_ON;
 	}
@@ -78,7 +77,7 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
 	/* Use governor for CPU PM domains if it has some states to manage. */
 	pd_gov = pd->states ? &pm_domain_cpu_gov : NULL;
 
-	ret = pm_genpd_init(pd, pd_gov, false);
+	ret = pm_genpd_init(pd, pd_gov, use_osi);
 	if (ret)
 		goto free_pd_prov;
 
-- 
2.43.0

