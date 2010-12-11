From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM / Hibernate: Restore old swap signature
	to avoid user space breakage
Date: Sat, 11 Dec 2010 21:17:06 +0100
Message-ID: <201012112117.06636.rjw__8414.21240843392$1292098716$gmane$org@sisk.pl>
References: <201012052324.30231.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201012052324.30231.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
Cc: Karel Zak <kzak@redhat.com>, LKML <linux-kernel@vger.kernel.org>, "Dr. David Alan Gilbert" <linux@treblig.org>, Pascal Chapperon <pascal.chapperon@wanadoo.fr>
List-Id: linux-pm@vger.kernel.org

On Sunday, December 05, 2010, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Commit 3624eb0 (PM / Hibernate: Modify signature used to mark swap)
> modified hibernate signature used to mark swap partitions containing
> hibernation images, but that turns out to have caused problems in
> libblkid on recent Ubuntu.  Restore the old signature to avoid those
> problems.

Below is the same patch with modified changelog reflecting the recent findings.

Thanks,
Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: PM / Hibernate: Restore old swap signature to avoid user space breakage

Commit 3624eb0 (PM / Hibernate: Modify signature used to mark swap)
attempted to modify hibernate signature used to mark swap partitions
containing hibernation images, so that old kernels don't try to
handle compressed images.  However, this change broke resume from
hibernation on Fedora 14 that apparently doesn't pass the resume=
argument to the kernel and tries to trigger resume from early user
space.  This doesn't work, because the signature is now different,
so the old signature has to be restored to avoid the problem.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Reported-by: Dr. David Alan Gilbert <linux@treblig.org>
Reported-by: Pascal Chapperon <pascal.chapperon@wanadoo.fr>
---
 kernel/power/swap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/kernel/power/swap.c
===================================================================
--- linux-2.6.orig/kernel/power/swap.c
+++ linux-2.6/kernel/power/swap.c
@@ -30,7 +30,7 @@
 
 #include "power.h"
 
-#define HIBERNATE_SIG	"LINHIB0001"
+#define HIBERNATE_SIG	"S1SUSPEND"
 
 /*
  *	The swap map is a data structure used for keeping track of each page
