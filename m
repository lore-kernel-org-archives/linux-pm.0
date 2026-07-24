Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45E524A06D;
	Fri, 24 Jul 2026 03:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784863872; cv=none; b=R6yPjjXsA2yBPfsblDJr51GpAQBA6yaKVGPI2x7BZoVXJtnSuaAMaD4YSqFGfj0BXHYmWkpUoAsZkS252rWANKWKsGKjllyL0+YjHk5wcfc5PFPPwYkuqunJDWF9Vs7147BlFAq6p3qG9EybFhKXN8HF4ALJa69OIX4B3hr8c9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784863872; c=relaxed/simple;
	bh=5Y9MdqjvxzHU1UPcHboNfcbpc0XclLaTkRs1B2QGXaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PWnSO+oocGmATj1AkFRBIHBuwOvfobjLVk89IlDc1fOa9AhJd1xdLVBR7oigLA7y6vuE4Ohm4ClX84NX6h5Xnpu9K28LPHAxuZM61okmiAL57Z0o02bEAgShxC+uOqU823YaPReCWP8z3SZ+Akb1a3tCGiuXabaDDlXtvsCU47Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 188b0f22871011f1aa26b74ffac11d73-20260724
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:2b37c958-4a85-449d-bcdc-2dd19d3f367a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:0a358f23e3be41b23995e091dfc515cc,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0
	|15|52,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 188b0f22871011f1aa26b74ffac11d73-20260724
X-User: tianyaxiong@kylinos.cn
Received: from [10.42.13.21] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1547600100; Fri, 24 Jul 2026 11:31:02 +0800
Message-ID: <23093125-0594-4135-a377-bf2ea8fbe1c8@kylinos.cn>
Date: Fri, 24 Jul 2026 11:31:00 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] selftests/cpuidle: add latency_req QoS idle-state
 selection test
To: Christian Loehle <christian.loehle@arm.com>, rafael@kernel.org,
 daniel.lezcano@kernel.org, lenb@kernel.org, pavel@kernel.org,
 shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260721092324.17508-1-tianyaxiong@kylinos.cn>
 <20260721092608.18973-1-tianyaxiong@kylinos.cn>
 <76302363-4a2e-403f-a72e-ee250aadee9c@arm.com>
Content-Language: en-US
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
In-Reply-To: <76302363-4a2e-403f-a72e-ee250aadee9c@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/7/23 20:51, Christian Loehle 写道:
> On 7/21/26 10:26, Yaxiong Tian wrote:
>> Verify that CPU latency, wakeup latency, and per-CPU resume latency
>> QoS ceilings prevent governors from selecting idle states whose exit
>> latency exceeds the constraint, by comparing cpuidle state usage
>> deltas under each QoS path.
>>
>> USE:
>> sudo make -C tools/testing/selftests TARGETS=cpuidle run_tests
> FWIW since you're mostly there anyway, can you extend this to cover cpuidle
> state disable too? Ideally also interaction between disable and latency_req.
> I think that would be quite useful.
Of course.I'll add it in the next version.
>
>> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
>> ---
>>   tools/testing/selftests/Makefile              |   1 +
>>   tools/testing/selftests/cpuidle/Makefile      |   6 +
>>   tools/testing/selftests/cpuidle/config        |   3 +
>>   .../cpuidle/cpuidle_latency_req_qos.py        | 331 ++++++++++++++++++
>>   tools/testing/selftests/cpuidle/settings      |   2 +
>>   5 files changed, 343 insertions(+)
>>   create mode 100644 tools/testing/selftests/cpuidle/Makefile
>>   create mode 100644 tools/testing/selftests/cpuidle/config
>>   create mode 100755 tools/testing/selftests/cpuidle/cpuidle_latency_req_qos.py
>>   create mode 100644 tools/testing/selftests/cpuidle/settings
>>
>> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
>> index 8189f333814c..a8fb620bebd1 100644
>> --- a/tools/testing/selftests/Makefile
>> +++ b/tools/testing/selftests/Makefile
>> @@ -12,6 +12,7 @@ TARGETS += clone3
>>   TARGETS += connector
>>   TARGETS += core
>>   TARGETS += cpufreq
>> +TARGETS += cpuidle
>>   TARGETS += cpu-hotplug
>>   TARGETS += damon
>>   TARGETS += devices/error_logs
>> diff --git a/tools/testing/selftests/cpuidle/Makefile b/tools/testing/selftests/cpuidle/Makefile
>> new file mode 100644
>> index 000000000000..f960d72c3a65
>> --- /dev/null
>> +++ b/tools/testing/selftests/cpuidle/Makefile
>> @@ -0,0 +1,6 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +all:
>> +
>> +TEST_PROGS := cpuidle_latency_req_qos.py
>> +
>> +include ../lib.mk
>> diff --git a/tools/testing/selftests/cpuidle/config b/tools/testing/selftests/cpuidle/config
>> new file mode 100644
>> index 000000000000..86e8f87d4e62
>> --- /dev/null
>> +++ b/tools/testing/selftests/cpuidle/config
>> @@ -0,0 +1,3 @@
>> +CONFIG_CPU_IDLE=y
>> +CONFIG_CPU_IDLE_GOV_MENU=y
>> +CONFIG_PM_QOS_CPU_SYSTEM_WAKEUP=y
>> diff --git a/tools/testing/selftests/cpuidle/cpuidle_latency_req_qos.py b/tools/testing/selftests/cpuidle/cpuidle_latency_req_qos.py
>> new file mode 100755
>> index 000000000000..875b623da530
>> --- /dev/null
>> +++ b/tools/testing/selftests/cpuidle/cpuidle_latency_req_qos.py
>> @@ -0,0 +1,331 @@
>> +#!/usr/bin/env python3
>> +# SPDX-License-Identifier: GPL-2.0
>> +"""
>> +cpuidle: verify latency_req QoS ceilings restrict idle-state selection.
>> +
>> +Constrains exit latency via each of the three QoS inputs and checks that
>> +cpuidle states whose exit latency exceeds the ceiling do not gain usage:
>> +
>> +  1) /dev/cpu_dma_latency
>> +  2) /dev/cpu_wakeup_latency
>> +  3) /sys/devices/system/cpu/cpuN/power/pm_qos_resume_latency_us
>> +"""
>> +
>> +from __future__ import annotations
>> +
>> +import glob
>> +import os
>> +import struct
>> +import sys
>> +import time
>> +from dataclasses import dataclass
>> +from typing import Dict, List, Optional, Tuple
>> +
>> +# Source tree: tools/testing/selftests/cpuidle/../kselftest
>> +# Install tree: kselftest_install/cpuidle/../kselftest
>> +sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)),
>> +				"..", "kselftest"))
>> +import ksft
>> +
>> +
>> +CPUIDLE_BASE = "/sys/devices/system/cpu"
>> +DMA_LAT_DEV = "/dev/cpu_dma_latency"
>> +WAKEUP_LAT_DEV = "/dev/cpu_wakeup_latency"
>> +
>> +# Keep windows short so the whole collection fits under settings timeout.
>> +IDLE_SEC = 2.0
>> +CPU = 0
>> +
>> +
>> +@dataclass
>> +class IdleState:
>> +	index: int
>> +	name: str
>> +	latency_us: int
>> +	residency_us: int
>> +	usage: int
>> +	time_us: int
>> +
>> +
>> +def read_states(cpu: int) -> Dict[int, IdleState]:
>> +	base = f"{CPUIDLE_BASE}/cpu{cpu}/cpuidle"
>> +	states: Dict[int, IdleState] = {}
>> +	paths = sorted(
>> +		glob.glob(f"{base}/state*"),
>> +		key=lambda p: int(os.path.basename(p).replace("state", "")),
>> +	)
>> +	for path in paths:
>> +		idx = int(os.path.basename(path).replace("state", ""))
>> +		states[idx] = IdleState(
>> +			index=idx,
>> +			name=open(f"{path}/name").read().strip(),
>> +			latency_us=int(open(f"{path}/latency").read()),
>> +			residency_us=int(open(f"{path}/residency").read()),
>> +			usage=int(open(f"{path}/usage").read()),
>> +			time_us=int(open(f"{path}/time").read()),
>> +		)
>> +	return states
>> +
>> +
>> +def usage_delta(before: Dict[int, IdleState],
>> +		after: Dict[int, IdleState]) -> Dict[int, int]:
>> +	return {i: after[i].usage - before[i].usage for i in before}
>> +
>> +
>> +def pick_ceilings(states: Dict[int, IdleState]) -> List[int]:
>> +	nonzero = sorted({s.latency_us for s in states.values() if s.latency_us > 0})
>> +	out: List[int] = []
>> +	if nonzero:
>> +		out.append(nonzero[0])
>> +	if len(nonzero) >= 2:
>> +		mid = (nonzero[0] + nonzero[1]) // 2
>> +		out.append(mid if mid > nonzero[0] else max(1, nonzero[1] - 1))
>> +	if len(nonzero) >= 3:
>> +		out.append((nonzero[1] + nonzero[2]) // 2)
>> +	# Dedup, keep order
>> +	seen = set()
>> +	uniq = []
>> +	for c in out:
>> +		if c not in seen and c >= 1:
>> +			seen.add(c)
>> +			uniq.append(c)
>> +	return uniq or [1]
>> +
>> +
>> +def idle_on_cpu(seconds: float) -> None:
>> +	end = time.monotonic() + seconds
>> +	burn_end = time.monotonic() + min(0.1, seconds / 10)
>> +	while time.monotonic() < burn_end:
>> +		pass
>> +	while time.monotonic() < end:
>> +		time.sleep(0.05)
>> +
>> +
>> +def allowed_states(states: Dict[int, IdleState], ceiling: int) -> List[int]:
>> +	return [i for i, s in states.items() if s.latency_us <= ceiling]
>> +
>> +
>> +def forbidden_states(states: Dict[int, IdleState], ceiling: int) -> List[int]:
>> +	return [i for i, s in states.items() if s.latency_us > ceiling]
>> +
>> +
>> +def fmt_state_list(states: Dict[int, IdleState], idxs: List[int]) -> str:
>> +	if not idxs:
>> +		return "(none)"
>> +	return ", ".join(
>> +		f"state{i}:{states[i].name}(lat={states[i].latency_us})"
>> +		for i in idxs
>> +	)
>> +
>> +
>> +def forbidden_violations(states: Dict[int, IdleState], udelta: Dict[int, int],
>> +			 ceiling: int) -> List[str]:
>> +	"""States that must not be entered but still gained usage."""
>> +	bad = []
>> +	for i in forbidden_states(states, ceiling):
>> +		if udelta[i] > 0:
>> +			s = states[i]
>> +			bad.append(
>> +				f"state{i}({s.name},lat={s.latency_us}) usage+={udelta[i]}"
>> +			)
>> +	return bad
>> +
>> +
>> +def print_usage_table(states: Dict[int, IdleState], udelta: Dict[int, int],
>> +		      ceiling: int) -> None:
>> +	ksft.print_msg(
>> +		f"{'idx':>3} {'name':<12} {'lat':>6} {'d_usage':>8} {'expect':>8}"
>> +	)
>> +	for i in sorted(states):
>> +		s = states[i]
>> +		expect = "allow" if s.latency_us <= ceiling else "forbid"
>> +		ksft.print_msg(
>> +			f"{i:3d} {s.name:<12} {s.latency_us:6d} {udelta[i]:8d} {expect:>8}"
>> +		)
>> +
>> +
>> +class DmaLatencyGuard:
>> +	def __init__(self, latency_us: int):
>> +		self.latency_us = latency_us
>> +		self.fd = -1
>> +
>> +	def __enter__(self):
>> +		self.fd = os.open(DMA_LAT_DEV, os.O_RDWR)
>> +		os.write(self.fd, struct.pack("i", int(self.latency_us)))
>> +		return self
>> +
>> +	def __exit__(self, *args):
>> +		if self.fd >= 0:
>> +			os.close(self.fd)
>> +			self.fd = -1
>> +
>> +
>> +class WakeupLatencyGuard:
>> +	def __init__(self, latency_us: int):
>> +		self.latency_us = latency_us
>> +		self.fd = -1
>> +
>> +	def __enter__(self):
>> +		self.fd = os.open(WAKEUP_LAT_DEV, os.O_RDWR)
>> +		os.write(self.fd, struct.pack("i", int(self.latency_us)))
>> +		return self
>> +
>> +	def __exit__(self, *args):
>> +		if self.fd >= 0:
>> +			os.close(self.fd)
>> +			self.fd = -1
>> +
>> +
>> +class ResumeLatencyGuard:
>> +	def __init__(self, cpu: int, latency_us: int):
>> +		self.path = f"{CPUIDLE_BASE}/cpu{cpu}/power/pm_qos_resume_latency_us"
>> +		self.latency_us = latency_us
>> +		self.prev: Optional[str] = None
>> +
>> +	def __enter__(self):
>> +		self.prev = open(self.path).read().strip()
>> +		with open(self.path, "w") as f:
>> +			f.write(f"{int(self.latency_us)}\n")
>> +		return self
>> +
>> +	def __exit__(self, *args):
>> +		restore = "0" if self.prev in ("0", "n/a", None) else self.prev
> See pm_qos_resume_latency_us_store(), n/a and 0 are distinct.
Yes, normalizing n/a to 0 is wrong. I will remove this logic.
>
>> +		with open(self.path, "w") as f:
>> +			f.write(f"{restore}\n")
>> +
>> +
>> +def run_case(desc: str, states: Dict[int, IdleState], ceiling: int,
>> +	     guard) -> None:
>> +	allow = allowed_states(states, ceiling)
>> +	forbid = forbidden_states(states, ceiling)
>> +
>> +	ksft.print_msg(f"=== {desc} ===")
>> +	ksft.print_msg(f"ceiling={ceiling}us")
>> +	ksft.print_msg(f"allowed:   {fmt_state_list(states, allow)}")
>> +	ksft.print_msg(f"forbidden: {fmt_state_list(states, forbid)}")
>> +
>> +	with guard:
>> +		time.sleep(0.05)
>> +		before = read_states(CPU)
>> +		idle_on_cpu(IDLE_SEC)
>> +		after = read_states(CPU)
>> +
>> +	ud = usage_delta(before, after)
>> +	total = sum(ud.values())
>> +	violations = forbidden_violations(states, ud, ceiling)
>> +
>> +	print_usage_table(states, ud, ceiling)
>> +	ksft.print_msg(
>> +		f"total_usage+={total} "
>> +		f"violations={violations if violations else 'none'}"
>> +	)
>> +
>> +	if total <= 0:
>> +		ksft.test_result_fail(f"{desc}: too little idle activity ({total})")
>> +		return
>> +	if violations:
>> +		ksft.test_result_fail(f"{desc}: {'; '.join(violations)}")
>> +		return
>> +	ksft.test_result_pass(desc)
>> +
>> +
>> +def build_plan(states: Dict[int, IdleState],
>> +	       ceilings: List[int]) -> List[Tuple[str, int, object]]:
>> +	"""Return list of (description, ceiling, context-manager factory args)."""
>> +	cases: List[Tuple[str, int, object]] = []
>> +
>> +	have_dma = os.path.exists(DMA_LAT_DEV)
>> +	have_wakeup = os.path.exists(WAKEUP_LAT_DEV)
>> +	resume_path = f"{CPUIDLE_BASE}/cpu{CPU}/power/pm_qos_resume_latency_us"
>> +	have_resume = os.path.exists(resume_path)
>> +
>> +	for ceiling in ceilings:
>> +		if have_dma:
>> +			cases.append(
>> +				(f"cpu_dma_latency ceiling={ceiling}", ceiling,
>> +				 ("dma", ceiling))
>> +			)
>> +		else:
>> +			cases.append(
>> +				(f"cpu_dma_latency ceiling={ceiling}", ceiling,
>> +				 ("skip", "missing /dev/cpu_dma_latency"))
>> +			)
>> +
>> +		if have_wakeup:
>> +			cases.append(
>> +				(f"cpu_wakeup_latency ceiling={ceiling}", ceiling,
>> +				 ("wakeup", ceiling))
>> +			)
>> +		else:
>> +			cases.append(
>> +				(f"cpu_wakeup_latency ceiling={ceiling}", ceiling,
>> +				 ("skip", "missing /dev/cpu_wakeup_latency"))
>> +			)
>> +
>> +		if have_resume:
>> +			cases.append(
>> +				(f"pm_qos_resume_latency_us ceiling={ceiling}",
>> +				 ceiling, ("resume", ceiling))
>> +			)
>> +		else:
>> +			cases.append(
>> +				(f"pm_qos_resume_latency_us ceiling={ceiling}",
>> +				 ceiling, ("skip", f"missing {resume_path}"))
>> +			)
>> +
>> +	return cases
>> +
>> +
>> +def main() -> None:
>> +	ksft.print_header()
>> +
>> +	if os.geteuid() != 0:
>> +		ksft.set_plan(1)
>> +		ksft.test_result_skip("must run as root")
>> +		ksft.finished()
>> +
>> +	cpuidle_dir = f"{CPUIDLE_BASE}/cpu{CPU}/cpuidle"
>> +	if not os.path.isdir(cpuidle_dir):
>> +		ksft.set_plan(1)
>> +		ksft.test_result_skip(f"no cpuidle sysfs at {cpuidle_dir}")
>> +		ksft.finished()
>> +
>> +	states = read_states(CPU)
>> +	if not states:
>> +		ksft.set_plan(1)
>> +		ksft.test_result_skip("no cpuidle states")
>> +		ksft.finished()
>> +
>> +	gov_path = f"{CPUIDLE_BASE}/cpuidle/current_governor"
>> +	gov = open(gov_path).read().strip() if os.path.exists(gov_path) else "?"
>> +	ksft.print_msg(f"governor={gov} cpu={CPU}")
>> +	for i in sorted(states):
>> +		s = states[i]
>> +		ksft.print_msg(
>> +			f"state{i}: {s.name} latency={s.latency_us}us "
>> +			f"residency={s.residency_us}us"
>> +		)
>> +
>> +	ceilings = pick_ceilings(states)
>> +	ksft.print_msg(f"ceilings_us={ceilings}")
>> +	cases = build_plan(states, ceilings)
>> +	ksft.set_plan(len(cases))
>> +
>> +	for desc, ceiling, kind in cases:
>> +		tag, arg = kind[0], kind[1]
>> +		if tag == "skip":
>> +			ksft.test_result_skip(f"{desc}: {arg}")
>> +			continue
>> +		if tag == "dma":
>> +			guard = DmaLatencyGuard(arg)
>> +		elif tag == "wakeup":
>> +			guard = WakeupLatencyGuard(arg)
>> +		else:
>> +			guard = ResumeLatencyGuard(CPU, arg)
>> +		run_case(desc, states, ceiling, guard)
>> +
>> +	ksft.finished()
>> +
>> +
>> +if __name__ == "__main__":
>> +	main()
>> diff --git a/tools/testing/selftests/cpuidle/settings b/tools/testing/selftests/cpuidle/settings
>> new file mode 100644
>> index 000000000000..5b445e716562
>> --- /dev/null
>> +++ b/tools/testing/selftests/cpuidle/settings
>> @@ -0,0 +1,2 @@
>> +# Multiple QoS paths x several latency ceilings x idle windows.
>> +timeout=180
