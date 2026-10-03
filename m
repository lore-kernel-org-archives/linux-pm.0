Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6422726AE5;
	Sat,  3 Oct 2026 00:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790985667; cv=none; b=RyrJAXw0DNv2zGUYWswrYfgVVewIXV8jlESR24htoXww1tup1vdpOoIY/gIfmga+ll3f6P0FSsBSZUf/OuJDjJrG8yx34NIGOTi/oa7XtP4fBgRDHGUfOmqA1TFJsl8ePfUppb3jdAhGqasGHH0JQACnlFXchAoxR1CmkJ8ljEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790985667; c=relaxed/simple;
	bh=j3jC3DeayT1BV0CY0e0hVV0PtSzO5JCPgqFfHEPz6yE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HCOF0sXGkpPsyiPFgMAjocwUX9Or+pGvnP3qtSWDNAL1wSTKPlUjl9CnM2ul28caK3+Y3zOpDLHH/Eae7gZM8MF0rluzOEqhFOGMvnJ6llJmjo6bSedTtM+qxNZNJUuj0wkfqjAUuHNo+JGXQlD9WtTHl9LRbh9Y6ENCPxO5qnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hgyegqb0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hgyegqb0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB441F000FF;
	Sat,  3 Oct 2026 00:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790985666;
	bh=TCfcQ4pwZ9076UQhow6zaul81EOJVhwbK3rrWGpZWJ4=;
	h=From:To:Cc:Subject:Date;
	b=Hgyegqb0LufAirbtHJHZSYxgc1r59hENOwMpURrZxoQNQGjNTNRLjbxC6Fz10HGFa
	 B1khDBq1RbwaWchyLQUAky+CNDYxPbaSzKRb3DB5WaI9yFqxrhUBrLrzXU04hKs8s0
	 DzmYHqa0QrzrFDsMlx3lrd1I6cpbiOCCdxVh8CBC9vvyv5seg/369SMSf99AOnwL4p
	 Li2FIwvEZahkq5RQskEgIHfuR+0rWiBfdQGFrPTPVbC1vrEmzBkNgqWaYi24Kd9q7s
	 KNsx34nbl4+SpkDmMbu5CJLN65lD4cQ85ypmEjA/E1tg3YYAzUUZn1lmzvTRnYlCHr
	 HEhQFKswKElLw==
From: Thorsten Blum <blum@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Cc: Thorsten Blum <blum@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: sysfs: Fix indentation in create_s32_tzp_attr()
Date: Sat,  3 Oct 2026 02:00:12 +0200
Message-ID: <20261003000011.58045-3-blum@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1068; i=blum@kernel.org; h=from:subject; bh=j3jC3DeayT1BV0CY0e0hVV0PtSzO5JCPgqFfHEPz6yE=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFkHXLu/qchV3Dgaf3j+NJZTE13nZdSvuHHgdppAJ1cJU 5iQzb+QjlIWBjEuBlkxRZYHs37M8C2tqdxkErETZg4rE8gQBi5OAZhIewUjQ68zq8SeW8xfHgu6 bDm1wviqQNIdPmHd9LnNO1Tswx7dmsbIMOuWtOb8MMYny5IKpdsl9mZzruyIn6EkmKzFez1kt7I PBwA=
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Indent the show callback consistently with the store callback and use an
early return if the thermal zone parameters are not available.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 drivers/thermal/thermal_sysfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 96fe5d591a0a..47daba943a76 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -287,12 +287,12 @@ sustainable_power_store(struct device *dev, struct device_attribute *devattr,
 	name##_show(struct device *dev, struct device_attribute *devattr, \
 		char *buf)						\
 	{								\
-	struct thermal_zone_device *tz = to_thermal_zone(dev);		\
+		struct thermal_zone_device *tz = to_thermal_zone(dev);	\
+									\
+		if (!tz->tzp)						\
+			return -EIO;					\
 									\
-	if (tz->tzp)							\
 		return sysfs_emit(buf, "%d\n", tz->tzp->name);		\
-	else								\
-		return -EIO;						\
 	}								\
 									\
 	static ssize_t							\
