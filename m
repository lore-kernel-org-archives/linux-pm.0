Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8622848BD40;
	Thu, 23 Jul 2026 12:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784811124; cv=none; b=ZLyD0MFV6pDwm63iwWgzukSzwZVtPOXMxp8WxwkS2RrT45cz8yqq+BOrW8BhMMgmP3j1xJm924zFweLFGmjsyIIDs2NcZNLkkF+k1pNf1gB8xm2oVA2biwNAni4wn6pqR5lIPeKYI+ssMRu/NI5UpfKkqOdGJTKATXLjBNuYr7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784811124; c=relaxed/simple;
	bh=mOZ0TJX6e8rqLNiCsPM84CE6kX8FLgk4/HwFxbewc94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f1wYtJc8JI6/mlYW9tMGAKj2OQkrxNbVaM94klmO7lRG635Z62HwXs4NvhNFSHXHwNWo1fdP9/S273hW181T3IU0cfsjNFFkVgU4Ds/ASFcXECL/A+Mnz85JsobxKFvcnm6jJDzOUc95/eS/Fum6nP1frzdib5eLjky1TY6Seqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=r2oFS7Ii; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="r2oFS7Ii"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78BD61477;
	Thu, 23 Jul 2026 05:51:57 -0700 (PDT)
Received: from [10.1.39.91] (e127648.arm.com [10.1.39.91])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50F2F3F59E;
	Thu, 23 Jul 2026 05:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784811121; bh=mOZ0TJX6e8rqLNiCsPM84CE6kX8FLgk4/HwFxbewc94=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r2oFS7IiqCS68Y+4vAKtN3RLFaboKMaU0iIfYaYqM/5H6z5SL+65CSJnSj3mx0WY2
	 vmby9EKmKpidwmm0gl+y3SWWxdPXQf1SG6/uLOmjHmQGWNpRR/M32IQCga7PB+lNyD
	 JmRtVhwk6PXVQgsEo8WomSlV2Au+LqkptX4cu5Bw=
Message-ID: <76302363-4a2e-403f-a72e-ee250aadee9c@arm.com>
Date: Thu, 23 Jul 2026 13:51:57 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] selftests/cpuidle: add latency_req QoS idle-state
 selection test
To: Yaxiong Tian <tianyaxiong@kylinos.cn>, rafael@kernel.org,
 daniel.lezcano@kernel.org, lenb@kernel.org, pavel@kernel.org,
 shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260721092324.17508-1-tianyaxiong@kylinos.cn>
 <20260721092608.18973-1-tianyaxiong@kylinos.cn>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260721092608.18973-1-tianyaxiong@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/21/26 10:26, Yaxiong Tian wrote:
> Verify that CPU latency, wakeup latency, and per-CPU resume latency
> QoS ceilings prevent governors from selecting idle states whose exit
> latency exceeds the constraint, by comparing cpuidle state usage
> deltas under each QoS path.
> 
> USE:
> sudo make -C tools/testing/selftests TARGETS=cpuidle run_tests

FWIW since you're mostly there anyway, can you extend this to cover cpuidle
state disable too? Ideally also interaction between disable and latency_req.
I think that would be quite useful.

> 
> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
> ---
>  tools/testing/selftests/Makefile              |   1 +
>  tools/testing/selftests/cpuidle/Makefile      |   6 +
>  tools/testing/selftests/cpuidle/config        |   3 +
>  .../cpuidle/cpuidle_latency_req_qos.py        | 331 ++++++++++++++++++
>  tools/testing/selftests/cpuidle/settings      |   2 +
>  5 files changed, 343 insertions(+)
>  create mode 100644 tools/testing/selftests/cpuidle/Makefile
>  create mode 100644 tools/testing/selftests/cpuidle/config
>  create mode 100755 tools/testing/selftests/cpuidle/cpuidle_latency_req_qos.py
>  create mode 100644 tools/testing/selftests/cpuidle/settings
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 8189f333814c..a8fb620bebd1 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -12,6 +12,7 @@ TARGETS += clone3
>  TARGETS += connector
>  TARGETS += core
>  TARGETS += cpufreq
> +TARGETS += cpuidle
>  TARGETS += cpu-hotplug
>  TARGETS += damon
>  TARGETS += devices/error_logs
> diff --git a/tools/testing/selftests/cpuidle/Makefile b/tools/testing/selftests/cpuidle/Makefile
> new file mode 100644
> index 000000000000..f960d72c3a65
> --- /dev/null
> +++ b/tools/testing/selftests/cpuidle/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +all:
> +
> +TEST_PROGS := cpuidle_latency_req_qos.py
> +
> +include ../lib.mk
> diff --git a/tools/testing/selftests/cpuidle/config b/tools/testing/selftests/cpuidle/config
> new file mode 100644
> index 000000000000..86e8f87d4e62
> --- /dev/null
> +++ b/tools/testing/selftests/cpuidle/config
> @@ -0,0 +1,3 @@
> +CONFIG_CPU_IDLE=y
> +CONFIG_CPU_IDLE_GOV_MENU=y
> +CONFIG_PM_QOS_CPU_SYSTEM_WAKEUP=y
> diff --git a/tools/testing/selftests/cpuidle/cpuidle_latency_req_qos.py b/tools/testing/selftests/cpuidle/cpuidle_latency_req_qos.py
> new file mode 100755
> index 000000000000..875b623da530
> --- /dev/null
> +++ b/tools/testing/selftests/cpuidle/cpuidle_latency_req_qos.py
> @@ -0,0 +1,331 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +"""
> +cpuidle: verify latency_req QoS ceilings restrict idle-state selection.
> +
> +Constrains exit latency via each of the three QoS inputs and checks that
> +cpuidle states whose exit latency exceeds the ceiling do not gain usage:
> +
> +  1) /dev/cpu_dma_latency
> +  2) /dev/cpu_wakeup_latency
> +  3) /sys/devices/system/cpu/cpuN/power/pm_qos_resume_latency_us
> +"""
> +
> +from __future__ import annotations
> +
> +import glob
> +import os
> +import struct
> +import sys
> +import time
> +from dataclasses import dataclass
> +from typing import Dict, List, Optional, Tuple
> +
> +# Source tree: tools/testing/selftests/cpuidle/../kselftest
> +# Install tree: kselftest_install/cpuidle/../kselftest
> +sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)),
> +				"..", "kselftest"))
> +import ksft
> +
> +
> +CPUIDLE_BASE = "/sys/devices/system/cpu"
> +DMA_LAT_DEV = "/dev/cpu_dma_latency"
> +WAKEUP_LAT_DEV = "/dev/cpu_wakeup_latency"
> +
> +# Keep windows short so the whole collection fits under settings timeout.
> +IDLE_SEC = 2.0
> +CPU = 0
> +
> +
> +@dataclass
> +class IdleState:
> +	index: int
> +	name: str
> +	latency_us: int
> +	residency_us: int
> +	usage: int
> +	time_us: int
> +
> +
> +def read_states(cpu: int) -> Dict[int, IdleState]:
> +	base = f"{CPUIDLE_BASE}/cpu{cpu}/cpuidle"
> +	states: Dict[int, IdleState] = {}
> +	paths = sorted(
> +		glob.glob(f"{base}/state*"),
> +		key=lambda p: int(os.path.basename(p).replace("state", "")),
> +	)
> +	for path in paths:
> +		idx = int(os.path.basename(path).replace("state", ""))
> +		states[idx] = IdleState(
> +			index=idx,
> +			name=open(f"{path}/name").read().strip(),
> +			latency_us=int(open(f"{path}/latency").read()),
> +			residency_us=int(open(f"{path}/residency").read()),
> +			usage=int(open(f"{path}/usage").read()),
> +			time_us=int(open(f"{path}/time").read()),
> +		)
> +	return states
> +
> +
> +def usage_delta(before: Dict[int, IdleState],
> +		after: Dict[int, IdleState]) -> Dict[int, int]:
> +	return {i: after[i].usage - before[i].usage for i in before}
> +
> +
> +def pick_ceilings(states: Dict[int, IdleState]) -> List[int]:
> +	nonzero = sorted({s.latency_us for s in states.values() if s.latency_us > 0})
> +	out: List[int] = []
> +	if nonzero:
> +		out.append(nonzero[0])
> +	if len(nonzero) >= 2:
> +		mid = (nonzero[0] + nonzero[1]) // 2
> +		out.append(mid if mid > nonzero[0] else max(1, nonzero[1] - 1))
> +	if len(nonzero) >= 3:
> +		out.append((nonzero[1] + nonzero[2]) // 2)
> +	# Dedup, keep order
> +	seen = set()
> +	uniq = []
> +	for c in out:
> +		if c not in seen and c >= 1:
> +			seen.add(c)
> +			uniq.append(c)
> +	return uniq or [1]
> +
> +
> +def idle_on_cpu(seconds: float) -> None:
> +	end = time.monotonic() + seconds
> +	burn_end = time.monotonic() + min(0.1, seconds / 10)
> +	while time.monotonic() < burn_end:
> +		pass
> +	while time.monotonic() < end:
> +		time.sleep(0.05)
> +
> +
> +def allowed_states(states: Dict[int, IdleState], ceiling: int) -> List[int]:
> +	return [i for i, s in states.items() if s.latency_us <= ceiling]
> +
> +
> +def forbidden_states(states: Dict[int, IdleState], ceiling: int) -> List[int]:
> +	return [i for i, s in states.items() if s.latency_us > ceiling]
> +
> +
> +def fmt_state_list(states: Dict[int, IdleState], idxs: List[int]) -> str:
> +	if not idxs:
> +		return "(none)"
> +	return ", ".join(
> +		f"state{i}:{states[i].name}(lat={states[i].latency_us})"
> +		for i in idxs
> +	)
> +
> +
> +def forbidden_violations(states: Dict[int, IdleState], udelta: Dict[int, int],
> +			 ceiling: int) -> List[str]:
> +	"""States that must not be entered but still gained usage."""
> +	bad = []
> +	for i in forbidden_states(states, ceiling):
> +		if udelta[i] > 0:
> +			s = states[i]
> +			bad.append(
> +				f"state{i}({s.name},lat={s.latency_us}) usage+={udelta[i]}"
> +			)
> +	return bad
> +
> +
> +def print_usage_table(states: Dict[int, IdleState], udelta: Dict[int, int],
> +		      ceiling: int) -> None:
> +	ksft.print_msg(
> +		f"{'idx':>3} {'name':<12} {'lat':>6} {'d_usage':>8} {'expect':>8}"
> +	)
> +	for i in sorted(states):
> +		s = states[i]
> +		expect = "allow" if s.latency_us <= ceiling else "forbid"
> +		ksft.print_msg(
> +			f"{i:3d} {s.name:<12} {s.latency_us:6d} {udelta[i]:8d} {expect:>8}"
> +		)
> +
> +
> +class DmaLatencyGuard:
> +	def __init__(self, latency_us: int):
> +		self.latency_us = latency_us
> +		self.fd = -1
> +
> +	def __enter__(self):
> +		self.fd = os.open(DMA_LAT_DEV, os.O_RDWR)
> +		os.write(self.fd, struct.pack("i", int(self.latency_us)))
> +		return self
> +
> +	def __exit__(self, *args):
> +		if self.fd >= 0:
> +			os.close(self.fd)
> +			self.fd = -1
> +
> +
> +class WakeupLatencyGuard:
> +	def __init__(self, latency_us: int):
> +		self.latency_us = latency_us
> +		self.fd = -1
> +
> +	def __enter__(self):
> +		self.fd = os.open(WAKEUP_LAT_DEV, os.O_RDWR)
> +		os.write(self.fd, struct.pack("i", int(self.latency_us)))
> +		return self
> +
> +	def __exit__(self, *args):
> +		if self.fd >= 0:
> +			os.close(self.fd)
> +			self.fd = -1
> +
> +
> +class ResumeLatencyGuard:
> +	def __init__(self, cpu: int, latency_us: int):
> +		self.path = f"{CPUIDLE_BASE}/cpu{cpu}/power/pm_qos_resume_latency_us"
> +		self.latency_us = latency_us
> +		self.prev: Optional[str] = None
> +
> +	def __enter__(self):
> +		self.prev = open(self.path).read().strip()
> +		with open(self.path, "w") as f:
> +			f.write(f"{int(self.latency_us)}\n")
> +		return self
> +
> +	def __exit__(self, *args):
> +		restore = "0" if self.prev in ("0", "n/a", None) else self.prev

See pm_qos_resume_latency_us_store(), n/a and 0 are distinct.

> +		with open(self.path, "w") as f:
> +			f.write(f"{restore}\n")
> +
> +
> +def run_case(desc: str, states: Dict[int, IdleState], ceiling: int,
> +	     guard) -> None:
> +	allow = allowed_states(states, ceiling)
> +	forbid = forbidden_states(states, ceiling)
> +
> +	ksft.print_msg(f"=== {desc} ===")
> +	ksft.print_msg(f"ceiling={ceiling}us")
> +	ksft.print_msg(f"allowed:   {fmt_state_list(states, allow)}")
> +	ksft.print_msg(f"forbidden: {fmt_state_list(states, forbid)}")
> +
> +	with guard:
> +		time.sleep(0.05)
> +		before = read_states(CPU)
> +		idle_on_cpu(IDLE_SEC)
> +		after = read_states(CPU)
> +
> +	ud = usage_delta(before, after)
> +	total = sum(ud.values())
> +	violations = forbidden_violations(states, ud, ceiling)
> +
> +	print_usage_table(states, ud, ceiling)
> +	ksft.print_msg(
> +		f"total_usage+={total} "
> +		f"violations={violations if violations else 'none'}"
> +	)
> +
> +	if total <= 0:
> +		ksft.test_result_fail(f"{desc}: too little idle activity ({total})")
> +		return
> +	if violations:
> +		ksft.test_result_fail(f"{desc}: {'; '.join(violations)}")
> +		return
> +	ksft.test_result_pass(desc)
> +
> +
> +def build_plan(states: Dict[int, IdleState],
> +	       ceilings: List[int]) -> List[Tuple[str, int, object]]:
> +	"""Return list of (description, ceiling, context-manager factory args)."""
> +	cases: List[Tuple[str, int, object]] = []
> +
> +	have_dma = os.path.exists(DMA_LAT_DEV)
> +	have_wakeup = os.path.exists(WAKEUP_LAT_DEV)
> +	resume_path = f"{CPUIDLE_BASE}/cpu{CPU}/power/pm_qos_resume_latency_us"
> +	have_resume = os.path.exists(resume_path)
> +
> +	for ceiling in ceilings:
> +		if have_dma:
> +			cases.append(
> +				(f"cpu_dma_latency ceiling={ceiling}", ceiling,
> +				 ("dma", ceiling))
> +			)
> +		else:
> +			cases.append(
> +				(f"cpu_dma_latency ceiling={ceiling}", ceiling,
> +				 ("skip", "missing /dev/cpu_dma_latency"))
> +			)
> +
> +		if have_wakeup:
> +			cases.append(
> +				(f"cpu_wakeup_latency ceiling={ceiling}", ceiling,
> +				 ("wakeup", ceiling))
> +			)
> +		else:
> +			cases.append(
> +				(f"cpu_wakeup_latency ceiling={ceiling}", ceiling,
> +				 ("skip", "missing /dev/cpu_wakeup_latency"))
> +			)
> +
> +		if have_resume:
> +			cases.append(
> +				(f"pm_qos_resume_latency_us ceiling={ceiling}",
> +				 ceiling, ("resume", ceiling))
> +			)
> +		else:
> +			cases.append(
> +				(f"pm_qos_resume_latency_us ceiling={ceiling}",
> +				 ceiling, ("skip", f"missing {resume_path}"))
> +			)
> +
> +	return cases
> +
> +
> +def main() -> None:
> +	ksft.print_header()
> +
> +	if os.geteuid() != 0:
> +		ksft.set_plan(1)
> +		ksft.test_result_skip("must run as root")
> +		ksft.finished()
> +
> +	cpuidle_dir = f"{CPUIDLE_BASE}/cpu{CPU}/cpuidle"
> +	if not os.path.isdir(cpuidle_dir):
> +		ksft.set_plan(1)
> +		ksft.test_result_skip(f"no cpuidle sysfs at {cpuidle_dir}")
> +		ksft.finished()
> +
> +	states = read_states(CPU)
> +	if not states:
> +		ksft.set_plan(1)
> +		ksft.test_result_skip("no cpuidle states")
> +		ksft.finished()
> +
> +	gov_path = f"{CPUIDLE_BASE}/cpuidle/current_governor"
> +	gov = open(gov_path).read().strip() if os.path.exists(gov_path) else "?"
> +	ksft.print_msg(f"governor={gov} cpu={CPU}")
> +	for i in sorted(states):
> +		s = states[i]
> +		ksft.print_msg(
> +			f"state{i}: {s.name} latency={s.latency_us}us "
> +			f"residency={s.residency_us}us"
> +		)
> +
> +	ceilings = pick_ceilings(states)
> +	ksft.print_msg(f"ceilings_us={ceilings}")
> +	cases = build_plan(states, ceilings)
> +	ksft.set_plan(len(cases))
> +
> +	for desc, ceiling, kind in cases:
> +		tag, arg = kind[0], kind[1]
> +		if tag == "skip":
> +			ksft.test_result_skip(f"{desc}: {arg}")
> +			continue
> +		if tag == "dma":
> +			guard = DmaLatencyGuard(arg)
> +		elif tag == "wakeup":
> +			guard = WakeupLatencyGuard(arg)
> +		else:
> +			guard = ResumeLatencyGuard(CPU, arg)
> +		run_case(desc, states, ceiling, guard)
> +
> +	ksft.finished()
> +
> +
> +if __name__ == "__main__":
> +	main()
> diff --git a/tools/testing/selftests/cpuidle/settings b/tools/testing/selftests/cpuidle/settings
> new file mode 100644
> index 000000000000..5b445e716562
> --- /dev/null
> +++ b/tools/testing/selftests/cpuidle/settings
> @@ -0,0 +1,2 @@
> +# Multiple QoS paths x several latency ceilings x idle windows.
> +timeout=180

