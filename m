From: Jiri Kosina <jikos@kernel.org>
Subject: [PATCH 2/3] freezer: get rid of the kthread freezer
Date: Fri, 30 Oct 2015 14:47:45 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1510301440400.17538@pobox.suse.cz>
References: <alpine.LNX.2.00.1510301424360.17538@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1510301424360.17538@pobox.suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@ZenIV.linux.org.uk>, Tejun Heo <tj@kernel.org>, Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

Now that hibernation performs fs freezing, we can get rid of kthread freezing
altogether.

This patch can even be used to demonstrate why the current kthread freezing is
an absolutely horrible API -- there are many kthreads that have gotten it wrong
since ever; they are often either not freezable, but issue the try_to_freeze()
call anyway or they set itself freezable, but never ever attempt to freeze
themselves.

Plus, it's being misused completely by all those kthreads which don't
participate in filesystem I/O at all.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 arch/powerpc/platforms/83xx/suspend.c            |  1 -
 arch/powerpc/platforms/powernv/opal.c            |  2 -
 arch/powerpc/platforms/ps3/device-init.c         |  1 -
 drivers/acpi/acpi_pad.c                          |  2 -
 drivers/android/binder.c                         |  4 +-
 drivers/block/pktcdvd.c                          |  4 --
 drivers/block/xen-blkback/blkback.c              |  2 -
 drivers/dma/dmatest.c                            |  6 +--
 drivers/macintosh/therm_adt746x.c                |  2 -
 drivers/macintosh/windfarm_core.c                |  2 -
 drivers/md/bcache/alloc.c                        |  1 -
 drivers/md/bcache/btree.c                        |  1 -
 drivers/md/bcache/writeback.c                    |  2 -
 drivers/md/dm-log-writes.c                       | 12 +++---
 drivers/media/dvb-core/dvb_frontend.c            |  4 --
 drivers/media/i2c/msp3400-driver.c               |  1 -
 drivers/media/i2c/msp3400-kthreads.c             |  3 --
 drivers/media/i2c/tvaudio.c                      |  2 -
 drivers/media/pci/cx88/cx88-tvaudio.c            |  2 -
 drivers/media/pci/pt1/pt1.c                      |  2 -
 drivers/media/pci/pt3/pt3.c                      |  1 -
 drivers/media/pci/saa7134/saa7134-tvaudio.c      |  8 ----
 drivers/media/pci/saa7164/saa7164-core.c         |  3 --
 drivers/media/pci/solo6x10/solo6x10-v4l2-enc.c   |  2 -
 drivers/media/pci/solo6x10/solo6x10-v4l2.c       |  2 -
 drivers/media/platform/vivid/vivid-kthread-cap.c |  3 --
 drivers/media/platform/vivid/vivid-kthread-out.c |  3 --
 drivers/media/platform/vivid/vivid-sdr-cap.c     |  3 --
 drivers/media/usb/pvrusb2/pvrusb2-dvb.c          |  4 --
 drivers/media/v4l2-core/videobuf-dvb.c           |  2 -
 drivers/media/v4l2-core/videobuf2-core.c         |  3 --
 drivers/mfd/ucb1x00-ts.c                         |  1 -
 drivers/mtd/ubi/wl.c                             |  4 --
 drivers/net/irda/stir4200.c                      |  2 -
 drivers/net/wireless/airo.c                      |  2 -
 drivers/pcmcia/cs.c                              |  2 -
 drivers/platform/x86/thinkpad_acpi.c             |  2 -
 drivers/pnp/pnpbios/core.c                       |  4 --
 drivers/power/tps65090-charger.c                 |  3 --
 drivers/staging/android/ion/ion_heap.c           |  2 +-
 drivers/thermal/intel_powerclamp.c               |  2 -
 drivers/tty/hvc/hvc_console.c                    |  2 -
 drivers/usb/atm/ueagle-atm.c                     |  2 -
 drivers/usb/gadget/function/f_mass_storage.c     | 25 +++++-------
 drivers/uwb/uwbd.c                               |  1 -
 drivers/video/fbdev/ps3fb.c                      |  2 -
 drivers/video/fbdev/pxafb.c                      |  4 --
 drivers/virtio/virtio_balloon.c                  |  3 --
 drivers/w1/w1.c                                  |  1 -
 fs/btrfs/disk-io.c                               | 16 ++++----
 fs/cifs/connect.c                                |  5 ---
 fs/ecryptfs/kthread.c                            |  3 +-
 fs/ext4/super.c                                  |  2 -
 fs/f2fs/gc.c                                     |  9 ++---
 fs/gfs2/log.c                                    |  2 -
 fs/gfs2/quota.c                                  |  2 -
 fs/jbd2/journal.c                                |  3 --
 fs/jffs2/background.c                            |  4 --
 fs/jfs/jfs_logmgr.c                              |  1 -
 fs/jfs/jfs_txnmgr.c                              | 28 +++++--------
 fs/lockd/svc.c                                   |  3 --
 fs/nfs/callback.c                                |  6 ---
 fs/nfsd/nfssvc.c                                 |  2 -
 fs/nilfs2/segment.c                              | 50 +++++++++++-------------
 fs/ubifs/commit.c                                |  4 --
 fs/xfs/xfs_trans_ail.c                           |  2 -
 kernel/audit.c                                   |  3 +-
 kernel/kthread.c                                 |  1 -
 mm/huge_memory.c                                 |  7 ++--
 mm/ksm.c                                         |  5 +--
 mm/vmscan.c                                      | 14 +++----
 net/core/pktgen.c                                |  5 ---
 net/sunrpc/svc_xprt.c                            |  1 -
 73 files changed, 72 insertions(+), 260 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/suspend.c b/arch/powerpc/platforms/83xx/suspend.c
index fcbea4b..4ca1e06f 100644
--- a/arch/powerpc/platforms/83xx/suspend.c
+++ b/arch/powerpc/platforms/83xx/suspend.c
@@ -266,7 +266,6 @@ static int agent_thread_fn(void *data)
 {
 	while (1) {
 		wait_event_interruptible(agent_wq, pci_pm_state >= 2);
-		try_to_freeze();
 
 		if (signal_pending(current) || pci_pm_state < 2)
 			continue;
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 4296d55..ea0fd8b 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -662,9 +662,7 @@ static int kopald(void *unused)
 {
 	__be64 events;
 
-	set_freezable();
 	do {
-		try_to_freeze();
 		opal_poll_events(&events);
 		opal_handle_events(be64_to_cpu(events));
 		msleep_interruptible(opal_heartbeat);
diff --git a/arch/powerpc/platforms/ps3/device-init.c b/arch/powerpc/platforms/ps3/device-init.c
index 3f175e8..059b013 100644
--- a/arch/powerpc/platforms/ps3/device-init.c
+++ b/arch/powerpc/platforms/ps3/device-init.c
@@ -843,7 +843,6 @@ static int ps3_probe_thread(void *data)
 
 	/* Loop here processing the requested notification events. */
 	do {
-		try_to_freeze();
 
 		memset(notify_event, 0, sizeof(*notify_event));
 
diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index ae307ff..8ea8211 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -148,8 +148,6 @@ static int power_saving_thread(void *data)
 	while (!kthread_should_stop()) {
 		unsigned long expire_time;
 
-		try_to_freeze();
-
 		/* round robin to cpus */
 		expire_time = last_jiffies + round_robin_time * HZ;
 		if (time_before(expire_time, jiffies)) {
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index a39e85f..7645f1d 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2202,13 +2202,13 @@ retry:
 			if (!binder_has_proc_work(proc, thread))
 				ret = -EAGAIN;
 		} else
-			ret = wait_event_freezable_exclusive(proc->wait, binder_has_proc_work(proc, thread));
+			ret = wait_event_interruptible_exclusive(proc->wait, binder_has_proc_work(proc, thread));
 	} else {
 		if (non_block) {
 			if (!binder_has_thread_work(thread))
 				ret = -EAGAIN;
 		} else
-			ret = wait_event_freezable(thread->wait, binder_has_thread_work(thread));
+			ret = wait_event_interruptible(thread->wait, binder_has_thread_work(thread));
 	}
 
 	binder_lock(__func__);
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 7be2375..e057373 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -1466,7 +1466,6 @@ static int kcdrwd(void *foobar)
 	long min_sleep_time, residue;
 
 	set_user_nice(current, MIN_NICE);
-	set_freezable();
 
 	for (;;) {
 		DECLARE_WAITQUEUE(wait, current);
@@ -1511,9 +1510,6 @@ static int kcdrwd(void *foobar)
 			residue = schedule_timeout(min_sleep_time);
 			pkt_dbg(2, pd, "wake up\n");
 
-			/* make swsusp happy with our thread */
-			try_to_freeze();
-
 			list_for_each_entry(pkt, &pd->cdrw.pkt_active_list, list) {
 				if (!pkt->sleep_time)
 					continue;
diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index 6a685ae..af3caa3 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -598,8 +598,6 @@ int xen_blkif_schedule(void *arg)
 	xen_blkif_get(blkif);
 
 	while (!kthread_should_stop()) {
-		if (try_to_freeze())
-			continue;
 		if (unlikely(vbd->size != vbd_sz(vbd)))
 			xen_vbd_resize(blkif);
 
diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index b8576fd..fa569fb 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -316,7 +316,7 @@ static unsigned int dmatest_verify(u8 **bufs, unsigned int start,
 	return error_count;
 }
 
-/* poor man's completion - we want to use wait_event_freezable() on it */
+/* poor man's completion - we want to use wait_event_interruptible() on it */
 struct dmatest_done {
 	bool			done;
 	wait_queue_head_t	*wait;
@@ -420,8 +420,6 @@ static int dmatest_func(void *data)
 	s64			runtime = 0;
 	unsigned long long	total_len = 0;
 
-	set_freezable();
-
 	ret = -ENOMEM;
 
 	smp_rmb();
@@ -620,7 +618,7 @@ static int dmatest_func(void *data)
 		}
 		dma_async_issue_pending(chan);
 
-		wait_event_freezable_timeout(done_wait, done.done,
+		wait_event_interruptible_timeout(done_wait, done.done,
 					     msecs_to_jiffies(params->timeout));
 
 		status = dma_async_is_tx_complete(chan, cookie, NULL, NULL);
diff --git a/drivers/macintosh/therm_adt746x.c b/drivers/macintosh/therm_adt746x.c
index f433521..94704be 100644
--- a/drivers/macintosh/therm_adt746x.c
+++ b/drivers/macintosh/therm_adt746x.c
@@ -282,9 +282,7 @@ static int monitor_task(void *arg)
 {
 	struct thermostat* th = arg;
 
-	set_freezable();
 	while(!kthread_should_stop()) {
-		try_to_freeze();
 		msleep_interruptible(2000);
 
 #ifndef DEBUG
diff --git a/drivers/macintosh/windfarm_core.c b/drivers/macintosh/windfarm_core.c
index 465d770..5683d6c 100644
--- a/drivers/macintosh/windfarm_core.c
+++ b/drivers/macintosh/windfarm_core.c
@@ -93,9 +93,7 @@ static int wf_thread_func(void *data)
 
 	DBG("wf: thread started\n");
 
-	set_freezable();
 	while (!kthread_should_stop()) {
-		try_to_freeze();
 
 		if (time_after_eq(jiffies, next)) {
 			wf_notify(WF_EVENT_TICK, NULL);
diff --git a/drivers/md/bcache/alloc.c b/drivers/md/bcache/alloc.c
index 8eeab72..ffb7178 100644
--- a/drivers/md/bcache/alloc.c
+++ b/drivers/md/bcache/alloc.c
@@ -288,7 +288,6 @@ do {									\
 		if (kthread_should_stop())				\
 			return 0;					\
 									\
-		try_to_freeze();					\
 		schedule();						\
 		mutex_lock(&(ca)->set->bucket_lock);			\
 	}								\
diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 83392f8..c906d51 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -1786,7 +1786,6 @@ again:
 
 		mutex_unlock(&c->bucket_lock);
 
-		try_to_freeze();
 		schedule();
 	}
 
diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
index b23f88d..28248cd 100644
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -228,7 +228,6 @@ static void read_dirty(struct cached_dev *dc)
 	 */
 
 	while (!kthread_should_stop()) {
-		try_to_freeze();
 
 		w = bch_keybuf_next(&dc->writeback_keys);
 		if (!w)
@@ -410,7 +409,6 @@ static int bch_writeback_thread(void *arg)
 			if (kthread_should_stop())
 				return 0;
 
-			try_to_freeze();
 			schedule();
 			continue;
 		}
diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
index b2912db..fc8f377 100644
--- a/drivers/md/dm-log-writes.c
+++ b/drivers/md/dm-log-writes.c
@@ -397,13 +397,11 @@ next:
 			continue;
 		}
 
-		if (!try_to_freeze()) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			if (!kthread_should_stop() &&
-			    !atomic_read(&lc->pending_blocks))
-				schedule();
-			__set_current_state(TASK_RUNNING);
-		}
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (!kthread_should_stop() &&
+		    !atomic_read(&lc->pending_blocks))
+			schedule();
+		__set_current_state(TASK_RUNNING);
 	}
 	return 0;
 }
diff --git a/drivers/media/dvb-core/dvb_frontend.c b/drivers/media/dvb-core/dvb_frontend.c
index c38ef1a..a2bd323 100644
--- a/drivers/media/dvb-core/dvb_frontend.c
+++ b/drivers/media/dvb-core/dvb_frontend.c
@@ -725,7 +725,6 @@ static int dvb_frontend_thread(void *data)
 
 	dvb_frontend_init(fe);
 
-	set_freezable();
 	while (1) {
 		up(&fepriv->sem);	    /* is locked when we enter the thread... */
 restart:
@@ -742,9 +741,6 @@ restart:
 			break;
 		}
 
-		if (try_to_freeze())
-			goto restart;
-
 		if (down_interruptible(&fepriv->sem))
 			break;
 
diff --git a/drivers/media/i2c/msp3400-driver.c b/drivers/media/i2c/msp3400-driver.c
index bdb9400..884a1a3 100644
--- a/drivers/media/i2c/msp3400-driver.c
+++ b/drivers/media/i2c/msp3400-driver.c
@@ -339,7 +339,6 @@ int msp_sleep(struct msp_state *state, int timeout)
 	}
 
 	remove_wait_queue(&state->wq, &wait);
-	try_to_freeze();
 	return state->restart;
 }
 
diff --git a/drivers/media/i2c/msp3400-kthreads.c b/drivers/media/i2c/msp3400-kthreads.c
index f8b5171..febcb62 100644
--- a/drivers/media/i2c/msp3400-kthreads.c
+++ b/drivers/media/i2c/msp3400-kthreads.c
@@ -510,7 +510,6 @@ int msp3400c_thread(void *data)
 
 	v4l_dbg(1, msp_debug, client, "msp3400 daemon started\n");
 	state->detected_std = V4L2_STD_ALL;
-	set_freezable();
 	for (;;) {
 		v4l_dbg(2, msp_debug, client, "msp3400 thread: sleep\n");
 		msp_sleep(state, -1);
@@ -700,7 +699,6 @@ int msp3410d_thread(void *data)
 
 	v4l_dbg(1, msp_debug, client, "msp3410 daemon started\n");
 	state->detected_std = V4L2_STD_ALL;
-	set_freezable();
 	for (;;) {
 		v4l_dbg(2, msp_debug, client, "msp3410 thread: sleep\n");
 		msp_sleep(state, -1);
@@ -998,7 +996,6 @@ int msp34xxg_thread(void *data)
 
 	v4l_dbg(1, msp_debug, client, "msp34xxg daemon started\n");
 	state->detected_std = V4L2_STD_ALL;
-	set_freezable();
 	for (;;) {
 		v4l_dbg(2, msp_debug, client, "msp34xxg thread: sleep\n");
 		msp_sleep(state, -1);
diff --git a/drivers/media/i2c/tvaudio.c b/drivers/media/i2c/tvaudio.c
index 2a8114a..70fc264 100644
--- a/drivers/media/i2c/tvaudio.c
+++ b/drivers/media/i2c/tvaudio.c
@@ -314,13 +314,11 @@ static int chip_thread(void *data)
 	int mode, selected;
 
 	v4l2_dbg(1, debug, sd, "thread started\n");
-	set_freezable();
 	for (;;) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		if (!kthread_should_stop())
 			schedule();
 		set_current_state(TASK_RUNNING);
-		try_to_freeze();
 		if (kthread_should_stop())
 			break;
 		v4l2_dbg(1, debug, sd, "thread wakeup\n");
diff --git a/drivers/media/pci/cx88/cx88-tvaudio.c b/drivers/media/pci/cx88/cx88-tvaudio.c
index 6bbce6a..2a4d2b0 100644
--- a/drivers/media/pci/cx88/cx88-tvaudio.c
+++ b/drivers/media/pci/cx88/cx88-tvaudio.c
@@ -992,12 +992,10 @@ int cx88_audio_thread(void *data)
 	u32 mode = 0;
 
 	dprintk("cx88: tvaudio thread started\n");
-	set_freezable();
 	for (;;) {
 		msleep_interruptible(1000);
 		if (kthread_should_stop())
 			break;
-		try_to_freeze();
 
 		switch (core->tvaudio) {
 		case WW_BG:
diff --git a/drivers/media/pci/pt1/pt1.c b/drivers/media/pci/pt1/pt1.c
index e7e4428..27c9d86 100644
--- a/drivers/media/pci/pt1/pt1.c
+++ b/drivers/media/pci/pt1/pt1.c
@@ -317,10 +317,8 @@ static int pt1_thread(void *data)
 	struct pt1_buffer_page *page;
 
 	pt1 = data;
-	set_freezable();
 
 	while (!kthread_should_stop()) {
-		try_to_freeze();
 
 		page = pt1->tables[pt1->table_index].bufs[pt1->buf_index].page;
 		if (!pt1_filter(pt1, page)) {
diff --git a/drivers/media/pci/pt3/pt3.c b/drivers/media/pci/pt3/pt3.c
index 0d2e2b2..cd67325 100644
--- a/drivers/media/pci/pt3/pt3.c
+++ b/drivers/media/pci/pt3/pt3.c
@@ -455,7 +455,6 @@ static int pt3_fetch_thread(void *data)
 
 	dev_dbg(adap->dvb_adap.device, "PT3: [%s] started\n",
 		adap->thread->comm);
-	set_freezable();
 	while (!kthread_freezable_should_stop(&was_frozen)) {
 		if (was_frozen)
 			adap->num_discard = PT3_INITIAL_BUF_DROPS;
diff --git a/drivers/media/pci/saa7134/saa7134-tvaudio.c b/drivers/media/pci/saa7134/saa7134-tvaudio.c
index 21a5793..6316b85 100644
--- a/drivers/media/pci/saa7134/saa7134-tvaudio.c
+++ b/drivers/media/pci/saa7134/saa7134-tvaudio.c
@@ -477,15 +477,12 @@ static int tvaudio_thread(void *data)
 	unsigned int i, audio, nscan;
 	int max1,max2,carrier,rx,mode,lastmode,default_carrier;
 
-	set_freezable();
-
 	for (;;) {
 		tvaudio_sleep(dev,-1);
 		if (kthread_should_stop())
 			goto done;
 
 	restart:
-		try_to_freeze();
 
 		dev->thread.scan1 = dev->thread.scan2;
 		audio_dbg(1, "tvaudio thread scan start [%d]\n",
@@ -596,8 +593,6 @@ static int tvaudio_thread(void *data)
 		lastmode = 42;
 		for (;;) {
 
-			try_to_freeze();
-
 			if (tvaudio_sleep(dev,5000))
 				goto restart;
 			if (kthread_should_stop())
@@ -774,14 +769,11 @@ static int tvaudio_thread_ddep(void *data)
 	struct saa7134_dev *dev = data;
 	u32 value, norms;
 
-	set_freezable();
 	for (;;) {
 		tvaudio_sleep(dev,-1);
 		if (kthread_should_stop())
 			goto done;
 	restart:
-		try_to_freeze();
-
 		dev->thread.scan1 = dev->thread.scan2;
 		audio_dbg(1, "tvaudio thread scan start [%d]\n",
 			  dev->thread.scan1);
diff --git a/drivers/media/pci/saa7164/saa7164-core.c b/drivers/media/pci/saa7164/saa7164-core.c
index 3206a82..7f1f493 100644
--- a/drivers/media/pci/saa7164/saa7164-core.c
+++ b/drivers/media/pci/saa7164/saa7164-core.c
@@ -1164,13 +1164,10 @@ static int saa7164_thread_function(void *data)
 
 	dprintk(DBGLVL_THR, "thread started\n");
 
-	set_freezable();
-
 	while (1) {
 		msleep_interruptible(100);
 		if (kthread_should_stop())
 			break;
-		try_to_freeze();
 
 		dprintk(DBGLVL_THR, "thread running\n");
 
diff --git a/drivers/media/pci/solo6x10/solo6x10-v4l2-enc.c b/drivers/media/pci/solo6x10/solo6x10-v4l2-enc.c
index 53fff54..d229944 100644
--- a/drivers/media/pci/solo6x10/solo6x10-v4l2-enc.c
+++ b/drivers/media/pci/solo6x10/solo6x10-v4l2-enc.c
@@ -641,7 +641,6 @@ static int solo_ring_thread(void *data)
 	struct solo_dev *solo_dev = data;
 	DECLARE_WAITQUEUE(wait, current);
 
-	set_freezable();
 	add_wait_queue(&solo_dev->ring_thread_wait, &wait);
 
 	for (;;) {
@@ -650,7 +649,6 @@ static int solo_ring_thread(void *data)
 		if (timeout == -ERESTARTSYS || kthread_should_stop())
 			break;
 		solo_handle_ring(solo_dev);
-		try_to_freeze();
 	}
 
 	remove_wait_queue(&solo_dev->ring_thread_wait, &wait);
diff --git a/drivers/media/pci/solo6x10/solo6x10-v4l2.c b/drivers/media/pci/solo6x10/solo6x10-v4l2.c
index 63ae8a6..8e67881 100644
--- a/drivers/media/pci/solo6x10/solo6x10-v4l2.c
+++ b/drivers/media/pci/solo6x10/solo6x10-v4l2.c
@@ -268,7 +268,6 @@ static int solo_thread(void *data)
 	struct solo_dev *solo_dev = data;
 	DECLARE_WAITQUEUE(wait, current);
 
-	set_freezable();
 	add_wait_queue(&solo_dev->disp_thread_wait, &wait);
 
 	for (;;) {
@@ -277,7 +276,6 @@ static int solo_thread(void *data)
 		if (timeout == -ERESTARTSYS || kthread_should_stop())
 			break;
 		solo_thread_try(solo_dev);
-		try_to_freeze();
 	}
 
 	remove_wait_queue(&solo_dev->disp_thread_wait, &wait);
diff --git a/drivers/media/platform/vivid/vivid-kthread-cap.c b/drivers/media/platform/vivid/vivid-kthread-cap.c
index 1727f54..08f6fe4 100644
--- a/drivers/media/platform/vivid/vivid-kthread-cap.c
+++ b/drivers/media/platform/vivid/vivid-kthread-cap.c
@@ -745,8 +745,6 @@ static int vivid_thread_vid_cap(void *data)
 
 	dprintk(dev, 1, "Video Capture Thread Start\n");
 
-	set_freezable();
-
 	/* Resets frame counters */
 	dev->cap_seq_offset = 0;
 	dev->cap_seq_count = 0;
@@ -754,7 +752,6 @@ static int vivid_thread_vid_cap(void *data)
 	dev->jiffies_vid_cap = jiffies;
 
 	for (;;) {
-		try_to_freeze();
 		if (kthread_should_stop())
 			break;
 
diff --git a/drivers/media/platform/vivid/vivid-kthread-out.c b/drivers/media/platform/vivid/vivid-kthread-out.c
index d9f36cc..ea76749 100644
--- a/drivers/media/platform/vivid/vivid-kthread-out.c
+++ b/drivers/media/platform/vivid/vivid-kthread-out.c
@@ -132,8 +132,6 @@ static int vivid_thread_vid_out(void *data)
 
 	dprintk(dev, 1, "Video Output Thread Start\n");
 
-	set_freezable();
-
 	/* Resets frame counters */
 	dev->out_seq_offset = 0;
 	if (dev->seq_wrap)
@@ -143,7 +141,6 @@ static int vivid_thread_vid_out(void *data)
 	dev->out_seq_resync = false;
 
 	for (;;) {
-		try_to_freeze();
 		if (kthread_should_stop())
 			break;
 
diff --git a/drivers/media/platform/vivid/vivid-sdr-cap.c b/drivers/media/platform/vivid/vivid-sdr-cap.c
index d2f2188..15d6d02 100644
--- a/drivers/media/platform/vivid/vivid-sdr-cap.c
+++ b/drivers/media/platform/vivid/vivid-sdr-cap.c
@@ -136,8 +136,6 @@ static int vivid_thread_sdr_cap(void *data)
 
 	dprintk(dev, 1, "SDR Capture Thread Start\n");
 
-	set_freezable();
-
 	/* Resets frame counters */
 	dev->sdr_cap_seq_offset = 0;
 	if (dev->seq_wrap)
@@ -146,7 +144,6 @@ static int vivid_thread_sdr_cap(void *data)
 	dev->sdr_cap_seq_resync = false;
 
 	for (;;) {
-		try_to_freeze();
 		if (kthread_should_stop())
 			break;
 
diff --git a/drivers/media/usb/pvrusb2/pvrusb2-dvb.c b/drivers/media/usb/pvrusb2/pvrusb2-dvb.c
index 8c95793..5d70953 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-dvb.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-dvb.c
@@ -39,16 +39,12 @@ static int pvr2_dvb_feed_func(struct pvr2_dvb_adapter *adap)
 	struct pvr2_stream *stream;
 
 	pvr2_trace(PVR2_TRACE_DVB_FEED, "dvb feed thread started");
-	set_freezable();
 
 	stream = adap->channel.stream->stream;
 
 	for (;;) {
 		if (kthread_should_stop()) break;
 
-		/* Not sure about this... */
-		try_to_freeze();
-
 		bp = pvr2_stream_get_ready_buffer(stream);
 		if (bp != NULL) {
 			count = pvr2_buffer_get_count(bp);
diff --git a/drivers/media/v4l2-core/videobuf-dvb.c b/drivers/media/v4l2-core/videobuf-dvb.c
index b7efa45..3413e51 100644
--- a/drivers/media/v4l2-core/videobuf-dvb.c
+++ b/drivers/media/v4l2-core/videobuf-dvb.c
@@ -48,7 +48,6 @@ static int videobuf_dvb_thread(void *data)
 	void *outp;
 
 	dprintk("dvb thread started\n");
-	set_freezable();
 	videobuf_read_start(&dvb->dvbq);
 
 	for (;;) {
@@ -63,7 +62,6 @@ static int videobuf_dvb_thread(void *data)
 			break;
 		if (kthread_should_stop())
 			break;
-		try_to_freeze();
 
 		/* feed buffer data to demux */
 		outp = videobuf_queue_to_vaddr(&dvb->dvbq, buf);
diff --git a/drivers/media/v4l2-core/videobuf2-core.c b/drivers/media/v4l2-core/videobuf2-core.c
index 4f59b7e..d1107b4 100644
--- a/drivers/media/v4l2-core/videobuf2-core.c
+++ b/drivers/media/v4l2-core/videobuf2-core.c
@@ -3212,8 +3212,6 @@ static int vb2_thread(void *data)
 			V4L2_BUF_FLAG_TIMESTAMP_COPY;
 	}
 
-	set_freezable();
-
 	for (;;) {
 		struct vb2_buffer *vb;
 
@@ -3235,7 +3233,6 @@ static int vb2_thread(void *data)
 		}
 		if (ret || threadio->stop)
 			break;
-		try_to_freeze();
 
 		vb = q->bufs[fileio->b.index];
 		if (!(fileio->b.flags & V4L2_BUF_FLAG_ERROR))
diff --git a/drivers/mfd/ucb1x00-ts.c b/drivers/mfd/ucb1x00-ts.c
index 1e0e20c..250e941 100644
--- a/drivers/mfd/ucb1x00-ts.c
+++ b/drivers/mfd/ucb1x00-ts.c
@@ -211,7 +211,6 @@ static int ucb1x00_thread(void *_ts)
 	bool frozen, ignore = false;
 	int valid = 0;
 
-	set_freezable();
 	add_wait_queue(&ts->irq_wait, &wait);
 	while (!kthread_freezable_should_stop(&frozen)) {
 		unsigned int x, y, p;
diff --git a/drivers/mtd/ubi/wl.c b/drivers/mtd/ubi/wl.c
index eb4489f9..138fa35 100644
--- a/drivers/mtd/ubi/wl.c
+++ b/drivers/mtd/ubi/wl.c
@@ -1415,16 +1415,12 @@ int ubi_thread(void *u)
 	ubi_msg(ubi, "background thread \"%s\" started, PID %d",
 		ubi->bgt_name, task_pid_nr(current));
 
-	set_freezable();
 	for (;;) {
 		int err;
 
 		if (kthread_should_stop())
 			break;
 
-		if (try_to_freeze())
-			continue;
-
 		spin_lock(&ubi->wl_lock);
 		if (list_empty(&ubi->works) || ubi->ro_mode ||
 		    !ubi->thread_enabled || ubi_dbg_is_bgt_disabled(ubi)) {
diff --git a/drivers/net/irda/stir4200.c b/drivers/net/irda/stir4200.c
index 83cc48a..3d5b311 100644
--- a/drivers/net/irda/stir4200.c
+++ b/drivers/net/irda/stir4200.c
@@ -747,8 +747,6 @@ static int stir_transmit_thread(void *arg)
 
 			write_reg(stir, REG_CTRL1, CTRL1_TXPWD|CTRL1_RXPWD);
 
-			try_to_freeze();
-
 			if (change_speed(stir, stir->speed))
 				break;
 		}
diff --git a/drivers/net/wireless/airo.c b/drivers/net/wireless/airo.c
index d0c97c2..addc3d6 100644
--- a/drivers/net/wireless/airo.c
+++ b/drivers/net/wireless/airo.c
@@ -3062,10 +3062,8 @@ static int airo_thread(void *data) {
 	struct airo_info *ai = dev->ml_priv;
 	int locked;
 
-	set_freezable();
 	while(1) {
 		/* make swsusp happy with our thread */
-		try_to_freeze();
 
 		if (test_bit(JOB_DIE, &ai->jobs))
 			break;
diff --git a/drivers/pcmcia/cs.c b/drivers/pcmcia/cs.c
index c3b615c..96302df 100644
--- a/drivers/pcmcia/cs.c
+++ b/drivers/pcmcia/cs.c
@@ -615,7 +615,6 @@ static int pccardd(void *__skt)
 	/* wait for userspace to catch up */
 	msleep(250);
 
-	set_freezable();
 	for (;;) {
 		unsigned long flags;
 		unsigned int events;
@@ -675,7 +674,6 @@ static int pccardd(void *__skt)
 		/* make sure we are running */
 		__set_current_state(TASK_RUNNING);
 
-		try_to_freeze();
 	}
 
 	/* shut down socket, if a device is still present */
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 131dd74..45fef60 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -2485,8 +2485,6 @@ static int hotkey_kthread(void *data)
 	if (tpacpi_lifecycle == TPACPI_LIFE_EXITING)
 		goto exit;
 
-	set_freezable();
-
 	so = 0;
 	si = 1;
 	t = 0;
diff --git a/drivers/pnp/pnpbios/core.c b/drivers/pnp/pnpbios/core.c
index facd43b..7695223 100644
--- a/drivers/pnp/pnpbios/core.c
+++ b/drivers/pnp/pnpbios/core.c
@@ -153,7 +153,6 @@ static int pnp_dock_thread(void *unused)
 	static struct pnp_docking_station_info now;
 	int docked = -1, d = 0;
 
-	set_freezable();
 	while (1) {
 		int status;
 
@@ -162,9 +161,6 @@ static int pnp_dock_thread(void *unused)
 		 */
 		msleep_interruptible(2000);
 
-		if (try_to_freeze())
-			continue;
-
 		status = pnp_bios_dock_station_info(&now);
 
 		switch (status) {
diff --git a/drivers/power/tps65090-charger.c b/drivers/power/tps65090-charger.c
index 7e8fbd2..adf4f07 100644
--- a/drivers/power/tps65090-charger.c
+++ b/drivers/power/tps65090-charger.c
@@ -218,11 +218,8 @@ static struct tps65090_platform_data *
 
 static int tps65090_charger_poll_task(void *data)
 {
-	set_freezable();
-
 	while (!kthread_should_stop()) {
 		schedule_timeout_interruptible(POLL_INTERVAL);
-		try_to_freeze();
 		tps65090_charger_isr(-1, data);
 	}
 	return 0;
diff --git a/drivers/staging/android/ion/ion_heap.c b/drivers/staging/android/ion/ion_heap.c
index fd13d05..f675b3f 100644
--- a/drivers/staging/android/ion/ion_heap.c
+++ b/drivers/staging/android/ion/ion_heap.c
@@ -229,7 +229,7 @@ static int ion_heap_deferred_free(void *data)
 	while (true) {
 		struct ion_buffer *buffer;
 
-		wait_event_freezable(heap->waitqueue,
+		wait_event_interruptible(heap->waitqueue,
 				     ion_heap_freelist_size(heap) > 0);
 
 		spin_lock(&heap->free_lock);
diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
index 6c79588..36ce4660 100644
--- a/drivers/thermal/intel_powerclamp.c
+++ b/drivers/thermal/intel_powerclamp.c
@@ -379,7 +379,6 @@ static int clamp_thread(void *arg)
 	unsigned int target_ratio;
 
 	set_bit(cpunr, cpu_clamping_mask);
-	set_freezable();
 	init_timer_on_stack(&wakeup_timer);
 	sched_setscheduler(current, SCHED_FIFO, &param);
 
@@ -393,7 +392,6 @@ static int clamp_thread(void *arg)
 		unsigned int duration_jiffies = msecs_to_jiffies(duration);
 		unsigned int window_size_now;
 
-		try_to_freeze();
 		/*
 		 * make sure user selected ratio does not take effect until
 		 * the next round. adjust target_ratio if user has changed
diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 4e9c4cc..764a671 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -740,11 +740,9 @@ static int khvcd(void *unused)
 	int poll_mask;
 	struct hvc_struct *hp;
 
-	set_freezable();
 	do {
 		poll_mask = 0;
 		hvc_kicked = 0;
-		try_to_freeze();
 		wmb();
 		if (!cpus_are_in_xmon()) {
 			spin_lock(&hvc_structs_lock);
diff --git a/drivers/usb/atm/ueagle-atm.c b/drivers/usb/atm/ueagle-atm.c
index a2ae88d..3773711 100644
--- a/drivers/usb/atm/ueagle-atm.c
+++ b/drivers/usb/atm/ueagle-atm.c
@@ -1930,7 +1930,6 @@ static int uea_kthread(void *data)
 	struct uea_softc *sc = data;
 	int ret = -EAGAIN;
 
-	set_freezable();
 	uea_enters(INS_TO_USBDEV(sc));
 	while (!kthread_should_stop()) {
 		if (ret < 0 || sc->reset)
@@ -1939,7 +1938,6 @@ static int uea_kthread(void *data)
 			ret = sc->stat(sc);
 		if (ret != -EAGAIN)
 			uea_wait(sc, 0, msecs_to_jiffies(1000));
-		try_to_freeze();
 	}
 	uea_leaves(INS_TO_USBDEV(sc));
 	return ret;
diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
index a6eb537..025c000 100644
--- a/drivers/usb/gadget/function/f_mass_storage.c
+++ b/drivers/usb/gadget/function/f_mass_storage.c
@@ -611,14 +611,12 @@ static bool start_out_transfer(struct fsg_common *common, struct fsg_buffhd *bh)
 	return true;
 }
 
-static int sleep_thread(struct fsg_common *common, bool can_freeze)
+static int sleep_thread(struct fsg_common *common)
 {
 	int	rc = 0;
 
 	/* Wait until a signal arrives or we are woken up */
 	for (;;) {
-		if (can_freeze)
-			try_to_freeze();
 		set_current_state(TASK_INTERRUPTIBLE);
 		if (signal_pending(current)) {
 			rc = -EINTR;
@@ -692,7 +690,7 @@ static int do_read(struct fsg_common *common)
 		/* Wait for the next buffer to become available */
 		bh = common->next_buffhd_to_fill;
 		while (bh->state != BUF_STATE_EMPTY) {
-			rc = sleep_thread(common, false);
+			rc = sleep_thread(common);
 			if (rc)
 				return rc;
 		}
@@ -947,7 +945,7 @@ static int do_write(struct fsg_common *common)
 		}
 
 		/* Wait for something to happen */
-		rc = sleep_thread(common, false);
+		rc = sleep_thread(common);
 		if (rc)
 			return rc;
 	}
@@ -1514,7 +1512,7 @@ static int throw_away_data(struct fsg_common *common)
 		}
 
 		/* Otherwise wait for something to happen */
-		rc = sleep_thread(common, true);
+		rc = sleep_thread(common);
 		if (rc)
 			return rc;
 	}
@@ -1635,7 +1633,7 @@ static int send_status(struct fsg_common *common)
 	/* Wait for the next buffer to become available */
 	bh = common->next_buffhd_to_fill;
 	while (bh->state != BUF_STATE_EMPTY) {
-		rc = sleep_thread(common, true);
+		rc = sleep_thread(common);
 		if (rc)
 			return rc;
 	}
@@ -1838,7 +1836,7 @@ static int do_scsi_command(struct fsg_common *common)
 	bh = common->next_buffhd_to_fill;
 	common->next_buffhd_to_drain = bh;
 	while (bh->state != BUF_STATE_EMPTY) {
-		rc = sleep_thread(common, true);
+		rc = sleep_thread(common);
 		if (rc)
 			return rc;
 	}
@@ -2185,7 +2183,7 @@ static int get_next_command(struct fsg_common *common)
 	/* Wait for the next buffer to become available */
 	bh = common->next_buffhd_to_fill;
 	while (bh->state != BUF_STATE_EMPTY) {
-		rc = sleep_thread(common, true);
+		rc = sleep_thread(common);
 		if (rc)
 			return rc;
 	}
@@ -2204,7 +2202,7 @@ static int get_next_command(struct fsg_common *common)
 
 	/* Wait for the CBW to arrive */
 	while (bh->state != BUF_STATE_FULL) {
-		rc = sleep_thread(common, true);
+		rc = sleep_thread(common);
 		if (rc)
 			return rc;
 	}
@@ -2390,7 +2388,7 @@ static void handle_exception(struct fsg_common *common)
 			}
 			if (num_active == 0)
 				break;
-			if (sleep_thread(common, true))
+			if (sleep_thread(common))
 				return;
 		}
 
@@ -2509,9 +2507,6 @@ static int fsg_main_thread(void *common_)
 	allow_signal(SIGKILL);
 	allow_signal(SIGUSR1);
 
-	/* Allow the thread to be frozen */
-	set_freezable();
-
 	/*
 	 * Arrange for userspace references to be interpreted as kernel
 	 * pointers.  That way we can pass a kernel pointer to a routine
@@ -2527,7 +2522,7 @@ static int fsg_main_thread(void *common_)
 		}
 
 		if (!common->running) {
-			sleep_thread(common, true);
+			sleep_thread(common);
 			continue;
 		}
 
diff --git a/drivers/uwb/uwbd.c b/drivers/uwb/uwbd.c
index bdcb13c..01c20a2 100644
--- a/drivers/uwb/uwbd.c
+++ b/drivers/uwb/uwbd.c
@@ -279,7 +279,6 @@ static int uwbd(void *param)
 			HZ);
 		if (should_stop)
 			break;
-		try_to_freeze();
 
 		spin_lock_irqsave(&rc->uwbd.event_list_lock, flags);
 		if (!list_empty(&rc->uwbd.event_list)) {
diff --git a/drivers/video/fbdev/ps3fb.c b/drivers/video/fbdev/ps3fb.c
index b269abd..0528189 100644
--- a/drivers/video/fbdev/ps3fb.c
+++ b/drivers/video/fbdev/ps3fb.c
@@ -890,9 +890,7 @@ static int ps3fbd(void *arg)
 {
 	struct fb_info *info = arg;
 
-	set_freezable();
 	while (!kthread_should_stop()) {
-		try_to_freeze();
 		set_current_state(TASK_INTERRUPTIBLE);
 		if (ps3fb.is_kicked) {
 			ps3fb.is_kicked = 0;
diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index 94813af..0c1745a 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -1269,12 +1269,8 @@ static int pxafb_smart_thread(void *arg)
 
 	pr_debug("%s(): task starting\n", __func__);
 
-	set_freezable();
 	while (!kthread_should_stop()) {
 
-		if (try_to_freeze())
-			continue;
-
 		mutex_lock(&fbi->ctrlr_lock);
 
 		if (fbi->state == C_ENABLE) {
diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 7efc329..7b61570 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -350,12 +350,9 @@ static int balloon(void *_vballoon)
 	struct virtio_balloon *vb = _vballoon;
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
 
-	set_freezable();
 	while (!kthread_should_stop()) {
 		s64 diff;
 
-		try_to_freeze();
-
 		add_wait_queue(&vb->config_change, &wait);
 		for (;;) {
 			if ((diff = towards_target(vb)) != 0 ||
diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index c9a7ff6..89a7847 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -1147,7 +1147,6 @@ int w1_process(void *data)
 			jremain = 1;
 		}
 
-		try_to_freeze();
 		__set_current_state(TASK_INTERRUPTIBLE);
 
 		/* hold list_mutex until after interruptible to prevent loosing
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 1e60d00..189f607 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1798,7 +1798,7 @@ static int cleaner_kthread(void *arg)
 		 */
 		btrfs_delete_unused_bgs(root->fs_info);
 sleep:
-		if (!try_to_freeze() && !again) {
+		if (!again) {
 			set_current_state(TASK_INTERRUPTIBLE);
 			if (!kthread_should_stop())
 				schedule();
@@ -1888,14 +1888,12 @@ sleep:
 		if (unlikely(test_bit(BTRFS_FS_STATE_ERROR,
 				      &root->fs_info->fs_state)))
 			btrfs_cleanup_transaction(root);
-		if (!try_to_freeze()) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			if (!kthread_should_stop() &&
-			    (!btrfs_transaction_blocked(root->fs_info) ||
-			     cannot_commit))
-				schedule_timeout(delay);
-			__set_current_state(TASK_RUNNING);
-		}
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (!kthread_should_stop() &&
+		    (!btrfs_transaction_blocked(root->fs_info) ||
+		     cannot_commit))
+			schedule_timeout(delay);
+		__set_current_state(TASK_RUNNING);
 	} while (!kthread_should_stop());
 	return 0;
 }
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 773f4dc..33a4cb1 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -384,7 +384,6 @@ cifs_reconnect(struct TCP_Server_Info *server)
 	}
 
 	do {
-		try_to_freeze();
 
 		/* we should try only the port we connected to before */
 		mutex_lock(&server->srv_mutex);
@@ -563,7 +562,6 @@ cifs_readv_from_socket(struct TCP_Server_Info *server, struct kvec *iov_orig,
 	smb_msg.msg_controllen = 0;
 
 	for (total_read = 0; to_read; total_read += length, to_read -= length) {
-		try_to_freeze();
 
 		if (server_unresponsive(server)) {
 			total_read = -ECONNABORTED;
@@ -855,10 +853,7 @@ cifs_demultiplex_thread(void *p)
 	if (length > 1)
 		mempool_resize(cifs_req_poolp, length + cifs_min_rcv);
 
-	set_freezable();
 	while (server->tcpStatus != CifsExiting) {
-		if (try_to_freeze())
-			continue;
 
 		if (!allocate_buffers(server))
 			continue;
diff --git a/fs/ecryptfs/kthread.c b/fs/ecryptfs/kthread.c
index 866bb18..fa3e9b5 100644
--- a/fs/ecryptfs/kthread.c
+++ b/fs/ecryptfs/kthread.c
@@ -55,11 +55,10 @@ static struct task_struct *ecryptfs_kthread;
  */
 static int ecryptfs_threadfn(void *ignored)
 {
-	set_freezable();
 	while (1)  {
 		struct ecryptfs_open_req *req;
 
-		wait_event_freezable(
+		wait_event_interruptible(
 			ecryptfs_kthread_ctl.wait,
 			(!list_empty(&ecryptfs_kthread_ctl.req_list)
 			 || kthread_should_stop()));
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index a63c7b0..c2e9032 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3036,8 +3036,6 @@ cont_thread:
 		}
 		mutex_unlock(&eli->li_list_mtx);
 
-		try_to_freeze();
-
 		cur = jiffies;
 		if ((time_after_eq(cur, next_wakeup)) ||
 		    (MAX_JIFFY_OFFSET == next_wakeup)) {
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 782b8e7..026fcd7 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -34,12 +34,9 @@ static int gc_thread_func(void *data)
 	wait_ms = gc_th->min_sleep_time;
 
 	do {
-		if (try_to_freeze())
-			continue;
-		else
-			wait_event_interruptible_timeout(*wq,
-						kthread_should_stop(),
-						msecs_to_jiffies(wait_ms));
+		wait_event_interruptible_timeout(*wq,
+					kthread_should_stop(),
+					msecs_to_jiffies(wait_ms));
 		if (kthread_should_stop())
 			break;
 
diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 536e7a6..d352b06 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -930,8 +930,6 @@ int gfs2_logd(void *data)
 
 		t = gfs2_tune_get(sdp, gt_logd_secs) * HZ;
 
-		try_to_freeze();
-
 		do {
 			prepare_to_wait(&sdp->sd_logd_waitq, &wait,
 					TASK_INTERRUPTIBLE);
diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 3a31226..463eeb0 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -1520,8 +1520,6 @@ int gfs2_quotad(void *data)
 		/* Check for & recover partially truncated inodes */
 		quotad_check_trunc_list(sdp);
 
-		try_to_freeze();
-
 		t = min(quotad_timeo, statfs_timeo);
 
 		prepare_to_wait(&sdp->sd_quota_wait, &wait, TASK_INTERRUPTIBLE);
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 8270fe9..1364fe4 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -198,8 +198,6 @@ static int kjournald2(void *arg)
 	setup_timer(&journal->j_commit_timer, commit_timeout,
 			(unsigned long)current);
 
-	set_freezable();
-
 	/* Record that the journal thread is running */
 	journal->j_task = current;
 	wake_up(&journal->j_wait_done_commit);
@@ -234,7 +232,6 @@ loop:
 		 */
 		jbd_debug(1, "Now suspending kjournald2\n");
 		write_unlock(&journal->j_state_lock);
-		try_to_freeze();
 		write_lock(&journal->j_state_lock);
 	} else {
 		/*
diff --git a/fs/jffs2/background.c b/fs/jffs2/background.c
index bb9cebc..8de17e7 100644
--- a/fs/jffs2/background.c
+++ b/fs/jffs2/background.c
@@ -88,7 +88,6 @@ static int jffs2_garbage_collect_thread(void *_c)
 
 	set_user_nice(current, 10);
 
-	set_freezable();
 	for (;;) {
 		sigprocmask(SIG_UNBLOCK, &hupmask, NULL);
 	again:
@@ -124,9 +123,6 @@ static int jffs2_garbage_collect_thread(void *_c)
 			siginfo_t info;
 			unsigned long signr;
 
-			if (try_to_freeze())
-				goto again;
-
 			signr = dequeue_signal_lock(current, &current->blocked, &info);
 
 			switch(signr) {
diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index a69bdf2..6c92f30 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -2347,7 +2347,6 @@ int jfsIOWait(void *arg)
 
 		if (freezing(current)) {
 			spin_unlock_irq(&log_redrive_lock);
-			try_to_freeze();
 		} else {
 			set_current_state(TASK_INTERRUPTIBLE);
 			spin_unlock_irq(&log_redrive_lock);
diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
index d595856..819385a 100644
--- a/fs/jfs/jfs_txnmgr.c
+++ b/fs/jfs/jfs_txnmgr.c
@@ -2797,18 +2797,13 @@ int jfs_lazycommit(void *arg)
 		/* In case a wakeup came while all threads were active */
 		jfs_commit_thread_waking = 0;
 
-		if (freezing(current)) {
-			LAZY_UNLOCK(flags);
-			try_to_freeze();
-		} else {
-			DECLARE_WAITQUEUE(wq, current);
+		DECLARE_WAITQUEUE(wq, current);
 
-			add_wait_queue(&jfs_commit_thread_wait, &wq);
-			set_current_state(TASK_INTERRUPTIBLE);
-			LAZY_UNLOCK(flags);
-			schedule();
-			remove_wait_queue(&jfs_commit_thread_wait, &wq);
-		}
+		add_wait_queue(&jfs_commit_thread_wait, &wq);
+		set_current_state(TASK_INTERRUPTIBLE);
+		LAZY_UNLOCK(flags);
+		schedule();
+		remove_wait_queue(&jfs_commit_thread_wait, &wq);
 	} while (!kthread_should_stop());
 
 	if (!list_empty(&TxAnchor.unlock_queue))
@@ -2987,14 +2982,9 @@ int jfs_sync(void *arg)
 		/* Add anon_list2 back to anon_list */
 		list_splice_init(&TxAnchor.anon_list2, &TxAnchor.anon_list);
 
-		if (freezing(current)) {
-			TXN_UNLOCK();
-			try_to_freeze();
-		} else {
-			set_current_state(TASK_INTERRUPTIBLE);
-			TXN_UNLOCK();
-			schedule();
-		}
+		set_current_state(TASK_INTERRUPTIBLE);
+		TXN_UNLOCK();
+		schedule();
 	} while (!kthread_should_stop());
 
 	jfs_info("jfs_sync being killed");
diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index d678bcc..b976670 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -130,9 +130,6 @@ lockd(void *vrqstp)
 	int		err = 0;
 	struct svc_rqst *rqstp = vrqstp;
 
-	/* try_to_freeze() is called from svc_recv() */
-	set_freezable();
-
 	/* Allow SIGKILL to tell lockd to drop all of its locks */
 	allow_signal(SIGKILL);
 
diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index 75f7c0a..1f4ef49 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -75,8 +75,6 @@ nfs4_callback_svc(void *vrqstp)
 	int err;
 	struct svc_rqst *rqstp = vrqstp;
 
-	set_freezable();
-
 	while (!kthread_should_stop()) {
 		/*
 		 * Listen for a request on the socket
@@ -122,11 +120,7 @@ nfs41_callback_svc(void *vrqstp)
 	int error;
 	DEFINE_WAIT(wq);
 
-	set_freezable();
-
 	while (!kthread_should_stop()) {
-		if (try_to_freeze())
-			continue;
 
 		prepare_to_wait(&serv->sv_cb_waitq, &wq, TASK_INTERRUPTIBLE);
 		spin_lock_bh(&serv->sv_cb_lock);
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index ad4e237..16ee084 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -605,8 +605,6 @@ nfsd(void *vrqstp)
 	nfsdstats.th_cnt++;
 	mutex_unlock(&nfsd_mutex);
 
-	set_freezable();
-
 	/*
 	 * The main request loop
 	 */
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index c6abbad9..c37069c 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -2506,37 +2506,31 @@ static int nilfs_segctor_thread(void *arg)
 	}
 
 
-	if (freezing(current)) {
+	DEFINE_WAIT(wait);
+	int should_sleep = 1;
+
+	prepare_to_wait(&sci->sc_wait_daemon, &wait,
+			TASK_INTERRUPTIBLE);
+
+	if (sci->sc_seq_request != sci->sc_seq_done)
+		should_sleep = 0;
+	else if (sci->sc_flush_request)
+		should_sleep = 0;
+	else if (sci->sc_state & NILFS_SEGCTOR_COMMIT)
+		should_sleep = time_before(jiffies,
+				sci->sc_timer.expires);
+
+	if (should_sleep) {
 		spin_unlock(&sci->sc_state_lock);
-		try_to_freeze();
+		schedule();
 		spin_lock(&sci->sc_state_lock);
-	} else {
-		DEFINE_WAIT(wait);
-		int should_sleep = 1;
-
-		prepare_to_wait(&sci->sc_wait_daemon, &wait,
-				TASK_INTERRUPTIBLE);
-
-		if (sci->sc_seq_request != sci->sc_seq_done)
-			should_sleep = 0;
-		else if (sci->sc_flush_request)
-			should_sleep = 0;
-		else if (sci->sc_state & NILFS_SEGCTOR_COMMIT)
-			should_sleep = time_before(jiffies,
-					sci->sc_timer.expires);
-
-		if (should_sleep) {
-			spin_unlock(&sci->sc_state_lock);
-			schedule();
-			spin_lock(&sci->sc_state_lock);
-		}
-		finish_wait(&sci->sc_wait_daemon, &wait);
-		timeout = ((sci->sc_state & NILFS_SEGCTOR_COMMIT) &&
-			   time_after_eq(jiffies, sci->sc_timer.expires));
-
-		if (nilfs_sb_dirty(nilfs) && nilfs_sb_need_update(nilfs))
-			set_nilfs_discontinued(nilfs);
 	}
+	finish_wait(&sci->sc_wait_daemon, &wait);
+	timeout = ((sci->sc_state & NILFS_SEGCTOR_COMMIT) &&
+		   time_after_eq(jiffies, sci->sc_timer.expires));
+
+	if (nilfs_sb_dirty(nilfs) && nilfs_sb_need_update(nilfs))
+		set_nilfs_discontinued(nilfs);
 	goto loop;
 
  end_thread:
diff --git a/fs/ubifs/commit.c b/fs/ubifs/commit.c
index 63f5661..c760f85 100644
--- a/fs/ubifs/commit.c
+++ b/fs/ubifs/commit.c
@@ -291,15 +291,11 @@ int ubifs_bg_thread(void *info)
 
 	ubifs_msg(c, "background thread \"%s\" started, PID %d",
 		  c->bgt_name, current->pid);
-	set_freezable();
 
 	while (1) {
 		if (kthread_should_stop())
 			break;
 
-		if (try_to_freeze())
-			continue;
-
 		set_current_state(TASK_INTERRUPTIBLE);
 		/* Check if there is something to do */
 		if (!c->need_bgt) {
diff --git a/fs/xfs/xfs_trans_ail.c b/fs/xfs/xfs_trans_ail.c
index 1098cf4..250aef7 100644
--- a/fs/xfs/xfs_trans_ail.c
+++ b/fs/xfs/xfs_trans_ail.c
@@ -530,8 +530,6 @@ xfsaild(
 
 		__set_current_state(TASK_RUNNING);
 
-		try_to_freeze();
-
 		tout = xfsaild_push(ailp);
 	}
 
diff --git a/kernel/audit.c b/kernel/audit.c
index 662c007..b5452c1 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -498,7 +498,6 @@ static void flush_hold_queue(void)
 
 static int kauditd_thread(void *dummy)
 {
-	set_freezable();
 	while (!kthread_should_stop()) {
 		struct sk_buff *skb;
 
@@ -516,7 +515,7 @@ static int kauditd_thread(void *dummy)
 			continue;
 		}
 
-		wait_event_freezable(kauditd_wait, skb_queue_len(&audit_skb_queue));
+		wait_event(kauditd_wait, skb_queue_len(&audit_skb_queue));
 	}
 	return 0;
 }
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 9ff173d..bddac62 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -596,7 +596,6 @@ repeat:
 	} else if (!freezing(current))
 		schedule();
 
-	try_to_freeze();
 	goto repeat;
 }
 EXPORT_SYMBOL_GPL(kthread_worker_fn);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index bbac913..7c343b2 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2877,7 +2877,7 @@ static void khugepaged_do_scan(void)
 
 		cond_resched();
 
-		if (unlikely(kthread_should_stop() || try_to_freeze()))
+		if (unlikely(kthread_should_stop()))
 			break;
 
 		spin_lock(&khugepaged_mm_lock);
@@ -2902,21 +2902,20 @@ static void khugepaged_wait_work(void)
 		if (!khugepaged_scan_sleep_millisecs)
 			return;
 
-		wait_event_freezable_timeout(khugepaged_wait,
+		wait_event_interruptible_timeout(khugepaged_wait,
 					     kthread_should_stop(),
 			msecs_to_jiffies(khugepaged_scan_sleep_millisecs));
 		return;
 	}
 
 	if (khugepaged_enabled())
-		wait_event_freezable(khugepaged_wait, khugepaged_wait_event());
+		wait_event_interruptible(khugepaged_wait, khugepaged_wait_event());
 }
 
 static int khugepaged(void *none)
 {
 	struct mm_slot *mm_slot;
 
-	set_freezable();
 	set_user_nice(current, MAX_NICE);
 
 	while (!kthread_should_stop()) {
diff --git a/mm/ksm.c b/mm/ksm.c
index 7ee101e..21f4c48 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1712,7 +1712,6 @@ static int ksmd_should_run(void)
 
 static int ksm_scan_thread(void *nothing)
 {
-	set_freezable();
 	set_user_nice(current, 5);
 
 	while (!kthread_should_stop()) {
@@ -1722,13 +1721,11 @@ static int ksm_scan_thread(void *nothing)
 			ksm_do_scan(ksm_thread_pages_to_scan);
 		mutex_unlock(&ksm_thread_mutex);
 
-		try_to_freeze();
-
 		if (ksmd_should_run()) {
 			schedule_timeout_interruptible(
 				msecs_to_jiffies(ksm_thread_sleep_millisecs));
 		} else {
-			wait_event_freezable(ksm_thread_wait,
+			wait_event_interruptible(ksm_thread_wait,
 				ksmd_should_run() || kthread_should_stop());
 		}
 	}
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 7f63a93..93520f7 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3314,7 +3314,7 @@ static unsigned long balance_pgdat(pg_data_t *pgdat, int order,
 			order = sc.order = 0;
 
 		/* Check if kswapd should be suspending */
-		if (try_to_freeze() || kthread_should_stop())
+		if (kthread_should_stop())
 			break;
 
 		/*
@@ -3445,7 +3445,6 @@ static int kswapd(void *p)
 	 * trying to free the first piece of memory in the first place).
 	 */
 	tsk->flags |= PF_MEMALLOC | PF_SWAPWRITE | PF_KSWAPD;
-	set_freezable();
 
 	order = new_order = 0;
 	balanced_order = 0;
@@ -3485,7 +3484,6 @@ static int kswapd(void *p)
 			pgdat->classzone_idx = pgdat->nr_zones - 1;
 		}
 
-		ret = try_to_freeze();
 		if (kthread_should_stop())
 			break;
 
@@ -3493,12 +3491,10 @@ static int kswapd(void *p)
 		 * We can speed up thawing tasks if we don't call balance_pgdat
 		 * after returning from the refrigerator
 		 */
-		if (!ret) {
-			trace_mm_vmscan_kswapd_wake(pgdat->node_id, order);
-			balanced_classzone_idx = classzone_idx;
-			balanced_order = balance_pgdat(pgdat, order,
-						&balanced_classzone_idx);
-		}
+		trace_mm_vmscan_kswapd_wake(pgdat->node_id, order);
+		balanced_classzone_idx = classzone_idx;
+		balanced_order = balance_pgdat(pgdat, order,
+					&balanced_classzone_idx);
 	}
 
 	tsk->flags &= ~(PF_MEMALLOC | PF_SWAPWRITE | PF_KSWAPD);
diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index de8d5cc..0ff3730 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -3511,8 +3511,6 @@ static int pktgen_thread_worker(void *arg)
 
 	pr_debug("starting pktgen/%d:  pid=%d\n", cpu, task_pid_nr(current));
 
-	set_freezable();
-
 	while (!kthread_should_stop()) {
 		pkt_dev = next_to_run(t);
 
@@ -3522,7 +3520,6 @@ static int pktgen_thread_worker(void *arg)
 			wait_event_interruptible_timeout(t->queue,
 							 t->control != 0,
 							 HZ/10);
-			try_to_freeze();
 			continue;
 		}
 
@@ -3554,8 +3551,6 @@ static int pktgen_thread_worker(void *arg)
 			pktgen_rem_one_if(t);
 			t->control &= ~(T_REMDEV);
 		}
-
-		try_to_freeze();
 	}
 
 	pr_debug("%s stopping all device\n", t->tsk->comm);
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index a6cbb21..ddef1dc9 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -806,7 +806,6 @@ int svc_recv(struct svc_rqst *rqstp, long timeout)
 	if (err)
 		goto out;
 
-	try_to_freeze();
 	cond_resched();
 	err = -EINTR;
 	if (signalled() || kthread_should_stop())
-- 
1.9.2

