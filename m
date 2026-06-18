Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DF03B71DA
	for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2026 08:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781772331; cv=none; b=EjgvdHXKHi8ufcswSsi9iELECksvxRoyelsbWdqe1qnA0NX0CiHeovm0d9v+5uqd7H6twysYnrfwi/jf0yxFMAr1vpy2xJuiup/HNedwj8434CmbwKE8fNjmi0Dwg08ktJWqJD0bljoS96OcCzKCETa0fnG6q75DUglXy1HXbAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781772331; c=relaxed/simple;
	bh=HWEk7qekRNu70kccP3km7XKTyuw+pe8EmgwvOad7GGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=i60UAFkfKQ/YHP4vYmOWt0uShr8kAF/9vfGJNhNzC57jRpSbXotwk3JGmbsWIXCJ4ffT1f92P/DO1EyVwRAQPpe2yGxnJPYKkE+h19NlIoUJJ2WoPlfJcSGIoYSENXrFJPUr5UQlvWhm3HkpKN9shuMqhY2zOUgIwxW0EP0llZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c/HZ76tq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EIKg+cLN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c/HZ76tq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EIKg+cLN"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I8DgWT692869
	for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2026 08:45:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=wKbqSXhfkpGeeLX9AyiCEI
	WVqjPPgKJafjWrRh8/jOg=; b=c/HZ76tqVq/XZG+czA81x6pyLFQe3Mqo20FZmy
	cdwR7f/vM1+1IV/Q5w6HGehWd9sBLaIl45bRcR/oG9rASZZE8E5HOU6ZhZbVRCfi
	LDiCamppjNaVRCMAtOrr87HvXuApXpZqg/JQAOXTaRgv3zgbyy5UP/RWKazV0Zih
	ie9bJe6fDMLlEGBXMKaspVkdy8BNQRurVkc6wzYMbDsGI83yP5AT8AyoSfKWTmz9
	Rl8N0Aw2mHhesVuPcAuSK0HuvzqZX2EAI8iDn5yDk9N67WAlB6z/24vWCLodH/xj
	1rBqpCP0GplBh+tZ519K4+AJP2HNaI3ANH8eMOZsof0t7ylQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eux2cbqka-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2026 08:45:29 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9159bc52211so140532985a.2
        for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2026 01:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781772328; x=1782377128; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wKbqSXhfkpGeeLX9AyiCEIWVqjPPgKJafjWrRh8/jOg=;
        b=EIKg+cLNFexDGGwnadE9qSWelcz+ngKUtmMyjkA/ZalH9DCxs62B4gkX35hfLue+Js
         /cRISh73yntfau8kGGNIgq8hT07a4ysZMHw/IdBnjUrwyNqrvbX6AfzMdPerf9cpZVrZ
         SAEl87vnBKCHR1CZTKwKjs3jd2qzZPiNLIZkcOAHSbrpa8xGwZHdm9Lj05fI8IXK+ppu
         nwn3hY/l0M00OxdKFMEUxdc2AWhKh2V1nerkDsIwBm4iA6MyaOZI1CMsPG7YlmESHje7
         HNgi+mJ8wBMtBUeFEQOFd5xVFAxsxUhSG5xb9icAh7o+CIUdHqkxHizYLxppubr8EvDZ
         dkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781772328; x=1782377128;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKbqSXhfkpGeeLX9AyiCEIWVqjPPgKJafjWrRh8/jOg=;
        b=sgaWmhJrxcul2noDTKURM+kGwe5UpjN/KClEgR+OU2Wj4GArOMcKFkmAW8C9PXoWm9
         f0aRCDc4Yy2zSkdVbL7McQxM+drIY0HjJGVvjKI1oelM/PtkXkiiNBI7/ONd3WXo5mvd
         sOibORhcM8ubmOgp19i1LvZ2ISdTb2MVdm81ReqiRApIwFpwby+7u3F1gxHIUaqF902+
         OEmajSa/N7s2YNhAMHT54HoNt8Kq9QPfi6YFcSaxzvlIYCOMwdn2bODP4iQPv816dOIm
         x28vLdLFDthJD36MQiVJvXBxXL8wKM18MwrWu9weSqEs/3AG/RBBqkzIY3aAKlFdtdc1
         aaRA==
X-Gm-Message-State: AOJu0YzFoDRXFD2Iin2zsoCUKKGzwPGySuDgqLuX8aZivT+7AuNx8x4z
	dfST/iyM6PyJwi90q46W5qavxVV99vWF+9oVIaU0ub5j3qEX+ZXasJWfZY0DNFviencWeFH41FB
	ML2Mlnb9DsAFD/h34AYrOQmuKZQGloey1nh+BxCTazQxdamw5tD6Y9YGxD3pWqQ==
X-Gm-Gg: Acq92OEf50yyeUI5onsLQFqlKtGOmxik7lNPsFjyaccNfQ3u7EdIHiO711W2361aUs9
	jMNedN+pKvsMTYPBcGarufrJ+8hS3SDP3pl8BZB8EQ1lreeVjXgVp07GoOOQ+W5qT4wFXmwwNWV
	5RzOeq5uLU/acnb57mnKo95ipdY39NkHdvYGTKBNRpVktDnlRScvtbVsQbfhqMjAPrh4nddjNI/
	PKheFcinfHO9uzWf7Rh8b6mTXAWsbYpYAjXg/s96sqc+T8BstdUxmX1MsBFp4Dnjfak0MwPFnuG
	R/WDiZlCjlv258PBbW5745pbzqy0lcwBO8pRP6PNbJL8chlc2Fz/g7OxmSflvZ/5NY5rEjhqA+L
	3zgFhBSjNDPAs4r8E7UFkv1R0FNKyC4roSRYDFCXu
X-Received: by 2002:a05:620a:1788:b0:90d:e71:8900 with SMTP id af79cd13be357-91f25f93507mr377344485a.10.1781772327853;
        Thu, 18 Jun 2026 01:45:27 -0700 (PDT)
X-Received: by 2002:a05:620a:1788:b0:90d:e71:8900 with SMTP id af79cd13be357-91f25f93507mr377342585a.10.1781772327415;
        Thu, 18 Jun 2026 01:45:27 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:41b6:7808:5ff9:cd42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2dbfb1sm65211538f8f.35.2026.06.18.01.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 01:45:26 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 10:45:12 +0200
Subject: [PATCH] power: sequencing: fix ABBA deadlock in
 pwrseq_device_unregister()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-pwrseq-abba-deadlock-v1-1-943a3fd81c06@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIABewM2oC/x3MTQqAIBBA4avErBtQF1JdJVr4M9ZQWClUIN09a
 fkt3iuQKTFlGJoCiS7OvMcK2TbgFhNnQvbVoITSQssOjztlOtFYa9CT8dvuVnQdKSFDb7UKUNM
 jUeDn347T+37baC//ZgAAAA==
X-Change-ID: 20260618-pwrseq-abba-deadlock-c8e201f9b62f
To: Bartosz Golaszewski <brgl@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Wentao Liang <vulab@iscas.ac.cn>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2753;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=HWEk7qekRNu70kccP3km7XKTyuw+pe8EmgwvOad7GGc=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqM7Ahai/59R1rGTE7y+Yv5ePU68stoVEqvQa/X
 vMzrtpOBQmJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCajOwIQAKCRAFnS7L/zaE
 w6SvD/46Hh2P1WvaVXQiPJW6GBh46vRP7YgPb6i7VithVplp5t2KU4FxRDFw2zmkxlmdmyCtacU
 zRpyaJPtplgcMBBbXDzuKa0zdJo0UcGo608FcmTbhm+u6LaHNooO1umrbnb9EpHqSLgX76LQj/B
 59ji6X1Jrlx1+KrruL5PHUWRMIgKD9ENjr5H0C2KWrIE/hJiPrW3kPjrvVisVQcQP/jdMqIDGTx
 JC4wHCQx44LGFRq/lTxjo+c7N0l/snBsMkdsKRUO3zNnr9GUY8jcnj+XP9g0Sg1n1OLPd1RneiI
 qEMKu6JT6ta/U8s/94NQ6R4BhMTNEPpTLisBvRqkyumCDF5qGyASDhEmk72ZtdhhK279xdF74KA
 uzsZTsAUSbKFicOwsqElHvJ4ZpJVcQKrSvR9ELzRmNjAK+G+iiGyuWiWU3+nnc74QrEoVe49iwW
 /DUCChNh8zUH3kQGSjx0zkbXxR0aiqBf23sZODmTLs97c/zxPzkFbzN0qyFFJcVgodZshoQ6hfM
 DlJa7BHXKMZZnPCgLfpOwt0Jiopk3MvW72GqWRkhLdbyXEQ/ajBHWjHqNecqIYGjZlljBiNh9C/
 219+DfQ08M27WoBk3Mz+l3TgKDYxPMKer60yUvvaDDs6nlqgLOLtV0LZWhd+QdlxfKrEBYSXltl
 /AY18s+MwOWsIRQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA4MCBTYWx0ZWRfX21oPyKeuVWF3
 eMVVLvcxtsLVcEWI1m7LbLsXgq4fBSvMFmKBg7PQT7eOQHMuylvJ+h9oJS4YhFcQkCC1YVOPvRF
 AiVBtQzPym7pwg1KrotTjZ7FCm5iNrtMZ82/NhdVgoYgSXVM4ZEMkoxr814W6NHSRLt+Bbje/nU
 aFBdgadWpuVCjssukRQroHavDYuuuIM9ZzZSo+G6mCiYsygjHMQLj1LovAYNR+gBYojcG/3k0do
 1CppSwnPVmzviCAlrkxb42hhF9Ix8bIjdWRkzq9cl3vlpqxFwAHz9QEA0Ka7dkDKVMpZ3mDoY+o
 eaaGz10ROoN73SzKxEEXnka8tubIjHNI0OkWLfPIEpzrF2rpYvKWxOdCMMsILJwnRyXRxOAUEfS
 e3Lm1e07DF27z/U9XQC3Jb1XsRDL7FQEd6/6ItY9crKlTxh5Lj1/sYKWhe2/mOjTC1C8PBViMN5
 jwlM+WiQeof8UezFOXA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA4MCBTYWx0ZWRfX8KE8kE+Rhxnz
 kVubT6yB+ke0osi9eU8Hg56x11vqw0qtmFwlR64Cc2uo6Mpm7K9s/Y0qO2B4MEyOwGcHUHugfhz
 Z8UJrbZBaq7egElkMeoSsDKe2QcpgFQ=
X-Proofpoint-GUID: kTnHyNdM-Fd6q7qTOA3L11Y-ZxCXe8xF
X-Proofpoint-ORIG-GUID: kTnHyNdM-Fd6q7qTOA3L11Y-ZxCXe8xF
X-Authority-Analysis: v=2.4 cv=WN1PmHsR c=1 sm=1 tr=0 ts=6a33b029 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=c92rfblmAAAA:8
 a=EUspDBNiAAAA:8 a=mm6afyvw4zEZKVl1pKIA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180080

The pwrseq core takes three locks in consistent order everywhere:

  pwrseq_sem -> pwrseq->rw_lock -> pwrseq->state_lock

pwrseq_get() -> pwrseq_match_device() takes pwrseq_sem for reading, then
rw_lock for reading. pwrseq_power_on()/pwrseq_power_off() take rw_lock
for reading and then state_lock.

pwrseq_device_unregister() is the only exception, it takes: state_lock,
then rw_lock for writing and finally pwrseq_sem for writing. This created
two potential ABBA deadlock situations that sashiko pointed out.

  - pwrseq_power_on/off() take rw_lock for reading then state_lock, while
    pwrseq_unregister() takes state_lock then rw_lock for writing
  - pwrseq_get() takes pwrseq_sem for reading then rw_lock for reading,
    while pwrseq_unregister() takes rw_lock for writing then pwrseq_sem
    for writing

Reorder the unregister path to taking pwrseq_sem for writing -> rw_lock
for writing and drop the state_lock entirely. This is safe as
enable_count is only ever written under rw_lock held for read (via
pwrseq_unit_enable()/disable(), reached only from pwrseq_power_on/off()),
so holding rw_lock for writing already excludes every other writer and
reader and the active-users WARN() stays race-free without state_lock.

Fixes: 249ebf3f65f8 ("power: sequencing: implement the pwrseq core")
Closes: https://sashiko.dev/#/patchset/20260616151049.1705503-1-vulab%40iscas.ac.cn
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/power/sequencing/core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/core.c
index 89694092981f76d750ca399d59a65c7e89d52051..ecafdf4d0ffa5611dc7637ca0a0e18b78e223896 100644
--- a/drivers/power/sequencing/core.c
+++ b/drivers/power/sequencing/core.c
@@ -543,15 +543,18 @@ void pwrseq_device_unregister(struct pwrseq_device *pwrseq)
 	struct device *dev = &pwrseq->dev;
 	struct pwrseq_target *target;
 
-	scoped_guard(mutex, &pwrseq->state_lock) {
+	scoped_guard(rwsem_write, &pwrseq_sem) {
 		guard(rwsem_write)(&pwrseq->rw_lock);
 
+		/*
+		 * Holding rw_lock for write excludes all power on/off callers
+		 * (they hold it for read), so it's safe to read enable_count
+		 * here without taking the state_lock.
+		 */
 		list_for_each_entry(target, &pwrseq->targets, list)
 			WARN(target->unit->enable_count,
 			     "REMOVING POWER SEQUENCER WITH ACTIVE USERS\n");
 
-		guard(rwsem_write)(&pwrseq_sem);
-
 		device_del(dev);
 	}
 

---
base-commit: 4fa3f5fabb30bf00d7475d5a33459ea83d639bf9
change-id: 20260618-pwrseq-abba-deadlock-c8e201f9b62f

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

