Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359B436DA0A;
	Fri,  3 Apr 2026 07:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775201811; cv=none; b=Kq+EL6SrMe2HjBQ6xVpW4VcwUlVLnfQZcEnGokRD2jYo1Cstd5yukPXS9fmL8CMnCCikVc3sUY/+/RT22g1WNXFzx+fh0WRicW6wcUuNRrdTAoRWjt+Uz1xptZYDLmuKftcK1wpLy15ArS+3GzV0iB+GVK8VZIlMib0OTslbjFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775201811; c=relaxed/simple;
	bh=eo26JsyZmpNnH/g5aS7cOZ4Vuwt7sdpIlqkX4T/ccLg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=O4qeSz1PlahaM4pegFe8UOI/7b4QOOEYjRFf7DVwPoPkDQ8ixCA/Dd2RFf9HwwgD2bQ6+MvIatm+DJNDqizsih+3u717zA49o+H/zEFytAVNHcPQCaO8GvGz9joLM6tpQ9cbVh5V/JPlSbBcMEQm6joCW/T5AfqJVeF+5w+dN2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PJRvQgb3; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PJRvQgb3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1775201808;
	bh=eo26JsyZmpNnH/g5aS7cOZ4Vuwt7sdpIlqkX4T/ccLg=;
	h=From:Date:Subject:To:Cc:From;
	b=PJRvQgb39888FUy9QBDFGCYnTBVFBmAloAzuXlnHjY/DWZ2/IOF/zdpugV3jhzFI6
	 Dz6qFebHvi7gShP2xfHOKE+b+C2M1kDdajUTrdeTFrxh4OR7P4hqLk9m14ARvCndi9
	 GfRHoUAYU3VsnRjprV4bg23sSTt6p+vy+m5iaUB+P4slYnutPnyVZHNPi0r6Dpg02n
	 j2uyCbHeqEMC3pL8lJvBbbAWDhilPetMhbQS5JlRuM4CIaTjL2VOJsnSc7k5M7YtXr
	 YZBGL5ecJbSsR7SllOlfl1jyULXRjsKQusuL/IV6rAaE3oAk3GXXLaQLz0Tfq/GU64
	 SXASNsjh6IGiA==
Received: from [192.168.1.53] (unknown [IPv6:2a01:6243:628:0:43ea:f64d:fc7e:3a2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mattl)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D525117E8457;
	Fri,  3 Apr 2026 09:36:47 +0200 (CEST)
From: Matthew Leach <matthew.leach@collabora.com>
Date: Fri, 03 Apr 2026 08:36:30 +0100
Subject: [PATCH v3] PM: hibernate: call preallocate_image after freeze
 prepare
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-hibernation-fixes-v3-1-31bc9fa3ba2d@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NwQrCMAwG4FeRnq2sGWudJ99DPDRd6gpzlXYUZ
 ezdzXYSFI9/kv/LLDKlQFmcdrNIVEIOceRQ73fC9Xa8kQwdZwEV6KoGJfuAlEY78Z304UlZ6ha
 dBaIGdSO490i0Lbh2uXLuQ55iem0vilqn/7SipJKNp1bXBrX37dnFYbAYkz24eBerWOBT0b8UY
 MVrU5nuCGjwS1mW5Q2tZAPe/AAAAA==
X-Change-ID: 20260321-hibernation-fixes-69bca2ee5b65
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
 Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 YoungJun Park <youngjun.park@lge.com>, kernel@collabora.com, 
 Matthew Leach <matthew.leach@collabora.com>
X-Mailer: b4 0.15.1

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
hibernate_preallocate_memory's reclaim path. Also remove
shrink_shmem_memory since hibernate_preallocate_memory will have
reclaimed enough memory for the hibernation image.

Signed-off-by: Matthew Leach <matthew.leach@collabora.com>
---
Changes in v3:
- Changed error label names to 'Thaw' and 'Complete'.
- Link to v2: https://patch.msgid.link/20260326-hibernation-fixes-v2-1-f6707d82b7b9@collabora.com

Changes in v2:
- Removed shrink_shmem_memory.
- Fixed missing call to dpm_prepare in error path.
- Link to v1: https://lore.kernel.org/r/20260321-hibernation-fixes-v1-1-5fe9637b6ff9@collabora.com
---
 kernel/power/hibernate.c | 46 +++++++++-------------------------------------
 1 file changed, 9 insertions(+), 37 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index af8d07bafe02..d2479c69d71a 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -392,23 +392,6 @@ static int create_image(int platform_mode)
 	return error;
 }
 
-static void shrink_shmem_memory(void)
-{
-	struct sysinfo info;
-	unsigned long nr_shmem_pages, nr_freed_pages;
-
-	si_meminfo(&info);
-	nr_shmem_pages = info.sharedram; /* current page count used for shmem */
-	/*
-	 * The intent is to reclaim all shmem pages. Though shrink_all_memory() can
-	 * only reclaim about half of them, it's enough for creating the hibernation
-	 * image.
-	 */
-	nr_freed_pages = shrink_all_memory(nr_shmem_pages);
-	pr_debug("requested to reclaim %lu shmem pages, actually freed %lu pages\n",
-			nr_shmem_pages, nr_freed_pages);
-}
-
 /**
  * hibernation_snapshot - Quiesce devices and create a hibernation image.
  * @platform_mode: If set, use platform driver to prepare for the transition.
@@ -425,14 +408,9 @@ int hibernation_snapshot(int platform_mode)
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
 
@@ -445,19 +423,13 @@ int hibernation_snapshot(int platform_mode)
 	}
 
 	error = dpm_prepare(PMSG_FREEZE);
-	if (error) {
-		dpm_complete(PMSG_RECOVER);
-		goto Thaw;
-	}
+	if (error)
+		goto Complete;
 
-	/*
-	 * Device drivers may move lots of data to shmem in dpm_prepare(). The shmem
-	 * pages will use lots of system memory, causing hibernation image creation
-	 * fail due to insufficient free memory.
-	 * This call is to force flush the shmem pages to swap disk and reclaim
-	 * the system memory so that image creation can succeed.
-	 */
-	shrink_shmem_memory();
+	/* Preallocate image memory before shutting down devices. */
+	error = hibernate_preallocate_memory();
+	if (error)
+		goto Complete;
 
 	console_suspend_all();
 	pm_restrict_gfp_mask();
@@ -492,10 +464,10 @@ int hibernation_snapshot(int platform_mode)
 	platform_end(platform_mode);
 	return error;
 
+ Complete:
+	dpm_complete(PMSG_RECOVER);
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

