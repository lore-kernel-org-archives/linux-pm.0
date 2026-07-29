Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFE61CD2C;
	Wed, 29 Jul 2026 06:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785305928; cv=none; b=ieZjS4bhLGxIvU/9u2Jwy482D4Wr8ngM7dJzeQA43Bn7CxNx2+F72iqVGDxTis6B48OBRUvXkhY7LAdSCwI9JL+8M89AqBs84c3IgJlyn4iwMdfsSy23Dv1xvcm6kp2YZ6NVOwiAkonGbnBELyTEaJ6EqCeRNwwfqq+57lvCgMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785305928; c=relaxed/simple;
	bh=vYaO5VnlvKFkWTbg+sX2ud2BCEVXF26ZtZ73uPWOE/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n7tD5hWrdhWvQYFS+MJ9/RAcfDnqDQrPHLWjRCIZuxhkG6QVOTWg8SJ5zo9Zh3rRea5bkI3aMwGssDYEQwp3NJuQjw1AqH9m4C3szni5vpB78sFF78JhbndLPeJdUovM0uuXxMYB9OE4XY3LM/kpTjHP8//pJcUbCSK/+wO5YpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 548c5f728b1511f1aa26b74ffac11d73-20260729
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
X-CID-O-INFO: VERSION:1.3.12,REQID:c353c405-1e10-44a5-8c38-506e4490baea,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:c353c405-1e10-44a5-8c38-506e4490baea,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:1aa105fb04bc06f540ae16ee07cd9dd9,BulkI
	D:260729141839ZU4XV3RH,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bu
	lk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 548c5f728b1511f1aa26b74ffac11d73-20260729
X-User: tianyaxiong@kylinos.cn
Received: from tian-x86.. [(106.16.184.249)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1377504995; Wed, 29 Jul 2026 14:18:35 +0800
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
Subject: [PATCH v2 5/6] selftests/cpuidle: add latency_req QoS idle-state selection test
Date: Wed, 29 Jul 2026 14:18:32 +0800
Message-ID: <20260729061832.14909-1-tianyaxiong@kylinos.cn>
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

Verify that CPU latency, wakeup latency, and per-CPU resume latency
QoS ceilings prevent governors from selecting idle states whose exit
latency exceeds the constraint, by comparing cpuidle state usage
deltas under each QoS path.  Run unconstrained baselines at the start
and end so a stuck latency_req of 0 cannot hide behind constrained
cases alone.

Share common helpers in cpuidle_lib.py for later cpuidle selftests.

Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/cpuidle/Makefile      |   7 +
 tools/testing/selftests/cpuidle/config        |   3 +
 .../cpuidle/cpuidle_latency_req_qos.py        | 280 ++++++++++++++++++
 .../testing/selftests/cpuidle/cpuidle_lib.py  | 226 ++++++++++++++
 tools/testing/selftests/cpuidle/settings      |   2 +
 6 files changed, 519 insertions(+)
 create mode 100644 tools/testing/selftests/cpuidle/Makefile
 create mode 100644 tools/testing/selftests/cpuidle/config
 create mode 100755 tools/testing/selftests/cpuidle/cpuidle_latency_req_qos.py
 create mode 100755 tools/testing/selftests/cpuidle/cpuidle_lib.py
 create mode 100644 tools/testing/selftests/cpuidle/settings

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 74183c27f6e3..83b2d57ae936 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -13,6 +13,7 @@ TARGETS += clone3
 TARGETS += connector
 TARGETS += core
 TARGETS += cpufreq
+TARGETS += cpuidle
 TARGETS += cpu-hotplug
 TARGETS += damon
 TARGETS += dax
diff --git a/tools/testing/selftests/cpuidle/Makefile b/tools/testing/selftests/cpuidle/Makefile
new file mode 100644
index 000000000000..116afec7fc0f
--- /dev/null
+++ b/tools/testing/selftests/cpuidle/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+all:
+
+TEST_PROGS := cpuidle_latency_req_qos.py
+TEST_FILES := cpuidle_lib.py
+
+include ../lib.mk
diff --git a/tools/testing/selftests/cpuidle/config b/tools/testing/selftests/cpuidle/config
new file mode 100644
index 000000000000..86e8f87d4e62
--- /dev/null
+++ b/tools/testing/selftests/cpuidle/config
@@ -0,0 +1,3 @@
+CONFIG_CPU_IDLE=y
+CONFIG_CPU_IDLE_GOV_MENU=y
+CONFIG_PM_QOS_CPU_SYSTEM_WAKEUP=y
diff --git a/tools/testing/selftests/cpuidle/cpuidle_latency_req_qos.py b/tools/testing/selftests/cpuidle/cpuidle_latency_req_qos.py
new file mode 100755
index 000000000000..ddc81323fa3e
--- /dev/null
+++ b/tools/testing/selftests/cpuidle/cpuidle_latency_req_qos.py
@@ -0,0 +1,280 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""
+cpuidle: verify latency_req QoS ceilings restrict idle-state selection.
+
+Constrains exit latency via each of the three QoS inputs and checks that
+cpuidle states whose exit latency exceeds the ceiling do not gain usage:
+
+  1) /dev/cpu_dma_latency
+  2) /dev/cpu_wakeup_latency
+  3) /sys/devices/system/cpu/cpuN/power/pm_qos_resume_latency_us
+
+Also runs unconstrained (no QoS) baselines at the start and end so a
+broken latency_req cache that falsely returns 0 cannot hide behind the
+constrained cases alone.
+"""
+
+from __future__ import annotations
+
+import os
+import struct
+import sys
+from typing import Dict, List, Optional, Tuple
+
+sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
+import cpuidle_lib as cl
+import ksft
+
+
+DMA_LAT_DEV = "/dev/cpu_dma_latency"
+WAKEUP_LAT_DEV = "/dev/cpu_wakeup_latency"
+
+
+def pick_ceilings(states: Dict[int, cl.IdleState]) -> List[int]:
+	nonzero = sorted({s.latency_us for s in states.values() if s.latency_us > 0})
+	out: List[int] = []
+	if nonzero:
+		out.append(nonzero[0])
+	if len(nonzero) >= 2:
+		mid = (nonzero[0] + nonzero[1]) // 2
+		out.append(mid if mid > nonzero[0] else max(1, nonzero[1] - 1))
+	if len(nonzero) >= 3:
+		out.append((nonzero[1] + nonzero[2]) // 2)
+	seen = set()
+	uniq = []
+	for c in out:
+		if c not in seen and c >= 1:
+			seen.add(c)
+			uniq.append(c)
+	return uniq or [1]
+
+
+def allowed_states(states: Dict[int, cl.IdleState], ceiling: int) -> List[int]:
+	return [i for i, s in states.items() if s.latency_us <= ceiling]
+
+
+def forbidden_states(states: Dict[int, cl.IdleState], ceiling: int) -> List[int]:
+	return [i for i, s in states.items() if s.latency_us > ceiling]
+
+
+def forbidden_violations(states: Dict[int, cl.IdleState], udelta: Dict[int, int],
+			 ceiling: int) -> List[str]:
+	bad = []
+	for i in forbidden_states(states, ceiling):
+		if udelta[i] > 0:
+			s = states[i]
+			bad.append(
+				f"state{i}({s.name},lat={s.latency_us}) usage+={udelta[i]}"
+			)
+	return bad
+
+
+class DmaLatencyGuard:
+	def __init__(self, latency_us: int):
+		self.latency_us = latency_us
+		self.fd = -1
+
+	def __enter__(self):
+		self.fd = os.open(DMA_LAT_DEV, os.O_RDWR)
+		os.write(self.fd, struct.pack("i", int(self.latency_us)))
+		return self
+
+	def __exit__(self, *args):
+		if self.fd >= 0:
+			os.close(self.fd)
+			self.fd = -1
+
+
+class WakeupLatencyGuard:
+	def __init__(self, latency_us: int):
+		self.latency_us = latency_us
+		self.fd = -1
+
+	def __enter__(self):
+		self.fd = os.open(WAKEUP_LAT_DEV, os.O_RDWR)
+		os.write(self.fd, struct.pack("i", int(self.latency_us)))
+		return self
+
+	def __exit__(self, *args):
+		if self.fd >= 0:
+			os.close(self.fd)
+			self.fd = -1
+
+
+class ResumeLatencyGuard:
+	"""Restore pm_qos_resume_latency_us exactly as read (n/a vs 0 differ)."""
+
+	def __init__(self, cpu: int, latency_us: int):
+		self.path = (f"{cl.CPUIDLE_BASE}/cpu{cpu}/power/"
+			     f"pm_qos_resume_latency_us")
+		self.latency_us = latency_us
+		self.prev: Optional[str] = None
+
+	def __enter__(self):
+		self.prev = open(self.path).read().strip()
+		with open(self.path, "w") as f:
+			f.write(f"{int(self.latency_us)}\n")
+		return self
+
+	def __exit__(self, *args):
+		if self.prev is None:
+			return
+		with open(self.path, "w") as f:
+			f.write(f"{self.prev}\n")
+
+
+class NullGuard:
+	"""No-op guard: leave all QoS constraints untouched."""
+
+	def __enter__(self):
+		return self
+
+	def __exit__(self, *args):
+		return False
+
+
+def run_no_qos_case(desc: str, states: Dict[int, cl.IdleState]) -> None:
+	"""Unconstrained idle: expect activity in at least one non-zero-latency state."""
+	ksft.print_msg(f"=== {desc} ===")
+	ksft.print_msg("ceiling=(none)")
+
+	with NullGuard():
+		ud = cl.measure_idle()
+
+	total = sum(ud.values())
+	deep = [i for i, s in states.items()
+		if s.latency_us > 0 and ud[i] > 0]
+
+	cl.print_usage_table(states, ud)
+	ksft.print_msg(
+		f"total_usage+={total} "
+		f"nonzero_latency_entered={cl.fmt_state_list(states, deep)}"
+	)
+
+	if total <= 0:
+		ksft.test_result_fail(f"{desc}: too little idle activity ({total})")
+		return
+	if not deep:
+		ksft.test_result_fail(
+			f"{desc}: no state with latency>0 gained usage "
+			"(latency_req may be stuck at 0)"
+		)
+		return
+	ksft.test_result_pass(desc)
+
+
+def run_case(desc: str, states: Dict[int, cl.IdleState], ceiling: int,
+	     guard) -> None:
+	allow = allowed_states(states, ceiling)
+	forbid = forbidden_states(states, ceiling)
+
+	ksft.print_msg(f"=== {desc} ===")
+	ksft.print_msg(f"ceiling={ceiling}us")
+	ksft.print_msg(f"allowed:   {cl.fmt_state_list(states, allow)}")
+	ksft.print_msg(f"forbidden: {cl.fmt_state_list(states, forbid)}")
+
+	with guard:
+		ud = cl.measure_idle()
+
+	total = sum(ud.values())
+	violations = forbidden_violations(states, ud, ceiling)
+
+	cl.print_usage_table(states, ud, set(forbid))
+	ksft.print_msg(
+		f"total_usage+={total} "
+		f"violations={violations if violations else 'none'}"
+	)
+
+	if total <= 0:
+		ksft.test_result_fail(f"{desc}: too little idle activity ({total})")
+		return
+	if violations:
+		ksft.test_result_fail(f"{desc}: {'; '.join(violations)}")
+		return
+	ksft.test_result_pass(desc)
+
+
+def build_plan(states: Dict[int, cl.IdleState],
+	       ceilings: List[int]) -> List[Tuple[str, int, object]]:
+	"""Return list of (description, ceiling, context-manager factory args)."""
+	cases: List[Tuple[str, int, object]] = []
+
+	have_dma = os.path.exists(DMA_LAT_DEV)
+	have_wakeup = os.path.exists(WAKEUP_LAT_DEV)
+	resume_path = (f"{cl.CPUIDLE_BASE}/cpu{cl.CPU}/power/"
+		       f"pm_qos_resume_latency_us")
+	have_resume = os.path.exists(resume_path)
+
+	for ceiling in ceilings:
+		if have_dma:
+			cases.append(
+				(f"cpu_dma_latency ceiling={ceiling}", ceiling,
+				 ("dma", ceiling))
+			)
+		else:
+			cases.append(
+				(f"cpu_dma_latency ceiling={ceiling}", ceiling,
+				 ("skip", "missing /dev/cpu_dma_latency"))
+			)
+
+		if have_wakeup:
+			cases.append(
+				(f"cpu_wakeup_latency ceiling={ceiling}", ceiling,
+				 ("wakeup", ceiling))
+			)
+		else:
+			cases.append(
+				(f"cpu_wakeup_latency ceiling={ceiling}", ceiling,
+				 ("skip", "missing /dev/cpu_wakeup_latency"))
+			)
+
+		if have_resume:
+			cases.append(
+				(f"pm_qos_resume_latency_us ceiling={ceiling}",
+				 ceiling, ("resume", ceiling))
+			)
+		else:
+			cases.append(
+				(f"pm_qos_resume_latency_us ceiling={ceiling}",
+				 ceiling, ("skip", f"missing {resume_path}"))
+			)
+
+	return cases
+
+
+def main() -> None:
+	ksft.print_header()
+
+	states = cl.require_root_and_cpuidle(min_states=1)
+	cl.log_states(states)
+	cl.warn_preexisting_qos()
+	cl.warn_preexisting_disable(states)
+
+	ceilings = pick_ceilings(states)
+	ksft.print_msg(f"ceilings_us={ceilings}")
+	cases = build_plan(states, ceilings)
+	ksft.set_plan(len(cases) + 2)
+
+	run_no_qos_case("no_qos baseline (start)", states)
+
+	for desc, ceiling, kind in cases:
+		tag, arg = kind[0], kind[1]
+		if tag == "skip":
+			ksft.test_result_skip(f"{desc}: {arg}")
+			continue
+		if tag == "dma":
+			guard = DmaLatencyGuard(arg)
+		elif tag == "wakeup":
+			guard = WakeupLatencyGuard(arg)
+		else:
+			guard = ResumeLatencyGuard(cl.CPU, arg)
+		run_case(desc, states, ceiling, guard)
+
+	run_no_qos_case("no_qos baseline (end)", states)
+
+	ksft.finished()
+
+
+if __name__ == "__main__":
+	main()
diff --git a/tools/testing/selftests/cpuidle/cpuidle_lib.py b/tools/testing/selftests/cpuidle/cpuidle_lib.py
new file mode 100755
index 000000000000..156ff7cd20b5
--- /dev/null
+++ b/tools/testing/selftests/cpuidle/cpuidle_lib.py
@@ -0,0 +1,226 @@
+# SPDX-License-Identifier: GPL-2.0
+"""Shared helpers for cpuidle kselftests."""
+
+from __future__ import annotations
+
+import glob
+import os
+import sys
+import time
+from dataclasses import dataclass
+from typing import Dict, List, Optional, Set
+
+sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)),
+				"..", "kselftest"))
+import ksft
+
+
+CPUIDLE_BASE = "/sys/devices/system/cpu"
+IDLE_SEC = 2.0
+CPU = 0
+
+
+@dataclass
+class IdleState:
+	index: int
+	name: str
+	latency_us: int
+	residency_us: int
+	usage: int
+	time_us: int
+	disable_path: str
+	disable: int
+
+
+def cpuidle_dir(cpu: int = CPU) -> str:
+	return f"{CPUIDLE_BASE}/cpu{cpu}/cpuidle"
+
+
+def read_states(cpu: int = CPU) -> Dict[int, IdleState]:
+	base = cpuidle_dir(cpu)
+	states: Dict[int, IdleState] = {}
+	paths = sorted(
+		glob.glob(f"{base}/state*"),
+		key=lambda p: int(os.path.basename(p).replace("state", "")),
+	)
+	for path in paths:
+		idx = int(os.path.basename(path).replace("state", ""))
+		disable_path = f"{path}/disable"
+		disable = 0
+		if os.path.exists(disable_path):
+			disable = int(open(disable_path).read())
+		else:
+			disable_path = ""
+		states[idx] = IdleState(
+			index=idx,
+			name=open(f"{path}/name").read().strip(),
+			latency_us=int(open(f"{path}/latency").read()),
+			residency_us=int(open(f"{path}/residency").read()),
+			usage=int(open(f"{path}/usage").read()),
+			time_us=int(open(f"{path}/time").read()),
+			disable_path=disable_path,
+			disable=disable,
+		)
+	return states
+
+
+def usage_delta(before: Dict[int, IdleState],
+		after: Dict[int, IdleState]) -> Dict[int, int]:
+	return {i: after[i].usage - before[i].usage for i in before}
+
+
+def idle_on_cpu(seconds: float = IDLE_SEC) -> None:
+	end = time.monotonic() + seconds
+	burn_end = time.monotonic() + min(0.1, seconds / 10)
+	while time.monotonic() < burn_end:
+		pass
+	while time.monotonic() < end:
+		time.sleep(0.05)
+
+
+def measure_idle(cpu: int = CPU,
+		 seconds: float = IDLE_SEC) -> Dict[int, int]:
+	"""Idle briefly and return per-state usage deltas."""
+	time.sleep(0.05)
+	before = read_states(cpu)
+	idle_on_cpu(seconds)
+	after = read_states(cpu)
+	return usage_delta(before, after)
+
+
+def fmt_state_list(states: Dict[int, IdleState], idxs: List[int]) -> str:
+	if not idxs:
+		return "(none)"
+	return ", ".join(
+		f"state{i}:{states[i].name}(lat={states[i].latency_us})"
+		for i in idxs
+	)
+
+
+def print_usage_table(states: Dict[int, IdleState], udelta: Dict[int, int],
+		      forbidden: Optional[Set[int]] = None) -> None:
+	ksft.print_msg(
+		f"{'idx':>3} {'name':<12} {'lat':>6} {'d_usage':>8} {'expect':>8}"
+	)
+	for i in sorted(states):
+		s = states[i]
+		if forbidden is None:
+			expect = "allow"
+		else:
+			expect = "forbid" if i in forbidden else "allow"
+		ksft.print_msg(
+			f"{i:3d} {s.name:<12} {s.latency_us:6d} {udelta[i]:8d} {expect:>8}"
+		)
+
+
+def current_governor() -> str:
+	path = f"{CPUIDLE_BASE}/cpuidle/current_governor"
+	if not os.path.exists(path):
+		return "?"
+	return open(path).read().strip()
+
+
+def require_root_and_cpuidle(min_states: int = 1) -> Dict[int, IdleState]:
+	"""Skip and finish unless root with enough cpuidle states; else return them."""
+	if os.geteuid() != 0:
+		ksft.set_plan(1)
+		ksft.test_result_skip("must run as root")
+		ksft.finished()
+
+	base = cpuidle_dir()
+	if not os.path.isdir(base):
+		ksft.set_plan(1)
+		ksft.test_result_skip(f"no cpuidle sysfs at {base}")
+		ksft.finished()
+
+	states = read_states()
+	if len(states) < min_states:
+		ksft.set_plan(1)
+		ksft.test_result_skip(
+			f"need at least {min_states} cpuidle state(s), got {len(states)}"
+		)
+		ksft.finished()
+
+	return states
+
+
+def log_states(states: Dict[int, IdleState], extra: bool = False) -> None:
+	ksft.print_msg(f"governor={current_governor()} cpu={CPU}")
+	for i in sorted(states):
+		s = states[i]
+		msg = (f"state{i}: {s.name} latency={s.latency_us}us "
+		       f"residency={s.residency_us}us")
+		if extra:
+			msg += f" disable={s.disable}"
+		ksft.print_msg(msg)
+
+
+DMA_LAT_DEV = "/dev/cpu_dma_latency"
+WAKEUP_LAT_DEV = "/dev/cpu_wakeup_latency"
+# Matches PM_QOS_CPU_LATENCY_DEFAULT_VALUE (2000 * USEC_PER_SEC).
+CPU_DMA_LATENCY_DEFAULT = 2000 * 1000000
+# Matches PM_QOS_RESUME_LATENCY_NO_CONSTRAINT / S32_MAX.
+CPU_WAKEUP_LATENCY_DEFAULT = 0x7FFFFFFF
+
+
+def _read_qos_dev_limit(path: str) -> Optional[int]:
+	"""Open QoS miscdev, read aggregate limit (s32), close. None if unavailable."""
+	try:
+		fd = os.open(path, os.O_RDONLY)
+	except OSError:
+		return None
+	try:
+		raw = os.read(fd, 4)
+	finally:
+		os.close(fd)
+	if len(raw) != 4:
+		return None
+	return int.from_bytes(raw, byteorder=sys.byteorder, signed=True)
+
+
+def warn_preexisting_qos(cpu: int = CPU) -> None:
+	"""Remind about preexisting global / per-CPU latency QoS settings."""
+	notes: List[str] = []
+
+	dma = _read_qos_dev_limit(DMA_LAT_DEV)
+	if dma is not None and dma != CPU_DMA_LATENCY_DEFAULT:
+		notes.append(f"/dev/cpu_dma_latency aggregate={dma}us (not default)")
+
+	wake = _read_qos_dev_limit(WAKEUP_LAT_DEV)
+	if wake is not None and wake != CPU_WAKEUP_LATENCY_DEFAULT:
+		notes.append(
+			f"/dev/cpu_wakeup_latency aggregate={wake}us (not default)"
+		)
+
+	resume_path = f"{CPUIDLE_BASE}/cpu{cpu}/power/pm_qos_resume_latency_us"
+	if os.path.exists(resume_path):
+		resume = open(resume_path).read().strip()
+		# "0" means no constraint; "n/a" and positive N are constraints.
+		if resume != "0":
+			notes.append(f"{resume_path}={resume!r}")
+
+	if not notes:
+		ksft.print_msg("preexisting QoS: none (unconstrained)")
+		return
+
+	ksft.print_msg("WARNING: preexisting QoS may affect results:")
+	for n in notes:
+		ksft.print_msg(f"  - {n}")
+	ksft.print_msg("  clear QoS holders / set resume to 0 if needed")
+
+
+def warn_preexisting_disable(states: Dict[int, IdleState]) -> None:
+	"""Remind about preexisting user-disabled idle states."""
+	disabled = [
+		f"state{i}:{s.name}"
+		for i, s in sorted(states.items())
+		if s.disable_path and s.disable != 0
+	]
+	if not disabled:
+		ksft.print_msg("preexisting disable: none")
+		return
+
+	ksft.print_msg("WARNING: preexisting user-disabled states may affect results:")
+	for name in disabled:
+		ksft.print_msg(f"  - {name}")
+	ksft.print_msg("  write 0 to stateX/disable to re-enable if needed")
diff --git a/tools/testing/selftests/cpuidle/settings b/tools/testing/selftests/cpuidle/settings
new file mode 100644
index 000000000000..1d2078f92780
--- /dev/null
+++ b/tools/testing/selftests/cpuidle/settings
@@ -0,0 +1,2 @@
+# QoS ceilings x paths, plus no-QoS baselines.
+timeout=180
-- 
2.43.0

