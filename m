Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793681337;
	b=0EEiLxXzCOOpDjbAuFjSDReFPhFea8PhZs948G88/p3sYWpYigOEGi71TDUffXevxgET
	 fP0N7UJz96uHxff3J9wLoWegIT2SK8qe+TG7oXIgTZjWbEroKNAX4bqGQoTOZY+THw7+q
	 uk2pQcfdFFji28mDv3oMXsya1f0L//SlrZKPwkjSCdW2arFqvP6XxNKkIGZXLAZ9679nN
	 8uxp9qGZPW0dimS1fAX0S1RjHIwLljz7bqHlAwNMTe27g2Zl27U+6yudIMvbw6v803QSC
	 raILSg/w5JQ5BfaytH2DVKXshiKKfbIPoKcH4WecA1k8X7k5CX1i0rNOu27CrqaY1Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793681337;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=QaMvQc7YPxqzERreS7uDmkIOc8TUZOr8mXcE/xhevoA=;
	b=0v1VLnOhLAuBg3GZHr1AA/cuKDswBiuB8VxvrCrXFK7GmFvu6i0tcKMuyXhxmvQr94Ed
	 NN5gms92Tg30x8wgFIaGaGxTNjxdGd32xMbj0z37oXryy3Hqze3hiU17mnoqBmJx/Bo1k
	 vBG2xGDUvKqoXX6ty6EJ6pjSZhEUea0ipmdPN9YFNH8xkWUE0RYe228hP9CnmXfMLUWdN
	 zic3heF1miLDPiR1pf9/aVjdJA5gSn5IBD4Z+DZX0UBa0XASOg8R/6UoAJ+WgF3/NyivZ
	 Qi0eN3VXcrn4vEqLRfoNDOCJdgHz2wbET5PPS39vZ7Dj3nudxRmRR8O0EIKb3fUPrYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cyS5S6oI;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GWjBqKhN;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E560C606A324
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 04:48:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E560C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cyS5S6oI;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GWjBqKhN
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A31eKn11434198
	for <linux-pm@vger.kernel.org>; Tue, 3 Nov 2026 04:48:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=QaMvQc7YPxqzERreS7uDmkIOc8TUZOr8mXc
	E/xhevoA=; b=cyS5S6oIf1Po/eJc0NRAJ+h+J0JEeZkHQEeiRELOGNXlBQCgMVn
	tsLQ/dynwsKN7YmfZkjHARE9RumS3C/rHEJO6866e9ykeTVdNDpYRJw6j2csUgL8
	jhCyteS8BBXZWbKXrlGLVH3DOVNtBMnRQwCxWqiaz50QU5jNvLpIJoX9w7ftdYSE
	HLvub43wxvNdXgHqt4xc3jd790ELVW6g9kolPcrllvfDzMQ8cwODPSFdEOOM94JL
	Forox06Pgt2W1Mm8tH6DCuz/h/kF5hOhPgGOFraxtRuU6zng3NsQTPBdzunxxsm/
	cXcqgBED7XSTf+Fogf5AYM5ZD5AXh9t4N+Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq2achc71-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 04:48:55 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-934963b2bc0so691638085a.3
        for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2026 20:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793681335; x=1794286135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QaMvQc7YPxqzERreS7uDmkIOc8TUZOr8mXcE/xhevoA=;
        b=GWjBqKhNw2lLsGKH3nI0esgtVGSUbHHYIeCFPkEdvNawI5C1VdTst1kAvCnT9gteIt
         Lj8IPf+XBDChda5PVyu7e1uWSgu3JqbCzM1VXa0RmcXxV+YFF4ttqx3GfE67y+eSFybe
         br4TVa+kOoCfpep5MJHUWI8DN4JwNrzUqZByudVX9eYSoUE9hz94ShgwtTX2y0cyu9Nk
         11ZbRStVQUi5r/qA8ltrTpB/WyUgqR9t6EklKahBPnNTX8cYiPw37ttoACdNGeO91qHY
         UzId9aMWTc1qU/XdI8W3Lz00SvOBCp4SBbmQ19rPSILXFqCZkoPt6VKfRkW2yfbLR3bR
         qnsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793681335; x=1794286135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QaMvQc7YPxqzERreS7uDmkIOc8TUZOr8mXcE/xhevoA=;
        b=LolRDoidIUo0JfNVkvXcyhdlUMxw3QL/AdfixzwuMaNrVu8nIx2e1NizLQPXw4jPee
         f3pZxezJ5Oh37qOYM3hlJB2RqxMSbF4eVt3dqB0K9VX2nSS0RM3qTtQjE90qusbvP1U9
         ioJcpBrCQ/ooM9EG3yFJTqV1+muQ4z440WguAlFNRwbI1ePC+F2BULvju8irgzX4ACf3
         76+e/CsXbJGboiWCZmgqLtIkYxJNzBzM3YNrW97IPMaFqVNxJB7TH5iLqH0RBuGDcY4l
         /1JFf+XLwo16rcBAXKc9LSWgVpH8cpgR1R0mejLHYkcU47kvmn5oiyWQKUGMGUe37Yqv
         aLeA==
X-Forwarded-Encrypted: i=1; AKwUvBxxVvp2X0Pbbgx5ylnpwYXZQ5CjCWm7amGjrI4NFW2bGixStCMIIz4xp/hzepxJ2HKT7S/YOmnDnA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/SE2OrWVHeR1yg2AyBPFBDmEhIWBEbNS7Ruk4RE5qlmTcLfpF8
	llUGjtkj6aq11jgsozG5lIPKxx53f1UZtyYSX6GaLBwsdGxPmWW0QbSc0CtUuKPf7pW2YDN2oQ3
	bat2mC1CctaaGWFhY9ctBzBXudA2d+ieOgi4S3txQl9wqFn2DI1qxqGADnGkizQ==
X-Gm-Gg: AYBFou0BwDx8NEL0pTLiwjtfPaWEifWw6VqsrbA2yH4KM7SkzYrcowUYFjgzri5Zy/z
	n+yrga16RKUD569blnj5pMICcPb4vAdL+bETxJCoSHjn+SfsT4Held1RkqV5TpNeY/HbBRFhU8V
	ZfaYVN+y2+H3q91qSWyLZ9Uq7xL4XL2crN7H12T0R23d1kzwSFb01kA1+Dgqk0gsmkXtFzRZFGu
	8+ufz2soChsWbhKVf0YLEakJGXAq+HD+YVmEiLh+vE6b/8ZqoNHO+E66nEw44qBIA2IOt9r3YhF
	itsk3X4CuGQ17OA6ShuP0QnrFz40xEi/c8aIYTJlsXc0564hu6ZxWG4fl0UA4PJfx99XYZZvWoS
	PUW1wy4odi8IPejVN6OVsVr8arPE0ISkwnkWOjrnCnxV8BdYnouPYg4lKMYIgtn9/cn2vD8snhr
	Vo
X-Received: by 2002:a05:620a:3945:b0:93c:70da:e45e with SMTP id af79cd13be357-94421677245mr2452915885a.36.1793681334920;
        Mon, 02 Nov 2026 20:48:54 -0800 (PST)
X-Received: by 2002:a05:620a:3945:b0:93c:70da:e45e with SMTP id af79cd13be357-94421677245mr2452913185a.36.1793681334303;
        Mon, 02 Nov 2026 20:48:54 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:8b9e:7797:dd05:11cb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a879fb29sm25685445e9.4.2026.11.02.20.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 20:48:53 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, Shuah Khan <shuah@kernel.org>,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v5 0/6] powercap: Add generic hierarchy support and convert DTPM
Date: Tue,  3 Nov 2026 05:48:14 +0100
Message-ID: <cover.1793666444.git.daniel.lezcano@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=T4gZ3PKQ c=1 sm=1 tr=0 ts=6ae967b7 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=Lw0nehYz5hoo17msdR0A:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAxOCBTYWx0ZWRfX6eJi03k4yqOv
 RQRKLvJulFudLJaZui7N20Qhpz7hfGVGpy/IajvptY5oulBrXwN5UMBJqL3pmmJwgdAhY2q3vmP
 uWtc8zpscfeC3AmgvEYyTVyIXMLdyKKx0mn8Zrgj4sT6/y+eeUMADJ3T2E7SNSZNiKWgqGjsXdv
 zFrHw1kjjs9lWUzRkfzg/69z6bmrQapgyEH2rTaJsSRsRGIfmPSBkquAaCOyuML6drdCG7YxRG0
 WOArip1JYsjlSLY3QimLKy7PM97jJCqJr4lv0diJi5OxlMqu7+VEXKgwnnfdYDMZ5onhE7whuJG
 5PnjqHP859KhF68IeOWvgo/55F4ra2jPMW+5kFormd1A4bnRa/SFGCG7trJOiYAa1v5lYDiquMV
 ntmzAO5tPKcM9uD4RbzaI369JqNFdZWJHMOpAN/SUhamCNjC3firBNgpa3vd/RQ0dDMvOmHB+KF
 AqlJk4DgM1JgdZco3eg==
X-Proofpoint-GUID: bo4X-525v8vPt7dbu9AwF_I2TzNV7Qez
X-Proofpoint-ORIG-GUID: bo4X-525v8vPt7dbu9AwF_I2TzNV7Qez
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAxOCBTYWx0ZWRfX8C6rxtZQ+WI2
 vpL11F342xy+osjwCRB4mnXucEjlqmyHpUzEkxN6GlqKYBAGJP8//RrRc1W5Nkz6ImOfPO4LuCd
 REVwBduB0hQ43bzkxlyKVhhVM/wnDKo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030018

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

Changes in v5 (since v4):
- Address Lukasz Luba's review of patch 4: reject a DTPM DT node with a
  NULL path before calling of_find_node_by_path(). Treat the missing path
  as an invalid descriptor (-EINVAL), rather than skipping it as an
  unavailable backend.
- Collect Reviewed-by tags from Lukasz Luba for patches 1, 3, 5 and 6.
- Keep the v7.3 base and the six-patch organization.

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

 drivers/powercap/dtpm.c                       | 180 +++++-----
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
 13 files changed, 1153 insertions(+), 152 deletions(-)
 create mode 100644 tools/testing/selftests/powercap/Kbuild
 create mode 100644 tools/testing/selftests/powercap/Makefile
 create mode 100644 tools/testing/selftests/powercap/config
 create mode 100644 tools/testing/selftests/powercap/powercap_hierarchy.c
 create mode 100755 tools/testing/selftests/powercap/powercap_hierarchy.sh


base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.43.0

