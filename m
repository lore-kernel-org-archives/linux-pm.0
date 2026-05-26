Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F913FDBEF
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 14:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779804524; cv=none; b=XW3a7Dam7ryM5qMlWlUnT31s4NfjW8uhuuzk/b2YuMqZ48GCH68uTF8RqfXaISKe4W9/NOasTCcBrvy6F1iMUTTVfWuAgSAtxAjsGebzVLEBsE+cfu/54YHPyCzj9E7AKOJ7uOicyaB2xkHX5kwtYfZ8kjF9S+RoIr/RCIgZnJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779804524; c=relaxed/simple;
	bh=SW8Dm2ZVmkfgDXJS9AQQGS/QJqRyDAQCLvTud8id3Wg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jDzUke0dgVvvVuWDDUgPqfbNQHTMFKRIhfq85Yzse/SGD+TfbLvyM4430FCAcvlG4p7h6QTuHZHOgvPfRly/j0Kh1PYypWceV2RqjEDaQJBvQbYNqinJg8NBLf8KEQ66uM59QzrbbbxfOenEC30M5xfsZnCRtv3lFIduATVm41M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mqRalz5+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EcPt+0HO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mqRalz5+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EcPt+0HO"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QCsigN3797184
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 14:08:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=AdHU4bNEE8eb4xBsOmQzID
	d+JgvYhcdCLMFgnvT8TVA=; b=mqRalz5+q/0+Aqt4fqzWuaX5DXhzFEjDo8exJv
	NyYvQ0hE6wJICpYlYwe5Q6xgX5SPVNDv9PfvD/ldmlp9ajdb5juEbS8ZhkNor+ep
	a/v6XVkXbkWr271s+Ka6qOepo7lqSXg14v13UHms0/VOePdnwZKhfC6xty5NvxXS
	+9/Wj4JKdDUaq3DNFLI4mg6y5phAnFimvCZuuJfvvKZy6MSunHMXKpcnXhtBcCZG
	7OQpTc0zv+WvLI9S0ivl7kaursOHNJNyLLb/jhzqDF8SX30n7JnXL52Nqrim/KwX
	p7rBg4qbMzn+qkM1RmjZNMCLUHHgev+B6GcWYy9C2yz6UIlA==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecpy2mucd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 14:08:40 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-69d98b46affso3416451eaf.1
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 07:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779804520; x=1780409320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AdHU4bNEE8eb4xBsOmQzIDd+JgvYhcdCLMFgnvT8TVA=;
        b=EcPt+0HOELBkot9FmZXpj8FZtEo76WncIP7/4ty92IxBdqjLJ/r4f4Q+BIagBWZsYE
         THC9momgsyZ8fztLKOHKD7iN8XTgEwiW9Ay+uQ35LczyY2URYkdwBuiaArDKQcTFrZYC
         TiNAIP5gjzHNf/0K1VQTFyAyVUoKPWGAifQlCosEkPI9lPqKF7cGgRpl8gQMNBkQ3SYX
         I/pXL6zafoLrQsF6QpS0EhWqArUh0XAfKaruE5NwezO2ucC4VFKWiO1uNRyYhlpodRoP
         4Zx0DY7Rf3CYO+eHzN2sxuao0WTCN8SS0jvANxxltriMQC6waWQsI9tys3fayDWGKJPz
         ratg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779804520; x=1780409320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdHU4bNEE8eb4xBsOmQzIDd+JgvYhcdCLMFgnvT8TVA=;
        b=D63WXyzwLLEpVzyBNduFw//bUgAOYQJBIFmtxtJkuerAUeI0qZ9Xbs66WOOr7LIKX8
         ixy9aJ5dcjVwZYAkpqCsxuxKQz01UvPFk56Uc8epf3LenCAobmQ3uJ+hy/CnABMKK1X/
         6JNvO1yNrHng9CjVrrXKxqgIgabyxGviIGYxjpQqDxr+1oNhMX9HUf10Rgw2GHgJZXHY
         /vpf1umO1fnqptWz6uj0kZpPVPxrcf0Wr2JDkAV+yT+TXl4GHmzyS/BIqEAz/kLvsNH+
         9PtF3KACsxV7DCMcEHxYCT+A3uPSGftoTi90WMymKhRtmTGtYAVnYmKVlUKJKazhEdIJ
         xKmg==
X-Forwarded-Encrypted: i=1; AFNElJ8e494lnWONqkEXJl/JzOQ3UZD1/MCgnvhP1FQLSTiyAWKfOr3maTZbgcZMxBvLS2kRCyBUiE/fkw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxuN/1knRIQKkz0Os/Q5x4hPEVZ1QN3YgZ1TWh8quKt86OtHD5B
	R2S0FoP8g1EDvE8aBNb4sGO1+TBFnTk9cXL8Uym51YRAv+txSzhB30n6OXc956vTGor+SR9pPFX
	JUv4wtuz/RNnkmhKcZmBoW0ZI5T5+wz3HERqk8sYjPaIhle97+XqN9X8NTA+uRA==
X-Gm-Gg: Acq92OHUJ2vCgH2f+zn+kc0TOhhKjc/6ILvKcYrlMOU/zDug8p5ugNxZuVAg05BRI8L
	YVslfUpRCA8r8Uojsr/cCcntQ3BZqNhoH3BgXWYuFlcMzBRQDYaWfjreEDmKVzvrAhO0RG6hWDA
	qmbjumZuOOtNTaS6xQxYEVSsfiSdyW9US2sLY9sd1zYxH/EZoCRggTC99QHsDX0nNnR2Nlo9Efw
	pI1OE3x6TghrDDpyOArZa7pAZQb/awnD3zz58rloQk4z0tgAK/lycPf0OggQ7Tj4OJKVn3A1PPM
	kf+4NJKRdORCZm6PcaWWBhycGmYNKDlTg61do2m8xEtbkAxGYiddclOgYiwi12vBlIrTRh2m0gy
	Gw9EAedTRyNYUz10y84jNFunYpNsAGWciZBN/tMZO8/v6n7lu
X-Received: by 2002:a05:6820:1612:b0:68a:116a:a5e5 with SMTP id 006d021491bc7-69d7ec85536mr10629570eaf.44.1779804519554;
        Tue, 26 May 2026 07:08:39 -0700 (PDT)
X-Received: by 2002:a05:6820:1612:b0:68a:116a:a5e5 with SMTP id 006d021491bc7-69d7ec85536mr10629521eaf.44.1779804519005;
        Tue, 26 May 2026 07:08:39 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:9e9:6f8d:9f1c:61e1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490424aa561sm156266605e9.5.2026.05.26.07.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 07:08:38 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org, daniel.lezcano@kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Guenter Roeck <linux@roeck-us.net>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Benson Leung <bleung@chromium.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: [PATCH v3 00/11] Support cooling device with ID in the OF
Date: Tue, 26 May 2026 16:08:01 +0200
Message-ID: <20260526140802.1059293-12-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7731; i=daniel.lezcano@oss.qualcomm.com; h=from:subject; bh=SW8Dm2ZVmkfgDXJS9AQQGS/QJqRyDAQCLvTud8id3Wg=; b=owEBbQGS/pANAwAIAagyI4oqT+hPAcsmYgBqFalCtU+EqpjPAVWrXzEKLYtIM/p1sQGpHenxZ OQ/LwzrlO2JATMEAAEIAB0WIQQafc3hhXPRY1XIeySoMiOKKk/oTwUCahWpQgAKCRCoMiOKKk/o T+0EB/9GLu1subli48erpNpVKcxpM8+o/ilBwm/83UXYjEHYNSTRO6GhItaOUowhq+2GaUHqtW4 NXkMLkW/HKzvqaF2PzXJU6S8Nc8s6/VgZD+A6PAG4eFCG0HjgCNb7i0Fm3ROw/rCuRj1A0SAQIE bDYVzy5ltAtRcvOJsMgj8RoDzIUhnV5555M73fEU29YnTTyX9Uo3s0sLDcxH0oXO43bdMCvXoY7 LfwQqih1UG+0vSpIPn2B9o/iXSCMdvvXSN2IbFfTyIs/mHreKxyFFfV9SJ8uizW0MbJgxs4AwEo +R65rIBJiGNzuScLmmf/eZPKFIckeJ1STigVokvAHFMH37St
X-Developer-Key: i=daniel.lezcano@oss.qualcomm.com; a=openpgp; fpr=24D626F253BE9E87E6CE5BF48FF4B8D271675527
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: NNmiWvb90xLfAQQAYLNqxyiATn265j9B
X-Authority-Analysis: v=2.4 cv=ML5QXsZl c=1 sm=1 tr=0 ts=6a15a968 cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=maJSIIvfzRj4fPHbN6IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=-UhsvdU3ccFDOXFxFb4l:22
X-Proofpoint-ORIG-GUID: NNmiWvb90xLfAQQAYLNqxyiATn265j9B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEyMSBTYWx0ZWRfX7ssPCHwutWI/
 M+iJE/ABLi/92clmDOX4juRJPSu+70cta6A3cOoXVqWctGyhUsXG+EYdKrXhUcMBLGcGIj+Z58E
 0HUGBD56PnupZTd+APBfzuFF+c8gjp6KKIt92pKvpB1xjGbx5FUflJoDGdogKbk28LF5PHJCtQH
 GFWNmQtwxluhS9OaoOZVybvKRE1rWEYsM4XiKESAxOsaukniEiQjxyk/BelHILLYh+jvwq6sCyx
 zM2U7yp1YHqGFZ2cVHyoQHES6eBY/xeOIdzIvfpcWMwCS5MBQ+YyJ7/xeRZuiHrHgoNd6qMiwqq
 WeQvGxYKGTDg7d6LTkFWrybUdYWmQvrxyq/6Y/aFkuLos23A8O54HglvEFtNghIKYspBHRMpdSE
 vpg5SQ6W0yA2qS9FdzRWvsa0RPHJ0/lykwzGUEU9oxA50bwxfzpVzI+ZeZkmxEHz0qHUrfQHP7v
 BXZnyttBB/dew/mlDDA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260121

Ultra short description. DT Cooling device description:
      Old: <&mycdev min max>
      New: <&mycdev min max> OR/AND <&mycdev id min max>

Based on
      https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/log/?h=thermal/linux-next

A cooling device can be a single cooling device or a cooling device
controller with multiple cooling devices attached to it.

The thermal framework builds a connection between a cooling device and
a thermal zone when there is a trip point to be mitigated by the
cooling device. In the Linux kernel thermal semantic, the action of
connecting the cooling device and the thermal zone is called a
binding.

The description of the aforementioned connection depends on the
firmware definition and in our case it is through the device tree. The
cooling map describes this connection.

How is it done ?

For a single cooling device, the DT describes:

 * A cooling device:

	mycooling_device {
		...
	};

 * A cooling map in a thermal zone

	mythermal_zone {
	...
      		cooling-maps {
			map0 {
				...
				cooling-device = <&mycooling_device min max>;
				...
		   	};
      		}
      	...
   	};

For a cooling device controller with multiple cooling devices
attached, the DT describes:

 * A cooling device controller:

	mycooling_device_ctrl {
		mycooling_device1 {
			...
		};

		mycooling_device2 {
			...
		};

		...

		mycooling_deviceN {
			...
		};
   };

 * A cooling map in a thermal zone

	mythermal_zone {
	...
      		cooling-maps {
			map0 {
				...
				cooling-device = <&mycooling_device1 min max>;
				...
		   	};
      		}
      	...
   	};

When the cooling device "mycooling_device" is registered, then the
binding function will browse all the cooling maps and matches the node
device pointer to do the association (the pĥandle in the cooling map
vs the cooling device node).

That is how the connection between the cooling device and the thermal
zone is done.

DT maintainers consider the above description with child nodes is
incorrect if a child node doesn't have its own bindings as explained
in the documentation [1].

Gaurav Kohli posted a series to support the QMI TMD (Qualcomm
Messaging Interface based Thermal Mitigation Devices) [2]. This device
is a dedicated, centralized cooling device controller managing a set
of cooling devices.

Because of the above restrictions with child nodes there is no DT
bindings allowing to do the connection between the cooling device
inside the cooling device controller and a thermal zone.

A QMI TMD is not a standalone cooling device neither a multiple
cooling devices with their own DT description.

For this reason, the proposed changes with child nodes has been
rejected [3].

As a solution, it has been proposed to fold all these child nodes into
an array and add an id in the cooling maps to identify the cooling
device entry in the controller node [4].

Given the thermal zone has the same mechanism [5], that is a phandle
to a sensor node and an sensor specifier. The proposed approach makes
sense as it is consistent with the thermal zone description.

This series provides a cleanup around the usage of the OF code which
is interleaved with non-OF code. The OF and the non-OF code are
separated and remain self-encapsulated.

Then the function to register a cooling device is renamed to reflect
the legacy usage and a new function is introduced with the id
parameter.

Finally, the DT bindings is updated with the new format and the
thermal OF is changed to handle the new DT bindings.

Given the trivial changes impacting the files outside of the thermal
framework, this series is designed to have all changes going through
the thermal tree.

Thanks!

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/writing-bindings.rst
[2] https://lore.kernel.org/all/20260127155722.2797783-1-gaurav.kohli@oss.qualcomm.com/
[3] https://lore.kernel.org/all/546faeda-d896-403c-a449-5c9b0cd7159e@kernel.org/
[4] https://lore.kernel.org/all/74f59ef0-ead7-483f-a80e-a3da2f6ebcdb@oss.qualcomm.com/
[5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/thermal/thermal-zones.yaml#n99

---
Changelog:
 - V4
   - Reworked splitted functions to register a cooling device and
     merged separately
 - V3
   - Reordered and reworked the patches to be git bisect safe
   - Reworked devm usage by using a more adequate function doing the
     same as the group of calls to devm*
   - Pass an init callback instead of moving
     thermal_cooling_device_init_complete() out of the function and
     calling it in different places
   - Sent separetely changes to the tegra soctherm driver
 - V2
   - Added stubs for OF functions in order to prevent to break the git
     bisectability compilation
   - Added missing call to thermal_cooling_device_init_complete() in
     devm_thermal_of_cooling_device_register()
   - Fixed assymetry in devm_ calls for the tegra/soctherm() driver
   - Fixed kernel documentation for API changes
   - Added missing static inline for a API stub
   - Hardened the test with two or three arguments in the cooling spec
   - Narrowed const: 2 strict in pwm-fan
---

Daniel Lezcano (9):
  thermal/core: Introduce non-OF thermal_cooling_device_register()
  thermal/core: Add devm_thermal_cooling_device_register()
  hwmon: Use non-OF thermal cooling device registration API
  thermal/core: Make cooling device OF node conditional on
    CONFIG_THERMAL_OF
  thermal/of: Move cooling device OF helpers out of thermal core
  thermal/of: Rename the devm_thermal_of_cooling_device_register()
    function
  thermal/of: Add cooling device ID support
  thermal/of: Pass cdev_id and introduce devm registration helper
  thermal/of: Support cooling device ID in cooling-spec

Gaurav Kohli (1):
  dt-bindings: thermal: cooling-devices: Update support for 3 cells
    cooling device

 .../devicetree/bindings/hwmon/pwm-fan.yaml    |   3 +-
 .../thermal/thermal-cooling-devices.yaml      |   8 +-
 .../bindings/thermal/thermal-zones.yaml       |   3 +-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c         |   5 +-
 drivers/hwmon/amc6821.c                       |   2 +-
 drivers/hwmon/aspeed-pwm-tacho.c              |   5 +-
 drivers/hwmon/cros_ec_hwmon.c                 |   4 +-
 drivers/hwmon/dell-smm-hwmon.c                |   4 +-
 drivers/hwmon/emc2305.c                       |   6 +-
 drivers/hwmon/gpio-fan.c                      |   6 +-
 drivers/hwmon/max6650.c                       |   6 +-
 drivers/hwmon/mlxreg-fan.c                    |   4 +-
 drivers/hwmon/npcm750-pwm-fan.c               |   6 +-
 drivers/hwmon/pwm-fan.c                       |   5 +-
 drivers/hwmon/qnap-mcu-hwmon.c                |   6 +-
 drivers/hwmon/tc654.c                         |   5 +-
 drivers/memory/tegra/tegra210-emc-core.c      |   4 +-
 drivers/soc/qcom/qcom_aoss.c                  |   2 +-
 drivers/thermal/cpufreq_cooling.c             |   2 +-
 drivers/thermal/cpuidle_cooling.c             |   2 +-
 drivers/thermal/devfreq_cooling.c             |   2 +-
 drivers/thermal/khadas_mcu_fan.c              |   7 +-
 drivers/thermal/tegra/soctherm.c              |   6 +-
 drivers/thermal/thermal_core.c                |  85 ++--------
 drivers/thermal/thermal_core.h                |   5 +
 drivers/thermal/thermal_of.c                  | 148 +++++++++++++++++-
 include/linux/thermal.h                       |  69 +++++---
 27 files changed, 273 insertions(+), 137 deletions(-)

-- 
2.43.0

