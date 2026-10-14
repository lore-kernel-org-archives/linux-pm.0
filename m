Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EEB51DAE7
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791984641; cv=none; b=NdN7/zhefL+p/N+IFeAXAtIR50GRXPm3Q/sshggFR8E5WAnjh9k51H1do8J/KWWNEWbdcjBhtoG7ewIYH3TTpVofW+ASSoEs0sUAS7OFYCQneYAHbRXomfsRQlXvtTj1wHFHR5vt9jSFU20qwzDiE4tzCftO1KSZes24w2knWH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791984641; c=relaxed/simple;
	bh=Xj3poXJCAnLJwR5G0Ttzjt9Vg9CWrhjrQ/sePqt56uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NhvUMa9NesA97rckuehGgZq1mZJxlEHZ7lyHtM5diO+J091jTRAUcvEReC99bUvhsPPopaBnGEcj8pfUQO+6ZX9SjjnMCJrnmfGDuZdyxNpSJIGF0wt/O30SHZm3ZSA8EJ+IwXQ9ICpvNGgtOt98KfPLVuehkrBBJlefsqyu2Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B3s7TSty; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZWW453qZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B3s7TSty";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZWW453qZ"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EBIGm23365999
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 13:30:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=cAwukZPw29i
	aC+HmN0aZTgUn1Ex9Dvm+iRL59fFTkSo=; b=B3s7TStyz29l+gCm+VHtVVvT88A
	4BV7570GSX8hymAPG0huWNNoMn2YAxbMJBEWHrtjSgtQgdJYC+7fPW0exoPzSGqy
	9n7ud+K8H001xvudRGWO/KNapnpN8k98tT7FkBvMN71/mXwAeFDrJPY57XeRCMN3
	U1fItKy5U4tHbmIsNQX7SqTVXGGbxhvhZnAM1HQJIcvPSc1ErxFi0SXCPzHzYANy
	sY6G9yt21YXifPmEH55A56XRKLmXfZvb+2RgD59bmxu0cexMhVRd5orQG0vk74vm
	tEc000ocBbvjoVVNuZsaMlGoGFrZf1qHQsNin9fOyqVJiFBsgeJPmekZNnQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha4621stj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 13:30:30 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93cb7f9bb86so836205085a.2
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 06:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791984630; x=1792589430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cAwukZPw29iaC+HmN0aZTgUn1Ex9Dvm+iRL59fFTkSo=;
        b=ZWW453qZpwcWMD8eWLoTVSYhrjBQ+6EFHW02o0TDKP+qfatewKnNGhCrcmixPgDPkB
         qYe3YTq9fbj5K6wBgjq9LSXpLFHiFj2oYLuqQNIFfqdNK6wSdcoa3hQo8fdtIQWV55DE
         7zkf9CkDNz+2bvAZhIwsrxE9OeAWD6Lc4FxQ//UQEnSfWOR9h3LQjLvslcOhjkUBEvkH
         /cPyE+ikU5eDfjj24bTIURrXx/A6llmQN9GAAVsjr3dcJq8CPdmpjz1WyXhw1QdiVAgQ
         LQ2yZKtksyPDDJwOLpguXCnKfTt8OIHtil9YWUa/9ZAmJVS0sxXsijl6PPvFi2bMG2yB
         yG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791984630; x=1792589430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cAwukZPw29iaC+HmN0aZTgUn1Ex9Dvm+iRL59fFTkSo=;
        b=Rv3uSgB35JSiytI5wm5DoC+k3OiE3TguF2xgqsLLoi6ybve5Vk5IV95X0D7EeCZyi8
         /g+GYjlnS4pMHjX/t9r1OgX9yK2FHNSY8sZmqdAlFSUCIHGVlnRcCrgwXEPwUApAkwcP
         QOGXh3DHTMGU9/kkh/MQG+iBHhk/uNXrl2ULHd9IbtWa26t/PAEygd6/GU87Xwew/5pp
         zVWYjPPiPXkeoiMu00ktobQJoCWtd8Y57mnHXYjc2y44nGCvekWvFlrE/aZEKSHgYC7X
         8QCkuwXse77eanVgnz7QYt2XAQCaWWR8GLS5tKHB9kd7m86eEYESWH8MPx3aNeN2RMdp
         sXqw==
X-Forwarded-Encrypted: i=1; AKwUvBxKNUo+6u9voT5bYZSRW0v8rCEncSvkG7PS6MN2L8/YcJbhyW/AR6o8Cq1fBGikDhDIsq+WMi0axw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLuwZxadZer7yMIzskVaB+Pozg4eWGBO6+zBgw2iWC8gZHvlSkK
	wbZ1sk30dHviGGdeJlkmTTEk12kPTrsbCWpsDj3G8N73JSaIbHjQr/pbobI6gAlEUQGcJVQKKHa
	4nIxALb7K8Pq9yRfgRlraBf++YlQW5HYOkKHzDrR051t0QjR0/CuJAWMMZnNgWw==
X-Gm-Gg: AYBFou1JFv2ZMa7YFGND7JIb6/MwioaO7aWf1UiZxp7pbUQBygmkuCO3YDAYFa+FlOg
	SoIRNBleZGMa+f3DmGXMswrPFADjb8MkacNyImFBah7/h2KoUxu4sbywyey7VyZ6izPPuaQ5itb
	SeiOBlrBb58b470wqMDQWtaiT4vMM9J98bGyW7VvRYvztj5CyFutkwldvSf1XrrqoINmf9HbKIu
	nDH7z666XzCksp47Dhw0nthPoWjGygUNLe9sCAsgwBfrPt9SeQcoAoZaCOsKnxe87Nd8bsNWuEm
	CcFiURKSDHcUQaQo7K4fZ1KbSG2ryPYOwNqEXOuzqgv5K6qf95tz7cg7rnqiyCV77jj2NocmzGu
	dkj2juKGSIHf72SQvBh/zT5dUFgo=
X-Received: by 2002:a05:620a:2a0f:b0:93b:d7a0:d9e1 with SMTP id af79cd13be357-93ebd2445b1mr2507774385a.59.1791984629650;
        Wed, 14 Oct 2026 06:30:29 -0700 (PDT)
X-Received: by 2002:a05:620a:2a0f:b0:93b:d7a0:d9e1 with SMTP id af79cd13be357-93ebd2445b1mr2507765785a.59.1791984629021;
        Wed, 14 Oct 2026 06:30:29 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bcf552e8sm2027155e9.13.2026.10.14.06.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 06:30:24 -0700 (PDT)
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
        platform-driver-x86@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v1 4/4] platform profile: Document firmware-independent profile selection
Date: Wed, 14 Oct 2026 15:24:47 +0200
Message-ID: <20261014132500.3817549-5-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014132500.3817549-1-daniel.lezcano@oss.qualcomm.com>
References: <20261014132500.3817549-1-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 7nc2QeMLLc_1-V1kvaKr66wOLpQ341XH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1MyBTYWx0ZWRfXxwWhJx/Ak1wH
 n4L2QypGMwauwBbMnqK8uJ0uiGXjjur9kgvvTxb/0bZl0VCogCr6RPCDFdCoZRVTGLF8EI5uJYD
 +mCcQPAFcXrn4T8zNSCFoslnhy5GUKUcthTkqr1g/vJJZi2wKhx8DLvSpcpyrk1FEx/0kH3pQCJ
 WWvpL2pUV4SglWmAlZOXEm3tfPV/nROIh3mkUIhjcHN5eWSxNwgsRjhnRBiGeIuAFODhXHRqdDX
 y4oiQjWDnWlsmnCmdXM2ZtIS2gWcnkKNQF1XNToN00EGZxc4Vad5gZxKRNaQHjJh5dCMeRBe9Fq
 2U/V/OuN5O2CHE6XjkUE9SVjdo/i2uZ8nye8SmEcPCjwGIxqmNmIjkaBRo7Ncrlju/RaewpnKK7
 lcMpOyu/5p71wQY56MzCY4X3Qk6ZLZAYhziBPUbS3dWOlb7IP0u8qnNrPzQI8T5tyTMfPk/Pidh
 dYCWq3f0hUQGkSjKyWg==
X-Authority-Analysis: v=2.4 cv=ErZHPicA c=1 sm=1 tr=0 ts=6acf83f6 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8
 a=sQUSrHfsy0YXJ0PWmfUA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1MyBTYWx0ZWRfX43nHIMbV7V5A
 9OG2peyqnABg1ZE77qCSCzKvESFUwwesD+yqw+K5RUe3lsaBBp1Zr76c/GUtJ9VBG20Fjoxuv9D
 WAUz4x8E4ODcmebtbhnWLtvObXAR5Cs=
X-Proofpoint-GUID: 7nc2QeMLLc_1-V1kvaKr66wOLpQ341XH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140053

Describe the firmware-neutral aggregate interface, retained ACPI
compatibility paths and unchanged device-based provider API. Document
hidden choices, mixed profiles and the sequential application of
aggregate writes.

Correct the per-provider attribute reference and extend existing ACPI
maintainer coverage to the extracted core and its interfaces.

Assisted-by: OpenCode:gpt-6.1-sol
Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 .../ABI/testing/sysfs-class-platform-profile  |  2 +-
 .../ABI/testing/sysfs-kernel-platform_profile | 30 ++++++++++++++
 .../ABI/testing/sysfs-platform_profile        |  7 +++-
 .../userspace-api/sysfs-platform_profile.rst  | 41 ++++++++++++++-----
 MAINTAINERS                                   |  6 +++
 include/linux/platform_profile.h              |  3 ++
 6 files changed, 77 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-platform_profile

diff --git a/Documentation/ABI/testing/sysfs-class-platform-profile b/Documentation/ABI/testing/sysfs-class-platform-profile
index fcab26894ec3..75e0f6e2c128 100644
--- a/Documentation/ABI/testing/sysfs-class-platform-profile
+++ b/Documentation/ABI/testing/sysfs-class-platform-profile
@@ -35,7 +35,7 @@ Date:		March 2025
 KernelVersion:	6.14
 Description:	Reading this file gives the current selected profile for this
 		device. Writing this file with one of the strings from
-		platform_profile_choices changes the profile to the new value.
+		choices changes the profile to the new value.
 
 		This file can be monitored for changes by polling for POLLPRI,
 		POLLPRI will be signaled on any changes, independent of those
diff --git a/Documentation/ABI/testing/sysfs-kernel-platform_profile b/Documentation/ABI/testing/sysfs-kernel-platform_profile
new file mode 100644
index 000000000000..c64a175873e2
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-platform_profile
@@ -0,0 +1,30 @@
+What:		/sys/kernel/platform_profile/choices
+Date:		October 2026
+Description:	Space-separated list of standard profiles supported across all
+		registered platform profile providers. Profile names have the
+		meanings documented in sysfs-class-platform-profile.
+
+		The file is read-only and is present while at least one provider
+		is registered. Reading fails with EINVAL when providers have no
+		common choices. Hidden choices may contribute to the common
+		choices when multiple providers are registered; with a single
+		provider only its visible choices are listed.
+
+What:		/sys/kernel/platform_profile/profile
+Date:		October 2026
+Description:	Reading returns the current profile when all providers agree,
+		or "custom" when they have different profiles or a provider
+		reports a custom configuration.
+
+		Writing a profile listed in choices applies it to all providers.
+		"custom" cannot be written. Changes are applied sequentially;
+		an error does not roll back providers already updated.
+
+		The file is read-write and is present while at least one provider
+		is registered. It can be monitored with poll() for POLLPRI.
+		Notifications cover successful userspace writes and changes
+		reported by providers, for example after a firmware hotkey event.
+
+		On ACPI systems this interface shares its state with the legacy
+		/sys/firmware/acpi/platform_profile interface. The interface is
+		also available without ACPI support or with ACPI disabled.
diff --git a/Documentation/ABI/testing/sysfs-platform_profile b/Documentation/ABI/testing/sysfs-platform_profile
index 125324ab53a9..ee32e222af64 100644
--- a/Documentation/ABI/testing/sysfs-platform_profile
+++ b/Documentation/ABI/testing/sysfs-platform_profile
@@ -2,6 +2,8 @@ What:		/sys/firmware/acpi/platform_profile_choices
 Date:		October 2020
 Contact:	Hans de Goede <hdegoede@redhat.com>
 Description:	This file contains a space-separated list of profiles supported for this device.
+		This is the ACPI compatibility interface for the system-wide
+		/sys/kernel/platform_profile/choices attribute.
 
 		Drivers must use the following standard profile-names:
 
@@ -23,7 +25,10 @@ Description:	This file contains a space-separated list of profiles supported for
 What:		/sys/firmware/acpi/platform_profile
 Date:		October 2020
 Contact:	Hans de Goede <hdegoede@redhat.com>
-Description:	Reading this file gives the current selected profile for this
+Description:	This interface shares its state with
+		/sys/kernel/platform_profile/profile.
+
+		Reading this file gives the current selected profile for this
 		device. Writing this file with one of the strings from
 		platform_profile_choices changes the profile to the new value.
 
diff --git a/Documentation/userspace-api/sysfs-platform_profile.rst b/Documentation/userspace-api/sysfs-platform_profile.rst
index 6613e188242a..37b98e5075db 100644
--- a/Documentation/userspace-api/sysfs-platform_profile.rst
+++ b/Documentation/userspace-api/sysfs-platform_profile.rst
@@ -1,6 +1,8 @@
-=====================================================================
-Platform Profile Selection (e.g. /sys/firmware/acpi/platform_profile)
-=====================================================================
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================
+Platform Profile Selection
+==========================
 
 On modern systems the platform performance, temperature, fan and other
 hardware related characteristics are often dynamically configurable. The
@@ -15,6 +17,21 @@ operation or towards performance.
 The purpose of the platform_profile attribute is to offer a generic sysfs
 API for selecting the platform profile of these automatic mechanisms.
 
+The framework is independent of the firmware interface used by a provider.
+Drivers can implement profile selection using ACPI, an embedded controller,
+or another platform-specific mechanism. The core does not discover providers
+or interpret firmware descriptions.
+
+The system-wide interface is ``/sys/kernel/platform_profile/``, containing
+``choices`` and ``profile`` attributes. These attributes are present while
+at least one provider is registered. Per-provider interfaces are available
+under ``/sys/class/platform-profile/``.
+
+On ACPI systems, ``/sys/firmware/acpi/platform_profile_choices`` and
+``/sys/firmware/acpi/platform_profile`` remain available as compatibility
+interfaces. They operate on the same providers as the system-wide interface,
+and changes are notified through both interfaces.
+
 Note that this API is only for selecting the platform profile, it is
 NOT a goal of this API to allow monitoring the resulting performance
 characteristics. Monitoring performance is best done with device/vendor
@@ -52,13 +69,14 @@ Multiple driver support
 =======================
 When multiple drivers on a system advertise a platform profile handler, the
 platform profile handler core will only advertise the profiles that are
-common between all drivers to the ``/sys/firmware/acpi`` interfaces.
+common between all drivers to the system-wide interface and its ACPI
+compatibility interface.
 
 This is to ensure there is no ambiguity on what the profile names mean when
 all handlers don't support a profile.
 
-Individual drivers will register a 'platform_profile' class device that has
-similar semantics as the ``/sys/firmware/acpi/platform_profile`` interface.
+Individual drivers register a ``platform-profile`` class device with
+``name``, ``choices`` and ``profile`` attributes.
 
 To discover which driver is associated with a platform profile handler the
 user can read the ``name`` attribute of the class device.
@@ -74,7 +92,10 @@ same system. If the selected profile by individual drivers differs the
 platform profile handler core will display the profile 'custom' to indicate
 that the profiles are not the same.
 
-While the ``platform_profile`` attribute has the value ``custom``, writing a
-common profile from ``platform_profile_choices`` to the platform_profile
-attribute of the platform profile handler core will set the profile for all
-drivers.
+While the system-wide ``profile`` attribute has the value ``custom``, writing
+a common profile from ``choices`` to it will set the profile for all drivers.
+``custom`` cannot be written to the system-wide interface.
+
+Profile changes are applied to providers sequentially. If a provider returns
+an error, providers updated earlier are not rolled back. Userspace can read
+the per-provider interfaces to determine their resulting state.
diff --git a/MAINTAINERS b/MAINTAINERS
index 8014b9f8253e..778275ff20b6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -285,10 +285,15 @@ B:	https://bugzilla.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
 F:	Documentation/ABI/testing/configfs-acpi
 F:	Documentation/ABI/testing/sysfs-bus-acpi
+F:	Documentation/ABI/testing/sysfs-class-platform-profile
+F:	Documentation/ABI/testing/sysfs-kernel-platform_profile
+F:	Documentation/ABI/testing/sysfs-platform_profile
 F:	Documentation/firmware-guide/acpi/
+F:	Documentation/userspace-api/sysfs-platform_profile.rst
 F:	arch/x86/kernel/acpi/
 F:	arch/x86/pci/acpi.c
 F:	drivers/acpi/
+F:	drivers/platform/profile/
 F:	drivers/pci/*/*acpi*
 F:	drivers/pci/*acpi*
 F:	drivers/pnp/pnpacpi/
@@ -296,6 +301,7 @@ F:	include/acpi/
 F:	include/linux/acpi.h
 F:	include/linux/fwnode.h
 F:	include/linux/fw_table.h
+F:	include/linux/platform_profile.h
 F:	lib/fw_table.c
 F:	rust/helpers/acpi.c
 F:	rust/kernel/acpi.rs
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index 855b28340e95..f23f9827eac6 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -2,6 +2,9 @@
 /*
  * Platform profile sysfs interface
  *
+ * Providers may use any firmware interface or implement profiles in software.
+ * The parent device does not need an ACPI companion or a firmware node.
+ *
  * See Documentation/userspace-api/sysfs-platform_profile.rst for more
  * information.
  */
-- 
2.43.0

