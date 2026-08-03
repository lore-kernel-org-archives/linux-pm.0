Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E3D3AE718;
	Mon,  3 Aug 2026 21:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785791140; cv=none; b=RPwGlrpxWVJfKMvwvPdzjYYaPTJuN4ltppWMAweXEUbO8ow3zoMJSi/DYMmDcof/8oPNPYL6rEJWsFG9Q6krHEIXVs0yiQDeat6etwsD2eQrJkkmVmNgJju0FMwzgOLWy4jVMpHgdIjtWQyYX8zzttXJ9RIIiUMIoZ69EdN6jOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785791140; c=relaxed/simple;
	bh=eY6jJTpiNOowA96CT9ZOi9a0ue/AR8TgVWtLupRdhPw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XLKnTOHwrG/QHrT9UUo2orK6jeSX/HD5qjbUpqPiPwVTMC/vsnaR0FmkEW35GUwRgxSy4ueNHW5oRKXb1BYs2K31YcpOdwR5N4ZUFxPuv3cRQbs7T/9ycgixynynKW6ixZU+wQczzwQo8YvX9JIFHDNidKLsvIdVCiF2iyUopvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KfYtbs0w; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KfYtbs0w"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5324143D;
	Mon,  3 Aug 2026 14:05:33 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.0.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A330C3F86F;
	Mon,  3 Aug 2026 14:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785791137; bh=eY6jJTpiNOowA96CT9ZOi9a0ue/AR8TgVWtLupRdhPw=;
	h=From:To:Cc:Subject:Date:From;
	b=KfYtbs0wvqZ5BrnUzM0yeaGb7sQ28ZLu3n04TeB3v311yigH0d9DsUcl0DpeQnwkj
	 0vHL3c3A4Sq4ZxGZLZtsgayj9oNjNGnu4EsVK0Z7ok0eQ+c8ukaMDOcRZu8hKp+ZHs
	 Rfyqe9FPuODvvEOQFd0ldi2DpGwK3HhTYQBhIa9I=
From: Christian Loehle <christian.loehle@arm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>,
	Jie Zhan <zhanjie9@hisilicon.com>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	zhongqiu.han@oss.qualcomm.com,
	Christian Loehle <christian.loehle@arm.com>
Subject: [RESEND][PATCH 0/3] ACPI: CPPC: Reduce .target() callback overhead
Date: Mon,  3 Aug 2026 22:05:24 +0100
Message-Id: <20260803210527.1285229-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cppc-cpufreq reaches cppc_set_perf() from every target callback.  For
direct SystemMemory controls, that path currently does several steps
which are unnecessary once the immutable _CPC layout is known:

  - a full-width write first reads the access unit and merges the value.
  - every write takes the descriptor's RMW lock, even when its access unit
    is not shared with another _CPC entry.
  - cppc_set_perf() evaluates the same three PCC predicates at each phase
    of the transaction.

Remove those costs while retaining the existing conservative paths for
partial fields, overlapping or malformed access units, and PCC controls.

The series was tested on Arm Power-Orion O6 and AmpereOne systems using
cppc-cpufreq and schedutil.  An rt-app task pinned to one CPU ran for
500 us every 2 ms with uclamp.min=512, for 5000 periods per run.  schedutil
rate_limit_us was 1000.  cppc_cpufreq_fast_switch() latency was measured
for 100 ten-second runs.  Each sample is the mean callback latency within
one run, and the table reports the median and sample standard deviation
of those samples.

Orion O6               median       stdev       callbacks
baseline               5703 ns      307 ns       188017
complete series        5023 ns      240 ns       188209
==> 680 ns (11.9%) reduction

AmpereOne              median       stdev
baseline               2090 ns      157 ns
complete series      1907.5 ns      140 ns
==> 182.5 ns (8.7%) reduction

The cumulative intermediate results on the Orion O6 attribute roughly half
of the gain to each of the first two patches: avoiding the read reduced
the median by 284 ns (5.0%), and avoiding the lock reduced it by another
336 ns (6.2%).
Together they account for 620 ns of the 680 ns total reduction.

With the same arm64 configuration and GCC 11.4, caching the PCC predicate
also reduces cppc_set_perf() from 1124 to 884 bytes.  The generated
function has 60 fewer instructions, 17 fewer loads and 20 fewer branches.

This series is based on the CPPC fixes posted at (already queued):
https://lore.kernel.org/lkml/20260722093825.1030594-1-christian.loehle@arm.com/

and the separately posted fix still under review:
https://lore.kernel.org/lkml/20260724104042.1481804-1-christian.loehle@arm.com/

PS:
There's a final optimization that I actually wanted to make but decided to
split it out for now as it somewhat replicated Sumit's series:
Skipping redundant perf ctrl writes in cpufreq-cppc if registers are non-PCC
and !shared (because the values are unchanged, the
!autonomous-common-case), but that requires the driver to have a more
complex caching- and atomic-updating machinery in place, similar to
hotplug. As opposed to this series the optimization would be for the
microcontroller handling the CPPC requests, which may be shared across
many CPUs and therefore redundant requests can increase the dvfs
transition latency.
That patch will follow once Sumit's is queued:
https://lore.kernel.org/lkml/20260716153820.2007095-1-sumitg@nvidia.com/

[RESEND] for the new base-commit specifier below

Christian Loehle (3):
  ACPI: CPPC: Avoid unnecessary reads for full-width writes
  ACPI: CPPC: Avoid locking standalone full-width registers
  ACPI: CPPC: Evaluate performance-control PCC use once

 drivers/acpi/cppc_acpi.c | 135 +++++++++++++++++++++++++++++++--------
 include/acpi/cppc_acpi.h |   5 +-
 2 files changed, 113 insertions(+), 27 deletions(-)


base-commit: 075b74841bd0065a3bda3440873c747938e69b68
-- 
2.34.1
