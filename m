Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794398352;
	b=kQlAItJtBkgNsn/OkdTKJcRoCSMaiH3AtIgCGIjzEpQYkqkWSc+OGM8gJz7lAFJsIp7j
	 SzZEibC3tynkAOMJJsad1DU/oRx2BB1HXl6r8j2b4Bzaf71zwVyExpFgWU9eiBz5y8Qvz
	 xGN9E7y+zOeJ6ghwIRNn2VFOsi+AXoZ686P5GcV4YetarUPna8hSuTrG7Cy+UdU4xQcHa
	 oklQFCYh7jaUDwmCumOscNnMv4aIugzAp1E46IrNU7fxnFwW1ydG96raeeRoLZXy5UJNs
	 uyVNPfYNy/C/utzjrlOrO7VSlg/XTH9+GcgucizXLdqOhx2AXShMPuB2z3MydS8RkSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794398352;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=EqgZS8hOcaza8TsJ5S7OdStdEENCeJT5AykHE7hmt4A=;
	b=Kf86Va50B1WETHrAQF7CdmeNaxhtlfx7PUj0nm0ZCs5praD68Ex7j+RDmVhEaxZdQUxM
	 hlzWmjql1ZcPeMaHbed2iGB1NVP4aAeRTHLHABV+f/4slNirNRrFCfBcHftx206iuVXP9
	 3dAsXRznrym/bD+2Mbuj8Akp0+ymzvB3aCVw0Q1ZF4UhemoGirkjvLOqUs737PQFsi6YE
	 rvSHFz37VwTK6jp5WVNLXMik8bQI2ZAICdqDOr3GSL3Gzy5as2GSD2bRtn/S9tX6iAVXe
	 BWobAEL/2WlF+sE6vxYMaUoV0glC2jPdWmX0kfh/1uBs4c9U4H4Q4V431Pi55BfL04g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=LYsIWr4M;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF8B606A326;
	Wed, 11 Nov 2026 11:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEF8B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=LYsIWr4M
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F34031576;
	Wed, 11 Nov 2026 03:59:07 -0800 (PST)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.0.130.226])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C92653F673;
	Wed, 11 Nov 2026 03:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794398351; bh=QBYOKE6IQCNM2hETAtfZT5j67FA/G7it8054JLX3Tuo=;
	h=From:To:Cc:Subject:Date:From;
	b=LYsIWr4MqgU82MsYsUpppyIOsSl+4x8aXRKzrRe84lfYA08wPBc2kZ/bDiAdyt+Tg
	 VlQTAswyOB2gvuTJTfawujRG6FJHc9agjwHYwB9k9DbrGsxzPXKrePzy+G7lDGXVMO
	 pOrji3fmjergqETGrhwNFl4FyuMA5YoZykdOUwYw=
From: Christian Loehle <christian.loehle@arm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH v2 0/2] cpuidle: cpu_idle_miss accounting fixes
Date: Wed, 11 Nov 2026 11:59:00 +0000
Message-Id: <20261111115902.1904523-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These two fixes exclude timer-broadcast fallbacks from governor miss
accounting and respect the latency constraint used for selection when
looking for a better deeper state.
No functional change outside of sysfs above/below and tracing.

Patch 1: Exclude timer-broadcast fallbacks

When tick_broadcast_enter() fails, the core forces a shallower state.
Exclude these entries from governor miss accounting while retaining
residency, usage and governor feedback.

On Orion O6, traces with menu and TEO running schbench, tbench and hackbench
recorded 6930 cpu_idle_miss events on 8172 broadcast fallbacks before the
fix, and none on 7763 fallbacks with patch 1. All matched fallbacks entered
WFI; counts cover complete idle episodes within workload markers.

Patch 2: Respect latency constraints for below misses

An enabled deeper state may violate the latency QoS constraint, causing a
false below miss. Sample the latency limit before governor selection and
share it with the governors and miss accounting. Exclude states exceeding
it, without an additional state-table walk. Disable flags continue to be
checked at exit.

Changes since v1:
- Add observed broadcast fallback statistics to patch 1. (Rafael)
- Sample QoS once before governor selection and reuse the same limit
  for miss accounting. (Rafael)
I know the broader refactor in v2 makes it less appealling to backport
these to stable, but it massively improves the value of the cpu_idle_miss
trace event, when I have to look at some older stable-based Android traces,
where latency requirements may be set dynamically at runtime.

Christian Loehle (2):
  cpuidle: Skip miss accounting for timer broadcast fallbacks
  cpuidle: Respect latency constraints when accounting below misses

 Documentation/driver-api/pm/cpuidle.rst | 13 ++++++-------
 drivers/cpuidle/cpuidle.c               | 18 +++++++++++++++++-
 drivers/cpuidle/cpuidle.h               |  1 +
 drivers/cpuidle/governors/haltpoll.c    |  2 +-
 drivers/cpuidle/governors/ladder.c      |  2 +-
 drivers/cpuidle/governors/menu.c        |  2 +-
 drivers/cpuidle/governors/teo.c         |  2 +-
 include/linux/cpuidle.h                 |  2 +-
 8 files changed, 29 insertions(+), 13 deletions(-)


base-commit: 067c5c24cef23d913b67eaaf71ae67e7169a6620
-- 
2.34.1

