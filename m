Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9FC48A2D0
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 16:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787158582; cv=none; b=ANuJvMbGlyY6mP2aXovZoaJIRqRx89zC0n1PaIRcTZq7I1oMjuVRFqvosQmbMZbIm5dl53S0EQVT0BmKeCFWhhW/Wj8qMium5OEDgH2RgvHX4xuI+/Dfjq+VjkV70Ymc6gIG9phMWeE10ub4vIci0RuYb35tbUYtue5jrbnJ0bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787158582; c=relaxed/simple;
	bh=Qrnv8qH2T52Rds3B+tQNiGt/EbIPH7XsOJpXNsPQrZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjXl111SxKL1+/PPxCZKrQOXs3Bl2l9xwbLliSMfZ2dICykvYYi7KZk7FbZVwhxMsWnBtbSrIZ3lgg1EoM9Iw5hAiweUOxB3FhCtXJY0hV8ZhQ6nWP6Z1lCGzxRjugMqAKdG6BEV0TngqoA/0DKGQz8Ttopr/JyS75aSPFZD+Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C3MYYDu6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UWhn7u6D; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C3MYYDu6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UWhn7u6D"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JEbVir067649
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 16:56:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=zIe6pwh84/c
	gjHJc/ZPARHNyhcZMHDOU3m6rWSmarLw=; b=C3MYYDu6yuNXMf9wnhG8s3G5bS/
	dS2KJZ8yTOcdUpUkUkPwNXyOPTjinPVhqJ8mlFYVQB+DF7bsLlWQC20YWzRmj9MC
	fW8T4OpuXdYB5TtTz0pyVTTbGOkKN8Ophb/+dbYa6M28KCGuVM8hJgGHdJZ5mIAB
	MOQ9OxRFUCbc+4AFOJRq2UwQNgZVzxGr0AuBTxwOr8ie12a+tFDhQ+11MYtKiGc5
	ccBx71/ArPwD8NquMPuqpghS/C10i2qb+SrQ2ENE/YJf8s9G9T7WEYaTdDjTy1XQ
	79lW+sn5As+t2n1+zoTlSqdqm5Jug6d9bQUoqzcb8luNZUefQRjQ4N5FcnQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5e5d0u1b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 16:56:18 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93494527488so221704385a.3
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 09:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787158577; x=1787763377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zIe6pwh84/cgjHJc/ZPARHNyhcZMHDOU3m6rWSmarLw=;
        b=UWhn7u6Ddhi4HpN3/ibxw2WxAEW9G/xjco6Id+fzOSwCKFXdErJfwRzwNDhPEKMzul
         kF9fo2gNcZL0GYOR84UFRFS5L5TD/gg5K9yGrr2Xi8IpKDdiYpKYhRdtOk2Zmajt7LMh
         n5wHOzlEXwjBkbyx4QOO7ZfvcXa6bdtruxRNoO74Q5VoldXP4oCUG5AV5vSubqt7KOdZ
         QqiniAFOzC+pHvjV407B8lcsIiLlukXMbAvGYhZMXPlwSbnWUEMdIIGoFuaHpEVJlEbD
         WA0tV32pDYkgJ6CH3GLHR5LYwpbgonv4/COmDPz4uELRMn8HGFrs4i4nNO5RN5kxspZ0
         iN9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787158577; x=1787763377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zIe6pwh84/cgjHJc/ZPARHNyhcZMHDOU3m6rWSmarLw=;
        b=on3fTs3rJ6G2DTVHCM+vlIV5YJpt23ButeWi2mYjm+K1GZmccdazMVOcAJfAqBzC4v
         rNVIPQtnJK7a63itkAiUj8fZFIiLFvvriDwMNM3Z9a/S9S8v5lhqXq02dwQGVev7nz0j
         Nio4SYga6gBvYLrdgIKin5MIPQUKOlv079idkaWVbfB8sld0wcQmf+slTNdHDyvPtRqD
         ASlZRD8kLLkJI/Xk/7aQSw7408XQOIAJ6ayf/yTepYZoAUPN/6eFCDraPSZM6jsg3i0w
         pulOvCQ8TbWW7P0UC6yWKLosSIbdIBWeDhOYegWYh16NHMGNebV6FFYq+UlmfmIsjsBy
         FqPw==
X-Forwarded-Encrypted: i=1; AHgh+RpnobdhJ8H52jjvO8/OYkuFegD497LuJAj8QzAzq5d5G9/9asLE28vxgfwBTvibRmfRhKAyVXL93Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyY4r+1x9FH1x3uKGRz2CYfoQvxgl5YQwjGqLAH8VdXjuoo0Nmw
	Io152umRC1hbmYt40LqDFUi3gFjG21EAwtDv/qscJ5fx6OZ/QdYK91MEk007bnfnuLsTtVwru4G
	8ZShdkmCe9NIRjWlqP6acq9uv6ACKGet5wQiyk+BbDUgA2l1MYS5ev1ZxJDPSFg==
X-Gm-Gg: AR+sD115VxSdDUDaYnp4ILiM4mbe4BlG0J2fCr+dDzhA3+bCVEiJT4cXJg3HaJOdh1N
	MmVBdz02QIQe6nYqluzYsbDcGEnMl0+rymiP7py3S7DCSug4ulOJ0Q8/bSyk7iFR1Vk+GOe/gTh
	gZqIIfhAcjJ9cYWkEXWKz8OyLQWcBZLiQHqpE8Zzgst9aMAsfVdXKV4dvp+d4PtCEbp6C6DgPQD
	X9wCOP1ev7iEme/2L0i3LW5o4q6dzZgfZEp3TyBEGGdVwIzvRvouEJE7YGrtv+cet5ZLCCu7oZo
	7UB00eqehSacudRrmfnGJfdWnI/vBA2NMWJWlAhGH6BOKDqerrBVrSXdHhDO1gR0GTDJhKxqit3
	kFoktr5Bi2eqrClR0whGgDVRXQgrY
X-Received: by 2002:a05:620a:1710:b0:932:ddff:123d with SMTP id af79cd13be357-9371e6f64b6mr620296985a.29.1787158577056;
        Wed, 19 Aug 2026 09:56:17 -0700 (PDT)
X-Received: by 2002:a05:620a:1710:b0:932:ddff:123d with SMTP id af79cd13be357-9371e6f64b6mr620291885a.29.1787158576588;
        Wed, 19 Aug 2026 09:56:16 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:2e33:a343:bae0:905b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b1441c78sm6952317f8f.2.2026.08.19.09.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 09:56:15 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: daniel.lezcano@oss.qualcomm.com, rafael@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v1 3/4] powercap: dtpm: Rename Rockchip virtual node descriptor
Date: Wed, 19 Aug 2026 18:56:04 +0200
Message-ID: <20260819165605.1398880-4-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819165605.1398880-1-daniel.lezcano@oss.qualcomm.com>
References: <20260819165605.1398880-1-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEzMSBTYWx0ZWRfX29otMuhc7TY4
 Usx6rUHrZR3jcawL18JrAreWUUfUcNbMPajXcIZmezF0xV3kQNhxq9vajMCNprgohNm5tDs85jl
 l/025k7ySkCh3o3uEvGTplc3CY/rZ+SaLQTRyqtbQHaclRMJ9RHmj7VOGQmK8tw8/bpIrtzomKx
 NegxsSLWniIzCh16RZ5gqDbl5v/l8PLkvulz8qrteOcJiiOfv7ZKJA0lCtpnGJ86j4eleULZq9h
 1VaHMPBCbwI+54grxiH81838BpkqA28e4TCueHhNQloX7VClucmqod0qDEdvn6lB8Wc9/HY5ec4
 SSFBFeT2jDUNUoJ1/K9J5ocFzk4H3okeuDCt3PSeiGtnBw/yKuQ/nPvpArN/k1iwGlVyU5QNIdL
 do4UiS9OP3++4ZHX4rGM5A6P4MvYHJciLA31XOWjyvWYhaS+tM+AkDLVEalTgavM/mOfUGk8mZa
 5Wum0fN4jNikRoRjdSA==
X-Authority-Analysis: v=2.4 cv=cuOrVV4i c=1 sm=1 tr=0 ts=6a85e032 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=_NZqlvP9bvTAGtRSC3sA:9
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: Kn-gIMih4o4pX-zONEOVVrnO7LWH1DBN
X-Proofpoint-GUID: Kn-gIMih4o4pX-zONEOVVrnO7LWH1DBN
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEzMSBTYWx0ZWRfX1GcaZtlaKjvT
 KZnPDFMVZzDPcJG8UYTVLJXy1AHVRlS/Ir2sVxSzPU702bK4zeqzBuLQFlBAqIYXfffb/p7H6Qi
 pcA0O1ejnPwkcHfAigs0DYTclytypMU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190131

The virtual DTPM node descriptor is named after the RK3399 even though
it does not contain any SoC-specific information.

Rename it to rockchip_virtual so it can be reused by other Rockchip SoC
hierarchies.

No functional change intended.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/soc/rockchip/dtpm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/rockchip/dtpm.c b/drivers/soc/rockchip/dtpm.c
index 451417ae5715..5f7f238a15fe 100644
--- a/drivers/soc/rockchip/dtpm.c
+++ b/drivers/soc/rockchip/dtpm.c
@@ -11,7 +11,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 
-static struct dtpm_node rk3399_virtual = {
+static struct dtpm_node rockchip_virtual = {
 	.type = DTPM_NODE_VIRTUAL,
 };
 
@@ -33,12 +33,12 @@ static struct dtpm_node rk3399_gpu = {
 static struct powercap_node __initdata rk3399_nodes[] = {
 	[0] = {
 		.name = "rk3399",
-		.data = &rk3399_virtual,
+		.data = &rockchip_virtual,
 	},
 	[1] = {
 		.name = "package",
 		.parent = &rk3399_nodes[0],
-		.data = &rk3399_virtual,
+		.data = &rockchip_virtual,
 	},
 	[2] = {
 		.name = "cpu0-cpufreq",
-- 
2.43.0

