Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E971F09A8
	for <linux-pm@vger.kernel.org>; Mon,  4 May 2026 02:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777860031; cv=none; b=k7brHPnEI/4yymE3FGm/s/q5ZrPJj/CLJG8ouSJ+/A/36b5GYpQCLEtoW+6JFtuUft9RUPwX/LZmYgfAqI3jWwYMnkExwGLDTP4bE/xC5/eP3T8TCHH3G3OYndGecp2lza26a/7lbedr37F37Y4OPHgyqao1rGS36XkZ/np5Xj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777860031; c=relaxed/simple;
	bh=2nLzsKYtPFhQH9YPjL0PFapNrdsVRfOd+Hro4eW9RKY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mbNQHRpYaSwLHaCatN/GCJUESuqacqThGpu70n3JOCdInd+qFIORkowx4dEnFTVgWrFKADqr4+rstbb3pHqd3xQhqspyJkYDI0uR5AFR8/GJbrzbyCj3xjzi3JYKyuMlXl7DkIoGAihouP1aHbfooj872+6sElL8qy9sP4nSpNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b=mf6CcL0c; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b="mf6CcL0c"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso27155375e9.3
        for <linux-pm@vger.kernel.org>; Sun, 03 May 2026 19:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20251104.gappssmtp.com; s=20251104; t=1777860027; x=1778464827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5cMKXE4HTk3LJQjUYjfql/GlKLvXEff/TpETqEGuMI=;
        b=mf6CcL0c6UyEiKmPAI0fNKSFnvvJ/Hdpep4K6QeCbQqk3QN34LGy1wuFytR/60vN+0
         UY13sM5YJn77on48xK0gc/aOkzi0wfcS82ccBGtEyrHzWEzFGnjgW8+YVd++qD3fiIn2
         K/Z3ueuS1oy5sHMBlbHAr96xRDOHwvCwkCRQW6w7bccru3FqO3WqflMRSbPXoAX6fgB0
         8fqpke6ZevoIZZnX1dZ7FNr7QpPvL44wpgSoJCHC5AxQ4RtYkWWV9lrJYGrtAc17AxMb
         /RSA7ex5jRqRHmRf0joVMxYCMyc8hrcBlzg+gBJ9z7BiKEvq6XQm594Ityj7FiCdS/3Y
         FDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777860027; x=1778464827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+5cMKXE4HTk3LJQjUYjfql/GlKLvXEff/TpETqEGuMI=;
        b=SeiNDBdSWSeUIMN9o/vmhHlNp1sYDTbD8waswZM0rzupiPWexUN3QYE8o/CPVIniH1
         jXRxRScjTviGUP4r8OPXu6alNUHwdEtkIo7n6L7HJG56vDHXc0mBfqeOGElhlF7poqT/
         PXRylQfluKgRMrfpTcdnnPsOqy1LVoBW7i3TbWTwZ9rN/ruVAlQLIS4Bt7tRyaZ86KFT
         HG6STQYk5EFMeUyZ0zdYf9BQS0eRMErYi8M4HS7TSPAQIGa0p9L7KPtuD4Vu9Od8tw1L
         Esu/PZiyri16WZ3rC0UITFIkY5LKM9u+EFcbCIUN6mYuUA+YigNgdwEcP97yJApA1OcS
         cBvg==
X-Forwarded-Encrypted: i=1; AFNElJ9f6bk/7EkyiNNNJoc25IYE9HrtJgpWWJ5Y2dNc/0J7jxeTwUEDo6XXCiBc6k3aiG9cfdsLONPPSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUAmHxZIHDDBbUV/xUvgzEOg5hRu2S1mH0OyxKjgSABCfTyZd7
	j198tXts9d7w9mXzJYdGwFKgl3nTWkZKgnuqaN0ZblfvwQcD7jRgykSyHrQVakNvKlo=
X-Gm-Gg: AeBDiesph8xnhtv0LdIBp0BztnNxk6gRvLzY+lYVUw4680Ult6nOM2J8ibb6J17R10H
	OFeLMrZARpsUHB2BA+b2imonWDBXjQhqHuB/zFBt6xJVE/ux0BdJvL3BF3XxzRS3iAXEasonHGq
	z7rBBKNGzd6B8PhvaDAHDyVOy5hqUAc+YVnkjjLE1kyXq/ctOiB0MzZToOqrTqHt9HLn2oasyc+
	ISWPgkCVgkwv36NQKF1VtVZfcrmJ4ikb2GPqeOV0XROT9XwTQ6Ag8ZG/cPMA0JFC419BHUhR0Ge
	qPuAs6+uOT5eP2CXxcT+pBB6bd+3WlK6sCIVPX7sNExsWL5GNgIw8n6szAuUCY8eRRzd3nqV5Bv
	PPKN9MMMeLdyGe7ZwzytsrGkNFKJC6NxByarsHR/KdwK5F/SKu5Pd8FOQLT7N3FCCz/2WXjBLbe
	jGNcWifId1bYxNNfB+jJ6cZ8GyOO6TAwE=
X-Received: by 2002:a05:600c:4f91:b0:489:149a:f9e7 with SMTP id 5b1f17b1804b1-48a98674fadmr118963015e9.27.1777860026695;
        Sun, 03 May 2026 19:00:26 -0700 (PDT)
Received: from airbuntu.. ([146.70.179.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fee5033sm68064215e9.22.2026.05.03.19.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 19:00:25 -0700 (PDT)
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
Subject: [PATCH v2 06/13] sched/fair: Extend util_est to improve rampup time
Date: Mon,  4 May 2026 02:59:56 +0100
Message-Id: <20260504020003.71306-7-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260504020003.71306-1-qyousef@layalina.io>
References: <20260504020003.71306-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Utilization invariance can cause big delays. When tasks are running,
accumulate non-invairiant version of utilization to help tasks to settle
down to their new util_avg values faster.

Keep track of delta_exec during runnable across activations to help
update util_est for a long running task accurately. util_est shoudl
still behave the same at enqueue/dequeue.

Before this patch the a busy task tamping up would experience the
following transitions, running on M1 Mac Mini

                            rampup-6338 util_avg running
     ┌─────────────────────────────────────────────────────────────────────────┐
986.0┤                                                               ▄▄▄▄▄▟▀▀▀▀│
     │                                                        ▗▄▄▟▀▀▀▘         │
     │                                                    ▗▄▟▀▀                │
     │                                                 ▄▟▀▀                    │
739.5┤                                              ▄▟▀▘                       │
     │                                           ▗▄▛▘                          │
     │                                         ▗▟▀                             │
493.0┤                                       ▗▛▀                               │
     │                                    ▗▄▛▀                                 │
     │                                  ▄▟▀                                    │
     │                                ▄▛▘                                      │
246.5┤                             ▗▟▀▘                                        │
     │                          ▄▟▀▀                                           │
     │                      ▗▄▄▛▘                                              │
     │                 ▗▄▄▄▟▀                                                  │
  0.0┤  ▗         ▗▄▄▟▀▀                                                       │
     └┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬┘
    1.700   1.733   1.767   1.800   1.833   1.867   1.900   1.933   1.967 2.000

───────────────── rampup-6338 util_avg running residency (ms) ──────────────────
0.0   ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 5.5
15.0  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 7.9
36.0  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 8.0
57.0  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 8.0
78.0  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 7.9
98.0  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 5.0
117.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 5.0
137.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 5.0
156.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 4.0
176.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 3.0
191.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 4.0
211.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 4.0
230.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 3.0
248.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 3.0
266.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
277.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 3.0
294.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.6
311.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.4
327.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
340.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 3.0
358.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
371.0 ▇▇▇▇▇▇▇▇▇ 1.0
377.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
389.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
401.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
413.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 3.0
431.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
442.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
456.0 ▇▇▇▇▇▇▇▇▇ 1.0

───────────────────────── Sum Time Running on CPU (ms) ─────────────────────────
CPU0.0 ▇▇▇▇▇ 90.39
CPU4.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 1156.93

                            6338 rampup CPU0.0 Frequency
    ┌──────────────────────────────────────────────────────────────────────────┐
2.06┤                                ▛▀▀                                       │
    │                                ▌                                         │
    │                                ▌                                         │
    │                                ▌                                         │
1.70┤                             ▛▀▀▘                                         │
    │                             ▌                                            │
    │                             ▌                                            │
1.33┤                         ▗▄▄▄▌                                            │
    │                         ▐                                                │
    │                         ▐                                                │
    │                         ▐                                                │
0.97┤                     ▗▄▄▄▟                                                │
    │                     ▐                                                    │
    │                     ▐                                                    │
    │                     ▐                                                    │
0.60┤  ▗         ▗▄▄▄▄▄▄▄▄▟                                                    │
    └┬───────┬───────┬───────┬───────┬────────┬───────┬───────┬───────┬───────┬┘
   1.700   1.733   1.767   1.800   1.833    1.867   1.900   1.933   1.967 2.000

                            6338 rampup CPU4.0 Frequency
    ┌──────────────────────────────────────────────────────────────────────────┐
3.20┤                                                    ▐▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀│
    │                                                    ▐                     │
    │                                                  ▛▀▀                     │
    │                                                  ▌                       │
2.78┤                                               ▐▀▀▘                       │
    │                                             ▗▄▟                          │
    │                                             ▌                            │
2.35┤                                          ▗▄▄▌                            │
    │                                          ▐                               │
    │                                        ▄▄▟                               │
    │                                        ▌                                 │
1.93┤                                     ▗▄▄▌                                 │
    │                                     ▐                                    │
    │                                     ▐                                    │
    │                                     ▐                                    │
1.50┤                                  ▗▄▄▟                                    │
    └┬───────┬───────┬───────┬───────┬────────┬───────┬───────┬───────┬───────┬┘
   1.700   1.733   1.767   1.800   1.833    1.867   1.900   1.933   1.967 2.000

───────────────── 6338 rampup CPU0.0 Frequency residency (ms) ──────────────────
0.6   ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 37.300000000000004
0.972 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 15.0
1.332 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 15.0
1.704 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 11.0
2.064 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 12.1

───────────────── 6338 rampup CPU4.0 Frequency residency (ms) ──────────────────
1.5   ▇▇▇▇▇▇▇▇▇▇ 11.9
1.956 ▇▇▇▇▇▇▇▇ 10.0
2.184 ▇▇▇▇▇▇▇▇ 10.0
2.388 ▇▇▇▇▇▇▇▇▇ 11.0
2.592 ▇▇▇▇▇▇▇▇ 10.0
2.772 ▇▇▇▇▇▇▇▇ 10.0
2.988 ▇▇▇▇▇▇▇▇ 10.0
3.204 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 85.3

After the patch the response is improved to rampup frequencies faster
and migrate from little quicker

                           rampup-2234 util_avg running
   ┌───────────────────────────────────────────────────────────────────────────┐
984┤                                                                ▗▄▄▄▄▄▛▀▀▀▀│
   │                                                          ▄▄▟▀▀▀▀          │
   │                                                     ▄▄▟▀▀                 │
   │                                                  ▄▟▀▘                     │
738┤                                               ▄▟▀▘                        │
   │                                            ▗▟▀▘                           │
   │                                          ▗▟▀                              │
492┤                                        ▗▟▀                                │
   │                                      ▗▟▀                                  │
   │                                     ▟▀                                    │
   │                                   ▄▛▘                                     │
246┤                                 ▗▟▘                                       │
   │                               ▗▟▀                                         │
   │                             ▗▟▀                                           │
   │                           ▗▟▀                                             │
  0┤                       ▄▄▄▛▀                                               │
   └┬───────┬───────┬────────┬───────┬───────┬───────┬────────┬───────┬───────┬┘
  1.700   1.733   1.767    1.800   1.833   1.867   1.900    1.933   1.967 2.000

───────────────── rampup-2234 util_avg running residency (ms) ──────────────────
0.0   ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 5.6000000000000005
15.0  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 8.0
39.0  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 5.0
61.0  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 4.0
85.0  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
99.0  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 3.0
120.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 3.0
144.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
160.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
176.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
192.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
210.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
228.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
246.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
263.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
282.0 ▇▇▇▇▇▇▇ 1.0
291.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
309.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
327.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
344.0 ▇▇▇▇▇▇▇ 1.0
354.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
373.0 ▇▇▇▇▇▇▇ 1.0
382.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
400.0 ▇▇▇▇▇▇▇ 1.0
408.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
425.0 ▇▇▇▇▇▇▇ 1.0
434.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
452.0 ▇▇▇▇▇▇▇ 1.0

                            2234 rampup CPU1.0 Frequency
    ┌──────────────────────────────────────────────────────────────────────────┐
2.06┤                             ▐▀                                           │
    │                             ▐                                            │
    │                             ▐                                            │
    │                             ▐                                            │
1.70┤                            ▛▀                                            │
    │                            ▌                                             │
    │                            ▌                                             │
1.33┤                           ▄▌                                             │
    │                           ▌                                              │
    │                           ▌                                              │
    │                           ▌                                              │
0.97┤                         ▗▄▌                                              │
    │                         ▐                                                │
    │                         ▐                                                │
    │                         ▐                                                │
0.60┤                      ▗▄▄▟                                                │
    └┬───────┬───────┬───────┬───────┬────────┬───────┬───────┬───────┬───────┬┘
   1.700   1.733   1.767   1.800   1.833    1.867   1.900   1.933   1.967 2.000

                            2234 rampup CPU4.0 Frequency
    ┌──────────────────────────────────────────────────────────────────────────┐
3.10┤                                                            ▐▀▀▀▀▀▀▀▀▀▀▀▀▀│
    │                                                 ▛▀▀▀▀▀▀▀▀▀▀▀             │
    │                                                 ▌                        │
    │                                            ▐▀▀▀▀▘                        │
2.70┤                                            ▐                             │
    │                                        ▐▀▀▀▀                             │
    │                                        ▐                                 │
2.30┤                                      ▛▀▀                                 │
    │                                      ▌                                   │
    │                                   ▐▀▀▘                                   │
    │                                   ▐                                      │
1.90┤                                 ▐▀▀                                      │
    │                                 ▐                                        │
    │                               ▗▄▟                                        │
    │                               ▐                                          │
1.50┤                              ▗▟                                          │
    └┬───────┬───────┬───────┬───────┬────────┬───────┬───────┬───────┬───────┬┘
   1.700   1.733   1.767   1.800   1.833    1.867   1.900   1.933   1.967 2.000

───────────────────────── Sum Time Running on CPU (ms) ─────────────────────────
CPU1.0 ▇▇▇▇ 32.53
CPU4.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 540.3

───────────────── 2234 rampup CPU1.0 Frequency residency (ms) ──────────────────
0.6   ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 12.1
0.972 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 6.5
1.332 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 3.7
1.704 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 5.5
2.064 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 4.8

───────────────── 2234 rampup CPU4.0 Frequency residency (ms) ──────────────────
1.5   ▇▇▇▇▇ 4.0
1.728 ▇▇▇▇▇▇▇▇▇▇ 8.0
1.956 ▇▇▇▇▇▇▇▇▇▇▇▇ 9.0
2.184 ▇▇▇▇▇▇▇▇▇▇▇▇ 9.0
2.388 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 11.0
2.592 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 16.0
2.772 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 18.0
2.988 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 47.0
3.096 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 53.4

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 include/linux/sched.h |  1 +
 kernel/sched/core.c   |  1 +
 kernel/sched/fair.c   | 41 ++++++++++++++++++++++++++++++++++-------
 3 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8ec3b6d7d718..b61da16861e7 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -589,6 +589,7 @@ struct sched_entity {
 					/* hole */
 
 	u64				exec_start;
+	u64				delta_exec;
 	u64				sum_exec_runtime;
 	u64				prev_sum_exec_runtime;
 	u64				vruntime;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3fbf560203f3..fe14fd4a2d53 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4391,6 +4391,7 @@ static void __sched_fork(u64 clone_flags, struct task_struct *p)
 
 	p->se.on_rq			= 0;
 	p->se.exec_start		= 0;
+	p->se.delta_exec		= 0;
 	p->se.sum_exec_runtime		= 0;
 	p->se.prev_sum_exec_runtime	= 0;
 	p->se.nr_migrations		= 0;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4e1ed3c7f96e..c6363ec5de9d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1344,6 +1344,7 @@ static s64 update_se(struct rq *rq, struct sched_entity *se)
 		 */
 		running->se.exec_start = now;
 		running->se.sum_exec_runtime += delta_exec;
+		running->se.delta_exec += delta_exec;
 
 		trace_sched_stat_runtime(running, delta_exec);
 		account_group_exec_runtime(running, delta_exec);
@@ -1362,7 +1363,6 @@ static s64 update_se(struct rq *rq, struct sched_entity *se)
 		__schedstat_set(stats->exec_max,
 				max(delta_exec, stats->exec_max));
 	}
-
 	return delta_exec;
 }
 
@@ -5099,15 +5099,30 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	if (!sched_feat(UTIL_EST))
 		return;
 
+	/* Get current estimate of utilization */
+	ewma = READ_ONCE(p->se.avg.util_est);
+
 	/*
-	 * Skip update of task's estimated utilization when the task has not
-	 * yet completed an activation, e.g. being migrated.
+	 * If a task is running, update util_est ignoring utilization
+	 * invariance so that if the task suddenly becomes busy we will rampup
+	 * quickly to settle down to our new util_avg.
 	 */
-	if (!task_sleep)
-		return;
+	if (!task_sleep) {
+		u64 delta = p->se.delta_exec;
+		unsigned int prev_ewma = ewma & ~UTIL_AVG_UNCHANGED;
 
-	/* Get current estimate of utilization */
-	ewma = READ_ONCE(p->se.avg.util_est);
+		do_div(delta, 1000);
+		ewma = approximate_util_avg(prev_ewma, delta);
+		/*
+		 * Keep accumulating delta_exec if it is too small to cause
+		 * a change.
+		 */
+		if (ewma != prev_ewma)
+			p->se.delta_exec = 0;
+		goto done;
+	} else {
+		p->se.delta_exec = 0;
+	}
 
 	/*
 	 * If the PELT values haven't changed since enqueue time,
@@ -5170,6 +5185,14 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	trace_sched_util_est_se_tp(&p->se);
 }
 
+static inline void util_est_update_running(struct cfs_rq *cfs_rq,
+					   struct task_struct *p)
+{
+	util_est_dequeue(cfs_rq, p);
+	util_est_update(cfs_rq, p, false);
+	util_est_enqueue(cfs_rq, p);
+}
+
 static inline unsigned long get_actual_cpu_capacity(int cpu)
 {
 	unsigned long capacity = arch_scale_cpu_capacity(cpu);
@@ -9245,6 +9268,8 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 simple:
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 	put_prev_set_next_task(rq, prev, p);
+	if (prev->on_rq)
+		util_est_update_running(&rq->cfs, prev);
 	return p;
 
 idle:
@@ -13670,6 +13695,8 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 		entity_tick(cfs_rq, se, queued);
 	}
 
+	util_est_update_running(&rq->cfs, curr);
+
 	if (queued) {
 		if (!need_resched())
 			hrtick_start_fair(rq, curr);
-- 
2.34.1

