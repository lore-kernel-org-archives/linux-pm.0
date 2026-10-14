Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87974518129
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 13:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791984614; cv=none; b=Q9L9P9tnqD6h7rmk6HYji0qS0uKxnT8kvl5Rvas4WdUweV/Xktw2I5xtI1Z4hnosslcF9gSnhKwUSYC/JKeg0cjv1vcuevvnm1b/7UGrwSTR81CW+5urL0YtSQSrxqVzbXFScorMqzaXao9V8RVFxcMsn8fYOsxkzSpO6KAkd8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791984614; c=relaxed/simple;
	bh=+yMU48ccOQTDJqcL+wYe+JjnvkSW+/MtKgVT1KqC1QI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oxqIxAHgsVNJwlp4LkZwCQSLnk4kr/5oDDzf9lb2S9WV5q3w1JZxfQS8dU6+5Coin06EGrjE6NW7PjXdX5kN2clWy8xBzwuWQEFU0z99adrekk+JO/QC43tEdewhb/ZPsBYVd4gLmNObULU3/BTSZpP/AGi4RpIUs8q1iykZ14s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GlnJRd80; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F+Jl2IO4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GlnJRd80";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F+Jl2IO4"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69E8IbO53017940
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 13:30:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=WPKkYivj8JUBz6V608J8AiLTN9VSzh8FXI9
	487Jr7wY=; b=GlnJRd803VKB8zt2rm3j33IoLgFkmEEZPHedUKVBMJV1Boaq38U
	L4th1hQ4JO2esuvRjFaI5b7u5yWtim/p/3wzVmPQb9xAqJzrLRWpxtaQ8q/D74h1
	hVGPR6svXiKiUr4IFxBaarVAE9XlMa8TYFweDbXlzpfOkPqPXrvUMwgOjL90zhuf
	jsBU9Es4cYSMdhNyMcUwXeRSflNH424El/bMj222yE16+u01Owd1rFBgB9qxG5/V
	MMaHXJ6t3AewG3UiqRHy2ucqhtR1t6Z3RhzGkUGTzLg/XQuWvKbhgMrwWIjtFrWM
	oNlE8Fg60anK3iKiDWdcaGVtImo6Ea4qoXg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9s2b4gvv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 13:30:03 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93cb6391e89so890855085a.1
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 06:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791984602; x=1792589402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WPKkYivj8JUBz6V608J8AiLTN9VSzh8FXI9487Jr7wY=;
        b=F+Jl2IO4vh1jQDJRHPE47fgaGvpnSq84YYOf5XEqowFl0xXIw0psjAN1MarauMgG5E
         H5qfcPe4WHpNBFUU+5ly2H3oDkFbKMUHm2x/2b0yXEozb5uD5iEspPkyJFL95mVZxDKy
         wntu9LbH475rmiswRZ051iC2qhhRypZ+8JwbYTPNI7XRu5KqY2jtckWgozGig/L01oub
         oVmPDB1dfsXXWqEFMM3vtStQCTUNUy6ILq1kW3XbgONv6BLQOqjlXVISlRMlK0Tcm+Qt
         MBlh/ox1fLB6wawFmLZEts9Hgs3bZSsL+6rZFaUxh/sHu/m3ux0VvE8YYRqczu6Z3fR+
         UIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791984602; x=1792589402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WPKkYivj8JUBz6V608J8AiLTN9VSzh8FXI9487Jr7wY=;
        b=DY5QQ02kG3GriVXK8HFr1gkC9wQda9nJgwHHuuhHu6uYboMGJR3ZJ/ZE0Y9UZ7qfnK
         g0zXuWoIypNzzhARUJp9Q5QxCEt5PKuMvXxriQj96XqEIU/2dG/2M1A0ds0tKfrxYaye
         spFW4YsxoSQ3oixtDF21qK/5gH0bMI/rWld5rAwpaAhmWoERpylEA+yJG12G2VYVTUMh
         oDkMqc/WRwD5yrfDhWCTzfk4T+9FHE9gvf98Q0VQlarp6/cjsl8a2EzMls7GbP3Dnx/I
         2xJJTy4+ANL2f1X1wUNaJ9wMUij3evithstCB4s/M/Nsq+hHTN+ePhfwkwWcI3UuE6zI
         IGzQ==
X-Forwarded-Encrypted: i=1; AKwUvBx6YtdLtAuKx6/fqQK81mPv+8f66u9k5aNAASHowdNQixAhK9TZGsQJe/M3WQ8GWFjZptAIZ4GeaQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJTL26wXthT94CgPoKAoj2xCZ5itcdoGt9f1d+6LohLgd6kibPi
	LaqdhpwztnvQUW4lIFQ0kOGfKQGxSr+fqN/Jl0/vjiQ/xuMSyCDAf7X8Y0ozS2wMLln2wEGZci7
	ANPigNXeOPJTtnvFVZe+wMX7GMG+IIB/DGVMQUKXZlRTipUD5apq1LFrsgjJwsQ==
X-Gm-Gg: AYBFou09rsz1vmw6kTg/u0HV+gqnMXVZlz6l5gP9thB1nRiOCtf2fJvLRg//DipZ4z6
	6NuAtyKdPwkF+7ZB52kIVZUG5gr851nxMbxJtpV/QS9SILYMTn3m8o4idOfPPh+kuCqfOjeRnKi
	ZceEsioIR0zgrsl0viQPbzwTJOAgNMtlXB0SpG8qc3tuA9D0FO/zIKISpxFreaQpgJ3yx5M3vSO
	E/zBUbicsQIe5ZVgYQphM6rJpM4xwfr5diw200UaMP/h0oIWw93Pmy+3aGzN0B1iTiefsf8eath
	wU5YHZt/sOoUySR6yEflDcGn56NGjNrxYREpOJRmfU77xk/1Mo3zPCWUSwWGxDq6G7TWiGGW99h
	ZLNzZBvaz+dTbB2ItBRPrC4jJpdQ=
X-Received: by 2002:a05:620a:4493:b0:93e:592d:f5a2 with SMTP id af79cd13be357-93ebd0df023mr2426215685a.11.1791984602181;
        Wed, 14 Oct 2026 06:30:02 -0700 (PDT)
X-Received: by 2002:a05:620a:4493:b0:93e:592d:f5a2 with SMTP id af79cd13be357-93ebd0df023mr2426208085a.11.1791984601485;
        Wed, 14 Oct 2026 06:30:01 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bcf552e8sm2027155e9.13.2026.10.14.06.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 06:30:00 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org
Cc: Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hans de Goede <hansg@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        "Derek J. Clark" <derekjohn.clark@gmail.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Jai Luthra <jai.luthra@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Armin Wolf <W_Armin@gmx.de>, Jack Wu <jackbb_wu@compal.com>,
        "Mario Limonciello (AMD)" <superm1@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v1 0/4] Make platform profiles firmware independent
Date: Wed, 14 Oct 2026 15:24:43 +0200
Message-ID: <20261014132500.3817549-1-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RPQmjIi+ c=1 sm=1 tr=0 ts=6acf83db cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=ZMhTd-B8TqveHcltUyQA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: oO-gVdsmvfdhJElfr4SWw1sJdfJYJRRS
X-Proofpoint-ORIG-GUID: oO-gVdsmvfdhJElfr4SWw1sJdfJYJRRS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1MyBTYWx0ZWRfX/blO5uyHnjFm
 Y+GZxdul8HPNmIuEKTq7/zBhBOPBETWeAfQHsBnirkmfabo/W5H0KSPy5u41bXUbUwZLrrMULj+
 9m/E3DJDDlXX0ZqvpyJo7u2LSo7MMxoTiCC2oLjI1+5RY9ksP3arbi5/ruLxhnLWbsJrhEC2Cpv
 tm/ELsrF+5njsqP9zNzbw0B9pI4j6O7JGWXRu+kR+QOUt0mc1pA9WS1m4/ih4oDk3ha1YfvKuqi
 /L+KeyOwbxiUKwTU5F+ao4BjRSvWwEwNihzQtMCMOd0LCPugkv2lLKEXYj8ru/EdpzFi/f7sulr
 j8n1takFUIWzpa7unEzsT0GJx2ewzya/Y53UjjA0gyWRlsT6i56SRn/4NczgvS+Hc0m5ski4eyP
 hxu61ZWHws8HFSfQwl2SR6TSRwWKF/amPh+nnB4XTQHit/ElEova+lhMM0oo5zbCBwwfywgXEYf
 gfbwGgholWdDvCIOXyQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1MyBTYWx0ZWRfX2Vq5j3rA4/+1
 BwxaAukFoTDjqznaKuVVbTtd852DTfTzYkR7WoE9i2XKjFbIujNddTwLn8Igiter0YPHM1Pzkm6
 EVAdFZKmHZI+WsF9OKiuWO0RnQlN3W8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140053

Make platform profile selection independent of ACPI firmware.

The provider API already uses struct device, profile enums and callbacks;
it does not require an ACPI handle or firmware node. However, the core is
built under drivers/acpi/, its Kconfig symbol depends implicitly on ACPI,
initialization fails when ACPI is disabled, and the system-wide profile
interface is only exposed under /sys/firmware/acpi/.

This series moves the core to drivers/platform/profile/ and introduces
CONFIG_PLATFORM_PROFILE, updating all existing provider selectors. It
retains the tristate configuration and platform_profile module name.
Firmware-specific discovery and profile operations remain with providers.
The core can also be selected directly through its Kconfig prompt.

An optional ACPI adapter obtains the legacy sysfs kobject and is linked
into the same module. The generic core contains no ACPI types or symbols
and initializes without ACPI support or with ACPI disabled at boot.
The existing /sys/firmware/acpi/platform_profile and
/sys/firmware/acpi/platform_profile_choices attributes remain available
on active ACPI systems.

The new system-wide interface is:

  /sys/kernel/platform_profile/choices
  /sys/kernel/platform_profile/profile

Both aggregate frontends use the same callbacks, handler set and profile
semantics. The per-provider /sys/class/platform-profile/ interface is
preserved. Notifications cover both aggregate frontends and direct
per-provider writes. The new sysfs location is proposed ABI.

The first patch fixes the lock/lifetime boundary before adding another
frontend: sysfs teardown must not drain callbacks while holding the mutex
those callbacks need. A separate registration mutex serializes lifecycle
changes, while a profile-lock-protected handler list determines aggregate
membership independently of the class device's teardown state.

The second patch extracts the core and uses subsys_initcall_sync() so it
initializes after ACPI and before built-in thermal and CPUFreq consumers.
The third adds the generic aggregate interface, and the fourth documents
the interfaces and extends maintainer coverage.

Validation:

  - ARM64 built-in core with CONFIG_ACPI=n: W=1 build and sparse.
  - x86 modular core with CONFIG_ACPI=y: W=1 object build and sparse.
  - Full x86 kernel link and QEMU boot with lockdep and list debugging,
    with active ACPI and with acpi=off.
  - Firmware-less providers exercising common and hidden choices,
    profile reads/writes, invalid input, mixed profiles, cycling,
    partial callback failures, POLLPRI and legacy/generic shared state.
  - Concurrent sysfs I/O with two persistent providers while a third
    provider is registered and removed 200 times, last-provider attribute
    removal and repeated provider module reloads.

The provider API and profile names are unchanged. Aggregate writes retain
their sequential, non-transactional behavior: a failing callback does not
roll back providers already updated.

Daniel Lezcano (4):
  platform profile: Separate handler locking from sysfs lifetime
  platform profile: Extract the core from ACPI
  platform profile: Add firmware-neutral aggregate sysfs interface
  platform profile: Document firmware-independent profile selection

 .../ABI/testing/sysfs-class-platform-profile  |   2 +-
 .../ABI/testing/sysfs-kernel-platform_profile |  30 +++
 .../ABI/testing/sysfs-platform_profile        |   7 +-
 .../userspace-api/sysfs-platform_profile.rst  |  41 +++-
 MAINTAINERS                                   |   6 +
 drivers/acpi/Kconfig                          |   3 -
 drivers/acpi/Makefile                         |   1 -
 drivers/cpufreq/Kconfig.x86                   |   2 +-
 drivers/platform/Kconfig                      |  16 ++
 drivers/platform/Makefile                     |   2 +
 drivers/platform/profile/Makefile             |   5 +
 drivers/platform/profile/acpi.c               |  15 ++
 .../profile/core.c}                           | 195 +++++++++++++-----
 drivers/platform/profile/profile.h            |  17 ++
 drivers/platform/surface/Kconfig              |   6 +-
 drivers/platform/x86/Kconfig                  |  10 +-
 drivers/platform/x86/amd/pmf/Kconfig          |   2 +-
 drivers/platform/x86/dell/Kconfig             |   4 +-
 drivers/platform/x86/hp/Kconfig               |   2 +-
 drivers/platform/x86/lenovo/Kconfig           |   6 +-
 drivers/thermal/intel/int340x_thermal/Kconfig |   2 +-
 include/linux/platform_profile.h              |   3 +
 22 files changed, 288 insertions(+), 89 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-platform_profile
 create mode 100644 drivers/platform/profile/Makefile
 create mode 100644 drivers/platform/profile/acpi.c
 rename drivers/{acpi/platform_profile.c => platform/profile/core.c} (79%)
 create mode 100644 drivers/platform/profile/profile.h


base-commit: d0cd1e850e1602729dd60dc3c5fd96f80e0cdc5d
-- 
2.43.0

