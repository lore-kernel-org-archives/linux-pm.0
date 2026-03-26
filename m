Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3643CB2D4
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 11:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774524342; cv=none; b=XLRpBnAfa7kSuJDMTWzMb0Wkogo/C1jq4THctvvgAoOJcoAqCf4Im6t7aXtSC1vwYSuXHqLsfgWRrOUgWxgZCudKp7nujBVnXtSLh9bTY0m8zZmUIqiE63i/o2T8NUeVE64NSxrr5z0gEfdM0i/dxHoXs709N8ts3jOV/cy/CpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774524342; c=relaxed/simple;
	bh=/V+0IdnH4j/38ObS2x8JnYWV0Up1Buj0iBonshlPv0o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Py+m6mPo4Yp6GR4TYPBVEgK898RmGo2KtM3aSFRvvV79aJF6ApYbWzYpoMnv6fsiEUCNxww0Zf+Ctlbob2q/iKyrZdLjSLlc6aDbtu0f5wvTefOAz/A2M2uZty0Wszrf76VpimcsIqMg/M/KdYe1OMwvBSvdQdno24+kwFnWTyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WXtZg27Y; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WXtZg27Y"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bdf75bc88fso716970eec.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 04:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774524340; x=1775129140; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AADrlL5HtSz7LV90mafOdNvanEoEV46ktmXue5e6GMM=;
        b=WXtZg27YRsX/r/r2lesffReMGwYDo4GTU3cfg6urrUWcSExB5B6w8R+CIPaBFHc9mx
         o4qKTGrM1bQ8kQjqoJ7yiZfd4iiK++hoB0sU47tJfpZijELtNQ1WL8W/pBZCvjDCOEqH
         vh7imIF2gyK7IXWlxr15RlQK3dQIRz5JHoFrFAK1EiQ/iI4fY1GV2wVOZVkd7Utga2pp
         xPLaFcNLHg7B47GArr+C+ZeUAn/4erRMc5fzN+F2S4P/mfZ2Y8u0BmdQujKnQVJ96bnQ
         A9ck7hRRhVH5p/JLS2/Q52wUYGqh4GR5sKUtz0aulYDZbLfL39ZRh9ULq72zZzoLrTbc
         a3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774524340; x=1775129140;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AADrlL5HtSz7LV90mafOdNvanEoEV46ktmXue5e6GMM=;
        b=e5tYZNiI1bwnD0Tvk3rUZj5K3gYr5vnBoXeL6B+uw9b54lQG0p4sXXUH/Zj4yKgS5s
         nksqKIy0AdWLMqj0q5hMv1zt9slz5c/amF6c950rfl5L6YAdoGyVBNGrbYyqk0BKuk23
         nRwCaxigXFo1ScyPjSjky/Yg5BQtuOLHszouIxrm6g5YTdU3wCdfdCVWKWVjjS84CnQ9
         kqKn7Cjiy1FbiakKJkmysDc6ENX6ii49/JVDPVRvLDS2gE03WdbU6V+4Yz96DvGPfckl
         CcwWYok372x7q9oJ4GZLiXD5cK6QZ2a/lq+whsuUfVNuOQCwKzOVpO47DJOHORfYD/qG
         iurA==
X-Forwarded-Encrypted: i=1; AJvYcCUdI2Ndk9uxFRtS9814wgv4FXedlvDVbgJms1ZboufHk6XnKZ7Jum2ejAwnJKDh7vDJQKabu3FbxA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8H6slNo78VnoyzRYHUJ7widOp0C7loaN9e7ZCi4JjR7W5myV/
	PD/9dOnT+Bd0jyG9ffLU/uSJ3QhNgtbOcVpEdPgkHhF1FXgcxfuz0Zb6dqj2/frhZvzAFqDVnzq
	YU3fVj5M7C+/9ag==
X-Received: from dyls26.prod.google.com ([2002:a05:7300:6a9a:b0:2be:9dd7:57f6])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:3c05:b0:2ba:a3f2:958c with SMTP id 5a478bee46e88-2c15d12dc96mr4152044eec.0.1774524339916;
 Thu, 26 Mar 2026 04:25:39 -0700 (PDT)
Date: Thu, 26 Mar 2026 04:25:20 -0700
In-Reply-To: <20260326112521.2827500-1-wusamuel@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326112521.2827500-1-wusamuel@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260326112521.2827500-3-wusamuel@google.com>
Subject: [PATCH v2 2/2] selftests/bpf: Add tests for wakeup_sources kfuncs
From: Samuel Wu <wusamuel@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: memxor@gmail.com, Samuel Wu <wusamuel@google.com>, kernel-team@android.com, 
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
 .../selftests/bpf/prog_tests/wakeup_source.c  | 101 +++++++++++++++++
 .../selftests/bpf/progs/test_wakeup_source.c  | 107 ++++++++++++++++++
 .../selftests/bpf/progs/wakeup_source.h       |  22 ++++
 .../selftests/bpf/progs/wakeup_source_fail.c  |  63 +++++++++++
 5 files changed, 295 insertions(+), 1 deletion(-)
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
index 000000000000..fa35156e31d2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_wakeup_source.c
@@ -0,0 +1,107 @@
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
+struct wakeup_source___local {
+	const char *name;
+	unsigned long active_count;
+	unsigned long event_count;
+	unsigned long wakeup_count;
+	unsigned long expire_count;
+	ktime_t last_time;
+	ktime_t max_time;
+	ktime_t total_time;
+	ktime_t start_prevent_time;
+	ktime_t prevent_sleep_time;
+	struct list_head entry;
+	bool active:1;
+	bool autosleep_enabled:1;
+} __attribute__((preserve_access_index));
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, RB_SIZE);
+} rb SEC(".maps");
+
+struct bpf_ws_lock;
+struct bpf_ws_lock *bpf_wakeup_sources_read_lock(void) __ksym;
+void bpf_wakeup_sources_read_unlock(struct bpf_ws_lock *lock) __ksym;
+struct list_head *bpf_wakeup_sources_get_head(void) __ksym;
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
+		struct wakeup_source___local *ws = container_of(
+				pos, struct wakeup_source___local, entry);
+		s64 active_time = 0;
+		bool active = BPF_CORE_READ_BITFIELD_PROBED(ws, active);
+		bool autosleep_enable = BPF_CORE_READ_BITFIELD_PROBED(ws, autosleep_enabled);
+		s64 last_time = BPF_CORE_READ(ws, last_time);
+		s64 max_time = BPF_CORE_READ(ws, max_time);
+		s64 prevent_sleep_time = BPF_CORE_READ(ws, prevent_sleep_time);
+		s64 total_time = BPF_CORE_READ(ws, total_time);
+
+		if (active) {
+			s64 curr_time = bpf_ktime_get_ns();
+			s64 prevent_time = BPF_CORE_READ(ws, start_prevent_time);
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
+		e->active_count = BPF_CORE_READ(ws, active_count);
+		e->active_time_ns = active_time;
+		e->event_count = BPF_CORE_READ(ws, event_count);
+		e->expire_count = BPF_CORE_READ(ws, expire_count);
+		e->last_time_ns = last_time;
+		e->max_time_ns = max_time;
+		e->prevent_sleep_time_ns = prevent_sleep_time;
+		e->total_time_ns = total_time;
+		e->wakeup_count = BPF_CORE_READ(ws, wakeup_count);
+
+		if (bpf_probe_read_kernel_str(
+				e->name, WAKEUP_NAME_LEN, BPF_CORE_READ(ws, name)) < 0)
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
index 000000000000..a569c9d53d21
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/wakeup_source_fail.c
@@ -0,0 +1,63 @@
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
+char _license[] SEC("license") = "GPL";
-- 
2.53.0.1018.g2bb0e51243-goog

