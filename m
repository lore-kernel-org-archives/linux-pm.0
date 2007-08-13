From: joe@perches.com
Subject: [PATCH] [444/2many] MAINTAINERS - SUSPEND TO RAM:
Date: Sun, 12 Aug 2007 23:36:05 -0700
Message-ID: <46bffbd5.kKrnXsYdLyNKojxF%joe__34210.5239550166$1187015108$gmane$org@perches.com>
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
index 5ae90a2..e9e7a00 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4226,6 +4226,7 @@ P:	Rafael J. Wysocki
 M:	rjw@sisk.pl
 L:	linux-pm@lists.linux-foundation.org
 S:	Maintained
+F:	kernel/power/
 
 SONIC NETWORK DRIVER
 P:	Thomas Bogendoerfer
