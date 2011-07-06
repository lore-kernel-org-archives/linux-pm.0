From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/5 v1] PM / Domains: Set device state to
	"active" during system resume
Date: Wed, 6 Jul 2011 22:50:53 +0200
Message-ID: <201107062250.54261.rjw__35458.2824315459$1309986322$gmane$org@sisk.pl>
References: <201107062248.35586.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201107062248.35586.rjw@sisk.pl>
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
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The runtime PM status of devices in a power domain that is not
powered off in pm_genpd_complete() should be set to "active", because
those devices are operational at this point.  Some of them may not be
in use, though, so make pm_genpd_complete() call pm_runtime_idle()
in addition to pm_runtime_set_active() for each of them.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/domain.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6/drivers/base/power/domain.c
===================================================================
--- linux-2.6.orig/drivers/base/power/domain.c
+++ linux-2.6/drivers/base/power/domain.c
@@ -786,7 +786,9 @@ static void pm_genpd_complete(struct dev
 
 	if (run_complete) {
 		pm_generic_complete(dev);
+		pm_runtime_set_active(dev);
 		pm_runtime_enable(dev);
+		pm_runtime_idle(dev);
 	}
 }
 
