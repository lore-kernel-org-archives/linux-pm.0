Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8471937DE84
	for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 18:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773340063; cv=none; b=j+xeOL6/MUV8de+ofRZXqrfP2Z8Fx5vY698b1BFNumhAZJ/KgKArMLFk3SAdhFAqjOM37nqE5uRsUF/LpAVzveRPtnFJFECpO3FDHu3zDhm+wS30EacfkwsoH0aYrcFi3TDuiDTxj9Rvlb1XPSDdMObSQ2GQvqHj/tURSr06fZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773340063; c=relaxed/simple;
	bh=spkX+HkkukkLQoaaiDs7C2UpPPlSNmShuwtcKgfHKpE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZIcG3V9R4Pkdiw8jCBhUe/7u1SAUsk2cywEdiP8LI2caMId5zNNlSEJxB4vlRWnwmCWvo9hHM2AsUTxoGaGEFhM6KvfJ9RnK26Y6mI+vOjffrvF2cIlcpuu2x8D/eUHlxpclJU8IJyqZBUDd7oqmneso9dVweqpado4IDdNHnaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=0gHogtNr; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="0gHogtNr"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fWx1M5vcJzlfl5V;
	Thu, 12 Mar 2026 18:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1773340050; x=1775932051; bh=10RPo9K9hQ1mW9VTvhBwrf2sfDery9skhJm
	JdgSpe4I=; b=0gHogtNrZ2G6/GQ1yfALuV0TFWXrvepuTYWlq+F7DzJD1MY3u0W
	0UtxzYhI+lFPiTASW3AWN/KtgHgEv3Y2YgPFLkSqV1dj2Mmk7OVxPIP/vT+DIpgd
	XvGimkO5WDZb7Y7ZCEpviDsOGc0xTHRjqgs03Wg6m42QkWZuL3aZp4+cPKyuK6nq
	T7lPiPCBr6k++ClOY9udFeS2XqIG9mHNC5rZUby2kGps3Lzyadu8eC3MtWFln2a7
	xZjUs2WyICuu+gMkGWjIpYcjFElcV7xckxs8SH5dEae+9UPD8+T7s08zxS+ot3BB
	y7tALd+gsgXhds27SkTmpHuvzqOuMx74Bhw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ErrShLL5t0c6; Thu, 12 Mar 2026 18:27:30 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fWx1D6GLCzlfl8L;
	Thu, 12 Mar 2026 18:27:28 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>,
	linux-pm@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Deepak Sharma <deepak.sharma.472935@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ming Lei <ming.lei@redhat.com>,
	syzbot+6c905ab800f20cf4086c@syzkaller.appspotmail.com
Subject: [PATCH] PM: runtime: Fix a race condition related to device removal
Date: Thu, 12 Mar 2026 11:27:20 -0700
Message-ID: <20260312182720.2776083-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The following code in pm_runtime_work() may dereference the dev->parent
pointer after the parent device has been freed:

	/* Maybe the parent is now able to suspend. */
	if (parent && !parent->power.ignore_children) {
		spin_unlock(&dev->power.lock);

		spin_lock(&parent->power.lock);
		rpm_idle(parent, RPM_ASYNC);
		spin_unlock(&parent->power.lock);

		spin_lock(&dev->power.lock);
	}

Fix this by inserting a flush_work() call in pm_runtime_remove().

Without this patch blktest block/001 triggers the following complaint
sporadically:

BUG: KASAN: slab-use-after-free in lock_acquire+0x70/0x160
Read of size 1 at addr ffff88812bef7198 by task kworker/u553:1/3081
Workqueue: pm pm_runtime_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x61/0x80
 print_address_description.constprop.0+0x8b/0x310
 print_report+0xfd/0x1d7
 kasan_report+0xd8/0x1d0
 __kasan_check_byte+0x42/0x60
 lock_acquire.part.0+0x38/0x230
 lock_acquire+0x70/0x160
 _raw_spin_lock+0x36/0x50
 rpm_suspend+0xc6a/0xfe0
 rpm_idle+0x578/0x770
 pm_runtime_work+0xee/0x120
 process_one_work+0xde3/0x1410
 worker_thread+0x5eb/0xfe0
 kthread+0x37b/0x480
 ret_from_fork+0x6cb/0x920
 ret_from_fork_asm+0x11/0x20
 </TASK>

Allocated by task 4314:
 kasan_save_stack+0x2a/0x50
 kasan_save_track+0x18/0x40
 kasan_save_alloc_info+0x3d/0x50
 __kasan_kmalloc+0xa0/0xb0
 __kmalloc_noprof+0x311/0x990
 scsi_alloc_target+0x122/0xb60 [scsi_mod]
 __scsi_scan_target+0x101/0x460 [scsi_mod]
 scsi_scan_channel+0x179/0x1c0 [scsi_mod]
 scsi_scan_host_selected+0x259/0x2d0 [scsi_mod]
 store_scan+0x2d2/0x390 [scsi_mod]
 dev_attr_store+0x43/0x80
 sysfs_kf_write+0xde/0x140
 kernfs_fop_write_iter+0x3ef/0x670
 vfs_write+0x506/0x1470
 ksys_write+0xfd/0x230
 __x64_sys_write+0x76/0xc0
 x64_sys_call+0x213/0x1810
 do_syscall_64+0xee/0xfc0
 entry_SYSCALL_64_after_hwframe+0x4b/0x53

Freed by task 4314:
 kasan_save_stack+0x2a/0x50
 kasan_save_track+0x18/0x40
 kasan_save_free_info+0x3f/0x50
 __kasan_slab_free+0x67/0x80
 kfree+0x225/0x6c0
 scsi_target_dev_release+0x3d/0x60 [scsi_mod]
 device_release+0xa3/0x220
 kobject_cleanup+0x105/0x3a0
 kobject_put+0x72/0xd0
 put_device+0x17/0x20
 scsi_device_dev_release+0xacf/0x12c0 [scsi_mod]
 device_release+0xa3/0x220
 kobject_cleanup+0x105/0x3a0
 kobject_put+0x72/0xd0
 put_device+0x17/0x20
 scsi_device_put+0x7f/0xc0 [scsi_mod]
 sdev_store_delete+0xa5/0x120 [scsi_mod]
 dev_attr_store+0x43/0x80
 sysfs_kf_write+0xde/0x140
 kernfs_fop_write_iter+0x3ef/0x670
 vfs_write+0x506/0x1470
 ksys_write+0xfd/0x230
 __x64_sys_write+0x76/0xc0
 x64_sys_call+0x213/0x1810

Cc: Deepak Sharma <deepak.sharma.472935@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reported-by: Ming Lei <ming.lei@redhat.com>
Closes: https://lore.kernel.org/all/ZxdNvLNI8QaOfD2d@fedora/
Reported-by: syzbot+6c905ab800f20cf4086c@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68c13942.050a0220.2ff435.000b.GAE@goo=
gle.com/
Fixes: 5e928f77a09a ("PM: Introduce core framework for run-time PM of I/O=
 devices (rev. 17)")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/base/power/runtime.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 0ee8ea971aa4..335288e8b5b3 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1895,6 +1895,7 @@ void pm_runtime_reinit(struct device *dev)
 void pm_runtime_remove(struct device *dev)
 {
 	__pm_runtime_disable(dev, false);
+	flush_work(&dev->power.work);
 	pm_runtime_reinit(dev);
 }
=20
