From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / core: Fix extra pm_runtime_enable on resume
Date: Wed, 03 Oct 2018 10:30:14 +0200
Message-ID: <16552133.rou2tyfJcz@aspire.rjw.lan>
References: <1537913455-43397-1-git-send-email-alcooperx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537913455-43397-1-git-send-email-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Cooper <alcooperx@gmail.com>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, September 26, 2018 12:10:55 AM CEST Al Cooper wrote:
> Matching pm_runtime_disable/pm_runtime_enable routines should be
> called for "direct_complete" devices during suspend/resume and there
> are cases where the pm_runtime_disable is skipped during suspend but
> pm_runtime_enable is still called during resume. This is a problem
> because the runtime enable state is really a counter and this can
> incorrectly enable pm_runtime when it should not be enabled. This
> happens for any direct_complete device doing an async suspend after
> the global variable "async_error" is set (which is set by any sync
> or async device's suspend error or early wake condition).

So the bug is simply that the direct_complete flag is not cleared
when we are going to bail out of __device_suspend() early due to an
error or wakeup.

The patch below should fix it then (without adding extra flags to
struct dev_pm_info), shouldn't it?

---
 drivers/base/power/main.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -1713,8 +1713,10 @@ static int __device_suspend(struct devic
 
 	dpm_wait_for_subordinate(dev, async);
 
-	if (async_error)
+	if (async_error) {
+		dev->power.direct_complete = false;
 		goto Complete;
+	}
 
 	/*
 	 * If a device configured to wake up the system from sleep states
@@ -1726,6 +1728,7 @@ static int __device_suspend(struct devic
 		pm_wakeup_event(dev, 0);
 
 	if (pm_wakeup_pending()) {
+		dev->power.direct_complete = false;
 		async_error = -EBUSY;
 		goto Complete;
 	}
