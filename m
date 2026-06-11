Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D053D4D2EF6
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 20:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781210827; cv=none; b=F5CdL4QnfAlbACf/Jh9ffF1LY0TRRsvdu9dXcjE+lUR7vcR5JvzLDh84SlbmT8XBCGJ+DpgeBogxIE85GyOjpqO6vG8VEBK2gr8OgCvQaaFdWpYZ+Fy68KmFUx5V2efzROmFX9D3YpZhd8SXNcnfXWCM7NOrEmbLAVotCtncUvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781210827; c=relaxed/simple;
	bh=7Mwo+iIqdQx8E6U6qCCbr1Gq9IaDaII2ThvLIrQQF9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CABunNpqAeEgl2ehnqmMKlxdn9f7l2nHz1vs7EI0rVVL2HZB2TJ97HSipWrfqom9sCOvjKgNL+L6qstiTfVv0EeI1j+UZgQULbKE/G0Je6aD4k1reiRZTYgHTrmNCADihfYtVMYf5QKf5625/2Agqircm5MYfjuVdviowM6/nIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s5XZ+kR7; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s5XZ+kR7"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-460662fcb4eso183599f8f.0
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 13:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781210824; x=1781815624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mdCZ9G/0ajheplZaMy2X4Fl2JukUf3RvZhBEz4Soe+w=;
        b=s5XZ+kR7J/dOzoB7pMEJOl8NTAb0c8qpKcgZrGo80Av7/DONx8gW+sp47lTaXNnTFs
         G8zr6HYUE3IaI+h5PXR5PpAzmxqoJ4JRsZBmlMtfdRkNET9ewXTvvdKFlLNlmccCYjg8
         Ojt4/fheTpLCIrVsdBx20AQHXLtH8b3M78OVgsArOdvQVLzaR8mVR8MyhJ5Y4h9O9Akj
         uD9X8JOb10P1SDEpaMr9RCpoNnXRE3fMm1OvYygakMw2tM4uf9r+pgsHh1VHXAQXYYSa
         j3yWpc8PqwRsSBIklAJNAe/+uCIeJVRsNVlRo5QNPpawkGYWbOlkTuIBYRVzWNYcIjWe
         qBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781210824; x=1781815624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mdCZ9G/0ajheplZaMy2X4Fl2JukUf3RvZhBEz4Soe+w=;
        b=EE/qG8R/cJWiNmaRb2arZ84ufLeBXEUGFKo/BQFdcCDpt/IgIsr3KBgTsiXeGXwuKg
         QLXpErX7hK+JPyNkX2jA4Vbk6FzHkTLnh6prIu/SgrxvbBpoN4U2dUC7PqGZD0TYe5Sb
         Zw8jmY8+OKm+DStHRL0NTWRpUWZnSYWXw2tNWrCT1Wge5fYlnV/pDjZA+FZy5p5lppTs
         fP7yLHF3M+5XNEziGuMzGBB7FAbkQALbU6OTgMR7v4kM6OkpxcntmqoZyiMuUMhtflRT
         btzpJPxDBQGgMYwsT0bXD2Y85/3FBfmxpNKEiSrd3tnGmDVUCpgKUx3ObcALRkaOhqF9
         9ODQ==
X-Gm-Message-State: AOJu0YyV30T3k5JJuhwcmjPtOvPE+JbGYx+SBE8pTsJPODCfIPSrRzJg
	AA/OiZpsW9mBUuP+0hxEe85n0aOlf2Ii3/BJu05gkOFn1FiUqAufd4lPFVYXpf+o
X-Gm-Gg: Acq92OG2fAluCFzMpTSwWf/qtzdlQk4JfOOZfU3r8R9Fv8YLjWj0C9W1Ke3E6UTS1nc
	Tay9lj8Yg0SDIJuz//4w9W/PIE8LxB8ufodoMdUs0iW8IQr8bUa42xe+xN3GO86PbEeXHXqmdzO
	997FBF7CJPKLcCM1OR71+x6wOTYL+YVpsoFMkAHnKz+DuWGBFORLA14YW/ATl35mxcuUmlzFlI8
	EwzM6xZpCWn3omI77Pgf3RhxgoHGkT2DjgdmRoBaV8+AhxbVyXGvyTIULiWJtDkruTTwbfLX7Ac
	ijlO5iRwHpyObBjoeHz9LvRoMfMpuL3WkVPddDCYOpXs4ZUgHQeZ1lfX1mUHope8t+YnEfldWO8
	/dWE803NEPQCL6MmJZNBLWQgkTMsu5xmhCD476r7G9iv890aNOoCEkMLJOaezPa9ftq212NxY5X
	O7pq/nEiDWnn/KvWnquYMwRJdbZNk8mq53ulZCXX5e5Y1NJKQkG9EArMzZ84iSZyDW0ct6QBquk
	CNLB+sv21dAdqajgROgwuNGD0/q/aJvOEiH1S2mvA==
X-Received: by 2002:a05:6000:228a:b0:43c:ffee:ee94 with SMTP id ffacd0b85a97d-4606db8c6c6mr34423f8f.11.1781210824158;
        Thu, 11 Jun 2026 13:47:04 -0700 (PDT)
Received: from MBP-Elazar-Leibovich.civet-hops.ts.net (bzq-85-130-200-168.static.bezeqint.net. [85.130.200.168])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606c0d0947sm1727493f8f.16.2026.06.11.13.47.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Jun 2026 13:47:03 -0700 (PDT)
From: Elazar Leibovich <elazarl@gmail.com>
To: linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sivan Zohar-Kotzer <sivany32@gmail.com>,
	Elazar Leibovich <elazarl@gmail.com>
Subject: [PATCH 2/2] powercap: dtpm_devfreq: Guard em_pd_get() against NULL return in callbacks
Date: Thu, 11 Jun 2026 23:46:58 +0300
Message-ID: <20260611204658.47987-3-elazarl@gmail.com>
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

em_pd_get() returns NULL when the device has no energy model
registered. All three dtpm callbacks dereference the perf domain
without checking it:

1. set_pd_power_limit() — reachable from sysfs via the powercap
   constraint power_limit_uw store path. If NULL, return the current
   power limit unchanged (no-op) instead of crashing.

2. get_pd_power_uw() — reachable from sysfs via the power_uw read
   path. Return 0 if the EM is absent.

3. update_pd_power_uw() — called via dtpm_update_power(). Return
   -EINVAL if the EM is absent.

This mirrors the equivalent NULL checks in dtpm_cpu.c.

Note this only handles the case where the EM is already gone (or was
never registered) when the callback starts. A callback racing with
em_dev_unregister_perf_domain() can still observe a non-NULL perf
domain that is freed underneath it; closing that race requires
lifetime guarantees from the EM core and is addressed separately.

Fixes: e44655617317 ("powercap/drivers/dtpm: Add dtpm devfreq with energy model support")
Signed-off-by: Sivan Zohar-Kotzer <sivany32@gmail.com>
Co-developed-by: Elazar Leibovich <elazarl@gmail.com>
Signed-off-by: Elazar Leibovich <elazarl@gmail.com>
---
 drivers/powercap/dtpm_devfreq.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/powercap/dtpm_devfreq.c b/drivers/powercap/dtpm_devfreq.c
index d1dff6ccab12..cf16e2756481 100644
--- a/drivers/powercap/dtpm_devfreq.c
+++ b/drivers/powercap/dtpm_devfreq.c
@@ -39,6 +39,9 @@ static int update_pd_power_uw(struct dtpm *dtpm)
 	struct em_perf_domain *pd = em_pd_get(dev);
 	struct em_perf_state *table;
 
+	if (!pd)
+		return -EINVAL;
+
 	rcu_read_lock();
 	table = em_perf_state_from_pd(pd);
 
@@ -60,6 +63,9 @@ static u64 set_pd_power_limit(struct dtpm *dtpm, u64 power_limit)
 	unsigned long freq;
 	int i;
 
+	if (!pd)
+		return dtpm->power_limit;
+
 	rcu_read_lock();
 	table = em_perf_state_from_pd(pd);
 	for (i = 0; i < pd->nr_perf_states; i++) {
@@ -102,6 +108,9 @@ static u64 get_pd_power_uw(struct dtpm *dtpm)
 	u64 power = 0;
 	int i;
 
+	if (!pd)
+		return 0;
+
 	mutex_lock(&devfreq->lock);
 	status = devfreq->last_status;
 	mutex_unlock(&devfreq->lock);
-- 
2.50.1 (Apple Git-155)

