Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967AC42316B
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 12:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778675718; cv=none; b=St5Dq4pcMxdaFlS+Zwg+i+bQRKFavupQhOrvxmhlNhyqU7HlYoZ1TtxGVTczcvnxOIn0zgGJies5uK3M3Xivlad2uTTyosgD14P8J+PdUklDFREaonyYi+0C3ePPDnUguoJuv0L7ICWAO5WNApUotkSOUb7ku+wX+D/wlg6py28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778675718; c=relaxed/simple;
	bh=w79hVuHA22RBpp0poxJ+DBRxzHJO3nuu/xNjY6Dzt94=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RQTqZBiIbfC1zy8wvhGlHbeFk90ls5MJkf+3rdocHN+jUlYSkyE05aJBifrlYngCel1Wf8gK0Afl8uN/GH9wCUFOCX3sIufEUc+hoC0KAMp3Z6kUJTQSDWqO8ou/sr9n0oqY1xDV12zT2uaXLU1WXG5O9fqWqXemeAc6KBKr0ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mKliJFcu; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mKliJFcu"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-48fd2b502e2so3143245e9.2
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 05:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778675715; x=1779280515; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B/yiXTDHFLW+/gAvDFdorcnDwM+eS+wmsY2xuPhgZn4=;
        b=mKliJFcuYN8zvASZ8xPCjSylm34X611dgJTmukvULhdtWos9t3XJU+cQl0QMQNmMe9
         VsLttfJO5s/iHKmUXpi4CRhHMvyhWvcHVuAb+wa/LrE7sWyGSJLAC+cem6V2ozTrXfgA
         PHT1N4oYTAPo3hivCTsif16IkZlAIlqMnaXyfch2Wqx3VMayRRzCodWrD9VAMvoGsmW8
         6mAwkEjxe9gRpN2/I5fOsm6hLXN0ss/Z3WA0OAUbrGKmcthTQbzXjbwdUZvN1ohtOKT0
         hEZ3bZK4rvhZRtA0qV/wpbLA45oFsUMOvjhV6Q08Sl7UM/GGysZIFTvC8OhptmO+5H1F
         6Z3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778675715; x=1779280515;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B/yiXTDHFLW+/gAvDFdorcnDwM+eS+wmsY2xuPhgZn4=;
        b=qxkoN/fMBRFqvUk+CTOOoyvESfEV+8ZKTe+EoQWwiU2aiPY0ssni+GIftbFD4dbpDI
         jm+rDphki8yzs53csKW+/g3RbTfGYhDCin2hKu3DLS3tTPfnsi1SIH4mGgTcsVwe8LnT
         HDs4NpiZ1lj3zlbuQTIoqzsnzxijrwsKUPiUQza9Q4T18LUcWuPoRMwwxVr7pyXZEGgt
         Fjq28iOQ1qICKkssCxp9/mA/psER4cpytjtSb0qp/cys+O1VyOmRQGd1clKC8nM5W/SJ
         F9uYNLbDtMh7Yw9PgXIJLevqanvtftAKaQlvYW7j/yVsb3fe78NnUIQOoXz7LRmBGR/X
         UxeA==
X-Forwarded-Encrypted: i=1; AFNElJ98IN805iJK1WwxhqU1/ZwmESGCUB40LBK6gNGFb6/uApI5zFhjzhqjQYBXXAJX3drppRwOcqyUsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYfrd+guj/gn/mjsOyslQqRiLm95ps+/wJHHWl74f9NhPdBxO8
	+rfdi2+1uRmmqVON+i1UxaNZ9AC65MWUnW7+wQs0OxrwDFvxaopdf5AanJ0RN8rCvOu0ydT7+vu
	0Wbw/quxsum70dg==
X-Received: from wmbf24.prod.google.com ([2002:a05:600c:5958:b0:48a:79c3:d04c])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5303:b0:48e:526e:101a with SMTP id 5b1f17b1804b1-48fc9a1026amr54832845e9.12.1778675714891;
 Wed, 13 May 2026 05:35:14 -0700 (PDT)
Date: Wed, 13 May 2026 12:35:12 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAABwBGoC/x2M0QqDMAwAf0XybKCtOMp+ZQyJbewCroYWx0D8d
 4uPd3B3QOUiXOHZHVD4J1W23MD2HYQP5cQosTE44x5mtA6VEk+0rlvAPX9JlSNqYcUwEJvB2zj 6GVre5CL/e/16n+cFWecZZWoAAAA=
X-Change-Id: 20260512-page_alloc-unmapped-prep-c3ae0381d58b
X-Mailer: b4 0.14.2
Message-ID: <20260513-page_alloc-unmapped-prep-v1-0-dacdf5402be8@google.com>
Subject: [PATCH 0/4] mm: misc cleanups from __GFP_UNMAPPED series
From: Brendan Jackman <jackmanb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Kairui Song <kasong@tencent.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

In v2 of the __GFP_UNMAPPED series [0], we realised that some of the patches
could potentially be merged as independent cleanups.

These are all independent of one another, if you think some are useful
cleanups and others are pointless churn, it should be fine to just pick
whatever subset you prefer.

No functional change intended.

[0]: https://lore.kernel.org/all/20260320-page_alloc-unmapped-v2-0-28bf1bd54f41@google.com/

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
Brendan Jackman (4):
      mm: introduce for_each_free_list()
      mm/page_alloc: don't overload migratetype in find_suitable_fallback()
      mm: rejig pageblock mask definitions
      mm/page_alloc: remove ifdefs from pindex helpers

 include/linux/mmzone.h          |  9 +++--
 include/linux/pageblock-flags.h |  6 +--
 kernel/power/snapshot.c         |  8 ++--
 mm/compaction.c                 |  3 +-
 mm/internal.h                   | 14 +++++--
 mm/mm_init.c                    | 11 ++++--
 mm/page_alloc.c                 | 88 +++++++++++++++++++++--------------------
 7 files changed, 79 insertions(+), 60 deletions(-)
---
base-commit: 30424114b17dd65c098749cedcaef301c1dd2f86
change-id: 20260512-page_alloc-unmapped-prep-c3ae0381d58b

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>

