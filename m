Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE954B8DF5
	for <linux-pm@vger.kernel.org>; Tue,  4 Aug 2026 19:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785873493; cv=none; b=kEJ+L5lXtTMNquSvr8K7Bcp2fVReuwJxCJcMnh8TfUes1zteQVUGXXRXSCNe8s0e4UAB/DA6SqOANW+u7H+2SnhTqYMbhi6mqh4B0OYqn1xBWmDxN3YcFE3/vZ1p2JaY7Qi4LFzA4uV2QL2vtZoOEcb09Q+0qjNY6+NyVEIOa9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785873493; c=relaxed/simple;
	bh=QHusmMhaGbIFkLVmVmgpKIxh1LPrPBJEiHcg0koGGmY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N8qtwHJGJIBFKhvL3uxW5Q0LMyAFQyVTZBnGQjEzQqMtrNnScw0BH/8eN5xoVnbrV7KuRLV2wOjSnna4MmLpAhovcxkpT07/vRLKn01bbdN79tPlAQWncgGgLFXDpDPAQ9U8i39cgGcUnPAFrcLgJB4Q2gKdly29IWQJtKjacO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bDzRUF6A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L8PjozER; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bDzRUF6A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L8PjozER"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674JlQUL641292
	for <linux-pm@vger.kernel.org>; Tue, 4 Aug 2026 19:58:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rNzC3IaAnkPqtcJDYyITkxHHLY0+YZOnhmPnAjsn054=; b=bDzRUF6AGiYwU31V
	sKUzppBV/TmVNZW4HBN0zogVQ/S+kQkMRGFn6d+DNoPUNpDQ1lALXnEDEZTK2Ktt
	RIR4HRcQWw0tUzjAbpzuS+PnsUKUnh4JAfENHT7wtVaxOkVc5/8YBCSvSV81OE1a
	xl1/qg9C30MJfMQDhAweUQwkAvddAU+/BOlwCgEkRfdd45eFHvTATC13DiMQ7Boo
	2e7uj7j0xSU3gjsIGe6C65Vpq2JVz9vPZSiH2iy0RBqAZrxe2z87vQBmqrMFPCx8
	slRNMuxOKvUlCznecZWZFzof8fSerwRVqJfnmqQSqbik25jTrTyA53pp/8E5BLc1
	6usgpg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fum3nrswg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 04 Aug 2026 19:58:09 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cfca8558d2so2955735ad.2
        for <linux-pm@vger.kernel.org>; Tue, 04 Aug 2026 12:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785873489; x=1786478289; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rNzC3IaAnkPqtcJDYyITkxHHLY0+YZOnhmPnAjsn054=;
        b=L8PjozER8DK34tRVhaqasaeOC6f6GcgQDiG5TIX+pimElr9mLnML4JPUqve9tgTuT1
         J+wKK+jVNtL4K9yjpPAH/LNswcrRbShozmxjhqGH1n2m9TYw6u0h3mMufPtPs5Z/h8P4
         LLyxnIvheVR7uIrHPbGxHaTa40vEDa70Qk+VLptvVzzwpLgRbX/e260daDjwd4rbX/tm
         0/bMdOz/c5uztLuYGmYV5pQGfb1PrSUG4j6CHZp+goxexL5XdsYvb9wzb57h8DM954tX
         LaJ2bQ2cR7i+Ht8IrBaRB/x7nU9FhgCSkrs+ZF+n+/t1CeQ/8jK+oiLIeR3FYth/70k8
         fRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785873489; x=1786478289;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rNzC3IaAnkPqtcJDYyITkxHHLY0+YZOnhmPnAjsn054=;
        b=NaVx9OAJJItWlqf2CW+mIKcLTOGpbF+GoZ5uptKbkPTEL4z/dAwMWpDMSrxoUXTNuP
         dH6k4XamYZQ+Ex3OECjx1mQ3wgIqHpILUheTvu2z0Cm0BaKTDpW8g7wh8OlHDcoU8T1A
         4bbO2gKrqt68x0IPHbRCNclfJhCffdQhH9Nyzd82yRQuQdYV+3TS0bfJ8pN7HmOYp5oW
         PcPe5YShGJWLrQ/+YG76ZHOyENjdlT0SEEi2TfMM1WTKvZSn9UGlkZN3LYN/ehqVD3OC
         mOncblZdGMd+UqLStZMGFeMsGBAGquSbk31Kl/L5Spk5qqdwNFMe45Kbh/gdXA05K8XH
         OHMg==
X-Forwarded-Encrypted: i=1; AHgh+RpvmLnS7C/wWLcY3psbiRpiBJ/0Y1ej+ETc4NUHo3+z65L3bfI70ltzqdAikcjq1XW8V8ptJxyuYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDcZtKAoOQEhli6PnF5I2KbHjo5nTVrC/H2jkzbX9MiBrOZJ2H
	lrRDP74X+Uia6VmNRCU5coGdio+CO/p6umbxue21ChvkzfUIjGpC/5pZgKQlm9Onmi2BmbzPOlt
	Rrrfu3jxnBhXrDjeo7/PBtxuGuabO5+SA8QNtAOujeZYhIUDZ9nNoecwYAqxw9w==
X-Gm-Gg: AR+sD11hnjx8VUvFx0OxG60CQBFVtGZ0HydU7vtAvsT/RKiNpx3pTv085y2tf2EQjX6
	3+Z20cGF2t3YNgbkYlEJwpoIhN4ESdrq6lN/Kbfksg1Aj2L3ByJnaRj0dewobRh6JHiUF+Ee9DF
	gZcT693bL4yIMOV4rlg9HbGEn8jBwBBAnavhnXiyWwm8+RIXdon9XvcU9Or6EYWtX+N/5BP3RxX
	ngOeKvRk0nXoj36ntTu7ebDzS03lDd9EkGudBrJstwxBpHcb0h7G3FDwFplaXRiysKgnBDBxbKV
	7zZzKevjbQeDR8Pa8Zd+nwT5MnVHUx7DTPGYL1upen3f3Ou26aaOXfSX+9W/S23QwOmzxKiZvEF
	5cvwA+fFU0zDILA+7SnD+UBdUIS9ndK4fKg==
X-Received: by 2002:a17:903:1a6f:b0:2ce:d957:59c4 with SMTP id d9443c01a7336-2d0ca7afcb6mr11223945ad.6.1785873488798;
        Tue, 04 Aug 2026 12:58:08 -0700 (PDT)
X-Received: by 2002:a17:903:1a6f:b0:2ce:d957:59c4 with SMTP id d9443c01a7336-2d0ca7afcb6mr11223555ad.6.1785873488203;
        Tue, 04 Aug 2026 12:58:08 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315867a68fdsm12316636eec.25.2026.08.04.12.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 12:58:07 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Wed, 05 Aug 2026 01:27:39 +0530
Subject: [PATCH 1/7] pmdomain: arm: Fix -EINVAL from
 scmi_pd_set_perf_state() on state 0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-1-61171ab1cdce@oss.qualcomm.com>
References: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
In-Reply-To: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
To: konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785873474; l=1262;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=QHusmMhaGbIFkLVmVmgpKIxh1LPrPBJEiHcg0koGGmY=;
 b=7NY2Qy1Uo7WrW93Aafa/QMqSQ+Cxokh+1WKAM1JvMN9b7jCvxdSzi5lT/yaqVn42n6Vozm6sR
 p4joM409JU5C8U5yINalro4nLUuP5VF3/aH1robdOvX6a4UlWUTsGBG
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE2MSBTYWx0ZWRfX+5ssyG8gnqCG
 OOirSgK89grzG4Yz07LF5wIvyFz1tVxC6SiZASm6AQAkRNtTo+5gNOmTjSd8tTEwVl2z4P+bKHc
 PTXJccnGQIjKb5MprF3nUYK/to3VYd8khD4cq/19L/fVj0az0+MRdI9kn18rUYWM45hLYxFenlm
 UNZOFUz75FH2vf1Iwm0CPaGJ1RtFxpCmgKGjEVSKVYOESEjD5QPSSsmxWXHGcr/rZuZ1OAZQa7l
 XpxcANTZMwQ3r6Nx+Fc/hyzCsql0LaENruuZqGqUYv6vidkQ6hfs8KGQ5btBWFCubhCkTMYLnuo
 T86zmKX/9C8ASmHZTSrcloYe/4M2AkMZNuklmhscHk5X0o8m1XL9/fz+d0ysJRlWeGjktIXa6o/
 Kz/2x+TtPJRuLtmLpnRHu5AC84Gti9CwZYjKv4m1Y70phW2LOkDjQZDvv7TIiSk0+F/M6qs9M3z
 zeopTKbc9oGKIf+TWHg==
X-Authority-Analysis: v=2.4 cv=AZqB2XXG c=1 sm=1 tr=0 ts=6a724451 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=sIx0R2CjXXeYvnaWutoA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: EUtdXop-IvdZ3P0LHl45g28XU2PwGSwB
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE2MSBTYWx0ZWRfX70HLWJjbvwee
 BsUHOkYEXAfG+iZTl6VRinYqE8T4sFiWvfrGuWi6phnaFEUKHOlFx8IThYQTG51NvIx+UaKp32v
 wmV3viuyDz/1y2d6baJxo0TgxO7LnUc=
X-Proofpoint-GUID: EUtdXop-IvdZ3P0LHl45g28XU2PwGSwB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040161

Currently, scmi_pd_set_perf_state() treats a performance state of 0 as
invalid and returns -EINVAL. As a result, devices attached to SCMI
performance domains can report failures when relinquishing their
performance vote.

The OPP framework use performance state 0 to indicate that no performance
vote is required. For example, dev_pm_opp_set_rate(dev, 0) is commonly
used (by firmware or linux)  when a device is runtime suspended.

A zero performance state does not require any SCMI performance request
to be sent. Treat it as a no-op and return success instead of reporting
an error.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/pmdomain/arm/scmi_perf_domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/arm/scmi_perf_domain.c b/drivers/pmdomain/arm/scmi_perf_domain.c
index 3693423459c9..e390f902a444 100644
--- a/drivers/pmdomain/arm/scmi_perf_domain.c
+++ b/drivers/pmdomain/arm/scmi_perf_domain.c
@@ -33,7 +33,7 @@ scmi_pd_set_perf_state(struct generic_pm_domain *genpd, unsigned int state)
 		return 0;
 
 	if (!state)
-		return -EINVAL;
+		return 0;
 
 	ret = pd->perf_ops->level_set(pd->ph, pd->domain_id, state, false);
 	if (ret)

-- 
2.34.1

