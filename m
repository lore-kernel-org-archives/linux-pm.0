Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505852;
	b=N8+dCvP/sSXSJlG5plaPhNm4mwDmGwsSGU4jOSqUSJfXhfUkFNPAPjbDrNQKYXlQ+XHd
	 RxYIfsEOPGxLful5JjgdQGbljMt0OI+X/996qHzGTgU/80K8Ue0pflpM86adVbQ6DolWx
	 sdRAplW6sy1qVmYwC5w0k55NOldYdl6a3SYg1kbKju3+/OiBSyJekLe5vk7Am7YOjrFoD
	 Ux+WR9JYxx1t+XR2KZ/jGR4VXyBP/z6++8DaZmhYFCioJmu+FmyKBgRCTyCJU/FNcgb1h
	 zh0qjp64zEFFISNA65CdW6MJh382KRdbSvWh8AOuqJLzlgzJTf62mDFMMFNONsxxb/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505852;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Sd2t6zfawn/sdEB5TPQXH1fGTRUUwWcMIRfzxgxuW6I=;
	b=WRU7erEroIWBOLTuG/KwVkFrqcKiNXQvP6ViCI4UdjNNFuIfMlmgiCyIcJRNzCvtXkPi
	 mbqMCEhR0foUV2xa/OinCcs11R2E7b1lfk/ty1o6dXXu4qH4TW7cVXUpEwc/9gxIWDZxD
	 f7z4m1FKMzA7F8KDP12T4Les662QtBLXB5XstBqDaTgiMK6wILV6pDLV1Bro5OwP1jO+o
	 rRTNnsRQpGpGIk41gFeNKKnLP45qQWqJfq5motAfdNx5QavopbkkwKsYNkXTXXVrC4sfp
	 IjE193GSkyqMMk8suIvLRZyqlFo5gKmypASTho9dY3SEnk8tKgIfjIfBgEB+QpPnRhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YP919FM0;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cZ7Q7XyB;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100D760A4AD7
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 14:17:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 100D760A4AD7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YP919FM0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cZ7Q7XyB
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KD9pNr1781303
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 14:17:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Sd2t6zfawn/sdEB5TPQXH1fGTRUUwWcMIRf
	zxgxuW6I=; b=YP919FM0JOYKraNflm4XG/APZyEWo54y3fi66Z0fTAs4bAhHoxq
	b7dfs1GWiIhn1B8gJSqaaEyoHlleHSrPdzUXY6KyRHLEa1ITiRmi3XQQRD1o2KAh
	p72CMes9DeabKGDmY/h9wLQpJv0NM/0CO70eeYndFDGjsdzPaZ44xaYbo6YZ7Im+
	JGtwHe1gp3srX54aQeDrRWV9WIqRUId44loA0wPT1Lqd9DlPdqm6BOgDhVNTUrn+
	MBFvcbC/J/z23LhDaCBphc1xH0rdh40vyzgJJ0hK4wcwbSW3BnYIes9qbspMBViA
	6UiADy+7dsulCTyEbAJN0RzJG5Wm+mv21MA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4he7h28k5e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 14:17:31 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cb93c874bso140112585a.0
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 07:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792505850; x=1793110650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sd2t6zfawn/sdEB5TPQXH1fGTRUUwWcMIRfzxgxuW6I=;
        b=cZ7Q7XyBaEsRFjP2fKPkRckDYYvVSrz+88sJ7l6b8bLJSZyh8G+sgy4pf4CT4iNucc
         x+u3jrHLdFDeMNouqFFQn4boRN7w5NmPYLU0bUkWC/ghpUTilNO3Gzb7EIW6gjEMUsFu
         DV4Ma9HZt53cYesl2ZUi2o5MX99auNf0DBq4s7u3ccLupmAuhoVnDOh4VKgMRzCPRU+U
         HHe+eoBSY6AQ/sT0v/tG/4ArrezKl3nthmZdasRwqRMdC9t43Cr4OXRe7IwhSNdpfSIn
         e3QRap6696L8vGn8rnqRtfa6wRKm9oaM+fgLde3iZVbRuZUG7D8v9J1iY+a0b2BOi67Y
         Ewbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792505850; x=1793110650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sd2t6zfawn/sdEB5TPQXH1fGTRUUwWcMIRfzxgxuW6I=;
        b=lMFFnl0jXu7ngp83+3YEJ+E0teba6vuLcjOlSZypSoN6prSaA2KgeCP0shMRzztltL
         0KZYviK7a4iIkQAE+Ad02Loj61At0F3wjKEeLZidNr4k1Mtqr0EAVM4/rpwBOSyirzV0
         NQpzxjUnDuUFzkQcEXLk0aRx4QXFv4K+pKu79oekDDfAu2QUV+fNozY5euAWM4KWlQcV
         5l77UkDT6hB/3bgNPeH1kUb9obxjGBeM34CbQk/w35nS8gqRlfFzRUo/XiiYEcq1gKjh
         wJrbXI9cmZkB1bpB/m8nj5A1J5jpdhnFM9INPw5WkPmUoyW8BRESCDbYTVXqq3NNA9Xz
         YPjw==
X-Forwarded-Encrypted: i=1; AKwUvBx7ugzXp65O4xvDjEoyHy0B4+3sYdtPZ2AzTLZtnAM/FIRmgrphpqVXV6NfbS0z76GPMrCx8ZeuCg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJLIiM//j22cJSkCK1fIXlBCiRYbQgPpwFWjug8/9BZJgus/Y6x
	3AAVh9Ke0+rExliQ2h7Lr7pW5aolWEgwxgNSGaJatFbcBQj+rbtZnH29+HNtq61OmwUg4ERIr4r
	R8av2d0x3+Jzcxa0znwHLkI0rsbEcxbPcZ5EBpY44wSeCXHKOTGOr1+0ahyoyhA==
X-Gm-Gg: AYBFou2+y1E7n8nbp3Ewim84mKhMKuflxuUjzO2M7dndya6fsiqR7pnk5sCYdcFyCKS
	DLRXwVrNUx8ZI1yl79uiDkwXQc22tyKZQd1NtRYgE3jCVy/owE0ySqbz7hKL3sg/1lt0JoizcvM
	t2JF6axn6wWMR4rIPjSTUY0cf0pOriztaE/4j4jlTN5MdFMOtTBb1BvCSPhxcyGgn48mXOXaWMR
	f1tpTMDSa/TrlwddU3g+XQLI0ZO3vnNBHsIw2IXxS648e5C7p7FOmuWfjdCtHtFHpgPxbHfCYk0
	+JTbATamLVezaUG1glUXMAb7wmu7yJFmAE4CWRymMXBWHV4c/xxTfNbpN7y4ia7MnrMW6agboOg
	iRa4PKb6DX1WAcQa7cEt9hSvNJaM=
X-Received: by 2002:a05:620a:4493:b0:93f:4498:603a with SMTP id af79cd13be357-93f4c993775mr333472985a.35.1792505849957;
        Tue, 20 Oct 2026 07:17:29 -0700 (PDT)
X-Received: by 2002:a05:620a:4493:b0:93f:4498:603a with SMTP id af79cd13be357-93f4c993775mr333466385a.35.1792505849328;
        Tue, 20 Oct 2026 07:17:29 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:4884:6e9a:d9ff:9fa6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d810043sm6642276f8f.16.2026.10.20.07.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 07:17:28 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, Shuah Khan <shuah@kernel.org>,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v3 0/6] powercap: Add generic hierarchy support and convert DTPM
Date: Tue, 20 Oct 2026 16:16:50 +0200
Message-ID: <cover.1792504834.git.daniel.lezcano@oss.qualcomm.com>
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
X-Proofpoint-GUID: W4_ia8Lad4z-gY0uFHCKu1CP2MK_87ZB
X-Proofpoint-ORIG-GUID: W4_ia8Lad4z-gY0uFHCKu1CP2MK_87ZB
X-Authority-Analysis: v=2.4 cv=EuJHPicA c=1 sm=1 tr=0 ts=6ad777fb cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=q5TblVhm6hz4NYUcPxYA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA1NiBTYWx0ZWRfX1mRMXoa9Cxk6
 2kdxmsD+LNgRCRJrso2AJVlLhiH3ZIgCEI+dR2RW9mWrpSnDOGap+RAScG6h01Kss5aIMICHlHo
 sUUy1vE0rY9ZMKwRCHPfEfT69fNVIuM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA1NiBTYWx0ZWRfX97r9N65mUT8s
 EH0PCHDr57+Eg5X80hriV9dZdsfI11LMFz8izAIEABwRTceqk+YbwI72lw3IUdwz7I/EsmVM4jQ
 54RHdgSAYIAuV5ghl9ul1VPlyammQ7pA3vjBGFjnbw1E4HhNTZTFZ251dUl7EeMOBaooTm3DsZV
 IlSveYo0V/TOLjaHSTXmH3c5rNfdIlsalFjHBl/n97LMmuT/GRTZfK+Qne7UNcNHiIMRDYjUaO7
 Zj+YJ0+wLwEjS4dvJz3IUv/sHTiDd5kmhdKCHqH45JoyQ5Vtb4a14R4BVRWEZeQ/zoQ10OS/LZL
 Ihd+kg3rluLITDxeqEQQ+eOQvVI5Qmr/NFusV5b7NVbMS610Z0EqRvGxqK8xuRErPjA826/Mz3k
 poTtsMks/x+EFg3yWnc2Xh4BztBgFk4vo8ofH4mfvkJ9ZjmOvxplPDqCIcTbp1MavGLnrru5Hec
 dgPmaghMWzyF7+8J7Ng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200056

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
- Correct descriptions of redundant CPU entries and actual sysfs checks;
  add Assisted-by attribution.

Earlier generic hierarchy API and selftest submission:
https://lore.kernel.org/all/20260806110159.69690-1-daniel.lezcano@oss.qualcomm.com/

Assisted-by: LLM

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
 drivers/soc/rockchip/dtpm.c                   | 129 ++++++--
 include/linux/dtpm.h                          |   6 +-
 include/linux/powercap.h                      | 205 ++++++++++++
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/powercap/Kbuild       |   3 +
 tools/testing/selftests/powercap/Makefile     |  27 ++
 .../selftests/powercap/powercap_hierarchy.c   | 305 ++++++++++++++++++
 .../selftests/powercap/powercap_hierarchy.sh  | 126 ++++++++
 12 files changed, 1115 insertions(+), 152 deletions(-)
 create mode 100644 tools/testing/selftests/powercap/Kbuild
 create mode 100644 tools/testing/selftests/powercap/Makefile
 create mode 100644 tools/testing/selftests/powercap/powercap_hierarchy.c
 create mode 100755 tools/testing/selftests/powercap/powercap_hierarchy.sh


base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.43.0

