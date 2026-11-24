Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534838;
	b=iafkri4K5uTzbqR6ACSpu/gLKHifEteHKRZyyOYeyhtX0AXffLYhQAldruBw9MuRHASd
	 oiSM6m0MkJIUlP3+xdWpstc0aaneZzJF8GH+gr8c9XfJ1o0K2oLNVUBaPFJNI1SIa9USH
	 OQtaws3A+1tDu8SXhQe7Lu1TSjxG/YzGXO6Q1LKZ0O+CeNJm/W6PFQw2GUqjW4HROBRQV
	 9GvGR8gtuk5h3SsNvsaCe6+oQSS7JgcWPNGAiKhE9gt8InEOvXJy9qmve0yWBkuNXtwI8
	 R+MlneQ7qPXZgghPS10HETZjA4nuWtr6LJC0RADNHsG3wHuyqvIHBKJenj8HI7WbkPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534838;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=dhqJCQhgaJBApfFBJugxExFWRtrsBOy1JZoteTuOMPI=;
	b=YWgGGAmq1jr42IVTWTeXuClDioo6HVJwV7JVOMHfZAVQAhmqdhkJMU0zC1jXz5J+fuQl
	 GXQaUmNFjjmiQ17k2wqMsBSMpqBvMuBH466wXYMvbexkx0EVVp7aQsLZzvgPWVgmbYjM2
	 LovLTMb7ZeCn1io/B0/Ct/0fUUPyy36AD3JSi8msrO+g5arYKEVa6QYNIVePcyH3kGJUt
	 DJnf7RwEjZjamDnjQ0zNuI7GNYKY2tZ9kytDZQmfxub+C1OR6EC6fePsfelDz6L/QhJ0R
	 5gr/u84ZSjJxKaAkr1I+ZbJpoAcNm0PP4KxOPGmwqa0QgEv+H6JJgYYhtJN4ajug01A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ejhU5ace;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C48606A31E;
	Tue, 24 Nov 2026 15:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ejhU5ace
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837601F000C6;
	Tue, 24 Nov 2026 15:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534837;
	bh=dhqJCQhgaJBApfFBJugxExFWRtrsBOy1JZoteTuOMPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ejhU5acetCl/gn5LbYvhpVhoCOojc3fGMopuMfe7Abl6mar3yp6RzVX84dhWO+695
	 bq+hbKPJ2Nu5rnNairZAXKKGdeUrWroovg3hpyy89umFOSrkxBzE8UT78sXnwdcbBU
	 CrCC0A9PeT3uG2/ckkVSc72RfBb25GxaKdL1nJFjlTUWsIsILGdMx5T/zoq9gUOOJY
	 S+/pdxzXoeuna49yFqi4bwL40wB90H+njL5gQcRoilGgT0rXfLFMid/e3YSS5nxM/5
	 bEchS/0fCQJ/Wi4GrEnt3oSKJnljFaICU50oIneTqZwu3GFnaSsPrklScI7yw7EIoy
	 45GEyJ7NLxmtA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Brian Norris <briannorris@chromium.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
 Linux Driver Core Development <driver-core@lists.linux.dev>
Subject:
 [PATCH v2 4/4] PM: runtime: Update stale pm_runtime_put_sync() kerneldoc
 comment
Date: Tue, 24 Nov 2026 16:39:01 +0100
Message-ID: <23323169.EfDdHjke4D@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <4779892.LvFx2qVVIh@rafael.j.wysocki>
References: <4779892.LvFx2qVVIh@rafael.j.wysocki>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

The pm_runtime_put_sync() kerneldoc comment still claims that it does not
update the last access time which is not correct any more.  Also the
suggestion to use pm_runtime_put_sync_autosuspend() or instead of
pm_runtime_put_sync() for devices with autosuspend enabled is outdated.

Make that kerneldoc comment more up to date.

Fixes: 26236a3e8803 ("PM: runtime: Update last_busy before calling rpm_suspend() in rpm_idle()")
Reported-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

New patch in v2.

---
 include/linux/pm_runtime.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 7972bfb90d6c..3f593a783e17 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -692,9 +692,9 @@ DEFINE_GUARD_COND(pm_runtime_active_auto, _try_enabled,
  * Decrement the runtime PM usage counter of @dev. If the counter drops to zero,
  * synchronously evaluate and trigger idle/suspend handling.
  *
- * Note that this does not update the last access time, but it does respect
- * existing autosuspend timers. If @dev uses autosuspend, consider using
- * pm_runtime_put_sync_autosuspend() or pm_runtime_put_sync_suspend() instead.
+ * This updates the last access time and respects existing autosuspend timers.
+ * If @dev uses autosuspend and respecting its autosuspend delay is not
+ * desirable, consider using pm_runtime_put_sync_suspend() instead.
  *
  * The runtime PM usage counter of @dev remains decremented in all cases, even
  * if it returns an error code.
-- 
2.51.0




