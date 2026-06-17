Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8694C47ECF0;
	Wed, 17 Jun 2026 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781712988; cv=none; b=mapKb5okHtPt3QO+/+XoTV8eRnf850QV8IWvOvAB+W2GG2pDHlUHWhCttUQEiLHKXUOabdjydhHmbuNHcELlAV1DUxK8rS9s2Mw0C55QFQZjmUf4mrMjjuTNs+MEu0QMHar76t/kmR8uqX3+Sn3J+FKq23BlRmbnvxUGBzYGJVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781712988; c=relaxed/simple;
	bh=nN8w8O9PbddvNVj7MdFW/gqvlmwJNFIi/BI6cgPwN5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FZEextbUIHb1GLwSZ3InRIfzpFwMl39KNlGogiahMYlkf14pAG7VKJh6pDgeU6BDqdo80X4acPm2l4M+MHreTF/WDogtb6sEZbqE2lY8UGnmWx9XG7ke/IB042nz6pmyR8yUXJiBRItb2ElMuAUxjLhsADEO+n79hUzr91dYjG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eo/p4RpM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eo/p4RpM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4151F000E9;
	Wed, 17 Jun 2026 16:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781712979;
	bh=hfEmmqVkxWXIECHW53bv/YPgZu63kRgufRGx3zssDrY=;
	h=From:To:Cc:Subject:Date;
	b=Eo/p4RpMRTd2jkZCsY3QRcFNQzIbM2OGOoVZH9pBpuXT6HpJAv24Cz3U98pFzRQdH
	 IDs48uBlhjWHwUTVZksSamAkdfq9ktRvgZyYBVQwYVaslwp182Hf+B/sAZ+b5+wd/v
	 hYAucOtId7r6WEHLXjKPqRRtPNqbPLZYgQT9fd51mOX111yoxmY6ecSTJzpZcTHYxc
	 8UxaPBbff99uyEVbky1dph9hRI0BkNMco0dNGBtSnrO97qYn0DL2Ckhu7n7XEdlQ1h
	 8IjDK63n6nwWM/xPtmU7GQQ3nbY2FIOFBG1JtpLQsml7ZJcKb7oCGL5C7sw0cpTZX9
	 hpZpNyQinuQyA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH v1] cpufreq: Allow exit latency to exceed target residency
Date: Wed, 17 Jun 2026 18:16:16 +0200
Message-ID: <3444162.aeNJFYEL58@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 76934e495cdc ("cpuidle: Add sanity check for exit latency and
target residency") had added a check to prevent the exit latency of an
idle state from exceeding its target residency that later was limited to
printing a warning message in that case in commit 4bf944f3fcb6 ("cpuidle:
Warn instead of bailing out if target residency check fails").

However, a thorough code inspection with that in mind leads to the
conclusion that actually there are no assumptions in cpuidle regarding
the relationship between the exit latency and target residency of a
given idle state.  It is generally assumed that the idle states table
provided by a cpuidle driver will be sorted by both the target residency
and exit latency in ascending order, but that's a different matter.

Accordingly, drop the check in question along with the message printed
when it triggers and the inaccurate comment preceding it.

Fixes: 4bf944f3fcb6 ("cpuidle: Warn instead of bailing out if target residency check fails")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/driver.c           |    8 --------
 drivers/cpuidle/governors/ladder.c |    2 ++
 2 files changed, 2 insertions(+), 8 deletions(-)

--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -195,14 +195,6 @@ static void __cpuidle_driver_init(struct
 			s->exit_latency_ns =  0;
 		else
 			s->exit_latency = div_u64(s->exit_latency_ns, NSEC_PER_USEC);
-
-		/*
-		 * Warn if the exit latency of a CPU idle state exceeds its
-		 * target residency which is assumed to never happen in cpuidle
-		 * in multiple places.
-		 */
-		if (s->exit_latency_ns > s->target_residency_ns)
-			pr_warn("Idle state %d target residency too low\n", i);
 	}
 }
 



