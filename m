Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C10E3B2FC0
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 09:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783070684; cv=none; b=HkvigMz5OCkNfeYjRlSDW6zugRqBjJaXVgpcR/MgIqoe9GwIy79PViHZ4WRud1TE2gaenRe3gZs80Q6S2DR2hhi/EQ/9OC0DSdsapi+JrbvAiSxUcRTVs+zcrG62nTKYRVWEn2XmYgVql+Rc68cA8KgQcTtm4SIn1ubmtcAEh/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783070684; c=relaxed/simple;
	bh=HVU8/HLjh2z+c0yTI6z2mcSFuDoKM9OsT9bhC1RQbnY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Db/bBv0cnm1zJFjg8FqV7YxAexGMJpoIgkTJbBlIQd9Wau9X/81iiWe34uGe+1ujWHvNSZAl4VXH0H4zqITx0f35dgoTSIUT3msC9BQPVIgzwo5FVmBcwxD6aOsqrZQLfqnKlCPPjlwBYPv/lYhxJUvDwbGvoodS5mnhrqzoIJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oQHx27Ep; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g4im6dEQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oQHx27Ep";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g4im6dEQ"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6635rjuc3108915
	for <linux-pm@vger.kernel.org>; Fri, 3 Jul 2026 09:24:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=cGaNwb3I1K5UnAhzyOmxF6Nb8xm/UogbvGV
	MLEDyxrQ=; b=oQHx27Ep+jppx70dJ4Nyc5f+tW6NO3OY/HMdxXQ9l2l6eQwCFZ1
	3rCVcL5zRAM2P08KlgAcSxtZ4IFdHxfuHflAXjADARGk1kAeyMXqzJljlsfhcpGZ
	I6bhhHTmPV5wbz3JrTq8iYufgSGBRus9/bAU24tbSgQLsB4iPdi784pXcSiFhzap
	5rbvdAtTwtR5mYnNY2BmFYFiahzCI9LS5ghXA9dnWcM1MBykMrOKY9WVD3YsEgqY
	TPD/Cm9tNLS6a8MhD6FL5IXSOx2iWw289XfVUrgECAiua3oAVyNDKG63OhpkZE99
	b4WJf8IIC6V16b0v4OUxyyKMDIjrewcmROA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f60eyaaq5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 09:24:41 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8479b45ad08so656054b3a.3
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 02:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783070681; x=1783675481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cGaNwb3I1K5UnAhzyOmxF6Nb8xm/UogbvGVMLEDyxrQ=;
        b=g4im6dEQXLqYe/CWPhpZyzN9YVwPRkHlYFEJjZo8MB4W7V+LCdrwZVIRZ01n06IOGi
         vFGSwrv0y5rRq9cQch3dSzaJVfqQHpE0qAWTMUC/a7W+Aw6KLrbkSYbzj0DmxGe+t9qn
         yr1FNxlgdzPmmFiRBeypcv49uWIOs2tknG8Jlsu9wIRvI/zAUcr8Md+jeMDZQkcpqGMo
         3mMP0L+YQs3+ZAdHhbSebgxhsHlFdmDMXDzEMzJalrLZZbxAVysJ9rTt9YMPJx1IRIHT
         XQHvLVzn3jD+uvu0oXjDbwe+Z9Ex2/fnp5VHbxKNWC1GRFtb39cAHtJzyv7Fqekg0RHz
         whYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783070681; x=1783675481;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGaNwb3I1K5UnAhzyOmxF6Nb8xm/UogbvGVMLEDyxrQ=;
        b=pwJkpmu2NcOH93NBs4jK5UCqpPCNKGSegBQvVPeiQrcCAj57hHpXZy2dpEZLTuxJuL
         Mqx+jz4d6LkQPkIogMboLwkJw/tQDghqNcYjZp0rNEcpmCCe+HxX03EzyaoXps304rIb
         B6U1M4o+anzsEzTCCA02f9dKbueRyJ6iKGdWqWapCX3uGd0BOEQbnHmEfMkaaawljzh8
         xibApdN3hLZ3nOJ/eeA1j210zPOilv0N4KeEFOj7L1N2yBvyq7RykvIzI4ZMnXHU6QCw
         2tHRJE0/RYzXOF2lvEwqO/BDnHVQ13WXFVBfNvuOfXqKscS+xP+xFANbmPcvFUG9n1Q9
         IHWg==
X-Forwarded-Encrypted: i=1; AHgh+Rqi4RIV7aTjVoVHtFrfU3JZgOfe+5mhyemwN4TTIcqIPyxdG3s7L593z+B90fAfeViwIDMDRBC+YQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyiZJeGQ0RLi3LQqeJqpy+w8icDW809up1ZbolcitpL9HiB6F1
	TV4DlTHwmPbeL0ZSeQLKa4+Zr5DHKk6LvzXZSJP6PK5A+0r3BKlyrffsD5fLEbeL93aiaEwIkIw
	DqgIXLXyFUQLizxLIuFdBmxpVcou33OaVQIMHB+zW9lhZUcfTia8U3fL18frqWA==
X-Gm-Gg: AfdE7clCwspa0a+VlivC6WfCQqcmBM3djffG7XykZgj0YKBvdG4oyLS5Rl4yuEDs+Ty
	O6mAAmlg/rzpN5hQquyMTYOwx7AW5Sl+snmYh3qFzeG6GFhi76e0s9jvTpnhaeMy3teZeuwEHxF
	pvpqb/LjrI4zQ9UKoYKABba1zuR2b4OyM6ZM4Cw9cPKgb8w74zl+4zNOgYI9kdpenIzLMwbBcwz
	tuGJrka5nQVEd2OUgpxqN2xNuJEE4Ae3MdhWZyRMpEbit3r8da9T6Ww/jAOHOcWk1Ug7rX3/0hq
	EyQpoK58tVYPH4i+ZuYve9TaJxbRnAg0K6atnc/91sU8hIx3uS4afG2f4PYAbfmcW19Ud9pGfp7
	KlDwzM/zh52sQDd9yeh4sM/fsyWl7Nek7j0QBp05vZMW8l2VRPq/QQ5YuWI/4ObdOGoPinxzOxn
	Q61g==
X-Received: by 2002:a05:6a00:3016:b0:842:4b88:20ee with SMTP id d2e1a72fcca58-847c090a61amr9103683b3a.44.1783070680584;
        Fri, 03 Jul 2026 02:24:40 -0700 (PDT)
X-Received: by 2002:a05:6a00:3016:b0:842:4b88:20ee with SMTP id d2e1a72fcca58-847c090a61amr9103651b3a.44.1783070679922;
        Fri, 03 Jul 2026 02:24:39 -0700 (PDT)
Received: from zhonhan-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb947651sm2595743b3a.29.2026.07.03.02.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 02:24:39 -0700 (PDT)
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
To: rafael@kernel.org, viresh.kumar@linaro.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, kprateek.nayak@amd.com, christian.loehle@arm.com
Cc: joel@joelfernandes.org, patrick.bellasi@arm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhongqiu.han@oss.qualcomm.com
Subject: [PATCH] cpufreq: schedutil: Fix self-contradictory comment in sugov_iowait_apply()
Date: Fri,  3 Jul 2026 17:24:33 +0800
Message-ID: <20260703092433.4080165-1-zhongqiu.han@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA4OCBTYWx0ZWRfX1hBg2WLtZQws
 LXG4tg9cy6LcEDSrHgGnSt1WjiJbtoZLln9EXhe76Y7Bi4BFZGBvgzRzpkEqxC7Qbe3GLZbsh4a
 m5Z19uf8aBv5j8rspu+Rqt+GE07TTR67BnSmzKGooFH0MP9xrv+M1wzQKTGt0QarxLVxIXmq3Dw
 lUyOYRamWVfxhdn2bUgT07EdNH6EdU5d02+A3+kfrg0O15GpFr4MBQ1RBqEAGwcV6khADBUTBJ3
 T7RpLjptYIr29GhlSBrvzXcAnVMJLK8HKFDYvNk7EjRFjtWObS0BrTPxt/WsVSZS4gz3UER3syy
 Y6hW7wzhVuq4B38IobxKVKU3oB0+YB55THDE04akGvLzvyj9eX4C8LB60D8P7T2k4G5FKkUF4xZ
 PoJ0OAcF/tbcZwF3fj90ek8BvLQhalIgPyQu5rTOkYpTnyAMB0EQlcSBQtSAtSS+oMiLoUGweBd
 yfH/56CFm95S8Mmmm5g==
X-Proofpoint-GUID: 1G4_R2LZ698HvQ8sfjappTssTPV_HMdL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA4OCBTYWx0ZWRfX3hL97JZseAZc
 BbU5oyGfAWRBYu1UAcJ+am0Picm1knJlJkfDCEtGUk4pmOOGftZhfydMcw/SqG4ptPTY5270kH5
 /MUMuCIoCqKIoHjzs/rw3H3u44Q+BvI=
X-Authority-Analysis: v=2.4 cv=SPRykuvH c=1 sm=1 tr=0 ts=6a477fd9 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=HVjeMj5qTong-8naV38A:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: 1G4_R2LZ698HvQ8sfjappTssTPV_HMdL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030088

The kerneldoc of sugov_iowait_apply() says the IO boost value is increased
in sugov_iowait_apply() and, in the same sentence, that it is decreased by
the same function. That is self-contradictory, and the first part is wrong:
sugov_iowait_apply() only decreases the boost.

The boost is actually increased in sugov_iowait_boost(). Fix the comment to
name sugov_iowait_boost() as the place where the boost is increased, so it
matches the code.

No functional change.

Fixes: fd7d5287fd65 ("cpufreq: schedutil: Cleanup and document iowait boost")
Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
---
 kernel/sched/cpufreq_schedutil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index a4e689eefdfb..f7aa26d62700 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -314,7 +314,7 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
  * A CPU running a task which woken up after an IO operation can have its
  * utilization boosted to speed up the completion of those IO operations.
  * The IO boost value is increased each time a task wakes up from IO, in
- * sugov_iowait_apply(), and it's instead decreased by this function,
+ * sugov_iowait_boost(), and it's instead decreased by this function,
  * each time an increase has not been requested (!iowait_boost_pending).
  *
  * A CPU which also appears to have been idle for at least one tick has also
-- 
2.43.0

