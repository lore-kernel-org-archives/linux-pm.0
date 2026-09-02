Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3704C377A95
	for <linux-pm@vger.kernel.org>; Wed,  2 Sep 2026 17:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788369539; cv=none; b=SFdtEnSSWXBVJQzTdrE0q3+nN5a+d4m/xs4SZQxZZGGO94xW29IclLXYx5xI+6EQ0jP4UuZ3kqVi/do5Ljw3UxFc8BE5A43dZJ+LMPREIEPEhn3ZXInQnxgGCaDLt+//qmk/FkgGJSlSUADZ6WrlOpnkDyKdzR8nU6Wf6xwj90s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788369539; c=relaxed/simple;
	bh=HY2s9iDSTOoVQgMBRKERQOvMKTBuDzzCZ0AA4lzBuLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r7fDlpjxFnDQVhDUY9ZDK2W1/uTzRTezosp85O322W9BkNIYhaCe8651THy0brvaGDW1W1IQAPur27O8eDB8PlaHxVwcAKlO2NtyqyS+5XanVxC/yXjP3WtIt34NCcsNoVMsmwkMLpbi74ofpbhR1CFowfjiZAxkbs1e3FBgxUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=TlcwXiUO; arc=none smtp.client-ip=80.12.242.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="TlcwXiUO"
Received: from device-106.home ([10.64.95.115])
	by smtp.orange.fr with ESMTP
	id 1oaox3mQed1xd1oaox6xNI; Wed, 02 Sep 2026 19:17:46 +0200
Received: from device-106.home ([IPv6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e])
	by smtp.orange.fr with ESMTPSA
	id 1oaexNFjKP8Xp1oaexvHDh; Wed, 02 Sep 2026 19:17:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1788369458;
	bh=knQhvrvBb8T8P3G9UIe7lzic6iGN2FHXjgOBj/taQ4Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=TlcwXiUOE3ARzjDgPhtTiVPd4tIX+M7MRDLjwkkvjUKk0jx6DY0Vyati+gADFQMni
	 6Zwk7uuYv3FDi3doxHi8TvxZcTM9s0P6r1o7C+L7fioykxrIhvd/KzF9PbRxPpTdPs
	 yMO2pauxm+BJHaXTSrDt9KzBc0ic/ZgNPFuFyp5NqHxvop8xFYfu+TA6k4xg/laR04
	 jlECsNkVaSuRjxiU/5bSMofGUwCHnOYcvJeABCuYi1DMxZNN7Vb+1rOtb16oTVZMvu
	 xSvY/OIOF8rivNHNQDDhUXGUNU1UZB9ZYTd/I23/GTIU2ClPaA3+TvakJdyS+YvpWY
	 qg99ZMOKS8jxA==
X-ME-Helo: device-106.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 02 Sep 2026 19:17:38 +0200
X-ME-IP: 2a01:cb10:785:b00:26fb:aefb:6cd2:db0e
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-pm@vger.kernel.org
Subject: [PATCH] thermal: intel: Slighly simplify duration_set()
Date: Wed,  2 Sep 2026 19:17:30 +0200
Message-ID: <0f12d097f5874242b8d3cc98b441c4fefd626aee.1788369428.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

there is no need to call clamp here(). The same tests have already been
performed a few lines above, and there is a "goto exit;" if outside of the
range.

While at it, also remove an un-needed initialization of 'ret'.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Based on my testing, gcc is not smart enough to get rid of the redundnat
tests by itself.

This patch is compile tested only
---
 drivers/thermal/intel/intel_powerclamp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index bd7fd98dc310..ba9c4a1224ca 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -80,7 +80,7 @@ static unsigned int window_size;
 
 static int duration_set(const char *arg, const struct kernel_param *kp)
 {
-	int ret = 0;
+	int ret;
 	unsigned long new_duration;
 
 	ret = kstrtoul(arg, 10, &new_duration);
@@ -94,7 +94,7 @@ static int duration_set(const char *arg, const struct kernel_param *kp)
 	}
 
 	mutex_lock(&powerclamp_lock);
-	duration = clamp(new_duration, 6ul, 25ul) * 1000;
+	duration = new_duration * 1000;
 	mutex_unlock(&powerclamp_lock);
 exit:
 
-- 
2.55.0

