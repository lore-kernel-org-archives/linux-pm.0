Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4E42D0C62
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 18:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776622953; cv=none; b=LJO6dVACDxm3ro2V7sj0InV64fCaLygslbgR+kYfITLLdyhvLgYRPEOMi5aRSQ8TDgEknE4TbuD4mOgVX5iL8ypQKfd7FuwZQCf7HxUP6NYlN6aEFhrmfI1Uf6dyBZUwr5Ea6DTHyysiysIKP4De2ngjYeZ3JthcEwlS0WNKRYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776622953; c=relaxed/simple;
	bh=6y8me+lbEya3M63TkpXJZxxb0cmqOstkAs3tXw0mOAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LIRP/VJGsUaaxy2LuBote9q3gFfpR250WHOLO6KQAUMCYMVzU0CZ+pAUJiWIY5ifXl5elrZPssmYmVHKEfLfipSySFEHmvLiINCpJc3U1akr8caq/kbEeHVPGH8vcAs2byj6y5phEOrdDrWYi3wYaIcBpTmaOEOsFUBBPR0nmNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nPk1ZXnz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ibB9K51O; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nPk1ZXnz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ibB9K51O"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63JFMrdB1410553
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 18:22:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=/JWZtoVPlmm+MrghkSNQxH
	HxHST/CjnSiSoBT2omWu8=; b=nPk1ZXnzhKPdR/SAK301eVeaSjImVG8rgtab5j
	fXkw32p+kUkhqgHikR7D5ihBwialbPncS9HSH800Mx8zHA/1UjzLf4n1co7wyA06
	wK5kz5h01AzdYwcj7Bqe3V7Tnj2NvSGW1S1ofv8pyLCxOFNdkqDYCXkMTKlMX9oH
	lTF46EweqEWtFQ6VdqQRw6ewNdIE3b57acSQeRba4PJq3IDNVTUQWDQTBT8VMnQY
	oyYy/7JxR+r1/0zBfeHOUpY7v2vFinT37piV0FtA5WlKYq3QRYsVDv3wKXg+g1L+
	xwipv1VHLPbgrpFiu2i26rd/cQbU1WOYr5RUYW4js8M+LLtg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm21ujypt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 18:22:30 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50d84b5f73bso87413211cf.0
        for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 11:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776622950; x=1777227750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/JWZtoVPlmm+MrghkSNQxHHxHST/CjnSiSoBT2omWu8=;
        b=ibB9K51ORaHWit5Tpzhqxke9AMd39iCnkXNLzaMM4Kaf03+cdphCQTx5YyB/WMGWsU
         H5ah7U6+rKgxGZmfaOX9heyowhDTCmOddBYxhT0bUJVaNxp54jJnj87oFny8WIX4Gzay
         4/ex+MhQZiCt/Ok6UP21hglLaKN2fFlPAHVmkENLPEDgTePeuEuHU3Gpa5XvEbf4f1tP
         e5ece/WWWhxoGn8apwyeq7L3kshMEYhKCGfURWLihSF3c/pBJKnU8PguQ6ddFZhXKJaV
         aRTqV5ZHUaM0tnU/MSa8SoixLrD4F74CiAlgMFYgGyKQG9+GRDbaQXeiiRX6pyOSaB+I
         2gBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776622950; x=1777227750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JWZtoVPlmm+MrghkSNQxHHxHST/CjnSiSoBT2omWu8=;
        b=IszLVRLizpPfanFgtOrfgpWt/jhTBJLZzzQaqbO22SczVP8LcEHVJv6Jqv88tLMiU9
         yQeVrkamBoZIPYP8wQeBuLOIfDee1KxfEGWbIAh1GT65WOKEkSmiNiwR7QUrVdkyTb3w
         0ierzl21VMq+G14pto8GNfl0Fsbi2VsU8BnP9wODOVB8tnLFS/4MZZtEG1SfjERXVtm2
         V2HLYBKOmRPU7me511nctpYlBwNjxIXH5qnHnBOLMoNRmK8DFEAXOMjX1bZZbDhV0tUQ
         dGNqu3q0iXupF+9Ye1MFcYysZ6S7uL73ybzFQWePqNoAxbvdjeH4x20AXRn1HsexI3Y2
         sHCw==
X-Forwarded-Encrypted: i=1; AFNElJ8hLMUw22BXqgQdxmyrC0j09OlalSMAGZow/pjHn8OB5DmcrRDuSQ3pvQEXJ1Jvi3SYDLSUVd5QEA==@vger.kernel.org
X-Gm-Message-State: AOJu0YySPL+H/hCNlXaBoQU/TVWXWSd7rAe31qa37XUwGul+yRRRbPHK
	/DwLBfz+W2UsDWhLho2trss8NnnSNXK/bw+FYphtbXGdQc3e5t2NKpnJshp2CANs8iyNvsaIR32
	sIiuzKlkp4H4YUznVWqV/uT6qmSpl8BWwOyv0HQNC2YImIOpHQpRKxu0KxayrOQ==
X-Gm-Gg: AeBDiesd837+c+XFt85B2ICDDM0D7+C0ESOmjhAgkCabSryGE4KbqxtqIbaLXdWLXne
	/zlhN5GsMG3Qeyjt1MBl47klK/mM5alzm9rbgfsAeNvdnBM9IjipuPEIGPAwiTfSEmLataLpNHC
	Y0lLopHoUlKZk7GL8bZNffryvXuhdaj1hq8EyekaUVrMTNzHEermcJFAyMePqO3e4671WL7rZLF
	xrqKdDxMqgQyQbVHPXFLZXQ8ZoOJ3n0eKzfchKvZhCBMwPKSUUdbfTvcH6ZkrCXgf61sabHEpYf
	zTSxktcHfzKLGqUaHZ0wax8pjD0rN37hqY7Lhe9ONCXybH2LRiVm3EbKteSgpCSyYulU7Ew3VjO
	ETRehMj00tzEmuuU2y2fX739tJr7yGeNy+bLOfJ9TAeA9pPgGZT/+3V7Szk9K
X-Received: by 2002:a05:622a:14d4:b0:50d:b33d:bc6b with SMTP id d75a77b69052e-50e36b44316mr167991251cf.20.1776622950287;
        Sun, 19 Apr 2026 11:22:30 -0700 (PDT)
X-Received: by 2002:a05:622a:14d4:b0:50d:b33d:bc6b with SMTP id d75a77b69052e-50e36b44316mr167990611cf.20.1776622949716;
        Sun, 19 Apr 2026 11:22:29 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e59f97sm25723070f8f.37.2026.04.19.11.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 11:22:29 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org
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
Subject: [PATCH v1 00/14] Support cooling device with ID in the OF
Date: Sun, 19 Apr 2026 20:21:44 +0200
Message-ID: <20260419182203.4083985-1-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE5MDE5NyBTYWx0ZWRfXzkDrp3axjvOM
 gkX0Dgfsmj3++7fFMzEkjSzgirbuxnuJ/o4aB+PoY8rBaDSr0DVjylSeX41yUPkx6JVc2jJlPaj
 M1k6l+zFRb/DpOSlgsuNsIb7WcmNpwwpQomWgUhKRTlePqJxIRoQhViw9rMyoBiGYBrgI9q3mE+
 MppodzA/Jm0lfGcBEqwCc7gu09bGaJP5IaLqpVsaITUvp2eDs+ESAYAzIKYsYerc2keBplp7hCn
 Uc8ATpmJNo4Zsm6Ovtz7W5QJPst88ID1v4X3j6dJTG2l8FUtvyEIN0w0It+JKMANh2quhrOnm0Y
 6DGWvLq8uOZe4nny3Y6DzvHhvwu8TeoRmllJQ0Ep/QI0+xoNRjad0fRBLnaWUK+1Q+1EnNrPE8k
 1SVJIBXSclKg84fizphkcI3C4raZU2PteNo2lLS4BBfLPC4UxhtS71Kii9I3N/4642u9CC77Ilg
 bOKqUdDaxoLFpC/Sxnw==
X-Proofpoint-GUID: UgIOCRPPYq170uulVroon4FH7x3zdajZ
X-Proofpoint-ORIG-GUID: UgIOCRPPYq170uulVroon4FH7x3zdajZ
X-Authority-Analysis: v=2.4 cv=WK1PmHsR c=1 sm=1 tr=0 ts=69e51d66 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=dQoLWzlZYRxCxHJU1UwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-19_05,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604190197

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

Daniel Lezcano (13):
  thermal/of: Move OF code where it belongs to
  thermal/driver/tegra/soctherm: Use devm_ variant when registering a
    cooling device
  thermal/core: Make thermal_cooling_device_init_complete() non static
  thermal/of: Move the node pointer assignation in the OF code file
  thermal/core: Remove node pointer parameter parameter when registering
    a tz
  thermal/core: Register cooling device non-OF drivers
  hwmon:: Use non-OF thermal cooling device register function
  thermal/core: Move OF functions def in the CONFIG_OF section in
    thermal.h
  thermal/core: Put of_node field cooling device structure under Kconfig
    option
  thermal/of: Rename the devm_thermal_of_cooling_device_register()
    function
  thermal/of: Introduce cooling device of_index
  thermal/of: Pass the of_index and add a function to register with an
    index
  thermal/of: Process cooling device index in cooling-spec

Gaurav Kohli (1):
  dt-bindings: thermal: cooling-devices: Update support for 3 cells
    cooling device

 .../thermal/thermal-cooling-devices.yaml      |   8 +-
 .../bindings/thermal/thermal-zones.yaml       |   3 +-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c         |   2 +-
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
 drivers/thermal/thermal_core.c                |  60 ++------
 drivers/thermal/thermal_core.h                |   6 +
 drivers/thermal/thermal_of.c                  | 139 +++++++++++++++++-
 include/linux/thermal.h                       |  71 ++++++---
 26 files changed, 267 insertions(+), 106 deletions(-)

-- 
2.43.0

