Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B541FA859
	for <linux-pm@vger.kernel.org>; Mon,  4 May 2026 02:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777860036; cv=none; b=jRQPmqZ3QArybFHhBNqOq3E3TsnrR8Dj5+JYFZgmVDc/csINtmHBAHSyOQWb8Q/7XBWYkHvlq4TIWEA1o5FVEEizkZu7fwSy8JiLht97TJLoyvaldol11C/25gk46RhQdHciojMTiOe0DzSy1tDQp7v3pXuv7WhOR7GfQ00QbeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777860036; c=relaxed/simple;
	bh=hxv28qxiMM010BdFmcLfqx6u+OZbFpQDMqKxGnS6oKY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uUAlPWk29J8DitvJh15ypTiWwrd4YBsgyos9kU8aUJsnc2tLgVpXlZK/KTxFblLsOxTOM22jGS3RFC5h832MS8ZG4N/65U1QBtOOXJH8WUB2BXKijTWlxEpntfs8q18NB+qv2dYpOwbqhcb8pXNth3UoLWY/yT1x3QimAGLHCGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b=zu9Unrok; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b="zu9Unrok"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so22564685e9.1
        for <linux-pm@vger.kernel.org>; Sun, 03 May 2026 19:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20251104.gappssmtp.com; s=20251104; t=1777860032; x=1778464832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USUCVKbkv4JKoHCWAtwT6K9NM/4+6hSZ3/jRvhM/sQw=;
        b=zu9Unrok4YQN+miG+9dvnNLc0KbBr/6abE6Q/T9dtib9B6WknldmHmJe2GVcN5duGe
         IE/1T4wqboJbHpzpmLHGMNbnPAQ7JK8NmTL2Oxq4EsiHYIieBNCLahSdamHFkb3aCeek
         uxKKjIMr0HKOhJO03vhAEgXMy7DolujC8XlilEZoAcTn6EzdjJGeqTTjg+OO62KRdkPd
         bpAv9x0O0lQLhwVszj+NLUbeB6BvsU4oZRBVyc/cFuXcxc2gBTDVcQoezGgsIm6RObhO
         Opf1KSRPSpAvkXNMNPo7MJhU0Idb26ZPEdV8zitz4z5cZPuiwEqicC+HedCXwfUmsxhU
         ecHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777860032; x=1778464832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=USUCVKbkv4JKoHCWAtwT6K9NM/4+6hSZ3/jRvhM/sQw=;
        b=SJHRLDr9EwGUYXhaqEFBzCn4H9gRNA9+lS7UsSylqsiBzhdL52eDLLWbHeBEwyaobx
         06ET8Y2JElfaZebrsVsYXXahtz4JQrSh4G5mKOMtINLL+NR+l/LdS7UOJkBDvbq/GZ/L
         qQiv9A/psU8xujgELSa/FAqKqe8FffH6iIEabaYm5xDOuTp/9vfWiGSSXo1l+hYuCSPu
         pwqQFuxFRCf2Q6D1LK4Ohj86W8FODLCy1aQ0S1XKS5QXULjq75sIsbepQhD5+wR83pNq
         8SS6m58TikfFob74rvIt7R205AjLI0Ayhkr71wuECtufh7sjqBqwtgARl5CKSMhK6QgP
         MXaw==
X-Forwarded-Encrypted: i=1; AFNElJ/bY8wej8jU0bStQC0tvNFxDf873PJYjhluAyqsx9nUk3wPZd70S3Jdv+52WXSPcLl15RsPso3NLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTViKLJLDt7J63EmGs+0D/Ogjnx3KZ7P9CRboNuN+T4kxFQs3r
	USsd/55Wh1uvasXkfz81MNrpjKtNoacs+tsWyaNWMyZLLfpi1wkbqJ5waUSK8G0GDYE=
X-Gm-Gg: AeBDiesuF05Ru6+k6Uz0XdT38qHPIM0q7HowefsNuL4sAJuxlkb2zC6za4gKpfiaBJ3
	HCQe7DCtN4nyrJTs0L+EWZVTW+ouzJN3cRLx5nxEs0dPe8qZXhyU2yThAwLdMYdoSOsqILmZjF+
	XHp8cfRLEhSLiw5Lh2UEThYfFBoIwXJz9/Y80GoUXRE1rj8Drghw4cMOfxRVISyYm+isROCqVDT
	/nmJAbm5K6G067mBfwooQ4bUHe0VyTAqScriQnKBQ9oGqL2rW9yvqy1r6RZqGmpbE5UHgDLp0BO
	WETmF1FXEbDF1yWQR7iq+BlFUfnCuW2nVnvZAMeVL5uJB3oaH0c3kZ5tLlcOLA0I6u6oVa2HWIN
	dWL0VD+2qw1NBfR1rGfHt43OSkvGqPgTQZG/YowJ9Pot0BMNGXiNLhoiOj6Tn5qO8LQzx2sGKXl
	CRLSY2+8UM8OfQCFMquDH2lk5zUflF8EtwdxUwsKSdxw==
X-Received: by 2002:a05:600c:a410:b0:48a:761:5816 with SMTP id 5b1f17b1804b1-48a970c1bc1mr97344565e9.8.1777860032194;
        Sun, 03 May 2026 19:00:32 -0700 (PDT)
Received: from airbuntu.. ([146.70.179.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fee5033sm68064215e9.22.2026.05.03.19.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 19:00:30 -0700 (PDT)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Stultz <jstultz@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	"Chen, Yu C" <yu.c.chen@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v2 RFC 08/13] sched/qos: Add a new sched-qos interface
Date: Mon,  4 May 2026 02:59:58 +0100
Message-Id: <20260504020003.71306-9-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260504020003.71306-1-qyousef@layalina.io>
References: <20260504020003.71306-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide a generic and extensible interface to describe arbitrary QoS
tags to tell the kernel about specific behavior that is doesn't fall
into the existing sched_attr.

The interface is broken into three parts:

* Type
* Value
* Cookie

Type is an enum that should be give us enough space to extend (and
deprecate) comfortably.

Value is a signed 64bit number to allow for arbitrary high values.

Cookie is to help group tasks selectively so that some QoS might want to
operate on tasks per groups. A value of 0 indicates system wide.

There are two anticipated users being discussed on the list.

1. Per task rampup multiplier to allow controlling how fast util rises,
   and by implication it can migrate between cores on HMP systems and
   cause freqs to rise with schedutil.

2. Tag a group of task that are memory dependent for Cache Aware
   Scheduling.

The interface is anticipated to be provisioned to apps via utilities and
libraries. schedqos [1] is an example how such interface can be used to
provide higher level QoS abstraction to describe workloads without
baking it into the binaries, and by implication without worrying about
potential abuse. The interface requires privileged access since QoS is
considered scarce resource and requires admin control to ensure it is
set properly. Again that admin control is anticipated to be the schedqos
utility service.

QoS is treated as a scarce resource and the intention is for the
a syscall to be done for each individual QoS tag. QoS tags are not
inherited on fork by default too for the same reason.

A reasonable point of debate is whether to make the sched_qos an array
of 3 or 5 value to avoid potential bottleneck if this grows large and
users do end up hitting a bottleneck of having to issue too many
syscalls to set all QoS. Being limited as it is now helps enforce
intentionality and scarcity of tagging.

[1] https://github.com/qais-yousef/schedqos

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 Documentation/scheduler/index.rst             |  1 +
 Documentation/scheduler/sched-qos.rst         | 44 ++++++++++++++++++
 include/uapi/linux/sched.h                    |  4 ++
 include/uapi/linux/sched/types.h              | 46 +++++++++++++++++++
 kernel/sched/syscalls.c                       | 10 ++++
 .../trace/beauty/include/uapi/linux/sched.h   |  4 ++
 6 files changed, 109 insertions(+)
 create mode 100644 Documentation/scheduler/sched-qos.rst

diff --git a/Documentation/scheduler/index.rst b/Documentation/scheduler/index.rst
index 17ce8d76befc..6652f18e553b 100644
--- a/Documentation/scheduler/index.rst
+++ b/Documentation/scheduler/index.rst
@@ -23,5 +23,6 @@ Scheduler
     sched-stats
     sched-ext
     sched-debug
+    sched-qos
 
     text_files
diff --git a/Documentation/scheduler/sched-qos.rst b/Documentation/scheduler/sched-qos.rst
new file mode 100644
index 000000000000..0911261cb124
--- /dev/null
+++ b/Documentation/scheduler/sched-qos.rst
@@ -0,0 +1,44 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============
+Scheduler QoS
+=============
+
+1. Introduction
+===============
+
+Different workloads have different scheduling requirements to operate
+optimally. The same applies to tasks within the same workload.
+
+To enable smarter usage of system resources and to cater for the conflicting
+demands of various tasks, Scheduler QoS provides a mechanism to provide more
+information about those demands so that scheduler can do best-effort to
+honour them.
+
+  @sched_qos_type	what QoS hint to apply
+  @sched_qos_value	value of the QoS hint
+  @sched_qos_cookie	magic cookie to tag a group of tasks for which the QoS
+			applies. If 0, the hint will apply globally system
+			wide. If not 0, the hint will be relative to tasks that
+			has the same cookie value only.
+
+QoS hints are set once and not inherited by children by design. The
+rationale is that each task has its individual characteristics and it is
+encouraged to describe each of these separately. Also since system resources
+are finite, there's a limit to what can be done to honour these requests
+before reaching a tipping point where there are too many requests for
+a particular QoS that is impossible to service for all of them at once and
+some will start to lose out. For example if 10 tasks require better wake
+up latencies on a 4 CPUs SMP system, then if they all wake up at once, only
+4 can perceive the hint honoured and the rest will have to wait. Inheritance
+can lead these 10 to become a 100 or a 1000 more easily, and then the QoS
+hint will lose its meaning and effectiveness rapidly. The chances of 10
+tasks waking up at the same time is lower than a 100 and lower than a 1000.
+
+To set multiple QoS hints, a syscall is required for each. This is a
+trade-off to reduce the churn on extending the interface as the hope for
+this to evolve as workloads and hardware get more sophisticated and the
+need for extension will arise; and when this happen the task should be
+simpler to add the kernel extension and allow userspace to use readily by
+setting the newly added flag without having to update the whole of
+sched_attr.
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 52b69ce89368..3cdba44bc1cb 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -102,6 +102,9 @@ struct clone_args {
 	__aligned_u64 set_tid_size;
 	__aligned_u64 cgroup;
 };
+
+enum sched_qos_type {
+};
 #endif
 
 #define CLONE_ARGS_SIZE_VER0 64 /* sizeof first published struct */
@@ -133,6 +136,7 @@ struct clone_args {
 #define SCHED_FLAG_KEEP_PARAMS		0x10
 #define SCHED_FLAG_UTIL_CLAMP_MIN	0x20
 #define SCHED_FLAG_UTIL_CLAMP_MAX	0x40
+#define SCHED_FLAG_QOS			0x80
 
 #define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
 				 SCHED_FLAG_KEEP_PARAMS)
diff --git a/include/uapi/linux/sched/types.h b/include/uapi/linux/sched/types.h
index bf6e9ae031c1..b65da4938f43 100644
--- a/include/uapi/linux/sched/types.h
+++ b/include/uapi/linux/sched/types.h
@@ -94,6 +94,48 @@
  * scheduled on a CPU with no more capacity than the specified value.
  *
  * A task utilization boundary can be reset by setting the attribute to -1.
+ *
+ * Scheduler QoS
+ * =============
+ *
+ * Different workloads have different scheduling requirements to operate
+ * optimally. The same applies to tasks within the same workload.
+ *
+ * To enable smarter usage of system resources and to cater for the conflicting
+ * demands of various tasks, Scheduler QoS provides a mechanism to provide more
+ * information about those demands so that scheduler can do best-effort to
+ * honour them.
+ *
+ *  @sched_qos_type	what QoS hint to apply
+ *  @sched_qos_value	value of the QoS hint
+ *  @sched_qos_cookie	magic cookie to tag a group of tasks for which the QoS
+ *			applies. If 0, the hint will apply globally system
+ *			wide. If not 0, the hint will be relative to tasks that
+ *			has the same cookie value only.
+ *
+ * QoS hints are set once and not inherited by children by design. The
+ * rationale is that each task has its individual characteristics and it is
+ * encouraged to describe each of these separately. Also since system resources
+ * are finite, there's a limit to what can be done to honour these requests
+ * before reaching a tipping point where there are too many requests for
+ * a particular QoS that is impossible to service for all of them at once and
+ * some will start to lose out. For example if 10 tasks require better wake
+ * up latencies on a 4 CPUs SMP system, then if they all wake up at once, only
+ * 4 can perceive the hint honoured and the rest will have to wait. Inheritance
+ * can lead these 10 to become a 100 or a 1000 more easily, and then the QoS
+ * hint will lose its meaning and effectiveness rapidly. The chances of 10
+ * tasks waking up at the same time is lower than a 100 and lower than a 1000.
+ *
+ * To set multiple QoS hints, a syscall is required for each. This is a
+ * trade-off to reduce the churn on extending the interface as the hope for
+ * this to evolve as workloads and hardware get more sophisticated and the
+ * need for extension will arise; and when this happen the task should be
+ * simpler to add the kernel extension and allow userspace to use readily by
+ * setting the newly added flag without having to update the whole of
+ * sched_attr.
+ *
+ * Details about the available QoS hints can be found in:
+ * Documentation/scheduler/sched-qos.rst
  */
 struct sched_attr {
 	__u32 size;
@@ -116,6 +158,10 @@ struct sched_attr {
 	__u32 sched_util_min;
 	__u32 sched_util_max;
 
+	__u32 sched_qos_type;
+	__s64 sched_qos_value;
+	__u32 sched_qos_cookie;
+
 };
 
 #endif /* _UAPI_LINUX_SCHED_TYPES_H */
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index b215b0ead9a6..88feedd2f7c9 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -481,6 +481,13 @@ static int user_check_sched_setscheduler(struct task_struct *p,
 	if (p->sched_reset_on_fork && !reset_on_fork)
 		goto req_priv;
 
+	/*
+	 * Normal users can't set QoS on their own, must go via admin
+	 * controlled service
+	 */
+	if (attr->sched_flags & SCHED_FLAG_QOS)
+		goto req_priv;
+
 	return 0;
 
 req_priv:
@@ -552,6 +559,9 @@ int __sched_setscheduler(struct task_struct *p,
 			return retval;
 	}
 
+	if (attr->sched_flags & SCHED_FLAG_QOS)
+		return -EOPNOTSUPP;
+
 	/*
 	 * SCHED_DEADLINE bandwidth accounting relies on stable cpusets
 	 * information.
diff --git a/tools/perf/trace/beauty/include/uapi/linux/sched.h b/tools/perf/trace/beauty/include/uapi/linux/sched.h
index 359a14cc76a4..4ff525928430 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/sched.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/sched.h
@@ -102,6 +102,9 @@ struct clone_args {
 	__aligned_u64 set_tid_size;
 	__aligned_u64 cgroup;
 };
+
+enum sched_qos_type {
+};
 #endif
 
 #define CLONE_ARGS_SIZE_VER0 64 /* sizeof first published struct */
@@ -133,6 +136,7 @@ struct clone_args {
 #define SCHED_FLAG_KEEP_PARAMS		0x10
 #define SCHED_FLAG_UTIL_CLAMP_MIN	0x20
 #define SCHED_FLAG_UTIL_CLAMP_MAX	0x40
+#define SCHED_FLAG_QOS			0x80
 
 #define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
 				 SCHED_FLAG_KEEP_PARAMS)
-- 
2.34.1

