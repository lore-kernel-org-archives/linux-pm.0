Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99A038C2C4;
	Wed, 25 Mar 2026 18:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774462408; cv=none; b=QeAhf9rB71ApmwokChpnJAFZPImQgx9RK7w1JZucOIQm+4bxaphrY6sDwOeJkbc2k3Ixizyo0rfGcPJxwgAAx637tWBzbOyn74WRPYn0jLqspD57vs0GNFDzvshitTWdCmWhpPovs1zvb5pfmSpaCXwJ9QPuMEU0W7BBVLzmr8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774462408; c=relaxed/simple;
	bh=lLBSARj3QF22ma0FdZySKFhXnBOJArvWWi9yJJq9lwc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KLkwCUrejiGoEucKoD+5fJ08kkuMxkYXkIPf6V3aQwDgGYzmkvVoRPVZOTNdGgC1lCicHaxzwfv+pfX9k1BBaGmeW5yskjd3FN2wegr35KymjCqtfH9gezod88nanV8lN+AmOc9tNQ8F6dXUK64BCboK+VrPtZikFAoQMY/PrgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MEnHLZ5W; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MEnHLZ5W"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D96216F2;
	Wed, 25 Mar 2026 11:13:20 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.83.185])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 302783F836;
	Wed, 25 Mar 2026 11:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774462406; bh=lLBSARj3QF22ma0FdZySKFhXnBOJArvWWi9yJJq9lwc=;
	h=From:To:Cc:Subject:Date:From;
	b=MEnHLZ5WBM9ZOgDuPz1k6yJ7fsBlEHXq+zo4XHG03JNi0mXWoumf2AfGynhwZKSMe
	 l77ubzmsQCckgav9dbuvfSvuDSaUNCU53FxDwyoULJWhXUohd3NV1UhJ2mwR7em0Jj
	 fDDRiY8KeBBWarNtF07oBUBUuL/sczphVyd/8cEA=
From: Christian Loehle <christian.loehle@arm.com>
To: arighi@nvidia.com
Cc: peterz@infradead.org,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	valentin.schneider@arm.com,
	mingo@redhat.com,
	rostedt@goodmis.org,
	segall@google.com,
	mgorman@suse.de,
	catalin.marinas@arm.com,
	will@kernel.org,
	sudeep.holla@arm.com,
	rafael@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	juri.lelli@redhat.com,
	kobak@nvidia.com,
	fabecassis@nvidia.com,
	Christian Loehle <christian.loehle@arm.com>
Subject: [RFC][RFT][PATCH 0/3] arm64: Enable asympacking for minor CPPC asymmetry
Date: Wed, 25 Mar 2026 18:13:11 +0000
Message-Id: <20260325181314.3875909-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The scheduler currently handles CPU performance asymmetry via either:

- SD_ASYM_PACKING: simple priority-based task placement (x86 ITMT)
- SD_ASYM_CPUCAPACITY: capacity-aware scheduling

On arm64, capacity-aware scheduling is used for any detected capacity
differences.

Some systems expose small per-CPU performance differences via CPPC
highest_perf (e.g. due to chip binning), resulting in slightly different
capacities (<~5%). These differences are sufficient to trigger
SD_ASYM_CPUCAPACITY, even though the system is otherwise effectively
symmetric.

For such small deltas, capacity-aware scheduling is unnecessarily
complex. A simpler priority-based approach, similar to x86 ITMT, is
sufficient.

This series introduces support for using asymmetric packing in that case:

- derive per-CPU priorities from CPPC highest_perf
- detect when CPUs differ but not enough to form distinct capacity classes
- suppress SD_ASYM_CPUCAPACITY for such domains
- enable SD_ASYM_PACKING and use CPPC-based priority ordering instead

The asympacking flag is exposed at all topology levels; domains with
equal priorities are unaffected, while domains spanning CPUs with
different priorities can honor the ordering.

RFC:
I'm not entirely sure if this is the best way to implement this.
Currently this is baked into CPPC and arm64, while neither are strictly
necessary, we could also use cpu_capacity directly to derive the
ordering and enable this for non-CPPC and/or non-arm64.
RFT:
Andrea, please give this a try. This should perform better in particular
for single-threaded workloads and workloads that do not utilize all
cores (all the time anyway).
Capacity-aware scheduling wakeup works very different to the SMP path
used now, some workloads will benefit, some regress, it would be nice
to get some test results for these.
We already discussed DCPerf MediaWiki seems to benefit from
capacity-aware scheduling wakeup behavior, but others (most?) should
benefit from this series.

I don't know if we can also be clever about ordering amongst SMT siblings.
That would be dependent on the uarch and I don't have a platform to
experiment with this though, so consider this series orthogonal to the
idle-core SMT considerations.
On platforms with SMT though asympacking makes a lot more sense than
capacity-aware scheduling, because arguing about capacity without
considering utilization of the sibling(s) (and the resulting potential
'stolen' capacity we perceive) isn't theoretically sound.

Christian Loehle (3):
  sched/topology: Introduce arch hooks for asympacking
  arch_topology: Export CPPC-based asympacking prios
  arm64/sched: Enable CPPC-based asympacking

 arch/arm64/include/asm/topology.h |  6 +++++
 arch/arm64/kernel/topology.c      | 34 ++++++++++++++++++++++++++
 drivers/base/arch_topology.c      | 40 +++++++++++++++++++++++++++++++
 include/linux/arch_topology.h     | 24 +++++++++++++++++++
 include/linux/sched/topology.h    |  9 +++++++
 kernel/sched/fair.c               | 16 -------------
 kernel/sched/topology.c           | 34 ++++++++++++++++++++------
 7 files changed, 140 insertions(+), 23 deletions(-)

-- 
2.34.1

