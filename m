Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE12F3043DB;
	Wed, 15 Jul 2026 13:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784123491; cv=pass; b=I+8qSeQJIT/+7I79+upYRktsIBuRqZyoP3X/PzHWr20daxBf0S/WJdBbxnW2Lgq0SN5214gTmtMIu7UoPCZPmZKaSBCa1+WWDjSCvhXKGdDy/Mvb/1yP8AByCV03cmo8DzRNETUA12BzkF1qPK5/W3boS6TZ6ze4Vweqj/fayi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784123491; c=relaxed/simple;
	bh=bCPLwA4kOudUqrPU5eA6lOnGtbkS3jRuiRxKZinBVW4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EtQ3BCWdr/lqsqhLQsRShdZMCOyJ5q/DNdBmtI3JVdLa31HCh0wMlmYxGej5IQLHE5F65LkQwtg28DvBStuARNAVBLJFMkTxcvN7z3ezfFNCvKRnf7MpBmgBVQ35pvzmMUfJfGn2peECplVgEnK+mzowSN7QyERqhkfpjezjYD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b=JGuERbjF; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b="JGuERbjF"
ARC-Seal: i=1; a=rsa-sha256; t=1784123480; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FUiYYmx3YCdbtnCuyly8Ci9CAzy5rzly2wV02oBSdDI5EQQr2eIB+pxnoYGqvwZRLFv9luaJKNWEcbeV3JtKsbVLrm4nmw8QfgbS2DLKqbzEYJrrU1VydIds8gJxPKDbr/sSerolvvWSo8IyJ6ecUtCNmOebaMzBm6gPmxtnRnA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784123480; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=LKNVMi0nMdMqvJz2LnP2SXcSswp0sRXMc6I/ZTbJ7Tg=; 
	b=KORoZ023i46rXa/paaM8g2iikgI4Ci1oc0J9UCYCGp7FNQ3i+KGdJG0qQSHtzNi4gVUDZx7dtAD9+dOnT4Ppu4ehvi8s/4XapbbP2vE6oy89b0mTtUti3NngIW0/2Kw5tQn7aHiIrHJHDIj+PDRIYLdmYnzoZF9y3ZXNnYT5LRU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nfraprado@collabora.com;
	dmarc=pass header.from=<nfraprado@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784123480;
	s=zohomail; d=collabora.com; i=nfraprado@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=LKNVMi0nMdMqvJz2LnP2SXcSswp0sRXMc6I/ZTbJ7Tg=;
	b=JGuERbjF0tfnezyJp6ImudKzhocdeyEF4yv6HhRoJS64Z9JIe6poXNkC/SVjN7t7
	fpfepbSNBS0wSJkypMZk1v+oiF7vtZ/EHctFh5ysaS6ZXGTZ0nlbTdJtOYOAwO+8X3k
	hPPpQ8KtXcIHT8J/CGh0ly4ENPh0GY1u5MHpmFsc=
Received: by mx.zohomail.com with SMTPS id 1784123477985993.5621633664949;
	Wed, 15 Jul 2026 06:51:17 -0700 (PDT)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Wed, 15 Jul 2026 10:50:57 -0300
Subject: [PATCH v2] PM: hibernate: Print speed statistics of
 copy_data_pages()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260715-copy-data-pages-show-speed-v2-1-6e30f15abcc1@collabora.com>
X-B4-Tracking: v=1; b=H4sIAECQV2oC/x3MwQqDMAwA0F+RnA10cbPgrwwP0UbNxZZG3ET8d
 4vHd3knmGQVg646IcuupnEtoLqCceF1FtRQDOSodf71wTGmAwNvjIlnMbQl/tCSSEA30DR4/yZ
 uGEqQskz6f/Jvf103sVFknWwAAAA=
X-Change-ID: 20260715-copy-data-pages-show-speed-0b2fb7742a3a
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>
Cc: kernel@collabora.com, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.3
X-ZohoMailClient: External

copy_data_pages() can take a long (multi-second) time to finish, and
currently the only indication of that is the timestamp difference
between print messages right before and right after. The timestamp is
also immediately reset afterwards to the time before image creation,
making it even harder to spot this delay. Furthermore this function runs
in a critical section with a single CPU online and syscore suspended, so
it should be kept as quick as possible to keep the system responsive.

Add a call to swsusp_show_speed() to report the amount of data copied,
time taken, and copy speed of copy_data_pages() to make it easier to
spot delays and verify performance improvements. The current time is
obtained through local_clock() instead of ktime_get() since timekeeping
is suspended in this region.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
Changes in v2:
- Patch split from series
- Use local_clock() instead of sched_clock()
- Account for total pages copied (nr_pages + nr_highmem) instead of
  final number of pages in copy (nr_copy_pages)

v1: https://lore.kernel.org/all/20260518-hibernation-decrease-time-in-copy-data-pages-v1-1-3998bdf90ee5@collabora.com/
---
 kernel/power/snapshot.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index d933b5b2c05d..42c730fadaed 100644
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
 
 	pm_deferred_pr_dbg("Creating image\n");
 
@@ -2130,7 +2132,14 @@ asmlinkage __visible int swsusp_save(void)
 	 * Kill them.
 	 */
 	drain_local_pages(NULL);
+	start = ns_to_ktime(local_clock());
 	nr_copy_pages = copy_data_pages(&copy_bm, &orig_bm, &zero_bm);
+	stop = ns_to_ktime(local_clock());
+	/*
+	 * Zero pages are overwritten but still copied, so account for them
+	 * in speed calculation.
+	 */
+	swsusp_show_speed(start, stop, nr_pages + nr_highmem, "Copied");
 
 	/*
 	 * End of critical section. From now on, we can write to memory,

---
base-commit: cc2b5f627e8ccbae1188ef2d8be3e451d7f933a5
change-id: 20260715-copy-data-pages-show-speed-0b2fb7742a3a

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>

