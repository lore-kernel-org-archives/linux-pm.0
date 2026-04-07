Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32583B6BF5;
	Tue,  7 Apr 2026 14:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775571050; cv=none; b=NgOzT5cQ57R6uyjOiVTYHu9swJLEg6hpKVxKtJnfVitbuATcqQfUo8RlinkU/SNGxBdLEi5uIHh1JTRajpBbFZyXUD7xBQvB1/arFZ2ZaC8BtYAN+ej00GlEF09mu7xh21OJotmJsbW5I1HLee1l/ZwrXSnnrmYK3MLQe84RuJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775571050; c=relaxed/simple;
	bh=3sXtcJuoD1r6t91CrCthx39JgZlogsjW4X0t5XHmEfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vn98UAq70wsNHacghaS1bvSOlQWylu85H4wZLCfD4ILjHebz81Yt3dG4glzGSHYNf7B/gyGUHrZlsTwCzs9cHXP2V33YaRvIBkQFG7s/H5Xw7/qBaAjPxfGE+rQjErJJoQ+/ld/Hm0udGqj0cytfyPY5w2EHlt0uw/fsITuuTMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTIiw/0v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTIiw/0v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B22C116C6;
	Tue,  7 Apr 2026 14:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775571049;
	bh=3sXtcJuoD1r6t91CrCthx39JgZlogsjW4X0t5XHmEfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fTIiw/0v169ICsf/AUbuvxdxD5T/2xqiQ29krWP/B9R+p69iLGifi0BVkqda2UV1Y
	 tTLUurg6EpkD04hTzPWRZq52fvYpjZg2+aCijdbNiO0UIhoppqIqwhXXiVweOIiRz9
	 EJZQ48qmAjiychE4icIPfnkTn6v6RqQLWJD2p5yAm+noA0tDCijFEJJGDZV0b8IpcA
	 rvg0z9h1hQxNHpMeA2Cb8JR5XTYT3Y86O7ZdrDSOV4YlUYsVPkv5DuzuLG2qd30qOR
	 txzKCXjfor86zXHHICF8GeLSIoNheb7ZLoD08urZkBSA9f+o6YVbSodZlPPduk1RbS
	 +3xa1jXUjOSng==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v4 4/6] thermal: core: Change thermal_wq to be unbound and not
 freezable
Date: Tue, 07 Apr 2026 16:06:35 +0200
Message-ID: <3413335.44csPzL39Z@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12871778.O9o76ZdvQC@rafael.j.wysocki>
References: <12871778.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The thermal workqueue doesn't need to be freezable or per-CPU, so drop
WQ_FREEZABLE and WQ_PERCPU from the flags when allocating it.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v4: No changes

---
 drivers/thermal/thermal_core.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1918,8 +1918,7 @@ static int __init thermal_init(void)
 	if (result)
 		goto error;
 
-	thermal_wq = alloc_workqueue("thermal_events",
-				      WQ_FREEZABLE | WQ_POWER_EFFICIENT | WQ_PERCPU, 0);
+	thermal_wq = alloc_workqueue("thermal_events", WQ_POWER_EFFICIENT, 0);
 	if (!thermal_wq) {
 		result = -ENOMEM;
 		goto unregister_netlink;



