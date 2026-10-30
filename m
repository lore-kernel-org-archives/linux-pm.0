Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793349405;
	b=EPmpk9m/m+lopkAhGdxvzq0HYrIq1V+tNimZgE0obTPCwUXWBVpEYh4oJQgLNN35LQz/
	 FVdq+aqKZeVWgx3BzA3Zx7TpWaOXRsDtNf5hG3dkiOb69b7jqeTGzoDAI9zLSzT8DZWKV
	 za5dWvSBuVgkEufMpitZoWp5t0mpRZ4ZJJhcBKh/tgu0/S+xNmUdRnThmlNrm8zMU5ZkZ
	 JkxC2fCtA8mzSx0vuQoJdGYvouwKiwnanqIDYtMI0/4TYXczDjc2lHHlxoPbca6aznWmG
	 QWjgZ21UgWGcVbmQC/RRLJOL06nXbNEFCXKRm33sjakz8YpAAs4Y7EdhvkM82k0Y+Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793349405;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=7Fy1QO1uu88KcV4SFjYcE+NC80g6BpPYVXgFQcl/tFE=;
	b=E63GRialkzUDk1q8jhG2ri8jhv0xJqx8VBMlILqve5/L2DQhBFw/VyyEZ7wUBHYxIB88
	 owSqiTqVr13fb/p0Sz/efMkYTAPLQvqLHfZRe+CWkY3h5E+gH3F9KJ6DLfojdEFZXSpFE
	 V0y6dir7Oo+/D3Nq/uLSyKfI/Z6qHh3MC6IC7T15YpfMhUfPC9l0fgodSYTWB2HH3XIHH
	 dhQwuPGnmRR5WUjV7p866qQFc3KF4iVpbm8RKcA0hrn1Q91iRc6wcYYgAyx0GZ1XKJHBP
	 efrzGZ9eodRZfC4ZFBo/hfeguKpJ7LrVDpyUCViQMpV9D+BRQr/fWnIt9YUc+L4nlsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F87606A31A;
	Fri, 30 Oct 2026 08:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56F87606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3173F1682;
	Fri, 30 Oct 2026 01:36:39 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.79.231])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 655F53F673;
	Fri, 30 Oct 2026 01:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793349402; bh=tU0BnLZlvFNe5H5fIup4FXwuZV+YbttPj0coubWIAG4=;
	h=From:To:Cc:Subject:Date:From;
	b=DCqtGPHNwWKV50Rk58pHfKiLHoauxymGy7Lqj+LXuwoUin52APiUJI3xgynzJZz3U
	 q5Zzbhp1bhB9+kj/cb9sg7i4Wei8IW2eNkMoulNUTekB40YmemgMyavWtf9ZM7Xj9W
	 fq+8tWXXzLkpAXs9kG67Nnyp1crqQRCywvNiZbQ4=
From: Christian Loehle <christian.loehle@arm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH 0/2] cpuidle: idle_miss accounting fixes
Date: Fri, 30 Oct 2026 08:36:31 +0000
Message-Id: <20261030083633.1699270-1-christian.loehle@arm.com>
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
accounting and respect the entry-time latency constraint when looking for
a better deeper state.
No functional change outside of sysfs above/below and tracing.

Patch 1: Exclude timer-broadcast fallbacks

When tick_broadcast_enter() fails, the core forces a shallower state.
Exclude these entries from governor miss accounting while retaining
residency, usage and governor feedback.

On Orion O6, traces with menu and TEO running schbench, tbench and hackbench
recorded 6930 cpu_idle_miss events on 8172 broadcast fallbacks before the
fix, and none on 7763 fallbacks with patch 1. All matched fallbacks entered
WFI.

Patch 2: Respect latency constraints for below misses

An enabled deeper state may violate the latency QoS constraint, causing a
false below miss. Save the governor latency limit at entry and exclude
states exceeding it, without an additional state-table walk. Disable flags
continue to be checked at exit as they are expected to change less frequently.

Christian Loehle (2):
  cpuidle: Skip miss accounting for timer broadcast fallbacks
  cpuidle: Respect latency constraints when accounting below misses

 drivers/cpuidle/cpuidle.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

-- 
2.34.1

