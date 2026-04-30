Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37973033F8
	for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 19:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777579018; cv=none; b=SeDtPf0M7NhzfzWtXw9Co6P6YgE/0S1B2qI0ubAi1zaNpq8qa/yWburkjOCxVqBBfadc0IsPvb3SIjOQIbeIKYs3ZzfROx9H55aHRD1JYmF+7pjMhdZoyZyT5yYRALlq2bLZ1RxIGpBr0/+4YD/Pq5UOBr5D+VNeTS1uzC3hLKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777579018; c=relaxed/simple;
	bh=EuaZpVYp/Skz5QTKHgDy/F1bCVr6eX5QViNZis4mmpo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ozob2wn6zEdVLipaM6psKQ5tzgRA1yMWBFCW1BEsn3vvTdDRV/Qo/9WWOgBBKRLIFCMPDLN/rGx1E02SLI4MoAchD95dqpQKX8Afd3TB0elYDSWR+fKZXoSBNaGsTU8u5oeVaz7knnnbivJd+2MRzpuLZAyRKoBU/o4IQmG3sb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sDIjcPTj; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sDIjcPTj"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so19138735e9.0
        for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 12:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777579015; x=1778183815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9suyq7OsGoU5hjx6DKCtQZWhNejxcqAH+lNu/8skT/U=;
        b=sDIjcPTjC18pnIyGizeBT+GBDBcWuOZMpCjsiz03JTbNT3WQoo+shcxFJ8UGtcu0ZS
         oWn2ITLwQQ3Hi+6hhlX52A92CBK/Qy0+ql8DWJVBDst3pwCoitVhnf+XClpQ1gs64nN2
         kKBE5bde5Za3JGtaNj6c/ahRbjXufho7fm54DXzvQf/G3oF/99Sk4sf0c6AFSB4DXUYL
         TA55pXGV7QABY5rgqFZo4F20rnMNOP3fsTpH0P4ny/n8UqMpo95KkJbG4fbT4hV275Zv
         wbp59nolhgeKGH9s7deGroq26oV+q6PYV8Z9Nh/ZYXyeSEjCNHXe6d1zEvFR8+kgzksX
         Dnvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777579015; x=1778183815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9suyq7OsGoU5hjx6DKCtQZWhNejxcqAH+lNu/8skT/U=;
        b=dcpF4lWBfZeMSxLrOIacqf/xQ2hKKn9xBvyAeTaWb5XZxSwYRd/Kqw57mkn8oc6Te/
         OZpyqkgeJEvHqOZtj/Cq12Gx7lWGOsxFHdTtgvyY0voDJvDpNQW5PZ9sxzbdQlj9tKn+
         ziRJpMIH412OhR4HH5bc7+F3Ph4OM/vijCilEbS9D5dovghEC+LxAHbmEY6/emgi9J7b
         r17FyvTVc36XVKubJUrrKLrcPa+eaI/bJv86vT32eRhavbFIxWywkSTurdYn85Sv25iU
         Wa0qZ5qdX90J8nnLoQhIMQ2+FsfU9G/EJqkok6vInw28aJRn8vyOHx9fKjrTlEqDKS0w
         Xkag==
X-Forwarded-Encrypted: i=1; AFNElJ/lTdjFfGd1J8Ni2pENXVsyBc3fyRmhx9/uf5YSc31JbOqHAKqMzR1QRlnMxfa3zt9nrcGRLZ/+EQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZCCprGFeU7R0SiW/F+5FvFQh8kgdE3JLLspfVM5lMvP5wKmrg
	ClSnM1NlJtUF9HhBSn56c6vasUsiQUJl1k7PfrCt2L+oiyQk1/guJwR7
X-Gm-Gg: AeBDiesxdKJsvseeROgKvYRsTo9rpKQslsA/PnBwwoSlVXX0TcNCIQjJ3gh9cKGAchp
	LzC8wWxbci0qKEJf/k10WTsTq/gKxClKMsclGXCwS7y5ob5xKe7wg8D3MlYPR63S1hbSuRSVmwi
	W3Wvvmliv7WsIQHKT07khe82kdqQ/5DeBp1xPYVVVcU7DhHEUsNW5Mubj7O/RKlj2mBRlsiJEg+
	uOcBF5MGwgPDREu2R0GQpx3FEohCFoP+3ehe2GCm8cuvYJ1rrWM8WxB5l3+tXkBC3THSB7snPNa
	TmMMnS2+Fi+HeuQtBGP7S1cYMyKgs5dbB/SsxEQ8BpcywhQHBI9odJyBbpCXWDAjAvldvUAlozA
	43QJhFoz8PG0g3zMme4i+r7QkMBqOM8w+DsU5DSxPTqM2wG43Lx0V6vSjA32yvVcfRrOy8hL7j6
	4n1O7U7k4cXbjB3kMEMDq7Q49L1r1CmqboFRXHJRBmOucDMBgDa2Wlt+Su/oa+Bg9rb12oF8Kkg
	rjdCdGqwmXCcIzV+MgUsw==
X-Received: by 2002:a05:600c:26d2:b0:48a:89d9:a419 with SMTP id 5b1f17b1804b1-48a89d9a46emr28797275e9.11.1777579015006;
        Thu, 30 Apr 2026 12:56:55 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb72184sm922615e9.32.2026.04.30.12.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 12:56:54 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: David Carlier <devnexen@gmail.com>
Subject: [PATCH] mm/swap, PM: hibernate: atomically replace hibernation pin
Date: Thu, 30 Apr 2026 20:56:51 +0100
Message-ID: <20260430195651.287659-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

snapshot_set_swap_area() unpins the previously selected swap device
and pins the new one in two separate swap_lock critical sections.
In the gap between them, swapoff() observes SWP_HIBERNATION cleared,
bypasses the guard, and tears down the device, reopening the race
the SWP_HIBERNATION pin was meant to close. The window is reachable
on any SNAPSHOT_SET_SWAP_AREA call after the snapshot device is
opened for hibernation, and on any retry after the resume path's
first selection.

Add repin_hibernation_swap_type(), which looks up the new device,
clears the old SWP_HIBERNATION flag and sets the new one under a
single swap_lock acquisition. The same-device case is short-
circuited so userspace can re-select the same swap area without
tripping WARN_ON_ONCE and -EBUSY. Switch snapshot_set_swap_area()
to the new helper.

A failed lookup now preserves the previous pin instead of dropping
it, so a bad SNAPSHOT_SET_SWAP_AREA leaves the prior selection
intact. The open and release paths keep using
pin_hibernation_swap_type() and unpin_hibernation_swap_type().

The race was identified during AI-assisted review of the
SWP_HIBERNATION pinning series.

Fixes: 8e6e0d845823 ("mm/swap, PM: hibernate: fix swapoff race in uswsusp by pinning swap device")
Assisted-by: Codex (gpt-5-codex)
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 include/linux/swap.h |  2 ++
 kernel/power/user.c  | 17 ++++--------
 mm/swapfile.c        | 61 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+), 12 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 1930f81e6be4..213ecb627a39 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -436,6 +436,8 @@ static inline long get_nr_swap_pages(void)
 extern void si_swapinfo(struct sysinfo *);
 extern int pin_hibernation_swap_type(dev_t device, sector_t offset);
 extern void unpin_hibernation_swap_type(int type);
+extern int repin_hibernation_swap_type(int old_type, dev_t device,
+                                       sector_t offset);
 extern int find_hibernation_swap_type(dev_t device, sector_t offset);
 int find_first_swap(dev_t *device);
 extern unsigned int count_swap_pages(int, int);
diff --git a/kernel/power/user.c b/kernel/power/user.c
index d0fcfba7ac23..6e4f40e49319 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -218,6 +218,7 @@ static int snapshot_set_swap_area(struct snapshot_data *data,
 {
 	sector_t offset;
 	dev_t swdev;
+	int new_type;
 
 	if (swsusp_swap_in_use())
 		return -EPERM;
@@ -238,19 +239,11 @@ static int snapshot_set_swap_area(struct snapshot_data *data,
 		offset = swap_area.offset;
 	}
 
-	/*
-	 * Unpin the swap device if a swap area was already
-	 * set by SNAPSHOT_SET_SWAP_AREA.
-	 */
-	unpin_hibernation_swap_type(data->swap);
+	new_type = repin_hibernation_swap_type(data->swap, swdev, offset);
+	if (new_type < 0)
+		return new_type;
 
-	/*
-	 * User space encodes device types as two-byte values,
-	 * so we need to recode them
-	 */
-	data->swap = pin_hibernation_swap_type(swdev, offset);
-	if (data->swap < 0)
-		return swdev ? -ENODEV : -EINVAL;
+	data->swap = new_type;
 	data->dev = swdev;
 	return 0;
 }
diff --git a/mm/swapfile.c b/mm/swapfile.c
index c7e173b93e11..4840fd40f36f 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2219,6 +2219,67 @@ int pin_hibernation_swap_type(dev_t device, sector_t offset)
 	return type;
 }
 
+/**
+ * repin_hibernation_swap_type - Atomically replace the hibernation pin
+ * @old_type: Swap type currently pinned (or < 0 if none).
+ * @device:   Block device of the new resume image.
+ * @offset:   Offset identifying the new swap area.
+ *
+ * Look up the swap device for @device/@offset and atomically transfer
+ * the SWP_HIBERNATION pin from @old_type (if valid) to the new device,
+ * all under a single swap_lock critical section. This closes the
+ * swapoff() window that exists when callers unpin and re-pin in two
+ * separate operations.
+ *
+ * If the new device cannot be located, the existing pin on @old_type
+ * is preserved and an error is returned. If @old_type already refers
+ * to the same swap_info_struct as the new lookup, no flag changes are
+ * made and @old_type is returned.
+ *
+ * Return:
+ * >= 0 on success (new swap type).
+ * -EINVAL if @device is invalid.
+ * -ENODEV if the swap device is not found.
+ * -EBUSY  if the new device is already pinned by another context.
+ */
+int repin_hibernation_swap_type(int old_type, dev_t device, sector_t offset)
+{
+	struct swap_info_struct *old_si, *new_si;
+	int new_type;
+
+	spin_lock(&swap_lock);
+
+	new_type = __find_hibernation_swap_type(device, offset);
+	if (new_type < 0) {
+		spin_unlock(&swap_lock);
+		return new_type;
+	}
+
+	new_si = swap_type_to_info(new_type);
+	if (WARN_ON_ONCE(!new_si)) {
+		spin_unlock(&swap_lock);
+		return -ENODEV;
+	}
+
+	old_si = swap_type_to_info(old_type);
+	if (new_si == old_si) {
+		spin_unlock(&swap_lock);
+		return new_type;
+	}
+
+	if (WARN_ON_ONCE(new_si->flags & SWP_HIBERNATION)) {
+		spin_unlock(&swap_lock);
+		return -EBUSY;
+	}
+
+	if (old_si)
+		old_si->flags &= ~SWP_HIBERNATION;
+	new_si->flags |= SWP_HIBERNATION;
+
+	spin_unlock(&swap_lock);
+	return new_type;
+}
+
 /**
  * unpin_hibernation_swap_type - Unpin the swap device for hibernation
  * @type: Swap type previously returned by pin_hibernation_swap_type()
-- 
2.53.0

