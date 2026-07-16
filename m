Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B803101BF
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 13:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784207756; cv=none; b=WG74SWiuaYoRuJ/x+XHO1lGhFFAi6eVD/MF9LhtUbhFlenPOryy202MvN7YOMZKYB89Phi2XnzGlySeeDMpTsEYo+x8s8GGHV8oTsM/IwSzXf6TslUmNzeam6t4O/BtQWjYT8EKd/vzea8NvQqnsIO7ckOdtZhLZs0c/W6K6D0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784207756; c=relaxed/simple;
	bh=gOT3MuXhmmDaCdsYwkspavKbnXI2Ou2Gi5nDhVqR52M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YaNfTD7cCKQZ6ltTyAwqB4HKbXy4wLwhXPGXZMO9ooK3/mDOwkMFUkUszZHrq/J5n3Ht/uJK3FjCJkSGUxvBEbZAgcqFFKPPbwB+hJXvSpB0Ax+W7tGi6JDuRPZ3Q5rAkTHPtA/uznPsE+rlzN+TIQsrAIdAgTuvAIG+dRpdBbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CPR0xbTq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C46BKDXV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CPR0xbTq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C46BKDXV"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GBiXhm2475212
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 13:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=XnQtHEhuzthj//QHyutL22JKvv4JKRo9o6q
	1sSR+o/k=; b=CPR0xbTq7M5/HsMRCNVUWzZ9kTEmc2ZHqHNytUSwgwSHQPRSBQE
	eHvuwPySenx1KIr8Chfw+IanpxlOPkwMnFmdfhOcBkFkqfdumo6cPlECvCtaJN1o
	mHzpVmfm9WJ7jXGhMbkWVCK4yaBVGfNfkhCcBJ+CN15TSRyHumtq03skIXwhtBop
	aG2OOyuMvNvVvMdiutqKlUdNexl+HmOo3HLFrSWAHVUfK2nfzK36THTtOQIZWSz8
	Bn6CyMSR/yGH78e2tDCe+YwzWJ4SPt7QrGNHxKI6w6s5wVPcyu1gp7RHOu/xdstK
	iED3ZrHfwSmFviWo1GWLUcS+iUKW8ZiVpIA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fetb7shgc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 13:15:54 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e04a53a7aso4427735a91.2
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 06:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784207754; x=1784812554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XnQtHEhuzthj//QHyutL22JKvv4JKRo9o6q1sSR+o/k=;
        b=C46BKDXVCqkBjFv4zah0XJ7nO7NmOqapyJ6lpF4CtrB8BwBZGVMzMSqYRwzxaLYHif
         ldcFZLCJctOA0McZbD2MrQhBz1Z3nKctCVf7apCD838YT/y4jzKVwO4/wdTENq32jPUp
         2BVvg2NEybOL1uoREVaj02xsitAk7BC3kHZMpL4FPZLGAOrpuWfWp9xeBpzbQZwBT1JO
         1HaEhLWCc4mEnqA/KXRZpdXAQL6W+inClhDYvRbYtTbjdLMaVd0geSFTb2Z+2++kSk2/
         p9uKzMAtTTsxMcTYSlvDxQTCnfrATvdfrK4S/74juGR0X3wuvUsLFawttbJGKfo3e2KC
         FeUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784207754; x=1784812554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XnQtHEhuzthj//QHyutL22JKvv4JKRo9o6q1sSR+o/k=;
        b=e6XHMLv+ogxC3rrLKs3TdNtWQYefIcExwEtsLdgPz7DfHXnolkU8IG5GQCm229HNmo
         zEBej0qzi2IKMQLHqTH0uH2qPDiR7GCCxj9bo0pzKVWRrSzO8a2FgLLLqGzxUpwN/TCg
         KD2plCYP+1ClYeoudBS53LYukwI1Donz7xJaA34NuJgPezd1+qE7IDFvj8Md098sppfr
         p/bH33/QZKG2OaClytweKVbkq4zgSoUOxf1zLryqws9gYBblibkySt2dEzwoHkgxz40C
         Q0Nlm6iN5bbdIgz26NzJoJM2mjwAOb+Bpjx1XRxKAHNlWRvKEtYKJ+JvkSYbRj242LvS
         /4pQ==
X-Gm-Message-State: AOJu0YylD5R5VH0C4TGLSUO6TJQuPSAHAN1yqmC+RSIO8VOzk2nUlzj8
	MTpHrlcNK1L4kKUJHdxHh9SCLtw1aoEL1mYzd3Xk8qpYMjd/jsjqEoKlGUXQEuoi/jfUC4zIC4u
	E/6P4WDZIXUCOheRCABPakjEVNjOriVkPlweCYlFRgij3bEH2OxiBXR3UTiKCHQ==
X-Gm-Gg: AfdE7cnwD/afnbeS+5arlEqFolcsjE9sd2slS0t9lh6h+iUKHdGqcM+aitbkJ3z1M7d
	ekt9FZHaWx9ZH6HgdfWJqJD4wibiqH/T2elhrxMSqCETFrrNVjZVOIL8tb9F/+iXOK1q/W1qGYM
	RtbeezTyNSti1jPzfXYbbfHnmJIYrUc/ul2g0vBZwJgCPA5wssTD3c2HiOa2Us8+lpSZxbqbJ/e
	uAPCWzmXGz7of6374AZcTQWKQtjXqzNHiHvqcrtrFH46dyXAwaqpPKmuzvED25PedM6pcSS2Tt0
	vy6/k/6GHq1aXJIGVopfzS6mioM3JWvYQ5GUi1tVhFbaGyBGjO25DZ6ZEqHhOrvaq/r15IHibu+
	IFS7ChdVvlwPBIYzwGaiY5FXhYYHmIu13+vyRiP5bXVd2XQ6+g8cs+Qv03BTUNiMO/as=
X-Received: by 2002:a17:90b:4c02:b0:36a:c4b:76cf with SMTP id 98e67ed59e1d1-38e2a0c346bmr5764778a91.23.1784207753549;
        Thu, 16 Jul 2026 06:15:53 -0700 (PDT)
X-Received: by 2002:a17:90b:4c02:b0:36a:c4b:76cf with SMTP id 98e67ed59e1d1-38e2a0c346bmr5764739a91.23.1784207753069;
        Thu, 16 Jul 2026 06:15:53 -0700 (PDT)
Received: from zhonhan-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e39e4ac51sm1284008a91.12.2026.07.16.06.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 06:15:52 -0700 (PDT)
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
To: rafael@kernel.org, viresh.kumar@linaro.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, kprateek.nayak@amd.com, christian.loehle@arm.com,
        liaochang1@huawei.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
Subject: [PATCH] cpufreq: schedutil: Replace sprintf() with sysfs_emit() in sysfs show
Date: Thu, 16 Jul 2026 21:15:46 +0800
Message-ID: <20260716131546.1159644-1-zhongqiu.han@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEzNiBTYWx0ZWRfX/M4K/SJ6Jvcy
 5pqY0YcKs2FMgyREXDlbdZpcAgLrjbcBiej/pcyYitykjc49PX3dTgkSzVk5BXWOvE0vUCxQSKe
 3Cyfykpy/pMBHoFv+z7N+fb0SoooYdI=
X-Authority-Analysis: v=2.4 cv=dM2WXuZb c=1 sm=1 tr=0 ts=6a58d98a cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=kMfCKS_JZJ-YtVc-sdcA:9 a=zgiPjhLxNE0A:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEzNiBTYWx0ZWRfXxHDudZWSmGyw
 qCXEnhsnOFgxHJCUQCUQQ83pHJA0PdD4CxL7C8/6lnVmNMBn9WG+G9dxsr06j+m6B6sOEsIJZrW
 NQ8Zrmflc5e6zNLZiwcpgxfw3leXNbfJxywQsXsjp6UIe6ggWj699RjK8tCXMV58FRf6eubE37O
 xg7tp342JmQGqxUiKJ5T4rdtufgQo+B4W5AGN9BCCr7i2OQzFI/5uZ1btNEEamTCsGata1uaEAk
 ZGpQEnueA8HCLakGE8coYpSHeE9o26oAFmUhf9QSrVXapirtekYE39x/1+W5AKfYOJg5b9trFIt
 0KMV37c0HYodRE+SKX3chfrm3MM0ZyvwrZf5s/Y6zlw3BKSdmUDKQdR/C6Prr5GAnYCnxBmF15k
 rtLEYo3JFvvgXt0f9wUUF4/sohptIs9hWxrctll1mu73EB7z86WwPSmrsVUqYaLh/9OZXn5uN5t
 M7aw7w3eX67riCexLeg==
X-Proofpoint-ORIG-GUID: p3whaV-8s96uiA8LFbt1qnr10VcGXpnf
X-Proofpoint-GUID: p3whaV-8s96uiA8LFbt1qnr10VcGXpnf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160136

Use sysfs_emit() instead of sprintf() in rate_limit_us_show().

sysfs_emit() is the preferred API for sysfs output as it provides
PAGE_SIZE bounds checking and ensures proper sysfs formatting.

No functional change intended.

Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
---
 kernel/sched/cpufreq_schedutil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index dc0835ceee98..96651873345e 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -592,7 +592,7 @@ static ssize_t rate_limit_us_show(struct gov_attr_set *attr_set, char *buf)
 {
 	struct sugov_tunables *tunables = to_sugov_tunables(attr_set);
 
-	return sprintf(buf, "%u\n", tunables->rate_limit_us);
+	return sysfs_emit(buf, "%u\n", tunables->rate_limit_us);
 }
 
 static ssize_t
-- 
2.43.0

