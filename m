Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61349491591
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 07:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792395619; cv=none; b=caiGMHciEX8fn5cpDsq3rQ4ZuiPMEcAQmzPscoGckDFoPZJcTif3SfF4x+kAPCzmzaoiRYN4gfPzU7f5FK/9jax2r22oC9qOzA9xFsknf6427o/MfDFx6/BkNqO7Cms1/5A4QNN/D0irQCDw3zgZdfPpUGrkoX59jzB7tQ/V/LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792395619; c=relaxed/simple;
	bh=Zk3AtaRrsWVloEcs5Wdm1kb5Rq5+jNt3UApPvmURU9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cmU3ldksA7VwtNtjV52ddps5mnlH5ZstbE3/Nb/iGZ3JaIdeZ3Xc1LG+vaYkhv3RYgCZ+1MkO71/IWePtItn6C7PCsUQjQkIaf3TpbDGp/cX8IuvNoryE+uv8n+I20IeGWAjgiWU88vxaPM6/GiMlLCqbq1VKTawWI/hjZx3iJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q2zATEqf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Dj27jw7o; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q2zATEqf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Dj27jw7o"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J4isps2768394
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 07:40:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=rFGmPQr3jkd
	6FbiHxP2MmwIuITClgB5wxGunUaoARfs=; b=Q2zATEqfMYsyJ/9PlaxMcdU0Lj3
	0fejHnFz0NEsOifkeJUOS0YtZJb/TANwn7KOo8Li6GvhY9M3SqATMECMA1v1THn8
	Mn0j/D/ZO62fCogD5+X44weTWDoYoruDTSd6be1z0iRM014V4Mal8yaDZaC/141Y
	bu/TFSOsywqGYyhXkK9XRegUbVuRSEzIKhY2XtZ4VDIVukWqnJtfRsrfwPFFe4kc
	Gbg+fpATlwA8Au/qaKv5n/9F/Xweq+faupFSstENFHwlfblaD8r3T2qySbsrbIHJ
	08J9bYoDCPHlBqFYCtQswC6fItV3cG4XVYpluwNVy8s7actwbk8Vmv1Pekw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbyys5mvs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 07:40:15 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9308eafb465so591342985a.2
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 00:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792395614; x=1793000414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rFGmPQr3jkd6FbiHxP2MmwIuITClgB5wxGunUaoARfs=;
        b=Dj27jw7oU74ET32/QbJIbLDf9srn/kSoDB3ZNmbtHwsqjTIqpkDGq1COVREwSRwviy
         VVr7OyiXA7bRlhfoE5UkfuzA4FmrN0lRQQHd551zaPDpbQ7hRRrlDeGzmN3D8ZFWmSnS
         enQub4pIq6Aarw/dvSwMKgSD9Qt6RaLx0ZSdDXFh5io4ous5a7dTXfA59+AdKBUaahxi
         2jiBC281x8fE43zpAzb4tGth+5qA/j4nCSLhGXYreeoMMMBWNn9c3QZST/JYWrQliqud
         /4W9TCNnML5lkgcGo52btXuACkN/BpJDx31QrEhwrn01Ye0GsgKO/euY5uQT3nc6vf97
         vZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792395614; x=1793000414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rFGmPQr3jkd6FbiHxP2MmwIuITClgB5wxGunUaoARfs=;
        b=uPgcxDxgvyMtdyMjrYB57IVlNelcwp76z8v8gLLtSIorqgnMla/Of+n7HMBjgFrcZV
         WfK8X0CPLAWmBN9nAHpMCMqlSyd2ufgxBbYOdk/TpK/jtvX+L3BFC7vh8LLevn5nYWO4
         T9K3ApwhR28jHvyL/rYBxUA0DRyXp6bHZcl4zni11gUxX5t63CaAtRQn1YTFXecO0WmQ
         pmxbFqv1TXoj/JKcYjNEuNXXS0I4SfIr/YBYwEXC8fj41zMKJzO0gd91PlKN8Qp4fZKL
         FHzgTyP7xKuhXyepCfLj+5LORBaupeKe3EIQHI8Kl2e5JWAqaJS5arm4J3YmwMNZ02AA
         6G1A==
X-Forwarded-Encrypted: i=1; AKwUvBxQ67A6HFjXW1UMN7nCEkRcg4ZDC6Tcj1McGtBafsMexAjUGOc7Mwxb9VFBUT/JSB+Mlh+peFPOrw==@vger.kernel.org
X-Gm-Message-State: AFq9FYIcJW3wpQ+XwTJm5Ho0Up266uhNBuASLfG0n2jBPhxL7r6nEEra
	Lagh4pXGEt963xA6kUGZTpOg+C6xhqNPS652fzrHOfTNUXEPrv/TOtBGxc0tP0ZGVo+7F3VRJQ1
	ZxhzePrCV4kq0DTd7bivD+guiTfIVOPloCZ7Q50a4M5HoetGQB44cU2V0WakCRw==
X-Gm-Gg: AYBFou0S6FQG1iFeZGs6otp0MwAt6wv1yWiMH8hreK7nRndSjs5d13eYbSSx2acB78A
	tnJSq/hnFK/D5iT+LblZk/qQ0hdGH559Qwpkb8c8PD1DNVhOywAsTH99pTLdrQFwUxVOjsOQ/r1
	vFF2svaK/dMnUVbYA/UBrtBCrUEURaHcMwfououimlosmsq6Xmw/zpGL/N26Wz5/gRVCpRgx6GS
	8uOZAo/PpcnO4mViSiO1mY0rKL0oyGCoEmYTX81GIroLRTBK4rqHmrlY5ELQtYGaYuUpIa7OCPG
	UyZijgKByg1dsv88UnlXwLeDaKAp/xrLbeDe9ADKFx89hT3ggZDji8ajRzQqABLp1Pfloq05T55
	bDkAyOtaNrLEah7guyiUvHHj8Xuc=
X-Received: by 2002:a05:620a:40c3:b0:93e:646c:9133 with SMTP id af79cd13be357-93f29da5d84mr1142212385a.64.1792395614023;
        Mon, 19 Oct 2026 00:40:14 -0700 (PDT)
X-Received: by 2002:a05:620a:40c3:b0:93e:646c:9133 with SMTP id af79cd13be357-93f29da5d84mr1142208685a.64.1792395613447;
        Mon, 19 Oct 2026 00:40:13 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:d01d:2002:4b7d:4c30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1ce325107sm212812955e9.3.2026.10.19.00.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 00:40:12 -0700 (PDT)
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
        Armin Wolf <W_Armin@gmx.de>, Jai Luthra <jai.luthra@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Mario Limonciello (AMD)" <superm1@kernel.org>,
        Jack Wu <jackbb_wu@compal.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Zhang DM <jixianqiang1540@gmail.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v2 5/5] platform profile: Make legacy ACPI aggregate interface optional
Date: Mon, 19 Oct 2026 09:39:08 +0200
Message-ID: <20261019073930.2352283-6-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019073930.2352283-1-daniel.lezcano@oss.qualcomm.com>
References: <20261019073930.2352283-1-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAzMCBTYWx0ZWRfX1h+3jnWr0rvO
 nYUmMtVn48ZULHK34EDMXEPkGwgBChZaqhkbP/bw1GLjNpjypsk3TfAJw/a1C3RZdy5k7hWiRIS
 DXQ8jA1ldoJ2spICQa23JefyvnNNBwFlZIr6GVZ9yALwgT6szo2WOAhur92USNDGTPArvJ5+l1M
 AylRe74gH48Q7FjXielFHGp3YCT4IPvBtmxGG43OUbBt/SqDn6eR87qVMLpxANCB5I5HbOKzbat
 ymicmifeAi1UhLmeMFXrcxjLxzxnjTJm/2LbVU7otG8D3sWOJwbmFBXnliBdkhjWxXnd33Szkgz
 I5ChVuT//UK3PGPD5EvP8/5B0hPmfGva+798Tp+NOtp7UIIIQHfbU4jNVotWdZ+XsczXSYbCWf6
 ytCHS9ZxdWrRjvHy+G+QyzpsCAVkcBjtMTy2A43k5ggsqNN4hs6JE4L+IFG5yAGY9ApBTGzLGfj
 3ij9qCX/ehoIgFRFQXw==
X-Authority-Analysis: v=2.4 cv=W4WtxhWk c=1 sm=1 tr=0 ts=6ad5c95f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8
 a=B7gyEwpuI2iDi5sUgSMA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: Z-VgQCq9Q75uK8K_80fCA1Xv1d2Q2_1b
X-Proofpoint-GUID: Z-VgQCq9Q75uK8K_80fCA1Xv1d2Q2_1b
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAzMCBTYWx0ZWRfXzS4edt+/Ctqh
 6Af5Q/yxBqc0nYoOy0OMo5K/4/Si4bqYmzburwgicKTb26yYflva11uvGM8GscBPSB86XVWxx6/
 F16e1f56zZPoNxxB4SH9EBO9zuPerrk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190030

The aggregate attributes under /sys/firmware/acpi/ are retained
for backwards compatibility. Firmware-independent userspace can already
discover providers through /sys/class/platform-profile/ and control each
provider using its choices and profile attributes.

Add PLATFORM_PROFILE_LEGACY, a boolean depending on PLATFORM_PROFILE and
ACPI, to control the legacy aggregate sysfs interface. Default it to y so
existing userspace continues to work when updating its configuration.

Compile the ACPI adapter and legacy sysfs callbacks only when the option
is enabled. Keep common aggregation helpers in the core because kernel
hotkey users still need platform_profile_cycle(). Class devices and their
notifications remain available regardless of the legacy option.

Document the compatibility option and recommend individual class devices
for new userspace. No daemon changes are included in this kernel series.
Move the legacy ABI documentation to obsolete/, retain its original
creation dates and attribute descriptions, identify the replacement class
attributes, and update its MAINTAINERS entry.

Mark the legacy ABI deprecated and document removal after the 2028 LTS
kernel, conditional on userspace migration. Keep the enabled default
until class-device support has been released and deployed in userspace.
Emit one shared pr_notice_once() when either legacy attribute is read or
the profile is written, identifying actual legacy use rather than warning
merely because the compatibility code was loaded.

Validate ARM64 without ACPI and x86 module builds with the option enabled
and disabled. With ACPI active and the option disabled, QEMU tests confirm
that the legacy attributes are absent while class controls, notifications,
kernel cycling and concurrent registration/removal continue to work.

Assisted-by: OpenCode:gpt-6.1-sol
Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 .../{testing => obsolete}/sysfs-platform_profile   | 12 ++++
 .../userspace-api/sysfs-platform_profile.rst       | 17 +++--
 MAINTAINERS                                        |  2 +-
 drivers/platform/Kconfig                           | 23 ++++++-
 drivers/platform/profile/Makefile                  |  2 +-
 drivers/platform/profile/core.c                    | 72 ++++++++++++++++++----
 drivers/platform/profile/profile.h                 |  2 +-
 7 files changed, 109 insertions(+), 21 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-platform_profile b/Documentation/ABI/obsolete/sysfs-platform_profile
similarity index 70%
rename from Documentation/ABI/testing/sysfs-platform_profile
rename to Documentation/ABI/obsolete/sysfs-platform_profile
index 125324ab53a9..c001c8641a3a 100644
--- a/Documentation/ABI/testing/sysfs-platform_profile
+++ b/Documentation/ABI/obsolete/sysfs-platform_profile
@@ -2,6 +2,12 @@ What:		/sys/firmware/acpi/platform_profile_choices
 Date:		October 2020
 Contact:	Hans de Goede <hdegoede@redhat.com>
 Description:	This file contains a space-separated list of profiles supported for this device.
+		Available with CONFIG_PLATFORM_PROFILE_LEGACY on active ACPI
+		systems for backwards compatibility. New userspace should use
+		/sys/class/platform-profile/platform-profile-X/choices instead.
+		This interface is deprecated, with removal intended after the
+		2028 LTS kernel once userspace migration is complete. Accessing
+		either legacy attribute emits a one-time deprecation notice.
 
 		Drivers must use the following standard profile-names:
 
@@ -27,6 +33,12 @@ Description:	Reading this file gives the current selected profile for this
 		device. Writing this file with one of the strings from
 		platform_profile_choices changes the profile to the new value.
 
+		This legacy interface requires CONFIG_PLATFORM_PROFILE_LEGACY.
+		Individual class devices remain available without that option.
+		Use /sys/class/platform-profile/platform-profile-X/profile
+		instead. This interface is deprecated, with removal intended
+		after the 2028 LTS kernel once userspace migration is complete.
+
 		This file can be monitored for changes by polling for POLLPRI,
 		POLLPRI will be signalled on any changes, independent of those
 		changes coming from a userspace write; or coming from another
diff --git a/Documentation/userspace-api/sysfs-platform_profile.rst b/Documentation/userspace-api/sysfs-platform_profile.rst
index a85ede3fb8e5..a3fc1ee20832 100644
--- a/Documentation/userspace-api/sysfs-platform_profile.rst
+++ b/Documentation/userspace-api/sysfs-platform_profile.rst
@@ -26,11 +26,20 @@ The firmware-independent userspace interface is available under
 ``/sys/class/platform-profile/platform-profile-X/``, with ``name``,
 ``choices`` and ``profile`` attributes for each registered provider.
 
-On ACPI systems, ``/sys/firmware/acpi/platform_profile_choices`` and
+On ACPI systems with ``CONFIG_PLATFORM_PROFILE_LEGACY`` enabled,
+``/sys/firmware/acpi/platform_profile_choices`` and
 ``/sys/firmware/acpi/platform_profile`` remain available as compatibility
 interfaces for aggregate profile selection across registered providers.
-On non-ACPI systems, userspace selects profiles through the individual
-provider class devices.
+New userspace should select profiles through the individual provider class
+devices. These remain available when the legacy interface is disabled and
+on non-ACPI systems. Kernel profile cycling also remains available without
+the legacy interface.
+
+The legacy aggregate interface is deprecated. Removal is intended after the
+2028 LTS kernel, once userspace has migrated to released software using the
+class devices. Compatibility remains enabled by default during the migration;
+the date alone does not trigger removal. Accessing either legacy attribute
+emits a one-time kernel notice directing userspace to the class interface.
 
 Note that this API is only for selecting the platform profile, it is
 NOT a goal of this API to allow monitoring the resulting performance
@@ -70,7 +79,7 @@ Multiple driver support
 When multiple drivers on a system advertise a platform profile handler, the
 platform profile handler core will only advertise the profiles that are
 common between all drivers to the ``/sys/firmware/acpi`` interfaces, when
-ACPI is active.
+ACPI is active and ``CONFIG_PLATFORM_PROFILE_LEGACY`` is enabled.
 
 This is to ensure there is no ambiguity on what the profile names mean when
 all handlers don't support a profile.
diff --git a/MAINTAINERS b/MAINTAINERS
index 929e1e095f17..47b7724f20ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -283,10 +283,10 @@ S:	Supported
 Q:	https://patchwork.kernel.org/project/linux-acpi/list/
 B:	https://bugzilla.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
+F:	Documentation/ABI/obsolete/sysfs-platform_profile
 F:	Documentation/ABI/testing/configfs-acpi
 F:	Documentation/ABI/testing/sysfs-bus-acpi
 F:	Documentation/ABI/testing/sysfs-class-platform-profile
-F:	Documentation/ABI/testing/sysfs-platform_profile
 F:	Documentation/firmware-guide/acpi/
 F:	Documentation/userspace-api/sysfs-platform_profile.rst
 F:	arch/x86/kernel/acpi/
diff --git a/drivers/platform/Kconfig b/drivers/platform/Kconfig
index 395b75f2edf0..7270f24a3b6e 100644
--- a/drivers/platform/Kconfig
+++ b/drivers/platform/Kconfig
@@ -9,12 +9,31 @@ config PLATFORM_PROFILE
 
 	  The core exposes per-provider controls under /sys/class/platform-profile/.
 	  A provider driver must register before profile attributes become
-	  available. ACPI is not required; on ACPI systems the legacy system-wide
-	  interface under /sys/firmware/acpi/ is also provided.
+	  available. ACPI is not required. The legacy system-wide interface under
+	  /sys/firmware/acpi/ can be enabled separately for existing userspace.
 
 	  To compile this as a module, choose M here: the module will be called
 	  platform_profile.
 
+config PLATFORM_PROFILE_LEGACY
+	bool "Legacy ACPI platform profile sysfs interface (DEPRECATED)"
+	depends on PLATFORM_PROFILE && ACPI
+	default y
+	help
+	  Expose platform_profile and platform_profile_choices under
+	  /sys/firmware/acpi/ for compatibility with existing userspace. These
+	  attributes aggregate the profiles of all registered providers.
+
+	  This interface is deprecated and is intended for removal after the
+	  2028 LTS kernel, once userspace has migrated to the class interface.
+	  It remains enabled by default until replacement userspace releases
+	  are available and have had time to reach users.
+
+	  New userspace should use the individual devices under
+	  /sys/class/platform-profile/ instead. Disabling this option removes
+	  the legacy sysfs interface but retains class devices and kernel
+	  profile cycling. If unsure, say Y to preserve compatibility.
+
 source "drivers/platform/mips/Kconfig"
 
 source "drivers/platform/loongarch/Kconfig"
diff --git a/drivers/platform/profile/Makefile b/drivers/platform/profile/Makefile
index ae95ba09383c..787fc9bc961a 100644
--- a/drivers/platform/profile/Makefile
+++ b/drivers/platform/profile/Makefile
@@ -2,4 +2,4 @@
 obj-$(CONFIG_PLATFORM_PROFILE) += platform_profile.o
 
 platform_profile-y := core.o
-platform_profile-$(CONFIG_ACPI) += acpi.o
+platform_profile-$(CONFIG_PLATFORM_PROFILE_LEGACY) += acpi.o
diff --git a/drivers/platform/profile/core.c b/drivers/platform/profile/core.c
index 320a5a964fea..1bffca947157 100644
--- a/drivers/platform/profile/core.c
+++ b/drivers/platform/profile/core.c
@@ -25,12 +25,16 @@ static DEFINE_MUTEX(profile_lock);
 /* Serialize registration and sysfs updates without blocking sysfs callbacks. */
 static DEFINE_MUTEX(profile_registration_lock);
 static LIST_HEAD(profile_handlers);
+#ifdef CONFIG_PLATFORM_PROFILE_LEGACY
 static struct kobject *compat_kobj;
+#endif
 
 static void profile_notify(void)
 {
+#ifdef CONFIG_PLATFORM_PROFILE_LEGACY
 	if (compat_kobj)
 		sysfs_notify(compat_kobj, NULL, "platform_profile");
+#endif
 }
 
 static int profile_update(void);
@@ -304,6 +308,12 @@ static int _aggregate_choices(struct device *dev, void *arg)
 	return 0;
 }
 
+#ifdef CONFIG_PLATFORM_PROFILE_LEGACY
+static void profile_legacy_notice(void)
+{
+	pr_notice_once("The ACPI platform_profile sysfs interface is deprecated and planned for removal after the 2028 LTS kernel once userspace has migrated; use /sys/class/platform-profile/ instead\n");
+}
+
 /**
  * _remove_hidden_choices - Remove hidden choices from aggregate data
  * @dev: The device
@@ -342,6 +352,8 @@ static ssize_t platform_profile_choices_show(struct kobject *kobj,
 	};
 	int err;
 
+	profile_legacy_notice();
+
 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
 		err = profile_walk_handlers(&data, _aggregate_choices);
 		if (err)
@@ -359,6 +371,7 @@ static ssize_t platform_profile_choices_show(struct kobject *kobj,
 
 	return _commmon_choices_show(data.aggregate, buf);
 }
+#endif
 
 /**
  * _aggregate_profiles - Aggregate the profiles across providers
@@ -403,6 +416,7 @@ static int _store_and_notify(struct device *dev, void *data)
 	return _notify_class_profile(dev, NULL);
 }
 
+#ifdef CONFIG_PLATFORM_PROFILE_LEGACY
 /**
  * platform_profile_show - Show the current aggregate profile
  * @kobj: The kobject
@@ -418,6 +432,8 @@ static ssize_t platform_profile_show(struct kobject *kobj,
 	enum platform_profile_option profile = PLATFORM_PROFILE_LAST;
 	int err;
 
+	profile_legacy_notice();
+
 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
 		err = profile_walk_handlers(&profile, _aggregate_profiles);
 		if (err)
@@ -451,6 +467,8 @@ static ssize_t platform_profile_store(struct kobject *kobj,
 	int ret;
 	int i;
 
+	profile_legacy_notice();
+
 	/* Scan for a matching profile */
 	i = sysfs_match_string(profile_names, buf);
 	if (i < 0 || i == PLATFORM_PROFILE_CUSTOM)
@@ -502,6 +520,44 @@ static int profile_update(void)
 	return 0;
 }
 
+static int profile_compat_init(void)
+{
+	int err;
+
+	compat_kobj = platform_profile_compat_kobj();
+	if (!compat_kobj)
+		return 0;
+
+	err = sysfs_create_group(compat_kobj, &platform_profile_group);
+	if (err)
+		kobject_put(compat_kobj);
+
+	return err;
+}
+
+static void profile_compat_exit(void)
+{
+	if (compat_kobj) {
+		sysfs_remove_group(compat_kobj, &platform_profile_group);
+		kobject_put(compat_kobj);
+	}
+}
+#else
+static int profile_update(void)
+{
+	return 0;
+}
+
+static int profile_compat_init(void)
+{
+	return 0;
+}
+
+static void profile_compat_exit(void)
+{
+}
+#endif
+
 /**
  * platform_profile_notify - Notify the provider and aggregate sysfs interfaces
  * @dev: The class device
@@ -728,24 +784,16 @@ static int __init platform_profile_init(void)
 	if (err)
 		return err;
 
-	compat_kobj = platform_profile_compat_kobj();
-	if (compat_kobj) {
-		err = sysfs_create_group(compat_kobj, &platform_profile_group);
-		if (err) {
-			kobject_put(compat_kobj);
-			class_unregister(&platform_profile_class);
-		}
-	}
+	err = profile_compat_init();
+	if (err)
+		class_unregister(&platform_profile_class);
 
 	return err;
 }
 
 static void __exit platform_profile_exit(void)
 {
-	if (compat_kobj) {
-		sysfs_remove_group(compat_kobj, &platform_profile_group);
-		kobject_put(compat_kobj);
-	}
+	profile_compat_exit();
 	class_unregister(&platform_profile_class);
 }
 subsys_initcall_sync(platform_profile_init);
diff --git a/drivers/platform/profile/profile.h b/drivers/platform/profile/profile.h
index 910c9f7da6a0..362eb8cc4592 100644
--- a/drivers/platform/profile/profile.h
+++ b/drivers/platform/profile/profile.h
@@ -5,7 +5,7 @@
 #include <linux/kconfig.h>
 #include <linux/kobject.h>
 
-#ifdef CONFIG_ACPI
+#ifdef CONFIG_PLATFORM_PROFILE_LEGACY
 struct kobject *platform_profile_compat_kobj(void);
 #else
 static inline struct kobject *platform_profile_compat_kobj(void)
