Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CF143E9CE
	for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2026 15:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624863; cv=none; b=hRqaxys+d5GAjeS9215gPIQNLmGpt3UDcLjkegjXenRUYCnyihIIqunaro0j9dkRZKHL/8rOU/6XuCmi6Gkd21cSWX5TAkFcvjJAYWYf1nK75xu9aCYEMeNUO3xIDXWhHphn6pEQcUX16RcOQ8jhJrUE2rbcqm0joC9hgfHn6Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624863; c=relaxed/simple;
	bh=e1pGdssdQsaRpIBh+4JFRNHi4dhtOKvcr+672dc0fYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u2asWVSAfrxR8wrqKuG8zppLy2apVzh+EM9Gio1Nte/xvBdI/mqzvjdZ1U69Uux9Wim0NN3XcUH5MTeutysIIpBYfbChGiDQ+QaFa1lY7wBw/JPrWjrSWO7SqL5c08NTJSrtIQd1PeIUY4iY0f7ANcUbkYnyTOTbaZy0VwPZAyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EC372epp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YndHConh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EC372epp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YndHConh"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GFdYv93997162
	for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2026 15:47:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=eJW0DORVNViUcs7XgxbuIXaC6bb6dBOgIPg
	icankNzk=; b=EC372eppeUcYA6AlOW+1agnLRrMAoU89X2U8ZHgfWSmNA4GWZcP
	+VnthYRIZ0fpePnfUj5NPG20VD3QShj+Bmpe9BnBHUqad+ioYma2cQ5c+0VVY4wB
	vxQCrrMZYIwMYNmqF+4nFqC7TZi50/kIcJtPk8XHYH0JAxuFAm3wOsYf4Q/Id0Pl
	sObjOeSJmXLYuSBfaIZfIYm61dpqDT+fHHQRUn8V0n3TBL/jfOkVZtZ8yW2XqizR
	m8V+mZK1micVsP6UBOcalPA8oxZPVDdT0OK+jVPtj6gfhZDSUeW/iLdkpG6vBHIa
	LCzcJcvgbSS2Vg+keGzrzSoQKGUwgaWH0Ew==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu09kap11-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2026 15:47:41 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c858e0cbc89so2552527a12.0
        for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2026 08:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781624860; x=1782229660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eJW0DORVNViUcs7XgxbuIXaC6bb6dBOgIPgicankNzk=;
        b=YndHConhzteEAwY9buYp4JKDwcchkQeoritQfWJxCJ5VBMH94FtPJ9tONbDH+uoulX
         QzE68Zw1QMCwEj/aiZ+y2pfbzK124Y/F9A6LfKCM0qs2vu9Pc/9t8G2DU97Na6KoNsK/
         yUc5YbSo/OfPOwBdENIeHb/j1U4HsqnpzOmIT/msQKdva2HdzE76PqUI29t06mN0QqjY
         es+BAuCKo6Zmm3pDLW9pvzZD0oSi555E5hVwcZvrxyJXdmPJMmd5BlJwwyuncFjNy79Y
         oc2KBrx/zIIHeXT5ibUiKin39EOAUig2Rej7+K5DfOQoIkeVWWwzLngv51qn5N7+KwDh
         AVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781624860; x=1782229660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJW0DORVNViUcs7XgxbuIXaC6bb6dBOgIPgicankNzk=;
        b=ic6mOd/4vIdukqYXyrcEaHKScRugSRvJw5OgufacIf1Pwo/6rxS+KJbcdty0uKU/ze
         v2HSZx6Gky3OmbBNG160+K+CQEfhKqOajTL1x53FbXdfs921rhynrVs4Czdx3uJgu0P/
         qhYoUB1uMBl9fchx4/zEFCyCw4gtSINeFQhnjKOirHS30ND3a1XLWthap9wPpxDUIMul
         ae/1qBUNoyjxRqi6D0E1tS7iz2lOqxzigcGEWyC4gDtY/CtldHMdccCB6ya2IwIDWtmD
         RDxY2HmCTCXTuQrs0zhoEEixFYmUWdEtOr1plsTK+IXNxAgLry/fVvgLPj/dIj1QwUib
         cHUg==
X-Gm-Message-State: AOJu0Yz5kMwVMExmiJ26AwuQv+u4t9bonDX6KRDdWzSKpXbjMpkjBtco
	ShTi2/AkBlb4+aLbslprOQbt3XNsaaxQTLppz7IusZdK8NSNZ5yueJ+qMmFL/Rf35sc+IYtpNzG
	n29c3WjX6MUuzSGPyVd4Kbef4qbel3KSpT/Um4ejdJQFP53MCuMV1tkY/MwKiHA==
X-Gm-Gg: Acq92OE47VipueOck+ufgeMca4xG6q64wlmrUHJi70416TylXzDusI3RpUYPJI4gs2u
	WXtJp45qfaQWjQz8JrJR8Zo+8yxkvTxr3JxqKbr1Ikj0SlUBU59JnkTwg4FfNEF5dj4D+iYBgAr
	lBleCq2Ks56tvMIU75HccL9sqU23+BrKluPdfqfXdUR2EAELeNlWsT2evjINl2Y1p7FEAUoMpv6
	fQqtA9Y4OBwcjulg4T6ChIhZYsH11I28gKJ1e+e4QVpHsQvrhVhdgEQOmET1TNrKfjtWMMxTq6L
	5IwDfPYKXv2z+jYhu7hXkP1AVh4C8CoHw4ZunT0JBCFne83NzW8rpyG11Nm0Q1WR1LsYIrs3ktO
	KjHsFSoz0AvuXnEOACEzvKxKCJ6nipA4d0Acnd/h32fxKsyxntlMcOM/ritRaonS7k5rIGM7cvz
	UsYqQMnKAf3iRG
X-Received: by 2002:a05:6a00:3a16:b0:842:33f3:da68 with SMTP id d2e1a72fcca58-8434cd0b4d2mr20606356b3a.8.1781624860395;
        Tue, 16 Jun 2026 08:47:40 -0700 (PDT)
X-Received: by 2002:a05:6a00:3a16:b0:842:33f3:da68 with SMTP id d2e1a72fcca58-8434cd0b4d2mr20606306b3a.8.1781624859917;
        Tue, 16 Jun 2026 08:47:39 -0700 (PDT)
Received: from zhonhan-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434acf039fsm13163418b3a.20.2026.06.16.08.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 08:47:39 -0700 (PDT)
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
To: rafael@kernel.org, viresh.kumar@linaro.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, kprateek.nayak@amd.com, christian.loehle@arm.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com, stable@vger.kernel.org
Subject: [PATCH] cpufreq: schedutil: Fix uncleared need_freq_update on the adjust_perf path
Date: Tue, 16 Jun 2026 23:47:33 +0800
Message-ID: <20260616154733.2405236-1-zhongqiu.han@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE2MCBTYWx0ZWRfXzmW7/hAMXAzg
 Gpl+eamizaT+PKPg3tNJfwJtX+b4ruegTPnjEKMzqB/6eKUr9LDDkB0FPHo6EQSNqODKXXFUvXB
 JTW4kniT13kLBVH4jiiRptOItMsS3qA=
X-Proofpoint-GUID: OufY_vetyWk4ZBPs_pJThBOxTSPmHCOF
X-Authority-Analysis: v=2.4 cv=DoZmPm/+ c=1 sm=1 tr=0 ts=6a31701d cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=4H1OJQDQ-noEIwH9yNQA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: OufY_vetyWk4ZBPs_pJThBOxTSPmHCOF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE2MCBTYWx0ZWRfXxbIKpQaQ2mGh
 9ap/eiYH+C6IZglgF015nc01Z6cGpoulzrMJSBqF7CaZBpUot+/8oLHXc4VPnF73iazenTr64HG
 PmPiyfzkwk9d431MYfJh0/GLblI94z0On5diY2xVUh2vtcsZ0p7g4tXNQvG45vnQbJDiCNB4h6t
 QjSxsmiEWMHk+Lk10LmFCdu6QnL/i+NU7deEZp7RNGcJlMQH9BP7QQ/SxnSTQD/95yD/twlcw2X
 r/kzszf/Gwyd3HZ3u9xfNJ8vt7RRoJfJCQuVCp+CNMy1idWXmmdhDCJEQ/6RohRRpgMf51LtuJB
 AFrZOL+b5+kwicotjpDD5wpTPcatJIBffT31JJjjQiRZ9XQJXtuVbDddCcxSOK9fhMnnHX5FzQm
 AVKUKNNh0a3Z4G8cV/2uO5HW0iDGWIh4ND2RkYKBji+0tLm0yFQ8/z5jiLMXIPKp7KKXkL9ozpC
 sb2rMM1r8x14BPBi7UA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160160

The need_freq_update flag makes sugov_should_update_freq() return true
regardless of the rate_limit_us throttling, and is cleared in
sugov_update_next_freq(). sugov_update_single_freq() and
sugov_update_shared() go through that helper, so the flag does not
persist there.

However, sugov_update_single_perf() (used by drivers implementing the
->adjust_perf() callback, e.g. intel_pstate or amd-pstate in passive mode)
calls cpufreq_driver_adjust_perf() directly and never goes through
sugov_update_next_freq(), so the need_freq_update flag is not cleared in
that path.

Before commit 75da043d8f88 ("cpufreq/sched: Set need_freq_update in
ignore_dl_rate_limit()"), this was effectively harmless because
sugov_should_update_freq() still honoured the rate limit even when
need_freq_update was set. After that change, the flag forces
sugov_should_update_freq() to always return true, so once set, it stays
effective indefinitely on the adjust_perf path.

As a result, cpufreq_driver_adjust_perf() gets called on every scheduler
utilization update (with the runqueue lock held) rather than being
throttled by rate_limit_us, even if the driver itself may skip redundant
hardware updates.

Clear need_freq_update at the end of the adjust_perf path as well.

Fixes: 75da043d8f88 ("cpufreq/sched: Set need_freq_update in ignore_dl_rate_limit()")
Cc: stable@vger.kernel.org
Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
---
 kernel/sched/cpufreq_schedutil.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index ae9fd211cec1..a4e689eefdfb 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -486,6 +486,7 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
 	cpufreq_driver_adjust_perf(sg_policy->policy, sg_cpu->bw_min,
 				   sg_cpu->util, max_cap);
 
+	sg_policy->need_freq_update = false;
 	sg_policy->last_freq_update_time = time;
 }
 
-- 
2.43.0

