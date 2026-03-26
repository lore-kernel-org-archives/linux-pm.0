Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F6D3E8664;
	Thu, 26 Mar 2026 11:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774525040; cv=none; b=CPLw0PiiYJ2JXWwn9ci4u8UpqivV0xvilEaKMjXAGGxSgM6U6zVT2ynSR3I83jsFddFUvO5ZOOOivMbP8C/WuWAh6qWntyEUo1Mt0SbPKqab6w0OSIoeLrN4Pk6tzqJ2+vz7K8swATYke2arMkt1LAw3u3x1lDZzkNc2ow3M3G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774525040; c=relaxed/simple;
	bh=Uhzs2oxZJwfyCFDgOwTqBrahqaccLqdeKI1H/jfjPQg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DhBtOy3iSobSqATlFp/Ek72OoqNn1HrXNNEOpd1DBpZkSUcAZFJ1Z7GDzjubBPfuCDkyA/5r4pGXEvdb3mu36RiS2c//CX7CcuitysYaS/Vo6AMhLTK8nnruqUwcf6NlSHNlnN+9256ACGdLAE/mJ8hTOfKaEGn9AkTBYRHsFpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=loArWVJE; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="loArWVJE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1774525033;
	bh=Uhzs2oxZJwfyCFDgOwTqBrahqaccLqdeKI1H/jfjPQg=;
	h=From:Date:Subject:To:Cc:From;
	b=loArWVJEiEgAuslYxdGUxqe3lcz+bFEAHoJOzJWauZMM1NY1bzZpK3RVeYLhjQlcj
	 W7ymYM/uiIjZ0nSMl5x9WakGfVlq69j4eYMhO8ymVoKldBt9IYOyNLmZ06Dnx1jtgr
	 f6YpYolrJk8uMvSBojGL3gzbqSnI7/2E3s4nyiw8FNTFxz056c8hzqzVxmcMTG4hOB
	 LMVT0NZQFNSwFc26xrG3R83tLe3DbGDLMbzJeSHgH/zsfS74/wehgNysMc9RnkIFFr
	 znXR6chSyVNSZhWAzWb1jH7hQPry2KGyKEBBs5WSKjtFtOSG9rdpFUl/89loNlpTlL
	 6CF+8ObzDrXMA==
Received: from goku6.local (ncb.1e0.uk [5.83.15.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mattl)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 04C2417E60AA;
	Thu, 26 Mar 2026 12:37:12 +0100 (CET)
From: Matthew Leach <matthew.leach@collabora.com>
Date: Thu, 26 Mar 2026 11:36:45 +0000
Subject: [PATCH v2] PM: hibernate: call preallocate_image after freeze
 prepare
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-hibernation-fixes-v2-1-f6707d82b7b9@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NSw7CIBCGr9LMWkyhAYMr79F0ATjIJBUMNETTc
 HexB3D5/c8dCmbCAtdhh4yVCqXYQZwGcMHEBzK6dwYxCjVOgrNAFnM0W88xT28sTGnrjECUVkn
 ovVfGw+i1eekcqGwpf46Lyn/qv7XKGWfSo1bTxSrv9c2ldTU2ZXN26QlLa+0LvNm4WLYAAAA=
X-Change-ID: 20260321-hibernation-fixes-69bca2ee5b65
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
 Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 YoungJun Park <youngjun.park@lge.com>, kernel@collabora.com, 
 Matthew Leach <matthew.leach@collabora.com>
X-Mailer: b4 0.15.0

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
Changes in v2:
- Removed shrink_shmem_memory.
- Fixed missing call to dpm_prepare in error path.
- Link to v1: https://lore.kernel.org/r/20260321-hibernation-fixes-v1-1-5fe9637b6ff9@collabora.com
---
 kernel/power/hibernate.c | 46 +++++++++-------------------------------------
 1 file changed, 9 insertions(+), 37 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index af8d07bafe02..39b0a8ea4024 100644
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
 
@@ -441,23 +419,17 @@ int hibernation_snapshot(int platform_mode)
 		 * successful freezer test.
 		 */
 		freezer_test_done = true;
-		goto Thaw;
+		goto ThawKThreads;
 	}
 
 	error = dpm_prepare(PMSG_FREEZE);
-	if (error) {
-		dpm_complete(PMSG_RECOVER);
+	if (error)
 		goto Thaw;
-	}
 
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
+		goto Thaw;
 
 	console_suspend_all();
 	pm_restrict_gfp_mask();
@@ -493,9 +465,9 @@ int hibernation_snapshot(int platform_mode)
 	return error;
 
  Thaw:
+	dpm_complete(PMSG_RECOVER);
+ ThawKThreads:
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

