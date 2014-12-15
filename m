From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: 3.18: lockdep problems in cpufreq
Date: Mon, 15 Dec 2014 23:09:22 +0000
Message-ID: <20141215230922.GL11285@n2100.arm.linux.org.uk>
References: <20141214213655.GA11285@n2100.arm.linux.org.uk>
 <003501d01876$fbc53f80$f34fbe80$%brar@samsung.com>
 <20141215174336.GJ11285@n2100.arm.linux.org.uk>
 <3353119.0CuA8fKaup@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:60706 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751076AbaLOXJf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Dec 2014 18:09:35 -0500
Content-Disposition: inline
In-Reply-To: <3353119.0CuA8fKaup@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Yadwinder Singh Brar <yadi.brar@samsung.com>, 'Viresh Kumar' <viresh.kumar@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 'Eduardo Valentin' <edubezval@gmail.com>

On Mon, Dec 15, 2014 at 10:41:02PM +0100, Rafael J. Wysocki wrote:
> On Monday, December 15, 2014 05:43:36 PM Russell King - ARM Linux wrote:
> > On Mon, Dec 15, 2014 at 08:24:05PM +0530, Yadwinder Singh Brar wrote:
> > > I agree with this approach, if its fine for others also, I can implement
> > > and post patch.
> > 
> > Yes, please do.
> 
> Indeed.  We have a regression here to fix.

Well, here's a patch which I'm running on top of 3.18 at the moment,
which is basically what I described in my email, and I'm running with it
and it is without any lockdep complaint.

8<===
From: Russell King <rmk+kernel@arm.linux.org.uk>
thermal: cpu_cooling: fix lockdep problems in cpu_cooling

A recent change to the cpu_cooling code introduced a AB-BA deadlock
scenario between the cpufreq_policy_notifier_list rwsem and the
cooling_cpufreq_lock.  This is caused by cooling_cpufreq_lock being held
before the registration/removal of the notifier block (an operation
which takes the rwsem), and the notifier code itself which takes the
locks in the reverse order.

Solve this by moving to finer grained locking - use one mutex to protect
the cpufreq_dev_list as a whole, and a separate lock to ensure correct
ordering of cpufreq notifier registration and removal.

I considered taking the cooling_list_lock within cooling_cpufreq_lock to
protect the registration sequence as a whole, but that adds a dependency
between these two locks which is best avoided (lest someone tries to
take those two new locks in the reverse order.)  In any case, it's safer
to have an empty cpufreq_dev_list than to have unnecessary dependencies
between locks.

Fixes: 2dcd851fe4b4 ("thermal: cpu_cooling: Update always cpufreq policy with thermal constraints")
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---

 drivers/thermal/cpu_cooling.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index ad09e51ffae4..9e42c6f30785 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -57,6 +57,7 @@ static DEFINE_MUTEX(cooling_cpufreq_lock);
 
 static unsigned int cpufreq_dev_count;
 
+static DEFINE_MUTEX(cooling_list_lock);
 static LIST_HEAD(cpufreq_dev_list);
 
 /**
@@ -317,7 +318,7 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
 	if (event != CPUFREQ_ADJUST)
 		return 0;
 
-	mutex_lock(&cooling_cpufreq_lock);
+	mutex_lock(&cooling_list_lock);
 	list_for_each_entry(cpufreq_dev, &cpufreq_dev_list, node) {
 		if (!cpumask_test_cpu(policy->cpu,
 					&cpufreq_dev->allowed_cpus))
@@ -333,7 +334,7 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
 		if (policy->max != max_freq)
 			cpufreq_verify_within_limits(policy, 0, max_freq);
 	}
-	mutex_unlock(&cooling_cpufreq_lock);
+	mutex_unlock(&cooling_list_lock);
 
 	return 0;
 }
@@ -482,6 +483,11 @@ __cpufreq_cooling_register(struct device_node *np,
 	}
 	cpufreq_dev->cool_dev = cool_dev;
 	cpufreq_dev->cpufreq_state = 0;
+
+	mutex_lock(&cooling_list_lock);
+	list_add(&cpufreq_dev->node, &cpufreq_dev_list);
+	mutex_unlock(&cooling_list_lock);
+
 	mutex_lock(&cooling_cpufreq_lock);
 
 	/* Register the notifier for first cpufreq cooling device */
@@ -489,7 +495,6 @@ __cpufreq_cooling_register(struct device_node *np,
 		cpufreq_register_notifier(&thermal_cpufreq_notifier_block,
 					  CPUFREQ_POLICY_NOTIFIER);
 	cpufreq_dev_count++;
-	list_add(&cpufreq_dev->node, &cpufreq_dev_list);
 
 	mutex_unlock(&cooling_cpufreq_lock);
 
@@ -553,7 +558,6 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 
 	cpufreq_dev = cdev->devdata;
 	mutex_lock(&cooling_cpufreq_lock);
-	list_del(&cpufreq_dev->node);
 	cpufreq_dev_count--;
 
 	/* Unregister the notifier for the last cpufreq cooling device */
@@ -562,6 +566,10 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 					    CPUFREQ_POLICY_NOTIFIER);
 	mutex_unlock(&cooling_cpufreq_lock);
 
+	mutex_lock(&cooling_list_lock);
+	list_del(&cpufreq_dev->node);
+	mutex_unlock(&cooling_list_lock);
+
 	thermal_cooling_device_unregister(cpufreq_dev->cool_dev);
 	release_idr(&cpufreq_idr, cpufreq_dev->id);
 	kfree(cpufreq_dev);


-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
