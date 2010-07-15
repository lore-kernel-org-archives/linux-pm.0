From: James Bottomley <James.Bottomley@suse.de>
Subject: Re: Warnings from PM QoS plist usage
Date: Thu, 15 Jul 2010 08:12:58 +0200
Message-ID: <1279174378.21982.52.camel@mulgrave.site>
References: <20100714093510.GC5933@sirena.org.uk>
	<20100714093558.GD5933@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100714093558.GD5933@sirena.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-pm@lists.linux-foundation.org, mark gross <markgross@thegnar.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2010-07-14 at 10:35 +0100, Mark Brown wrote:
> On Wed, Jul 14, 2010 at 10:35:10AM +0100, Mark Brown wrote:
> 
> CCing in the mailing list like I meant to on the original post, sorry:
> 
> > When running with 'pm_qos: Reimplement using plists' and
> > CONFIG_DEBUG_PI_LIST enabled ALSA (and presumably other PM QoS users)
> > generate tracebacks like this whenever they use PM QoS:
> > 
> > [  118.250000] ------------[ cut here ]------------
> > [  118.250000] WARNING: at lib/plist.c:57 plist_check_head+0x2c/0x44()
> > [  118.250000] Modules linked in: snd_soc_fnord snd_soc_s3c64xx_i2s snd_soc_s3c_6
> > [  118.250000] [<c0034aac>] (unwind_backtrace+0x0/0xec) from [<c004a8f0>] (warn_)
> > [  118.250000] [<c004a8f0>] (warn_slowpath_common+0x4c/0x7c) from [<c004a93c>] ()
> > [  118.250000] [<c004a93c>] (warn_slowpath_null+0x1c/0x24) from [<c0187c2c>] (pl)
> > [  118.250000] [<c0187c2c>] (plist_check_head+0x2c/0x44) from [<c0187cf0>] (plis)
> > [  118.250000] [<c0187cf0>] (plist_add+0x18/0xbc) from [<c006755c>] (update_targ)
> > [  118.250000] [<c006755c>] (update_target+0xb8/0x124) from [<c025336c>] (snd_pc)
> > [  118.250000] [<c025336c>] (snd_pcm_hw_params+0x2cc/0x310) from [<c0253780>] (s)
> > [  118.250000] [<c0253780>] (snd_pcm_common_ioctl1+0x1f8/0x10ac) from [<c0254e20)
> > [  118.250000] [<c0254e20>] (snd_pcm_playback_ioctl1+0x3d8/0x3fc) from [<c00c7e5)
> > [  118.250000] [<c00c7e50>] (vfs_ioctl+0x2c/0x70) from [<c00c8534>] (do_vfs_ioct)
> > [  118.250000] [<c00c8534>] (do_vfs_ioctl+0x4d0/0x524) from [<c00c85c0>] (sys_io)
> > [  118.250000] [<c00c85c0>] (sys_ioctl+0x38/0x5c) from [<c002eec0>] (ret_fast_sy)
> > [  118.250000] ---[ end trace 810ec758dcd5bc5a ]---                              
> > This is because the plists introduced by the above commit are being
> > initialised with the _PLIST_HEAD_INIT() rather than PLIST_HEAD_INIT()
> > and don't have the associated locks which the debug code relies on.
> > 
> > I've not looked at the PM QoS code at all so I don't know what the
> > appropriate place to fix this is - do we perhaps want to fix the debug
> > code to cope with no locks?  Looking at the plist.h code it seems fairly
> > clear that there's currently no expectation that users should use
> > _PLIST_INIT_HEAD() directly.

Sorry ... I just wasn't sure what it wanted without reading through the
plist code more ... and also that debug item is hidden by
CONFIG_DEBUG_RT_MUTEXES, which is why I couldn't enable it.

This should fix the warning.

James

---

diff --git a/kernel/pm_qos_params.c b/kernel/pm_qos_params.c
index bff4053..7971678 100644
--- a/kernel/pm_qos_params.c
+++ b/kernel/pm_qos_params.c
@@ -62,10 +62,12 @@ struct pm_qos_object {
 	enum pm_qos_type type;
 };
 
+static DEFINE_SPINLOCK(pm_qos_lock);
+
 static struct pm_qos_object null_pm_qos;
 static BLOCKING_NOTIFIER_HEAD(cpu_dma_lat_notifier);
 static struct pm_qos_object cpu_dma_pm_qos = {
-	.requests = {_PLIST_HEAD_INIT(cpu_dma_pm_qos.requests)},
+	.requests = PLIST_HEAD_INIT(cpu_dma_pm_qos.requests, pm_qos_lock),
 	.notifiers = &cpu_dma_lat_notifier,
 	.name = "cpu_dma_latency",
 	.default_value = 2000 * USEC_PER_SEC,
@@ -74,7 +76,7 @@ static struct pm_qos_object cpu_dma_pm_qos = {
 
 static BLOCKING_NOTIFIER_HEAD(network_lat_notifier);
 static struct pm_qos_object network_lat_pm_qos = {
-	.requests = {_PLIST_HEAD_INIT(network_lat_pm_qos.requests)},
+	.requests = PLIST_HEAD_INIT(network_lat_pm_qos.requests, pm_qos_lock),
 	.notifiers = &network_lat_notifier,
 	.name = "network_latency",
 	.default_value = 2000 * USEC_PER_SEC,
@@ -84,7 +86,7 @@ static struct pm_qos_object network_lat_pm_qos = {
 
 static BLOCKING_NOTIFIER_HEAD(network_throughput_notifier);
 static struct pm_qos_object network_throughput_pm_qos = {
-	.requests = {_PLIST_HEAD_INIT(network_throughput_pm_qos.requests)},
+	.requests = PLIST_HEAD_INIT(network_throughput_pm_qos.requests, pm_qos_lock),
 	.notifiers = &network_throughput_notifier,
 	.name = "network_throughput",
 	.default_value = 0,
@@ -99,8 +101,6 @@ static struct pm_qos_object *pm_qos_array[] = {
 	&network_throughput_pm_qos
 };
 
-static DEFINE_SPINLOCK(pm_qos_lock);
-
 static ssize_t pm_qos_power_write(struct file *filp, const char __user *buf,
 		size_t count, loff_t *f_pos);
 static int pm_qos_power_open(struct inode *inode, struct file *filp);
