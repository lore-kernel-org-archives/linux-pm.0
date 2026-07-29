Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3B63A961B;
	Wed, 29 Jul 2026 06:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785305938; cv=none; b=h66IyzYY3Kv8IlekYjVsyaK2EMhIV2NlWt0WeWWxcXii3j9Ho6LbWwM/D5OPd7zuswvFaJBRyt8L7spt2Ki7yR5b+1HrsV96zS26Np88p0cbirOLbVFWM+PIBE16PBCptRdKVUcc5ZPiTrynzYEQq3nYZErZX1rbTZZQE1jMQng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785305938; c=relaxed/simple;
	bh=rMOz9tNCBFm7cV1VsMeyU8NEXZBCS8iWVwHAEyI8zj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NFGe9XoNBkK+tT87fn8Xdry1XEj7MSEQxEhMcFrosoF6vkej8gV0BrSDC2gt8Eoh42ORE+5ugJX0wn7s9tizNxtvaYjI//E8zvXm/lF6OSVwcN3zcPXmLf8Eyq+n+KLrnY/ws2Jp7NueNj2FyRlwR2K6aa/CfbiJ/E/XYGNYjN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 59dc81648b1511f1aa26b74ffac11d73-20260729
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD_SPF, CIE_UNKNOWN, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:da59ef48-c325-4653-aa0d-748f8d93aa2d,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:da59ef48-c325-4653-aa0d-748f8d93aa2d,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:cd6b38ad01831fe32bf65835281ceb14,BulkI
	D:260729141848R6NOSYHN,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bu
	lk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 59dc81648b1511f1aa26b74ffac11d73-20260729
X-User: tianyaxiong@kylinos.cn
Received: from tian-x86.. [(106.16.184.249)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2134096418; Wed, 29 Jul 2026 14:18:44 +0800
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
To: rafael@kernel.org,
	daniel.lezcano@kernel.org,
	christian.loehle@arm.com,
	lenb@kernel.org,
	pavel@kernel.org,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH v2 6/6] selftests/cpuidle: add idle-state disable selftest
Date: Wed, 29 Jul 2026 14:18:40 +0800
Message-ID: <20260729061840.14965-1-tianyaxiong@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729061549.13419-1-tianyaxiong@kylinos.cn>
References: <20260729061549.13419-1-tianyaxiong@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Verify that writing 1 to cpuidle stateX/disable stops that state from
gaining usage while other states continue to idle, then restore the
previous disable value.

Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 tools/testing/selftests/cpuidle/Makefile      |   2 +-
 .../cpuidle/cpuidle_disable_state.py          | 133 ++++++++++++++++++
 tools/testing/selftests/cpuidle/settings      |   2 +-
 3 files changed, 135 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/cpuidle/cpuidle_disable_state.py

diff --git a/tools/testing/selftests/cpuidle/Makefile b/tools/testing/selftests/cpuidle/Makefile
index 116afec7fc0f..0e054199acc5 100644
--- a/tools/testing/selftests/cpuidle/Makefile
+++ b/tools/testing/selftests/cpuidle/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 all:
 
-TEST_PROGS := cpuidle_latency_req_qos.py
+TEST_PROGS := cpuidle_latency_req_qos.py cpuidle_disable_state.py
 TEST_FILES := cpuidle_lib.py
 
 include ../lib.mk
diff --git a/tools/testing/selftests/cpuidle/cpuidle_disable_state.py b/tools/testing/selftests/cpuidle/cpuidle_disable_state.py
new file mode 100755
index 000000000000..72ad5278c53c
--- /dev/null
+++ b/tools/testing/selftests/cpuidle/cpuidle_disable_state.py
@@ -0,0 +1,133 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""
+cpuidle: verify user disable of an idle state blocks selection.
+
+Writes 1 to /sys/devices/system/cpu/cpuN/cpuidle/stateX/disable and checks
+that stateX does not gain usage while other states still idle.
+"""
+
+from __future__ import annotations
+
+import os
+import sys
+from typing import Dict, Optional
+
+sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
+import cpuidle_lib as cl
+import ksft
+
+
+def pick_disable_target(states: Dict[int, cl.IdleState]) -> Optional[int]:
+	"""Prefer deepest user-enabled state; keep at least one shallower enabled."""
+	ordered = sorted(states)
+	if len(ordered) < 2:
+		return None
+	for idx in reversed(ordered):
+		if idx == ordered[0]:
+			continue
+		s = states[idx]
+		if s.disable_path and s.disable == 0:
+			return idx
+	return None
+
+
+class DisableStateGuard:
+	def __init__(self, path: str):
+		self.path = path
+		self.prev: Optional[str] = None
+
+	def __enter__(self):
+		self.prev = open(self.path).read().strip()
+		with open(self.path, "w") as f:
+			f.write("1\n")
+		return self
+
+	def __exit__(self, *args):
+		if self.prev is None:
+			return
+		with open(self.path, "w") as f:
+			f.write(f"{self.prev}\n")
+
+
+def run_disable_case(desc: str, states: Dict[int, cl.IdleState],
+		     target: int) -> None:
+	s = states[target]
+	ksft.print_msg(f"=== {desc} ===")
+	ksft.print_msg(f"disable state{target}:{s.name} (lat={s.latency_us})")
+
+	with DisableStateGuard(s.disable_path):
+		ud = cl.measure_idle()
+
+	total = sum(ud.values())
+	cl.print_usage_table(states, ud, {target})
+	ksft.print_msg(f"total_usage+={total} disabled_usage+={ud[target]}")
+
+	if total <= 0:
+		ksft.test_result_fail(f"{desc}: too little idle activity ({total})")
+		return
+	if ud[target] > 0:
+		ksft.test_result_fail(
+			f"{desc}: state{target}({s.name}) usage+={ud[target]} "
+			"while user-disabled"
+		)
+		return
+	ksft.test_result_pass(desc)
+
+
+def run_reenable_case(desc: str, states: Dict[int, cl.IdleState],
+		      target: int) -> None:
+	"""After restore, confirm disable sysfs is cleared and idle still works."""
+	s = states[target]
+	ksft.print_msg(f"=== {desc} ===")
+	ksft.print_msg(f"re-enabled state{target}:{s.name}")
+
+	ud = cl.measure_idle()
+	total = sum(ud.values())
+	cl.print_usage_table(states, ud)
+	ksft.print_msg(f"total_usage+={total} target_usage+={ud[target]}")
+
+	if total <= 0:
+		ksft.test_result_fail(f"{desc}: too little idle activity ({total})")
+		return
+	cur = int(open(s.disable_path).read())
+	if cur != 0:
+		ksft.test_result_fail(f"{desc}: disable sysfs still {cur}")
+		return
+	ksft.test_result_pass(desc)
+
+
+def main() -> None:
+	ksft.print_header()
+
+	states = cl.require_root_and_cpuidle(min_states=2)
+	# Need disable sysfs on states we might target.
+	states = {i: s for i, s in states.items() if s.disable_path}
+	if len(states) < 2:
+		ksft.set_plan(1)
+		ksft.test_result_skip("need at least 2 cpuidle states with disable")
+		ksft.finished()
+
+	cl.log_states(states, extra=True)
+	cl.warn_preexisting_qos()
+
+	target = pick_disable_target(states)
+	if target is None:
+		ksft.set_plan(1)
+		ksft.test_result_skip("no user-enabled deep state to disable")
+		ksft.finished()
+
+	ksft.set_plan(2)
+	run_disable_case(
+		f"disable state{target} blocks selection", states, target
+	)
+	states = cl.read_states()
+	run_reenable_case(
+		f"restore state{target} disable", states, target
+	)
+
+	ksft.finished()
+
+
+if __name__ == "__main__":
+	main()
diff --git a/tools/testing/selftests/cpuidle/settings b/tools/testing/selftests/cpuidle/settings
index 1d2078f92780..1bbc754b982b 100644
--- a/tools/testing/selftests/cpuidle/settings
+++ b/tools/testing/selftests/cpuidle/settings
@@ -1,2 +1,2 @@
-# QoS ceilings x paths, plus no-QoS baselines.
+# QoS ceilings x paths, no-QoS baselines, plus disable-state windows.
 timeout=180
-- 
2.43.0

