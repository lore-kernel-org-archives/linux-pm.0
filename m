Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B804134252B;
	Thu, 13 Aug 2026 07:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786607037; cv=none; b=hdfZ+01iuQ0eHo9vMohwQrJZVhor6RzV0MOYLBk7ci8y0kmaKpDxHLkXA38JrfFT/gDVtDg8IHK2z6kdFpmifE97Xvdq7RRwQVhXkdCJhjsqaE8izC8SwgRgOYjyi8ZFNNtyGoAtaY8GCcPgq1eQtWAy5UhMiNYlUfsGLlCcqco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786607037; c=relaxed/simple;
	bh=p+WvSSEtMgXXqExqX3nzHsJaMTepBYM+zxZTdBB0GEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f4rktZg0/eA/+Tyf9aSXswuguxWrM5dskYAVeZV8dEDjf6i1o90xKB0sG0l4XYM1dCAXYmf73AtLhOKlwwmAqO9DJFAoQknU5igIXsEuWHbRCH5zgQAgj4yVaRmsmoVsS4qF9Uiud/t+Je999meeSxvBEw08Xqk7KeFGBhHL13Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=gbnzJ0wB; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="gbnzJ0wB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1786607028;
	bh=UN+yhj6wcfMgwSLGkZGVz4D95rrRLTHUHQZ/MUP2myo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gbnzJ0wBla52dv8F7NCWIV5Gv/qXReDWPiwMFOcjC+eY29/MKw8D24pO7xRrBI3FJ
	 o84KLpQGYs4sfcR8/GvC3zaTCw3WCJNrNLz+Kp7GnU1Xck8UmFVYltr+9dGbtw+ExZ
	 ABDSfdqJB9YgbrxT690GDVKAirXiCdWyZTqwrktQ=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with UTF8SMTP id 4hLHRS0LLSz6vPb;
	Thu, 13 Aug 2026 07:43:48 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4hLHRR4nTrz4y6W;
	Thu, 13 Aug 2026 07:43:47 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Thierry Reding <treding@nvidia.com>,
	Daniel Leznan <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Rosen Penev <rosenp@gmail.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] PM: cpu: Restore synchronize_rcu() to cpu_pm_unregister_notifier()
Date: Thu, 13 Aug 2026 07:43:43 +0000
Message-ID: <20260813074343.26460-3-include@grrlz.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260813074343.26460-1-include@grrlz.net>
References: <20260813074343.26460-1-include@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpu_pm_notify() walks the notifier chain lockless under only
rcu_read_lock(). That only works if a removed notifier block is not
freed until every concurrent walker is done with it.

The chain used to be an atomic_notifier, whose unregister ends in
synchronize_rcu(). Commit b2f6662ac08d ("PM: cpu: Make notifier chain
use a raw_spinlock_t") switched it over to a raw_notifier, and in
doing so replaced that with raw_notifier_chain_unregister(), which
does not synchronize. The grace period quietly went away, so a driver
that frees the memory holding its notifier block right after
cpu_pm_unregister_notifier() returns can race with a concurrent
walker:

  cpu1 (idle exit)                  cpu2 (driver remove)
  ----------------                  --------------------
  cpu_pm_notify(CPU_PM_EXIT)
    rcu_read_lock()
    nb = rcu_dereference_raw(*nl)
                                    cpu_pm_unregister_notifier(&od->nb)
                                      unlink, no grace period
                                      remove() frees od (devm)
    nb->notifier_call(nb, ...)
      /* use after free */

The rcu_read_lock() on cpu1 does not stop cpu2 from freeing the
block, and nothing else does. The read side is the idle exit path,
so this can hit on any system where a driver with a cpu_pm notifier
gets unbound.

Add the grace period back. It is only needed when a notifier was
actually removed, so wait on success and return -ENOENT without
waiting otherwise. The kerneldoc gets back the "may sleep" note that
the same commit dropped.

Fixes: b2f6662ac08d ("PM: cpu: Make notifier chain use a raw_spinlock_t")
Cc: stable@vger.kernel.org
Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 kernel/cpu_pm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
index 7481fbb947d3..a2a598ad6e6d 100644
--- a/kernel/cpu_pm.c
+++ b/kernel/cpu_pm.c
@@ -10,6 +10,7 @@
 #include <linux/cpu_pm.h>
 #include <linux/module.h>
 #include <linux/notifier.h>
+#include <linux/rcupdate.h>
 #include <linux/spinlock.h>
 #include <linux/syscore_ops.h>
 
@@ -76,7 +77,8 @@ EXPORT_SYMBOL_GPL(cpu_pm_register_notifier);
  *
  * Remove a driver from the CPU PM notifier list.
  *
- * This function has the same return conditions as raw_notifier_chain_unregister.
+ * This function may sleep, and has the same return conditions as
+ * raw_notifier_chain_unregister.
  */
 int cpu_pm_unregister_notifier(struct notifier_block *nb)
 {
@@ -86,6 +88,11 @@ int cpu_pm_unregister_notifier(struct notifier_block *nb)
 	raw_spin_lock_irqsave(&cpu_pm_notifier.lock, flags);
 	ret = raw_notifier_chain_unregister(&cpu_pm_notifier.chain, nb);
 	raw_spin_unlock_irqrestore(&cpu_pm_notifier.lock, flags);
+
+	/* Wait for the rcu_read_lock() walkers in cpu_pm_notify(). */
+	if (!ret)
+		synchronize_rcu();
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(cpu_pm_unregister_notifier);
-- 
2.47.3

