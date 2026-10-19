Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89D848E0D5
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 07:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792395609; cv=none; b=gxZ+9uo2WRglJK6vEblJvaaMjWLI9hveOVNsyS5pZUs+U1uwVGlokYPQLXJrLJpF9FNdwaKcREXZDcRznNUoq78JUucR1uQvejgIJFwy4jh/A7Rq3e3OV1eRzbW6zqxiMCm3izW8Zc3TH7kBh6X8c7zqTTVctvOXvUsD44HYK04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792395609; c=relaxed/simple;
	bh=UAKxb2sO19EjjUuXra2lzxhVdgml7sw5ft9FMCzbe1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8mrj2ISNv5GuvI1uZNKPkwvVLIrDHTb06n8MjiAEA6ejuOyIcbLIJl0JJSuwCejWAYnjYyY7SUMtTR+g2BzTMKI7RCcT6gdzW36ZStwQx4EEu+hMSAZGRE0XTk9v7N6PTANTtoQ0+Q4Kyt5IBz47dh97TgreZL2GkT0vt67qbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a0RKcATq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C1NAoQHU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a0RKcATq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C1NAoQHU"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J4jFMk2821625
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 07:40:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=/6zJMYsjAxH
	JLinn/mQnZ7v0Rd1A8UU3vQ1u2rl25ww=; b=a0RKcATqF2EChomZWgY1lOK6Z9h
	EEkuT9nCDSTZ8eYMh47J/ja+L5HULtAUZM7+WOcquRc3udvadcf6C3J/hbxUQ8gJ
	nQiANiYMEhYn5b5Ye7p87vt+F7ZY940q3AaBaf9yRvE6hh+LnTikb/WgrFaAQveb
	3ka2tPjFhSI+xTZJ3ztWEf7wyPiqHHUPSMrU4uo8nIXz06SfwgPkv2XI/h2mOFTH
	RLzUOcA64puAqhQoDlxVHXTsya77r0h7DShQ+20UPX2LLlkG+/yqCTEuj1NzXROz
	M2Dn0snaoqgx0Ltasl9RPklFPERDAJDNgiH6MsmkvkePmNdt4O2FJ8ig7Jw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbxqfwt5y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 07:40:03 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f1e62510cso451100885a.1
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 00:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792395603; x=1793000403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/6zJMYsjAxHJLinn/mQnZ7v0Rd1A8UU3vQ1u2rl25ww=;
        b=C1NAoQHUAYvpXL0au+3jB9vnX/eFDYoslVPtaFXaMRZKtYqWGRhLu4vKHx42Z+EkVI
         p3TOFXVjtj1/51Ug7X76d8RFnFranHDAmIO65Y+xbI7KlwN98b6W+Q5ddc41ZNNurpQI
         8lYSYMoDJ4QBymAL3a4lpwsY4nHz5Fyv6V62NM3dab5/qs5A9OMU48ZTI85YngRAnUaA
         sasOaIEuhg/nljKbkG/eCvejL5IieIL8ApmdzEXGPnLTdk9D386upAqGr6Uj/2pybCec
         Pf8rPWpcZF5S2OKhIetMgDcaGc81s3Y6houtpmbyEdZeknUd8GOMTGYeHZ1M68aNhCK0
         ZUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792395603; x=1793000403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/6zJMYsjAxHJLinn/mQnZ7v0Rd1A8UU3vQ1u2rl25ww=;
        b=BqylYyAanyhTjNzJ0BiXaAeaYYGC/0xt/zehRdxNfaUvRE/7LAtiY+fMSpe+VeeMHf
         9SbCqJpLm9pLGxtUV6s9hcyItQcWrwXsPHBApG01uLnuTOtuaE5qpbKC1AJ9sKnXJOni
         uEtSyLdViUahLBShWdjqqcwmisyFM5kOFfgCOo51QfHGz9l5LDXPrxJV5eOKa+HmDFlm
         /LI0DcwWwJ7wU9ZtEEXzrnpzjOw/2NWnl4CDHcnShrVjimIP+7J/WafN9VTg8qbMsSwk
         jABchcPx4xhrJ9TX8IJreLjwRVQyVADXu4n+yFO0Bm4HTZT15V2D1zUWs0H/WQev5rs8
         AwKA==
X-Forwarded-Encrypted: i=1; AKwUvBx7WaCjYWT92v0mAMsZS6PftKy8a8uj+jiXNh6luJLOymB1nLLMtTTrnYKUyTwo3POxyHC2VBm6BA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKj0HcMaXchDBJXeahOd+zSDVSTzlKEx21s3ReDnarYGEDmGOcw
	zJAfiBVZ5oQOVEsmy7+XbyPO27e/P81Z6ZFxVrd8xRIgtN0t6OFm8y8zcTMC2QjovTZ9LGKbAHX
	+MiCJfzoghwiJO9l2oVkZR4WVl2JObK0uiRaPHl2qEIsBJDgPKQnFV/piz/33Wg==
X-Gm-Gg: AYBFou09R57GA5nGgph28hmqlz+CK04z6GM4yCuwzGQStYzMTd9XBmzBtkmrmLK9RmV
	ALemTzZsPdkkDXDMIxl/OtzYT7+RzuOdj5RGjXzLbVM9SjvZiirqvZVeBP7RWje/iDDL9SfUFzd
	/n6q79pria/lF6DymnVNKFiS111gi86IjIKTutLcMHIumludDQm3cS9SOQ3pmDvWRJ91ZBTSPJJ
	Z2EDHfcbikXuOlgYT65/5rXma1TZpRdQl36KtLHUAqazfKGA+Rg8IJ5D2SA/FjxG3v2oPeWu0A3
	CPpMSzmZV1d6RJJomycYprMpL+cKFJ4yvFnROZ2m7WwqmW7EfDwfeqNaTEj1lcoVJc1NK9tE/4t
	B9k6p91cJcdjAopq9+SSk+zKVbCA=
X-Received: by 2002:a05:620a:2989:b0:937:6de8:b40 with SMTP id af79cd13be357-93f29ceec65mr1174371885a.15.1792395602374;
        Mon, 19 Oct 2026 00:40:02 -0700 (PDT)
X-Received: by 2002:a05:620a:2989:b0:937:6de8:b40 with SMTP id af79cd13be357-93f29ceec65mr1174368785a.15.1792395601887;
        Mon, 19 Oct 2026 00:40:01 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:d01d:2002:4b7d:4c30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1ce325107sm212812955e9.3.2026.10.19.00.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 00:40:01 -0700 (PDT)
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
Subject: [PATCH v2 4/5] platform profile: Document firmware-independent profile selection
Date: Mon, 19 Oct 2026 09:39:07 +0200
Message-ID: <20261019073930.2352283-5-daniel.lezcano@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAzMCBTYWx0ZWRfX4x4qjl68g9Ct
 d8XxxqDsYmwcg0gwCanVx5bVhVgWPvakusNpHZdUTKwr2C9V6WVFeV0dbk0K1PEPCAmrm3kZqX9
 ukl7iZXJJgiQI96UEILwubNwFxJGao0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAzMCBTYWx0ZWRfXyeO/pf7nDw5S
 RFwJ1N9Uph34YGjliPSLOfOOrpAyPrOVQ+ZuGRehxIhLp4iz8xoLetPXb7q8zohhwItyqFw+r51
 R1scVOedL1j3z2TZpdAEE14dKybKB2pRPEljhy+DSKscpm9Uq5OufYZuGvZ4Sl8yaG/jFGE44xT
 Vbn5YRPzf6G8H7/AVoOf/Rx+TtSXDCxtQWraae6+RbRrwuJHGMYmD5n18f6DeD/Lpn3HjEDGwjA
 z7/9eODXit14/dZ8otbH1zJUZGVJBACMdEyrJlUtsVJCuAp6/sZ2Ygajdf34xfAK2OfVUUC+N+5
 ak/Q0vB3Yz8cUFumzwQr0HhAy2uc027SuTToFZnV4jpCy4Ainl7bb67ZHdlQbg9RgEO6LRwXqQh
 HteJjr95kpf2GxHH878AG5pOYSeUxOszgqnuQG4wyHlkuPVfRLgERpVSWYEMaskUJfzxW1Wjw6i
 G6S8FjXNm31gOW9VthA==
X-Proofpoint-ORIG-GUID: g2nP3oM_YDVWSGXAqnfNh1oNrKJpodYm
X-Proofpoint-GUID: g2nP3oM_YDVWSGXAqnfNh1oNrKJpodYm
X-Authority-Analysis: v=2.4 cv=RYMFmFtv c=1 sm=1 tr=0 ts=6ad5c953 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=uEqVyaLVsi9FIuCuvY4A:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190030

Describe the existing per-provider class devices as the firmware-neutral
userspace interface. Explain that providers can use any firmware transport
or implement profiles in software, without an ACPI companion or firmware
node on their parent device.

Retain the ACPI paths as compatibility interfaces for aggregate selection.
Clarify that non-ACPI userspace selects individual providers and document
the sequential application of aggregate writes and their partial-failure
behavior. No new userspace ABI is introduced.

Correct the per-provider choices attribute reference and extend existing
ACPI maintainer coverage to the extracted core and its interfaces.

Assisted-by: OpenCode:gpt-6.1-sol
Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 .../ABI/testing/sysfs-class-platform-profile  |  2 +-
 .../userspace-api/sysfs-platform_profile.rst  | 46 ++++++++++++++-----
 MAINTAINERS                                   |  5 ++
 include/linux/platform_profile.h              |  3 ++
 4 files changed, 43 insertions(+), 13 deletions(-)

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
diff --git a/Documentation/userspace-api/sysfs-platform_profile.rst b/Documentation/userspace-api/sysfs-platform_profile.rst
index 6613e188242a..a85ede3fb8e5 100644
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
+The firmware-independent userspace interface is available under
+``/sys/class/platform-profile/platform-profile-X/``, with ``name``,
+``choices`` and ``profile`` attributes for each registered provider.
+
+On ACPI systems, ``/sys/firmware/acpi/platform_profile_choices`` and
+``/sys/firmware/acpi/platform_profile`` remain available as compatibility
+interfaces for aggregate profile selection across registered providers.
+On non-ACPI systems, userspace selects profiles through the individual
+provider class devices.
+
 Note that this API is only for selecting the platform profile, it is
 NOT a goal of this API to allow monitoring the resulting performance
 characteristics. Monitoring performance is best done with device/vendor
@@ -52,13 +69,14 @@ Multiple driver support
 =======================
 When multiple drivers on a system advertise a platform profile handler, the
 platform profile handler core will only advertise the profiles that are
-common between all drivers to the ``/sys/firmware/acpi`` interfaces.
+common between all drivers to the ``/sys/firmware/acpi`` interfaces, when
+ACPI is active.
 
 This is to ensure there is no ambiguity on what the profile names mean when
 all handlers don't support a profile.
 
-Individual drivers will register a 'platform_profile' class device that has
-similar semantics as the ``/sys/firmware/acpi/platform_profile`` interface.
+Individual drivers register a ``platform-profile`` class device with
+``name``, ``choices`` and ``profile`` attributes.
 
 To discover which driver is associated with a platform profile handler the
 user can read the ``name`` attribute of the class device.
@@ -71,10 +89,14 @@ by writing to the ``profile`` attribute of the driver's class device.
 
 This will allow users to set different profiles for different drivers on the
 same system. If the selected profile by individual drivers differs the
-platform profile handler core will display the profile 'custom' to indicate
-that the profiles are not the same.
+ACPI aggregate interface will display the profile 'custom' to indicate that
+the profiles are not the same.
+
+While the ACPI ``platform_profile`` attribute has the value ``custom``,
+writing a common profile from ``platform_profile_choices`` to it will set
+the profile for all drivers. ``custom`` cannot be written to this aggregate
+interface.
 
-While the ``platform_profile`` attribute has the value ``custom``, writing a
-common profile from ``platform_profile_choices`` to the platform_profile
-attribute of the platform profile handler core will set the profile for all
-drivers.
+Aggregate profile changes are applied to providers sequentially. If a provider
+returns an error, providers updated earlier are not rolled back. Userspace can
+read the per-provider interfaces to determine their resulting state.
diff --git a/MAINTAINERS b/MAINTAINERS
index 8014b9f8253e..929e1e095f17 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -285,10 +285,14 @@ B:	https://bugzilla.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
 F:	Documentation/ABI/testing/configfs-acpi
 F:	Documentation/ABI/testing/sysfs-bus-acpi
+F:	Documentation/ABI/testing/sysfs-class-platform-profile
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
@@ -296,6 +300,7 @@ F:	include/acpi/
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

