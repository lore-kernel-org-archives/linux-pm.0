Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792882583;
	b=jseWYBRSBBHudNua7/6dBzuF0nvzd22Lz3biRctkadWtS88uhdWrWNYVysE2PvxynihY
	 AESHEZJLgfuvCsCtAiTSGky5nA5VJIzYDe36huevVtJsg2CYyZ4/G0RN3oWkgO0ujVa36
	 aI24hLuwkzJ63ebb9B2vygJhbQYIX5XlGE9e4nLYNhzu54ph3RV4U7L8yvzdINOhIaJAY
	 qJmIYFUt3j/ydE/rPhnb1BiWJ3mIXcJU7Hmp9w4Um2ybr+RrJj03s2CDi5EUriHa3d2Bn
	 hE1qtuR+kaWMyjRGj1ATVhS8vCpA+48iyvnZp+cDNgh/ylHX+Qn3F3edJJIMYcbWFMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792882583;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=KtdPkxiSZqOwEqjhj02FkI3Op22Kf/c+qdzJcWgt0Y4=;
	b=J70AZZQMo9AW0fz2JRgBoOiBKpOxUJHe44ihnuYHcm1gCGKL9p45aR5v29C1m5/8oBpn
	 HZRV5JrnbkvpEAX0O2E3jvuJ0FuZgeHfoQeym7Lby3HXybot5KZg25T3H/5XjMmFnZ80K
	 RIwNMdhR5p6su1VOwUq3ToFLVwBIp5/HK/SpBVtM147z0ojLI+ZpEmvzyKA07qlWirhwF
	 6xvh1viLuWT+qEu+Ts3WX98IjyEXwRy1AX7oH4qQ7sDu7kOITS/LABj4cy2eB4NOKnpMl
	 oXui0IfW8SUFyrP1R9JUPMsGwPNYIBa6ixV3mnfCQico1lw/gSd+QL0MJul6nBHBQzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kV3KU4b1;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TJG4Rv8S;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7C5606A31F
	for <linux-pm@vger.kernel.org>; Sat, 24 Oct 2026 22:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D7C5606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kV3KU4b1;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TJG4Rv8S
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69OLbFbB3751227
	for <linux-pm@vger.kernel.org>; Sat, 24 Oct 2026 22:56:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=KtdPkxiSZqOwEqjhj02FkI3Op22Kf/c+qdz
	JcWgt0Y4=; b=kV3KU4b1BH3js6u+LxfQy7/nA4zNAxsIo2oDBDDJjKRu543nKTH
	ukB+kmZ0NUnH50baqPtoF4uJWLZ2tbpnQ/0l06LoRCwItMMduJY5y+Vwz17A45xm
	PUN41d1+b7FF/BVWq2tXSgrkvM+weTAd7ibR/i4PqYsn0lt5Y0KV72aO6IHNBUiD
	eUpH64TSjPOH9APONiHInp/9AZB5dQTNTnLGKFhP0nsfiMg1y9t9Mn9NN/S9Msew
	BLW9+KA524sroFucPcv5TT6iOJ/g1SzIL+kGZGjHdGafLqNKjNX3v+hCfRBmqTqg
	35L/U6gHN/jzU1tsK9C9IVND1NNFk3nb8mw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgkmsa3sf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 24 Oct 2026 22:56:21 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f32050e72so298844785a.1
        for <linux-pm@vger.kernel.org>; Sat, 24 Oct 2026 15:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792882580; x=1793487380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KtdPkxiSZqOwEqjhj02FkI3Op22Kf/c+qdzJcWgt0Y4=;
        b=TJG4Rv8SQTbY4SwOFYGIfAICdgKIDxbp+Qxjnhd/9IfK8lUZphB+/CGx8XtUqsXdQP
         3GeWjMJIvJrcaiDwWfT8AkIrM3ecXBvrsMc0FpvOOHzMtU/OjZy4XarNdb/fYWjiZwKq
         b2gUAmOjbAcY48H87KYPbtmbjWMDNVl9b2FcZtu1ssfMh0stLaXnn7SIiVS6ttVyExsy
         SuIDVIhDFRMrwgqvXPasKdHdGWgtXmJw10dbLznuEfUfsfC+iumY9eUdJTaOD1TVcmtU
         UE+pqeOpQS4/maZYb25M+tY6V0SIrDtH6IHeEF7kGp3NKy42S+qMMM6Sk1X6WVDvHb8E
         +UtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792882580; x=1793487380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KtdPkxiSZqOwEqjhj02FkI3Op22Kf/c+qdzJcWgt0Y4=;
        b=Me0NszKBld/vFrrHY/m2RmA6gOT9h+GJO4/ZE6m90UfYwRx7qNhAg8lt3IyqE//TPa
         Sk0e1A3/MnuXbhoCFA4nqmix5wrPjvtBXxzKTEQup56/XngCTdz1mYnZgJoHLkSYW/dS
         +YW75hyulr/36EpJfUqXnqJMuMEkxlihRIDhAPEyWNaVp0yYsYCkcEb4ns45ZHRYML0O
         3qiIxIn0Eyoj3y4OOKd4zbsTEI69dQYOSt+mkPq+YdN+hnj23GBtRQBJOP+a9LZ0yQDw
         3OABMfcsth5sFtOh6SeuBSVzLvI78gUuS/Mp8q7Sru2EOsJjB9sd/f1R1rG9QOsa8Jst
         s9pA==
X-Forwarded-Encrypted: i=1; AKwUvBwnsctyO06x9LPDH4SddjR3Kolz6Z8iW46VjRoaPE2wbb/tMaY/0OFTvliSnf+3HAExjbVt8mKMhw==@vger.kernel.org
X-Gm-Message-State: AFq9FYI4sctjilL0CyXH1DcEEFiY2JYrdhqpkgUVISD7AeDBlrfDYZYt
	+JquumhcSng/0P8Y92eetV4GQUXWN1u6QzbqDIacqohYSHySGQIYgtsXVCra63dXvN2fr74RAwO
	HnQGIO2/p74AM/iCf1BGbctx5OciYX0QLgDk5bY3RJ4iTp/RyYKCm34ge/kC6mQ==
X-Gm-Gg: AYBFou0r1x9pEdP+NKJ9VZ4gIF7+NtZ+X16Mumzq9skM+9sDnUPiyCGb/FhcL3ME8bX
	XOnEkfttMyczLVujZNG9LEpaFXlvxG5HyOwmg3WGp3agHN45GzE3PaHzXLtmUAwDlSKfIML5/tR
	cUHSAlio3SxvzhAqMFDmYqheElayNiyXHj0jujreZReR+DDxgMgx5HfMsGM29MuWz1IICebm8HO
	QisKfJ5+46OiKeDJAJdIamGHldLcKcVinDbXj83iV5seL2Yl11BXYfNeDCppmf4reL+fDdkxkVc
	5qK3DTECaJU0UzjD1G8PaR4+Cy1dVIcmy4gq6NN6SUCWplVN52FnixRcCANPXI/Y2jTgUMYwSB6
	SDbPu38B65uqVuCuIZInuywDNiJc=
X-Received: by 2002:a05:620a:2909:b0:939:de48:e41f with SMTP id af79cd13be357-940ef8d8c8amr432341585a.31.1792882580097;
        Sat, 24 Oct 2026 15:56:20 -0700 (PDT)
X-Received: by 2002:a05:620a:2909:b0:939:de48:e41f with SMTP id af79cd13be357-940ef8d8c8amr432338085a.31.1792882579489;
        Sat, 24 Oct 2026 15:56:19 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a359ff2189sm98564145e9.1.2026.10.24.15.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 15:56:18 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org
Cc: Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
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
        Jack Wu <jackbb_wu@compal.com>,
        "Mario Limonciello (AMD)" <superm1@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v3 0/4] Make platform profiles firmware independent
Date: Sun, 25 Oct 2026 00:34:25 +0200
Message-ID: <20261024223501.1420953-1-daniel.lezcano@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: tm-ps9bRxGdNMvmsYKZknQ1UTM4lxTS8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA5MSBTYWx0ZWRfXx6sSGb278sYI
 CIvlmgFXJKycKbfFfIpcB3KtCKK/e1wXmWRLv0vWVvHds7sxTenfeuKpDSCzjWopJKazWu/ZOKs
 6uRODpssysHRFwumvxLSBzBsk2osK0hrjvR6kYY9qmSPPLalAlN8JZpFPcjoPRtEWwWHnRi8aDO
 34Oohzq8/nZfk8pfKaVveA/fl+ml7SP++OSo+aKBTc4xW6fsCdZm+CUauad1rIJUcoLtuATx7dn
 brc7nzy5S8EMeuP/8pn/ZjskS0gyniS1Cl+yNHTPUhCbZum9ArbNSA1kto0c7vKF0Zv1nFUv1cS
 AlY7F2IfcPLNMYxGdoAcyyNU8wLQQml6IdcO+DZLy2vIEQzyIzRSbZwFwQowRVZTYIz4R4e5Y+r
 ontnbxPD0tWE7fQsoYhJxMJAxpIHCCEG20fEEVORBzw3UXsYuLOfIFJdbvb4zD0A8jd8xbuCb5l
 gjvkLaTHY7mS2Yhza3g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA5MSBTYWx0ZWRfX8ERY7tTcj0Qh
 f63VK9gtdOB1AK952T3uo7KswMadrKzfKiKN7ux9BLBcFx+TPS1Era8Mcojc3VSM+jtVs/C17cr
 MmGA1sTTOTjc4f72WAD4oKbYJ6ByhsA=
X-Authority-Analysis: v=2.4 cv=UqX2pOwB c=1 sm=1 tr=0 ts=6add3795 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=2DKhwoluTUTBQ7ciJkYA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: tm-ps9bRxGdNMvmsYKZknQ1UTM4lxTS8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610240091

Make platform profile selection independent of ACPI firmware.

The provider API already uses struct device, profile enums and callbacks;
it does not require an ACPI handle or firmware node. However, the core is
built under drivers/acpi/, its Kconfig symbol depends implicitly on ACPI,
and initialization fails when ACPI is disabled, preventing non-ACPI
providers from using the existing firmware-independent class interface.

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

CONFIG_PLATFORM_PROFILE_LEGACY controls the backwards-compatible aggregate
sysfs interface. It defaults to enabled to preserve existing userspace.
Disabling it omits the legacy sysfs callbacks and ACPI adapter while
retaining class devices and kernel profile cycling. New userspace should
discover and control individual class devices instead.
The interface is deprecated, with removal intended after the 2028 LTS
kernel once userspace migration is complete. A shared pr_notice_once()
warns on legacy attribute access rather than on merely loading the core.
The default remains enabled while userspace adopts released class-device
support; this series does not claim that ecosystem migration is complete.

The existing firmware-independent interface remains:

  /sys/class/platform-profile/platform-profile-X/name
  /sys/class/platform-profile/platform-profile-X/choices
  /sys/class/platform-profile/platform-profile-X/profile

Non-ACPI userspace controls providers individually through these class
devices. Aggregate selection remains available through the legacy ACPI
attributes, and aggregate profile cycling remains available to kernel
callers. No new sysfs directory or userspace ABI is introduced.

The original first patch, "Separate handler locking from sysfs lifetime",
fixing the handler access race and sysfs teardown locking issue, has been
sent separately as a standalone v3 fix. It is not included in this series.
The base tree used here already contains that fix.

Patch 1 extracts the core and initializes it before built-in consumers.
Patch 2 completes class-device notifications and registration cleanup.
Patch 3 documents firmware-independent profile selection through class
devices. Patch 4 makes the legacy ACPI aggregate sysfs interface optional
and documents its deprecation.

Validation performed during development (before this rebase):

  - ARM64 built-in core with CONFIG_ACPI=n: W=1 build and sparse.
  - x86 modular core with CONFIG_ACPI=y: W=1 object build and sparse.
    Both CONFIG_PLATFORM_PROFILE_LEGACY=y and =n are covered.
  - Full x86 kernel link and QEMU boot with lockdep and list debugging,
    with active ACPI and with acpi=off.
  - Firmware-less providers exercising common and hidden choices,
    profile reads/writes, invalid input, mixed profiles, cycling,
    partial callback failures and POLLPRI on the class and legacy ACPI
    interfaces. With acpi=off, class get/set, notifications and kernel
    cycling are exercised. Both runs check that no new aggregate sysfs
    directory is created.
  - Concurrent sysfs I/O with two persistent providers while a third
    provider is registered and removed 200 times, last-provider attribute
    removal and repeated provider module reloads.
  - QEMU with active ACPI and CONFIG_PLATFORM_PROFILE_LEGACY=n: verify
    the legacy attributes are absent, class get/set and notifications
    work, and kernel cycling and registration/removal stress pass.

The provider API and profile names are unchanged. Aggregate writes retain
their sequential, non-transactional behavior: a failing callback does not
roll back providers already updated.

Changes in v3:
  - Send the original first patch fixing the handler access race and
    sysfs lifetime locking separately as a standalone v3 fix, including
    the requested profile_lock protection comment and Fixes tag.
  - Reduce this series to the four remaining patches and renumber them.
  - Rebase the remaining changes onto the current base, which already
    contains the separately submitted locking fix.

Changes in v2:
  - Add the Fixes tag to patch 1 and explain how the mutex-guard conversion
    reintroduced the teardown deadlock previously fixed in 041142d7d252,
    and how class-device support subsequently extended the affected paths.
  - Drop the proposed /sys/kernel/platform_profile/ aggregate interface
    and its ABI documentation. Use the existing firmware-independent
    /sys/class/platform-profile/platform-profile-X/ devices instead.
  - Preserve aggregate selection through the legacy ACPI attributes and
    retain internal aggregation for kernel profile cycling.
  - Refocus patch 3 on class-device notifications for direct writes and
    restoring aggregate visibility after failed registration.
  - Update the Kconfig help and documentation to describe the existing
    class interface and distinguish it from ACPI aggregate selection.
  - Revalidate class controls and notifications with acpi=off, legacy
    aggregation with ACPI active, and the absence of a new aggregate ABI.
  - Add CONFIG_PLATFORM_PROFILE_LEGACY (default y) to make legacy aggregate
    sysfs code optional, independently of class devices and kernel cycling.
  - Mark the legacy ABI deprecated and describe removal after the 2028 LTS
    kernel, conditional on userspace migration. Emit one shared notice on
    legacy attribute access; retain the enabled default during migration.
  - Move the legacy ACPI ABI documentation from testing/ to obsolete/,
    document the replacement class attributes and update MAINTAINERS.

Changes in v1:
  - Initial series extracting the core from ACPI, separating handler
    locking from sysfs lifetime operations and retaining the legacy ABI.
  - Proposed a firmware-neutral aggregate sysfs interface alongside the
    existing per-provider class devices (removed in v2).

Daniel Lezcano (4):
  platform profile: Extract the core from ACPI
  platform profile: Complete class notifications and registration
    cleanup
  platform profile: Document firmware-independent profile selection
  platform profile: Make legacy ACPI aggregate interface optional

 .../sysfs-platform_profile                    |  12 ++
 .../ABI/testing/sysfs-class-platform-profile  |   2 +-
 .../userspace-api/sysfs-platform_profile.rst  |  55 ++++++--
 MAINTAINERS                                   |   5 +
 drivers/acpi/Kconfig                          |   3 -
 drivers/acpi/Makefile                         |   1 -
 drivers/cpufreq/Kconfig.x86                   |   2 +-
 drivers/platform/Kconfig                      |  35 +++++
 drivers/platform/Makefile                     |   2 +
 drivers/platform/profile/Makefile             |   5 +
 drivers/platform/profile/acpi.c               |  15 +++
 .../profile/core.c}                           | 122 ++++++++++++++----
 drivers/platform/profile/profile.h            |  17 +++
 drivers/platform/surface/Kconfig              |   6 +-
 drivers/platform/x86/Kconfig                  |  10 +-
 drivers/platform/x86/amd/pmf/Kconfig          |   2 +-
 drivers/platform/x86/dell/Kconfig             |   4 +-
 drivers/platform/x86/hp/Kconfig               |   2 +-
 drivers/platform/x86/lenovo/Kconfig           |   6 +-
 drivers/thermal/intel/int340x_thermal/Kconfig |   2 +-
 include/linux/platform_profile.h              |   3 +
 21 files changed, 255 insertions(+), 56 deletions(-)
 rename Documentation/ABI/{testing => obsolete}/sysfs-platform_profile (70%)
 create mode 100644 drivers/platform/profile/Makefile
 create mode 100644 drivers/platform/profile/acpi.c
 rename drivers/{acpi/platform_profile.c => platform/profile/core.c} (88%)
 create mode 100644 drivers/platform/profile/profile.h


base-commit: 8244dc8f69f0e73cb1789355260b7d68bf5494e7
-- 
2.43.0

