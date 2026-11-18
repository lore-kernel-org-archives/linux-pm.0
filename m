Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795018237;
	b=gQafFljWW4E5W2qlMAqiqmX307v/MTZZ+nQ140N4B9pojHmfjyq+Hr/a+Oykfpt0P9S7
	 pho6+IfdrByv4xaf/yZmglG1r1Gfj9l2VT2ygIUFK+p1MwaCyhDmTRg8p1e4dgaC9tB6H
	 Wm1AkW61COCLvAdscm8txpxSJ2rOMFB+fiYHO2ipU/48I2tzXwWGI+Q5IsMP1qdexU5VD
	 cMrCqaBHNAXyfUdhmn6qvEcZkZ6MVxn1/SM/9laYwvGPeFEQohcDLTgNdEXnmpwgM9mHK
	 EIlY4I3PjDZWoDKilEogFA8ISISTxWwPrOqYT8Wz5kySRzlbOIgrBhFLGhfhgulliwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795018237;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=6DyjFwh0daqRWVGV8alAfLhW51+EbUV4ESRE/kWsbJw=;
	b=wjFjt9vzMLqW9vRORyVJaplTtVYhKeFRphRyaNIeB1N91tvY20a4Cuy49eExl4XlQdvP
	 Yyk+gMnFOdZHs7nBtbju3Ef0MBH3C0NkY6EHW85wR//DfK/iFOlbYfQ8p0pzg+POvToBG
	 DxGfTNB5DK2A/1zK4bbN1UjN2RmuS5M7iKZGRzNnhEElCJC++kSPIEBuacKRJziXKdpaS
	 f2j7heVrL/R39mtCJwlxq4OGfhHPUCfgpe1ixpWaPmDY/pS4DKuj82m6BDk7f4iwNaQm4
	 DeSb7xmK48rzsBqBFgQgki5CrevI+ANyVF/8tSpDFh8gCO6hvRkLoxZ53JoHStThaag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LiZ7EFEq;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OHl64Xew;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A348C606A31C
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 16:10:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A348C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LiZ7EFEq;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OHl64Xew
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIDQ9ji376574
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 16:10:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=6DyjFwh0daqRWVGV8alAfLhW51+EbUV4ESR
	E/kWsbJw=; b=LiZ7EFEqfkvy0Nv+KTC5X1Hlg1C5MuL0h1McdBJnli2Y0LcnthZ
	bnBOCzt2Md1WNrt5PsxTVvm0jw0C6aDUZvsOmM2uXA6HiO3DGGAcXUqFFpD0jWS1
	YdwflRKmpbYf4ljA/MfyE9aip9GN1XJCpJyGn4x4s9/b3jCvWdd6GPcJc/SUunHt
	XEVokqUpyPX8U3gKNG7VKJ1SBzWPsQOf8wW5StYj71m6ONvFe2UfulqRZHSUo3/O
	J0ispPcIVNfsRZ32n53jRa8qvN12z7UOSUJ++/HaG86iFss22mAmW45WhiJgBJZS
	p4Ki82l92r82hHnoRwTwQGSmUtZM6DeS1IA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv9kwfy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 16:10:35 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9308eafb465so278221885a.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 08:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795018235; x=1795623035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6DyjFwh0daqRWVGV8alAfLhW51+EbUV4ESRE/kWsbJw=;
        b=OHl64XewA4JeYQifG1nKORMHIvv0o6PcGSqNsc5Ys+z8RP7fkps2oqAfDnQT/VygH0
         oaC5eHd0rrAmBo/EVElYOFmBTksMrMVYba/vNF6zRJn1jH/Ysf2TJcmt0f706cLnksG4
         wwNcItGTGfaRC10rKkMPzyIsVmfpJFoKEZeF088iIZ1jerpUqFQNmrc9ccE90Q9+R6Kl
         ZePfzdhYJStm0XfImAmAILs0lXxFoRMyBpajgIMdIon7zgcC6pRfKKHjeCNtz+gXFWxH
         BasjJdMpl7E1TDLLcv8gSRUBCTMidS58XdQHFJsONtPRv7/XKsrYr7JWEdFErrDC9DZD
         QAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795018235; x=1795623035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6DyjFwh0daqRWVGV8alAfLhW51+EbUV4ESRE/kWsbJw=;
        b=B1pO6Cv3hkxRCl01FEL6fvXm4lASHPAqAeTRhF3YyuANDqsLvWV4AXNu4JNyTbMxks
         HDASe3N48YFGk01F+7UtjYtUXkJDxv8T+7larX752OA+Hz3nmh0gIn5Avo+19Cjy8hgo
         EtGw7uJeJu5tZOpMrFLxdn0gbpViXvBfcen5IdEgyh3MzNvqeO8Eoa0x1BfVe0AjRTL5
         xVDGNggKKS4SEaEWLYy6zn++9GZ9YwHBp9TyIPQJDym2WomSZ/X5WPb4zYIG1eljHOe7
         JuXsa0h+b0W14KAhJ4oTq+HQsjVE8hGR6Aupkd23UsoKfjakyDK9gfxFrhPV1YVbVJ8y
         YU5Q==
X-Gm-Message-State: APuU4Z/4qrgLZEzQPv71y/ibY3wi+FO/9qlOD/X7U0ZRDPpp/sxUFVtb
	GIjLSnTEz6PJspYdJCxx8+nW21n3s2Xu5x5JaZV8oOfcfkDPn/C1mxlQ1Oqd6Xj2ONUIKMBD1og
	VzlIf+p4fSRRb+cUrUtGnUPinQhrbpIOmQ9g3VXldh9FPY4dko7fL/xg2StEPBw==
X-Gm-Gg: AYBFou1vD5Eklxj4Oul8Mk+Of9tx5qLE9UwM7IT+EL2QchLDEEumPZRfHxW0eNPdRtN
	E0QKeZQDGkJShQ/IC+gWqjn7hSeMMHOwtYFdgBZVsOwqIcXnnY+xKGXrsH4UYzhQ4Aj+06bYJJR
	HNuSmpJ2G3EVqWeC1WDJNu+gAeeuu1lSENmX1fWxLpH+L4moSHdftNAhljdYsbInFw07SJlXJnW
	aV7sH5c81laBIfWKjBLM68qxX9I1SRsABMRFhUYOIGEPLhIBERUh/C+pnK8gLSRxRyjYHWPelDD
	+BsbX9bsUpl4BUaIFJCjXfqgCVe8sBKuoO1Bq+axogeTb3HHkiWUouRI/X1vaHPjkbdpJvdDYUz
	y6/XE92Va4eJF8CG/3BKNi2/MXGu5rhTq4Ibub4PezFjfo/i8xrsZh2bfuctOs1E8d19IhgDaQl
	hc
X-Received: by 2002:a05:620a:4551:b0:944:d7b:e7a with SMTP id af79cd13be357-949995e12fcmr574564585a.52.1795018232214;
        Wed, 18 Nov 2026 08:10:32 -0800 (PST)
X-Received: by 2002:a05:620a:4551:b0:944:d7b:e7a with SMTP id af79cd13be357-949995e12fcmr574519285a.52.1795018228092;
        Wed, 18 Nov 2026 08:10:28 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:d355:fe70:14a0:ac8d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a65560911fsm5762628f8f.26.2026.11.18.08.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:10:27 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org
Cc: linux-pm@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
        Mario Limonciello <superm1@kernel.org>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH RESEND] platform profile: Restrict the core prompt to COMPILE_TEST
Date: Wed, 18 Nov 2026 17:09:37 +0100
Message-ID: <20261118160938.3057738-1-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
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
X-Proofpoint-GUID: OevTZKs0n1T6TBSmJZf4kABMGba2EUS4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA2NCBTYWx0ZWRfX7nYDUvb+y85U
 YCQ+pbW7raR7XNK0qHh/+mT29CrPn+AvxdbST8N+UO1vk2hYMLu7vopeHp26M3WCiiky9d8lSuF
 PKq/32hfw/FkdMaaiAMjXPNPC4Tn9kc=
X-Proofpoint-ORIG-GUID: OevTZKs0n1T6TBSmJZf4kABMGba2EUS4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA2NCBTYWx0ZWRfX1s9/5/vYtu/d
 hhdjOZX0CpCdYwNjtU1WcVHo2ZZ+KHEoTvYV68w6yVHtzGG3PeMLnD5PlLcygy/5zEtwpigkM6i
 uQBSHQS4qkZKGbu7fpmzqaUdUHFRtgSVXkrnRylnUdhq45/ZYpsrxbvMXcxII29B65KBxCtMJr7
 RbZFkwqlRx17y+Eoj1kVZuRtK4JKYrGrTuQ4E+76E/eumkwqEmm8YWg2eUv/185xJKLOR2ONKwj
 N2mUyFtrOrzjxE33hvDQKK8/QEqBoO3Fke+MEwVmZ9WjlKMjVzcpnFQsdEJTdnWgADUvxT9QdxC
 v5ahW0w6fz8FKTyuyZ6EQ3n0VCZ6G7uONQ/mmovzhpNMT8L8v3D456fd+TFm9vS9dlkwJa2FMZ7
 pL7r14OxAtwhXa07j3znxnGESYF88B2NeSxS6BQQee9Yrnm/D6x5/maRBceJzcEhpUnz+bdqXGI
 ytIOQLXPfM4UtRclVzA==
X-Authority-Analysis: v=2.4 cv=RYIFmFtv c=1 sm=1 tr=0 ts=6afdcdfb cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=tBb2bbeoAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=XVxARQIAAAAA:8 a=eSez5piW9hGb_tCy0SwA:9 a=PEH46H7Ffwr30OY-TuGO:22
 a=Oj-tNtZlA1e06AYgeCfH:22 a=p77dMD-AzHemhwI1qD6W:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180064

All platform profile providers select PLATFORM_PROFILE, so users do not
need to enable the core explicitly.

Only show its prompt when COMPILE_TEST is enabled. This avoids exposing
the option in normal configurations while allowing the architecture-independent
core to be build-tested without a provider.

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
 drivers/platform/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/Kconfig b/drivers/platform/Kconfig
index 7270f24a3b6e..1cf87904afc3 100644
--- a/drivers/platform/Kconfig
+++ b/drivers/platform/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config PLATFORM_PROFILE
-	tristate "Platform profile support"
+	tristate "Platform profile support" if COMPILE_TEST
 	help
 	  Provide a common sysfs interface for selecting platform power,
 	  performance and cooling profiles. Platform-specific provider drivers
-- 
2.43.0

