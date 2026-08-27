Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5E543B4B8
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 09:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787824114; cv=none; b=ddCg8aF1OBpTHSPg3xbQqRnTEJE7AEPx1gbsNSoblLvgT0s7K+IImjd4z9ghSLQDMq4hOKmcleQT8oG/UDfKpuUfYM+3+MFUbEAj/Nmey18Q5rKWVi1rDe7FZ2FjtPje34/Yg8eIZNJFZXABq7qUOg/atle6vb88o0XJH9ZxalQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787824114; c=relaxed/simple;
	bh=NscxapskYlED4TEjPx8+LckNB1aHKhulyJC8EsuSdVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=La+xHLWG3hzQ33m4G3tvgVE7mTc/FZSqbO7v2i8uiwjZTUY5SoAY4ekm5+zBUI7fi/EiuEpZq2Nldk7qK/ROQfn3IiX+SZpq5U5/sD1WyiSXi0ZAZXVSDJD9pAVyP4kUnzkGhQYRQ/hQiPRVvoK4GU8gfH+R0DIOjiRhXQA2kcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj2-f3.google.com with SMTP id d9443c01a7336-2d72a63f529so4934385ad.1
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 02:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787824109; x=1788428909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Liq/EJtD6N0Gi+c1SrxKgExt6xAXf4g/P6QiYJZH9PQ=;
        b=RHdmDyaRl+0ousqInN14rXVoJl+B8o4xKczsBJAI5y6/fyy6oXjeGoP/N9CE9FCfGl
         ygN5RH1G59195Lj+eHWV1JYJ4XeQo93tWNhb74U+UNYIBNyHIppxq1rMV485eh/NjfzP
         FSVsw8UvjAuaSvosDq/ohGUBR35FnmwPzp7LeJiO/JSkZC7NsnjWkkx26eA3zcz5nYLq
         eC+r/VYyZqg7zdBMP3vn6Ms3sXgLP9LPF48jI3NE4+48QAXa85nnuPpJzCa2uZ52oJYy
         bjLMUE0GppX74JJoaQSZXPZva3r1BX8WqiSQwm9T7qSJEyCUXgcwKKTlAor/2q+2fLWg
         qH3Q==
X-Gm-Message-State: AFuF++louPDz/qR2Om1MXnq2E71rBWcluqa0lOgkfuDnSuZxxc3tkES6
	3YY0ke7U0jxQF+qySAaoIeLfXx9TQqqqD+qX2V9NqFo9kAEbVxi9e2D2
X-Gm-Gg: AR+sD10jfqPDXpfasm7VgCFeZJriwKCXrLO9CCWEuHNL+a+zz3S/zG8/IXzbPyCjOhj
	Kx9LV2JoaL1+7L7WqY9X8VBKVx5KV75Ay7eDoPUcJcVgs9jQS+w5lIaDiE1lcyGuU2aZwsYvFLs
	YptVL2ZNjlUHH2v8GYywSf3skMefZnEphSgRL0rcxLFyCZUmhjgD1EaLDWlxu6pOx1kdUsjeDzM
	17X5V6p7bZY4oyFAw8hNm2WYptQx2P+emf/559zsAb5scs1YppSLQolbiTvC0PFBBlhir2Avs7d
	y1nRRbLtpcyCcivERe4dE6LXwQnZNoI0GH3XjQIcjCLUV574Rd9IuhZrL44PHSxpiFYaZ6qdARz
	UC8pb6Oj3mlkU7slevoe/mQDcPnQ1gQoxHKy/5n3OR1inXUnWUwAQGnOYeBUfCBTzC0rbYWQY4K
	z1xJun69djmXFHMEYRMRrrub31iexIsv5dNcNQVVG6mf1IEperpE6cfmQcKzCX/7lK8Fl0zA3gO
	JkbOpAgZQ==
X-Received: by 2002:a17:903:3910:b0:2ce:faa6:7cbb with SMTP id d9443c01a7336-2d707a3ed87mr269236975ad.4.1787824108816;
        Thu, 27 Aug 2026 02:48:28 -0700 (PDT)
Received: from kylin-XiaoXinPro-16-AHP9.. ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d704939c2dsm15256895ad.3.2026.08.27.02.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 02:48:28 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	daniel.lezcano@kernel.org,
	christian.loehle@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH] cpuidle: menu: Do not return a disabled idle state
Date: Thu, 27 Aug 2026 17:48:19 +0800
Message-ID: <20260827094820.3900062-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When idle state 0 is disabled and the PM QoS latency constraint is
zero (latency_req == 0), the first branch of the || in the early-return
condition of menu_select() is taken immediately, so state 0 is returned
regardless of its disable flag.

Address this by making the !disable check a prerequisite for the entire
early-return condition, so that when state 0 is disabled the normal
state selection loop is used instead, which already skips disabled
states.

Fixes: 53812cdc9100 ("cpuidle: menu: Move the latency_req == 0 special case check")
Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
---
 drivers/cpuidle/governors/menu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 544a5d593007..eb529d73d4b7 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -284,10 +284,10 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		data->bucket = BUCKETS - 1;
 	}
 
-	if (latency_req == 0 ||
-	    ((data->next_timer_ns < drv->states[1].target_residency_ns ||
-	      latency_req < drv->states[1].exit_latency_ns) &&
-	     !dev->states_usage[0].disable)) {
+	if (!dev->states_usage[0].disable &&
+	    (latency_req == 0 ||
+	     data->next_timer_ns < drv->states[1].target_residency_ns ||
+	     latency_req < drv->states[1].exit_latency_ns)) {
 		/*
 		 * In this case state[0] will be used no matter what, so return
 		 * it right away and keep the tick running if state[0] is a
-- 
2.43.0

