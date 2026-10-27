Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793108019;
	b=2TDEkZ2UILWzSWx4NDtZ5oJNJR+SQKFixkZDi+qTZiLVxM8ZPqU05ESUDKee0RFjJlC5
	 rz9pZX/8eDEAAYdxffMfYXIC1O9/cIB9KCDTUNZVOqjXO1G7FCw2FuNmHJObxXV/0kxxH
	 ppduBjrUagnJZib8QMbKRra4hLsgLeXopPhSSMbKTk3t0fzo4ieY7rOrM+KChfDeiJHmq
	 smUwJnrUlovDXKB6owWF57pjmDLRjb6ag/m6gVmTWNqLTGQvRhjt/QvAsS1/AcPtqjrcM
	 pXd1MRAfTbh7Zr+Ssb6JXD08NfQscmAS8mF/R+QiRhcalzAktzpBJPkBUuZAr/5foCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793108019;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=VhTrCHgNWYcect8PsBRYG/AUQupaCriJbSZPutukaL4=;
	b=Rrdb0+Y/oJJHncJkwJK8iM+UJQCUoa09YNT6awZQ1bOOcR7hrB5Eycovmt0Axi70FGVA
	 TJgI1HWbp+Mg48xK786t3BBMYeFora5dimlr1F9HoSTjC+nGOhOsUC/JblTc27FhJuQ9T
	 2OtMG6OWhHUDFx2BfQYO4cxsQpfZLKGWwmnH6WBpGyYGjOc3Y3UirVIXf8pRxoTeSRbd9
	 kw/qllYczyZ5xEOwVBN2UzyCKHXG/qG90U0k0u/AjzljPC84J4zMJ4v7CNoqPC4SlSmUQ
	 gxHspRqsCDz/i2x+jh0QPyNOfa4cV8f91Etauy0XV8az2ziZn/xHPdk5PVWjiLCsKLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cXQyxX7E;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YAAV8iuJ;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB53F606A321
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 13:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB53F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cXQyxX7E;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YAAV8iuJ
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RCOBKB1124998
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 13:33:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=VhTrCHgNWYcect8PsBRYG/AUQupaCriJbSZ
	PutukaL4=; b=cXQyxX7EWtisylRynMs+ee5lUEWdoPioWw2HSYEyhvDCxMGzpwX
	+5aftycct+4vVHIJkhj5/3E4WJUYPmPwdFUwLqN3F5CRpnV3cOoukxa3Zhz8WqTY
	GLmIZpzRt6eTbe7/rxGYiBW8zhVQJdCnV1V1aYrvFwXaqsYGxN1ofKOK8D61Lt+I
	X/Xa36EXTA6byVR9wHZtMXcyrzqQXT7eO1ZFiK9SZJQacEUrIQS62SWCyl3nm37E
	8zERHzrOrryeGVOuFL+1ZHbrN5BvzABWGMV2EHnD7qYGxMMrrK0awmJJeS6tvmE+
	IA0hoA9PpnpTLLKLaArJEmp1RP9bYYYhMwg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjux988u0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 13:33:37 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ac6795617aso3693397a91.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 06:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793108016; x=1793712816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VhTrCHgNWYcect8PsBRYG/AUQupaCriJbSZPutukaL4=;
        b=YAAV8iuJhVeXfJOB2te6lNryHey1pT0keX33pOuv7VsuE+g4mZcJtNayZPJ6qV31u9
         SVLoOFPtrJmv2Bofev89LOWCueCUVawSDDm8nWIbvzTBmxo2RB3/7aAmnqrHOUjWor8o
         vZIhXCKvZp0Ay1en+l62XZLHdOW7dRaw88u8GOJK1RE0fTKXJZ8ke9Yc586ul4R877LT
         CQY3enD2uQ6VDg2Vmw5FVRhDZw+lgbssYuLXwpVu7Q+vbOR1dhSx5JcPM0ewZ/DUDfhW
         GGnUizSoRK/OLeIZTJ7B/fDXR6MjtSo3S9Z2L4UItohS2/IIm+0Ks7bJDId/nA3ESC68
         oKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793108016; x=1793712816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VhTrCHgNWYcect8PsBRYG/AUQupaCriJbSZPutukaL4=;
        b=ih+cV7JCBi/d0M7rMcU6YJW0QsjmX2/9OIwEkdz0EGBX8lsA1aBpItevVUmTdwjHfB
         rOyaOK2O6rGZZPVjoSNxAn/GkTUzLLaD0mkmeVpWDWalpPMsZ/eB46HH8duDiUdXqSfe
         4/TWcxttsctXCpCdprNsSFP6wjBoJsdB9bpVqEHkBSjVwa7VxhkS+Gr4B6NlfMl5diCu
         aTrtZE84mNRE/oWgucE7OS4RuzZjnT0esZeExSciVxJH1jryWdcei7h1AAvXQWKDycHe
         rz7zo3APEpB4hCD5HynukRpF3weqEmXPhtYUUAosY8m9LexUY4gOBV1DzGR/CF30C6Sd
         m9UQ==
X-Gm-Message-State: AFq9FYLgxUOISj7sSe/i/nOxaDC1nwYswAeg1MgQWcBYr17dQfzLqjr2
	+KRlucoomkudOt4Pjf164p4umuX3m2XexiHsN5t/YqjpPX9MxX0H1CKNE4ovQgJTEzhDXRBtL0c
	mv/2j5dJywca7iMkzcJA+ikwsMsWgy3dd/QsDWyuukUMJUvFgiv0xo2E9FnRPuQ==
X-Gm-Gg: AYBFou3XN53xoCOeeHS4YqlYCQ2Roc5phUWCyLJSqPSc2fyBJfg3jeZEWOqtA3zByRf
	uswu454WyX4c86Q2rWyEe0Of6/iuMEAg+5+N5dipkyBkQC5Jj0qvexJ/8kc05VLjbgn3gaGBIzf
	Kg1q0iloJllkcyY7nTF8d4TpNu2XbjMCRgHfaTToJ3HOzM02G6YvoWqqJ/frGI3l8cOrhtFCT8p
	vROfkhakpqo6cNOD8X2GD8B/ipfVjQdG4WnuSghGuN1ElvHYgwJgKRJHrovC7XXWSw+3vWjg5CK
	QJaki4sjYkioKuAF7Q8AVwgRrZ5ba1mqJPOG/ihsgDwErNvhaWs5hT+CVOHlN1OSlrhPReuKAzi
	f8E4IssUMNrrlgr0czXB/IaQwNEm9waRRTyDSdjqZGUK4zWIwmCQzuOvs3yCor7DU0H3WsvmMvR
	PHxBfBzQMhFLbamAP4VDr3mUK36qlgIVE4szIBi40=
X-Received: by 2002:a17:90a:e7c1:b0:3ac:9a5e:9cde with SMTP id 98e67ed59e1d1-3adeabe0cc2mr8753248a91.30.1793108016193;
        Tue, 27 Oct 2026 06:33:36 -0700 (PDT)
X-Received: by 2002:a17:90a:e7c1:b0:3ac:9a5e:9cde with SMTP id 98e67ed59e1d1-3adeabe0cc2mr8753220a91.30.1793108015716;
        Tue, 27 Oct 2026 06:33:35 -0700 (PDT)
Received: from zhonhan-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae4066d631sm4033195a91.17.2026.10.27.06.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 06:33:35 -0700 (PDT)
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
To: rafael@kernel.org, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com, stable@vger.kernel.org
Subject: [PATCH] cpufreq: stats: Fix potential out-of-bounds access in deferred reset
Date: Tue, 27 Oct 2026 21:33:31 +0800
Message-ID: <20261027133332.377546-1-zhongqiu.han@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=GYyCDgXL c=1 sm=1 tr=0 ts=6ae0a831 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=rmPzS-a5SAvYCXl-4t4A:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: v9u9gIt3vz7wQSuJDDz2XkiwEdhU2ssv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1MyBTYWx0ZWRfX6rvgaFj+nuo+
 cLOJiygT1KBMNLsuPuXNKPnyeER0hNkrXakdaul5O1I5Rp/PLmv5s2+sAl65w7VCYPJybvERSgZ
 acmZcuhEPGep0+ziXeaFygOJ7CKYHmbPVQmU+LVEYFjwmpDymOH2PALuCIiOkdAIKtKhHvargW9
 9PydFJ/hmFl5F36lyG5BPeUoxXfu8SMRx6OqOBgnFfp6eFHhAruJJnAdMqUJ1ttrBzCiScAL+XB
 fqUdb9Zk5GBVGhu2HkKAlUUE7VrEYmoC9YB4WiQtv9nO1BMVQf9fZHSfYR8PCDIJZK5K5Gss/F0
 d0NvlrJE1OjfhEAnF3zqJ03rV9N4d9uF6u/IEaY6jF5Y09ouG5iO9mq4S882ossSLpSG+FGU/ra
 zApNe3QrjLRoQRuMqsX+ErdUXLXva5VpVxcmBB/5TpIyfgHfs+wnI2VsOQef58kcV/0Na2eFMpM
 IBLrc4kit56qPi31lxw==
X-Proofpoint-GUID: v9u9gIt3vz7wQSuJDDz2XkiwEdhU2ssv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1MyBTYWx0ZWRfX1lTbUmzOtM4q
 KuF/7tPjWGApQHsqRhLgDxZB9pGy0xIBsW4S2uZvqq+z8b3jdeyIdDOLeu5LUneqgZMyhG7rYi9
 A5Vve2TjKQ5KRopi4rSf895Td+nFFP4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270053

cpufreq_stats_create_table() sets stats->last_index to -1 if policy->cur
is not in the frequency table. It then stays at -1, because
cpufreq_stats_record_transition() returns early on old_index == -1 before
it gets to update last_index.

Commit 46a310b80bc2 ("[CPUFREQ] Don't set stat->last_index to -1 if
the pol->cur has incorrect value.") added that check. However, since
commit 40c3bd4cfa6f ("cpufreq: stats: Defer stats update to
cpufreq_stats_record_transition()"), the stats reset is deferred to the
beginning of cpufreq_stats_record_transition(), before that check, and
cpufreq_stats_reset_table() ends with an unconditional
cpufreq_stats_update(). So if the "reset" attribute is written while
last_index is -1, the next frequency transition accesses
time_in_state[-1].

Fix it by also returning early on last_index == -1 in
cpufreq_stats_reset_table().

Fixes: 40c3bd4cfa6f ("cpufreq: stats: Defer stats update to cpufreq_stats_record_transition()")
Cc: stable@vger.kernel.org # 5.10+
Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
---
 drivers/cpufreq/cpufreq_stats.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index 670a10c3ecfa..e7ec16bcb67e 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -52,6 +52,10 @@ static void cpufreq_stats_reset_table(struct cpufreq_stats *stats)
 	 * reset_pending accesses in cpufreq_stats_record_transition().
 	 */
 	smp_rmb();
+
+	if (stats->last_index == -1)
+		return;
+
 	cpufreq_stats_update(stats, READ_ONCE(stats->reset_time));
 }
 
-- 
2.43.0

