Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CF03D648A
	for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 06:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781245546; cv=none; b=DdP131e31XWamaXoGmszhqcoDDovRbfOecfGGynSlE/nGz3i1FW9eFFpYpZh2FhTLUllb4DsCmWMTQj1oTOiSPzBBqC0n2kbEj0QHCEifyIW6N0nLHPrW0VY+l4NrO6AqrWJ5jMA0sQ3Au4Fy/AFCRa5J7feCuXRaW6m69c/5Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781245546; c=relaxed/simple;
	bh=ME6/4at17uE0uQ6UzaFOgHaMMc5xs8aEQfTQpokV1NM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dE9HhlObpJzHCrS9K9ON7zQLRksdQi7NHvher04KmjrLUBG5gzEiYquvW39HVL7j2nxpIPpaISKs0xAGFP/KrxuXcUB2hryuWpLXNKMjdz+hrFQCmhOX0hPbdyaPyWHo8UfhBwbqKNoyTLkNXwVDHNp5ntQle8IVjd6o5zAn5rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=soY8tL+2; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="soY8tL+2"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490b915ded5so4824175e9.3
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 23:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781245541; x=1781850341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ER2GZASA5JjD1TFnAJvDRP44OshxUfqSF2ema9VeuQc=;
        b=soY8tL+22tQUdfGj3eQ6UVoSbb1wbyZ+JOBKF2pkXb0qhKUvUVJp7hMPNNrvYhKxXH
         KhbDuCo8g7pvf2ChltPHpTS4AG4+HGOC4YY3eaqMXyQooKAecC1GtHK4znx1HrTM4sLT
         4Aj6nCd0OEvPatO9mxD4kWYm7y4R7iEb+wb9bzE9Qnj9wfvgafqYwnUuAtp4sTZBxhXi
         h6S87aLbMr+LW22zHdH/Xd34q8DFbldl+jXiyHjN8vOpcV7nzY1OAeLiho0kKpK7nKBM
         IchI12XZXI8jwDd6ZoB0UKpaf4aU7X+pqTBY5D16YT7xFj5bL+Tms8zXj31twhaxzS8w
         BQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781245541; x=1781850341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ER2GZASA5JjD1TFnAJvDRP44OshxUfqSF2ema9VeuQc=;
        b=PqxemaxAcazAqhXyqn0jaJ2bJDK5BKbeziOutYS3nbRJvqiDIdITdJencdspMLQZWi
         7Z9uqAz4msIe5nEzRXq6fkb/GddQBkk+368YG7/BdaDliz/3dKDgqW7qYmLGGBcdPTIb
         NuPP0I4K313NRvA0tl5X9TFuwioaSWTyLydz2P4uMhqZkS7qFtCQnMm6NR+1AZox8PJd
         3q5XqRSBzly4+GGV1zlsIwHxQdsQF0WqiC/rBW1ocwSIolqMqs9aVWmr/mEoglaudw8f
         iYNanyCZO3+8dOQ+iQ19GqrBhQcAweEvm9eNQ//iRDocK8UTpALNp0R8ZRUM/zqEcW64
         eFAQ==
X-Gm-Message-State: AOJu0Yxg/5PpjGvHG4Bw7dEHtBECO85maXSs6n6n9K12LuKitlN7+mM/
	MIZ8bvKYGi48wnwXMC124ZPIiECEo74EIr657eDpfWtKi4LLLZYRGkztjGD7IK3M
X-Gm-Gg: Acq92OHPTcPH3qKSHQ344sk7z2LqgrQH7+JR7lxG9GCevq0xh6w8ZRIweEUAPMybYaF
	LaCAWoJ9SNOB40EXY0GZjd5eV+d6hQJo2T3mJI4knb+/3/AdiKa0vb4n+COiMgLsMal4W3LQ6hg
	MKkWr9TidalrLTMY/3t2w44UKvPacPTjdSp+oP7RONN/e9pGYeluOT1knqAFGPDGLPuJvo8VzFO
	UrLjCETEpCwdrOOhgZ8iXpuZlXbwWHQeAnU9MXUoz+lP0ZDgMwznOmtnWHsSxCoZTMi8bl2arpM
	2FV9zIwdPaglIayl5F636cc5E3WlyqkQXg3mZYU9SPRR2+sZFkndUw55vFTWI1GJrJNha3rjUCc
	xDMG0uon5MksbS/vi34UbpRTWLApOf0sIdp85XLZhl+0p61Sxmy5Puex+sOOD1K4lLfg3xSRjGc
	1q0oYH6Qvd21wT3DdFYfpiF9TUj2sYHFPjDBNhxwVrfmOd4UbIxoCKnqSmJoaaI0mumVo4rwR4o
	9Js//JmSdrYmRowFOHVKTT2rxhNjL0PsYwvZyGwpaf+Uw==
X-Received: by 2002:a05:600c:820c:b0:489:5022:39a4 with SMTP id 5b1f17b1804b1-490ec4d652amr14475065e9.9.1781245540476;
        Thu, 11 Jun 2026 23:25:40 -0700 (PDT)
Received: from MBP-Elazar-Leibovich.civet-hops.ts.net (bzq-85-130-200-168.static-ip.bezeqint.net. [85.130.200.168])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea83d8dasm52501375e9.11.2026.06.11.23.25.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Jun 2026 23:25:39 -0700 (PDT)
From: Elazar Leibovich <elazarl@gmail.com>
To: linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-kernel@vger.kernel.org,
	Elazar Leibovich <elazarl@gmail.com>
Subject: [PATCH 0/2] powercap: dtpm: Fix out-of-bounds read in the set_pd_power_limit() callbacks
Date: Fri, 12 Jun 2026 09:25:34 +0300
Message-ID: <20260612062536.9147-1-elazarl@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The set_pd_power_limit() callbacks in dtpm_cpu and dtpm_devfreq scan
the EM perf state table for the first state whose power exceeds the
requested limit, then use table[i - 1]. If the very first perf state
already exceeds the limit, the loop breaks at i == 0 and table[-1] is
read out of bounds.

The powercap core clamps the requested limit to dtpm->power_min, but
that clamp can be computed from stale data: in dtpm_cpu the number of
online CPUs may have grown since power_min was last updated, and in
dtpm_devfreq the EM table may have been updated at runtime via
em_dev_update_perf_domain(). In both cases the clamped limit can still
be below the first state's power, making the underflow reachable.

Start the scan at index 1 so the lowest perf state is used as the
fallback when even it exceeds the requested limit.

No functional dependency, but minor context offsets assume the dtpm
NULL-guard series posted earlier [1].

[1] https://lore.kernel.org/linux-pm/20260611204658.47987-1-elazarl@gmail.com/

Sivan Zohar-Kotzer (2):
  powercap: dtpm_cpu: Fix out-of-bounds read in set_pd_power_limit()
  powercap: dtpm_devfreq: Fix out-of-bounds read in set_pd_power_limit()

 drivers/powercap/dtpm_cpu.c     | 2 +-
 drivers/powercap/dtpm_devfreq.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.50.1 (Apple Git-155)

