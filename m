From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Update][PATCH 7/8] PM / Domains: System-wide
	transitions support for generic domains (v3)
Date: Tue, 21 Jun 2011 01:05:41 +0200
Message-ID: <201106210105.41740.rjw__17504.1045797572$1308611381$gmane$org@sisk.pl>
References: <201106112223.04972.rjw@sisk.pl> <201106112239.16285.rjw@sisk.pl>
	<201106200006.07642.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201106200006.07642.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Cc: linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, June 20, 2011, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Make generic PM domains support system-wide power transitions
> (system suspend and hibernation).  Add suspend, resume, freeze, thaw,
> poweroff and restore callbacks to be associated with struct
> generic_pm_domain objects and make pm_genpd_init() use them as
> appropriate.
> 
> The new callbacks do nothing for devices belonging to power domains
> that were powered down at run time (before the transition).  For the
> other devices the action carried out depends on the type of the
> transition.  During system suspend the power domain .suspend()
> callback executes pm_generic_suspend() for the device, while the
> PM domain .suspend_noirq() callback runs pm_generic_suspend_noirq()
> for it, stops it and eventually removes power from the PM domain it
> belongs to (after all devices in the domain have been stopped and its
> subdomains have been powered off).
> 
> During system resume the PM domain .resume_noirq() callback
> restores power to the PM domain (when executed for it first time),
> starts the device and executes pm_generic_resume_noirq() for it,
> while the .resume() callback executes pm_generic_resume() for the
> device.  Finally, the .complete() callback executes pm_runtime_idle()
> for the device which should put it back into the suspended state if
> its runtime PM usage count is equal to zero at that time.
> 
> The actions carried out during hibernation and resume from it are
> analogous to the ones described above.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---

The patch below adds wakeup devices support on top of this one.

Thanks,
Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: PM / Domains: Don't stop wakeup devices during system sleep transitions

Devices that are set up to wake up the system from sleep states
should not be stopped and power should not be removed from them
when the system goes into a sleep state.  Make the generic PM domain
code respect that limitation.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/domain.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: linux-2.6/drivers/base/power/domain.c
===================================================================
--- linux-2.6.orig/drivers/base/power/domain.c
+++ linux-2.6/drivers/base/power/domain.c
@@ -446,6 +446,9 @@ static int pm_genpd_suspend_noirq(struct
 	if (ret)
 		return ret;
 
+	if (device_may_wakeup(dev))
+		return 0;
+
 	if (genpd->stop_device)
 		genpd->stop_device(dev);
 
@@ -666,6 +669,9 @@ static int pm_genpd_dev_poweroff_noirq(s
 	if (ret)
 		return ret;
 
+	if (device_may_wakeup(dev))
+		return 0;
+
 	if (genpd->stop_device)
 		genpd->stop_device(dev);
 
