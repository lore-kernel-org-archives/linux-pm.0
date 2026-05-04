Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18588145FE0
	for <linux-pm@vger.kernel.org>; Mon,  4 May 2026 02:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777860013; cv=none; b=BDiidPdmrwbgremzeFliTImCKmWF7f1yk6dJitNKlXmkfts/5gps/5SZka1mOGFFEEh9pSkkbJoxWmdxiIRgCiN7BRLX+XFwQrMfa6mqMPXNimFxE7n/54YpvBe9FeclhT0RDsNEGpUqCqaTuq8wkgnbkqYczRZ8LRScFofSygU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777860013; c=relaxed/simple;
	bh=PlAT9JDfozxzJQNBLtbs7ABTIBIQR5FkA/al0wHOyC4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=CMLnAAlpq7TZq5QHQoMUMBI0mpsWkHY9N/jsLURaome27l544qa02EKjVir6rqqp860VszWjiDSSfsZJaEzU+7fX4h5q0e4mpUfbuCuE8tn7OF/L62szJ17Jwof/dScQXFc5lSbGjTfbF8/HprBdwl6FqGpxzjZkI6pgPGkjNn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b=K9Pm3VIH; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b="K9Pm3VIH"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so39625735e9.2
        for <linux-pm@vger.kernel.org>; Sun, 03 May 2026 19:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20251104.gappssmtp.com; s=20251104; t=1777860009; x=1778464809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TkqbLhbf38FHL3mS7/BiWTRrhBqCXCu9aHAIY93ayqk=;
        b=K9Pm3VIHGe8gSxNQ4ZYj8cZ2cfOP7VvAxlMRwYKuo7tysb4yClbnUqemfNxFuGed3h
         w6oqOGM3lB/YuqQhIS+66TbQApoAJ8d5UGeuq2vTVKrPvqBEv7Uj+6eFTzG0E+TkK+VB
         Srwe083OqU9J1OLkWpx44q/DnPjGUITLDWrrLKevWBOx691JQe6JnknzUbwqQzYYGc6H
         rmX83/oI3gGUGmdS7U8JgkL71MhOwMTEXXNa668LOjDOCXGIar3yrMSISjhKmjyF4uc8
         w0rQdP4BYi3XF201XbEhYVvOZxhQAo1LifTPLtwkry7g9aeJDhMcRvOWfmAD7ht55ikp
         Oy4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777860009; x=1778464809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkqbLhbf38FHL3mS7/BiWTRrhBqCXCu9aHAIY93ayqk=;
        b=nSx0/vSCQWuWvyKIT2P7utkmmZ9lPf07bIYMf8cUUywLitbPQiVvck2TP1x/6aNcO9
         IO/fc1hqlSbyTsf4V99T7bCqkvGFbZWQrm37s0PrvmYdvc79SEOOFX31hld4vo1i1UeE
         K8/etlsHgwlqlpDhDeD1Mc5d/U3rE2Pl5cKyN6hgH/4kHBgsFLR0SUwTUXeC4vIl7J0T
         BzKo/yDkx0fYSncv26r/sZrMZxrVmYHwi2RUP/afvKv3x+GmueIf5TIjPiIeh5Rwteq7
         +2zEjoe0es+scPKjiwrTnkSijqCWIopuVZShcyBOxhgqeDzXuhuZBaC1KlduSRR7Hyzx
         IxoA==
X-Forwarded-Encrypted: i=1; AFNElJ/cJlvH1AEiGt2xbaOQOZydCuvn9/rpBShE+iwJxyBhj1Fxjwb3e11QrF2OCDUiwoRCNjCJjovllA==@vger.kernel.org
X-Gm-Message-State: AOJu0YycC8z+7+emDDAOZwbJUs099AwjyaFOV/LxFqLQf+5w8KcmeFml
	kOR+kgkqxJ5NPYuofOu/cnleCvhGfgTiJpbYFCw5hoIOHJgclBnHgjSipyo6PcHEiJg=
X-Gm-Gg: AeBDiesKrtyPgWkmTOz3H9zjGFiTPGwK2zAo9c3XM6dO2Dm/1FTybgiwfaD8H0uPqZp
	U7OMWjYYdvgnIa5Iyj1Xx+H8/FXJ0Ehpczxt9FLgwki8ceg5llk5xXQhWyTd4/iCInMvMC9I1Xp
	q5txODE/ElhSVVtz3tSfO7LKjMDhg8TQmsYP0ghrghiPZ+l31bcSKumAjvWPkl6aI9h3dQgAMfp
	XsjkeCjvAiupMG369k8lH+bida4+hhFr7Pugd1lT1XlFAcDEU70k5P9NCAX9A1HtF9A/CivahbA
	Gip0b2gV1ETdKMoNfj0kWX+uRh5ahfduWqZKGQc+YZoSnHzufkMms7ZG1NBmqlplWula5YzHO31
	3bdBD3bd2ThB1ZhaSkcIuvaWA41QkWbIKxYnBBwYfpb8OvnJ3q2PG8LPVRfotstZ422UTkHm7Q7
	qnQ1aXTB7Cb8+gf1ZrGoHD0qsPWXvB3sY=
X-Received: by 2002:a05:600c:620c:b0:48a:97b6:7420 with SMTP id 5b1f17b1804b1-48a98670f8emr125210655e9.24.1777860008805;
        Sun, 03 May 2026 19:00:08 -0700 (PDT)
Received: from airbuntu.. ([146.70.179.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fee5033sm68064215e9.22.2026.05.03.19.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 19:00:08 -0700 (PDT)
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
Subject: [PATCH v2 00/13] sched/fair/schedutil: Better manage system response time
Date: Mon,  4 May 2026 02:59:50 +0100
Message-Id: <20260504020003.71306-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the long delayed follow up to the series sent back in August 2024 [1].
Life got in the way to some extent (I had a baby, and now my time that I used
to do upstream work late at night was stolen :). Apologies for those who
replied and I didn't get a chance to respond back.

The series is now rebased on top of tip/sched/core 78cde54ea5f0. I removed
a number of optimization patches that are not necessary for this initial merge
and can be treated as their own separate topics once this is hopefully
accepted.

I discussed the problem in LPC in 2024 [2] and the initial cover letter
contains all the details. I hope all the key parties are up-to-date on the
problem details by now.

As a brief recap, there are some hardcoded constants in the kernel that
introduce a bias that frequently fails to deliver the best outcome on various
systems.  It turns out these constant seem to help somewhat against a bigger
problem in utilization signal distortion due to utilization invariance causing
what I call black hole effect. The lower the capacity, the harder it is to
accumulate runtime to cause the signal to rise acting like a gravitational pull
causing time dilation.

One of the major difficulties we will face is that this distortion turns up bad
for performance but good for power. The fix will inevitably rebalance the
system, while in the right way, but also in a surprising way to potentially
cause some to be unhappy. sched_features were added to ensure those unhappy
folks can revert the system to the old behavior while still allow us to make
the right progress.

That is to retain the older behavior one must:

	echo 0 | sudo tee /proc/sys/kernel/sched_qos_default_rampup_multiplier
	echo CONST_DVFS_HEADROOM NO_UTIL_EST_RAMPUP_ZERO UTIL_EST_FORCE_POST_INIT > /sys/kernel/debug/sched/features

Note for migration margin there's no sched features since I think the old
behavior was worse for perf and power and doesn't require reverting back to.

The system is going to be a lot faster now by default with
sched_qos_default_rampup_multiplier=1 since it fixes the distortion issue and
provides a constant rise time regardless of DVFS latencies.

The desired behavior is for default rampup_multiplier to be 0 and only those
interactive tasks to request a higher rampup multiplier. Preliminary
integration with schedqos is available [3] for those who want to see the full
benefit of fine grained control to mange perf and power.

Open questions:

* The details of the QoS interface is the biggest one.
* Would debugfs be better for setting the default rampup multiplier instead of sysctl?
* Patch 13 makes updating load_avg unconditional not on period boundaries.

Patches 1-3 are prepatory patches renaming a function and introducing new ones.

Patches 4-5 handle the magic margin problem but making them dynamic based on
actual hardware limitations.

Patches 6-7 fix the black hole problem and teaches the scheduler how to handle
bursty and periodic tasks via extending util_est.

Patches 8-9 is where I expect most of the discussion on as I introduce a new
sched_qos interface to support the new rampup_multiplier to help manage DVFS.

Patches 10-11 introduces a couple of necessary optimizations to counter the
power impact of increased responsiveness by disabling some features that we now
know how to handle better.

Patches 12-13 fix a couple of issues causing util_est and util_avg value to
swing for a periodic task. Patch 12 must go via stable.

My mac mini M1 system where I did the testing on before is down and it has been
proven difficult to revive it before sending this series. I will revive and
repeat the testing to ensure all is okay after the rebase.

I did test it on AMD system, but it has only 3 freqs so no real perf numbers to
report since it just whizzes by these 3 freqs anyway. But I did spend enough
time to verify the util_est behaves as expected under different scenarios. More
testing would still be appreciated :)

[1] https://lore.kernel.org/lkml/20240820163512.1096301-1-qyousef@layalina.io/
[2] https://lpc.events/event/18/contributions/1880/
[3] https://github.com/qais-yousef/schedqos/compare/main...schedqos

Qais Yousef (13):
  sched: cpufreq: Rename map_util_perf to sugov_apply_dvfs_headroom
  sched/pelt: Add a new function to approximate the future util_avg
    value
  sched/pelt: Add a new function to approximate runtime to reach given
    util
  sched/fair: Remove magic hardcoded margin in fits_capacity()
  sched: cpufreq: Remove magic 1.25 headroom from
    sugov_apply_dvfs_headroom()
  sched/fair: Extend util_est to improve rampup time
  sched/fair: util_est: Take into account periodic tasks
  sched/qos: Add a new sched-qos interface
  sched/qos: Add rampup multiplier QoS
  sched/fair: Disable util_est when rampup_multiplier is 0
  sched/fair: Don't mess with util_avg post init
  sched/fair: Call update_util_est() after dequeue_entities()
  sched/pelt: Always allow load updates

 Documentation/scheduler/index.rst             |   1 +
 Documentation/scheduler/sched-qos.rst         |  66 ++++++++++
 include/linux/sched.h                         |  10 ++
 include/linux/sched/cpufreq.h                 |   5 -
 include/uapi/linux/sched.h                    |  10 +-
 include/uapi/linux/sched/types.h              |  46 +++++++
 kernel/sched/core.c                           |  71 ++++++++++
 kernel/sched/cpufreq_schedutil.c              |  49 ++++++-
 kernel/sched/debug.c                          |   1 +
 kernel/sched/fair.c                           | 124 ++++++++++++++++--
 kernel/sched/features.h                       |  21 +++
 kernel/sched/pelt.c                           |  44 ++++++-
 kernel/sched/sched.h                          |  12 ++
 kernel/sched/syscalls.c                       |  61 +++++++++
 .../trace/beauty/include/uapi/linux/sched.h   |   4 +
 15 files changed, 501 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/scheduler/sched-qos.rst

-- 
2.34.1

