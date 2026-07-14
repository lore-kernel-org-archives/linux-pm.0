Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2DA44683D
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 16:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784047195; cv=none; b=s1A1sAlloWZ/j5PK7VKOQpTenYgL+TZ3mlTJQw2KcY4S+uU58ukRnfcTtjjAMMCrpdoyRz8XaQs1/NjTpbrYvuSMHRI0OV0R/EdJJgwcEKNzzu0IqqoX6ojVahUNzMiPBrRDI8A5rir/c6LZenY/nhmExBp5WF+bLAcwMZPC5eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784047195; c=relaxed/simple;
	bh=w1ayaFiykhXyStq+Fz4dl2B99MS+jLMfiGovaQyDklQ=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=Q9NgkeiBY1oIY0EfpFfoNvqSmAvYsJCcoY2F0Nf6nlJRESqCfIYNt6Mfnqh+HE6+yYhFOLOYQy6bQu99fUKXjINcOi5G1t4ccGm1VIm1onqyuLyehHt42N2QvDtI4icnnAzEMric6386dA0lzp4dZCvwmBpqw6ffdkwqF5zKKUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PONAYks2; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PONAYks2"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ced3386430so10735455ad.1
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 09:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784047194; x=1784651994; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:date:cc:to:from:subject:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fSSdPKad7upGTshmAAVeCJsnuIRzn7WTT52NBuduyY8=;
        b=PONAYks2e4EZa1wYDAQqw4VOzmCfYY6yQyQYF1UKRQoNsYfSIT82Hz9JxnxbVuMMzm
         3r04lUvB6/B7d8/t+4qqsmwi2tmVKXw0FT/brVhBs9PgBGnbtc4o7Oj6bWtW+qCfbbK1
         AdGLkJi4We95hr5Fov+SKTrdeSgngSFqCfkWCGFePEblaMPowepj7o0w6zpxnyhWu1fh
         1MyLoQIa2ugrP0J347YOYzfXTDa7M3Vz7jDEEFnV1sb6ivArGRv8xlTRxY0fxBsijkOQ
         vHZKRQ3YWNun6sMo5+biGkRlkW/9hC7SQ5o2/NRb/fFnQbt9nTB25ZZw/R5uP0RAVnN2
         8hUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784047194; x=1784651994;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:date:cc:to:from:subject:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fSSdPKad7upGTshmAAVeCJsnuIRzn7WTT52NBuduyY8=;
        b=RoK2SowI6B/ro3N59ya7WanglsWF37XguAGA5v+NUi9oNb4rgF3WJNlBlb8UnNdjhn
         BuCvy5itM9c9v425hdw3pk/fN2+uXbJGAziB7fz4I+wN85jSJEhrJsX9oyd+kra5RqSE
         kPB6GK2UisqcHZezJWv8M9rGVpzIfK2TMWjrmNVuXIpyumKa1x5tlJasR9BklItqqi+m
         5bjvOsr9LY9rX9PalJ06Rdj7HILO4JgoIhNvbmW2HPsKOVF2PuVHoTSix/yBpPUlkizJ
         4Yn3Cd31msJK0JTiHNjmf53EsT1x7cBvjKxuw5IswC24IYnmCWAUls163221veumEPat
         idrw==
X-Gm-Message-State: AOJu0YybExHFTZftrO2VhGkPB0BxZb4boWsPbv4ajcKRc5tJXpW7+Yk9
	pyzp53eBmyrnd/wmV+RfHHM0GUHIrna6lqY/MVDxGnVQHJLKLioRMiGz
X-Gm-Gg: AfdE7cnrWNVk9WEy3HNPMUG9fbaz6Zce6MvRbyjDtkdr0dDwgYanUlILYZNL4QAaT3D
	kG4yr6H//pM/qYWw7dDSCgLrziDQYCCbf2zasM4GcAZZnTITqG9YirMBuJXIMWmCS+gg52LTC60
	YwRIfeZ7hdD94fgXRJWB8rREr/qpKdQeQkN2W0vReJYYLTg00yELw7cS5IRipUK5hv1LQ5tIoCu
	II+cRWTkR9DwcgFRbVSr/F4KZPDmgTNq34f9pY9OzK7rhKAMncWPMqUoxynWMW5haA0LQpIUWWP
	WX6ZYXOpBsOqzkxulUSUtVkEzQal/vYoMiueMK8oLz46dQqxzxmL1TYMs3B6307p82dzRpU+VmY
	R55lU424y1DnmiTEZKI26RMRuwvmeFCo/oFx60+1XySqcbWK4VTrOfotGnTu2vJvreVb6sglLyB
	SXv8jC03OwQeK5uSXe+m4gwVrwfVy8Mty2jjOJVRZ5NObxPk86AgkVACMuu3OmefgPkH4rtQ==
X-Received: by 2002:a17:902:f645:b0:2c9:fc14:588f with SMTP id d9443c01a7336-2ce9ec0f95fmr137040705ad.29.1784047193513;
        Tue, 14 Jul 2026 09:39:53 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d1e914sm118986685ad.50.2026.07.14.09.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 09:39:52 -0700 (PDT)
Subject: [RFC PATCH] freezer: Restrict unsafe freezable tasks to system sleep
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: rafael@kernel.org, pavel@kernel.org, lenb@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
 skinsburskii@gmail.com
Cc: linux-pm@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
 linux-kernel@vger.kernel.org
Date: Tue, 14 Jul 2026 09:39:51 -0700
Message-ID: <178404715617.1031850.16243528040694432110.stgit@skinsburskii>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

TASK_FREEZABLE_UNSAFE is used by network filesystems for sleeps that may
happen while a task holds locks or transport resources needed by other
tasks. Allowing the freezer to park such tasks for administrative freezer
requests can therefore block unrelated users of the same mount until the
task is thawed.

The original purpose of these unsafe freezable sleeps is to keep system
sleep from being blocked indefinitely by RPC or filesystem waits. Preserve
that behavior for suspend and hibernation, but do not freeze
TASK_FREEZABLE_UNSAFE tasks for non-PM freezer requests.

Make __TASK_FREEZABLE_UNSAFE independent of CONFIG_LOCKDEP so the freezer
can test the unsafe state in all builds. The lockdep check still uses the
same bit to suppress the locks-held warning for these known unsafe waits.

Document the PM-only freezer semantics for TASK_FREEZABLE_UNSAFE.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
---
 Documentation/power/freezing-of-tasks.rst |    3 +++
 include/linux/sched.h                     |    2 +-
 kernel/freezer.c                          |   10 ++++++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/power/freezing-of-tasks.rst b/Documentation/power/freezing-of-tasks.rst
index df9755bfbd94..0ccf2ea041cf 100644
--- a/Documentation/power/freezing-of-tasks.rst
+++ b/Documentation/power/freezing-of-tasks.rst
@@ -16,6 +16,9 @@ II. How does it work?
 
 There is one per-task flag (PF_NOFREEZE) and three per-task states
 (TASK_FROZEN, TASK_FREEZABLE and __TASK_FREEZABLE_UNSAFE) used for that.
+Tasks sleeping in TASK_FREEZABLE_UNSAFE may hold locks or other resources
+that make them unsafe to freeze for administrative freezer requests, so the
+freezer only freezes them during system-wide suspend or hibernation.
 The tasks that have PF_NOFREEZE unset (all user space tasks and some kernel
 threads) are regarded as 'freezable' and treated in a special way before the
 system enters a sleep state as well as before a hibernation image is created
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 908aff695ef8..67e052dee1c4 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -122,7 +122,7 @@ struct user_event_mm;
 #define TASK_NEW			0x00000800
 #define TASK_RTLOCK_WAIT		0x00001000
 #define TASK_FREEZABLE			0x00002000
-#define __TASK_FREEZABLE_UNSAFE	       (0x00004000 * IS_ENABLED(CONFIG_LOCKDEP))
+#define __TASK_FREEZABLE_UNSAFE		0x00004000
 #define TASK_FROZEN			0x00008000
 #define TASK_STATE_MAX			0x00010000
 
diff --git a/kernel/freezer.c b/kernel/freezer.c
index a76bf957fb32..bf7bb15c144f 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -124,6 +124,16 @@ static int __set_task_frozen(struct task_struct *p, void *arg)
 	if (!(state & (TASK_FREEZABLE | __TASK_STOPPED | __TASK_TRACED)))
 		return 0;
 
+	/*
+	 * TASK_FREEZABLE_UNSAFE waiters may hold locks or other resources that
+	 * other tasks need in order to make forward progress.  Only freeze
+	 * them for system-wide suspend or hibernation, where failing to freeze
+	 * them can prevent the sleep transition from making progress.
+	 */
+	if ((state & __TASK_FREEZABLE_UNSAFE) &&
+	    !pm_freezing && !pm_nosig_freezing)
+		return 0;
+
 	/*
 	 * Only TASK_NORMAL can be augmented with TASK_FREEZABLE, since they
 	 * can suffer spurious wakeups.


