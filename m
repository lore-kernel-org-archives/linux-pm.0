Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FAF4E50A2;
	Mon, 19 Oct 2026 13:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792415361; cv=none; b=jrVo8ijAN0vV6dJWnoaAwkyiYBx24iTS/Fu1ANVC2JAG+5h/C5Pqx6HaexlTC4S5WWQsqVfB3Az8LGH9WwaJw1vS/KQBh7xcKRbsOSmK9oY+qJXs6h4/qrm1rgergFZ4aWomujhYgYo66eylDvy6h/d6JeqzjJfRc8Su7eH7xZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792415361; c=relaxed/simple;
	bh=rhv2UaoggFs3LA4ULpdTxBNxYtRORs+lUlnda9mV+rA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s6vhKbeilNHSjiaLlagnmB1y7QyCzqxtv9VVwtAHhc73rRXr7WXNzLb2Qd+mYsIgpNujmDB6ZtQWrPaFwOATImZyLym9WynScnlwsBRPWuBh/x/CykARLyHMkpNapf5xUa/XzDdDJl0kQ/rPDY2Ih/pmG3p3wzCkSF2MSZ0SoBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIAKJ1bf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIAKJ1bf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629221F000C5;
	Mon, 19 Oct 2026 13:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792415359;
	bh=uVTV66EQARd6AtvNeKLH6twwh1vHhGz7zukKT167vwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KIAKJ1bfFSWtcXVF1B2lkRTfoMjdHlc2fA5Q+C67CfWsLwT1edMHgtPraNrtsjBEF
	 yWtU+FF7QvhQWJHlZubj+2QyUSZ1EH7SoI6q7hmKjQ9mRKTJWP5Rxc5FiioznW+Vm2
	 5SxGQxzJF0TxYJf+Yd+RDdgeJ/g42xzBW5j0pTwxB6XQKtB8C0z+ErF7/9OxWjSeB+
	 G0kRqhW4uIPJgKM4e6GsLkt0bN7xLVEx+1UzyyN3/H65cAfb065FwQgXnzF/BSpQf8
	 UoCfepbafHWusQM6FTjEA8pmrtDrYIrje2rJSXPT5eUQVUGYLrvV4ILklvRRdd7jZ5
	 PzbsaxOVuubWA==
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
	linux-pm@vger.kernel.org
Subject: [RFC PATCH 05/49] cpuidle: Move CPUHP_AP_CPU_PM_STARTING post stop_machine()
Date: Mon, 19 Oct 2026 15:08:12 +0200
Message-ID: <20261019130856.49711-6-frederic@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019130856.49711-1-frederic@kernel.org>
References: <20261019130856.49711-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
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
index f22afb213d6f..68eb8de820d5 100644
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

