Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795119548;
	b=HHq9YtQJsn2IlyyRo4rLqZk/UxT+3Z5j660H6rgNiGnmcLItQdBmYfamkqKKJ8PqOuOp
	 SfZy30lQudcaU7T6D8XyNk2URr6lz+CUJxYXd8QqQNWlnViwMDruNjix54lmQwGWfJiQl
	 rs0ljckd0KBCRgBsj6/dSui8PMCHqOEXK0On07h8kQz1Ps0oOGctQb3fzvGFHdRlJKycV
	 YEsB/NRqr1+ZYwq3RKis2FUfa7fzYNFiOJig6iWnYt/HJJM1+jBnw9EOiWzjNhQ+HZ6UC
	 NINXi7Ljm/1r+GtNgz07vvL3Yidlk+Mzc4pP/hU3s8pRY8xzWzVZLxpivSehAcH/Afg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119548;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=U0MmSaqb/zJUK2FlYCC7vJQ8qg6SgdumupYKh9psImU=;
	b=Ae/BoL94diUjprtmo4s7XSKMNO0A5WfowFk6/G5e1vBYNG8ZJwBW+BMAXcGti87S0Foj
	 EV6g/5eyR3qllyTDzcjt9PIB1LciqHXGySep2jvdhI0U7fB15vtXEXLP5rtG106KPs3to
	 DqRAOrMpgMU+Ss4mufdUrJAgZWev4AQFXm+MuxZ8iggL+PDoTBkpSfYd9d0Y1hOyqqkYW
	 c1WVz2AJJOE8AXtXWrD6tO37h0q3bSZwSL1cmAQOLaMuaiwlgQ26AniWff6/1hHkO1O4i
	 9jjs9mhg3dretNShJBXRznfOq2XZe8j9XHu+jC8nR2DNaMyliAd40FPxXz358ulyq4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WlwJwqdE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330E6606A32A;
	Thu, 19 Nov 2026 20:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WlwJwqdE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 974DF1F000C0;
	Thu, 19 Nov 2026 20:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795119547;
	bh=U0MmSaqb/zJUK2FlYCC7vJQ8qg6SgdumupYKh9psImU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WlwJwqdEobbk9OSg7OUgv72po5Pa5w8+gdYiX6P+KAL14adeAInQVqPAsBCjHmoRC
	 WP+nBMQnkb9B9oaeb4qStzpzWV+ijC96TN6BxpB8je69p7qYyFyleWo9Q9Jp5F4Us/
	 gwOvRC5DchGc0agZ+Wd/cZMMERDS86F4ROmFgZRWzATjNEsqrIF1STcOhYTxoeG1Zc
	 V8Ii/0nQkzfg2PaPymhKw4vQDAhV6P2jWnZXp0SDh3x3JFGx503niHwCtWbO0qly9g
	 18/UIN5u4RRT9GEzX+SbwQ6RQMWF084lNWQET7zW5Y8pMa/wILmmuSEwxn7xoguWXr
	 s+0YD2GdrtG4Q==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Brian Norris <briannorris@chromium.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
 Linux Driver Core Development <driver-core@lists.linux.dev>
Subject:
 [PATCH v1 4/4] PM: runtime: Drop direct last_busy updates from rpm_resume()
Date: Thu, 19 Nov 2026 21:18:32 +0100
Message-ID: <2062233.PYKUYFuaPT@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <1978814.tdWV9SEqCh@rafael.j.wysocki>
References: <1978814.tdWV9SEqCh@rafael.j.wysocki>
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

Now that rpm_resume() calls rpm_idle() even if the device was active
to start with, both direct last_busy updates in rpm_resume() are on
paths that also call rpm_idle(), which updates last_busy itself.
Accordingly, drop the direct last_busy updates from rpm_resume().

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/runtime.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 1a3b32e299d8..19d44b258cd9 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -834,12 +834,6 @@ static int rpm_resume(struct device *dev, int rpmflags)
 		pm_runtime_deactivate_timer(dev);
 
 	if (dev->power.runtime_status == RPM_ACTIVE) {
-		/*
-		 * The attempt to resume the device means that it is needed for
-		 * something, so update its last_busy timestamp as in the case
-		 * in which it actually resumes below.
-		 */
-		pm_runtime_mark_last_busy(dev);
 		retval = 1;
 		goto success;
 	}
@@ -966,7 +960,6 @@ static int rpm_resume(struct device *dev, int rpmflags)
 	} else {
 no_callback:
 		__update_runtime_status(dev, RPM_ACTIVE);
-		pm_runtime_mark_last_busy(dev);
 		if (parent)
 			atomic_inc(&parent->power.child_count);
 	}
-- 
2.51.0




