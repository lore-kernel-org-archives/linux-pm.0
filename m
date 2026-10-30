Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793349406;
	b=FdeWBdA9CW2RWyelelVPYDE0ulsIMQUNd76OGf7n5j8dDPck0QgXWFO0amLxoOZE5fNE
	 Z3Xr1a24XMx8Yi2zMnYHSUgsn39ZA7QheM4Cpv3XDOJmvDyKX/5NNAyxJGkThn1Tm8Yw5
	 wTTB/zEYxbOfdvbdbYu7nC1c4ctgPxbLCabapq4W4oNzRpjYUfxfnqffawKWbf+osbYPg
	 D/mRTGt5uhsjYMkEZoAKSRy6CpFE+zgOpk+xTZXf3rc4WHy9Xn8I31DCXhKm0q4PI8AcD
	 PDueBTPrqrza+kiR1+uyjtsdOeTo/XA0MMJoHyLRwKuClAZK9+NMnBYwZutypneLgig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793349406;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PyO9V3NEdRS42/rBxENZPA7VOFkuTdZ9UgfoOQrncFE=;
	b=JhMOsvhuFL/R7JxscEITDeZOubMb7g1dW6T3ROQ8x6rv9NT3rPS60i2cgzEXn0+6s/Pl
	 e2e4Aqli5smYQQ324Ni20b6p1wrPTxRPGth72W2y4aUFjcUqUs/9zNOvp/I371mGuivfZ
	 XpC2oJKS70nJ7vhK8wnyOgc9d5lkYprKpY214g5KWhmlJzUF3cSR9K4r0Krr6EhKAzMoV
	 sOF/4/PNfp1b5qbeotiAM/uqRs5F2qYAuUMknmcx9+/Ibu+5X7v+GpjyjYfrEnlHXsAQU
	 Pm+XWfKovwGvmY96VWFXpGA3jzklrBlyTLDdgQbFPinGo+Ig81+x7Oo3QfOA9ynv1Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=IxXRgkeL;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A57606A336;
	Fri, 30 Oct 2026 08:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71A57606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=IxXRgkeL
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1F1A237B;
	Fri, 30 Oct 2026 01:36:41 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.79.231])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E5FF13F673;
	Fri, 30 Oct 2026 01:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793349404; bh=3GOit7A0VnlJRo5fs146qOU1IclspBZKxrf0ylSTTcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IxXRgkeLmfd7WzKItVJyEcCpOlFfSDckdsQTD172MdPbkaA/G8K8o/8mwsFBCT25x
	 Qv62YuioebAff6FZ/kYYrtBRqKx1De1+nPyWzvSNXwK4KX7nOx0Xbd0Y5DKbJ9ZWek
	 8OTx7rsdecKYhSWjmNcVJmQPph/3V75zY1h2IF/g=
From: Christian Loehle <christian.loehle@arm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH 2/2] cpuidle: Respect latency constraints when accounting below misses
Date: Fri, 30 Oct 2026 08:36:33 +0000
Message-Id: <20261030083633.1699270-3-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261030083633.1699270-1-christian.loehle@arm.com>
References: <20261030083633.1699270-1-christian.loehle@arm.com>
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

Only count a below miss when an enabled deeper state meets the latency
constraint. Save the applicable limit before entry so QoS changes during
idle do not affect accounting. Continue checking disable flags on exit.

Fixes: 04dab58a39d4 ("cpuidle: Add 'above' and 'below' idle state metrics")
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/cpuidle/cpuidle.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index faa29f58738e..e9195ea8cfb6 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -219,6 +219,7 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
 				 int index)
 {
 	int entered_state;
+	s64 latency_req;
 
 	struct cpuidle_state *target_state = &drv->states[index];
 	bool broadcast = !!(target_state->flags & CPUIDLE_FLAG_TIMER_STOP);
@@ -244,6 +245,8 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
 	if (target_state->flags & CPUIDLE_FLAG_TLB_FLUSHED)
 		leave_mm();
 
+	latency_req = cpuidle_governor_latency_req(dev->cpu);
+
 	/* Take note of the planned idle state. */
 	sched_idle_set_state(target_state);
 
@@ -327,7 +330,8 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
 			}
 		} else if (diff > delay) {
 			for (i = entered_state + 1; i < drv->state_count; i++) {
-				if (dev->states_usage[i].disable)
+				if (dev->states_usage[i].disable ||
+				    drv->states[i].exit_latency_ns > latency_req)
 					continue;
 
 				/*
-- 
2.34.1

