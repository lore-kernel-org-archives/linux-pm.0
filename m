From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] i2c: Factor out runtime suspend checks from
	PM operations
Date: Wed, 22 Dec 2010 22:25:22 +0100
Message-ID: <201012222225.22368.rjw__46794.6805445992$1293053206$gmane$org@sisk.pl>
References: <1293041268-7707-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<AANLkTin5eSg8vL4Q8yZ9tme38fbS2aAZ-xeLQSNu809B@mail.gmail.com>
	<20101222201413.GB8167@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20101222201413.GB8167@opensource.wolfsonmicro.com>
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
Cc: linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, Jean Delvare <khali@linux-fr.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, December 22, 2010, Mark Brown wrote:
> On Thu, Dec 23, 2010 at 12:49:39AM +0530, Rabin Vincent wrote:
> 
> > And even if we did want to support runtime PM interaction for legacy
> > ops, the code for restore() above suffers from the problem of setting
> > active even when no callback exists, like I mentioned in the same email
> > for resume():
> 
> I agree it's confused, I posted an updated patch which should behave
> exactly as the old code did - I think the confusion with the legacy
> behaviour should be addressed seperately (and ideally in 2.6.37 or at
> least a stable patch rather than 2.6.38 which is where the current patch
> is targetted).

Rabin is right, runtime PM cannot be supported in the "legacy" case.
Still, I see that __pm_generic_resume() has the problem that it sets
RPM_ACTIVE unconditionally, which it shouldn't do if the runtime PM has been
already disabled.

So, I think we need this patch:

---
 drivers/base/power/generic_ops.c |    2 +-
 include/linux/pm_runtime.h       |    6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/base/power/generic_ops.c
===================================================================
--- linux-2.6.orig/drivers/base/power/generic_ops.c
+++ linux-2.6/drivers/base/power/generic_ops.c
@@ -185,7 +185,7 @@ static int __pm_generic_resume(struct de
 		return 0;
 
 	ret = callback(dev);
-	if (!ret) {
+	if (!ret && pm_runtime_enabled(dev)) {
 		pm_runtime_disable(dev);
 		pm_runtime_set_active(dev);
 		pm_runtime_enable(dev);
Index: linux-2.6/include/linux/pm_runtime.h
===================================================================
--- linux-2.6.orig/include/linux/pm_runtime.h
+++ linux-2.6/include/linux/pm_runtime.h
@@ -82,6 +82,11 @@ static inline bool pm_runtime_suspended(
 		&& !dev->power.disable_depth;
 }
 
+static inline bool pm_runtime_enabled(struct device *dev)
+{
+	return !dev->power.disable_depth;
+}
+
 static inline void pm_runtime_mark_last_busy(struct device *dev)
 {
 	ACCESS_ONCE(dev->power.last_busy) = jiffies;
@@ -120,6 +125,7 @@ static inline void pm_runtime_put_noidle
 static inline bool device_run_wake(struct device *dev) { return false; }
 static inline void device_set_run_wake(struct device *dev, bool enable) {}
 static inline bool pm_runtime_suspended(struct device *dev) { return false; }
+static inline bool pm_runtime_enabled(struct device *dev) { return false; }
 
 static inline int pm_generic_runtime_idle(struct device *dev) { return 0; }
 static inline int pm_generic_runtime_suspend(struct device *dev) { return 0; }
