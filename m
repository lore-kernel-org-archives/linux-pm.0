Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794942091;
	b=daDuq8Ihkki0b5jOx+42cGrmgS1S+zDaeuBwTtQT7OU3ogpME3kdJgOqA28KStekercK
	 MUOwQ65HBDkfukirw860VkK+V0NzcykMO+vkKQWzzOWSThxwjzcO/1wgFzO7tHL1PZ/Nw
	 AluPOESX8weUo6JBdvhN94gByxvblDq1XDQ4OAnMd8oPN6KelsRWacnIir8hcIMdA+Wxl
	 6zQU++WV6VBdGx8rdI8S2p3TBFwji6rQj7R1GpC8yOcH9g15CBI94hmFHPUYtw06XZRjL
	 ncd+5EWj8oPXB8luzxZnguaztCC8NdfUn3dv41wltvdTxg6lLE+DmftfmOnRyMPdLUw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794942091;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=NhoMDskPLY9jxDsoC7+1in5zPVLsgP3Ep+b9hOyyowE=;
	b=EygQsPk/+rcsVGwCSZIywiBKKJXGVtvFUTPJS5Sxaba+PTRDBdKls4Gu0vr2bAS8pXL+
	 aNc3zN6tfhXdhNLiSGlu4xivdXG+c6f2uEiW7u5J7evQ9MPB9FflLzk+mq9F6YODuugPr
	 0YOVTA85M1KUJ0MzhuBiZMrJ4R/A8wMa//zes20gAu/Z6NC3VzlEO2hCqOutbgb+Ij9dU
	 ziQFMu2Ml8+CNMITqJ6oN2/0bazfiTlz+pPLEEFevIl/AlbA8PaQoemTiScxKrH+wGvVC
	 av6I1HmVDDP/UXcbeNzvLCZSygbAVhFGvZHK6TjWgTSEaFcnOLX3najcuadvrlmKFpg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g2n0RKeB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE561606A31C;
	Tue, 17 Nov 2026 19:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g2n0RKeB
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794942091;
	b=GRnZ1rhk6whY5MSCpjqa9MextloGbi3Yl1zzj7kaU7qn5lKdAlqR60t/5YYr2R5vpTue
	 IczjBX3nqW9mYjjOlj72NPnieqCyKIdZBvagsC3TW5rOE1m5YKisiiV0Ls2B2zmyeEpIG
	 cBYNJNq56ad7I9edJu66ajQBbUh/JpDqFQNlfMt9r5N3gcBGJTKEKoHl7ufCw4Nvu2D3P
	 RJ39mX0FHUqhiKze4Chw5fqr5FwO8BzVzA57BgjJiz1TWJJVo6+itye86nfNFwG2UgRjd
	 10Lcft5uBD7rvgt8nzFmCUOYnRjQ5fZAJAh02nFmK5dRku3kPfeOgEplWNWlREOs3Pg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794942091;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=NhoMDskPLY9jxDsoC7+1in5zPVLsgP3Ep+b9hOyyowE=;
	b=yr9k3OldwlCbwQCtcoz5RpZpV3kGIGBePGbHEDgsvxQnzvpTrTW9d4sAZKb+/WYGYBGR
	 Xs0zSdT2uwJwvWe8eg92uVyMGRPCOMguX9TM/nV5B7kAMFDxZBS0KLxazyZcGhwf9perl
	 T6i2xDBbdcqnr6o1xEZVuKAQ20gR0r1I/wxrjLOybGn+IdvWDdltKmyVVScRgCVtMxHOU
	 mRyaGaSVyiY+BBE6RjOGnLhhUJsETEzO3TC1ElpGsziFPrduJGaJb6aKfpGcX2uemtkWQ
	 jxeEbVhdf8cdnHgT6KBJQU5mAHSgLv6GgyuU5JxNMVWpufb3aqPYqI2trhJyJati8Wg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 38B891F000C5;
	Tue, 17 Nov 2026 19:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794942091;
	bh=NhoMDskPLY9jxDsoC7+1in5zPVLsgP3Ep+b9hOyyowE=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=g2n0RKeBDfrAH0Hzm5jNnbMpthJvjaxMLNTCILM10iucJYPO8xUlEgKiAJjuc3B/P
	 uLx+h2dHt3Oe+vf3NK7dwFqx2rb+3gVXbwkMkdI+U8JHH/m2wncf4CJ8g82d2B0EQm
	 9aXpoNQmGuFnsxGTvnlBh6rhZGw9jsHh8RRWRKaVBSf7MwrNmsObCd/JEO0jpX1UsA
	 YW2i/jIuF4jFYh19pjXEN4vZAapKeokZfE87u/90WJuvgJSGLieuoc2ULg/PtMAVjo
	 YddS4BbyGgn1hbov51H7XPSdEadsfwSYnj9znoywa/8f7cq5jlZTLpo1UDFnphE1lW
	 5nkYbPLoL/ozw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 84EDE4AA65;
	Tue, 17 Nov 2026 19:01:29 +0000 (UTC)
From: Wondertan via B4 Relay <devnull+hlibwondertan.gmail.com@kernel.org>
Date: Tue, 17 Nov 2026 23:00:03 +0400
Subject: [PATCH] cpuidle: Do not reinstall the idle handler while paused
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261117-cpuidle-pause-fix-v1-1-b2789fce4c16@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMywrCMBBFf6XM2oGmWCP+irjIY7QjGkOmKULpv
 3eiy3PuYwWhwiRw6VYotLDwJymYQwdhculByFEZhn44GWMshlw5vgizq0J45y+ex2OIGvbRWtB
 dLqT693m9/Vmqf1KY21FreKdTX1wKU1NvJzMV2LYd3Br3k44AAAA=
X-Change-ID: 20261117-cpuidle-pause-fix-854cd6110d77
To: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Christian Loehle <christian.loehle@arm.com>, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Thorsten Leemhuis <linux@leemhuis.info>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5859;
 i=hlibwondertan@gmail.com; h=from:subject:message-id;
 bh=yzxZl4KPDFCwZKGEVvZatYF9Wv9r4O4+T52r9pIWSHE=;
 b=owGbwMvMwCW230B11izXCXcYT6slMWT9WdKRcFPlaeqtVcvzZ61rmpT7qLWNwVj8fzKnxm7Ta
 VnzfH8ydZSyMIhxMciKKbKwvTBVs2NQkD0zUbQFZg4rE8gQBi5OAZjIaT5Ght+ar1QmH1jKbeje
 YLrwh9FMvgk/ah1i30j+/KvyzePojkZGhrlSAn3elev1DlflXLhf7/l3xtaP+0xqNgsfWqJR/pB
 PjxcA
X-Developer-Key: i=hlibwondertan@gmail.com; a=openpgp;
 fpr=B881FDA34AD04D090E7E995C82711D6CF6F29BEC
X-Endpoint-Received: by B4 Relay for hlibwondertan@gmail.com/default with
 auth_id=1553
X-Original-From: Wondertan <hlibwondertan@gmail.com>
Reply-To: hlibwondertan@gmail.com
Content-Transfer-Encoding: 7bit

From: Wondertan <hlibwondertan@gmail.com>

The PM core pauses cpuidle before taking secondary CPUs offline during
system-wide transitions and resumes it after bringing them back online
(pm_sleep_disable_secondary_cpus()/pm_sleep_enable_secondary_cpus()), so
that CPUs do not enter cpuidle-managed idle states in that window.

However, with acpi_idle, acpi_soft_cpu_online() calls
acpi_processor_hotplug() for every CPU brought back online, and that
function brackets its update with cpuidle_pause_and_lock() and
cpuidle_resume_and_unlock().  The latter reinstalls the idle handler
unconditionally, so cpuidle is effectively resumed as soon as the first
secondary CPU is back online.  The remaining CPUs are then brought up,
and cache_aps_init() runs stop_machine(), with idle CPUs entering deep
ACPI C-states.  cpuidle_register_device() and cpuidle_switch_governor()
can undo the pause in the same way.

On a Framework Laptop 16 (AMD Ryzen AI 9 HX 370, BIOS 04.01), whose
_CST exposes C2/C3 with the SystemIO entry method, this intermittently
hangs hibernation after the image has been created: a CPU idling in
io_idle() does not respond to an IPI and another CPU soft-locks waiting
for it, either in smp_call_function_many_cond() (text poking from
sched_cpu_activate() while an SMT sibling is onlined) or in
multi_cpu_stop() (the MTRR rendezvous in cache_aps_init()).  The image is
never written and the next boot reports "PM: Image not found (code -22)":

  watchdog: BUG: soft lockup - CPU#12 stuck for 22s! [cpuhp/12:89]
  RIP: 0010:smp_call_function_many_cond+0x147/0x520
   on_each_cpu_cond_mask+0x24/0x40
   smp_text_poke_batch_finish+0xe2/0x380
   arch_jump_label_transform_apply+0x1a/0x30
   static_key_slow_inc_cpuslocked+0x4f/0xa0
   sched_cpu_activate+0x13c/0x150
  ...
   thaw_secondary_cpus.cold+0x5e/0xd2
   hibernation_snapshot+0x231/0x530
  NMI backtrace for cpu 0 skipped: idling at io_idle+0x3/0x30

  watchdog: BUG: soft lockup - CPU#3 stuck for 22s! [migration/3:37]
  Stopper: multi_cpu_stop+0x0/0x140 <- __stop_cpus.constprop.0+0x6d/0xb0
  (23 CPUs in multi_cpu_stop)
  NMI backtrace for cpu 2 skipped: idling at io_idle+0x3/0x30

Online CPUs can only be in io_idle() via cpuidle, so cpuidle was not
paused at that point.  Tracing power:cpu_idle across the transition on
6.18.59 confirms it: while CPUs 1-23 were being brought online (between
the first and the last CPU_ON "end" events, about 35 ms), idle CPUs
entered C2 263 times and C3 305 times on all 24 CPUs, the first C3 entry
coming 0.6 ms after CPU1 was onlined.  The failure rate was about one in
four hibernations, higher on battery; disabling C2/C3 via sysfs around
hibernation made it go away.

Fix this by recording that cpuidle has been paused by cpuidle_pause()
and not reinstalling the idle handler until cpuidle_resume() is called.
All callers of cpuidle_install_idle_handler() hold cpuidle_lock, which
also protects the new flag.

With this change on top of 6.18.62 and 7.3.4, the same trace across a
real hibernation and resume with C2/C3 enabled shows no C2/C3 entries
in that window (only C1), hibernation completes, and C2/C3 are used
again once the transition is over.

The root cause analysis, the fix, the tracing used to verify it and
this changelog were produced with an AI coding assistant (Claude Code,
model claude-opus-5-5), working from pstore dumps, ftrace captures and
the kernel sources.  All builds and tests were run on the affected
machine as described above.

Fixes: 8651f97bd951 ("PM / cpuidle: System resume hang fix with cpuidle")
Cc: stable@vger.kernel.org
Signed-off-by: Wondertan <hlibwondertan@gmail.com>
---
Tested only on the one affected machine (AMD, acpi_idle, BIOS 04.01
and 04.02): built and run-tested on 6.18.62 and 7.3.4 (Arch linux-lts
and linux configs, x86_64).  drivers/cpuidle/cpuidle.c in 7.3.4 is
identical to mainline apart from this change.  On mainline
(141b164bbe18) drivers/cpuidle/ was only built (W=1, no warnings), not
booted.  Not tested with intel_idle or other cpuidle drivers.

Earlier report of the hangs, before the root cause was known:
"[REGRESSION?] hibernation soft lockup in migration/0 after image
creation", linux-pm, 2026-07-09.
---
 drivers/cpuidle/cpuidle.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 2d2f40a2c..3e26b1760 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -39,6 +39,7 @@ LIST_HEAD(cpuidle_detected_devices);
 static int enabled_devices;
 static int off __read_mostly;
 static int initialized __read_mostly;
+static bool paused;	/* Protected by cpuidle_lock */
 
 int cpuidle_disabled(void)
 {
@@ -465,7 +466,12 @@ __cpuidle u64 cpuidle_poll_time(struct cpuidle_driver *drv,
  */
 void cpuidle_install_idle_handler(void)
 {
-	if (enabled_devices) {
+	/*
+	 * Do not reinstall the idle handler while cpuidle is paused for a
+	 * system transition, even if a nested cpuidle_resume_and_unlock()
+	 * (e.g. from the ACPI processor CPU online callback) asks for it.
+	 */
+	if (enabled_devices && !paused) {
 		/* Make sure all changes finished before we switch to new idle */
 		smp_wmb();
 		initialized = 1;
@@ -515,6 +521,7 @@ EXPORT_SYMBOL_GPL(cpuidle_resume_and_unlock);
 void cpuidle_pause(void)
 {
 	mutex_lock(&cpuidle_lock);
+	paused = true;
 	cpuidle_uninstall_idle_handler();
 	mutex_unlock(&cpuidle_lock);
 }
@@ -523,6 +530,7 @@ void cpuidle_pause(void)
 void cpuidle_resume(void)
 {
 	mutex_lock(&cpuidle_lock);
+	paused = false;
 	cpuidle_install_idle_handler();
 	mutex_unlock(&cpuidle_lock);
 }

---
base-commit: 141b164bbe186423e295b139e40e8e2d11cf1341
change-id: 20261117-cpuidle-pause-fix-854cd6110d77

Best regards,
--  
Wondertan <hlibwondertan@gmail.com>


