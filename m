Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793896270;
	b=MezH+ZI+8t7zvxBw1FUt9SfPzezak8E+d5Ws+ByyaZQBMYb78d9EFJWD82tmRV8l7Dt7
	 iYMEnT+IECh4mKwReJo5YFuMvbvNsfztv5OQDqIA7UuAo8pNrom10C25uOg2De7S6PJMD
	 l2fr7xZoFS/o8CdbnFJkjUt0bBBnoSoVmjbdNByCBsT8eFsZTpWqYIWfz/yXxUxhxbyca
	 m3UHJakRmAl8mBTb54/srQlnS6kmhR2YaXLDmN+kqCzxBKhgV8OuK1U3kQK/M6grcCmfW
	 10gwdEwiHUA1157MSugMTJxONnQYY+G30ztjASoRB68aqgHejiAnUojFfRyVR2t6OkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896270;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZqPM3lz+Qi+tuVf9TikDN4riZPh5fTUW7R1UE7fCWfI=;
	b=i6jReaNHtJTPLxByN7b55r8FQRHbry0g97a5/+cUeQZEt7gKagBvHWJlalVn/Dw6e9vy
	 bez03gEmecxFhOR11u6BTi5sZKSGpb/52Hg6mP7b2TDSCbGu8IrOItoKVy9AZr/0K+PT/
	 8RHAdb2El/uEhYGLonXDdMfJNaw6GNF9GhTf9jFEVTXQqBIq1EvE/HpmNbJIfarr2wfxr
	 OVypLoRWV3DceydnxUlXtgR/vTeikthip57f6gfbayvFxU0wGQ+wLDI1jNgRa44cdMcti
	 lZ1J0+ZHe3uc5Eg1S6OM8JN+pAkk6jdNeh7jpTuaFZAm67T/okSISbTXJOe7hIDDaxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LlTcQXWe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0E160A2617;
	Thu,  5 Nov 2026 16:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LlTcQXWe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757D31F00A16;
	Thu,  5 Nov 2026 16:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793896269;
	bh=ZqPM3lz+Qi+tuVf9TikDN4riZPh5fTUW7R1UE7fCWfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LlTcQXWeHY4iuS02HQLwEakv0vB88LygZgP24Hpv0zjrdpuQCWW9sbVPh7RcjyQHr
	 /zrCXlHoMwhj7zErNroZuX3/f+hEtsiPPcnWms6P+StLfbZOSFocFqK8f4eQ4yi2tU
	 mmBNp7I1+YHLk/MK+Gi8Ele2k7TVUk1eneeABiVCkPL7/mGwq3IOmmOevTksTAFPDf
	 sMoCh9hF1UPI62Y+iwqGKuasbVBTRZmAzYrqXuGlmNOP9OTNm3S9nCENKtrCLKiyUY
	 Y18uUzxtV5bXQlqgIls9lsg5Hg6gLZCHLQaVAWjtiLkhoNNfPZCMXoknHqmk5ITLHp
	 oIwy4FTthOZ0w==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Phil Auld <pauld@redhat.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	Waiman Long <longman@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 05/47] cpuidle: Move CPUHP_AP_CPU_PM_STARTING post stop_machine()
Date: Thu,  5 Nov 2026 17:30:03 +0100
Message-ID: <20261105163045.38862-6-frederic@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105163045.38862-1-frederic@kernel.org>
References: <20261105163045.38862-1-frederic@kernel.org>
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

Between CPUHP_TEARDOWN_CPU and CPUHP_AP_OFFLINE, stop_machine executes
all the teardown callbacks while stopping all CPUs in the system. This
doesn't mix-up well with running RT or isolated tasks.

In order to transition smoothly from global stop_machine to finer
grained synchronization between teardown callbacks and the other CPUs,
a new stop machine post function has been introduced to be executed
after the main one with IRQs still disabled while other CPUs can exit
stop_machine().

The teardown callback here only touches local data and also the local
power device under its power lock. Therefore it should be safe to run
against other CPUs.

Move this teardown callback to post stop_machine() accordingly.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 58bb74f0fcb0..acc6a0e6446c 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1275,7 +1275,7 @@ void clear_tasks_mm_cpumask(int cpu)
 static int take_cpu_down(void *_param)
 {
 	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
-	enum cpuhp_state target = max((int)st->target, CPUHP_AP_RCUTREE_DYING);
+	enum cpuhp_state target = max((int)st->target, CPUHP_AP_CPU_PM_STARTING);
 	int err, cpu = smp_processor_id();
 
 	/* Ensure this CPU doesn't handle any more interrupts. */
@@ -1303,7 +1303,7 @@ static int take_cpu_down_post(void *_param)
 	enum cpuhp_state target = max((int)st->target, CPUHP_AP_OFFLINE);
 	int cpu = smp_processor_id();
 
-	WARN_ON(st->state != CPUHP_AP_RCUTREE_DYING);
+	WARN_ON(st->state != CPUHP_AP_CPU_PM_STARTING);
 	/*
 	 * Invoke the former CPU_DYING callbacks. DYING must not fail!
 	 */
-- 
2.53.0

