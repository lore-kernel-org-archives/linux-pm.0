Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793559498;
	b=rAVdO6vbznNdZs6gatDc9frJ9sdj6+LRuw2mfvXRA4VIcHYpp4sEFAt4Qe71K6jeOj1S
	 kD1gZQc6zEJM8hUJG9Av50PHnxcHR4qkUBgXpBBjpPHDC4gYkWJfn41x3wp1kFpJ0Yfto
	 7VYQZ7pl17ATRQwmKvAhSyG4KDHOsdnBrtXO4j7ZvXjHKn4EEtUe1zRhxAV8fRJErTVIv
	 pWiVMI81gCLveJcE9cihz5fwcy+vtJIpZNaxPuZ+wuIzrYP0Y7t+UVqOkzBlCaUHNG9ai
	 vfVEsXORRy8jXkHl/Fut5pq0kaowro1K+hT05urAt0/UoVY1+tKaDuXnkgTTeAH6yww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793559498;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id;
	bh=U8qzDU+msPHL0dnxX5aGigQJ0eVelvQUESkdPC29Fq8=;
	b=Rfa4ttmOM6O+liakE6o9B/LR/PDCjcC/eHs7hurfopXiZeeCmRzcxif5ZovN8vkTUTXj
	 nKLVREWTqWAoe3JfLwGo9xXt7XNI4T/HPU/7wm/5iSwnavj6GESsvS6K+82Lv9Ht86/1e
	 zpc1P10GWGW3gfID/IXEHmA6gVrApCOteHHPAR5rtEFE27aeOmb/cpFKOYMclud5m4p/s
	 9vDS+9VoHcOKOHr7hFOLyTqfESugFjR9rQiJ0964xCmgBRfWwzaqXpaWe61c5QdjtaO4j
	 yidLmJFLC+vM5VWDE3lBmiOJU4KAb7HbDtg72yV4doCZTxRSjO+cxC2nyartp/+VWjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hsal.es;
	spf=pass smtp.mailfrom=hsal.es;
	dkim=pass header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=ODMK0351;
	arc=none smtp.remote-ip=80.241.56.172
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E83606A326;
	Sun,  1 Nov 2026 18:58:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1E83606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hsal.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hsal.es
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=ODMK0351
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jHkcf1Z6mzMlWK;
	Sun, 01 Nov 2026 19:58:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
	t=1793559490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U8qzDU+msPHL0dnxX5aGigQJ0eVelvQUESkdPC29Fq8=;
	b=ODMK0351XiCM8o96SlfxjVYnVzejOPAVsREQzZS4T7wQ1LQq05HWD6yROayj+y7HJlhM97
	TIByRt5yvg5L1epAvaH91t5BxkqgWO9FWnjOAR/lZ6dk6qmqIPJfnocJKmcmcbXB05PTHO
	VYyDT7s6jHjWEQlp8pl+ZpPNi7etn4GhAiuz3j8ZyRvlCgi5elDI4CKASyssAk4FE+U+Q6
	kGR5IAq9lkhbrIXPmX+gHiLk5Vp/fdEgfv80REmL04WzDjp1sC9EZnW9dLXWyD9j8P7302
	XCIWEWZxBo/Q203lyZx/OljeDNpy02fS4C+FaV+2vHopN4YUbMm0JZF6VwDYJw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Len Brown <lenb@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Ashton A." <me@ashtonantila.com>,
	linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/4] ACPI: processor: thermal: Recompute the frequency cap when boost changes
Date: Sun,  1 Nov 2026 18:58:03 +0000
Message-ID: <20261101185807.112449-1-hugo@hsal.es>
X-Mailer: git-send-email 2.56.0
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
X-Rspamd-Queue-Id: 4jHkcf1Z6mzMlWK

thermal_req is a fixed fraction of policy->cpuinfo.max_freq, computed
only when the cooling state is written, so it keeps the boost state of
that moment. The ACPI thermal zone writes step 0 on every resume, and
step 0 caps at cpuinfo.max_freq, so if boost was off at suspend, turning
it on after resume leaves the CPUs at their base clock. Steps 1 to 3 go
stale the same way

Ashton A. sent a one-line fix for the resume case, which stops step 0
from setting a cap. It fixes the resume case on my laptop, and my
Tested-by is in that thread:

  https://lore.kernel.org/all/20261028-acpi-thermal-stale-limit-v1-1-4b0ab3230f01@ashtonantila.com/

That patch is small, easy to backport and enough to fix the biggest
issue. This series applies on its own to bleeding-edge and fixes the
resume case and steps 1 to 3 by recomputing the cap when boost changes,
so please take one or the other, not both

Before d15ce412737a the CPUFREQ_ADJUST notifier recomputed the cap on
every policy update. This series brings that back without letting a
notifier touch the policy:

  1. cpufreq core: a CPUFREQ_UPDATE_CPUINFO policy notifier event, sent
     from policy_set_boost() after ->set_boost(). That covers
     amd-pstate, cppc_cpufreq and the cpufreq_boost_set_sw() drivers
  2. intel_pstate: send it from __intel_pstate_update_max_freq(), since
     no_turbo and HWP capability changes don't go through ->set_boost()
  3. processor_thermal: factor out the thermal_req update
  4. processor_thermal: recompute thermal_req on the new event, from the
     step each request was last set to, under a mutex shared with
     cpufreq_set_cur_state() and the request add and remove

Step 0 still sets a cap here, and patch 4 recomputes it with the other
steps, so the resume case needs no special case

The freq QoS notifiers can't do this. They fire only when the aggregate
limit changes, and while the thermal cap is below both maximums,
turning boost on moves boost_freq_req without moving the aggregate

I also looked at basing the steps on a fixed reference frequency, the
way cpufreq_cooling uses absolute table frequencies. There is no generic
way to read the boost maximum while boost is off (amd-pstate and cppc
keep it in driver data), and with boost off step 1 would often not
throttle at all

Rafael, Viresh, which do you prefer? This series adds a cpufreq event
with one user. If that isn't worth it, I'm happy to drop it and keep my
Tested-by on Ashton's patch

Tested on my laptop (Ryzen 9 5980HS, amd-pstate-epp) with the series
backported to 7.3. With boost off and cooling state 1, cpu0's
scaling_max_freq is 2640800, 80% of 3301000. Turning boost on raises it
to 3879405, 80% of 4849257, and turning boost off brings it back down.
Step 2 follows boost the same way, and at step 0 turning boost on gives
the full 4849257. Toggling boost while writing cooling states on all 16
CPUs left nothing in the kernel log, on a kernel without lockdep

Patch 1 changes Documentation/cpu-freq/core.rst only. Its zh_CN and
zh_TW translations need the same update from someone who can review
them

Hugo Sales (4):
  cpufreq: Add a CPUFREQ_UPDATE_CPUINFO policy notifier event
  cpufreq: intel_pstate: Send CPUFREQ_UPDATE_CPUINFO on max_freq changes
  ACPI: processor: thermal: Factor out the thermal_req update
  ACPI: processor: thermal: Recompute the frequency cap when boost
    changes

 Documentation/cpu-freq/core.rst  |  9 +++--
 drivers/acpi/processor_driver.c  |  2 ++
 drivers/acpi/processor_thermal.c | 58 ++++++++++++++++++++++++++------
 drivers/cpufreq/cpufreq.c        | 16 +++++++++
 drivers/cpufreq/intel_pstate.c   |  8 ++++-
 include/acpi/processor.h         |  4 +++
 include/linux/cpufreq.h          |  2 ++
 7 files changed, 85 insertions(+), 14 deletions(-)


base-commit: 5854d2ce4b0b9ccb37b154319d8283bad889a694
-- 
2.56.0

