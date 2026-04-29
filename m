Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7563B9DAE
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 16:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777479288; cv=none; b=nT1GUFF5zhH2Qx6vKgTyu3ncxPcKudHwWUbbVL8I9ltG2P7m4RpV09ZjCrCJY+vg4oBMobgCsP2OZwU5CN60jZGIjFGVmCKPrsXtZfH0xJwSYJoEtF5aP0g1WiiUVzSLOYUeyR+iu8axCCf9b3AP0AA+GYFnn6+UM3K+EVzQlu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777479288; c=relaxed/simple;
	bh=nMSPPfwRBbo8PMwanHsXp5mfP6ohvGo4qxHHhAAmESU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kZ0Kkqx6w0X8m0T9HJWaoDYFpDclgZpN1gf4XBOsNjSjn12wfu6EXqba3tOqFuOWbNU1BGeXJk8+GOZ6HxzaLXLYToL2I6f6XzYLzF/sd7BpQQdftIuR7lbGTk1cCkmsYjilHeZpuWGTfApkvXMGuRs/lLGSGAcxk+Uzb605R4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ma85PxT5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Bhea/zy0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ma85PxT5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bhea/zy0"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TCMSSp2486211
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 16:14:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=5XIEIU3Lp20hM7lvbKpbtA
	gDJ68FndI6Gkohfoyi7KU=; b=ma85PxT5+wIWWCSm++8OI1ptpmnyx9/MBNwlSl
	xvad51F0XZDClGUITaSCR1wFAv3fhTohdVa2hY3+3d1n4rUcYSe38uC2q7Vm0AFm
	U34EQi5cS9kvRfcr6fOPaTxfH06vnrn/NxrYPzohLM99FyNScXliA436XDhXGH/d
	UyvABOeNcZUWiY+agyM7lY0eRJXIFNtTHvoiLULnQkXs3zcnZeO9Gko9iL68NpoT
	OsZ22UWAaSpS1BDnbjWC8/TLp5Drg+7JNc4hOKAAwC2NzC14jQb9dX0bSVxMod8O
	AW0eTkE9aHnNxNs3fjzWuGylIo2u/7J4wTGo3/rOe/lkFllg==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duhx90vyf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 16:14:40 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-56f67ce97a7so8789988e0c.3
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 09:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777479279; x=1778084079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5XIEIU3Lp20hM7lvbKpbtAgDJ68FndI6Gkohfoyi7KU=;
        b=Bhea/zy0HrLOm/uABGrXeZr2t4o674jRUHtNZe/bDHzspWf8OlDoRK7xNQG+f8ixpB
         WO2JzgwTWJqHWJI+YOpybhsr4dZx9xaZEckAV4TJfiGKLeLtnfvodDkBSYFufC20EsyM
         wasC2Tb6eG27PdyU+6YEY9MvBR8bCI4Vu36XtBjNzcM54HMJr0LtMS3/jhcw4tF/yOdw
         TX0i3++wVuqUpjx7Fw7DZAvELqwkbbqwRLm5n5EiNgC8qNFcCgh9lMudGwMhZQFnIBGW
         Ox+pjfWGLNQG5EhRqhcX9cxkrwH0w7NSZzXnCcpvyIpKXk9dPG9MGOOirOytCYzcpmhK
         +C9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777479279; x=1778084079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XIEIU3Lp20hM7lvbKpbtAgDJ68FndI6Gkohfoyi7KU=;
        b=F7END5PhauaMIDSUlNKQVncwgn1BHdiu/+1/JzqtM0emmBp/GvgyZtl5sKLtz7BWqo
         9DtgNK+XgvqKWXFg9gLdWvDYutcbsdZjEzXXErnw+H+k9xWidzf9Yt9LGa/dRocjsNia
         WsVOx4zpyAFLP3suTh1pFFipMA3Zx4uGyGlMlcRppirtoWThFBB/DHM8hyiHuht0r5MI
         QcB3EOEVbyIQyRVkG0H2jyFVpJtGJGjqT0Q1yG+8iBvNUdX6HMX2spe8h7k2LWylr85o
         XIyyTzJeyZgko3eU7M6YvwIDjl1I7kgEq37F7rUoP4CGE5Ry9LXGtRDpTvt/gIGCqpmP
         rRTw==
X-Forwarded-Encrypted: i=1; AFNElJ8d3Kmukab79qgBg3ZtfBbU5tgSGgaU1SnRpEhJywEA1aC9LqcNnaUU5HPY3iOugAKEP7Jo72a5xA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxC8A3wNWLQ/Avh94OLhkGw5O7roN+H6iOh70zebo4Uzl/+aS0K
	DjW7yE19XUJvOEIYqD3pzgctEi38eChe7b4+Lla1q1Na+FULRRwesizW+BL0nJf9oFJlFqb+J4E
	L3N3zc0vpJGaVrsQW2qoUQ77PwY13iQSrrrr8WmCj9mfpk7Up2cXufi9hPQZnIw==
X-Gm-Gg: AeBDiesJigBJ6P2HmyTvemKhqCK8aRolCVigcIkyBgf+R78S0GP2oK5YOgS2uyYSftv
	sQCItEF56rWiOnTsetYWDXOe8euk5aZ1FWjdYmSavdolSh7tOQrQyGoXvxl7gdQ0Edkq4I0Y6i9
	7pVOQLU2OPe8UENkD1piHug/419TBKh2V0Ud8dX5VS0XSPP1c/GavHKm5ANSZAZ9Y2cxXqSQa4G
	X+dHcgjgJjnAgFgd6qD0SwugdY29kDlueG2BuSoWP2+FoLODsW1qkYchpODEvbx1heEW/91nUjD
	NzUHu3JlVy3CQP5gKboT6shK7zVgUHoxcMF/meDXi+JkMYWXrYklljk9mtDNcKzfA7ParR2Ikol
	NLZXIaSSsLBPiJIKbV75iMWv3lvA3HoYVM0OUZbkCmPPk8A4nij8xgLjuAGap
X-Received: by 2002:a05:6122:3d06:b0:56a:f979:a9d1 with SMTP id 71dfb90a1353d-573b34d89b4mr2330294e0c.1.1777479279075;
        Wed, 29 Apr 2026 09:14:39 -0700 (PDT)
X-Received: by 2002:a05:6122:3d06:b0:56a:f979:a9d1 with SMTP id 71dfb90a1353d-573b34d89b4mr2330226e0c.1.1777479278473;
        Wed, 29 Apr 2026 09:14:38 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81ed659dsm2438525e9.2.2026.04.29.09.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 09:14:37 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org, daniel.lezcano@kernel.org
Cc: gaurav.kohli@oss.qualcomm.com, Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
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
Date: Wed, 29 Apr 2026 18:14:13 +0200
Message-ID: <20260429161430.3802970-1-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE2MiBTYWx0ZWRfX48gJEqScH3Cc
 bnDo1rAEztNUi2mPtMWPUds31EbdLcW6af5FTgOh8Op45vJSvpiAs8WGVJJ13gF82ydvsIH3Z1/
 WdVo0nXMdLFk/AXuTZoUc31v87h9heSqqSkaNPz0vWjn5xyniNcj2Xlybs3er0GU1fO0UljwhYt
 WwTBonrD2t4YSnVPxOa5kACxL0d9V7eSChvOTZQROuS9qDZQ85M3H04aFSlvk54Xx6cDLWBlCP6
 wAMtQ3xZLSZHsI7kczAfYJHizh1ygafXXKoyHE8wCIBi19Vx66Pp0Ls7fZ1xiR40YkddvmWmrOq
 UKV5dzVTG7OUq1N9EzhYUeLqYSTU2jZ8RCay2N3oIIqGYUTkCFIdCaiFxEILoEiYwVSZylvQrN8
 TW7oA/950F9pCY9uPXQom3NhUf5q8xLEsmaCtSiFberQirJj73E0DW7edkafW4US3lx15ao/YRA
 axe1I7iTn/Ym8YGuQHA==
X-Proofpoint-ORIG-GUID: 00R6hY5hxcY1ve57cPHAJjyGZDqawInn
X-Authority-Analysis: v=2.4 cv=O5oJeh9W c=1 sm=1 tr=0 ts=69f22e70 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=maJSIIvfzRj4fPHbN6IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-GUID: 00R6hY5hxcY1ve57cPHAJjyGZDqawInn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 phishscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290162

Ultra short description. Dt Cooling device description:
      Old: <&mycdev min max>
      New: <&mycdev min max> OR/AND <&mycdev id min max>

Depends on series:
	https://lore.kernel.org/all/20260424160019.41710-1-daniel.lezcano@oss.qualcomm.com/

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


Daniel Lezcano (10):
  thermal/core: Use devm_add_action_or_reset() when registering a
    cooling device
  Add a non-OF registering funciton
  thermal/of: Move the node pointer assignation in the OF code file
  hwmon:: Use non-OF thermal cooling device register function
  thermal/core: Put of_node field cooling device structure under Kconfig
    option
  thermal/of: Move OF code where it belongs to
  thermal/of: Rename the devm_thermal_of_cooling_device_register()
    function
  thermal/of: Introduce cooling device of_index
  thermal/of: Pass the of_index and add a function to register with an
    index
  thermal/of: Process cooling device index in cooling-spec

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
 drivers/thermal/thermal_core.c                | 106 ++++--------
 drivers/thermal/thermal_core.h                |   6 +
 drivers/thermal/thermal_of.c                  | 157 +++++++++++++++++-
 include/linux/thermal.h                       |  71 ++++++--
 27 files changed, 303 insertions(+), 140 deletions(-)

-- 
2.43.0

