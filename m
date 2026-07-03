Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B9D3AB291
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 11:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783077628; cv=none; b=t/7PC92IEsEPXkzSJTHUamPhwxVjm3cIPMAO4IsO8S4I/ZWXHItV0p2Af6wOSSTpLU2UClTBcnWBTr6bMsTKpx/osU7hQLRju50XXsVRkc26OshsQ/x+/N6eNHzEe1/0U6cNDvZdzjOdCdRo/oa6Bi7x8+eM2TfOH9Xk6qCtPOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783077628; c=relaxed/simple;
	bh=0u/Hn+/+Ov7gEwvAy1Fe3xpUvD2U1MX/9snOD6f2Czs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jtKenm+upqKKE6VEUsUeAHlDroZR2aYCj0ANDQJQVoqTMe9U0RWKq22sURD5zQvsvafanFYOTnxYY18hdfUni/gA61ZCW+6wghQHCI8PGnDNkdL1645GToL47rR+a2ig1g+x2rz92If//pzvYFP4kMKJrXo7GXJxCzsU0yKT0z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KN9xvv4p; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aFZxgAjx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KN9xvv4p";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aFZxgAjx"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663BEZiT3134747
	for <linux-pm@vger.kernel.org>; Fri, 3 Jul 2026 11:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Nbi6KRQjupOc9B3Hw9OyBw
	J8mgQgydOW3Gn8fR9ycYc=; b=KN9xvv4pbKCDOdA5N4lwhvzoE/Q7UihobnSlPm
	98K4FXR8O6ViaHlMmxjk+tYAABcQvX+dI2hRKYAuVRuvTttTIj3k6RBgNovL08/J
	HF2NHi1L1cwvzr0jzbkq49FfjmXQMPRNNSTCTuFL8NqhLTHSk9pZyLLiTptsEonm
	GW1oPCq4+VcUhXln1i3C3EBs9FAwPAvO//LXraZu29cSJlyQyw1VvBcqG7duV8aC
	u8CuHvrIKs2yRlDA1qjBF3FY4TSUzafF3R/dmLD76yn728PM2cxkWh8bwrRQhG+L
	uUWKMZlC3bu5jS3PG1U82Loa0JmUhTP0vCYtFJdyEZVrUHYw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f65qchsc4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 11:20:25 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8478e603285so1951940b3a.0
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 04:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783077625; x=1783682425; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nbi6KRQjupOc9B3Hw9OyBwJ8mgQgydOW3Gn8fR9ycYc=;
        b=aFZxgAjxAtB2I8SOtOle/PKOtSKnoM+IWfGer/RI2OpUufB6fIZlRYhXAXC0HyvevF
         zBbl0deNu1a8mirkzeDA4fcmb3cWUvKdBobSykTPXU+Aljnxfi+XZaMcI4P2qjjwHi/5
         /W0abk2mx66HLrPtLkMl80jxt3Tp/gGwJCT9axryW6mTfnXK0z9e55wK/ihxF30PiD/y
         wUWDCr6Zd/ur8irQyOfdYrk1EactmMW//cFT3ieklrne4haqGB5C/NxbBhEsvmLA7l7i
         vaM7m4rt4LwmGmpm52WBpc6HAClNlk5t4Z/HVFs4VhJtTy5g+fL1e8Tef/SF0zUykWM5
         Qyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783077625; x=1783682425;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nbi6KRQjupOc9B3Hw9OyBwJ8mgQgydOW3Gn8fR9ycYc=;
        b=XcHOuq+oPRJsv0EzJP6bC3bkSmz3/M46pb/2iQjsDLQvr+DxFh6CjBXY8K5Gzng0uP
         AVYDYsoPRgJW2Gz+Iz7PZzNkhGqEuBHlgdzfeET2ohV/0uHKNDTRgBsyOVx5geSLY5V9
         c0xOPdWjrm/sywnd03ZhbGB/lk7QSZ3jRMPOYE5Xv+qCOGeZ5nIguQkdbmVXpnc5BUCb
         maHhwNJi6b4fuWBshX3rNRigG9Zn+J/k4ZsjPwrxoeVYAiTt/MXW8wxXvWXUpOZWKZZz
         T/sVXaNGqaIuOFkpPS7P6PX2xxWCaUi6Lp74EDcnizujninaZCv2AfPfUwREoBG1ogjK
         YNyw==
X-Forwarded-Encrypted: i=1; AHgh+Rp00fvyyYKBI8QFEVot/yuINjMEpNb3rV5Ake2ac4B55wL6UcTdYpST6+xfXX/GoSgwmcxyJTtEkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw99zxb955IsZfn2i70R7FojVoZwUt80GFrucU+2CD5V6Oe2bY4
	i6TnGUP4VRdGF1FhtCE/PDf4c5jRJb0POJPZN/ewMzcBu6mkEmvXE3IEuwOkok38Mh5f2F5y3m+
	kDH7fk2y32ILBOqWC1Kdm8j4kAhYgJbW4izkCM2TqjM+XHkbDi3ewzSLprfmZzAOQatrryw==
X-Gm-Gg: AfdE7ck4LubbRdDPVrDAuRHgwegKfVpS/x+SK46KS7IDXJrQfTvTbzIHao9vJqK78La
	sfTQcPk8V7STTIwW9anx60NIHk6Jn3Jvw0Bcr6g3btUGSwzgjE/kAk68zTWOYTco4iPvMq6pQ7q
	enCuCu4apyUt4Iyvey7fOHoVrG9sz/XhmQzWTTdRakiCmV28YZ9BQEnSyaMPehO6X18MuMe6ntQ
	O4O7r91/bUOKnYz5KZGLM7I887zVku/iPCSraxPyITK4PBI7PGQg9PLlEG5u+ZDC6exasjwMgQV
	g2cs2x6TARXi+QLc2KGTgbybVwx2cSEWQX5rw3WWhh65Ygo0rTMRqD2uTAFujyg6TK4Yy4QWhGP
	3+OllC3vUFmsoOn5oON4tCnfy/k6FLd9xrsF2zsfA
X-Received: by 2002:a05:6a00:760d:b0:842:dd4:d9e2 with SMTP id d2e1a72fcca58-847e14f59b3mr2793939b3a.0.1783077624646;
        Fri, 03 Jul 2026 04:20:24 -0700 (PDT)
X-Received: by 2002:a05:6a00:760d:b0:842:dd4:d9e2 with SMTP id d2e1a72fcca58-847e14f59b3mr2793906b3a.0.1783077624149;
        Fri, 03 Jul 2026 04:20:24 -0700 (PDT)
Received: from hu-smankad-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb9902efsm2728261b3a.45.2026.07.03.04.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 04:20:23 -0700 (PDT)
From: Sneh Mankad <sneh.mankad@oss.qualcomm.com>
Date: Fri, 03 Jul 2026 16:50:02 +0530
Subject: [PATCH v2] arm64: Disallow disabling boot CPU based on config
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-disable_boot_cpu_offline-v2-1-782d16ff58c3@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAOGaR2oC/3WNwQqDMBBEf0VybsSkGmxP/Y8iEuOmLqhrsyot4
 r83FXrsZeANzJtNMAQEFtdkEwFWZKQxgj4lwnV2fIDENrLQmTaZyc6yRbZND3VDNNduWmryvsc
 RJDS5LwrrLsZrEedTAI+vQ32vInfIM4X38bSqb/uTFv+lq5JK5s6UHpQ1zpc3Yk6fi+0dDUMaQ
 1T7vn8Adw6SFMcAAAA=
X-Change-ID: 20260603-disable_boot_cpu_offline-eb4f55ac96f2
To: Thomas Gleixner <tglx@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sneh Mankad <sneh.mankad@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783077619; l=2434;
 i=sneh.mankad@oss.qualcomm.com; s=20250818; h=from:subject:message-id;
 bh=0u/Hn+/+Ov7gEwvAy1Fe3xpUvD2U1MX/9snOD6f2Czs=;
 b=hbLYt8wNQd74NPxFoeXBJoSB7L3HKgJpB/Ls7t3cgm/7vJoy7ZGbGg42hEtIT52O+ZE3Q8A6B
 hCZVB2RQnT/DdbHMHTz+jp70iryzWvl1fEkWXrMd/jM/UvAtzP0gx6j
X-Developer-Key: i=sneh.mankad@oss.qualcomm.com; a=ed25519;
 pk=sv57EGwdcfnp6xJmoBCIT1JFSqWI+gawRHkJWj/T2B0=
X-Proofpoint-GUID: p3rXImSAJS-KgY5x88XzQtrjebFYuHEr
X-Authority-Analysis: v=2.4 cv=Bb7oFLt2 c=1 sm=1 tr=0 ts=6a479af9 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=uPx51MvRb-IBqrSjUCkA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: p3rXImSAJS-KgY5x88XzQtrjebFYuHEr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDExMCBTYWx0ZWRfX/xdn6iZeln1J
 w7yL/wwykiENZKUCnEn3GGETpE9mRqL+09ixCaan3Bq6ykjwXof0PzjH6I65aiIvLm6LTbpGfzu
 7xZArL41Lx+ooPWDx8cv6SV8rvPoVDNEC8fHZSOn8f1yOJSMl1cBwcGAuFRzhCdXJ0TsKjdsZIx
 /1Mzl7NF2X9w/AF8zWiAqF3ti4pQua1dkQUgaLxmjJkhd4gWfp69F/AZYSWyB1vXRYbsx+yKBjt
 2161fXtRzG7+e3DO5+T0Kp/urAoxGeQ7WMCvjPTCTwiA3X6PLPM2H53E3bGjPKD3bD+0j8uOxwE
 Fpt8qwTUCwmgwROTi3tvOK69UyIDvngxOVotk7++uI0SArbO1qjrxijWYy+2D6SvOmEXpW+Yjg/
 iq3qWoAHg4Ot0OQh55L3eY1p1V+aBu8eCV0GH52opzCO7RbIHA35hdTbxJH/8PHMzOdOWdcGs6/
 9spPoxZAT858htP7XDw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDExMCBTYWx0ZWRfXxNGOfLVgfdJB
 jZJA4N2M/rAQFWl8jzYRMaUXE/IvhEPDQXL1Ya9rMFSMU1ocC0ykvawHy8plop41iWu211/AOfM
 K8VTfKDqvW6KqK8yecy6P9evWjO0fak=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030110

The Qualcomm SoCs like LeMans, Monaco support suspend to ram which leads
the SoC to ACPI S3 similar state where SoC is turned off and DDR is
retained. The hardware design on these SoCs forces a constraint to suspend
and resume the system on boot CPU / CPU0.

If CPU0 is already offline before starting suspend to ram the
freeze_secondary_cpus() picks alternate CPU as primary / last CPU and
proceed further to invoke PSCI SYSTEM_SUSPEND.
This leads to a system crash.

In order to prevent such an issue introduce PM_SLEEP_SMP_CPU_ZERO_STRICT
config and when enabled prohibit the CPU0 from getting disabled.

Signed-off-by: Sneh Mankad <sneh.mankad@oss.qualcomm.com>
---
Changes in v2:
- Moved the check to arm64 specific code.
- Link to v1: https://lore.kernel.org/r/20260605-disable_boot_cpu_offline-v1-1-4c68fe1a6cf8@oss.qualcomm.com
---
 arch/arm64/Kconfig       | 9 +++++++++
 arch/arm64/kernel/psci.c | 6 ++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fe60738e5943ba279e5571862423df4fed3db661..21697a535a25d286a2f8afe4921a41b13cc32c0a 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -263,6 +263,15 @@ config ARM64
 	help
 	  ARM 64-bit (AArch64) Linux support.
 
+config PM_SLEEP_SMP_CPU_ZERO_STRICT
+       bool "Disallow boot CPU (CPU0) offline"
+       depends on ARCH_QCOM
+       depends on HOTPLUG_CPU
+       depends on SUSPEND
+       help
+         Disallow boot CPU (CPU0) offline when the suspend_ops->enter()
+         has to be executed by boot CPU.
+
 config RUSTC_SUPPORTS_ARM64
 	def_bool y
 	depends on CPU_LITTLE_ENDIAN
diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index fabd732d0a2dfee37074ef4ebb6ce5894871c8bd..4ad90ae6f8bacf0cbd3203d66580107d467ea232 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -49,6 +49,12 @@ static int cpu_psci_cpu_boot(unsigned int cpu)
 #ifdef CONFIG_HOTPLUG_CPU
 static bool cpu_psci_cpu_can_disable(unsigned int cpu)
 {
+#ifdef CONFIG_PM_SLEEP_SMP_CPU_ZERO_STRICT
+	if (cpu == get_boot_cpu_id()) {
+		pr_info("Disabling boot CPU is not supported\n");
+		return false;
+	}
+#endif
 	return !psci_tos_resident_on(cpu);
 }
 

---
base-commit: ba3e43a9e601636f5edb54e259a74f96ca3b8fd8
change-id: 20260603-disable_boot_cpu_offline-eb4f55ac96f2

Best regards,
-- 
Sneh Mankad <sneh.mankad@oss.qualcomm.com>

