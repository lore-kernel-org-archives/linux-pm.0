Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEBB44BC91
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 20:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781210825; cv=none; b=cc975mO4anaUv6l5zXXk6TAcYYxQGanR28fnCOA6hwQf3x9FaGnr/gxbO7f/Akayqf0q+/37YvLU7nr2lsKhSm25aHHO1hMrOW7ZGkGwGsHmNnQPeDmK118OYB/dHo8c7JJ0TisZo+0XsIlcgmNXk6JXOlu4CuxKOWpcmSa0E6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781210825; c=relaxed/simple;
	bh=b93JfrcRQx0CTzQvkuR+kUrMWsWAsGLNNjPAew/7MUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q+q2vZ5tGr1W6G149MRmT/jl27fIgY1otuT3NTh+YUi/KYN/3KpBSz9UxFQf5glRDznH7tGfEsI2GU1HQcQ50XzP4qRbgAtjbSHo8vAvcbYU39iwVUNXuesIraqnJlYcriUP3jr9axlLyamaEhHzbrsFzBG6e0kzbmdeCMuSEjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n1/c0rmj; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n1/c0rmj"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45efb698ef2so121714f8f.3
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 13:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781210823; x=1781815623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQkhjHws1rHibd0xf6qIemlx9VV/9yCLceOtf0Xc8T4=;
        b=n1/c0rmjwEHueIGzBIYvic2BFKgU9VE/6+CDaxjQYy3vxT1gUQf+m6sSjttfRLETg+
         H8MZhOraFmPxczWSlCjhVqr8H+sfstddtU+SXOTbVqKtT17P7o08CCs1QrOo5dkz/Hqu
         rjZX6CdRCgrOStA5g8I6fnSOYkWYb/q1+sKAfbuNjB+zmNdjCQsdZ9D9KNDg4kCW1ubr
         ib1tgEldPZ0Sy5DQjYF4iLw7JSsBFj/DriT5H/q3DGj0jKxCM+VAilpxkVaHRHha5/tp
         HLdNnePB13m4U3zQE1v/NyvCG9ST9saqp5dxSfMe2VNZ3FyQt6PymKqxDRupJu/h12YG
         zZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781210823; x=1781815623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aQkhjHws1rHibd0xf6qIemlx9VV/9yCLceOtf0Xc8T4=;
        b=Ig5UYnQCTHiz0aZBqsx+mbom9ebTLdMY+STPPYydAWfaI+SJWhLCrV5YHndZll8zhO
         7bX9RMNxUK/oVTtgzdnwiHRqtBRJpeFTf//wL+USrYTMhEngWgQxCOkUvIO9KOAwhLg+
         6uTNVaOheESlITHl73aXgxVaAB0A1Q63eCOzB3QaJpu5gQf1RrDEg6P2v6PBrco+tYgV
         X1DFb4q1M/K/rCJpqDrlLlqiwWc4DwEMZcZfbJgc1iTyrgtj87W/IlCGgEgdgAuwJ5Mm
         xOk8zvDAmPOGCYUvlrarrIVOntdn4uEdApE9chR+LUs9xXdgRxFtSCldxu3m7SG79k5n
         2x3Q==
X-Gm-Message-State: AOJu0YxcMp36bmlckUJSLCrjgAIqdW0B6SHIcxzL9W2aja68JFlo5J1W
	31KsFs+OIkxkvJmcx80HA2hrn3ijF/N11gX95QvgcZOOnEaFQPBKq82JC14+DW1h
X-Gm-Gg: Acq92OGgw9CsAvHoQ5eiOLzgoPtlKpV+T5rLffNmyKqVjDJUhZnpyrW2vJNNBxPhbTs
	09E8EOIFSqQ0ZdEqLbvBGMUNr+UXc2maH/Qe8RYUMjWXgyfAIXpVAgTUOKmnY5NzSASyVoJK2aA
	C/lMCeAvWvZJe8cUVuxROH8gBoVBIbKLnvOdQJ3uEj8FawYfFfU1tNVsqz29t2QLPoTV4hnndkD
	VxfRxyCp2NxW5PGv4XzUkOtOmlrhx6Owt/D8WWQiRXaZSUrf4sRWmZwzHuYkyA1xvLXH2TT4O/2
	gI3mJdksfjQ3igdwFdPCju2VCsyMPDRwBeu3T++claw9orAEoJbvsOPo8dLZFrg4gZPA7mlPAA+
	Je3RUtyTepmR1cLNybkiHpYV25/qMFMOVhAs/WTykbXO8vCslKAOEuU9LM3gWIpfyCHYRdSbwfW
	xZGegiU8m3IutqpgFbat3IP/c3NJfxVtALqM3Qn3aiOb/QfDgY+dfw0MarQeQnpB039bCEqoa3B
	QddnoBbKnXAFIixxlo4AgSUe4InH+RDTS8xG+jJQg==
X-Received: by 2002:a5d:64e1:0:b0:45e:e1a4:c4c3 with SMTP id ffacd0b85a97d-4606da66f9amr53784f8f.15.1781210822740;
        Thu, 11 Jun 2026 13:47:02 -0700 (PDT)
Received: from MBP-Elazar-Leibovich.civet-hops.ts.net (bzq-85-130-200-168.static.bezeqint.net. [85.130.200.168])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606c0d0947sm1727493f8f.16.2026.06.11.13.47.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Jun 2026 13:47:02 -0700 (PDT)
From: Elazar Leibovich <elazarl@gmail.com>
To: linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sivan Zohar-Kotzer <sivany32@gmail.com>,
	Elazar Leibovich <elazarl@gmail.com>
Subject: [PATCH 1/2] powercap: dtpm_cpu: Guard em_cpu_get() against NULL return in sysfs callbacks
Date: Thu, 11 Jun 2026 23:46:57 +0300
Message-ID: <20260611204658.47987-2-elazarl@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260611204658.47987-1-elazarl@gmail.com>
References: <20260611204658.47987-1-elazarl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Sivan Zohar-Kotzer <sivany32@gmail.com>

em_cpu_get() can return NULL when the CPU has no energy model registered
(e.g. during hotplug races or initialization failures). Two call sites
miss the NULL test:

1. set_pd_power_limit() — reachable from sysfs via the powercap
   constraint power_limit_uw store path. If NULL, return the current
   power limit unchanged (no-op) instead of crashing.

2. update_pd_power_uw() — called from CPU hotplug handlers via
   dtpm_update_power(). Return -EINVAL if the EM is absent, since this
   is an internal consistency failure that should not be swallowed.

The other sysfs-reachable path, get_pd_power_uw(), already has a NULL
guard returning 0.

Fixes: 0e8f68d7f048 ("powercap/drivers/dtpm: Add CPU energy model based support")
Signed-off-by: Sivan Zohar-Kotzer <sivany32@gmail.com>
Co-developed-by: Elazar Leibovich <elazarl@gmail.com>
Signed-off-by: Elazar Leibovich <elazarl@gmail.com>
---
 drivers/powercap/dtpm_cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index 99390ec1481f..0a460f97bf15 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -47,6 +47,9 @@ static u64 set_pd_power_limit(struct dtpm *dtpm, u64 power_limit)
 	u64 power;
 	int i, nr_cpus;
 
+	if (!pd)
+		return dtpm->power_limit;
+
 	nr_cpus = cpumask_weight_and(cpu_online_mask, to_cpumask(pd->cpus));
 
 	rcu_read_lock();
@@ -125,6 +128,9 @@ static int update_pd_power_uw(struct dtpm *dtpm)
 	struct em_perf_state *table;
 	int nr_cpus;
 
+	if (!em)
+		return -EINVAL;
+
 	nr_cpus = cpumask_weight_and(cpu_online_mask, to_cpumask(em->cpus));
 
 	rcu_read_lock();
-- 
2.50.1 (Apple Git-155)

