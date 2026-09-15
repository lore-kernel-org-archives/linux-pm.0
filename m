Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C414623FC41;
	Tue, 15 Sep 2026 22:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789510575; cv=none; b=Fv18Iu2kn0aM8cCS30K89FB5hHG7NlC+3DgwP4q7NO9OBTckF1f//ktXp4i2kw7f6FPtgOOos0WxprqqqGEDJmuzMXXyIKwGTVTO9CapOdjbwyEe2zKrMHlnNl33yeWd0b60NfLQOPs7fuqMxq6WtVzJLjgSiua1M14as2gThY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789510575; c=relaxed/simple;
	bh=4OcySWkVwXRzl3gLkRSH3M68XKZRjwR+q3mkHssFlEA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k3WH3+ZiRUl5csHYA3CAVZ4WJ3Xz0nm3hHHmyaXpjmooYZINvV+1eGJPZwW9TR2KIlL4r7FHUvegiVUTq7F9Yeqoo2J/8iEz67q2lDNqFtmhvo2SE6Wqy43DU76nPhDct5Asrr5lwWxvs98xKL55e4rC52szRAM/j5FFw1eDIDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjg6k9RF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjg6k9RF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2691F000FF;
	Tue, 15 Sep 2026 22:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789510573;
	bh=+BkOBk1sg9gA13PbWkh0DsNS8VZNZHt0LnWD0AIK+vI=;
	h=From:To:Cc:Subject:Date;
	b=bjg6k9RF6NSkushGvbiA9fIScvJrqo+ZFLr1ugIwaUnC8otcP89pLcmrF8eDjhz05
	 Bh6oST5+j9ZgIwVz7dSh2E4+VFawHo6FHQqKzpt6WrmT4mdgMUquD5Bw5cglAdnS+5
	 1yDwoV7+B3fX6YTkOkIFR9XeL7fJ0nFWWJWXxzrUsBisyYDGp76qz9XSjqwvRfV6KL
	 z+TkyTVDnCbUV8c0juhQ+VIyn7vipB7eJYSnXoMLaa+0mQtaUkpRDm4a2p4KT7GTOW
	 9YLYa2hXdZVwi70DKOfLjsN6SKWMguUn2vCmjQKgVl764R6RHqJeva9IwPLlOBLaMe
	 1s4bU1Ws9RlZg==
From: Thorsten Blum <blum@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Thorsten Blum <blum@kernel.org>,
	Yury Norov <ynorov@nvidia.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] thermal: intel: powerclamp: Simplify duration_get()
Date: Wed, 16 Sep 2026 00:15:48 +0200
Message-ID: <20260915221548.104852-3-blum@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1002; i=blum@kernel.org; h=from:subject; bh=4OcySWkVwXRzl3gLkRSH3M68XKZRjwR+q3mkHssFlEA=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFkrD0+tPOoh52Nst7BtwrQli99aLqs173ZttX11qllDN t9PaMX1jlIWBjEuBlkxRZYHs37M8C2tqdxkErETZg4rE8gQBi5OAZhI8j6GP1yF/z/WHdq287gn Q+cuzwDJ5TYHt8U5layPYz6Sl2/bosnI8FB7+eIJkm0CFxZvED0eufXVBsHnYVHpv/QCgzcsEZi +iAEA
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Use guard(mutex) and return the result of sysfs_emit() directly to
simplify the code. Also use %u to format the unsigned duration.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 drivers/thermal/intel/intel_powerclamp.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index bd7fd98dc310..8ceb1270646c 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -103,13 +103,9 @@ static int duration_set(const char *arg, const struct kernel_param *kp)
 
 static int duration_get(char *buf, const struct kernel_param *kp)
 {
-	int ret;
+	guard(mutex)(&powerclamp_lock);
 
-	mutex_lock(&powerclamp_lock);
-	ret = sysfs_emit(buf, "%d\n", duration / 1000);
-	mutex_unlock(&powerclamp_lock);
-
-	return ret;
+	return sysfs_emit(buf, "%u\n", duration / 1000);
 }
 
 static const struct kernel_param_ops duration_ops = {
