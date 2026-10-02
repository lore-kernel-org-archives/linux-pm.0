Received: from mail-dl2-f40.google.com (mail-dl2-f40.google.com [74.125.229.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04811497B64
	for <linux-pm@vger.kernel.org>; Fri,  2 Oct 2026 23:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790982449; cv=none; b=d73cDqjxVvMG2498xEn3kJ9bHsvPvxV8Mpooq3pael+bFL+iFiil3Tv9ad6AA8hGdZr1XZA74oQmla8nDG7ul98gKGlD1Hs6GeewykXKwTMasg5aAFGG82TOXLojGkyz6I+Tpcd7Y4ko53dv5lRAlGrwIFrIbOubfiWuT5f+fFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790982449; c=relaxed/simple;
	bh=ojqUoeadyLtRgHpE4QSBZ8jr4q1a9kCTFa/MCi0AEBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QiGD5OjEX1V3wHmHH8rDsaMoBxiApXZ1ZrqEOqKfE+x4l9CYC7wzZMwxv+6Hg3EW3vuj3PxNuRtfiD3PPtkyP4RuUIECJPBzoZE9rHLSNfzxUhxD5sIUrw2V5PijhcPMeNKWKtf5uQY8C+HkeOLR6mAHlr8PMIDaFgZdN02jjYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=k4OAZFjr; arc=none smtp.client-ip=74.125.229.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k4OAZFjr"
Received: by mail-dl2-f40.google.com with SMTP id a92af1059eb24-14e1fe551c3so36011c88.0
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2026 16:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790982446; x=1791587246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LXSwX5jjkSLNliyM1NMwqcwfmmI5JkAaKqy5NKFRsCg=;
        b=k4OAZFjrT8ZpBcwWcTygc65JkvsUGDw0/mjw3fJ73pLkJEbDv+e4QnPe9yKz64yzze
         XmEHx7UOnjKccDCjvOne8TdlNazx2DnJ8GpANDhTW+2Oc5Onoevd9UHCiXDx14c4OPoQ
         gI5AEFDU5sWqiZastOXddjLTbZU23cgthDKKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790982446; x=1791587246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LXSwX5jjkSLNliyM1NMwqcwfmmI5JkAaKqy5NKFRsCg=;
        b=a5caqLbXiknrWH8sHuNJXhMgvwmgHuuwjUq9QFEhhwPYvFOyyv60MM3xXBdi1BdQRU
         Qb53Gjn3vDTXaMZ7i9iXD3PlCQKQXrYF1C3QCnZuU7XQCjgZPFUxllilt3BBmHrvYM1J
         f+7jcCMhfQKkhQFleR1dMn2Q7EnFYEa3dqAFqMUSkujt9W6eImx5vtoRk8uI6Te/WczS
         sq1QxinAQpXUKxLuN8XJDHzTbGe+8wJwZjTpriKanYL0DkTDuzSzQW4HT1KtMUmdgANq
         HvMxe+9XayfNGMF1eZVrWN3mx1ovBKPd315ZAbF7ODKncGDEUgvS2vrYygrAMSlL9r5+
         mf5g==
X-Gm-Message-State: AFuF++kcy6mEqc5XIupusksqwtJ/c1sTiYvVpf2Zaw+ESaLLZ+q3Kirk
	9AxJTVBgPtGct80oxgVWz3MWr2iH2yuYiXLMe3Qi9xiafqXIWSeaLmJIlxq2iKtiaw==
X-Gm-Gg: AYBFou2pXET3sVCNBRXnxo4CXqIKn9yEZKxXw8CT8vUnlKpcpgyyIHlAl1pNAGmm9IN
	izH4T+wEDXPbb52dO+FtvwFQqv64aIge2M0AAOwLgNfk+lyRe+WIsXRR0tHz8Q5r8ezeyMFTgmZ
	5DGg84xN0nQVxGr85RiuuvU3TufHORu5rb+HSwBn5WxE7Aou0KWdV4gVYeqEzGbzwjycuD+kg0h
	WHddL9WLvdmOY6p4ZVFa7FIVjd04mrKbKV54OK0KYbDVsexKzjgt4iwsi5DLto+pMum7p57MQJG
	2qg13kxkOI5EXpFfDJteHynbXHvzcXSPfvIUbQ7NK0Vp+MNGn7e0RABHziB9ft0kUGV4E7GNr5a
	6TuzkW26Ijhx0L0WpwxflbrSoniZDCj5FKvgxIOtFoV7Omomnq1txZjhp1KAZ8HyzuoI9f5mMQR
	BnZ+O6o7Le3B1rDXcOrImgVS25HngYUiRky/fBbDNHUfLB+OmXmggEvDFprZQmmqQFKeL5FQhUu
	JKeOyolownmHcYy9dfF4c9YUFMiCMmRduVvrxvvcjCQSiMN
X-Received: by 2002:a05:701b:450b:10b0:148:cfd2:1e4 with SMTP id a92af1059eb24-14f7e8aad17mr4136592c88.16.1790982445807;
        Fri, 02 Oct 2026 16:07:25 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:b0dc:e72e:e96b:3323])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-151f7bd2884sm704829c88.0.2026.10.02.16.07.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 16:07:25 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	linux-kernel@vger.kernel.org,
	Fabrice Gasnier <fabrice.gasnier@st.com>,
	linux-arm-kernel@lists.infradead.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 3/5] PM: runtime: Propagate last_busy from dependent to dependency
Date: Fri,  2 Oct 2026 16:03:07 -0700
Message-ID: <20261002160309.3.I40c0bc917fa0b13111251844e9a54feb1d9cd7d2@changeid>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20261002230714.507921-1-briannorris@chromium.org>
References: <20261002230714.507921-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a child device suspends, it does not update the last_busy timestamp
for its parent. If that parent configured autosuspend and didn't
otherwise maintain its last_busy timestamp, it may now be immediately
eligible to suspend. This is probably not expected -- the parent should
wait for its autosuspend delay before suspending.

The effect of this behavior is that a parent device may suspend sooner
than its autosuspend delay, simply because its usage was accounted by
its children, and not by direct references to the parent device.

This was noticed in several cases, and some have implemented
workarounds, such as in commit c537d3457542 ("iio: adc: stm32-adc: fix
runtime autosuspend delay when slow polling"). At the same time, Ulf
suggested these problems "should be solved in the runtime PM core".

Instead of working around the problem in drivers, we propagate last_busy
timestamps from a dependent device to its dependencies any time it may
allow a dependency to suspend -- i.e., when releasing a refcount for its
parent or suppliers. We take care to only propagate the timestamp if it
is larger than the existing busy timestamp.

Note that this works best if the dependent device is using autosuspend
(and therefore updates its last_busy timestamps appropriately), but even
for a non-autosuspend child, this is still somewhat useful --
non-autosuspend devices still automatically update their last_busy every
time they resume.

Link: https://lore.kernel.org/all/CAPDyKFp=KTf8=zGBSzPYqhjnZpY8xwvjCeM1e-WTKT1QLSxaDA@mail.gmail.com/
Cc: Ulf Hansson <ulfh@kernel.org>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/base/power/runtime.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 9eed1f79429d..ee7253d154e2 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -318,6 +318,21 @@ static int rpm_get_suppliers(struct device *dev)
 	return 0;
 }
 
+/*
+ * Propagate last_busy timestamp from one device to another. This can, for
+ * example, prevent overactive suspend when a dependency's usage is primarily
+ * driven by one of its dependents.
+ */
+static void rpm_propagate_last_busy(struct device *dev, struct device *target)
+{
+	s64 busy = atomic64_read(&dev->power.last_busy);
+	s64 target_busy = atomic64_read(&target->power.last_busy);
+
+	while (target_busy < busy)
+		if (atomic64_try_cmpxchg(&target->power.last_busy, &target_busy, busy))
+			return;
+}
+
 /**
  * pm_runtime_release_supplier - Drop references to device link's supplier.
  * @link: Target device link.
@@ -348,6 +363,7 @@ static void __rpm_put_suppliers(struct device *dev, bool try_to_suspend)
 		if (!device_link_test(link, DL_FLAG_PM_RUNTIME))
 			continue;
 
+		rpm_propagate_last_busy(dev, link->supplier);
 		pm_runtime_release_supplier(link);
 		if (try_to_suspend)
 			pm_request_idle(link->supplier);
@@ -710,6 +726,8 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 
 	if (dev->parent) {
 		parent = dev->parent;
+		if (!parent->power.ignore_children)
+			rpm_propagate_last_busy(dev, parent);
 		atomic_add_unless(&parent->power.child_count, -1, 0);
 	}
 	wake_up_all(&dev->power.wait_queue);
@@ -1369,8 +1387,10 @@ int __pm_runtime_set_status(struct device *dev, unsigned int status)
 		goto out_set;
 
 	if (status == RPM_SUSPENDED) {
-		atomic_add_unless(&parent->power.child_count, -1, 0);
 		notify_parent = !parent->power.ignore_children;
+		if (notify_parent)
+			rpm_propagate_last_busy(dev, parent);
+		atomic_add_unless(&parent->power.child_count, -1, 0);
 	} else {
 		spin_lock_nested(&parent->power.lock, SINGLE_DEPTH_NESTING);
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

