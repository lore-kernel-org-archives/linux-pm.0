From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 3/3] PM / Hibernate: Fix ioctl SNAPSHOT_S2RAM
Date: Sat, 7 May 2011 00:32:27 +0200
Message-ID: <201105070032.27540.rjw__48806.4138139181$1304721380$gmane$org@sisk.pl>
References: <201105070029.44623.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201105070029.44623.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Alexandre Felipe Muller de Souza <alexandrefm@mandriva.com.br>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The SNAPSHOT_S2RAM ioctl used for implementing the feature allowing
one to suspend to RAM after creating a hibernation image is currently
broken, because it doesn't clear the "ready" flag in the struct
snapshot_data object handled by it.  As a result, the
SNAPSHOT_UNFREEZE doesn't work correctly after SNAPSHOT_S2RAM has
returned and the user space hibernate task cannot thaw the other
processes as appropriate.  Make SNAPSHOT_S2RAM clear data->ready
to fix this problem.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/user.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6/kernel/power/user.c
===================================================================
--- linux-2.6.orig/kernel/power/user.c
+++ linux-2.6/kernel/power/user.c
@@ -381,6 +381,7 @@ static long snapshot_ioctl(struct file *
 		 * PM_HIBERNATION_PREPARE
 		 */
 		error = suspend_devices_and_enter(PM_SUSPEND_MEM);
+		data->ready = 0;
 		break;
 
 	case SNAPSHOT_PLATFORM_SUPPORT:
