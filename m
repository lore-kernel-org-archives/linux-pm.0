Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F872E266C;
	Wed, 22 Jul 2026 09:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784713125; cv=none; b=eZPsfNvCFH18ZFV/7Lp6on8lcwBj+fTDtd7W3HnTqJHE0yBWU/ke7Hvxwu1Lq2unfi1STE8BUKmuM4/KrafeNPofzOyGPXWUmUfbBV1MNExilPhvHM4kZcGAlNV99dqCNlIO2YzMoLsJyIRBqjPyEOyyqfKm1Y9O9RX2IW9XPDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784713125; c=relaxed/simple;
	bh=FHJ77Y5gyVZvHldCu2Ryh1m2/mwr7JJyC2MavI2hcb8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qHdAYO2OK6n0OC0CNYegVNmRSEN/HE4ASNfiOC4uyCQbgBfRiAbhZPIiimOBYba/ZHEFul0aUBkeSAM/uRVtqXg0+aQgMzFLoxCW/gNUrgIDBc1AfISUO7jjcZWnnjgOedjocfL19ylSD5Ey3bwOg6JDwLON4VcLSC3y1fvko30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=iZFkClTb; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="iZFkClTb"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F6471595;
	Wed, 22 Jul 2026 02:38:39 -0700 (PDT)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.39.91])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D374C3F86F;
	Wed, 22 Jul 2026 02:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784713123; bh=FHJ77Y5gyVZvHldCu2Ryh1m2/mwr7JJyC2MavI2hcb8=;
	h=From:To:Cc:Subject:Date:From;
	b=iZFkClTbG71uG/62nJtGY4vFXJ4Db1loNqmPnFP2KUcNkqpF4DUBjDClIh3tiO67m
	 3UCaG3oSXeQqmdId7z5O0jWdrL/jh7Iq3yNqp/a+dQTYdJcoofLRFFwIB8bJVsiEVj
	 96FX8RsotoMdj6ej/Iyy7aHvkmCE/iQXu1OWzA/c=
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
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH 0/2] ACPI/CPPC: make policy-limit updates safe
Date: Wed, 22 Jul 2026 10:38:23 +0100
Message-Id: <20260722093825.1030594-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit ea3db45ae476 ("cpufreq: cppc: Update MIN_PERF/MAX_PERF in target
callbacks") made cppc-cpufreq submit policy bounds from both target
callbacks. Two correctness issues remain in that path.

ACPI permits the CPPC controls to use different address spaces. Fast
switching can consequently enter the sleeping PCC path when DESIRED_PERF
is directly accessible but MIN_PERF or MAX_PERF is PCC-backed. Fix it by
doing the simple thing and only allowing fast-switch when all controls
are directly accessible.

The policy bounds are also read without the policy lock. Because the core
updates policy->min and policy->max separately, a lockless reader can form
an inverted pair. Patch 2 sanitizes that snapshot before converting it to
CPPC performance values.

Christian Loehle (2):
  ACPI: CPPC: Check all controls for fast switching
  cpufreq: cppc: Sanitize lockless policy limit snapshots

 drivers/acpi/cppc_acpi.c       | 22 +++++++++++++++++-----
 drivers/cpufreq/cppc_cpufreq.c | 33 +++++++++++++++++++++++----------
 include/acpi/cppc_acpi.h       |  5 +++--
 3 files changed, 43 insertions(+), 17 deletions(-)

-- 
2.34.1
