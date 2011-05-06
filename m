From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Power Manager suspend-hybrid warn on
	systemlog
Date: Sat, 7 May 2011 00:12:05 +0200
Message-ID: <201105070012.05863.rjw@sisk.pl>
References: <1298384175.8390.25.camel@localhost.localdomain>
	<201104262236.10340.rjw@sisk.pl>
	<1303930856.17485.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1303930856.17485.1.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alexandre Felipe Muller de Souza <alexandrefm@mandriva.com.br>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, April 27, 2011, Alexandre Felipe Muller de Souza wrote:
> Those lines are the last lines of dmesg.
> I think it was at "waking up" process.

Hmm.  I have found a bug, but I'm not sure it's this one still.

Please apply the appended patch on top of the previous one (i.e. the
second of my patches) and check if that helps.

Thanks,
Rafael
 

---
From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: PM / Hibernate: Fix ioctl SNAPSHOT_S2RAM

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
