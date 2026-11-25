Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795645375;
	b=XsoSN4Hx/zyQcfRVIDEQuduf8Mbbm/pU3JVIgxdbwFTg0cOtus48fsTmZZ6EYQUzeGVG
	 weyi1MZSR+H2BKm0MOayRWget5EnhQHRu1T+D5g42XO7nFaoBXVZBWujHwoyzSFW9115n
	 +iJuw5fViWx4cFVrWApuAJ4T3S0TIpL7a/8Zk9dcN0fWey9paJ7zyDC2nHHob72mvc0MA
	 D+BanjfjfZhnVKlctFIdoQTTpGEAGQCNOf7JIN6UFsxA7/LdiEtjta6lemuWNNqUI+F1W
	 GECMjiwyUFTreXfVct51YvA5Mtefu+8yHy/nt7eAVAgK8zSOjSAIp9S7bUiMq/pKDlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795645375;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aamSgS9mN4fl3LNN9RVzzpQBmZHNs4ovTx1ZPQ9tpB8=;
	b=K8L8Jh1jeJfmFUjacrtGFd8A7Z+2s8gmY2pfjU55yk0T3IvRsWIosw0E+mYxQEjuX4zZ
	 Zr4WJLFAHXRgqLWKxHc4R0WKiVVycQF5dysJHYpMGDMWHsRslEe3EL3sn55WWoUidpXeV
	 ZQipRcLI7RbyHN7Wx7abogn2BLRNgLhGycZQeOO+g2I4ZopqOFVZgKELRORNjKwCZyz34
	 a1gDYQ1SHguPkFbYkN/A6mQMKjrMIvjGVL0+OO2lnoik5iOMbIjihnArBlrs1NSgSHECa
	 QOg1AL5wPComeBElG6FqWG4SkBxVP78qEqPgpwCsJJvIeiWZZdZb0wQk7jPIIX4sB2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K706cijN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C528606A31E;
	Wed, 25 Nov 2026 22:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K706cijN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5867D1F000D0;
	Wed, 25 Nov 2026 22:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795645374;
	bh=aamSgS9mN4fl3LNN9RVzzpQBmZHNs4ovTx1ZPQ9tpB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K706cijNYCe/Yc4AIzTkXKGEAkwDYfOsOKxwbipF3DsJfyYuEBvXcyst/xMEQLsxM
	 kdgxMLYhRuzuKHqw7MFQzMj2kW6nkuGDBmnTt5BLfzDtXRVE0omCsx2BmeH4hWw/NQ
	 UjmsAAcJXxuWAPvTOChX265gFU3fmuCHBsDmJX2jgsc0sLoKGiqy56UXdFNnjXPL+1
	 z5oKvNqof8cC+uCQo7XPJpPbQR0rYi8mJ2Pq2S1OvjgXKGL8jYNn6AbwqvaN1axuk4
	 2ENr+aEjSdN8h9SCofQFCkpj50JUfiNU7JdBIlUyXtSP6gWR9L8S+8yYiMDJVUtn8F
	 Q7oD9u3Qj7tzw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
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
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH 05/47] cpuidle: Move CPUHP_AP_CPU_PM_STARTING post stop_machine()
Date: Wed, 25 Nov 2026 23:21:48 +0100
Message-ID: <20261125222230.22508-6-frederic@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125222230.22508-1-frederic@kernel.org>
References: <20261125222230.22508-1-frederic@kernel.org>
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
all the teardown callbacks while temporarily stopping/pausing all CPUs
in the system. This doesn't mix well with running RT or isolated tasks.

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
Tested-by: Michael Kelley <mhklinux@outlook.com>
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
2.56.1

