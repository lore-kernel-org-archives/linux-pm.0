Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E963FB048
	for <linux-pm@vger.kernel.org>; Fri,  5 Jun 2026 10:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780655477; cv=none; b=hhxXPRT4QQkI5QeKmSo9k6nNoGZv55D8gENSF8RfyYDH0VOJSdDICAMLOPID00h188s5tkhlEgRjV2BAWbzkHGsKdPI7nJ3UmNIELyJ0W1GpI0IMjWr8thFXB5L4iEFQeJvpJU2foZjCtOsjD1nwY0E2zSqzY8EA+gqqFgzAw3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780655477; c=relaxed/simple;
	bh=R/FRwW+ySF9W2dPGZQVRXHt6gF9PijiVFPkHxc0Wcgg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=O2hio8sIi4p9V7wjXYN4YwtQEvSpFhFGwa72LnsJEAQyUPgY21LSNEzGOpK+fNz5X40t8ZT3Y4OVJcMA5tQ8IqWJDyrKOxiHz2jfoA59gfkTC+zJF80kty4SMEeg6RugoMlzXe5vqliI+9CpJE3h6Jq9PB6Kf/SLL9LbevWkemM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eo428vh7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Mjg6TW8h; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eo428vh7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mjg6TW8h"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6556Nj9R3111397
	for <linux-pm@vger.kernel.org>; Fri, 5 Jun 2026 10:31:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=LC2pJVsxWt+KbmcxSdrSyA
	iWMz8/N4TYn6VfLvbw4to=; b=eo428vh7LlUfLQKi1KEuWDaoevAiL01w5uPhma
	jbNzKJ5NGZXboNFhiDY9LPh4aVj/p83r2wGxoDyYilKgZcXMZhDaIruezLS18Ykq
	OJsttuA4+9AM9Xsh5gLuqWbzaQjmZc4+6rD1fCtjeEoTXj+qlOwuQk8sj+Ymh4lp
	OKc1d6140TOI/6iQjeEb0psGpwkwJhmQgIIr7sQYUk9tQiXDJH7/+ziwrk7bUAPQ
	hBLu2ET7hOA+jjkpfz5EZMsEMHFRSWmt5Mf2whRdx6vAdh2SbBBcnXPPGRo96WDY
	0Fv90FQrBH2DOsD0IhZUPAlUXu3D2XgWiGSdk6jtnOXN2W3g==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ekfv7326a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 05 Jun 2026 10:31:14 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c860544c077so1164714a12.3
        for <linux-pm@vger.kernel.org>; Fri, 05 Jun 2026 03:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780655473; x=1781260273; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LC2pJVsxWt+KbmcxSdrSyAiWMz8/N4TYn6VfLvbw4to=;
        b=Mjg6TW8hdgFSDmOqY04qhkBmhzJ0Po1wVJ5q4n6kmuOG88QSvL+1CwxjSnjMD+PnFl
         y2BvcykMQUq2zHbxCJ0A0w5qiCx25pznFeNhVqgWjIf+Br/7sJH8B1bwEKJnxfNs6Gys
         viDxUuQkglkTSpgVcjURse3xNsFjarJtZSrcdEN3PbqXc8olUTif/tPwMe6yDAeeozH9
         lfN7OLysfIoSX/M8r5MQYPVYlAbvZEf1NyyEwL5V+4vKMIswetNdzORIilvsKrIBjUZO
         E62r/l01Cp4zQ2Vn/1gM3+D/GZBay4sOVaN6/XD03SQ1Kle4Adsa110WCXTgOwxDXyde
         N3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780655473; x=1781260273;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LC2pJVsxWt+KbmcxSdrSyAiWMz8/N4TYn6VfLvbw4to=;
        b=g6dt7aO1XrXduxvW+CXdsoVN4IvPTLpyhvr7aYdIMWpvsZXaA9NZsW+t9a9yMI8GVg
         vjkynBq3FPhm7CLskx1wxZBnxH/gQbzzZgjayZ/i7htoHD80y3HciYX9YkxtoR57t6v0
         SF3IKBPP39yLJXU2+7NUBWWTvJeHT50bHMib+it5gaABnZsvns9abz1EdfmS344mA8w7
         3uuGJEGUKGYaiuoLHuUaGgdPGMxK348qkH5NV7zIjDAGo9dCWzJC0TXwrLVgQegRc48q
         oSJhJrffKCa1sNS4gE2wh9xTmGjOWpq46iQDBb9VEBJ1QYxnJtjagQRYTzmukzVRa0O1
         dGWg==
X-Forwarded-Encrypted: i=1; AFNElJ9xvSFhYAMPUXT+NyxlojVO7GT/YUv9BKLaIbkdgGGaOL1m/MmMUyXD15NlqzIvtFX4sqW+K/fY9w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpHHi10ZeWKpVTKphtvX5vy2fxLi35R8lHSgFxC/Dp/Ao/pQu4
	L8HoRtvTHdF801hc0SCrhr9E/o6wHS7TXJcYXnA6XHBy6EHe7DEQ9Ho/jjaEYsLidpL0l5DjAKu
	OAnUSaLA+P35wrvSW4AQ0lwCGg3+2u1TuFCvtX5uOMWxJosNE2cmfuupIzMEEEw==
X-Gm-Gg: Acq92OEVrKmJWtAtvkUlVsukfztoqhsb1ZFCTq8z0wQz99jU06Hngb0X5sLl2Q8vr+m
	nSJsHWdjGLXDGOKvcv69JKhDmBqkBG4ynoka79Rrj/wYAzGDXYJlkKu/9+Q2ti4nGw79jMxuT0l
	zZ/fTAX69sM6sWY8MTFvxzAh3aZ6awGFH1/PTeZjax1RplPtDwWy9zO+z9OEm4ertL0AnbglZC6
	flMy/eZ5pZrz3ku8SjM13SonGwpHHQ3cF8gQu2KL/4vAqXfmun2RcalgfjofkUZF3fropRd5lmt
	uVtYZxVrvRrD2WSAXBV9MuFkb0lM+P1XYhW/GXhh9U5+zZi8vaYw9SU1CwxKPB7jUgvtQz79IXv
	4q7WmyFjIIRoo4bwsfVGIwRK1UWeLs3png+J82CXDcH5NwLUfBlRhzGIR2UKWrg==
X-Received: by 2002:a05:6a21:6111:b0:3b4:8f57:3205 with SMTP id adf61e73a8af0-3b4cd03f192mr3495326637.36.1780655473394;
        Fri, 05 Jun 2026 03:31:13 -0700 (PDT)
X-Received: by 2002:a05:6a21:6111:b0:3b4:8f57:3205 with SMTP id adf61e73a8af0-3b4cd03f192mr3495292637.36.1780655472902;
        Fri, 05 Jun 2026 03:31:12 -0700 (PDT)
Received: from hu-smankad-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df03498csm8743566a12.1.2026.06.05.03.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 03:31:12 -0700 (PDT)
From: Sneh Mankad <sneh.mankad@oss.qualcomm.com>
Date: Fri, 05 Jun 2026 16:00:46 +0530
Subject: [PATCH] kernel/cpu: Disallow offlining boot CPU based on config
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-disable_boot_cpu_offline-v1-1-4c68fe1a6cf8@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAFWlImoC/x3M0QqEIBBA0V+JeV7BrITdX4lF1GZqIDS0IpD+P
 enxPNxbIGNizPBrCiQ8OXMMFe2nAb/YMKPgqRqUVFpq2YmJs3UrGhfjbvx2mEi0ckCBrqdhsP6
 rSUHNt4TE17se//f9ADzwiI5qAAAA
X-Change-ID: 20260603-disable_boot_cpu_offline-eb4f55ac96f2
To: Thomas Gleixner <tglx@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Sneh Mankad <sneh.mankad@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780655469; l=2099;
 i=sneh.mankad@oss.qualcomm.com; s=20250818; h=from:subject:message-id;
 bh=R/FRwW+ySF9W2dPGZQVRXHt6gF9PijiVFPkHxc0Wcgg=;
 b=+PA7Cxep45m/Mu6YMDVJ7/tZ8OzoVvkvmeCtv1jQZ8fJ9rD028VTNKmb3zBPaZbL+6bccn1Xl
 zYP2D1YGjTSBwRBy+ZTFZOzN3+tc186oYHr8jl5AV0vnnp910QyVhh8
X-Developer-Key: i=sneh.mankad@oss.qualcomm.com; a=ed25519;
 pk=sv57EGwdcfnp6xJmoBCIT1JFSqWI+gawRHkJWj/T2B0=
X-Proofpoint-GUID: u42CM2aoTt_DLQbIlSDVvmR4KoZcMa6Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDEwMSBTYWx0ZWRfXyh1lU+KR8wFz
 sEtROgJFmTPNweGTpaGL+AQAjPH5+wrRA9d//ZcWmQFsBFFsrHwWq7fPTiAX1QpQr1FzwcLLEtR
 WdXr9+FP+LP0/Flag3SCepz+lSdzThiaUt5cWpSCVVesQpXHqm4whAzPy2qw8IOH1/QQT/PO7Ie
 QYPiSQkv3JEWXKTQF7VyhYSLPTUChjBf7RPTqwcDfbuazZmJkpu7YOLXc8ZDpp37ZB4K3LOkX61
 yu5NLEiryXKRLQkdlzf6TG4Aa3BQmgiLt+1R09APk/9HILILNH/n/FzwDjfj4bWJ8A43/xqfGIZ
 Z1rNNqLQ9zBJlL8q91AsOHEszHVATS2hgel/en1V80ruYFJpFpnOwzpKUL6mIYsbPSLP/Uhq9cR
 odE1yDaRyJWePtjm1VHF15t20iBCFPFCjBqJKnnUbCscagxn8AcjFxM0/uqPehkQDZcc2HNrL4j
 7HG6dEZzFaSNw99+zgg==
X-Authority-Analysis: v=2.4 cv=JNULdcKb c=1 sm=1 tr=0 ts=6a22a572 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=uPx51MvRb-IBqrSjUCkA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: u42CM2aoTt_DLQbIlSDVvmR4KoZcMa6Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0
 clxscore=1011 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050101

The Qualcomm SoCs like LeMans, Monaco support suspend to ram which leads
the SoC to ACPI S3 similar state where SoC is turned off and DDR is
retained.
The hardware design on these SoCs forces a constraint to suspend and
resume the system on boot CPU / CPU0.

If CPU0 is already offline before starting suspend to ram the
freeze_secondary_cpus() picks alternate CPU as primary / last CPU and
proceed further to invoke PSCI SYSTEM_SUSPEND.
This leads to a system crash.

In order to prevent such an issue introduce PM_SLEEP_SMP_CPU_ZERO_STRICT
config and when enabled prohibit the CPU0 to be offline.

Signed-off-by: Sneh Mankad <sneh.mankad@oss.qualcomm.com>
---
 kernel/cpu.c         | 4 ++++
 kernel/power/Kconfig | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index bc4f7a9ba64e62d76fbb2b362f243c918defe5bc..1c878db1d9cb6df0e31cb55343851aab4e38a3a0 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1478,6 +1478,10 @@ static int cpu_down_maps_locked(unsigned int cpu, enum cpuhp_state target)
 	 */
 	if (cpu_hotplug_offline_disabled)
 		return -EOPNOTSUPP;
+#ifdef CONFIG_PM_SLEEP_SMP_CPU_ZERO_STRICT
+	if (cpu == get_boot_cpu_id())
+		return -EPERM;
+#endif
 	if (cpu_hotplug_disabled)
 		return -EBUSY;
 	return _cpu_down(cpu, 0, target);
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 05337f437cca29da57864583166d7f9abd526507..0b342b3a4a5650a1927dc4805d1515e1d9e067c6 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -401,3 +401,11 @@ config ENERGY_MODEL
 	  The exact usage of the energy model is subsystem-dependent.
 
 	  If in doubt, say N.
+
+config PM_SLEEP_SMP_CPU_ZERO_STRICT
+	bool "Disallow boot CPU (CPU0) offline"
+	depends on HOTPLUG_CPU
+	depends on SUSPEND
+	help
+	  Disallow boot CPU (CPU0) offline when the suspend_ops->enter()
+	  has to be executed by boot CPU.

---
base-commit: ba3e43a9e601636f5edb54e259a74f96ca3b8fd8
change-id: 20260603-disable_boot_cpu_offline-eb4f55ac96f2

Best regards,
-- 
Sneh Mankad <sneh.mankad@oss.qualcomm.com>

