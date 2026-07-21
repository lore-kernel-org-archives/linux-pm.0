Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A556B3793C3;
	Tue, 21 Jul 2026 15:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784646853; cv=none; b=fM9KmFaEHPfykyBmewdYmjBO76g+oRlm0/QIzbniIwgVAJJefEiO40/tk1JUbPygP/AnalM431lYlzy1Uf8fJQRl5O9FWiOmPhm1kRx3icwggMg4Afh2d9PL7MPFSnd3umhsIWtk8VPXHyiQEVPhMEh9HJD4f5q5Ye3x6Ved2Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784646853; c=relaxed/simple;
	bh=1tlW2FzhayOoRkA/k5MGV941viuVyl7EM+PuDyXQKDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VU1mEtSOpVb/yj1NTBf/Eq0kVfYudsOC3Ui+1iOXJl09TNf3/6ep4bRrkFwspV3GPoCXHF4kfVE73I68xsFryeGOUdwZ6a5F2XxqRVHPL0DOJXctMaVQbCr6kFwHuevig/Iac7Om4AX9NUBqpPJsTF1u3wRImJ6RQl5TAIOcn5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=pwq7Ef46; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="pwq7Ef46"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1784646851;
	bh=1TnWlVinJDeOhala/vbIeVYCGUm59YDKqzBVCOS9jWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pwq7Ef46XWcW85AVc4Id1OZ84DWSL6smZgO4II9+fpMcNuh5e9mfet3Rxc1FYyyo9
	 nQ5LiP3/dlxpRm8vw7jFcNgO+Hm6PpqRbEg+p5IlSMGdCiSKGrMturwHkp4a/lp2RM
	 3HYstfKUxL1oomd0i0sVrmXpzBfnGcR5NMsRvMcc=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4h4LWl18Tbz6vP7;
	Tue, 21 Jul 2026 15:14:11 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4h4LWk2rKwz4vyJ;
	Tue, 21 Jul 2026 15:14:10 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: akpm@linux-foundation.org
Cc: baoquan.he@linux.dev,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	rafael@kernel.org,
	lenb@kernel.org,
	pavel@kernel.org,
	kees@kernel.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-pm@vger.kernel.org,
	Bradley Morgan <include@grrlz.net>
Subject: [PATCH v2 3/3] PM: hibernate: log the task that initiated the power down
Date: Tue, 21 Jul 2026 16:13:58 +0100
Message-ID: <20260721151358.4185467-4-include@grrlz.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260721151358.4185467-1-include@grrlz.net>
References: <20260721151358.4185467-1-include@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Give the hibernation power down the same treatment as the reboot
syscall commands. hibernate() runs in the context of the task that
asked for it, whether through the reboot syscall or a write to
/sys/power/disk, so when power_down() runs current is still the
initiating task.

Log it once the image has been written and the machine is committed
to going down:

  reboot: initiated by systemd-sleep[812]
  reboot: Power down

The line comes from kernel/reboot.c so it keeps the "reboot:" prefix
and sits right next to the final "Restarting system", "Power down"
or "System halted" line, same as a plain reboot.

The one exception is platform mode rolling back on a pending wakeup
event after the line has been printed. The existing "Wakeup event
detected during hibernation, rolling back." line follows immediately
in that case, so the log stays real about what happened.

Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 kernel/power/hibernate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index d2479c69d71a..bec91bf6a63c 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -687,6 +687,8 @@ static void power_down(void)
 	}
 #endif
 
+	reboot_log_initiator();
+
 	switch (hibernation_mode) {
 	case HIBERNATION_REBOOT:
 		kernel_restart(NULL);
-- 
2.50.1

