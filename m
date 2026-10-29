Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793293064;
	b=MrwOCLLvrpfwlFWtVe+H1hW0QUpAuRG6et6M1K4Ru99hB4/mmrXoS0/LHSZdFcblXRNU
	 wa1DHnV1qmY13PLU0TZ97hy9xUehq8dAytyHWbatp8ZbcaPGRKKx5fedVtdZy8WKA38go
	 QHOwfFlL4cRYH1qi8K9Owo3EsX0yxC76oHrHVaq9kGOR4ccqhbmKxhZ1plzAdFaN8Iuty
	 tuDEjJCRVbhmMX55QBkNn0kHqm2+qfIeEP5zw2pAKmXLggJ4oR48FwEs8cleuZpk+KJwR
	 D/DEINI9xg08GBqydePmZFy5EIr7wOz+BijU9ZzBJnnScpwSZ9vDoHKXxzqYo6l99Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793293064;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ytOjkYgyk5LlmjFcxh3gPQQdewa7HVP6wQzba4/f+go=;
	b=lPwqthVwP9r/PA6VJZ2xinyKVs9ykNa1nrARNSm4d5uQG6JgdAMixvIPdOanktIJoZkT
	 LNZYR/4iorG5Fc8/K5C8sWgFeL4WAhPqgCQU9NGNABIGLxAgZUA1t3saNumY0c9FmVt9r
	 V5VAM9EsoYW8bk4YK+F2y0TjfWaFFFdLqPVTwOb1HCnmSfTJ3YbS/ATK/1rnjwdjIqriY
	 G87PwSXVMuRGaJOiASw3GC7lOAqMhAMdvSDNvwdSPGxWnoUq16+ByesfNaB6ZjQoegYj4
	 Dffk8Gw548iozm+4L/yFE8IoodqrTpfzQLX8jWs2srM0ZAuA48TjxrgNfJjIZsXX/iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=K5B4EY4m;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UEjBhxH8;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43E560A2600
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 16:57:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A43E560A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=K5B4EY4m;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UEjBhxH8
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TGDXOv3234268
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 16:57:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ytOjkYgyk5L
	lmjFcxh3gPQQdewa7HVP6wQzba4/f+go=; b=K5B4EY4m88mryxZuLbPk7QKXc2F
	+bohx0GPOVwzeoz05M1vtTbY1G/RlSkU0t0d7BmUFdl2FGHmh2zw94EKW3kqyiDU
	M5Q2hQmVUQNKONVnE/q/FqJlsBAdZV2c41/yn58cj0e8XrAwdRE9xBEiJGQmlAcC
	tPP9kVwj2n9rHIP8EuVxpXWvwoe3+PQRhvUWLXI5dL2r8AvwXfC6DI3QV701Kbyf
	Ua7vj1nxum6/ahaYKeBgVjsOzDzlUuecvKAE7aZveMgc0xLOPOhAbFFCJnXLSGsQ
	W9ZG36XnnqtUdzHoyPbA/nPz9LykFPBypu0zpOFzWWKkf03ZSTXkO6WbGtg==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm31b2081-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 16:57:42 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-990aa76e3daso427353241.1
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 09:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793293062; x=1793897862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ytOjkYgyk5LlmjFcxh3gPQQdewa7HVP6wQzba4/f+go=;
        b=UEjBhxH8LEL8nsqJCQm0X5sXfub94BSpRqSJ//Cf7RVT5Yv9yLkxmGzVH7qVHZNYid
         Jw+KR3MtIX8QLq4DVu+9jF8WODum80BXsNyNT5rZ5MnqWdSIu54olOZ8mFEtLut1tLo3
         d4/MFIjq1CKQbkiM2h3145NPIyc5pngXNgGnPC009P9hIuz9VVDr+Dbk2ZGvxnD03jSe
         vOJEuVZ4BJ/9xWu+k7WDKts9RZQdCpPhfhA5yOF6YNEp84oa1wQezkzdw/1jsC/ClHrj
         N2zSRYFEMoVTdgSrE0yzzjMoDNWZxtYL2esVfz0ybCuWLelgZQtOzlIJm22bu9ds63fQ
         qE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793293062; x=1793897862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ytOjkYgyk5LlmjFcxh3gPQQdewa7HVP6wQzba4/f+go=;
        b=kgS1EhY8azSTDuYimgtdaYQdFuRsLxQw8bzcwHLPGLkEUx7PA09wVsAqR42Fu43IkV
         Wjj4q5NCvwbOTD2rYzMNgfL0EfwSd+IbO3smn011MURDCyPy863qiogAIZlwafLTSQR2
         JS3Y/QdOqFf96fdxsuWkNY5Va8/Emuzp6JSfQPtL1pxpffP8doY9ydpEo53BqjGFXh7i
         Nb+icpRWGzlqYGaE3kE7apAbYtiJVN1aZR7rJZE9TaD2q4KRpuvIl6vnSco77X5vxfBm
         7fkhsIZyIgyvz9QjuhdImoELkLYc8FwaYYYNVl/CoQ7UvplbuWepxb0I0d8M0BJRVHO8
         CW0Q==
X-Forwarded-Encrypted: i=1; AKwUvBzzlYK9WFDHyVmBXWVbAaOh5vWsNw/yOKItx3mXCCpc+HxUWz7LQu/QUrG3hoBn2H96qIV4P/o07Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYIDBPEjbN69n2J4FNbX7bB7ItpNGONBUyhf2oyoxcsXvGGap3kT
	LN5a2QBn7eXOyjF3Vb6LHnfPY2LyKSZ+NyJRUvZTdBs71+LdcDBodlHWeP1ls5aabNGos68o9aC
	zxdRVo1SiXSVTibHCJfchPe0fKKS8Ad05LO8r5izqWcTP7eF73yymQpV+2ba3Y6aCwhQ8iw==
X-Gm-Gg: AYBFou1eMgysA3256t0qn1PXhB6yuoQZEDH8EWWiohD4ciu5bHxT1ERwdrowNMHl1pw
	oCJiZkvxsBVV+Guj2qKWLj8Wdx0O1seLLjb6/y7R+L8TCNxBVXLDzdIBWKkiiM+86Olc54Oo1Fj
	xPjaIbNeYkOjlczeq24Q/axzlP9r6cRAwrbFomLmt2rdkr1N2uj+XlDQEDvClFSOc/g8fvw895i
	/0bv+UXrRV0NSkb6trsIjoV25zImDB22xDgg+kGTz9siUz28EtnbA8+tLFoxqPQ2qjY4Jt30G8z
	whVfZWHsm8+Dm+Y1Mj8VwHTRhfSKSFATuiXHKvTrrHKh93a0RJ0zERFEZw+Z3ZAP7+ASEAgLGrU
	SMWyKxh2VpwPK5UsFxQbYsCQopc1ujZsXp9yPRWFh0bV9IG4TQUQ6XAbIhEmorR+nr2Qw1N94Ak
	jU
X-Received: by 2002:a05:6102:6a8c:b0:7cc:2c29:54ef with SMTP id ada2fe7eead31-7d03a5abb96mr2605286137.19.1793293061843;
        Thu, 29 Oct 2026 09:57:41 -0700 (PDT)
X-Received: by 2002:a05:6102:6a8c:b0:7cc:2c29:54ef with SMTP id ada2fe7eead31-7d03a5abb96mr2605280137.19.1793293061411;
        Thu, 29 Oct 2026 09:57:41 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:7fbe:151a:486d:a2cc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e6df961dasm325669f8f.23.2026.10.29.09.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 09:57:39 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, Shuah Khan <shuah@kernel.org>,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v4 5/6] powercap: dtpm: Rename Rockchip virtual node descriptor
Date: Thu, 29 Oct 2026 17:56:49 +0100
Message-ID: <063f0587a6c951ca57e941ebab39617a0d0a305c.1793288783.git.daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793288783.git.daniel.lezcano@oss.qualcomm.com>
References: <cover.1793288783.git.daniel.lezcano@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2NiBTYWx0ZWRfXwWwV76Iv4l/u
 n4Nzr5APk8HS79GVPt62ca9GFSh2LpiEhVQGcZqXvz5xQ3m4WJD9F2bMF8Ssa/S49dKe6CtrYZX
 FzJgrFatMz/9QkOi0GjOWlRtGGw0jr0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2NiBTYWx0ZWRfX1cpuU8BK8erR
 H3VdfSTvbo+z/XGvGmqrXHhmobKnU4mQNX1M832DHyBcl+78i/1QfTWN/wy7TgRzP0LzyD9lgl8
 bhE7S9CFkWZASNX5p9J1p/oisQUsjAydHAs98D0sQ96P9w+DLMniJKIJB5tSRL2vgyBiFdpk27W
 N2huI8Zcv+HmYccO20Ji9Ntc96sl7XVlzgr9yEfJZsUxhKEqfJKQ4BGWGMfuSSyFbbWEjR8vljK
 bJTJm69lfMOK+DzJP7aa/8iLALXCLYCTLvaKekGwUo7lmufSQQujJhxRAqnSPEJkhiV8W2s8Us9
 wviOJfcRAnHy0EkE1wvbJufN6zqPnb8C1CADRfuwPRf6vj1F8Dr6cuTaWBtgah5zrj859c2O2Jt
 w1M7uLx9znT7/0nPbt7ZxO8uRRDU2ZnOFIdiWTD7oRasT0dmT3XIgxlxnfD1xIvAquMU8swcC7d
 qmttqF0k0xx4w2x3azw==
X-Authority-Analysis: v=2.4 cv=A8T5rKWG c=1 sm=1 tr=0 ts=6ae37b06 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=_NZqlvP9bvTAGtRSC3sA:9
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-GUID: awsLTo6KXBm_-MaocJpQz2WFQGdC9jM0
X-Proofpoint-ORIG-GUID: awsLTo6KXBm_-MaocJpQz2WFQGdC9jM0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290066

The virtual DTPM node descriptor is named after the RK3399 even though
it does not contain any SoC-specific information.

Rename it to rockchip_virtual so it can be reused by other Rockchip SoC
hierarchies.

No functional change intended.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
Changes in v4 (since v3):
- Rebase on v7.3; no code or commit-description changes.

Changes in v3 (since v2):
- Rebase on v7.3-rc7 and refresh context after patch 4 style cleanup.
- No functional changes.

 drivers/soc/rockchip/dtpm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/rockchip/dtpm.c b/drivers/soc/rockchip/dtpm.c
index 222d9098cc98..5ae00680602f 100644
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
 static struct powercap_node rk3399_nodes[] __initdata = {
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

