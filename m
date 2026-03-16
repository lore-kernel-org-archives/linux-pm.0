Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BB3351C2E
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 07:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773646693; cv=none; b=BpN3K9U0ciiDeZLhJPq7gbNApUH6XSZEAPdXUmWklgRvIyCTyuQTIWb+zU4W0j3OghxbPQMNaD0aN7YjwNPpqevxQq8+lpV+sjyOTMtAQun/r9J1A+fS6kHiIwNalnTzHMiZyxq6oEDb0SB+MYceUnkU2x+/A1uzgmi/u3z6Ywc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773646693; c=relaxed/simple;
	bh=Z/6THY+XjK9RDZxdSvC8eT1j6g70IKfbM7MZwp/Y34w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uIqGqyfj+BAROokYPOAXcPYbXIytVZj5VIzDj/YedlBILnRHPBiqtJ+a+M/0CBkZxuU+3sycmE4NCACBS6/EPUfEwYKCVUyw2GXJNm8J2ZcBPxGmSgTF2L3hq9VxL2V7sf/Do7gSYfp4P4AbzLs21jWSsKzRWbuno9OQnLuNh9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bpLgIE78; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=knfCZgDZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bpLgIE78";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="knfCZgDZ"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G64kIC4002930
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 07:38:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=yQfdCnYwqfB2t+bxnIB5Aa
	6+L8HeWThtqBaUd3Opfgs=; b=bpLgIE78N5oSwXgo5zhWFi+5LSEpo4cI6A1HnC
	KmoMCraDhNy8+PEIGXJGv7X5bynD6QPSieIfeSTL5760xmXsyrn4DjfcLSkhA49T
	8ttjwqUzw7unek9z9YfdQHGDjf6f53QafQMw/RuaeEX+mpvZYU1cBYZYHArae4ej
	G1lw21nv60FiOcmdBjy2o4m1sH4U/JtvTcEbk7G7iNL9Fca08f1WGMfU6UL2x3AD
	+9vGDTFga4dR0uYJshQMRKWxyBl9p3yIh4s0B35pkRfA6chfsySa8MHKPrP73wWF
	io8tWKxVSCfU4VaILxF2gWHGoyk9EmcZlO9LxqC0tx2dG33g==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw0424sgy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 07:38:10 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82984468f85so2979652b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 00:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773646689; x=1774251489; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yQfdCnYwqfB2t+bxnIB5Aa6+L8HeWThtqBaUd3Opfgs=;
        b=knfCZgDZW4EZGq8Sfsyb3HiMKCXnmtN3+LaArx9Ghv0CxpdvOINMxYzQmwre1J0dLy
         I6xkfa2AByZhpxrJLGTQMX7xhW/DDh5S9xDy3B1qc/FyiMjdc6uiG3rX/byCpQ+pfg5x
         fOKFOHlRsx8S22LwqzhKXyEQdnBsAYopXdX6muqrrXPVn5ZqWzfs5NQjRj/OT4YV+shp
         a5wKpFiuwSXsTlQ6KLRmmlkYgNVJOMGnk+0RV15vGK9uHuA+TODfQFjNyKdhO2F+f+vF
         R+am9hlqEuyIpmbr/+zSsB9ZD8j2zODa2Ry6atH+pR6gj1OcfUx+CxOFTJ0I6O/r6HH0
         et3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773646689; x=1774251489;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQfdCnYwqfB2t+bxnIB5Aa6+L8HeWThtqBaUd3Opfgs=;
        b=OwLikwrib70gNKokBEvaY9BZ9ZcNymEYZ+4Q7Xr+8wzUb0HPAZdeN9ftH8hwj9dx9K
         y/UM+4AN9MnPl41l0vlWEUvLzOXxiRSqsfLOconCkYDLuqQtlGQss7oUftKJt/wBMp5+
         EmCPURkYN0PtIfJ0DpBa5hhjAKbvwEqj+7X4VmyziJJpoQ48E7Hx7vmLpfvYgn+zYPnD
         +yAdwzpdbjpG9ikC2k+ggfYtmpeFPEfz0RmhDnUpfe7UwNQ6ID6fBF+a4XPJoZWhvegh
         AN1cK+uyRv+xZFpq8sIPijAUkETf7kX8P6qBBK8j3I5fuQ/1X4RKEXnCvbUifg0xVpyn
         CwBA==
X-Gm-Message-State: AOJu0YzVczyI2YmrO9n+/iFW2+574BFbnjVBN2zuMGBGQ3JkIM9EWpAX
	hapT+7NcLT58BAZ+6F/XnSwDE5UCHLB6Ol43qCmEtv/c7nmCcsKxSsO+cnvqfYEDel2vrlTBl1N
	84qmCbPmuHxqzzh5S2tgjISi3kYMySqhNAlspMI6TcxhFno54FaslH/JF/75fmw==
X-Gm-Gg: ATEYQzyKDp1DeF0hGeYWqNFv5fB3QvRYgja9bNaOOqAs50nNxQW83a8yOT+SMqQReE0
	bQvDoJ/1a0kGfcy0DGlC6uQPu5oYiUdqqZ4SoaiPyimWmxpUZbYqX143jcllym8WEkwdDmXaEoF
	fdjK4I+WfVKe6JjvHHBMrFIX5ltwbsO3VGeU16chI1nfMCzmiE0J0CHbM8U50wNeUvw5dYrlLZ8
	ts/igbAp9bAq4Fd2KWNInJkTgeCX/qrExN7rZpaeg1a6jEkUwPZ9scdLyT6WnwJgZs6X7GnWzt8
	PVaima8emx1SjTBwfemuEJ/ORkrsrI9699fGblrRwZiQ934P+nozPyZsEjqxwYw3iaWQS1b0fV0
	CQTSZgNFl6SXYz4LwptGdVAy1ZpAGkIw59ZEeZGmL4ByGfO0pNA==
X-Received: by 2002:a05:6a00:1585:b0:82a:ea3:c161 with SMTP id d2e1a72fcca58-82a198cb23emr8629453b3a.41.1773646688776;
        Mon, 16 Mar 2026 00:38:08 -0700 (PDT)
X-Received: by 2002:a05:6a00:1585:b0:82a:ea3:c161 with SMTP id d2e1a72fcca58-82a198cb23emr8629436b3a.41.1773646688169;
        Mon, 16 Mar 2026 00:38:08 -0700 (PDT)
Received: from hu-mkshah-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0736b5e7sm12169509b3a.49.2026.03.16.00.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 00:38:07 -0700 (PDT)
From: Maulik Shah <maulik.shah@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 13:07:58 +0530
Subject: [PATCH] cpuidle: Deny idle entry when CPU already have IPI
 interrupt pending
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-cpuidle_ipi-v1-1-d0ff6350f4e2@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAFWzt2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY0Mz3eSC0syUnNT4zIJMXZNkMxMDY7M0y0QTCyWgjoKi1LTMCrBp0bG
 1tQAqoa2iXQAAAA==
X-Change-ID: 20260316-cpuidle_ipi-4c64036f9a48
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Maulik Shah <maulik.shah@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773646685; l=2361;
 i=maulik.shah@oss.qualcomm.com; s=20240109; h=from:subject:message-id;
 bh=Z/6THY+XjK9RDZxdSvC8eT1j6g70IKfbM7MZwp/Y34w=;
 b=g8JlpKm2V6KsG+AG4VPbmSr/eN8Rllcg3DwIgMgyOzss36HbmNH1meKGA7OCrjjYTgumtnRgd
 a1cltzDnii+B7UbO59tcQX/KEdgmdfzmHjFMnKEUGlTx+hfc3ePfBVr
X-Developer-Key: i=maulik.shah@oss.qualcomm.com; a=ed25519;
 pk=bd9h5FIIliUddIk8p3BlQWBlzKEQ/YW5V+fe759hTWQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA1NiBTYWx0ZWRfX59cRWCbiKavi
 EWAmXfcemn4mJg2HUDVRDJ0YVQaPpEuD5Xp8UKzE6+hgv/ZXwVCYVvZa288pa38cgIuZq8BZco4
 tmmUDMd33+jkVZPmvSdGBLj3COv/ZcnwR9qKiuZ/SeeR17gbTIMT5EnkgTo1pfCSjFgqnXoVdFb
 yxVMRywMmpoEV1D/PKMzcqrE0ssoHDJjlGFItkayqJeyoWGpdKy5F6+fHaLujEcJQGOpr00c/Id
 cpH+dbL+LwRWl2j6Tz0ieDYDEwmUzefSpoHKNaM4MbmrTiDiORIMMimbhOn8Hw9io+3gbGhDIUn
 HgF6T1Vp/LQepk1rC3c/V2cRCkmnp97Hd117wJHrSLrq0PJ2W9IiRQ2BOfqvVlil9HNBFYHG8Dt
 D/3ZdDnUL0aN5mYk+9nd7ExGyVlwDOewXT5uMelLCjUsZxAjBDuihQToYQtDIm/jeEfXAChTIKX
 8ChLB3gnOKf9nfPtr2Q==
X-Proofpoint-GUID: lU6Fda5jVTAxVYEaLoccmuv1rVTEuWZ2
X-Authority-Analysis: v=2.4 cv=SJJPlevH c=1 sm=1 tr=0 ts=69b7b362 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=5VM2pUZDyY3GmIPixBcA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: lU6Fda5jVTAxVYEaLoccmuv1rVTEuWZ2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160056

CPU can get IPI interrupt from another CPU while it is executing
cpuidle_select() or about to execute same. The selection do not account
for pending interrupts and may continue to enter selected idle state only
to exit immediately.

Example trace collected when there is cross CPU IPI.

 [000] 154.892148: sched_waking: comm=sugov:4 pid=491 prio=-1 target_cpu=007
 [000] 154.892148: ipi_raise: target_mask=00000000,00000080 (Function call interrupts)
 [007] 154.892162: cpu_idle: state=2 cpu_id=7
 [007] 154.892208: cpu_idle: state=4294967295 cpu_id=7
 [007] 154.892211: irq_handler_entry: irq=2 name=IPI
 [007] 154.892211: ipi_entry: (Function call interrupts)
 [007] 154.892213: sched_wakeup: comm=sugov:4 pid=491 prio=-1 target_cpu=007
 [007] 154.892214: ipi_exit: (Function call interrupts)

This impacts performance and the above count increments.

commit ccde6525183c ("smp: Introduce a helper function to check for pending
IPIs") already introduced a helper function to check the pending IPIs and
it is used in pmdomain governor to deny the cluster level idle state when
there is a pending IPI on any of cluster CPUs.

This however does not stop CPU to enter CPU level idle state. Make use of
same at CPUidle to deny the idle entry when there is already IPI pending.

With change observing glmark2 [1] off screen scores improving in the range
of 25% to 30% on Qualcomm lemans-evk board which is arm64 based having two
clusters each with 4 CPUs.

[1] https://github.com/glmark2/glmark2

Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
---
 drivers/cpuidle/cpuidle.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index c7876e9e024f9076663063ad21cfc69343fdbbe7..c88c0cbf910d6c2c09697e6a3ac78c081868c2ad 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -224,6 +224,9 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
 	bool broadcast = !!(target_state->flags & CPUIDLE_FLAG_TIMER_STOP);
 	ktime_t time_start, time_end;
 
+	if (cpus_peek_for_pending_ipi(drv->cpumask))
+		return -EBUSY;
+
 	instrumentation_begin();
 
 	/*

---
base-commit: b84a0ebe421ca56995ff78b66307667b62b3a900
change-id: 20260316-cpuidle_ipi-4c64036f9a48

Best regards,
-- 
Maulik Shah <maulik.shah@oss.qualcomm.com>

