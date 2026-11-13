Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794532052;
	b=HC2RApITdoYBSwuIahXiLlruRRKKk5AnTJIZWt0MdUU55esNAiluk8cdB1UJcAWM8f7K
	 SdvlEet+shTZQjgUnWamf5Tp33epav+3J0ieoAVPwFYmEoCQqGcKbl9ZlY8EcWtUe/vgS
	 0mQDKQCy9Q3jun8y6l+Hx2EH7a+TVRtg6AzUbGsQqnU9Bg9lS2MwGoSONJ5vn1z33WlHL
	 z/dHBp6KqeAYBNQ9CpaaM/WsgduPhKdaELuzJoDO+gcETZBJmSxCba6OJhoVeX1xEfOrD
	 oFpSr8h0cGeVWWCHgS3elxpy49+yvElQLKirrtV8jPvT2AroUFWDC/zyJziKlGMLCNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794532052;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=y5dvtWN48Of2Ff8r0NZmrMSivJ/dH4bQ2NUxOe+Y+iM=;
	b=HlvVOp3xIKsVYhVnYp74BYl596Y8a64Pzwf1p6m6mEye4evoF5HXW4/c2fRIxcGsHLnn
	 7C9JC0EjMFt03+jHi8ZwZ7C+5HIQ8D6PEN7fIh1dwVaYwNpvd2+VIm97gSLJcqJx74nPV
	 xDddsmffQBpwQPtDmHSl2HMMPMZkIssJgrTLAm/XSFQUAZynmKlIIw+ZsZ/oG+HkN1dJ+
	 9q9mqMrf8KM499gjr3O0Dkb+BLW1fagcL3TvUTozLErL+W5YbEDi6VnjOpK/AGNlFuXz3
	 3RE+4Hf0Obq4++0Zb3B5+mnl7Dx7BTJpOtAAQVlYD1Fw7lO9L1IEoDTB9D7MiaFCZHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=alUUlNLL;
	arc=none smtp.remote-ip=209.85.208.181
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B12606A31C
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 01:07:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22B12606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=alUUlNLL
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3ad5529ae64so4815531fa.2
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 17:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794532050; x=1795136850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y5dvtWN48Of2Ff8r0NZmrMSivJ/dH4bQ2NUxOe+Y+iM=;
        b=alUUlNLLM4r23MzLGD6KSTwEjevaMWDBsZLRG3xpHOzByGGDfvG4Xk6K14kt9Sec/H
         I3rPYaJMhd67QjqEPCGq7qLBm30ePI2bgEBDuMDSRaYDDqQzrsb60JL77yR8lkxcvWc8
         2DC53lioLkxmqVK15Sf+Goxgqs4M2zOAan1FxU7PUGsdmwsonR/oF72DgKtpx1zC58qd
         RhU5XegWfbQRLn/hGCAc1XHwayw8DaWXC1YgY9LKA4pqa0dATyK9KpD8LqMM/ap6TlpV
         FCMUMeiBHVD46maIEjqVm7wWtwZeaOUf3IlKVYMNril7KkdaOaThhJeAK5EkzG83q3Av
         ZDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794532050; x=1795136850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y5dvtWN48Of2Ff8r0NZmrMSivJ/dH4bQ2NUxOe+Y+iM=;
        b=jAzzyjYkq8ucUN2fqTWfOlWYZAfjGHksX0SMLFD9iju6oQTp0kdjGDfF7UPfH6iZWf
         3SFEqKm0empDeRdGHFSJLPT5LRkxSM8Gmch8f+3hG6mpoiZF8lSwmpvTwxikrdtbZamx
         ZZX371N9v0AVpoVmJv4ZLTUtXIai2lEvo7IqaxA32QDtclJcUjJ3sLlrbPPTxUF+YvRn
         su+y32f4QQAUnTzoaQmjPi5BzQcog9758vIOBtuy/9WwDO/KqIuDZy5eI28DbiU2ZWEd
         JbvWda1IwqPydDmA3epQQBp81+Mm/oxnzYi2FjICRvfrtBrT/iFEuABtvE367t/B8Zjh
         LBww==
X-Forwarded-Encrypted: i=1; AL+hErFpbcvfxGHfChqPnMUxnADzOqWW4EyMi9AEhxIZBWx9NLHvWWMO9O/672McshJeL0XU4oVDIDjWUA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+ypImuhyqrITCrgj775vrmtHXLLOnZWXj8y9ChmcIIcbT6+W8f
	ug6cNaK+o26MJpYJh8IQb+hHKzL2BGFCciWsPMFBvxDvhfv5+VLc35At
X-Gm-Gg: AYBFou2uwQkSa0ZYvd8/8ZmAKmhhgMNc2xr+Qk9fd/mfEqvENlHka4ZD1zLcKRgRoza
	/rGfsAkFcEqKotASsFzYdCnVgsmA1Pv9W4V1Ca2fezKOoOnorUhzk9T5vIWb88f2peH/8ty6FZG
	lLdWtGriE3YmnO6tKx10DTnycwCCc4mxPjl27m44ND+Lwx9fhA57m2IIA+go5B8y+mrMlXcI1A+
	+XZlxmTwztmUx15q41tgrUqGvEJ3Qpip8fpbk0WzpTIUw0dA9vCeKU8tifOc/3lZEUhNDmMEmNE
	K2exBQhtBWTXDpNMs6fja8OirxcgKxH2q1JB+oJzX/GQHfzbeHS2Hj6vSQTBqH5/N+hBNIlEHX3
	/rC69KXuJfeeMhCaZDhuKLtVZC0pGBocpt683KfhqJ77rLxXfCQobVJxvZFc7y1syUWUF11TfzM
	PGsjBNf/PC7HsNVLaCEqMQsJfnjxChiksgnP8FL6mIAi5iJ4M5Pc8hZenCsSljsA9dDJDk4uN5P
	n/pNjnEr4CeXWv/o7Cn88F894o7c76tbLqpwDgmPhpiWeklhUQiUKqv/4kzH1o2Vh43xj+woEs6
	xg8AmBwqGUMCTQhSMUId1n2Hcl/19TCjOArwfuKDrh2R7lbncFpmoZkKmV2hbgO1saVMtkgBDxP
	6vuB+kp70D3SCIdN6g0pQcp9V3Axz9ZE=
X-Received: by 2002:a2e:ac0b:0:b0:3a9:abd6:1acd with SMTP id 38308e7fff4ca-3ae2b4b5d4bmr3909171fa.6.1794532050397;
        Thu, 12 Nov 2026 17:07:30 -0800 (PST)
Received: from SafoStation ([31.40.65.49])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae2b7d183bsm3133941fa.31.2026.11.12.17.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 17:07:28 -0800 (PST)
From: Safocl Stollmannovic <safocl88@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Petr Mladek <pmladek@suse.com>,
	John Ogness <john.ogness@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	printk@lists.linux.dev,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 10/10] kernel: fix duplicate extern declarations
Date: Fri, 13 Nov 2026 05:06:15 +0400
Message-ID: <20261113010631.139191-11-safocl88@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261113010631.139191-1-safocl88@gmail.com>
References: <20261113010631.139191-1-safocl88@gmail.com>
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

Compiling a kernel module with a C++ compiler results in a "duplicate
extern specifier" error.
This occurs because the code contains `extern asmlinkage`, and `asmlinkage`
expands to `extern C` when processed by a C++ compiler.
Since the code already contains sections that respond to a C++ compiler,
I believe it is a perfectly valid approach to gradually move toward a state
where kernel modules can be compiled by a C++ compiler without any issues.
The `extern` specifier must be removed.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=222257

Signed-off-by: Safocl Stollmannovic <safocl88@gmail.com>
---
 include/linux/lockdep.h      | 2 +-
 include/linux/printk.h       | 6 +++---
 include/linux/sched/task.h   | 2 +-
 include/linux/start_kernel.h | 2 +-
 include/linux/suspend.h      | 4 ++--
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index a6451ecbb..f436eab07 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -89,7 +89,7 @@ extern void lockdep_init(void);
 extern void lockdep_reset(void);
 extern void lockdep_reset_lock(struct lockdep_map *lock);
 extern void lockdep_free_key_range(void *start, unsigned long size);
-extern asmlinkage void lockdep_sys_exit(void);
+asmlinkage void lockdep_sys_exit(void);
 extern void lockdep_set_selftest_task(struct task_struct *task);
 
 extern void lockdep_init_task(struct task_struct *task);
diff --git a/include/linux/printk.h b/include/linux/printk.h
index f594c1266..09a28181e 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -136,7 +136,7 @@ struct va_format {
 })
 
 #ifdef CONFIG_EARLY_PRINTK
-extern asmlinkage __printf(1, 2)
+asmlinkage __printf(1, 2)
 void early_printk(const char *fmt, ...);
 #else
 static inline __printf(1, 2) __cold
@@ -200,8 +200,8 @@ void __init setup_log_buf(int early);
 __printf(1, 2) void dump_stack_set_arch_desc(const char *fmt, ...);
 void dump_stack_print_info(const char *log_lvl);
 void show_regs_print_info(const char *log_lvl);
-extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
-extern asmlinkage void dump_stack(void) __cold;
+asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
+asmlinkage void dump_stack(void) __cold;
 void printk_trigger_flush(void);
 void console_try_replay_all(void);
 void printk_legacy_allow_panic_sync(void);
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 90ed5bc3c..5cdef6b0f 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -61,7 +61,7 @@ extern struct task_struct init_task;
 
 extern int lockdep_tasklist_lock_is_held(void);
 
-extern asmlinkage void schedule_tail(struct task_struct *prev);
+asmlinkage void schedule_tail(struct task_struct *prev);
 extern void init_idle(struct task_struct *idle, int cpu);
 
 extern int sched_fork(u64 clone_flags, struct task_struct *p);
diff --git a/include/linux/start_kernel.h b/include/linux/start_kernel.h
index 09f994ac8..5855467ca 100644
--- a/include/linux/start_kernel.h
+++ b/include/linux/start_kernel.h
@@ -8,6 +8,6 @@
 /* Define the prototype for start_kernel here, rather than cluttering
    up something else. */
 
-extern asmlinkage void __init __noreturn start_kernel(void);
+asmlinkage void __init __noreturn start_kernel(void);
 
 #endif /* _LINUX_START_KERNEL_H */
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index a38150277..b97af3420 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -385,8 +385,8 @@ extern int swsusp_page_is_forbidden(struct page *);
 extern void swsusp_set_page_free(struct page *);
 extern void swsusp_unset_page_free(struct page *);
 extern unsigned long get_safe_page(gfp_t gfp_mask);
-extern asmlinkage int swsusp_arch_suspend(void);
-extern asmlinkage int swsusp_arch_resume(void);
+asmlinkage int swsusp_arch_suspend(void);
+asmlinkage int swsusp_arch_resume(void);
 
 extern u32 swsusp_hardware_signature;
 extern void hibernation_set_ops(const struct platform_hibernation_ops *ops);
-- 
2.56.1

