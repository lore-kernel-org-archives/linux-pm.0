Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794398353;
	b=oORZfArwNW4V+KKESzUBez1HDrR5P/TGL3KeaRJU6lis90AU423PTIENNsV6ScPHzoCG
	 SgPpdkNUqJtDFGytqvhVAET3x3rUKIYvEMuwH0mP0LxjkDjyTzvLypJTboWZDYLzn5NNq
	 y5ymVIrBXuOAA6zqogXy+gZDxOWmJ4vLDVmxbHZq1LFdV2WyLJ4t/z306HM3RVWzCfqgo
	 3mWsazUfqoqQteEqxzUbmIsS7O/h6r3wObVIPq7q8saag8/Ue90gAyh869UPY4+jMvnNd
	 2va+3YAIWzl6w49rP5ckEXonYQf5CMRwiiKV7VoA3HxoLiAXWPOH6BQvg90PseSieRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794398353;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tmeH9/HT8/9td4wyNdO7vNMgAiZgqsttgi2BQtjYIuY=;
	b=ACmc1V+8Po4ACjLsswdgRyjsQx8IakGQtizcaDpQ0joWuji4yVfepTHZJs8VFMMDJ+Rx
	 cVelEB5sl+N5Gg8UWTrXi5HsE+a9sUKKl85a4I85p+fMeJOS75zeQEUnRE0ZeMMYXaHHj
	 JqPh4kuKhqO9DIPabY7mowyAq1pFZVB7eU6czjwrxCusdNxXMwrhZjuvsYIuVbhjH+J8N
	 gLZ9hSSQRWcX85KGdMGnOLGEIABtcLiCdoifIatEFQAYIHEl7Oi7sYb2aXb600M3jpVFP
	 eVdvytRtHfLm4aN9oiN/VPrbfxZblsGLTMp0ahFhJSsZBmOzTrvVUnYYbiKi1XnUvWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=EdAWoU5L;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD54606A324;
	Wed, 11 Nov 2026 11:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FD54606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=EdAWoU5L
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B399F1682;
	Wed, 11 Nov 2026 03:59:09 -0800 (PST)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.0.130.226])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 685483F673;
	Wed, 11 Nov 2026 03:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794398352; bh=umuEHFeZKN7voacZsDV+IjuLya9LRnYJIKFPC+8pv74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EdAWoU5LtrpH6x5LFfN7IVXg+eIBy6v9vvaeo9vspL6exAAozRbvrTn+v68ITjsF1
	 FZHnt2zAWEE6fw6G7pNFu5OdXqQVgQf0UnjY+tBZmT8ntocngot68OB4SCjZ2bRbet
	 xBV4VuzUz0xOjZ5jGQifdgQSvg7oveYEKJD3tczk=
From: Christian Loehle <christian.loehle@arm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH v2 1/2] cpuidle: Skip miss accounting for timer broadcast fallbacks
Date: Wed, 11 Nov 2026 11:59:01 +0000
Message-Id: <20261111115902.1904523-2-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261111115902.1904523-1-christian.loehle@arm.com>
References: <20261111115902.1904523-1-christian.loehle@arm.com>
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

A failed tick_broadcast_enter() can force a shallower state than the
governor selected. Exclude successful broadcast fallbacks from above/below
miss accounting while retaining their usage, residency and governor
feedback.

On Orion O6 with menu and TEO under normal workloads, 9,782 of 33,136
broadcast fallbacks emitted below misses: 90.4% of all below misses and
13.6% of the 72,059 total misses. Excluding these from the same
795,370 complete idle episodes reduces the miss ratio from 9.06% to
7.83%.

Fixes: 04dab58a39d4 ("cpuidle: Add 'above' and 'below' idle state metrics")
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/cpuidle/cpuidle.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 2d2f40a2cb81..faa29f58738e 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -222,6 +222,7 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
 
 	struct cpuidle_state *target_state = &drv->states[index];
 	bool broadcast = !!(target_state->flags & CPUIDLE_FLAG_TIMER_STOP);
+	bool broadcast_failed = false;
 	ktime_t time_start, time_end;
 
 	instrumentation_begin();
@@ -232,6 +233,7 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
 	 * CPU as a broadcast timer, this call may fail if it is not available.
 	 */
 	if (broadcast && tick_broadcast_enter()) {
+		broadcast_failed = true;
 		index = find_deepest_state(drv, dev, target_state->exit_latency_ns,
 					   CPUIDLE_FLAG_TIMER_STOP, false);
 
@@ -306,6 +308,13 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
 		dev->states_usage[entered_state].time_ns += diff;
 		dev->states_usage[entered_state].usage++;
 
+		/*
+		 * The broadcast constraint forced a shallower state, do not
+		 * account for it as a cpu_idle_miss.
+		 */
+		if (broadcast_failed)
+			goto out;
+
 		if (diff < drv->states[entered_state].target_residency_ns) {
 			for (i = entered_state - 1; i >= 0; i--) {
 				if (dev->states_usage[i].disable)
@@ -338,6 +347,7 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
 		dev->states_usage[index].rejected++;
 	}
 
+out:
 	instrumentation_end();
 
 	return entered_state;
-- 
2.34.1

