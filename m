Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C344B7A2D;
	Thu, 17 Sep 2026 15:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789659689; cv=none; b=XsjwqWEMpd/4qRe4CXV9N6C0JXJOhGcGFxMqcWN8BW90uxVtjoSfj+e3cuzrw1h9Vk4g5pQHGQqSlhVoF+E0I7TuBV0g9J9ojb1Rrl6okY0tFVaNp4MFNzAFkCeWjZDkT+GbBNp1/8e/i9g6XpC+JDQhtI7yuHt3Xytm6YIHFGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789659689; c=relaxed/simple;
	bh=JEpBsEZCu0M4t7snWrrDS8B/12BK01ss70hxw3Ic4SM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fHkD+NhbAqzWmPyhwgKuv3h2QJ7OG/iDbO1pDCqaZk34uvQZX7SxB+f5MLTZjdWOcsJjmZi2tPIfpePBR8UGJkshgtvt52WGFmex0jjZnaRxK0A3lKEpCJLd/7paXgDKxuMTND4EPwRXaceH9Nc/5Iu1A3udpkhU2r+LrYiTdas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KrtepTyL; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KrtepTyL"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6E1D1476;
	Thu, 17 Sep 2026 08:41:13 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.50.144])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 291073F7B4;
	Thu, 17 Sep 2026 08:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789659677; bh=JEpBsEZCu0M4t7snWrrDS8B/12BK01ss70hxw3Ic4SM=;
	h=From:To:Cc:Subject:Date:From;
	b=KrtepTyL/mEyHggp0l5pO8pxCR2+5lF6UcefMGEQcj7bGn3uKgWPLnWpG3uTFymHs
	 PR1jjJsFyBCrFqG8xBUFXkk4Jrh2WmQsjR5/shOIRoMhk6Ui10OiVPj7TaazLd0S8y
	 gB5d8XH4g4L6xlKE4Sv5ZY+Bx67MLLtMSdSWJvCI=
From: Christian Loehle <christian.loehle@arm.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Beata Michalska <beata.michalska@arm.com>,
	Elif Topuz <elif.topuz@arm.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Shubhang Kaushik <sh@gentwo.org>,
	Christoph Lameter <cl@gentwo.org>,
	Huang Shijie <shijie@os.amperecomputing.com>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH v2 0/2] sched/fair: Randomize equally shallow idle CPU picks
Date: Thu, 17 Sep 2026 16:39:13 +0100
Message-Id: <20260917153915.1563875-1-christian.loehle@arm.com>
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

The testing platform is a 160-CPU, dual-socket Altra with unusually large
80-CPU candidate groups at NUMA level.

Median stress-ng throughput (bogo ops/s):

  --fork  --fork-max      Baseline       Patched    Change
  ------------------------------------------------------
       1           1        779.19        829.82    +6.50%
      16           1       5070.95       5277.62    +4.08%
      16           4       7692.64       7963.30    +3.52%
      32           1       8662.82       8733.79    +0.82%
      64           1      11880.47      12001.01    +1.01%

Separate instrumented runs observed lower conditional stale-pick rates,
i.e. a busy candidate at final return:

Workload                Baseline       Patched
----------------------------------------------
fork, 32 creators          0.771%       0.335%
fork, 64 creators          1.242%       0.633%

Changes since v1:
- Use u64 latency keys and U64_MAX for unpublished states.
- Sample unpublished-state CPUs only as fallbacks, resetting the reservoir
  when the first advertised-state candidate is found.
- Update the Altra measurements.
- Pick up Vincent Guittot's Reviewed-by for patch 1.

Christian Loehle (2):
  sched/fair: Drop idle recency from slow-path CPU selection
  sched/fair: Randomize equally shallow slow-path candidates

 kernel/sched/fair.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)


base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
-- 
2.34.1
