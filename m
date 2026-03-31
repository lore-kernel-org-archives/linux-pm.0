Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A5B421F02
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 15:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971302; cv=none; b=NJiaZTmgFvJpjOU05bHcvuJU+mLUdLwYeycNa4GBcplKSDArEkOomDKj9jeQE+DTF/ZQOHhvMNU2nzDyFIy0+7tTMGdFwe3fdF8WTSpX+d7Buu5TudNZyPn/4CEH/nFxKTLAwwo2hjcQXQJTB2s9ANxLpRWdRx0Gqla3+WVrC0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971302; c=relaxed/simple;
	bh=hqnvAUyRD//uDsghjeO9XTcRE/oWX3SD/127id8yotY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mPUp5u9/lF48uVRHc8++s6Z2MoDuQzI1WJ3ot6k6avUetFeqG/+DelapxuC/KemvKnJ0atkMaS9lm/DqIqZeolst4FPr4lXY3k1nFf0weYUUH1nps08McRy2kGoAjOQsafjFPhe8Oq2JcQ44DM1hRk6jbl90S5QGmpQ7F2bvZNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uf+Q21rv; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uf+Q21rv"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so5080145eec.0
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 08:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774971298; x=1775576098; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oKdyQZxERM7zX00CvQx5rmQ/yM+uYmSc+NIq9/dspVA=;
        b=uf+Q21rvAXqnL1spCKc1aC7Jk5QtpsQVXMAPbL8omoJbYpVJH44IgdOYUr9TcR+wzv
         rFsNXmPSrkdu+96sMSV5+OFVhcCkMdpohQ9LCsr2oyouV+AkvLZsr0RkKNxb6GgCQGat
         SPXOZqq6gnkRUWwtSIvA3nsFTIvyEbejprmZPQ8koRlcAEa7+WmTovkOaNDSxP5d4+kC
         mcvM4xvNS9BvMZZ/GMH2ksqywD9n7HBpUUrWdsXyZLQSh1OWjqsKj8l62TjwqmJ+n8hB
         LZjOrGnwJvArW7koRSr2O3zSwBSBymj7E/x/jN+CRtd4N5N5dwxHtxPZOXOeWGs7iAKt
         15ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774971298; x=1775576098;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oKdyQZxERM7zX00CvQx5rmQ/yM+uYmSc+NIq9/dspVA=;
        b=G+rUT1gv9HMT9lonvQcqnyHWRt3TPFFJM+WvmblA7I9ZWrAr7B6TmXDLUaTmxTluur
         HI4BkXhbIqER7Emo3RpfOUbNbW7KHE6pwQ0haxr4B5e8TkEp4MmQspDPnpi/Bj+kOxIj
         Otu8t2BXRBu3sMu4hghOPJwfjV3eTeCJ8f5z4YdLE8UbH4dO8J5qdq+Gh8ztEbKjqybv
         4t0QKAYcxvCNdzmeonSkgPjsJSMGBLa/PWSZTYuB3Pl9x59nsJ2h8MvUXMHM1HrnpGcS
         Lt/bUWo311heTqNb/UINPsAVf6E9L0ceEMY0oBbyYb9MOdDApGazYvo5j/4rNBps7Pzl
         4HhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUY2GrEHVQNvubD0nEdlFblUwoI6X++GFwUB9NK5Sxghe7FITkvkFFWg7MeZnGDn8LNiqXj4EeSA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTDonrkNWu2H287IeMdl30TKKyrgsJNEyrYztUCGZwkDcAoq+w
	TorYtLVwuz855Zx3LvhXlwbeyzRNk7SgPCQvv5ZQA2FSwQAwxLxIKKSNweKGkMJWYN+/tQ5X+kV
	rWhLeJd3yt+tkPA==
X-Received: from dycmo5.prod.google.com ([2002:a05:693c:26c5:b0:2c6:af43:29fd])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:4909:b0:2c3:f58a:77c5 with SMTP id 5a478bee46e88-2c3f58a877emr3793737eec.30.1774971297340;
 Tue, 31 Mar 2026 08:34:57 -0700 (PDT)
Date: Tue, 31 Mar 2026 08:34:11 -0700
In-Reply-To: <20260331153413.2469218-1-wusamuel@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331153413.2469218-1-wusamuel@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260331153413.2469218-3-wusamuel@google.com>
Subject: [PATCH v3 2/2] selftests/bpf: Add tests for wakeup_sources kfuncs
From: Samuel Wu <wusamuel@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Samuel Wu <wusamuel@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	driver-core@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Introduce a set of BPF selftests to verify the safety and functionality
of wakeup_source kfuncs.

The suite includes:
1. A functional test (test_wakeup_source.c) that iterates over the
   global wakeup_sources list. It uses CO-RE to read timing statistics
   and validates them in user-space via the BPF ring buffer.
2. A negative test suite (wakeup_source_fail.c) ensuring the BPF
   verifier correctly enforces reference tracking and type safety.
3. Enable CONFIG_PM_WAKELOCKS in the test config, allowing creation of
   wakeup sources via /sys/power/wake_lock.

A shared header (wakeup_source.h) is introduced to ensure consistent
memory layout for the Ring Buffer data between BPF and user-space.

Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 tools/testing/selftests/bpf/config            |   3 +-
 .../selftests/bpf/prog_tests/wakeup_source.c  | 101 ++++++++++++++++++
 .../selftests/bpf/progs/test_wakeup_source.c  |  92 ++++++++++++++++
 .../selftests/bpf/progs/wakeup_source.h       |  22 ++++
 .../selftests/bpf/progs/wakeup_source_fail.c  |  76 +++++++++++++
 5 files changed, 293 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/wakeup_source.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_wakeup_source.c
 create mode 100644 tools/testing/selftests/bpf/progs/wakeup_source.h
 create mode 100644 tools/testing/selftests/bpf/progs/wakeup_source_fail.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 24855381290d..bac60b444551 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -130,4 +130,5 @@ CONFIG_INFINIBAND=y
 CONFIG_SMC=y
 CONFIG_SMC_HS_CTRL_BPF=y
 CONFIG_DIBS=y
-CONFIG_DIBS_LO=y
\ No newline at end of file
+CONFIG_DIBS_LO=y
+CONFIG_PM_WAKELOCKS=y
diff --git a/tools/testing/selftests/bpf/prog_tests/wakeup_source.c b/tools/testing/selftests/bpf/prog_tests/wakeup_source.c
new file mode 100644
index 000000000000..ff2899cbf3a8
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/wakeup_source.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright 2026 Google LLC */
+
+#include <test_progs.h>
+#include <fcntl.h>
+#include "test_wakeup_source.skel.h"
+#include "wakeup_source_fail.skel.h"
+#include "progs/wakeup_source.h"
+
+static int lock_ws(const char *name)
+{
+	int fd;
+	ssize_t bytes;
+
+	fd = open("/sys/power/wake_lock", O_WRONLY);
+	if (!ASSERT_OK_FD(fd, "open /sys/power/wake_lock"))
+		return -1;
+
+	bytes = write(fd, name, strlen(name));
+	close(fd);
+	if (!ASSERT_EQ(bytes, strlen(name), "write to wake_lock"))
+		return -1;
+
+	return 0;
+}
+
+static void unlock_ws(const char *name)
+{
+	int fd;
+
+	fd = open("/sys/power/wake_unlock", O_WRONLY);
+	if (fd < 0)
+		return;
+
+	write(fd, name, strlen(name));
+	close(fd);
+}
+
+struct rb_ctx {
+	const char *name;
+	bool found;
+	long long active_time_ns;
+	long long total_time_ns;
+};
+
+static int process_sample(void *ctx, void *data, size_t len)
+{
+	struct rb_ctx *rb_ctx = ctx;
+	struct wakeup_event_t *e = data;
+
+	if (strcmp(e->name, rb_ctx->name) == 0) {
+		rb_ctx->found = true;
+		rb_ctx->active_time_ns = e->active_time_ns;
+		rb_ctx->total_time_ns = e->total_time_ns;
+	}
+	return 0;
+}
+
+void test_wakeup_source(void)
+{
+	if (test__start_subtest("iterate_and_verify_times")) {
+		struct test_wakeup_source *skel;
+		struct ring_buffer *rb = NULL;
+		struct rb_ctx rb_ctx = {
+			.name = "bpf_selftest_ws_times",
+			.found = false,
+		};
+		int err;
+
+		skel = test_wakeup_source__open_and_load();
+		if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+			return;
+
+		rb = ring_buffer__new(bpf_map__fd(skel->maps.rb), process_sample, &rb_ctx, NULL);
+		if (!ASSERT_OK_PTR(rb, "ring_buffer__new"))
+			goto destroy;
+
+		/* Create a temporary wakeup source */
+		if (!ASSERT_OK(lock_ws(rb_ctx.name), "lock_ws"))
+			goto unlock;
+
+		err = bpf_prog_test_run_opts(bpf_program__fd(
+				skel->progs.iterate_wakeupsources), NULL);
+		ASSERT_OK(err, "bpf_prog_test_run");
+
+		ring_buffer__consume(rb);
+
+		ASSERT_TRUE(rb_ctx.found, "found_test_ws_in_rb");
+		ASSERT_GT(rb_ctx.active_time_ns, 0, "active_time_gt_0");
+		ASSERT_GT(rb_ctx.total_time_ns, 0, "total_time_gt_0");
+
+unlock:
+		unlock_ws(rb_ctx.name);
+destroy:
+		if (rb)
+			ring_buffer__free(rb);
+		test_wakeup_source__destroy(skel);
+	}
+
+	RUN_TESTS(wakeup_source_fail);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_wakeup_source.c b/tools/testing/selftests/bpf/progs/test_wakeup_source.c
new file mode 100644
index 000000000000..fd2fb6aebd82
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_wakeup_source.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright 2026 Google LLC */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_experimental.h"
+#include "bpf_misc.h"
+#include "wakeup_source.h"
+
+#define MAX_LOOP_ITER 1000
+#define RB_SIZE (16384 * 4)
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, RB_SIZE);
+} rb SEC(".maps");
+
+struct bpf_ws_lock;
+struct bpf_ws_lock *bpf_wakeup_sources_read_lock(void) __ksym;
+void bpf_wakeup_sources_read_unlock(struct bpf_ws_lock *lock) __ksym;
+void *bpf_wakeup_sources_get_head(void) __ksym;
+
+SEC("syscall")
+__success __retval(0)
+int iterate_wakeupsources(void *ctx)
+{
+	struct list_head *head = bpf_wakeup_sources_get_head();
+	struct list_head *pos = head;
+	struct bpf_ws_lock *lock;
+	int i;
+
+	lock = bpf_wakeup_sources_read_lock();
+	if (!lock)
+		return 0;
+
+	bpf_for(i, 0, MAX_LOOP_ITER) {
+		if (bpf_core_read(&pos, sizeof(pos), &pos->next) || !pos || pos == head)
+			break;
+
+		struct wakeup_event_t *e = bpf_ringbuf_reserve(&rb, sizeof(*e), 0);
+
+		if (!e)
+			break;
+
+		struct wakeup_source *ws = bpf_core_cast(
+				(void *)pos - bpf_core_field_offset(struct wakeup_source, entry),
+				struct wakeup_source);
+		s64 active_time = 0;
+		bool active = BPF_CORE_READ_BITFIELD(ws, active);
+		bool autosleep_enable = BPF_CORE_READ_BITFIELD(ws, autosleep_enabled);
+		s64 last_time = ws->last_time;
+		s64 max_time = ws->max_time;
+		s64 prevent_sleep_time = ws->prevent_sleep_time;
+		s64 total_time = ws->total_time;
+
+		if (active) {
+			s64 curr_time = bpf_ktime_get_ns();
+			s64 prevent_time = ws->start_prevent_time;
+
+			if (curr_time > last_time)
+				active_time = curr_time - last_time;
+
+			total_time += active_time;
+			if (active_time > max_time)
+				max_time = active_time;
+			if (autosleep_enable && curr_time > prevent_time)
+				prevent_sleep_time += curr_time - prevent_time;
+		}
+
+		e->active_count = ws->active_count;
+		e->active_time_ns = active_time;
+		e->event_count = ws->event_count;
+		e->expire_count = ws->expire_count;
+		e->last_time_ns = last_time;
+		e->max_time_ns = max_time;
+		e->prevent_sleep_time_ns = prevent_sleep_time;
+		e->total_time_ns = total_time;
+		e->wakeup_count = ws->wakeup_count;
+
+		if (bpf_probe_read_kernel_str(
+				e->name, WAKEUP_NAME_LEN, ws->name) < 0)
+			e->name[0] = '\0';
+
+		bpf_ringbuf_submit(e, 0);
+	}
+
+	bpf_wakeup_sources_read_unlock(lock);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/wakeup_source.h b/tools/testing/selftests/bpf/progs/wakeup_source.h
new file mode 100644
index 000000000000..cd74de92c82f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/wakeup_source.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright 2026 Google LLC */
+
+#ifndef __WAKEUP_SOURCE_H__
+#define __WAKEUP_SOURCE_H__
+
+#define WAKEUP_NAME_LEN 128
+
+struct wakeup_event_t {
+	unsigned long active_count;
+	long long active_time_ns;
+	unsigned long event_count;
+	unsigned long expire_count;
+	long long last_time_ns;
+	long long max_time_ns;
+	long long prevent_sleep_time_ns;
+	long long total_time_ns;
+	unsigned long wakeup_count;
+	char name[WAKEUP_NAME_LEN];
+};
+
+#endif /* __WAKEUP_SOURCE_H__ */
diff --git a/tools/testing/selftests/bpf/progs/wakeup_source_fail.c b/tools/testing/selftests/bpf/progs/wakeup_source_fail.c
new file mode 100644
index 000000000000..0f8d29865a01
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/wakeup_source_fail.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright 2026 Google LLC */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+struct bpf_ws_lock;
+
+struct bpf_ws_lock *bpf_wakeup_sources_read_lock(void) __ksym;
+void bpf_wakeup_sources_read_unlock(struct bpf_ws_lock *lock) __ksym;
+void *bpf_wakeup_sources_get_head(void) __ksym;
+
+SEC("syscall")
+__failure __msg("BPF_EXIT instruction in main prog would lead to reference leak")
+int wakeup_source_lock_no_unlock(void *ctx)
+{
+	struct bpf_ws_lock *lock;
+
+	lock = bpf_wakeup_sources_read_lock();
+	if (!lock)
+		return 0;
+
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("access beyond struct")
+int wakeup_source_access_lock_fields(void *ctx)
+{
+	struct bpf_ws_lock *lock;
+	int val;
+
+	lock = bpf_wakeup_sources_read_lock();
+	if (!lock)
+		return 0;
+
+	val = *(int *)lock;
+
+	bpf_wakeup_sources_read_unlock(lock);
+	return val;
+}
+
+SEC("syscall")
+__failure __msg("type=scalar expected=fp")
+int wakeup_source_unlock_no_lock(void *ctx)
+{
+	struct bpf_ws_lock *lock = (void *)0x1;
+
+	bpf_wakeup_sources_read_unlock(lock);
+
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("Possibly NULL pointer passed to trusted arg0")
+int wakeup_source_unlock_null(void *ctx)
+{
+	bpf_wakeup_sources_read_unlock(NULL);
+
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("R0 invalid mem access 'scalar'")
+int wakeup_source_unsafe_dereference(void *ctx)
+{
+	struct list_head *head = bpf_wakeup_sources_get_head();
+
+	if (head->next)
+		return 1;
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.53.0.1018.g2bb0e51243-goog

