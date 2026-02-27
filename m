Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5683143E9CB;
	Fri, 27 Feb 2026 16:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772208082; cv=none; b=HcomKlY9rNT6vU6QSaSf+KC6eEuaBe/pSeTvs44cEKrDSHtS0rBTJLTySFVNfHg97dWQ8uUCjWWAmN09WEuAY9DSlWFoyWcK3UMX0Its2k3EQeNy8JcTBwEuX/drh52hM5P561FlyUkH/jGCgbtru+1kQEeWe99Tl116QgwJv1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772208082; c=relaxed/simple;
	bh=Wx1shL1sZOpNIZU7JmZc2/QgwjrW1YNXoCfAu1N4mBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jbxg6siJD80eGAuQ/pOlb9EWmMT8Bq3dpgzFl/u5QjHOVWHieZ6B/I3OEj65O9ZxKbyS/Y6naSYwUWWBO0gbX5GvOsIO7rrfbLDAOUQDG62mbiy2FQADo8hk86pf6Xs1OVg80zCR90b4CYzpdHQm9mVJEAqs/R81+8NS76RwW3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=Ve01KqIT; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="Ve01KqIT"
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 1095BB2E33;
	Fri, 27 Feb 2026 16:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1772208072;
	bh=vL2gmeWvIXcKqpbeZJOT58tvlHDLMuAurr2dMdDct3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ve01KqITpLGHQ8GqeWzWYoY8WBzxqqlDBEIXDvb0e3G9boUo2qZvqP5SSWkX2H7QX
	 lMzk6o2fI2gBVG/+okSBQJnWXDUAtMv7O2f+CzCcyKAP/MMh0KLogICFizFm/Jhgdw
	 /nG6VP4fttxuHbSTD8PXdMlY1s+6+drq74v4vkX4=
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Oscar Salvador <osalvador@suse.de>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	"linux-cxl@vger.kernel.orgkernel-team"@meta.com,
	Dmitry Ilvokhin <d@ilvokhin.com>
Subject: [PATCH v4 1/5] mm: introduce zone lock wrappers
Date: Fri, 27 Feb 2026 16:00:23 +0000
Message-ID: <849dee9c47df1e6fba97c9933af0d5a08b8e15d3.1772206930.git.d@ilvokhin.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772206930.git.d@ilvokhin.com>
References: <cover.1772206930.git.d@ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add thin wrappers around zone lock acquire/release operations. This
prepares the code for future tracepoint instrumentation without
modifying individual call sites.

Centralizing zone lock operations behind wrappers allows future
instrumentation or debugging hooks to be added without touching
all users.

No functional change intended. The wrappers are introduced in
preparation for subsequent patches and are not yet used.

Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 MAINTAINERS                 |  1 +
 include/linux/mmzone_lock.h | 38 +++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)
 create mode 100644 include/linux/mmzone_lock.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 55af015174a5..947298ecb111 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16672,6 +16672,7 @@ F:	include/linux/memory.h
 F:	include/linux/mm.h
 F:	include/linux/mm_*.h
 F:	include/linux/mmzone.h
+F:	include/linux/mmzone_lock.h
 F:	include/linux/mmdebug.h
 F:	include/linux/mmu_notifier.h
 F:	include/linux/pagewalk.h
diff --git a/include/linux/mmzone_lock.h b/include/linux/mmzone_lock.h
new file mode 100644
index 000000000000..a1cfba8408d6
--- /dev/null
+++ b/include/linux/mmzone_lock.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MMZONE_LOCK_H
+#define _LINUX_MMZONE_LOCK_H
+
+#include <linux/mmzone.h>
+#include <linux/spinlock.h>
+
+static inline void zone_lock_init(struct zone *zone)
+{
+	spin_lock_init(&zone->lock);
+}
+
+#define zone_lock_irqsave(zone, flags)				\
+do {								\
+	spin_lock_irqsave(&(zone)->lock, flags);		\
+} while (0)
+
+#define zone_trylock_irqsave(zone, flags)			\
+({								\
+	spin_trylock_irqsave(&(zone)->lock, flags);		\
+})
+
+static inline void zone_unlock_irqrestore(struct zone *zone, unsigned long flags)
+{
+	spin_unlock_irqrestore(&zone->lock, flags);
+}
+
+static inline void zone_lock_irq(struct zone *zone)
+{
+	spin_lock_irq(&zone->lock);
+}
+
+static inline void zone_unlock_irq(struct zone *zone)
+{
+	spin_unlock_irq(&zone->lock);
+}
+
+#endif /* _LINUX_MMZONE_LOCK_H */
-- 
2.47.3

