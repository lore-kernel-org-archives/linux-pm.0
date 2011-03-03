From: Alexandre Courbot <gnurou@gmail.com>
Subject: [PATCH] Documentation/power/states.txt: fix repetition
Date: Thu,  3 Mar 2011 17:57:40 +0900
Message-ID: <1299142660-5859-1-git-send-email-gnurou__28940.3562703685$1299171106$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Alexandre Courbot <gnurou@gmail.com>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Remove repetition of "called swsusp".

Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
---
 Documentation/power/states.txt |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/power/states.txt b/Documentation/power/states.txt
index 34800cc..4416b28 100644
--- a/Documentation/power/states.txt
+++ b/Documentation/power/states.txt
@@ -62,12 +62,12 @@ setup via another operating system for it to use. Despite the
 inconvenience, this method requires minimal work by the kernel, since
 the firmware will also handle restoring memory contents on resume. 
 
-For suspend-to-disk, a mechanism called swsusp called 'swsusp' (Swap
-Suspend) is used to write memory contents to free swap space.
-swsusp has some restrictive requirements, but should work in most
-cases. Some, albeit outdated, documentation can be found in
-Documentation/power/swsusp.txt. Alternatively, userspace can do most
-of the actual suspend to disk work, see userland-swsusp.txt.
+For suspend-to-disk, a mechanism called 'swsusp' (Swap Suspend) is used
+to write memory contents to free swap space. swsusp has some restrictive
+requirements, but should work in most cases. Some, albeit outdated,
+documentation can be found in Documentation/power/swsusp.txt.
+Alternatively, userspace can do most of the actual suspend to disk work,
+see userland-swsusp.txt.
 
 Once memory state is written to disk, the system may either enter a
 low-power state (like ACPI S4), or it may simply power down. Powering
-- 
1.7.4.1
