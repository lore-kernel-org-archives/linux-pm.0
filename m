Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246802F8EAD
	for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2026 15:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781798204; cv=none; b=GSSJCfNGmvOXINPsd7aZbGBtwuXGzgFiG0EJr/8pnpCKSQjhnjbsBiLMs0INStqzXEsIZ7AQhAGaqWqpUedDbm+pUaSBPM4RJvqidVCMGq4gjzOUYN7CwBVNbky7tCtkfZkWw4yXlm60N7/gOqpumhLkoBSdL7ZFlV/p2PVuaes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781798204; c=relaxed/simple;
	bh=mjHNFjrSpakQHraKQgU4+H6bL9gQu4hB14FwBpqmgUw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=G9LppaoxdtU3/rlF9e1FUQtEkjLau4uiM8m449lAXKqtZJjcpi7xWFAzCoSV4ROSyKGPYAjs/yOCJf+smdGLTcjm/zz9isRYGw7oQ86qQcLAtcacoDzT1z+Ad3ulxiC6IDEkGdNmRkju3iZa3i/s4YhjhbPOtpixmmGMSNR36Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j+4Ad/TB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bWtzS7iJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j+4Ad/TB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bWtzS7iJ"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IFG1Ws1914324
	for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2026 15:56:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=VcLPpasNEX3QJRIY2M0aIP
	dRTeqR6PucNCShGuq0DT4=; b=j+4Ad/TBxE32rfAqTZbpyHo5FViecn7R35vhpr
	74BEHSF2/qdDmvm+fklFofRMit2uIn8MmjvJl8YgZ6xNgVsThjmZ3BotCkH1eI9/
	louLIg+7SUtah9lg6M0uCp8iZqtFJmlAfKBc7eKX9IpNO1aniohq8rz/FLdjaToH
	q7kBJcoz7BpzIU/SlKHazaORgfwxy/S8vwaDPEh9tr8ApsE73xuAhFNOP+A79pYs
	aeeaKmUMq662gL1I5bm5ogAQ5V2KGJy43PV6w8gdvypO6/lBeIuaHAp4E7ywCsxo
	YnoF/lH5og/tG4XxnDctQi2cLkFhXY389TcmW3IlWx1nC4uw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev1wc3xmu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2026 15:56:41 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-139553dd8acso4460506c88.0
        for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2026 08:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781798201; x=1782403001; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VcLPpasNEX3QJRIY2M0aIPdRTeqR6PucNCShGuq0DT4=;
        b=bWtzS7iJBPg6n5tq0TOSnESMpc3T0W2ufYl5B9KuujEnNfbYaQli4ptSgZ0rYBLajr
         BUSiUDWqiF1EII64iNl3cFZKMKeCyvRVfXVZksddCGE+zUA1hy0P9NDWyM7zGie+YIKc
         /bsk1b98YUwbD4uqYOSPb/ldAYnu7eMU2uEuaxXRL4o+NbDaNOqUJ9pTSy1vPG9TbxDo
         6/d6muaqZa4gmCJ8mEGP4RX/ZJp88hdUb0FMFhhWozKmkA74Cs4lrn13tlNKgZOVnk73
         oGgOLJrmMr4S6VMRvb4cuNHhdnm13FlXFDly+i53Slyc7AkAQS65Nre8rRY1TqxbKkpW
         ahzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781798201; x=1782403001;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VcLPpasNEX3QJRIY2M0aIPdRTeqR6PucNCShGuq0DT4=;
        b=UFdKiz6Lm274+4juA7KOdgqL2vBk+h/wiG0C1F2nCOqdxxe02xthcGD/yyew2PKW7P
         WDv2UTXMpxcBMSNos2T0k1otglgC8+V8fq44tbwZiqAZBUV2bCaWCfY0fE9G6gh4tlYI
         SIyM8uIDhKXDXZ0+zGNPJ867ktau8IFnxeQNw4rKxMwQcBK81/zWp5m1nZd/szfY8g59
         ODg8iicAzOYTyZC7uWXsJUY/NV3ycPC4QEoITPfxsyvNGMAqbJm5cNT1UmtLkSHhS5Jr
         NZ2LNFBIGpLaQqJu0cXbVcTANHNtAMyhXmFK8pSqCv9nZdtQvGXU4c2bs8k1N4PpGdXR
         8V/A==
X-Forwarded-Encrypted: i=1; AFNElJ/czvnTuVd9axJGagRGqFEQ0WgNx7VfjYdplYu+vXg5strvtCBKXVm7FY/tqeGtCrWnC7TcdsCucQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Uz7iG5HsHG4Kf0nxBZnNWCaT4+d1wMREeLJzoZugmIx8Yj05
	/tjd+yGHfC+r9Cof0J7fMe5mn/+Fa6Uqf9v5PC4U1mOztlh/FelgIZ4lu/IAei1Eqs9ai7UNYiJ
	Av4ntrDnapFoa3liAdjvpUjwhIY1LZybNxpqJ6HOxwR9mALHSzFoVsupiCOVY9g==
X-Gm-Gg: AfdE7clErrPuBgAkc5qE3fGD+zn3RPp5z0BdrV5mBka9lrjnY+0RVK49Lj4D/8fKbr/
	nXF/PNfT3RK9wo/ubbjb63eiGEWJDhpaybqV9UZtJa4jdN8OxB3hOVlWtPKrJmR+IUUahl11r3y
	XoxojIM4pRxkvWdddADIopLhT7ZHP4d7FWwOWSpy2mor/J0gF70kwY5d+xAVVfTrzm323LztP6y
	IWh8Ag3UTAv2rRwPJ5DSC/9VWmw/wIl/oY97npBMnBClRyFoIx3+CokBaYw2BRy3ZcKsRZflRYH
	q0VsTKfjqBQIU1htXWgY70jn/Vkg+CrZ4WsjW7WsGoEFG4IjDWcC3qcRtMNQBNoFEy7p+CVOXYU
	mDdS3a7TL2uQuNAlNoZ5za6vH6w1yuILQJ0kwIwa+Iskjmx4VAo6U
X-Received: by 2002:a05:7022:624:b0:137:eb21:eafb with SMTP id a92af1059eb24-139a210d950mr184916c88.13.1781798200900;
        Thu, 18 Jun 2026 08:56:40 -0700 (PDT)
X-Received: by 2002:a05:7022:624:b0:137:eb21:eafb with SMTP id a92af1059eb24-139a210d950mr184876c88.13.1781798200388;
        Thu, 18 Jun 2026 08:56:40 -0700 (PDT)
Received: from [169.254.0.13] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b9110d3sm19671267c88.5.2026.06.18.08.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 08:56:39 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Subject: [PATCH v2 0/2] firmware: arm_scmi: Ensure automatic module loading
Date: Thu, 18 Jun 2026 15:56:33 +0000
Message-Id: <20260618-scmi-modalias-v2-0-8c7547c1be21@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADEVNGoC/3WNyw6CMBREf4V0bUl7hca48j8Mi76QayjFXiAaw
 r9bcO1mkpPMnFkZ+YSe2LVYWfILEsYhA5wKZjs9PDxHl5mBACWUVJxsQB6i0z1q4qI9QwXSuKo
 Gljdj8i2+D9+9+THN5unttEv2Roc0xfQ5Dhe59/65F8kFVwrMxbkatIFbJCpfs+5tDKHMwZpt2
 741G+bgwwAAAA==
X-Change-ID: 20260616-scmi-modalias-0f32421bd452
To: Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc: arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Hans de Goede <johannes.goede@oss.qualcomm.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Guenter Roeck <linux@roeck-us.net>,
        Jyoti Bhayana <jbhayana@google.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulfh@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        imx@lists.linux.dev, linux-hwmon@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-rtc@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781798198; l=3732;
 i=bjorn.andersson@oss.qualcomm.com; s=20230915; h=from:subject:message-id;
 bh=mjHNFjrSpakQHraKQgU4+H6bL9gQu4hB14FwBpqmgUw=;
 b=hBg6Nk9j8qta0n05zkLply061xcL+eKoogc7g6U/ddVe3HybQC8J6n/rGWlCHlG6Rs3u3pXA1
 tTC1mEfs4N3BHALIzXBsVdWzGKEoLUmiZW+sPGVEdal1Zj/Blud0IQn
X-Developer-Key: i=bjorn.andersson@oss.qualcomm.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-Authority-Analysis: v=2.4 cv=TMt1jVla c=1 sm=1 tr=0 ts=6a341539 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=IpJZQVW2AAAA:8 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=8AirrxEcAAAA:8
 a=pGLkceISAAAA:8 a=_jlGtV7tAAAA:8 a=1XWaLZrsAAAA:8 a=gAnH3GRIAAAA:8
 a=P-IC7800AAAA:8 a=JfrnYn6hAAAA:8 a=Bhy_3RDnOwLV862tVBkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22 a=FO4_E8m0qiDe52t0p3_H:22
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=IawgGOuG5U0WyFbmm1f5:22 a=cvBusfyB2V15izCimMoJ:22
 a=ST-jHhOKWsTCqRlWije3:22 a=nlm17XC03S6CtCLSeiRr:22 a=d3PnA9EDa4IxuAV0gXij:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: x0XiDWDqSU-0rS0-Sf1KA0-lqAHEsLGD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE0NyBTYWx0ZWRfX5WpG+HZLT3ul
 kiOAWmloClpNqXp5L/Be+oqbVNQCJFAl5oa0itbF7mev092z/7k5aJJHWSn4FMB1h8iy9auXF9R
 FjHKt4IYD6/WcOSIpzyD5hY1LxHPwOA=
X-Proofpoint-ORIG-GUID: x0XiDWDqSU-0rS0-Sf1KA0-lqAHEsLGD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE0NyBTYWx0ZWRfXwnEEJnHlrlNX
 S615fEVZVAAsQh7nO08SWZ+VEHr4e+7LJGIc9t/B4RUAccyKtUNiNgogeFdi8cLnUDJI9r45ytj
 07KLlREI3iOoMAuxoCKv2iPaabSWp6c0nqrudGN/t21mCqOSYAjEgpnQ5AiUIlwLm50FEmNHOSj
 aUSn+BtQulBxQcsh44/uFxfVKbFesmxNeoDUozFVkJnwjjPYl+Saoe0iUoKTzFWoR3AjUrJWLrJ
 kME7uPsbzD27z1ApFopUULJlWHLyfpZkY7jsNcqLZs59KE4hcMqjYmWtn/iN9vP97bSgnJr0dB0
 96JbwC6bhLFj94sGov4Y+6MZzhYGA7xgVGyHZUkrWdXitt4AKWdmHkpkVP0Yij8uZx+/QA3xi4g
 BJrnnhfwlJW8bQLyVv5ypi+WCnE/m7Xll2tLMtg/IsEjMd6e7IBF00LA3pba00nng4NCWLARJdD
 VTpoyrl+6rWs3+N+axA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1011 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180147

SCMI drivers such as the Arm SCMI CPUfreq driver are allowed to built as
modules, but they are then not automatically loaded. Rework the SCMI
device table alias support to make modpost consume the information from
MODULE_DEVICE_TABLE(scmi, ...) and allow drivers to be loaded based on
this information, if known. Also add a protocol-based alias to also
trigger driver loading when only the SCMI protocol id is known.

Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
---
Changes in v2:
- Use request_module_nowait()
- Drop #include <linux/mod_devicetable.h> from scmi_protocol.h
- Link to v1: https://patch.msgid.link/20260616-scmi-modalias-v1-0-662b8dd52ab2@oss.qualcomm.com

To: Sudeep Holla <sudeep.holla@kernel.org>
To: Cristian Marussi <cristian.marussi@arm.com>
To: Michael Turquette <mturquette@baylibre.com>
To: Nicolas Schier <nsc@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Brian Masney <bmasney@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Jyoti Bhayana <jbhayana@google.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Nuno Sá <nuno.sa@analog.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: arm-scmi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-clk@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: linux-hwmon@vger.kernel.org
Cc: linux-iio@vger.kernel.org
Cc: linux-input@vger.kernel.org
Cc: linux-rtc@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org

---
Bjorn Andersson (2):
      module: add SCMI device table alias support
      firmware: arm_scmi: request modules for discovered protocols

 drivers/clk/clk-scmi.c                         |  1 +
 drivers/cpufreq/scmi-cpufreq.c                 |  1 +
 drivers/firmware/arm_scmi/bus.c                | 20 ++++++++++----------
 drivers/firmware/arm_scmi/driver.c             |  3 +++
 drivers/firmware/arm_scmi/scmi_power_control.c |  1 +
 drivers/firmware/imx/sm-cpu.c                  |  1 +
 drivers/firmware/imx/sm-lmm.c                  |  1 +
 drivers/firmware/imx/sm-misc.c                 |  1 +
 drivers/hwmon/scmi-hwmon.c                     |  1 +
 drivers/iio/common/scmi_sensors/scmi_iio.c     |  1 +
 drivers/input/keyboard/imx-sm-bbm-key.c        |  1 +
 drivers/pmdomain/arm/scmi_perf_domain.c        |  1 +
 drivers/pmdomain/arm/scmi_pm_domain.c          |  1 +
 drivers/powercap/arm_scmi_powercap.c           |  1 +
 drivers/regulator/scmi-regulator.c             |  1 +
 drivers/reset/reset-scmi.c                     |  1 +
 drivers/rtc/rtc-imx-sm-bbm.c                   |  1 +
 include/linux/mod_devicetable.h                | 12 ++++++++++++
 include/linux/scmi_protocol.h                  |  5 +----
 scripts/mod/devicetable-offsets.c              |  4 ++++
 scripts/mod/file2alias.c                       | 13 +++++++++++++
 21 files changed, 58 insertions(+), 14 deletions(-)
---
base-commit: 8d6dbbbe3ba62de0a63e962ee004afb848c8e3ac
change-id: 20260616-scmi-modalias-0f32421bd452

Best regards,
--  
Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>

