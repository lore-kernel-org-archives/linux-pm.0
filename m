Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB30299929
	for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2026 03:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787887507; cv=none; b=NPH7IsBSfZ7XWcF/rMB42zCn6dsonqX454VQfdpIcIB3xUmpl9yNIRv7CQKGwdSdcKeGoS/qIG9nTB3wXN1ZTjCeLM7qjy1VYLG9D1DMfhwCzNRUBHhRnQXiDafxZU8jeFXEUO21c6SztUOEHx8sJfjLm/+B91s7BIUEX2m5ZHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787887507; c=relaxed/simple;
	bh=yt+mLfSWcK0f6sKjTvFhMgbeBoBtwF/0GIVGw2ZnO4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dEeyP/d9yqo0PfQf+wXai2UaB4ZfzZYp94nxt+EgQWbiVot2bNXosQ+2LpETx4mjiAFtoFwZa3LlSjZZEPpwwuXk8v9bpplk4J24xTupE8n76nG9Qb3HcrmIsssTTRANa+cO7y1QJ0iaW1jBTrWw1vMMVtWymb7X+kqDF8E7WU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-396d27bb2beso489631a91.0
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 20:25:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787887505; x=1788492305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BaJs+obz6L+QhNc39Iv8LiC8QOj4nRSSCQxNzvKMxEk=;
        b=DHM52PGQQ1OYYjGvlacf5nslKDAyF6YF6h4+b5Xc0zrkwvGfLW6Sj4vAuEvF9P09Vx
         RrsgfyAu1E06cRgNPhLPh/4VeQR6LP5+Kk0s16tvQs3EeHhD2u7HRVJWlzMUYn2MIuBF
         7mdcVdXNrSGurKDZ7JWKbHvoM8etYlkgTdBt9lyW8jj+8zt5oxWJYw4JxtY8bLE/+/rg
         sBygSM83ikeL+RG23U12bLB6rL8qOt8cDvphBkbmYuXJUr1djBSdY5S4QzINe6FxKqdu
         uW8fUWbFBUFWsrX8LtbGGKCvEjwyBwXuCENTlLsjeDYcX2oNwoosreg80SMwh/sjU96X
         twBQ==
X-Gm-Message-State: AFuF++k4c9Natru+DHTyT4/2RiawzzqRL7QH7DpIQQljxJJVlMvy9Egh
	79F/VgRcq0hVWCVeKdhO43b0KXNtUgmDvw/Nt/VlRZh2jLvppNbbobgh
X-Gm-Gg: AR+sD13C75T9isTTCjqcbvO5lcsAx2WE5AXv27m6leMwpQ8EsIAyISB+vV+HeOsC32+
	MlPfkH5qnajdKSOJqGCVbGHbrRQ9UgRhHiScr1VNIXOL+kLS3j/l+r0boBFwRZKAk/P+zQZfvf0
	DVZSj3LDM2kSsFPyOb6Hlna2VGSGI/dv5ooPYCn4DP0EmAVzT8sy5997BBRCVvTlqSWEZbYCQQo
	tewoY6omnZ9IX0dyFcZZx1X7GorazMtwxBpE9g48z2Hn2ovTmzYp5VkKyBmxtOj6c8XSXj1+lVI
	kr5QX3CYedsk0D8yJjbwotsa0Se8r9CeZmA1wSXE9e7Mat/s/edwdep4GksfG+UuOHKYsKGwuzF
	9EkJyv0uAFnMQ+48cnPi3U0BTIFlfA5jJMzrAci3Qxl5hhoLSzO5B45bbo3yTcs0Lkcb+hrq75p
	vY/n5tsQzHGHyGpBxPUn2kHOZIeg/ykT0Tuz4OAK+0m+8pHdKAX/xddjLavLBGga3PUiV16JvPT
	+wMT7+nCJJmSlW/18+h
X-Received: by 2002:a17:90b:2b90:b0:38a:c3f:3b87 with SMTP id 98e67ed59e1d1-396d0fce294mr8160222a91.12.1787887505458;
        Thu, 27 Aug 2026 20:25:05 -0700 (PDT)
Received: from kylin-XiaoXinPro-16-AHP9.. ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b1ab4e12sm5142275a91.16.2026.08.27.20.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 20:25:05 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	daniel.lezcano@kernel.org,
	christian.loehle@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH v2] cpuidle: teo: Do not return a disabled idle state
Date: Fri, 28 Aug 2026 11:24:57 +0800
Message-ID: <20260828032457.2317326-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If idle state 0 is disabled and none of the enabled idle states satisfies
the PM QoS latency constraint, constraint_idx in teo_select() stays at its
initial value of 0, because the loop that updates it starts at state 1,
and so the candidate state index is capped at state 0, which is disabled,
and that state is returned to the caller.

The cpuidle core does not validate the returned state index against the
per-state disable flags, so the CPU ends up entering the disabled state 0.

To address this, ensure that constraint_idx is at least equal to the index
of the first enabled idle state (idx0), so that the candidate state is
never capped to a disabled one.

Fixes: c410a9a142f1 ("cpuidle: teo: Change the main idle state selection logic")
Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
---
v1 -> v2:
    - Instead of falling back to idx0 after the candidate index has been
      capped to a disabled state, ensure that constraint_idx is at least
      equal to idx0 before the capping check (suggested by Rafael J. Wysocki).

 drivers/cpuidle/governors/teo.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
index ac43b9b013b3..906f4f89e365 100644
--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -426,6 +426,17 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		}
 	}
 
+	/*
+	 * If the latency constraint does not allow any of the enabled idle
+	 * states to be used, the candidate state index will be capped to 0
+	 * by the check below, but state 0 may be disabled.  To prevent the
+	 * selection of a disabled state in that case, ensure that
+	 * constraint_idx is at least equal to the index of the first
+	 * enabled idle state.
+	 */
+	if (constraint_idx < idx0)
+		constraint_idx = idx0;
+
 	/*
 	 * If there is a latency constraint, it may be necessary to select an
 	 * idle state shallower than the current candidate one.
-- 
2.43.0

