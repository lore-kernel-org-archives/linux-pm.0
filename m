Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDD04BA9F2;
	Wed, 16 Sep 2026 10:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789552917; cv=none; b=VYA0GQNnx99cGXg9UqR0RZKm4i5pOA78gwi9g4IZZsA6eI8y9Wm2QaFckA9r6XokUGlzOWpE/ISsG8gkCTEz4CnakSzNqdkmSU/8tKa1N3ct9vgEecTTdX8IShPO+fRr7Fn6tG/S4YZlSnhGJLFjfn8JG/38fykuDk39i2ZBid8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789552917; c=relaxed/simple;
	bh=7jLZ2XhJiOEZYmvQi/rWbrYMbAlJyFj+KfTLwKY+2KU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SQG9Lua7YVOHUaAp0aSiXpDQaGFvJQfnBC5WOQG3RlVIG+2Y/b+5OKOs8i0vNhp49dHpqIMY/gb18HrYeNXe+Aqlcco1MabN1YtEYTFu2+g55kpu0X2v+bE5GlTK4SKRBolxChVjVHGuAgAib6x7cQq3fphyGvieGuLzqU6r8y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=l2M/L4l0; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="l2M/L4l0"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDE9A152B;
	Wed, 16 Sep 2026 03:01:23 -0700 (PDT)
Received: from e127648.carmbridge.arm.com (unknown [10.0.129.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 086183F86F;
	Wed, 16 Sep 2026 03:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789552887; bh=7jLZ2XhJiOEZYmvQi/rWbrYMbAlJyFj+KfTLwKY+2KU=;
	h=From:To:Cc:Subject:Date:From;
	b=l2M/L4l0zAw3abeg/4TOau953HS5vrQamXD5Ch4xxQj6do6uWlALCFl7yLWq0VMq+
	 hrf6JuzuegaICWRB0WNFWUvTvn83WebiRXEQ1FPHtGg1SkmGPjbZOYnJ+1MQe2Ltsz
	 WkBKWzXvAbLdIOuzxPRmTWTrexgA3kD9Cfw4PAwo=
From: Christian Loehle <christian.loehle@arm.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Beata Michalska <beata.michalska@arm.com>,
	Elif Topuz <elif.topuz@arm.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Shubhang Kaushik <sh@gentwo.org>,
	Christoph Lameter <cl@gentwo.org>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH 0/2] sched/fair: Randomize equally shallow idle CPU picks
Date: Wed, 16 Sep 2026 11:01:14 +0100
Message-Id: <20260916100116.701206-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Concurrent slow-path selectors can converge on the same idle CPU before
either task is enqueued. Remove the idle-recency preference and randomize
equal-latency choices in a single scan.

The testing platform 160-CPU, dual-socket Altra has unusually large 80-CPU
candidate groups at NUMA level, making this particularly prone to stale
idle picks.

Median stress-ng throughput (bogo ops/s):

  --fork  --fork-max      Baseline       Patched    Change
  ------------------------------------------------------
       1           1        779.19        811.38    +4.13%
       8           1       2958.32       2960.18    +0.06%
      16           1       5070.95       5247.63    +3.48%
      16           4       7692.64       7831.60    +1.81%
      32           1       8662.82       8643.39    -0.22%
      64           1      11880.47      12096.69    +1.82%

Separate instrumented runs observed lower conditional stale-pick rates,
i.e. a busy candidate at final return:

Workload                Baseline       Patched
----------------------------------------------
fork, 32 creators          0.771%       0.407%
fork, 64 creators          1.242%       0.672%

Christian Loehle (2):
  sched/fair: Drop idle recency from slow-path CPU selection
  sched/fair: Randomize equally shallow slow-path candidates

 kernel/sched/fair.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)


base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
-- 
2.34.1
