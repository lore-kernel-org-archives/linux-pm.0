Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793092002;
	b=0mu7Y6XhDKICR8MmhB4n/1olUqrjO+M958Pw15fIgTAU3aVm+NU21qNwGU95TDHs3snf
	 4BxdbAVXGww7ULQDxhpyd5GZG0Iod9PolmyjmCOGTbnaj2A5mFjCA+dpsFl7zaNWx7fyX
	 rMIVjNdkqU0pzDo8F4dHrU425KNTH/Q86xRNNn6UaVktWDa7IzGoxPxhPdyPflsq1e8r2
	 QOZZxcf5MRnFvjsgxKQFOd1vAnpElUVSNpIVnpfDcijalkFKJuNImIQnnA1wwbbn1xwBN
	 +o6tX43COLkKc0KW7QoV5GKuSgOvHBsCGDp+tX8HzG6pdpcROZL5BA91nhUHWzJZvNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793092002;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=zTaJNhx6jjIJnXjeoqnWeSprw8pGi/JKXn6SeEWkoek=;
	b=CbC4Gk+JTi5T2WTBF7EFfu10Nkdazt0wmpae/zak+QG2fCnxKbRoS6fUYnJdJFppdYY4
	 yOrpAAK25jE3Fn0/KO4JQngGzO73q/anTkhBeH4ruYS2zqnBEuGe0hI8GBynPT2qEU28s
	 ODVT9Ome2DmYxPwjjGyuYGkxdWrnLUvZX2bkWcu/DiNrFdPolDhc+JZZhquDRiNSr6tz5
	 MUl9ebN0mkCFSme5xc2eISM0PzC7LQSQhgYvgk/Dbb8zekfVS8d8DB+b8yqr4mZXfUaWL
	 0MvStLsxfrt0fMn2fdTzlaTWU4npPETIWckh/3hSo8v2PK/KQb5mk1aXaYXfQnY8QfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--chungkai.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=N6iT+wA4;
	arc=none smtp.remote-ip=209.85.210.198
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C06C606A31A
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 09:06:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C06C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chungkai.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=N6iT+wA4
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8a064f294cbso3095855b3a.2
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 02:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793092001; x=1793696801; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zTaJNhx6jjIJnXjeoqnWeSprw8pGi/JKXn6SeEWkoek=;
        b=N6iT+wA4jDwAuJkuzO50Ln4dqtlHbcE6fi02H1dMFDeJAgJb5AqtKeIieeUF3lNQYE
         k42a5B7jUQ/L5hgNVkTEvIWAZjZfVzJJlVUV4YKuX3JhBtqJvtO47ollIviWq8dOotZw
         4BSMSn2/hiN9VTjKwkylAh2+s2CsQyQm0TSlESCOE+YGDhyevuZ1mfJQlufeyafEZQhN
         wg9uutVgfyN8Q8zB5AzXiJ8cohBu6C0gZbPJrYyoyGts9SIPBzz5SoTFvLVLRPpoX6aZ
         5o0VL1seBuF2kSeCdS/JR47OC/2zGvAhjbZKT5OVwwl3Omf3/CsSyEYCMuyjnlq6WYK6
         j9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793092001; x=1793696801;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zTaJNhx6jjIJnXjeoqnWeSprw8pGi/JKXn6SeEWkoek=;
        b=nvV35ZTP/q2+3+I+o/E14oiYFJlHK7+bfzd8/f5AlgKngMegNXIC46gPlX4yPdlgV2
         bRx6a7IPt+f3EXE76828AQynwuLaPt1FvYHYHhjIIKuAqSJo05cfSKtCxz/WUI+lL/Ij
         IuANF4w0k4WKb6/x63Ym2Kwjl2PhNZ3Z/i3kFQRnF6gfjWLCyOeliZ6WMqUUnLT96onw
         sSRSkL/t9+FUdZoeVqOVcOLc/MOTc7IYngIzxm9sgC9hQLGhrEHVdMY/eDalW5sINyh7
         Ue5rZ1ZEAUywhdu7zr+MDY/IT+dCbWQNxFlNAHfunAJpRMhDVVzIwvjXMygEA42D8az0
         QZXQ==
X-Forwarded-Encrypted: i=1; AKwUvBxIFtNcJ6ODNxNzrCd76X0PKHiw8av5o5rFTZsIIPGN+kS/dmOWpw4rJGuPAFPwOnNMB/GqXZt0EQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIKHiJXadoTVtvSln6yUaftkosAgTaeAKGZ+UUpia48vPsKO2pr
	WvkNvnfcIU9Lco6agve5I3o7neUii2lDExUgcs25g5gIwMFMaz3KxTniJCBWFm+/cQCOBfOLEsT
	9GL1CsV6WJvHRwA==
X-Received: from pffj5-n1.prod.google.com ([2002:a05:6a00:c2c5:10b0:89f:e459:aedd])
 (user=chungkai job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4b11:b0:89e:fc56:a25e with SMTP id d2e1a72fcca58-8a3674448b7mr7424489b3a.41.1793092001231;
 Tue, 27 Oct 2026 02:06:41 -0700 (PDT)
Date: Tue, 27 Oct 2026 09:06:38 +0000
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027090638.900747-1-chungkai@google.com>
Subject: [PATCH] PM: runtime: Allocate pm_wq with WQ_HIGHPRI
From: "Chung-Kai (Michael) Mei" <chungkai@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, chungkai@google.com
Content-Type: text/plain; charset="UTF-8"

Asynchronous runtime PM work (pm_runtime_work()) and genpd power-off
work (genpd_power_off_work_fn()) run on pm_wq. While such a work item
executes a ->runtime_suspend() or ->runtime_resume() callback, the
device's runtime_status is RPM_SUSPENDING or RPM_RESUMING with
dev->power.lock dropped, and genpd_power_off_work_fn() holds the genpd
lock.

If another task calls pm_runtime_get_sync() on the device in that
window, rpm_resume() sleeps on dev->power.wait_queue in
TASK_UNINTERRUPTIBLE until the work item completes. A wait queue has
no owner, so the waiter cannot lend its priority to the kworker, and
its latency is bounded by how quickly the pm_wq worker gets CPU time.
Because asynchronous runtime PM work is queued onto pm_wq by the PM
core, individual drivers cannot select a different workqueue.

pm_wq workers run at nice 0 and can be kept off the CPU for a long
time by higher-weight CFS tasks. On an arm64 Android device whose GPU
driver uses runtime PM autosuspend, render threads were observed
blocked in rpm_resume() for 5 to 19 ms while the runtime PM callback
itself needed less than 60 us of CPU time. For more than 99% of that
time the pm_wq worker was runnable, preempted by nice -20 tasks.

Allocate pm_wq with WQ_HIGHPRI so that its work items are served by the
unbound high-priority worker pools (nice -20), like other
latency-sensitive kernel workqueues such as kblockd. This does not
change the ordering or concurrency semantics of pm_wq. It only reduces
the time a runtime PM transition spends waiting for CPU time, and with
it the latency seen by synchronous runtime PM callers.

Signed-off-by: Chung-Kai (Michael) Mei <chungkai@google.com>
---
 kernel/power/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index 5429e9f19b655..1e8ae76356b23 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -1125,7 +1125,7 @@ EXPORT_SYMBOL_GPL(pm_wq);
 
 static int __init pm_start_workqueues(void)
 {
-	pm_wq = alloc_workqueue("pm", WQ_UNBOUND, 0);
+	pm_wq = alloc_workqueue("pm", WQ_UNBOUND | WQ_HIGHPRI, 0);
 	if (!pm_wq)
 		return -ENOMEM;
 

base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.56.0.307.g5fe7bd680c-goog

