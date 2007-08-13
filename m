From: joe@perches.com
Subject: [PATCH] [443/2many] MAINTAINERS - HIBERNATION (aka
 Software Suspend, aka swsusp):
Date: Sun, 12 Aug 2007 23:36:03 -0700
Message-ID: <46bffbd3.IqsNHrHU1Y9BF7Dd%joe__20956.5767938786$1187015111$gmane$org@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: torvalds@linux-foundation.org, rjw@sisk.pl, pavel@suse.cz, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 29a2179..5ae90a2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4215,6 +4215,9 @@ P:	Rafael J. Wysocki
 M:	rjw@sisk.pl
 L:	linux-pm@lists.linux-foundation.org
 S:	Supported
+F:	Documentation/power/swsusp*
+F:	arch/i386/power/swsusp.S
+F:	kernel/power/
 
 SUSPEND TO RAM:
 P:	Pavel Machek
