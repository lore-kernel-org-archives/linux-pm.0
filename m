Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A6242A782;
	Fri, 24 Jul 2026 13:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784900593; cv=none; b=FZmLoVk2MQrXrNt6hLnq+u+1JZ4dDva9iXu047DhXMptg44ifPA6cX1O9JyomKaoM0JV2LCInVtjaivFcsFhFGPxma0d9EoG8Wd0/UIp+Qvdg+TP6G3Vh9OSzDCMPEVBd+GLSwkwbB2v7OxSlKzQL9icoFcCIG65Qv0CMnCdN/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784900593; c=relaxed/simple;
	bh=1QY3CziTqGNhL3/KPNo6jV0TQXBUU6XW1bZCekPF4Yc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QdERKWSSfM5ix+UOsm2r1V8Mpgp8WJNUXerOcEM9gVU2RlQs09RN5zHHxOVo463mbiJ2FmmHlfUAob+gDOzxrA88XG2EPbgalQEyf7qxayBFrZas01LYI8B3lUAI5YbSs00w+fMhGh8/3gTYyJjqinL/+2FB4NO0zCD+VVqArDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=vn/eeqid; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="vn/eeqid"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1408C1477;
	Fri, 24 Jul 2026 06:42:58 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.66.189])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 06F4F3F59E;
	Fri, 24 Jul 2026 06:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784900581; bh=1QY3CziTqGNhL3/KPNo6jV0TQXBUU6XW1bZCekPF4Yc=;
	h=From:To:Cc:Subject:Date:From;
	b=vn/eeqidapQnPcooOrIavDGocSIgnkZWyqtvg4VyCh5UMnd3AJi0Wq3wsJMyF6ix9
	 BkCTDRXFTu+/ARdqgu4zz0ezp20oUjw8lWFgZFwZ/ZNuCvC0sJ5/SJrzNVRxa7Hiqn
	 NXYbdP9cKjmY+z1AZxgQ6XLjUaibWD4iEMiAHtzc=
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
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH 0/3] ACPI: CPPC: Reduce .target() callback overhead
Date: Fri, 24 Jul 2026 14:42:48 +0100
Message-Id: <20260724134251.1632824-1-christian.loehle@arm.com>
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

Christian Loehle (3):
  ACPI: CPPC: Avoid unnecessary reads for full-width writes
  ACPI: CPPC: Avoid locking standalone full-width registers
  ACPI: CPPC: Evaluate performance-control PCC use once

 drivers/acpi/cppc_acpi.c | 135 +++++++++++++++++++++++++++++++--------
 include/acpi/cppc_acpi.h |   5 +-
 2 files changed, 113 insertions(+), 27 deletions(-)


base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f
prerequisite-patch-id: 4c1f4063800e3658717eb77e43af13dad52d55cc
prerequisite-patch-id: 5c40d9f099543123c9b904d18ce651e740fbefb8
prerequisite-patch-id: 7202391dca8f31f9eb8f6d59fc753b3ce665e103
-- 
2.34.1
