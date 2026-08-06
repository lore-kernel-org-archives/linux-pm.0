Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4BD385529
	for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2026 04:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785991367; cv=none; b=KO36s3rNyiAvBflRP2UimM3tBiKGyIb+nyXXOe26StLCnlutv1rd01nhl2dkdyzntWNC+8cnBPk5jWpwi3WN/XIfFdrR/3wWmCj3L3UQ+EHuCTRcTFFbRR9t7VU2/6I5uXqzK1GNzqb3B1Ljao8xes19SRY1S0spZSgxq+7pQZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785991367; c=relaxed/simple;
	bh=KK5fOJv3HcE4z1ixBn/u7cnTTyKHDIYC3p/im5bWYUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lV43dsCyA+hHX5NssIJU14R4s1bd0KVyp2Twd7pcTGUfRA2snr8cuDqckkdH+mMt1YUTx6q2mHct1E6yWOGmWeaCC3J+AP4IH1VUc0anlxv9bEMHOI/9QoeQVEBH/RjpIlLDDoFvwdwJJ3Wd4OPopPSFYTaf6AoDuYsiCDRs89s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L4KNEc3p; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d8EOW0n+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L4KNEc3p";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d8EOW0n+"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675NbMMN170489
	for <linux-pm@vger.kernel.org>; Thu, 6 Aug 2026 04:42:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Oz+Wc6Bsoqf
	slMI9UaiYcAde1YtVj4xAT63QnxB32cA=; b=L4KNEc3p9/E1GLx2B/KVClbUubl
	IsXHwNeLuoFn7qM9mq0xnjNXFQ8wqy0EBx0Zk4w2JOAdGHPo9IEYWjak0JQAe+R0
	8+FvAoT7inqX5BjfhfIUqLRUtWBf1+0isj9zzFCt2zuKe0FclbzRPLo0jtJVKifD
	wspqWF3jU4SmX8cCjy98gREH90Fi2KTTYSQtaDHcOVrRMQE8UNqpv3mFw9BHF/9n
	qX4kkQgt6E4iMXivWaVHnMTh4tNNEN+DXU4Swe5PIv+QIclYIjDer45Kj1zeFLXs
	8AjmElsyb8D2oiM6FlhlyofZZtRfYUTJFIsQgWPWY+3Jk+wdjAYsLPfo4uQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv5x5um2v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2026 04:42:45 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cf7dd9fd91so16652815ad.1
        for <linux-pm@vger.kernel.org>; Wed, 05 Aug 2026 21:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785991364; x=1786596164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Oz+Wc6BsoqfslMI9UaiYcAde1YtVj4xAT63QnxB32cA=;
        b=d8EOW0n+4+F8HgW5D1w7qJsr4a+DAkn2NXyyYkefGcUdXCd1f+WPkJz8vi+5+BBUli
         AJoSHYC3/p8hww5JNxf4VMYCo15Ca2h1gV9JjwKcJgNGxM6wMsmQ8aH8iQA2XfuEZMgp
         gByJQFmTToFt8SvC4JUrzL/5z9pCANOCio3AVw+u3Lu9Oe4KgXnpvRg+aFd8t35Vx84+
         V7Ubks5sA0eZkN75y06YSFJw6JGhbWUYBSrIZrVnfX9elydwcXfWOzr95ocS5kPnlIs8
         Rj5Fzj9ZDTfQeJ6RYDpb1Z+OXaMucbdjslPGE5jKhtmwpg+YX+XylQKNRS8HZptuplur
         EhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785991364; x=1786596164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Oz+Wc6BsoqfslMI9UaiYcAde1YtVj4xAT63QnxB32cA=;
        b=JIIjCBSdHv2nVVQ1FVibfP6fGCSZU+iJkU9zVP3TSIr7Cd8KIoRM5C+N26QA++G/mb
         fJKLBtQybR3xPvt2FKIspYoj+4b24wsWC3VBfdOqsVRd8mdeuB4ARET7yeYR0SnA2+TJ
         3wxzZNapOfZQfpG8/wPms9F4wah1Lcuqp0bAnfcuMjMnHkgU63p3q/MgJ8XdtTTgm8up
         6A1FSQWxJ7h/nMjkHyDj08NvcFHScjhxuZdxNyR+iBU0T0YTC8pofpoR++G1Pgw5TVNZ
         8lCbK1/hxCP1rur9OrZImze/5FJk3+szZFTcJtDBQGDqRUxmoSaUxKnXlKUzOkdxbxfg
         eQKQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp5HHCH6XYfybnYTVgTnoB/WIri+F6egKQxoAc0nXXcoDxrapc/UcttmQWV9EHov3Cks7LSCXkR6w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu6neT60vw2ciSS+PA14Q/Rdx7WJ+swunZAayzwCJMB00ErP5r
	ul79e4X/OZ7LWUgkZLL0cyUokfaCxqFX3oF+fFdmlJ1cdmE98jGxI8nDA0wpoSFW5oIlm8sdZKG
	O3Ku0+bOiKZi9t/Zyc+Z6F04Z6IK3F2hsl6nYwZENdiORT/raoxsyGj8LjXaOfg==
X-Gm-Gg: AR+sD10NVW/W3Wqmc5YXWZCy3ND5U9R7HNz7UA6gdVai6hBJeryMM82SKzVVRAn6ZkD
	MKOOr6In3ODC4yDljgWNTvMlGV6yeUAKpHi8iDo6FWSJUm+YQhFlCLtuu54+5GQrJGi2J2uPJ62
	L8Iy7fZIVgdV+j9Sz4ZicgfJPcJv7IyxDz4c3ExaNDpkSJEa/6BtTCLOs1W+5rSLxyp/6dcaAeO
	HHapbtLA7qA4IKWyJf8b1qVLK/zjP2jh/+Kla8aHuse/kILshLVhmDwN1xk7ab4JmTiacs/+rvV
	ZKYrvZ1nfINWL/JuWT/So8pdJdOK65uL2EKpB265ryDqMkKQsA7EJbFrSLz2lEiVcO7fhICW0sd
	cvtKlgDsCLQEFqQ6E4iZwKGKBlif7WxwaLDkpjTvah95p2m9+mYccUzpXLASjT8zGindR692Lri
	iIDeiSSkYUeB+j+5I=
X-Received: by 2002:a05:6a20:cc0e:b0:3c4:3672:ba6 with SMTP id adf61e73a8af0-3cb85efabd0mr14830169637.22.1785991364314;
        Wed, 05 Aug 2026 21:42:44 -0700 (PDT)
X-Received: by 2002:a05:6a20:cc0e:b0:3c4:3672:ba6 with SMTP id adf61e73a8af0-3cb85efabd0mr14830111637.22.1785991363750;
        Wed, 05 Aug 2026 21:42:43 -0700 (PDT)
Received: from hu-sibis-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31586402e53sm32643473eec.11.2026.08.05.21.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 21:42:43 -0700 (PDT)
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
To: rafael@kernel.org, viresh.kumar@linaro.org, mingo@redhat.com,
        peterz@infradead.org, linux-arm-msm@vger.kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com
Cc: linux-kernel@vger.kernel.org, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
        linux-pm@vger.kernel.org
Subject: [PATCH 1/2] cpufreq: allow cpuinfo max to decrease when boost is disabled
Date: Thu,  6 Aug 2026 10:12:29 +0530
Message-Id: <20260806044230.909961-2-sibi.sankar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260806044230.909961-1-sibi.sankar@oss.qualcomm.com>
References: <20260806044230.909961-1-sibi.sankar@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: B0wGsWETOGiuOIriAg1sW6gnJ5BXUfkk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDAzMiBTYWx0ZWRfX/9zSCqHkqNkO
 RVKddqSlD28AA4rUKNVLEOqs2inxdy2KVzXApapj4b97BX7m9fGlW3Z5H3ak936QEYI+npNR5IO
 agt7THp6c8lHW3vToiE/nleaAvgJGKoIBURzctcg8lpFEweWGlXlgwMoSzxy60xanXLD2RzRp62
 0UvkM9JNk9r7wXiymRnLMx2FzNG+a9JfOEfPrD2MKrsxLzIbY7aK7a7C0wv2HKumEk3M7IIMcML
 dcl7pym10DBydChmKkljlPB4Ms9w3loz5yKs2w/ufzRW40+2FAaxWXG9oUJ6FqT8PbyOqCdnlR0
 BwVmQHYgbITHx4w6S5uL3p4c7jFbcrsXwW0+U/eLJ74c1YXzPirjFuSwF52//nG8wmvfeVpuJi0
 8JZDASreM7kVhN7MsqzVpYP1CrmzlXsQ5DICPmrzKbu7U1ZmIrlF+nmTKRT40Jydjg931XGAYVH
 Wt62AZRcj+9O4HXQOuQ==
X-Proofpoint-ORIG-GUID: B0wGsWETOGiuOIriAg1sW6gnJ5BXUfkk
X-Authority-Analysis: v=2.4 cv=RcygzVtv c=1 sm=1 tr=0 ts=6a7410c5 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=OnsR6Khfw191TVAs058A:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDAzMiBTYWx0ZWRfX5e5lTZESq331
 hu14NaFNeI3h+WfthopKX87XqjIhMiPHNGIpR25jvB0xMg7G5ZziQnNUxaDtaupOjmvZ+ZPMpDW
 Hy0QWkLIIe36rTgngXRUM6yYVhsRGqY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060032

From: Ananthu C V <ananthu.cv@oss.qualcomm.com>

Commit 538b0188da46 ("cpufreq: ACPI: Set cpuinfo.max_freq directly
if max boost is known") guarded cpuinfo max updates to only allow
increases, preserving values set directly by drivers above the freq
table maximum. This prevents cpuinfo max from decreasing on boost
disable, leaving policy max pinned at the boost ceiling.

Remove the guard so cpuinfo max is always derived from the frequency
table scan. Drivers that correctly flag boost entries are unaffected
since the scan already excludes them when boost is off.

Fixes: 538b0188da46 ("cpufreq: ACPI: Set cpuinfo.max_freq directly if max boost is known")
Signed-off-by: Ananthu C V <ananthu.cv@oss.qualcomm.com>
Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
---
 drivers/cpufreq/freq_table.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index ea994647abc8..791118466ca4 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -50,12 +50,7 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy)
 	}
 
 	policy->cpuinfo.min_freq = min_freq;
-	/*
-	 * If the driver has set its own cpuinfo.max_freq above max_freq, leave
-	 * it as is.
-	 */
-	if (policy->cpuinfo.max_freq < max_freq)
-		policy->cpuinfo.max_freq = max_freq;
+	policy->cpuinfo.max_freq = max_freq;
 
 	if (min_freq == ~0)
 		return -EINVAL;
-- 
2.34.1

