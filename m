Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC6A541E75
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 12:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079557; cv=none; b=SQxzdfEo/joImacULg5HqwJCy2IlBXlOQjSzj3LtLOFwQ3GaRFO5YqvZEWUtjDvTC94F+NmWbn5HlNBxeo+9zaSs7wjQhEhaOdliYrKhIo3w8sZ+Zl2Wx0lUBId4w1fO0kU1qMMtBrpZR5hsU71qiZH11ZNVa9qGN5g3Jji9dBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079557; c=relaxed/simple;
	bh=1dlM7Z4+tJdQen1X96YsAEa2D0A13iz8IrrDf/8d0tU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TTaitYP4N3PF4J757eBavWuvaDFYHrZ3vfmQCTspMTFRoc79YZNBkjBr39uxfChAy5gIGlZmZwsNerg6hH73ER2KR6zroHglr5SQxyfOR+LGSDR40xyen320OUmoyFHguJLECWSdD837jlTsa5klnLOH77YLMzqhCVtLLmRHIAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xq9pTWOP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OSZzUrPL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xq9pTWOP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OSZzUrPL"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MBPe6h269221
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 12:19:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=g+oIgXL0Upy3cOX9OQ0bCY
	UpD1ds4ORdqAu3wAb90u8=; b=Xq9pTWOPsA2WE8J5a3J0Zod6+uSWe00PublddG
	4nnjCLU3cOk5mdbH1hl98aZJHrG6CoqPOJDYqVAIKDpy+awgf07ybCjS3k8XhP2h
	4PBhkUgDOOV2Sm4QSQZUcXQLLPUgPQOpvQD0PGhH+l1e0PQrGA+FYs67C47f3Y0f
	dSIVnnm/xDWTGZRTCBbk7C3+XuS1tRonzMuUFN9a2OGzotzTB/x551KG06CTLBPw
	CQYTcUWIStCHZ8gtEE8ojkhZ9G8wHKywaf5inroY84yj8VV26kZVw+K9MIcp9Piq
	3lHryntFOommW3xAfF8kkFQ4TcM+OO66OIHtfzOVKx0cFFcw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gufbatgu8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 12:19:14 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d6fb956002so55577375ad.1
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 05:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790079554; x=1790684354; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=g+oIgXL0Upy3cOX9OQ0bCYUpD1ds4ORdqAu3wAb90u8=;
        b=OSZzUrPLJ1i73kz/dMG5bz2UG4UGyUOAXKp4VvcXgrK47rdoHc/YIFDvhhDnujxlgt
         YoiOWV8bXlIAq5WN1MLfbpFXR/ONvJ3x/9pBiUgm0dyViojoEU90Dv/BXXkHfNeLKVot
         A1m8Zhlm6fYE+5zIzP37Kyagusaa+ecSVAywjvP7ML8RR3zNjbQjNgEkzTXCxxXJ7aNT
         6j637/7KI9BGIsVqdK5EgFrZw75HWy9CGyn5J3iPCBW5f9YfXNpOXYe0hX7VFjuDeKtI
         lVVzHbKn7fXme7PPzRVTR1j1AWJxMRTf2hre9VgodynDwyNl42oH61Is19CgJS9eooVW
         rcDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790079554; x=1790684354;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=g+oIgXL0Upy3cOX9OQ0bCYUpD1ds4ORdqAu3wAb90u8=;
        b=ppt+m/Yns/1SpkAdmWb+3SHcK7LCP5x8uvO60Nx2fPWFPJcpxVBRtoAkhsIEag+PSo
         JhetzE1ziYDOG6hFw62cgGmaujgEH23qBZvaSNFnMZVcrdmV1D2W7rUJryGrcoB0eVm0
         DYnTK9J0WXy2ZD7iIUnU4QsK/WbE9o/zTzRreCW0Bsq3TS8FJkgr80F1Y72aKwEXYdst
         3wrXpOT4J5nuoX8sH63pN2Ajtxyn9PMj9Wcu5xdXpqWbBQtIGEqqfGXsGqwrWCceoGEm
         dZr1oAnP1HHJyL8kP1+wOdb9iZYWYoJx2AKm8BdYb2xfMKnWI9ltVPCWiRsZmM6ywF8d
         wWoA==
X-Forwarded-Encrypted: i=1; AKwUvBzklMR3wiLUvMoHBWUCHoYf+c4pUmvUZFWmJPhe8qeJRkmt2SE2XBWnJOIz6nuarvekdFofhwUYNA==@vger.kernel.org
X-Gm-Message-State: AFuF++nU6S9Tbv7oPdeGb8PMl6viE7UIq7GX6IuOSIeDWYYeUrAF2BD1
	qFtmi6v4xUOySnIS0npHXRrUUW9IuhFtpQrXnQB2fF71b10Wc0hBo9k+ch/x2h/c8rshbiVFkB3
	SpyB5+jTrTzYIZiEw9aAfKnla85HzxjWWIYgUr+74grfaTrkOs5PIqWCC9t/y41RMKf7HWQ==
X-Gm-Gg: AYBFou3m5jSJrz/0qZXJO0DRLd6VLkJqtC0ao3ZWPmMQVQYR7YYkWs0TNh7jU3zdOqE
	M9pngLKn/J8XjJzvRqEhMPdIy3xwfOzSRU7Lh7noYW4yfz5lyMfStOlIh2eosp70FZ63NILR1Xz
	RoIDPfP+hOyF3JfKG+mCbSylGl3cqXY20cjLNiZL54x1ggSsy9djHuUqUvai9I7F9EMVZsxBx8a
	l0OpKYeE9mcPi0MAAbGiGM2Hcxyv1yE15YA1APlOwV1OHMkJZ12emQgN+il9i8lAb1xOGozUMS3
	C/zCyt0S5bhfDKNg0qGE9faNqk5+oa4CoCQNomMMbp88a97RFLhNuXpGRQVI2w4IlEC/MZ9gvSD
	7PCOTn4S8CfMreeSyo4ZI84tDgAXGQP7aDA==
X-Received: by 2002:a17:90b:5408:b0:39e:6c6a:4b73 with SMTP id 98e67ed59e1d1-3a0732799femr955866a91.61.1790079553777;
        Tue, 22 Sep 2026 05:19:13 -0700 (PDT)
X-Received: by 2002:a17:90b:5408:b0:39e:6c6a:4b73 with SMTP id 98e67ed59e1d1-3a0732799femr955827a91.61.1790079553157;
        Tue, 22 Sep 2026 05:19:13 -0700 (PDT)
Received: from hu-manafm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07385e516sm562203a91.0.2026.09.22.05.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 05:19:12 -0700 (PDT)
From: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 17:49:02 +0530
Subject: [PATCH] thermal: gov_step_wise: Fix stale mitigation vote with
 non-zero lower bounds
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260922-step_wise_multi_zone_stale_vote_fix-v1-1-789f68dab229@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIADVysmoC/x2NzQqDMBAGX0X23IBGsNpXKWWJ9atdsIlk4w8V3
 72hx5nDzEGKKFC6FQdFrKISfIbqUtDz7fwII0NmsqVtys5aowkzb6LgzzIl4W/wYE1uAq8hgV+
 yG1y7umnhhgo95dIckfX/cn+c5w/kC89CdQAAAA==
X-Change-ID: 20260922-step_wise_multi_zone_stale_vote_fix-e79368ead1eb
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790079550; l=4592;
 i=manaf.pallikunhi@oss.qualcomm.com; s=20260206; h=from:subject:message-id;
 bh=1dlM7Z4+tJdQen1X96YsAEa2D0A13iz8IrrDf/8d0tU=;
 b=+vpHNJbU8cMwcO7pfZw28j9gugoSp0dF22vG80lUHJTUD8R2bYlGD0ZaubWOFzi63SPqkIgpc
 7uOHPkfx1sBCsxtTuLfd41BkhdI/NMWaLHAup7aJkDo3wMVn/6jiG9Y
X-Developer-Key: i=manaf.pallikunhi@oss.qualcomm.com; a=ed25519;
 pk=oZ3x9jh+FDyPwxHmCbyzEMQHMzKqrH6hUbbL7dEBe2g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE3OSBTYWx0ZWRfX3PX3MoYtimE7
 Ht47Wys7FpkNAxvxgPGJwgTmlFemaQJ5+A0+lylfNQ88KrYHaeqCtmNNrv/jAcUgCPQ09zBA7/7
 q6hqdaoZocOcTzf2WZL6h4gZ2N2NdkaHQVvPJkhuV5cX2o38DWR7dq5gEuRSs8kMg4CChrI79OX
 5DP1I1u/+KS0aQ8qzzMvBg+dLrGi2pqKDxR0vS2js976XIVvLPc0/+fBRt2K4EtK3Ttkdjv/ldT
 MBdFEGXj1cSrrOPugnHTlZPBD0qDpNOS+yLeo+fopO9GzSGFF0zyYHbudGafg9OAkN5r+jj8Ylc
 B0szkgp2Sn1WziCyGrmZt870Q7t6CpzVdtOMly5YGphY+kh5AIBV9V6CbEaKRoRQ7GH0lLWveh6
 lKa8otw/W1sflQqO9ndiU2ksYpS4f5huVc8OXH/00zBfJgraasQv44xtfzHYYHeKtpPuxrKuONF
 iKAf6rQPtb5K2w7R0Vg==
X-Authority-Analysis: v=2.4 cv=IYYSymqa c=1 sm=1 tr=0 ts=6ab27242 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=67fxiblbIBgiSD12K_sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE3OSBTYWx0ZWRfX1mLFovM6M4d8
 UfeJVih5AaLfYxZAqRqkxK3DzQVfeOzZC2Ti44IFjfWZ5jgpjaNTdRSoq+5R5ElFDt4CqaHDskU
 p1R2SZXu1SqBXWgc9yHkfvSGO66sGqo=
X-Proofpoint-ORIG-GUID: yIMMzSr1Lc9jFmXiiEXxLk8-SxpWGzkz
X-Proofpoint-GUID: yIMMzSr1Lc9jFmXiiEXxLk8-SxpWGzkz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1011
 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220179

When two or more thermal zones bind to a common cooling device and one zone
uses a non-zero instance->lower value, there is a bug where the instance
holds a stale mitigation vote even after its trip is cleared.

Problem scenario:
- thermal-zone1: Trip at 50°C, cooling-map with lower=0
- thermal-zone2: Trip at 55°C, cooling-map with lower=2
- Both zones share the same cooling device (e.g., CPU)

Issue flow:
1. Both trips trigger, zone1 requests state 5, zone2 also mitigates
2. Zone2 trip clears (temp < 53°C due to hysteresis)
3. When throttle=false and trend=THERMAL_TREND_DROPPING:
   - Current code checks: if (cur_state <= instance->lower)
     return THERMAL_NO_TARGET
   - Since cur_state (5) > instance->lower (2),
     it returns instance->lower (2)
   - This is the BUG where it returns instance->lower even though
     trip is cleared
4. Zone2's passive polling stops (tz->passive reaches 0) - no more updates
   for zone2
5. Zone2's stale vote of 2 persists indefinitely
6. Even when zone1 wants to reduce cooling to state, the cooling device
   cannot go below state 2 due to zone2's stale vote

When a trip is cleared (throttle == false), always return THERMAL_NO_TARGET
instead of instance->lower. Remove the unnecessary check comparing
cur_state with instance->lower. Since passive polling is already
deactivated when the trip is cleared, the instance should always be
deactivated regardless of its current cooling state. This ensures that
instances with non-zero lower bounds do not retain stale mitigation votes
after their trips are cleared.

Fixes: 042a3d80f118 ("thermal: core: Move passive polling management to the core")
Signed-off-by: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
---
When two thermal zones bind to a common cooling device and one zone uses
a non-zero instance->lower value, there is a bug where the instance holds
a stale mitigation vote even after its trip is cleared.

Problem scenario:
- thermal-zone1: Trip at 50°C, cooling-map with lower=0
- thermal-zone2: Trip at 55°C, cooling-map with lower=2
- Both zones share the same cooling device (e.g., CPU)

Issue flow:
1. Both trips trigger, zone1 requests state 5, zone2 also mitigates
2. Zone2 trip clears (temp < 53°C due to hysteresis)
3. When throttle=false and trend=THERMAL_TREND_DROPPING:
   - Current code checks: if (cur_state <= instance->lower)
     return THERMAL_NO_TARGET
   - Since cur_state (5) > instance->lower (2),
     it returns instance->lower (2)
   - This is the BUG where it returns instance->lower even though
     trip is cleared
4. Zone2's passive polling stops (tz->passive reaches 0) - no more updates
   for zone2
5. Zone2's stale vote of 2 persists indefinitely
6. Even when zone1 wants to reduce cooling to state, the cooling device
   cannot go below state 2 due to zone2's stale vote

When a trip is cleared (throttle == false), always return THERMAL_NO_TARGET
instead of instance->lower. Remove the unnecessary check comparing
cur_state with instance->lower. Since passive polling is already
deactivated when the trip is cleared, the instance should always be
deactivated regardless of its current cooling state. This ensures that
instances with non-zero lower bounds do not retain stale mitigation votes
after their trips are cleared.
---
 drivers/thermal/gov_step_wise.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/gov_step_wise.c b/drivers/thermal/gov_step_wise.c
index ea277c466d8d..4fa4377f0d42 100644
--- a/drivers/thermal/gov_step_wise.c
+++ b/drivers/thermal/gov_step_wise.c
@@ -65,14 +65,12 @@ static unsigned long get_target_state(struct thermal_instance *instance,
 				     min(instance->lower + 1, instance->upper),
 				     instance->upper);
 	} else if (trend == THERMAL_TREND_DROPPING) {
-		if (cur_state <= instance->lower)
-			return THERMAL_NO_TARGET;
-
 		/*
-		 * If 'throttle' is false, no mitigation is necessary, so
-		 * request the lower state for this instance.
+		 * If 'throttle' is false, no mitigation is necessary and
+		 * passive polling is already deactivated, so clear this
+		 * instance state by returning THERMAL_NO_TARGET.
 		 */
-		return instance->lower;
+		return THERMAL_NO_TARGET;
 	}
 
 	return instance->target;

---
base-commit: 1a1de54f7369cd2b5bac0f265910e60ad3a6b4c3
change-id: 20260922-step_wise_multi_zone_stale_vote_fix-e79368ead1eb

Best regards,
-- 
Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>

