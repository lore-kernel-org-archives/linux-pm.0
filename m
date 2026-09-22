Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABAC3630AE;
	Tue, 22 Sep 2026 01:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040335; cv=none; b=UI0ab1OK5nGUTy4vJOpXCWmCfchqLHjDorjyL1CwT1ApVCYOuK3UOo8XqyqqHAoEafeirJz2k3f13oyiqp8nNW8lRUzrhsG1IrCBpkWBCsOzEODW0Ed3fGTOJ4iH4mGWFf/E5DXiDeUHNGpOKkP+Dnam6ftPxJDPqm4rIjs0jiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040335; c=relaxed/simple;
	bh=61axLVgIzjCNXUBgnWF3ptdLu3hjeFOP4UIgqmTMl5E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jyNYivmjDMPqGuRTyNXZ1LtBx/i+B1NjDMKmFZcqE7oyMkmY+1dMz1BD6ewMXKjwFDsjmCTLehYNB5hwvz0i/AlgkmNvKKwZbeudLqiuUWzFnn2r0CwBYjg6Wy3Gsn0l7HNIo4S4QNaj30iefyq9Bpc8KF2o5SXt+JkUFhi+5H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rTmKPEoB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rTmKPEoB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E3A4C2BCB3;
	Tue, 22 Sep 2026 01:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790040335;
	bh=61axLVgIzjCNXUBgnWF3ptdLu3hjeFOP4UIgqmTMl5E=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=rTmKPEoB3qhztb65ZALoirbpH9vy5pG2wdeXsgJ8rTMQ7S4gf0LLx6VlvpHjoMAqJ
	 EwCYSVnJbRCqNM2natooMPTdM9yhS6vAgk7eR1tgsLVDQI3BIE4FsntUOoYkCwKa95
	 g/TNYCIcdBZ/nkng9HQGEF91b3CGCiacWf21KVtY8jK52L/BIiMG18TBSpGf9dWBaH
	 xNjUq5Yaus3d4uc6kSrfVXp/RdH9ZZMFcCqjDGJw2TiYuNIE012pSsdUm7H2w9MsEa
	 rdU26k6mD4EfIAfmKLORK2N7cIsimwhGRt7uRg7fgpqwBWb5y77MjW+uxlfIo9NCd2
	 xbKbKeO94xGuw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAD3C982FE;
	Tue, 22 Sep 2026 01:25:35 +0000 (UTC)
From: Jaidev Shastri via B4 Relay <devnull+jaidevshastri.vt.edu@kernel.org>
Date: Mon, 21 Sep 2026 21:25:34 -0400
Subject: [PATCH] PM: wakeup: publish events_check_enabled with release
 semantics
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-mb-pm-wakeup-v1-1-1c91ca80c87a@vt.edu>
X-B4-Tracking: v=1; b=H4sIAA3ZsWoC/yXMwQ6CMBAE0F8he3YNLRWDv2I8dOsi1VCbriAJ4
 d9t8fgmM7OCcPIscKlWSDx78e+QoQ4VuMGGB6O/Z4OudVt3WuFIGEf82hdPEVtyplenThtlIE9
 i4t4v+9319rdM9GT3KR+lQVYYKdnghhLtnM/HBpMzsG0/KAXpXZAAAAA=
X-Change-ID: 20260921-mb-pm-wakeup-6bc4f1592414
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: linux-pm@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Jaidev Shastri <jaidevshastri@vt.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790040334; l=1865;
 i=jaidevshastri@vt.edu; s=20260921; h=from:subject:message-id;
 bh=dLWCuVoji96i81HPlOoevn58jnK61tArK6cZTPiiZP0=;
 b=CphCynVJOFS/MfVwFrnw7tX3op6AbeUv2p51ciLYI89MUhEPSQjK0dsdJNVmRCqUZz4hDxEYK
 ZtOjeoGLl3UA16SI8f/FkrTXiL8p8mP8R9xck2FiqGIGXGLNx9pgIm3
X-Developer-Key: i=jaidevshastri@vt.edu; a=ed25519;
 pk=J7+xYJRlTPds+pv5hbqFFRqGCpDeJDzmZT1ggRwj7/0=
X-Endpoint-Received: by B4 Relay for jaidevshastri@vt.edu/20260921 with
 auth_id=1044
X-Original-From: Jaidev Shastri <jaidevshastri@vt.edu>
Reply-To: jaidevshastri@vt.edu

From: Jaidev Shastri <jaidevshastri@vt.edu>

pm_save_wakeup_count() stores saved_count and then events_check_enabled
under events_lock. wakeup_source_report_event() reads
events_check_enabled without the lock and counts the event.

Store the flag with smp_store_release() and read it with
smp_load_acquire(), so that the stores a reader may rely on after
observing the flag are stated by the code.

Found with MBCheck, a static herd7-based memory consistency checker.

Signed-off-by: Jaidev Shastri <jaidevshastri@vt.edu>
---
 drivers/base/power/wakeup.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 80b497de2..afc9fafaf 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -578,8 +578,11 @@ static void wakeup_source_activate(struct wakeup_source *ws)
 static void wakeup_source_report_event(struct wakeup_source *ws, bool hard)
 {
 	ws->event_count++;
-	/* This is racy, but the counter is approximate anyway. */
-	if (events_check_enabled)
+	/*
+	 * This is racy, but the counter is approximate anyway. The acquire
+	 * pairs with the release in pm_save_wakeup_count().
+	 */
+	if (smp_load_acquire(&events_check_enabled))
 		ws->wakeup_count++;
 
 	if (!ws->active)
@@ -1003,7 +1006,8 @@ bool pm_save_wakeup_count(unsigned int count)
 	split_counters(&cnt, &inpr);
 	if (cnt == count && inpr == 0) {
 		saved_count = count;
-		events_check_enabled = true;
+		/* Pairs with the smp_load_acquire() in wakeup_source_report_event(). */
+		smp_store_release(&events_check_enabled, true);
 	}
 	raw_spin_unlock_irqrestore(&events_lock, flags);
 	return events_check_enabled;

---
base-commit: 93f51579e7df248780214094418f205253383cc5
change-id: 20260921-mb-pm-wakeup-6bc4f1592414

Best regards,
--  
Jaidev Shastri <jaidevshastri@vt.edu>


