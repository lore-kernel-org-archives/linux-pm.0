Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794528938;
	b=3uzctx1/lbGDvhr2cfJYt0KDH2dw2VM6+tGn7bAciZ6Nd6V64ZcIwqRe8qTBhs8ehQL3
	 Xp73hB0SucsFypbxK7yHNYpVXDdXB2mXReoFlq4TawgDN6f+UdyQd97ROM5/MwxU1k1bd
	 UedNcRqiAev8m9zz9SLTfH7b6cNdiTwfSlkRUWz8Z+VpaxupAHmIT/MxVQiS9boork9/k
	 k0kvlOIOYbrZ1gwMXmb/9X8EXUVY+E2A7s6nvYagdfHLtO4HglTdMJSsT9I3W726Te9hB
	 lPOuuX+RLL6vFlieDJy1ZgcwdB408YictZnLyoFK++tIZG8J840u51oE0bjKWOwBliA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794528938;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Fy4WFW4Td97IvBSVlIHdYeCc7+bBQ4nJWzT+60QtQBo=;
	b=EXKN2SR9eHEx6h9AxpQ1MChyZK+uF0wUaR2ST7nLMQsuMC4iywhMieSfMvLkFjF8aKZI
	 RRa6zzQxOu6Jp7tAPm5ewKcvistqfdTbc2Ft9LnGejv0A9Y/lNh2vES5DduMMIHCp29TE
	 QTmCfVG5eifh/M9Ui0W+m1HIrSce4CWbuPyxWdT2xtkrrAFMNf24+0qkBm9++nRkWZUaz
	 bvl2EYwCVUlviDRc87A+RYam6XMCoFnjL+ypM8K49dUkPYJ5jYhs7DsSMYU/s87Jq03oU
	 L9zdxTXyvIza90vr2znSzDXh0DFxRy0V7DAqnCzc91KgloqlK+GC6FGpSNcWmrGBgfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SVpco5us;
	arc=none smtp.remote-ip=209.85.167.41
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD01D606A31C
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 00:15:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD01D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SVpco5us
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5c10dc41270so483014e87.2
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 16:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794528936; x=1795133736; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Fy4WFW4Td97IvBSVlIHdYeCc7+bBQ4nJWzT+60QtQBo=;
        b=SVpco5ussGSCn0fL6muNLwvqer8Lfpvi+E1CqTTeZQuBkCxJvHQ+N3hG4z/neEEgeW
         h3Dnsk4ODSPGYETfVQigcz8D1w5UlcfpZEw7fDWzdQbGH1sMN1vYtXIV3m01bKXyQ8oU
         JUXfQ2y71PKrIJcmlsiDFUsaQY43MuF/A8XVstRowkQperjX+WimCda4RWnVkEUYcQ+M
         liRsSNjupGie/ThC9MnIWL8b1Xs0K85L+6wal0RKS135Okd+DXFOMiQ/QgSQ2zn5THf7
         r7nsEFCRN6U6Ohlawpxl2uEp7qpxTSsSiHn7ug3rNkQRAV2TR14ztfggqPcZIOmhMNSN
         Oj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794528936; x=1795133736;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fy4WFW4Td97IvBSVlIHdYeCc7+bBQ4nJWzT+60QtQBo=;
        b=BqAm5PYMHVky4dVMt5qQSKHwERAIkAFWRIkkwMA3ss0X8kKBV+I1wN+/u4pg+VtQ40
         6ALvQyn9gIsjZVTAcOdUbLzGFl/GvmEPdh70+0WvG/+5Fi3oqvGJoAlSIq5dtZDv4HFv
         mll9qv6uPaNg3h8aJUMsVm+zlpYUHPKlDaYVLNtCKaOe3WF/PUhnrWk+ZoilNXgDqYYq
         DNYHQX1hdCjJ/xMZ+Xup41jhWq+r8z2siGqqKew0JKVmlPy0fFBwuNaN0eVpvH2d+oPc
         zrJBzyDO2AUbQOymvM4vokQetUxbU6IG5j0svku5g3iwopk51GWpeo04czYMfHIGk2cy
         I+qg==
X-Forwarded-Encrypted: i=1; AL+hErGBp0Z9TiT8bhsQK9Q/l9Ctu535YamSHFq5HeAe1KHUU4TCR31D5XLxuAhzdmqfkHNF4c1/+7MjXg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9xynr21hsTEoLyMF/ydaCKWg6XjXK/ZptZ8uK1Cn0teZHxLCta
	5d0t7szR/f2vR3t97jh2RY4M9EbEXdGNPXrCKiJgo4rPIOQO+iOsLBrV
X-Gm-Gg: AYBFou2unwu03pXWlpzvahZMQbl/P5dpWi+gufNzjWKaAf43+OOlU4w7ccV6qszYMJt
	txskkE3+j7w+hj4C9R5/qgT6R6O0sqFOntfteTNguaCLMFDAXK3F3U9+U9kPaKr4KvEirN0cQW0
	RJx1v4njehmHrAPjkymRsJgVP7bpPw2Hqnghrs0GRVGGGMFrIi+KPZ18Xrli5TsM42x1Avtqs9y
	wQ10DYo7/HjyZ72Hf4sg1ysl5vYwFO+QjXfdyTg/5k9D2jSHNDFq3ZEA/WWCoW6kyRwPMHYk+Uc
	OAvxpWecfsIHNI+s6r07SxSkNXJ9lhboKwdymS95Vej61DH/5nqgncwvspEre+3zqR3zWm+zcCG
	V7Bu18LB9s666Zzy2jg8zFTI5naKct5UNtSdVKE3zBzPa83Rj2aXFzWqfc6QqmXLVmRXtBt/xry
	bkxboppzBwxepWxx9VYplqsWeU+uZDsjFC/kqCfRuqlmSKG1hjhY3iitvQ/2XUHG64FpIU90PXD
	yfv1kd70ffXquiTNq6UDrpO21I2jDQATa+yFNP+ZczGonE29zKy3wVyY9nyxNYxoErOxFuStp9J
	ACX5aILd4f5xByB7T8TVcHyUWBKi67+/uYNLv0Jg3VCeODqIqHfnh1xMuuPhtQrjJEBYlZjXxT7
	I1H0fmwDLsg==
X-Received: by 2002:a05:6512:a8c:b0:5bf:ce85:50e3 with SMTP id 2adb3069b0e04-5c170a0f613mr334159e87.42.1794528935920;
        Thu, 12 Nov 2026 16:15:35 -0800 (PST)
Received: from SafoStation ([31.40.65.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c17133ca01sm200968e87.36.2026.11.12.16.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 16:15:35 -0800 (PST)
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
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	printk@lists.linux.dev,
	linux-pm@vger.kernel.org
Subject: [PATCH 10/10] kernel: fix duplicate extern declarations
Date: Fri, 13 Nov 2026 04:14:16 +0400
Message-ID: <20261113001432.128201-11-safocl88@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261113001432.128201-1-safocl88@gmail.com>
References: <20261113001432.128201-1-safocl88@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Compiling a kernel module with a C++ compiler results in a duplicate
echo ‘extern’ specifier error.
This occurs because the code contains , and
expands to  when processed by a C++ compiler.
The  specifier must be removed.
https://bugzilla.kernel.org/show_bug.cgi?id=222257

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

