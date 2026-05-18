Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233602EA48F;
	Mon, 18 May 2026 21:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779140082; cv=pass; b=PjWj3i1Ze/3ngmi5EGo4RuLSrOn8ws0bbs9IGmLXmK54HDkbny7FL8FZG4mYcQDuWCJhY8a4rk+WUdTohczevPaAyYiM3eyhCR1Ni+zDe3ZX3/3peGMHm3lVHnblWrQKR0sbOou6DAWwKGz6zlsfV791iRYJVLTJswHOwKYjUWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779140082; c=relaxed/simple;
	bh=OzZmviRTNQsUTlVf4J2EVv4rMEO4sjNRSqxMWqyYffg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V/191DN2k3f3BTzpk4FdhY6wKax8jPUI7RqkN+Iz9uymanQg8WXnBGQgF4nrZe/YNL5TQXQV6rlbUPIrrdZP3T00Dny1/7NjVfUIAlqwqr4RT44Cs2kDz+/kaYmBaL8GPzmmvRxoAgtdO5iU4Cf5Leg7W6u02cFwuf7teUS2tok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b=OfKVoRrl; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b="OfKVoRrl"
ARC-Seal: i=1; a=rsa-sha256; t=1779140068; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=isIehNg4drm1j9t7GTTek4jARri1dtTUw6ySSRLSKMRrDZtUKmkooQCVP5A8upNBzBMCw6Ph8HKpo3Yy/0H7O6yCfeIddmj7Toxrde+Rgf5A3my+NtW3uvlDIH0Rzng5ikJrmdRyCqz78twiOelecO4H6CnakpsEOyybkaH1QdU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779140068; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=HBzuTS1xr9hjw5geSlWhqnXY3Z/Gi0+3Knt1SrZIKDQ=; 
	b=jwGQJecNEk7d0juzLFmL0MKJ9Hi7i2meivJcenY8IHafWYJ1jAcq+dTUowGNrYfBrBzUnPEiFJsnRpm5HCvZllzPS+wj5p2yy6tCCKHFgwzmZkq6LUOffm/pgB2RhTYYBK37ajRZt6gMofnvopX+hSsbEEpUO5JXe/R174pmMHI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nfraprado@collabora.com;
	dmarc=pass header.from=<nfraprado@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779140068;
	s=zohomail; d=collabora.com; i=nfraprado@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=HBzuTS1xr9hjw5geSlWhqnXY3Z/Gi0+3Knt1SrZIKDQ=;
	b=OfKVoRrl7wGWWrAY21+/J6Vhme0zp1eYcJkRBwDwP0P8K7sn4LWC2f+6B9US1Vag
	VnIjtJmm5fXGea2CHZoaPpebf5/SlVlXZu7ZXe/LrfROf3XVIlkVfigS4hSFmHhKiDt
	dpRRLMdMldgAybREXaObeM3LOCt3HtHUVTDAkpcM=
Received: by mx.zohomail.com with SMTPS id 1779140065683909.163863266387;
	Mon, 18 May 2026 14:34:25 -0700 (PDT)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Mon, 18 May 2026 17:34:22 -0400
Subject: [PATCH 1/3] PM: hibernate: Print speed statistics of
 copy_data_pages()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260518-hibernation-decrease-time-in-copy-data-pages-v1-1-3998bdf90ee5@collabora.com>
References: <20260518-hibernation-decrease-time-in-copy-data-pages-v1-0-3998bdf90ee5@collabora.com>
In-Reply-To: <20260518-hibernation-decrease-time-in-copy-data-pages-v1-0-3998bdf90ee5@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Pavel Machek <pavel@kernel.org>
Cc: Brian Geffon <bgeffon@google.com>, kernel@collabora.com, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.3
X-ZohoMailClient: External

copy_data_pages() can take a long (multi-second) time to finish, and
currently the only indication of that is the timestamp difference
between print messages right before and right after. The timestamp is
also immediately reset afterwards to the time before image creation,
making it even harder to spot this delay. And this function runs in a
critical section with a single CPU online and syscore suspended, so it
should be kept as quick as possible to keep the system responsive.

Call into swsusp_show_speed() to report the amount of data, time taken,
and copy speed of copy_data_pages() to make it easier to spot delays and
verify performance improvements. The current time is obtained through
sched_clock() instead of ktime_get() since timekeeping is suspended in
this region.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 kernel/power/snapshot.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index e249e5786fbc..4f452baf31dc 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -13,6 +13,7 @@
 #include <linux/version.h>
 #include <linux/module.h>
 #include <linux/mm.h>
+#include <linux/sched/clock.h>
 #include <linux/suspend.h>
 #include <linux/delay.h>
 #include <linux/bitops.h>
@@ -2109,6 +2110,7 @@ static int swsusp_alloc(struct memory_bitmap *copy_bm,
 asmlinkage __visible int swsusp_save(void)
 {
 	unsigned int nr_pages, nr_highmem;
+	ktime_t start, stop;
 
 	pr_info("Creating image:\n");
 
@@ -2132,7 +2134,10 @@ asmlinkage __visible int swsusp_save(void)
 	 * Kill them.
 	 */
 	drain_local_pages(NULL);
+	start = ns_to_ktime(sched_clock());
 	nr_copy_pages = copy_data_pages(&copy_bm, &orig_bm, &zero_bm);
+	stop = ns_to_ktime(sched_clock());
+	swsusp_show_speed(start, stop, nr_copy_pages, "Copied");
 
 	/*
 	 * End of critical section. From now on, we can write to memory,

-- 
2.53.0

