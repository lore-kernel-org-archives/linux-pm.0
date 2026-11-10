Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316881;
	b=QA6iwJFXCfCvpgVfBuG4e1zG0EaIbmFjp6bO9uZfDCMzGdmM6CWKx1eddIM7N3uzpd+M
	 JKWoRHZ29xlhDRumP45QjuxF8HyW+ch+U7yf7Mt86p8fhWeDBE9O+BuUc6vQ8DaRPWoe6
	 RSbN/ja01Bgoj0GjaSnzwWUCqcNb2Yn8c/dJZRe522NlGmj6DInDf6ONKqPEZSl2/3uXU
	 5B8TDZgHmxg2SFKukoTZS/+/BG4e/1CtrSArrRmovzTL7jD0hkT27DOfWHyZSRb7lawoU
	 DisAKOTMUJsIawGCubw1uoXSLAjXhEMmY4VII1efnpQjNzPfInm6+sDjenQ8BI1IGig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316881;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Content-Language:To:Cc:From:Subject:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=wedbrXh177mbzmYM+3txzr4ofpzd2UDd+z7ICvagmsM=;
	b=Cb3RpfLUQZIIno0Tln0ouy7WBbcwobLaLZ8za0Mj+kY6H21kjKsQBQqfIkUZb09rQcMO
	 1rFIAD7ZAAwGL4jDMQ6ZAz9eteMwtcDRu+NOSXsuIB/igAn5TdWhR5LwPfW7upRUFiePe
	 MRQGtwKaLUQJ4hZIW6P23RlkxhYifLFdZz8FLFTJADLwGY+GBdSXKaysuPt1FVkf+jsbT
	 Q1htikqKBkTZZzmzEI4B36oE/c61by4wMRN8g3B4ZnU3bUCtR1uIOyn2PNb5b4AITy++s
	 v77sEH33JR1RnXhNh1uzs9snBiByxQugb+H7wMieAjhVyc/uebTdllxCdtnMmknb3kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XYkrWJgp;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VZD9wvhx;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46DC606A7C5
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 13:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B46DC606A7C5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XYkrWJgp;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VZD9wvhx
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AABA8rF3217130
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 13:21:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=wedbrXh177mbzmYM+3txzr
	4ofpzd2UDd+z7ICvagmsM=; b=XYkrWJgpRa06p1t340wdOzXmWXTRgyqCfNJFBl
	eWdpDzKL/23EU2D72H96WXxiMPbR2PHzscSUYks5STxiYudNtOMp1evTvt1/N2Sc
	QfCHV6+CbxCVV8/6JzHiHm95OHA/Yx5tUFNwxjTdJErtrLMqICsUPXQXonzPh8X2
	LaJPqNoT7kYM6eRXzREoL1nTa2At/FW6ar5UrUMvHa+q6lXJNr42URX47wMMUhUR
	qs4n04Vrw5VKURJIQCUqjokEjpjdcTE+MZfBvLpLXBbiPl1er6z/ixbREzrYi3m0
	Q1tuCmFQX7rZRfi9YXD/EoknlrYXpAXsK5jyaReIy/v3DJiQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huvtd9tj7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 13:21:19 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f559420f3so226400385a.0
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 05:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794316879; x=1794921679; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wedbrXh177mbzmYM+3txzr4ofpzd2UDd+z7ICvagmsM=;
        b=VZD9wvhxvM8ezfjARMcT9qLdNBtmUtuU1P9nwpZqPQSNf0HsAge7OQ1JkdorQLU50I
         3F0+7UyJurPVb5vhOqNUVHbScZd8DXtJ+A1qKXDsjbSpxRq6qBAQTZrhcjCl79/a12iM
         1WPczozEwqUuM5b5jRUeughz0Z9jdSdComV+62ZwV8V13hBvM9sMzyeDnRV6GpjEVcDI
         9RBdIfyPRCvZOg3KS0pKBtgvw0HtENAMBon0kjoAPyyDYSvG8IOCqit2QbgfxkL+Z3/n
         fs3jY1TgHbAhYJQR+NtJ3ib9l0BFjJK/dl+N74p17oBiUDRBczO0SwDb0afRbbpHbEGR
         qEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794316879; x=1794921679;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wedbrXh177mbzmYM+3txzr4ofpzd2UDd+z7ICvagmsM=;
        b=OqTTa8pvMZeBxju1Lxtj73QdzFvzg/vJ2BfaQPDCNKoMYsH1EdAZSIrKxla+YE0b1E
         LlKX98khZlrHWXOkXrXgwUhcBrTEEbZdk3JM0YcE2QhiX+n8iKLeDof12yVJAKTCX0Cg
         66dhhFMzvIQLglorSpy9+nvt3t/0Jf2Joz/gUd8Bkq0jPOGW/SGmyXuC18Vjzpoe/Ygs
         8pwtEM7H264gsn//GHteF5a4C8v/SuI2RbHP4aVbJufbLkhlr/6S8S2hjOp71VUjKJaW
         bNfVHTieQD1uPSoZdmcLcj1ylYdxmzuhvVz7nlxFF67mgYSlaIh+iKUD7DDeLWgVW7A/
         kQZQ==
X-Forwarded-Encrypted: i=1; AL+hErFzUVkKk368cFCeDOP+m7/V1pZ/Sn7ft9CJ5VGJ0r/B5tssNG75nXhjVysW9I+1E9MIkVBmvqTWqg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8wODn6dRGpnE2WbdbWKi52LJ+FQ08SPV1CdGo09GBnA+pzOCjd
	defyddFoz5rDrKJwpa/qg4p7yWL0m3EGieMuiWk7y8nRMT/gAdOiOuTXvcCjHLQ3bXk3XBiYEPW
	mIeHcyjD+6RjFqoZASP55LlEQORM2k+bCUxHrgDZ0+gQII1g0xwty9o9vXUeHlg==
X-Gm-Gg: AYBFou2kXcwY5KxFaOC1LBgADlfNfi/x+44g5qgpTuTlbSiho2+MHS9HAIvFBbn++ps
	sO4glrXl75O0FKdHmUdXkankLxhRpZ7xILmCKzVy91/oLItbex3fmPGfVsn3HZS2zu5ysjyNOQo
	Um7izjvfPyDZDIK6N3hCSrqy1CvlGA13v3YnklHen3uqOdRb+KjtjcRzxhZVx4pMSDpPuQvUh29
	06ejJVMj333RKJH61+gdY9LpwLktaVHJokr/E3MA0TDQAn/bAEQCssAGvL4HESqTP9zwOgZ2XzK
	wTBavLsPoABUh117sQCwklZcOT/EB5WQ0AVJ7ICI/XQ3X4VrP2frKa5x7xP9fLiPSO+ndJEXYse
	LrrR3eeIylk6xd6xNk4Bu0TqtmntZAK8USw6yfCEGcuLYMILsCOSJ4JMEKmDC+Me21wu1rJwRKF
	qEA6/KgOCbr4w5Z3NUV1fRCBIuVBBzxgMxZCM=
X-Received: by 2002:a05:620a:4413:b0:93f:a63:15f8 with SMTP id af79cd13be357-9479f1d71c1mr399920785a.8.1794316878728;
        Tue, 10 Nov 2026 05:21:18 -0800 (PST)
X-Received: by 2002:a05:620a:4413:b0:93f:a63:15f8 with SMTP id af79cd13be357-9479f1d71c1mr399913585a.8.1794316878017;
        Tue, 10 Nov 2026 05:21:18 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:496c:dcb4:4deb:25e8? ([2a05:6e02:1041:c10:496c:dcb4:4deb:25e8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983585c4fdsm5047635f8f.10.2026.11.10.05.21.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 05:21:17 -0800 (PST)
Message-ID: <b9ff4d03-61f7-4e17-b048-3cecee70f3ca@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 14:21:16 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Heiko St??bner <heiko@sntech.de>, Shuah Khan <shuah@kernel.org>,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        Lukasz Luba <Lukasz.Luba@arm.com>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kselftest@vger.kernel.org
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Subject: [GIT PULL] powercap: Add generic hierarchy support and convert DTPM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: trb5MwzpPTfpGAeheRoW51wXOsnygJxy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA1MyBTYWx0ZWRfXyZtRjyl23gKB
 kdqtxVDE6m3za/mWq7kLBLlETd/g7xjOBeypCpPkBBE9QDHnKQmQKd1lEm/x3cT+LSJkRLEMAay
 GFwZrP5NBH28/8HhEEb3CRczDuVljeM=
X-Proofpoint-ORIG-GUID: trb5MwzpPTfpGAeheRoW51wXOsnygJxy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA1MyBTYWx0ZWRfX/sjbsc/pUkpo
 J/S464gSfUMNbm4CqWd87VLMa2VC3K88CIS4D2wvOva2T7QlZlJM4f9OewEdwYrZgmRfXjwIDCd
 WkQuiWKyncKSGimu/mToMYf4cueT1sw6umP1y/dK2XKMufNPvEzp+0ucnU4ugrhfdQHV+qj47La
 kVumCeSfr/DYCBz35mc6udZB0MN/yXhSfGtSaHk0c0xUYiGaG9jA7xTVxDIzTJJP8288hhEeAQt
 RdAOKdwY5tgWOaJQX+2f/wKt+RY5OXQ8U5ax1B6bsLde6HycgjManIRjtUi7wtf30CCUna7oRxt
 1EjCpJU8cNrv6/ZVzQH2lTB3D2wqWuqOekQVEfPnyV314xQJx4utRM1KomO7mujQ8EyGOx7sMu9
 zOXIVR9e5Nx2oHnnTqjZt24ssxCiPLm72LloN4aw6jueiyRelB/GZfd/Bn9B+8hH1moT7cdwWc2
 IK76M53OcyLMsAKMSaA==
X-Authority-Analysis: v=2.4 cv=ArR7T+9P c=1 sm=1 tr=0 ts=6af31a4f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=GgbJc354ad6G5sA-JgAA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100053


Hi Rafael,

as requested please consider the following changes since commit 
6628e7d4c6b25c8d18f1345e3a20d21829aae7e4:

   Linux 7.4-rc1 (2026-11-01 13:26:31 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git 
tags/powercap-hierarchy

for you to fetch changes up to 6ba41a1519ff1f91f96d90a6bf4f70131a8f7c73:

   powercap: dtpm: Add RK3588 hierarchy (2026-11-09 17:33:40 +0100)

----------------------------------------------------------------
Powercap controllers may expose trees of power zones, such as packages,
clusters and CPUs. This series adds generic helpers to duplicate a static
hierarchy description, create its zones through backend callbacks, and
destroy them in reverse order. Parents must precede their children in the
node array; the helpers validate that ordering rather than sorting nodes.

Drivers supporting multiple platforms can place each platform's hierarchy
description and node array in initdata. powercap_hierarchy_dup() creates a
working copy of the selected hierarchy and rebases its parent pointers.
All original descriptions, including those for unused platforms, can then
be reclaimed automatically with init memory. Names and backend-private
data are not duplicated and must remain valid for the working hierarchy.

The controller supplies creation and destruction callbacks to connect the
generic hierarchy traversal to its backend. The creation callback receives
the control type, node name, private data and parent zone, registers the
zone with its operations and constraints, and returns it to the helper.
The destruction callback unregisters it during rollback or teardown.

The API supports both fatal creation errors, which roll back previously
created zones, and optional nodes: a NULL callback result skips a node and
its descendants while allowing independent branches to be created.

The helpers were motivated by the SPEL work and also let DTPM share the
same hierarchy infrastructure:
https://lore.kernel.org/lkml/20260702-qcom_spel_driver_upstream-v3-0-434d50f0c5b0@oss.qualcomm.com/

A kselftest exercises static and duplicated hierarchies, skipped branches,
reuse after partial destruction, and rejection of repeated creation. Its
userspace script checks the 16 exported zones and selected attribute
values, then removes the module with a sysfs attribute descriptor open.

DTPM is converted to the generic helpers while preserving best-effort
creation when individual backends are unavailable. The CPU backend finds
an online sibling when a hierarchy's representative CPU is offline.
Entirely offline policies remain unavailable during initialization.

The RK3399 description is reduced to one CPU entry per cpufreq policy.
The old backend already suppressed duplicate registration; the extra
entries were redundant descriptions, not additional registered zones.
Finally, a shared Rockchip virtual descriptor and an RK3588 CPU hierarchy
are added. RK3588's three frequency domains are represented by cpu@0,
cpu@400 and cpu@600 below a virtual package node; no GPU zone is added
for RK3588 in this series.

----------------------------------------------------------------
Daniel Lezcano (6):
       powercap: Add generic zone hierarchy creation helpers
       selftests/powercap: Add powercap hierarchy creation API tests
       powercap: dtpm: Remove duplicate RK3399 CPU hierarchy nodes
       powercap: dtpm: Use generic powercap hierarchy helpers
       powercap: dtpm: Rename Rockchip virtual node descriptor
       powercap: dtpm: Add RK3588 hierarchy

  drivers/powercap/dtpm.c                            | 180 ++++++------
  drivers/powercap/dtpm_cpu.c                        |  62 +++-
  drivers/powercap/dtpm_devfreq.c                    |  22 +-
  drivers/powercap/powercap_sys.c                    | 204 +++++++++++++
  drivers/soc/rockchip/dtpm.c                        | 129 +++++++--
  include/linux/dtpm.h                               |   6 +-
  include/linux/powercap.h                           | 205 ++++++++++++++
  tools/testing/selftests/Makefile                   |   1 +
  tools/testing/selftests/powercap/Kbuild            |   5 +
  tools/testing/selftests/powercap/Makefile          |  46 +++
  tools/testing/selftests/powercap/config            |   3 +
  .../selftests/powercap/powercap_hierarchy.c        | 314 
+++++++++++++++++++++
  .../selftests/powercap/powercap_hierarchy.sh       | 128 +++++++++
  13 files changed, 1153 insertions(+), 152 deletions(-)
  create mode 100644 tools/testing/selftests/powercap/Kbuild
  create mode 100644 tools/testing/selftests/powercap/Makefile
  create mode 100644 tools/testing/selftests/powercap/config
  create mode 100644 tools/testing/selftests/powercap/powercap_hierarchy.c
  create mode 100755 tools/testing/selftests/powercap/powercap_hierarchy.sh
