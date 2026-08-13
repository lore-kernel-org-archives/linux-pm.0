Received: from latitanza.investici.org (latitanza.investici.org [185.218.207.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D99328B77;
	Thu, 13 Aug 2026 07:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.218.207.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786607028; cv=none; b=FInBMMB3v6QgUcyJ78E2QjBAiyqDL/9i4E0EhQYQJufzLIMjGsO0Vuubevz9NBLaBQimIN0KjiqVFYHQ5QsGhLOhsdQh/WCCuvW6rG7vRjo0CC/n0tWhn4vgPr/FLZvWDho2X5lrKIRIFGB9ff8AY3NeMYiUyX7xmVvj0k99wKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786607028; c=relaxed/simple;
	bh=17hA/R8YqhqyJkXkLOuSEV56FpzYKNU6rDLLYmKQ7gc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=htPl52CgmfGwudMNHRY95QqjuvRyf63ZIHRfMlO1mwvAdVO9V273Y6/7tiEoolNQjnp/CJ8OXgztwtIyM3dXD3RhV/rCFFTKa/DXU/pKsnQRnA7UUdcvlNViosIpptqa6IixeMThejemrAEqCZsf0U1vvwk3CdAEd293JQlFCYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=HrkNkxQg; arc=none smtp.client-ip=185.218.207.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="HrkNkxQg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1786607022;
	bh=3Mt6jCjQJy8mo44c4uzTVZTEcvtOr1Vt4OtXGR3/gXI=;
	h=From:To:Cc:Subject:Date:From;
	b=HrkNkxQgxUeigC/HWS7I2zJIXoZqIK4gMQ5yKt8tOlyit1tjFlGu42+5dVQF0eyYX
	 YkV7Cf6c2DfhF6Nw+00xddVyHZxrpEkS3hFWnC8r9leiBeSFGpqiiA4Yu+zhJbKh/5
	 5yR8JXgXIm5GMF47BhlEvtK7tbt+rm1/EHlF2GHI=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with UTF8SMTP id 4hLHRL2XsCzGpG7;
	Thu, 13 Aug 2026 07:43:42 +0000 (UTC)
Received: by mx3.investici.org (Postfix) id 4hLHRK71x6zGpG6;
	Thu, 13 Aug 2026 07:43:41 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Thierry Reding <treding@nvidia.com>,
	Daniel Leznan <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Rosen Penev <rosenp@gmail.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] PM: cpu: Restore the RCU grace period to cpu_pm_unregister_notifier()
Date: Thu, 13 Aug 2026 07:43:41 +0000
Message-ID: <20260813074343.26460-1-include@grrlz.net>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit b2f6662ac08d ("PM: cpu: Make notifier chain use a
raw_spinlock_t") cpu_pm_unregister_notifier() no longer waits for an
RCU grace period, but cpu_pm_notify() still walks the chain with only
rcu_read_lock() held. A driver that frees its notifier block right
after unregistering can race with a concurrent walker.

Patch 1 moves the one caller that unregisters from atomic context out
from under its spinlock, patch 2 restores the grace period.

Bradley Morgan (2):
  clocksource/drivers/timer-ti-dm: Unregister CPU PM notifier outside of
    the timer lock
  PM: cpu: Restore synchronize_rcu() to cpu_pm_unregister_notifier()

 drivers/clocksource/timer-ti-dm.c | 9 ++++++---
 kernel/cpu_pm.c                   | 9 ++++++++-
 2 files changed, 14 insertions(+), 4 deletions(-)

-- 
2.47.3

