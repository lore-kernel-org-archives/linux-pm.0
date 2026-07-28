Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0AE34B19F;
	Tue, 28 Jul 2026 16:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785256661; cv=none; b=d6QdIehX7f7gJ/fSTFPv7eTgxfWGYV1NWtPE0cNT4RjtVa1NfJv5r4VJENRzFVOuUQnQ7jCXq6FgKwIVLu3nxxK8CA3H9xPgrilCZPSV/Z6vbo0aZ3+HU+dmbaJlpgoB645QHwBDH/vxMji3YV3Ho/i0ia96+Li3ASoa53hkRC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785256661; c=relaxed/simple;
	bh=ZwumHLdDD05eqeamyWaZK6REcQd7t/8018MxvOhS168=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=enTRF4rDvD378Suw1Vt1aF3W5bok40vBq5gDTK5asRR+gD4ggNqPhJ29Fxx0RQMeXFARRbioRQNgD9h8RFZEpTIwsGcLINYeNk/Mh7/ikA4NIyzBvSxZzCy9Q+XMC8zn2OAvrQ2VXBrY9Ti4scfphB0BpeWiEXnw+HSDcLW77Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=hEnna7Ki; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hEnna7Ki"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 296C6169E;
	Tue, 28 Jul 2026 09:37:35 -0700 (PDT)
Received: from [10.1.39.91] (unknown [10.1.39.91])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93C223F763;
	Tue, 28 Jul 2026 09:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785256659; bh=ZwumHLdDD05eqeamyWaZK6REcQd7t/8018MxvOhS168=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=hEnna7Ki1eXf0o228QAPXujM0mc1cgjWxZmZqNglm5YQYG4MPzs5n4oj5ST5kM5N/
	 GPCvWSdFsN71+hnvwBFECU1x2Iik5w/H5bPu8wxm2C3OmCMFRWOqwqAAC7ucRbikCi
	 v0a7uyrtLKQewbyzEBnZptOIxmyAWeyJjyc9vy9k=
Message-ID: <0b9b9c3d-8ba0-4329-9504-b9d33c627649@arm.com>
Date: Tue, 28 Jul 2026 17:37:34 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] sched/idle: Stop the tick when no cpuidle driver is available
From: Christian Loehle <christian.loehle@arm.com>
To: Joseph Salisbury <joseph.salisbury@oracle.com>,
 "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: rafael.j.wysocki@intel.com, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, frederic@kernel.org,
 linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 regressions@lists.linux.dev
References: <096b42fa-107f-450d-b3b1-03bcad3f1e04@oracle.com>
 <CAJZ5v0g+SkTxuP5fqUMisQAh19v-JzpmRZHiKtYzJH1sVt656g@mail.gmail.com>
 <5f5cb821-92ae-4539-ae81-a43e33a7ded5@arm.com>
 <f5946a8a-43be-49d4-a827-25149112b21f@oracle.com>
 <774c3a68-6a6b-4e2e-a347-03e36953b750@arm.com>
Content-Language: en-US
In-Reply-To: <774c3a68-6a6b-4e2e-a347-03e36953b750@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Commit f4c31b07b136 ("sched: idle: Consolidate the handling of two
special cases") changed the no-cpuidle-driver path to use the previous
tick wakeup heuristic.

Oracle reported a substantial sysbench regression on small OCI VM shapes
with no cpuidle driver available. Reverting the commit recovered the lost
performance.

Restore the previous tick handling for the no-driver case while retaining
the heuristic for the single-state cpuidle case.

Fixes: f4c31b07b136 ("sched: idle: Consolidate the handling of two special cases")
Reported-by: Joseph Salisbury <joseph.salisbury@oracle.com>
Closes: https://lore.kernel.org/all/096b42fa-107f-450d-b3b1-03bcad3f1e04@oracle.com/
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
Here's the actual patch, I'd still be curious about why this happens here...

 kernel/sched/idle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 052435f4d3e3..a814f9d5759f 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -194,7 +194,7 @@ static void cpuidle_idle_call(bool stop_tick)
 	}
 
 	if (cpuidle_not_available(drv, dev)) {
-		idle_call_stop_or_retain_tick(stop_tick);
+		tick_nohz_idle_stop_tick();
 
 		default_idle_call();
 		goto exit_idle;
-- 
2.34.1
