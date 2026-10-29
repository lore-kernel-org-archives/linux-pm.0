Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793293048;
	b=cHY7lYooIUoCzJYhzywheDy/tUETz+s3Mo0WjSGINHCHYbFLqCZh/UqNb+/Th8sGzzy3
	 yHa9KTd/sZVjU5DYH96Iwum2EWrjgL/d6/m42pUZGq8eSPA3XUd4SkgejRp8CWbMOJonj
	 cvrMvlM12w8BtzO3SY2pWPyhYg7F22T48RamZQ+wE8DdX5o+xS1kXh0gHNEGnJmMUUvy/
	 KGHQ8Lug6GZL3BnxXCtJ/mLW/oVErZWR258jRXgDIF46Pl0x84K95tUEW/JpaKsnqIwc3
	 Wo4oC0/SWP6v1Ba08EHHQuFH2bJZDEaj0cpd4h5d+OJx9hjve93lm9KO6xbczmZANWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793293048;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=me5c7m/qzPaBItKrxG31JKNm+LqR9airvuaWsfIyW/E=;
	b=cqcpJpa4MAWLNR93vRRSM9C7Nljcnh8Q4DztNUfvzaDT8Iv0gj+f0t+lwGhE+bdbhoou
	 oht03i0+fI5tL2PW6otGdoqKGy5RldAjUPLPpJF7wBh2VY5gjGWPw6IJPTnCzuwB6Pakd
	 L0aXqkg3Ob9bN1QvAmAytYeGExIF+XHQMvgFW0UQWggWMBATn9lybztfkb+ir0kGg7REA
	 QfADH0Xwkt8ySCyw/S9zfLri2EiXuCc8yVfsio7D7euWVLuFBT+I83HyvEFMJMi4BhoPm
	 TgdY5V6VosKi+QMHvbCkJPj2gsA/ggplnFZScl3Mp53EG6eUf4YUPLaFQzkyUfToikw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UievcfT0;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SxtYZEG7;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF862606A31D
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 16:57:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF862606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UievcfT0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SxtYZEG7
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TGDPjG594506
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 16:57:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=me5c7m/qzPaBItKrxG31JKNm+LqR9airvua
	WsfIyW/E=; b=UievcfT0DQjO8FjvbPe1RKj08QapsD968FpQwzYlqJWV2/9ukGQ
	6vBzNSNLqJ9silL0CZCw4DCLWZAFiYyrJ0Pdo1RBZ5YFOHhLp452A6iK8Y2cAJ1z
	IkttFda9ZoOZQ5UTgviDWsDh6Xp+oe4VeygexGWCPgXsCQ1C3JClyl/oTRfZ9DbB
	U675GynJLwRTHqzoxb1Gsf4agGAOgK8OgceVtl6qmoGyAfZTgaq0TuSVKd7cR0aS
	uuPuEflWE5oHqycrzJzHZBytenUX1Snd6ZowrihMZEWLkYUBbzBzvwLITVqE4dgN
	UXb0M77CadJJV2DvRIfqW2ec0x0l/m2HenQ==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkut3kj7m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 16:57:26 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-98a9c848bf0so514460241.0
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 09:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793293046; x=1793897846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=me5c7m/qzPaBItKrxG31JKNm+LqR9airvuaWsfIyW/E=;
        b=SxtYZEG7a0BSFuElUP6wYh+T4ooLhQN0CqnpMTmp6wSvhxqHVidPJ6GIpQgi8pRN1f
         TD1FDs7G84D6u7SP3/178Sz7bmUtmREfk3dpPvUI+Cbh8o4q3BtkkStE+DtNa7dCSLzw
         p40nJHmdBwdR/2p/iVxqexqpfllopeIbSm1rw7zn9kvQkfLbw2817nJqF+uuIUolWfFQ
         YC+roeau8u5gArYJtA0cImbFBdPx0Go6WzeqymcyvRy0qpNkXDrcTTpzs7YDm02RqiuS
         fKerR6D23t/S9tX1BDx/MwJ0l6WzWqDM9bA+tH3yDJNP8+JdLqxJPwk5wmx+cY2PuVX0
         +OyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793293046; x=1793897846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=me5c7m/qzPaBItKrxG31JKNm+LqR9airvuaWsfIyW/E=;
        b=lAjXoh6kWZzyGec0Bfp8JcoONA3z71BUU/2WnIhwsPnrcufgKiIbngq1DDqj7hMJLh
         Ang461N+95wTwX2aVQ4VXhsO7utdmC7H5NekKrq/M9i6h1XMl3klfaK4gw3e8UJf8V+Z
         sQY//8N9g6umrev2EuEiSrImUsiiMzm4FbSQzI4+urpJ/w7P+ac1MHiRDlVhCLBvCGEt
         0lhNG0fyC901rq7UDJv23XxS9q/9nXOxJr6H6cHWL8ei4gH7wWuCDXMLhm1uf95QkBXt
         YqpdJTgEL+Ll1FEMmBJHLk77y3B7239Jl2bBevEdVyZ0z71T0ERc9oSgGZTlzTN2BWRx
         1kww==
X-Forwarded-Encrypted: i=1; AKwUvBy3Gycnnov+78C1/a5hTfjPQigQSkQos32TOATd6kjsIvtDdCHfhFBra5U8lHQEDNOjboewmovzZQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKQyNGjgacq1Bil1rrnPa6VgSpKMo2T09QiD2Z/XCXElOfzAen+
	OO546s46A0KKw/R79SCkWg7R2Z004Dh70GOdIuQjTVsyOY3tZAibejyzZ53Aopdovsae9GOHlH2
	K6iGHgYOrfPFar2lbY5s3ZZdnqpKgPqEv2pHaV5q/AFwAJjH7xnI1OeV/QFF+cQ==
X-Gm-Gg: AYBFou0jwwfPCIZF8zq/CRlnDuCSQWSBgaOvrZ+64mcxZO8lFX+bUp2aNoIDmHdgpuf
	URG/WZJZj640HCHrH7s7TCyyQBDXR9ac2mc0WdddagOh2u1iyCqQOb1itNRQ6i45f1ZhqSZ8uyU
	F7h53LV+i9JtET028kOKCzS2fI1t9tHJ613ndZsw+13EEVsVxaZdWJFO6oynd9/PWPUs0qSyYju
	bjJ43kXUvqFqcJfZiqElchMplwLRODLEI3RkezZtO+LypDAdfIEWf1BQjoV7jwiX4RUxgxdYvUQ
	CptJUudQtLwk0d+/RXHNE3YjJjirzHcde5GScxwdiSf24ViGRy/y2TWXO5YHLQE8YocvMkMRE13
	FS0WAnrFz9aWwREX02idqv5EtfMzc24dwaPr3EqZBn8CZkdCQ+CtVa3Lcbz1sru153eIUrn9LAL
	LX
X-Received: by 2002:a05:6102:5698:b0:7bd:732e:c615 with SMTP id ada2fe7eead31-7d03a5b4865mr2521755137.26.1793293045821;
        Thu, 29 Oct 2026 09:57:25 -0700 (PDT)
X-Received: by 2002:a05:6102:5698:b0:7bd:732e:c615 with SMTP id ada2fe7eead31-7d03a5b4865mr2521743137.26.1793293045283;
        Thu, 29 Oct 2026 09:57:25 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:7fbe:151a:486d:a2cc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e6df961dasm325669f8f.23.2026.10.29.09.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 09:57:24 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, Shuah Khan <shuah@kernel.org>,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v4 0/6] powercap: Add generic hierarchy support and convert DTPM
Date: Thu, 29 Oct 2026 17:56:44 +0100
Message-ID: <cover.1793288783.git.daniel.lezcano@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2NiBTYWx0ZWRfX71366YHmu4KL
 1B1nNH0/wkek88OUC4lIOtBsvjEOBQqjHlt0xvW+5WlLawKzRqitCiLTa1M6FsrDNu7ThVvT9HR
 PFRULHesd84DiR9jKPs7orDnhjQrNZ8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2NiBTYWx0ZWRfX7kMZIbljzXUS
 7K7kK2END65IW2UJ6I6yO8/0uonID0ZrR3SsIA7zj3MjUXCWkWdm1slB4NaYzzcxmla2uKVEGot
 IE4evqJla6yejfX3A71M9TCfvLrDM7/kqQ0AiGRfqufboAYSQebqNIyTF+SJU2ppzK68GhfC7m0
 kiBQafX+3yEgHuSsBb+kMoQ15PMZIF24T/b5XlqlZ/xgaUU8AMeUkbJeCVWDiUMHqdltE3SQR//
 CaHgS0Wbwh8kxEJB0NYr/USbwipKfawcCm2rZ+pcLh5JzNtYjGlG+S/qOqq0BSItYalfkArZ9rM
 FeAswUUeZdEBeJE1p4LMRA5kihJQ8VWh+9kKzg0AFnaW1II4WTmyZVLrikGFQvXTD9KXpsO2Jlf
 9i3pY5kUn/dW+56kgLk0FtGmkVqylKxMx6aQXcUT8Fw5aPicakv9pQF3yj5jwntYqcMXme+HORN
 KL54UyB9DdT5zZbqaYQ==
X-Proofpoint-ORIG-GUID: xHBP371GcqON-1eWGkLXH_3ARmSRvFsT
X-Proofpoint-GUID: xHBP371GcqON-1eWGkLXH_3ARmSRvFsT
X-Authority-Analysis: v=2.4 cv=HYSB3SE8 c=1 sm=1 tr=0 ts=6ae37af6 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=6LeHEQr_I3XcUWd-WmkA:9 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290066

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

Changes in v4 (since v3):
- Rebase on v7.3.
- Address the selftest issues reported by Sashiko:
  - Add a kselftest config fragment requesting CONFIG_POWERCAP,
    CONFIG_MODULES and CONFIG_MODULE_UNLOAD, guard the module build with
    CONFIG_POWERCAP, and skip building when prerequisites or Module.symvers
    are missing instead of failing at modpost.
  - Resolve the kernel output directory and pass absolute O=,
    KBUILD_OUTPUT and module-output paths to Kbuild so cleanup works when
    a relative O= is inherited from the parent selftest make invocation.
  - Keep the statically initialized mutex in permanent module data so its
    lockdep key does not point into freed module init memory. Retain a
    separate init-only description for the hierarchy duplication test.
  - Return KSFT_SKIP when powercap sysfs support or the test module is
    unavailable, while retaining failures for actual module-load errors.

Changes in v3 (since v2):
- Rebase on v7.3-rc7.
- Add POWERCAP_HIERARCHY_INIT() and document static versus duplicated
  hierarchy ownership and lock initialization.
- Explain how duplication retains the selected platform hierarchy while
  init memory containing the original descriptions is reclaimed, and
  describe the controller callbacks and their arguments.
- Reject populated hierarchies with -EBUSY before invoking callbacks.
- Validate names and parent ordering before zone creation, including for
  static hierarchies; document the accepted hierarchy structure.
- Use explicit mutex locking, a signed reverse-loop index, and the clearer
  powercap_node.zone member name.
- Define NULL creation results as skipped branches and retain rollback for
  error pointers, preserving DTPM's best-effort behavior.
- Handle offline CPU representatives through an online policy sibling
  while holding the CPU hotplug read lock.
- Fix selftest output-directory handling and module cleanup, use
  powercap-owned zone allocations, and keep shell validation/counting in
  the main shell so failures propagate.
- Extend and document selftest coverage for static creation, skipped
  branches, hierarchy reuse, -EBUSY, and an open descriptor at teardown.
- Fix indentation, __initdata placement, unnamed setup callback arguments,
  and whitespace-only lines reported by checkpatch and patch application.
- Correct descriptions of redundant CPU entries and actual sysfs checks.

Earlier generic hierarchy API and selftest submission:
https://lore.kernel.org/all/20260806110159.69690-1-daniel.lezcano@oss.qualcomm.com/

Daniel Lezcano (6):
  powercap: Add generic zone hierarchy creation helpers
  selftests/powercap: Add powercap hierarchy creation API tests
  powercap: dtpm: Remove duplicate RK3399 CPU hierarchy nodes
  powercap: dtpm: Use generic powercap hierarchy helpers
  powercap: dtpm: Rename Rockchip virtual node descriptor
  powercap: dtpm: Add RK3588 hierarchy

 drivers/powercap/dtpm.c                       | 177 +++++-----
 drivers/powercap/dtpm_cpu.c                   |  62 +++-
 drivers/powercap/dtpm_devfreq.c               |  22 +-
 drivers/powercap/powercap_sys.c               | 204 ++++++++++++
 drivers/soc/rockchip/dtpm.c                   | 129 +++++--
 include/linux/dtpm.h                          |   6 +-
 include/linux/powercap.h                      | 205 ++++++++++++
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/powercap/Kbuild       |   5 +
 tools/testing/selftests/powercap/Makefile     |  46 +++
 tools/testing/selftests/powercap/config       |   3 +
 .../selftests/powercap/powercap_hierarchy.c   | 314 ++++++++++++++++++
 .../selftests/powercap/powercap_hierarchy.sh  | 128 +++++++
 13 files changed, 1150 insertions(+), 152 deletions(-)
 create mode 100644 tools/testing/selftests/powercap/Kbuild
 create mode 100644 tools/testing/selftests/powercap/Makefile
 create mode 100644 tools/testing/selftests/powercap/config
 create mode 100644 tools/testing/selftests/powercap/powercap_hierarchy.c
 create mode 100755 tools/testing/selftests/powercap/powercap_hierarchy.sh


base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.43.0
