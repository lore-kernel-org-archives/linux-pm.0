Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63523FF1AD
	for <linux-pm@vger.kernel.org>; Fri,  2 Oct 2026 20:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790972908; cv=none; b=ezOZ9kOvKhdCaLofbydpypNimZCIXQIjQPRsprPxqCxdARNmCwt9HpSwapIgXT/w1U93fcI6OMlBdpqZO+MfcamHuL27dG6snUykAIZbuXKgjBT34hCNznM0guaz/FWtU/5SuDeQMOe4Z7WiGPRZAAMMYqgwNzeSq82buFcNthE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790972908; c=relaxed/simple;
	bh=oMrg/JcSLSgC4x3ZoCTn3lh3asbXbcffptazbw4Kz/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SagfWj+JZwif6O1cYdzL6WwD9tMhozTakyiJ5i1kNCX9jJlk0jLN7n92NAibHV0GrGFAE2gOc0WJYdAmMSLBmAj+s6cCAxB9JjIb28cQSeour1fraNnESlW7duSu/exxMWRqOl74ROG8B6ohGL6jgIcGFoN319EYeu4UVxOdBeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wl5w8h1J; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wl5w8h1J"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48b059eae96so259351f8f.0
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2026 13:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790972905; x=1791577705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0Pq1olcgehbSi55FB4Scf0q8Uf4BPvEP/mIxGiWXIGM=;
        b=Wl5w8h1JNRBeU1ZCpeMxtl6SrSV+w81LHOZKLXZYvHD3Ybex1g/QULNb21iCEMLMen
         yJiJsANtq5AT/nhp181k273RC1J5hYO1oUCpFk+PhjLQ0fz4IWpQQ2kw5kEy/+p9k4yw
         OWa4zkTY76V+ip0/Md7+WvW7eRaWXFo67FIkBWlLDwULr1cq6rvIgh7PbaqK6eCO9zWr
         19UYZ4rPtrXJo20VprsBMjJ766gb3CtATjHv6a6ZVDFptalt0oYvzEb1Tio6x8kRDTGs
         RV7WeRTGhRPth2jEo2ly1WM5fLrZSxUX9X7d+vfCIwiZbob8b/UJZqY7wDyV2MhKPwH1
         rdhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790972905; x=1791577705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Pq1olcgehbSi55FB4Scf0q8Uf4BPvEP/mIxGiWXIGM=;
        b=WgCrd4mJCBZt7a6dtoOWmBIrqym4auHIv0e+O4g2szIk9qDsA17HuNLvG8ihkJVJ8f
         HL9oGq+XEtBJoglxKV4SZV90hOFQEmTrSd8c7Nfin1lTeDkVACMofBa5DYUfn8XDMSsl
         FFvgTTqGRLC2DuRt26Ug1LDxEgOJ8k7yNt3vyw+a2CgDIV7y6QLeL9x4mEEA3Qad323N
         cOsNCxzxI/oIceJw1xMDGGrFba6zcMz6jiiloJKsTB5IitkQByAv299mKUlh7SjJDrDf
         +NdWhNJe9c3z8HwCuTR5BFh4YTFX/N5s0+wtmqg6iDzuZCfro9XMB6pVAOGKN6ZxHBIc
         c5dg==
X-Forwarded-Encrypted: i=1; AKwUvBxtXWTRFGKyT567yI9zNFjlBmmqkBbCrZG+Q0TGnciEPoGYSFDt2XYJCUSArcVzr1+TsEKfV7OewA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ1slsoeAykVRBcnHTTyl5EF5mQMNjs265cKbmRY/i08YXps+Ze
	iCixxoKAhmYsxmoCrCqp9slf+0bqOBxc1Pe2qrspH1Eovivpznt88u01
X-Gm-Gg: AYBFou3o6o0B0Y2Q28IiD4AuRYcMETKkyhebcH1KFuF68iLlLHRlE48tatdC7VupZlN
	IKNP0+T/UKD+Hzk/1s6ePkBm3MM70huDu27ZuxoolLFORGg3HJpX71Vo8kkkCXGQqqbBjUzpB3U
	uc6e8NQHKgCeze1Z2p2f0z0w8XAEaImUEB3Z4PTf2lvmox7r4Fg35mqyu7lJJgLRwn62hohIXS6
	XzP6VZouTlnsMuJXiR9Stxg/e/nIwBtR0JMUgt+RvxSqgG0WGNY3CkJ48QDmXxf7i9dr4hOvo3b
	GRZC+VGIjt+kVUQwxVS42/9gGGvcr47FR1pC8x/Ip2TZoC/MrOlzOmq2hgs+zuZnwsfkXdiQ+SB
	wt6a+55PHMZGIrEreigt3763PyrQyc/76ocYdfEABVKHzWc5TKPRtdUJV9XVdkTHM4Top6nPeNQ
	4UFkRFwy0LfmDdrZto1dAv58FdKfjFvbGpajeBKmy9sQZ8Qkk6puSUAVyE0HsimPcGAyNXwDNsY
	Z83ueXd0X9fwnUiBVuSTh7Oyv1zXHG6QrfWMNOkPnU7sqX1gUXl/f3KGnEh+rc0mg+po5xIlVPO
	OutUDw==
X-Received: by 2002:a05:6000:605:b0:488:89af:e95b with SMTP id ffacd0b85a97d-48b126d2949mr7371021f8f.8.1790972904852;
        Fri, 02 Oct 2026 13:28:24 -0700 (PDT)
Received: from arch ([37.142.150.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b38104d58sm8334335f8f.28.2026.10.02.13.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 13:28:23 -0700 (PDT)
From: Aviv Vaknin <vaknins33@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Bradley Morgan <brads@mainlining.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] pid_namespace: make zap_pid_ns_processes() freezable
Date: Fri,  2 Oct 2026 23:28:20 +0300
Message-ID: <20261002202820.3433318-1-vaknins33@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the init of a pid namespace exits, zap_pid_ns_processes() waits
until all other pids in the namespace are freed. A tracer outside the
namespace that does not reap its traced zombies keeps those pids
allocated, so this wait has no upper bound, and while it lasts every
suspend attempt fails:

  Freezing user space processes failed after 20.006 seconds (2 tasks refusing to freeze, wq_busy=0):

Neither wait is freezable. The first loop sleeps in do_wait(), which
returns -ERESTARTSYS on the freezer's fake signal; the loop then clears
TIF_SIGPENDING and waits again without ever freezing. The final loop
sleeps in TASK_INTERRUPTIBLE, and since nothing clears TIF_SIGPENDING
there, schedule() returns immediately after the first freeze attempt
and the task spins until the wait ends.

Sleep in TASK_INTERRUPTIBLE | TASK_FREEZABLE in do_wait(), so that the
freezer can freeze tasks waiting there directly, and in TASK_IDLE |
TASK_FREEZABLE in the final loop, like coredump_task_exit() does.

This was hit with Chromium-based browsers: crashpad ptrace-attaches the
threads of a crashed renderer, which is a pid namespace init, and does
not reap those killed during the dump.

Fixes: 3eb07c8c8adb ("pid namespaces: destroy pid namespace on init's death")
Fixes: b9a985db9896 ("pid_ns: Sleep in TASK_INTERRUPTIBLE in zap_pid_ns_processes")
Cc: stable@vger.kernel.org # 6.1+
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Aviv Vaknin <vaknins33@gmail.com>
---
v2:
- Make do_wait() freezable instead of calling try_to_freeze() after
  kernel_wait4() (Oleg).
- Drop the comments.
- Drop the acks and the review tag, since the approach changed.
- Retested on v7.3-rc5 with the reproducer from v1, also unprivileged:
  freezing completes in 0.001 s, the zap task stays idle, and reaping
  the zombies still ends the wait.

v1: https://lore.kernel.org/r/20261001121254.883973-1-vaknins33@gmail.com

 kernel/exit.c          | 2 +-
 kernel/pid_namespace.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 97686af89..b54cc7b2b 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1751,7 +1751,7 @@ static long do_wait(struct wait_opts *wo)
 	add_wait_queue(&current->signal->wait_chldexit, &wo->child_wait);
 
 	do {
-		set_current_state(TASK_INTERRUPTIBLE);
+		set_current_state(TASK_INTERRUPTIBLE | TASK_FREEZABLE);
 		retval = __do_wait(wo);
 		if (retval != -ERESTARTSYS)
 			break;
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 8bc9edb40..127a5fd23 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -269,7 +269,7 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
 	 * free_pid() will awaken this task.
 	 */
 	for (;;) {
-		set_current_state(TASK_INTERRUPTIBLE);
+		set_current_state(TASK_IDLE | TASK_FREEZABLE);
 		if (pid_ns->pid_allocated == init_pids)
 			break;
 		schedule();

base-commit: ed14a591175bb5f56c2936b082cffb9e4b935e6d
-- 
2.55.0

