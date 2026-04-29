Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B5713FEE;
	Wed, 29 Apr 2026 15:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777476918; cv=none; b=IJ0QABkU2vw1Q4qaKTCtYrIiyV0M34GaiKUSQacEu76HZqksoRMrtxU22YzBtF6WyQkFv89UBHDk/nG6fMeftKCR0ZLRuZlfdjS1szPULWicmSXpJ7V2/efpibu74VrDt4dAkFlUwaLTRo8qZVQJuyCb5xj5P0pA5ZnE6uhLxto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777476918; c=relaxed/simple;
	bh=tNixtlRULwcI+phA9apV3NW6N1ll+hwWSS2Qu7zrJuw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RnoX+WZR5HXwVaDlEKIb8p81KAFMoLEqimh7biNoSTWekrIIoqNV5I3LguXNpdqMsDsKFBkn+775eAQhexZo6urdbms24aRYZj4p8MRiqkVt2Z6p9J+w5vrn9tly+6aOteDiZchmbBgmHd7WQyvjZs4nlXp3gz/Su9uP+ljAIlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=fabhKfK4; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="fabhKfK4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dZ90ymQ5zhboUV8KWjXalATLAoXVNCO/BuD/DtfrKZA=;
  b=fabhKfK4cGz7Sbk73QkD/vIQPjVb47HqZDHJjZf8FbNCwvG1zbjevrAu
   XW5kpEoYcBLya2/TpZbpgBTwzruoXTTLs3Do8UaFo4L/oXzftTGhcs28r
   ypfwWBiwtmd8Oa44KHSt7j1SYnuSZ4474fHYLEZFj7wUaNKJArA3zd2EV
   Y=;
X-CSE-ConnectionGUID: IHu/HwuxRu6COdoHSQxL8A==
X-CSE-MsgGUID: If3gCpLuRvykTfnydMowbQ==
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.23,206,1770591600"; 
   d="scan'208";a="145358392"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.102.196])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 17:34:04 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: kernel-janitors@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Christian Loehle <christian.loehle@arm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpuidle: menu: correct variance calculation
Date: Wed, 29 Apr 2026 17:33:57 +0200
Message-Id: <20260429153357.2350958-1-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 13982929fb08 ("cpuidle: menu: Use one loop for average and
variance computations") simplified the numerator of the variance
calculation to:

sum of squares of idle times - (average idle time)^2

This computes a value that is typically too big.  The formula should be

sum of squares of idle times - (sum of idle times * average idle time)

On a small number of tests I didn't find any significant performance
change.  Likewise, the original patch was tested by various people and
was presumably not observed to cause any problem.  My impression is
that this is because the actual variance is almost always quite high
(greater than the threshold of 400 used by get_typical_interval), so
having a value that is even higher than it should be doesn't matter.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
Fixes: 13982929fb08 ("cpuidle: menu: Use one loop for average and variance computations")

---

 drivers/cpuidle/governors/menu.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 64d6f7a1c776..8cbd70cafe89 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -117,14 +117,14 @@ static unsigned int get_typical_interval(struct menu_device *data)
 {
 	s64 value, min_thresh = -1, max_thresh = UINT_MAX;
 	unsigned int max, min, divisor;
-	u64 avg, variance, avg_sq;
+	u64 avg, variance, sum;
 	int i;
 
 again:
 	/* Compute the average and variance of past intervals. */
 	max = 0;
 	min = UINT_MAX;
-	avg = 0;
+	sum = 0;
 	variance = 0;
 	divisor = 0;
 	for (i = 0; i < INTERVALS; i++) {
@@ -138,7 +138,7 @@ static unsigned int get_typical_interval(struct menu_device *data)
 
 		divisor++;
 
-		avg += value;
+		sum += value;
 		variance += value * value;
 
 		if (value > max)
@@ -151,17 +151,17 @@ static unsigned int get_typical_interval(struct menu_device *data)
 	if (!max)
 		return UINT_MAX;
 
+	avg = sum;
 	if (divisor == INTERVALS) {
 		avg >>= INTERVAL_SHIFT;
+		variance = variance - (sum * avg);
 		variance >>= INTERVAL_SHIFT;
 	} else {
 		do_div(avg, divisor);
+		variance = variance - (sum * avg);
 		do_div(variance, divisor);
 	}
 
-	avg_sq = avg * avg;
-	variance -= avg_sq;
-
 	/*
 	 * The typical interval is obtained when standard deviation is
 	 * small (stddev <= 20 us, variance <= 400 us^2) or standard
@@ -175,7 +175,7 @@ static unsigned int get_typical_interval(struct menu_device *data)
 	 * Use this result only if there is no timer to wake us up sooner.
 	 */
 	if (likely(variance <= U64_MAX/36)) {
-		if ((avg_sq > variance * 36 && divisor * 4 >= INTERVALS * 3) ||
+		if ((avg * avg > variance * 36 && divisor * 4 >= INTERVALS * 3) ||
 		    variance <= 400)
 			return avg;
 	}

