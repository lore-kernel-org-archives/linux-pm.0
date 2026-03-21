Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AE02DCF4C;
	Sat, 21 Mar 2026 08:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774083136; cv=none; b=SypoMzjyhyE975JEIwy4+7+pxcv+g1v2C33AqvJI2+8VStnL8gmk6H1BLEyT2hB9FrfKxQ+nSsThlbEtraNqpb6MZSUQ4IId2vriMnMx+dyb7Pjj6aSDsgBfdU1BiUcuyWhXsbZYEYcwDcIaIvfb+YCdI3RtQBM2TXT3XpxByZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774083136; c=relaxed/simple;
	bh=8apiOH2dC6YsNkQPQk4SrelHbxNNP11B97V8qHmqQ1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=i4UZix1fbk/cPqGDOpMsXwf7xcZlTETmYGrCf7YlB3DOIWq7oY5K3bthX1yyyXWAgY2JbI9nXfFQt/6R3Tz635UmhtvoJuh2JFF2W+jyY52r+f9q6My3yRMlU8K3GvLfA84cLJ2eBHR6ulXWel7Okb1EX7MU8csu9NGWw+Wj09w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VWx4c3y7; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VWx4c3y7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1774083133;
	bh=8apiOH2dC6YsNkQPQk4SrelHbxNNP11B97V8qHmqQ1k=;
	h=From:Date:Subject:To:Cc:From;
	b=VWx4c3y7PXi0MOuaj3DeW6KWH/mKf/suhvpirG4YyStwTwtkS+P16U9p4nSTzGI6e
	 WV//kxJchvzjS1LKgFiNTjO1TRojpY6m6zux2qd4ir1X+m2STTN1Fsa7XuuA7kqhpO
	 ci86PdEPt3aqurDRnKntnVtbc9MDEMRJYoXRggeqOln7+Sc3tgzAnKsWsAFKuap2q0
	 d+AO6IT4IFXx/pFL3dxte1X5twwPK12f0mJSD5AvgP+SKZUHnFzj/4h+c21NAy6CbL
	 sD5R/0LQ1Xv7+AgYZxz59qXnuVY0oOv4WCLcXIil7gXN0/TTzIKKjbvDPUFflSvKxI
	 N631CjQdji4pQ==
Received: from [192.168.1.53] (unknown [IPv6:2a01:6243:628:0:43ea:f64d:fc7e:3a2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mattl)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4407A17E1418;
	Sat, 21 Mar 2026 09:52:13 +0100 (CET)
From: Matthew Leach <matthew.leach@collabora.com>
Date: Sat, 21 Mar 2026 08:51:31 +0000
Subject: [PATCH] PM: hibernate: call preallocate_image after freeze prepare
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260321-hibernation-fixes-v1-1-5fe9637b6ff9@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2LQQqAIBQFryJ/nZCGQl0lWmi96m8sNCII796n5
 TAzLxVkRqFBvZRxc+EjCZhG0byHtEHzIky2tb7trNE7R+QULun0yg+K9n2cgwVc9I7kOzN+Ids
 41foB+K8AXWMAAAA=
X-Change-ID: 20260321-hibernation-fixes-69bca2ee5b65
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
 Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, Matthew Leach <matthew.leach@collabora.com>
X-Mailer: b4 0.14.3

Certain drivers release resources (pinned pages, etc.) into system
memory during the prepare freeze PM op, making them swappable.
Currently, hibernate_preallocate_memory is called before prepare freeze,
so those drivers have no opportunity to release resources first. If a
driver is holding a large amount of unswappable system RAM, this can
cause hibernate_preallocate_memory to fail.

Move the call to hibernate_preallocate_memory after prepare freeze.
According to the documentation for the prepare callback, devices should
be left in a usable state, so storage drivers should still be able to
service I/O requests. This allows drivers to release unswappable
resources prior to preallocation, so they can be swapped out through
hibernate_preallocate_memory's reclaim path.

Signed-off-by: Matthew Leach <matthew.leach@collabora.com>
---
 kernel/power/hibernate.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index af8d07bafe02..ff62e220ded1 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -425,14 +425,9 @@ int hibernation_snapshot(int platform_mode)
 	if (error)
 		goto Close;
 
-	/* Preallocate image memory before shutting down devices. */
-	error = hibernate_preallocate_memory();
-	if (error)
-		goto Close;
-
 	error = freeze_kernel_threads();
 	if (error)
-		goto Cleanup;
+		goto Close;
 
 	if (hibernation_test(TEST_FREEZER)) {
 
@@ -450,6 +445,11 @@ int hibernation_snapshot(int platform_mode)
 		goto Thaw;
 	}
 
+	/* Preallocate image memory before shutting down devices. */
+	error = hibernate_preallocate_memory();
+	if (error)
+		goto Thaw;
+
 	/*
 	 * Device drivers may move lots of data to shmem in dpm_prepare(). The shmem
 	 * pages will use lots of system memory, causing hibernation image creation
@@ -494,8 +494,6 @@ int hibernation_snapshot(int platform_mode)
 
  Thaw:
 	thaw_kernel_threads();
- Cleanup:
-	swsusp_free();
 	goto Close;
 }
 

---
base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
change-id: 20260321-hibernation-fixes-69bca2ee5b65

Best regards,
-- 
Matt

