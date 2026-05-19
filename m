Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E126837FF40;
	Tue, 19 May 2026 06:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779171505; cv=none; b=mZZZdElFO+wnYqJQtFA46Tc7n/7m5Y58B70hqi4WbKxxq1+q7pv4VEKZV7nE2R7FzX9MCd+G/imfLoPANVcRND+8bz6R01h2FqJCNACnVVZ0tJl1N5HwSziP+KV/NaXHISn4hxjcHJKG9yohi28ZKymrKvOleYEtuHrCgcJsS6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779171505; c=relaxed/simple;
	bh=HDRhc31CvFqZU4Dpr1nIp9CwCZi9lQiE1Y3CzkPcOBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LNeudRWqIiVbJiKfM8AfmuE/awOpjSv9UsjrwdGx5mtJ7iGgfWMxHk8NIBO3Tdx/7jEevg2whyTW9uI77lrRZYlsk5ZEcWiIJec4hlso/6fsiXowi9pa7PS20+IcrsvxckZ8PBx/iZfbtz6dFDUowodzfZcJ1GxkKxeYFapSKFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFdgOXvR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFdgOXvR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0BEC2BCB3;
	Tue, 19 May 2026 06:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779171504;
	bh=HDRhc31CvFqZU4Dpr1nIp9CwCZi9lQiE1Y3CzkPcOBw=;
	h=From:To:Cc:Subject:Date:From;
	b=IFdgOXvR5FfbL2FJUD97YOOt3Sv1+Nv/tSjIP6nRxI2USdT75QKo11r+xTpChQJ6l
	 fgbALL14Rd5XrbJYisvNUOeYUg68203kO9k0dAaw6cbZrleZMPjWY8GDGkQm7BFKMA
	 VtaJMA5yh8mIQp9egf7FjaV4xoH+6t/5xsq//Q1THQEOxT14t/V2M3VotK7osk2Sl7
	 zAQiURosFfuRJX9mjdqQ4Fi+4PPIKg1HPB4/WWzKR1pKevRtohjbPFbsoeCMFsibRm
	 d4RupwtWPF/Dm4yr3qwaMKsP/WjmZY5H8Z24Ar2M5LqVfAtUBKfskJvu5EwPDxL775
	 pCtk6PBoC3CTQ==
From: Jisheng Zhang <jszhang@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: linux-pm@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PM: Use LIST_HEAD() to initialize on stack list head
Date: Tue, 19 May 2026 13:59:20 +0800
Message-ID: <20260519055920.13180-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use LIST_HEAD to initialize on stack list head. No intentional
functional impact.

Change generated with below coccinelle script:

@@
identifier name;
@@
- struct list_head name;
+ LIST_HEAD(name);
... when != name
- INIT_LIST_HEAD(&name);

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/base/power/clock_ops.c | 4 +---
 drivers/base/power/main.c      | 3 +--
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index 59bb37e8244c..1f708e10e711 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -422,13 +422,11 @@ void pm_clk_destroy(struct device *dev)
 {
 	struct pm_subsys_data *psd = dev_to_psd(dev);
 	struct pm_clock_entry *ce, *c;
-	struct list_head list;
+	LIST_HEAD(list);
 
 	if (!psd)
 		return;
 
-	INIT_LIST_HEAD(&list);
-
 	pm_clk_list_lock(psd);
 
 	list_for_each_entry_safe_reverse(ce, c, &psd->clock_list, node)
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index e1b550664bab..d0c7b1d4101e 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1257,11 +1257,10 @@ static void device_complete(struct device *dev, pm_message_t state)
  */
 void dpm_complete(pm_message_t state)
 {
-	struct list_head list;
+	LIST_HEAD(list);
 
 	trace_suspend_resume(TPS("dpm_complete"), state.event, true);
 
-	INIT_LIST_HEAD(&list);
 	mutex_lock(&dpm_list_mtx);
 	while (!list_empty(&dpm_prepared_list)) {
 		struct device *dev = to_device(dpm_prepared_list.prev);
-- 
2.53.0

