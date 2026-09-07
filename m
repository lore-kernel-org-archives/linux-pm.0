Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A5B46D2A4
	for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2026 11:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788779848; cv=none; b=kk4HuIAkdznUCxbncnVqRYADaatQ0Yrx078BNllYywKTnyIwh/zsRY2z/zNMDwwMZcUU0L68tRv7CY0dC+tDrOBPcoaR4jW5GlIDLd0daRE1rZHdGNSDXsizQA7r3p4fRAK9sr/uabZAJYGPNZXWK3CtHl8JfVMIEROpzrdMytw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788779848; c=relaxed/simple;
	bh=zSX96X3WCPvjM5dc/JWy2IMD1tZ0uShhAn1gR2rmBYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uxB0e/AzdFgaj6i68yM7QnDqBvVoG1PguZc7HydB6743OIGtSLM4lB5Fg4JduS5mMzzcHSnckxaFidW2ipY9dSDffzgMWnb+dBdWYOMN3N+Y2xNBFKhtPCdn+JIDqBSzk06Nylsk/BBpPDjlveD9ZHmwX/JtMTOefXPNeBX8euI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g8uy6qOQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WRr36WL4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g8uy6qOQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WRr36WL4"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687AnAGp4064247
	for <linux-pm@vger.kernel.org>; Mon, 7 Sep 2026 11:17:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=9tO/GYw7p5Y
	IziUo24tsiXtwALlKjEcO4Fmzh7zgI8c=; b=g8uy6qOQVIGVvsD2K6GsjaXCXFG
	r3Ui0eAvc91yHnD5W+GmiHJHMRvQcYZLnzqrMfjN38H4MrDFlfzeQPfmDWK41dO5
	nQQe1pYDQZW30w/eoJ/dXXVkHQh5kEVcx5Apm3QnlhDK6PQRz8wonyYxmQOvspux
	ER5MXktsOe5FXBNDy1gq3n///03usbWxWhZE+84soPMBxBogBXFN63WSsfl/4RrP
	bX3nf6KyqFQIEUqMYefKInvTnJeGzvQGhWb0lT2mu8YtWk27ziqOKnVMIvpIiVYD
	pEyz42YQtiuIVCSewASRTN5KcSUdBzZ6/9+egFztiKzeMDc8OF/THK5SFEw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghs86rwmx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 11:17:23 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e820609d9so570496485a.2
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 04:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788779843; x=1789384643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9tO/GYw7p5YIziUo24tsiXtwALlKjEcO4Fmzh7zgI8c=;
        b=WRr36WL4spfijeCDFYneV64MuCJoUkLJzpuZUtcn7RwGurZARIXN2YztD6M0cOOvRg
         PCNCGj3CwIKMHBRCrowUaAj7cRdY8diAFmrOZNl4anU1y46fGsInQpP3l8BB2/RRLJBr
         0QVdPkjx0VpFNa66+tou8H4V+4Aopr6xk8B+PV6LayVTBNeK3Sw/lGz8Fn2hGNo6+Qcw
         psWTxZ+dgm8sXvjdLoGGpqHgGazDQX2hCAu3h6yrh6SP7MZRxYtw8q29S7B3Q1RgDGAL
         oIwGrqoyCSPQjdeE+wDZBidzjLJnSDPvZIqRLMVcQaDSUO8E4X8e+ypTnoQZ/qF4QqD2
         iHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788779843; x=1789384643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9tO/GYw7p5YIziUo24tsiXtwALlKjEcO4Fmzh7zgI8c=;
        b=KQMARsvG07jmHbDuDUGr79TPqAeEFgyRfCphA4s//msNcIV3SwNTHv+0jouTuf2++l
         WqJVx0BBm/W/YUGRnPiaGwRFAF46w3/CeUgRQhV0Q5BzH8eiOwZ0QwJbM+HlH4O8d8HT
         w2tPkepEIjSN0ossnno1xDJUmMKRX+AnZFhylakECZGqJsN1KZamFqgAoxuXl2mRcdz3
         AyK0A1/7WIKos/4h/mKllVfWRhmo2WXppaL+DECaPJbg35GVSzv/9EqVUWnkMEaD8R96
         7RpEs5lIcXJurgeEtGsuzfxNaJa9O1LbNn7o1FRx1eVBhFXeMPSyG/CdB4GVanKBYjUe
         nwzw==
X-Forwarded-Encrypted: i=1; AKwUvBx86Sq3eGEJX/hSMxTgUbjSSp0rmcl0DdgGy/gHYAFg0hyU5FL4jBc1e2f2EAEKp1prjDLMsoTdug==@vger.kernel.org
X-Gm-Message-State: AFuF++lofVNFKT2eWHRquz7E2/+um7+GKAM4wdmXTJGtILGb/nznnqa7
	8+igFXRiWAY2x8zRQadaNUcxf7loE3BIhXBpSjnGuMFaJra6K7G2ktAPSptZ2ylpRjWVsANwss8
	5uyF32cexzzH3Pr8tdYiqFClFGzqFx0mruVTgsWgJZgt9G/78urMiycMLin25Yw==
X-Gm-Gg: AYBFou37iQLCei97sSs79WhvkEiNjbcILk0MxhZxL3o6PkB831vokOUDlDng1bcy9HY
	45reyuW4JkX4esez5YG9ozLJfyOBZYeN4Xo5mgebA1/QzoaC6YWOP7ZWOlPD/2rgWy9RH1DOR9F
	aVxt1M2H07kXA5kJwU+iGv8087ZPauQ9EylU8GaVwUBivNdEzI2hzk+6R85dt/r2dSnQUrO+lRn
	s4OeXkpUFwMwadMxZDGzICR+gPT+WGUOp9aMaRv8YfEacdhGV+NZOKtt1aMFOLvZVSth3NbOp15
	gxdlpExiNHW5p5DzDscwJSZqy4EPsapfznGqve4zpo1jA4Pcsw7uyWgaYB+wOESAHus51FHWXa4
	RXg5WFTD2rQOh/X4WXNMntoHOFtvFzBzGZWAVAQfHGEMQCYIoqgbGQ1AJQA==
X-Received: by 2002:a05:620a:13d7:b0:92e:8405:7ad2 with SMTP id af79cd13be357-93980462eabmr1638327885a.41.1788779842775;
        Mon, 07 Sep 2026 04:17:22 -0700 (PDT)
X-Received: by 2002:a05:620a:13d7:b0:92e:8405:7ad2 with SMTP id af79cd13be357-93980462eabmr1638321085a.41.1788779842315;
        Mon, 07 Sep 2026 04:17:22 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d5cfaa2sm456120066b.59.2026.09.07.04.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 04:17:21 -0700 (PDT)
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
Subject: [PATCH v3 5/5] cpuidle: psci: Move initialization a bit earlier in the boot sequence
Date: Mon,  7 Sep 2026 13:16:55 +0200
Message-ID: <20260907111659.263324-6-ulf.hansson@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907111659.263324-1-ulf.hansson@oss.qualcomm.com>
References: <20260907111659.263324-1-ulf.hansson@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: v2VOaUpQjTS6ocJfGsbuIDbiR9twFGr2
X-Proofpoint-ORIG-GUID: v2VOaUpQjTS6ocJfGsbuIDbiR9twFGr2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDEyNCBTYWx0ZWRfXw/aY3nupYKsF
 oSyyrCMa4RkPbt2dUnL9DgIGY9rXFoVbOc+vxkvR/4zVq7sAO4R9GURhq5y47ZrJQc/mnoBKUJB
 KVUm6shcDZK5IelZEX0bd5eWUksm9Wk=
X-Authority-Analysis: v=2.4 cv=LseiDHdc c=1 sm=1 tr=0 ts=6a9e9d43 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=h7aNHqOhPKB91FvYUefsSA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=lJEbMRRrfWY45v_ev9wA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDEyNCBTYWx0ZWRfX0LfT48cFjC6u
 SnEejUrg8xIDvLnEWDUU55vTLK3mJzKJHT8+hnyw8iTkfkHsamYJ8BtFbiVD2e7QFlvGwS9Cos3
 8M4sm/Ook4OBP1cjTxSh2ARRfXxcH6EJwBd6qoi6sTMVrdlV4fRxE/PWs/mAFSn3efEc1GzsojE
 GhNT0j2Vo2Zbw+DNtEUf5uj6kDik7qR7MAxUKrXVbLBpoV8ZyUJXJWQoxEcXj19WpAliWUjUVO7
 UpDejs25KwvOpEKadbpfZptd7K+BwGfE/bdy8/2+IAopu+iFotR+S/NbfLtBvdoAqP7lIKaSjNt
 TgZqycteyIm+xW27QDtJfAPUWxL82t/M3xSwwxXCpZXnoflPTbJut+4O7rApwIGpus7WiLTMLGb
 UYwuMN/3xB0TSVbHBh3xAHB8mRXChMfAK92jFD5NznToT4fS6drutr8ayaT7a0wTT6Xr2yUT/mL
 FQjUnj+N/3tSQRc/LLw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070124

When using PSCI OS-initiated mode along with the cpuidle-psci-domain driver
it's of great benefit to attach the CPU devices to their CPU PM domains as
soon as possible, as other non-CPU devices sharing the same PM domains
depends on it to allow their devices to be probed.

Let's therefore move to a subsys_initcall, which should be soon enough
after the cpuidle-psci-domain have initialized the PM domain topology.

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Tested-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
Signed-off-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
---

Changes in v3:
	- None.
Changes in v2:
	- New patch.
---
 drivers/cpuidle/cpuidle-psci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index b250d0dde760..0187d6a9096a 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -479,4 +479,4 @@ static int __init psci_idle_init(void)
 
 	return 0;
 }
-device_initcall(psci_idle_init);
+subsys_initcall(psci_idle_init);
-- 
2.43.0

