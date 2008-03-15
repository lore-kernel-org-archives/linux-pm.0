From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: more [PATCH 0/2] PM: Remove legacy PM
Date: Sat, 15 Mar 2008 16:36:02 -0700
Message-ID: <20080315163602.1b368275.randy.dunlap@oracle.com>
References: <200803132351.19794.rjw@sisk.pl>
	<200803140000.02420.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803140000.02420.lenb@kernel.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Baechle <ralf@linux-mips.org>, Pavel@smtp1.linux-foundation.org, Ralf@smtp1.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 14 Mar 2008 00:00:02 -0400 Len Brown wrote:

Please add this docbook patch.

---

From: Randy Dunlap <randy.dunlap@oracle.com>

Source file was removed.  Need to remove docbook reference also.

Are there other files in kernel/power/ that should be added to the docbook?

$ power> kerndoc-search.pl --count *.c
file console.c: 0 kernel-doc blocks
file disk.c: 18 kernel-doc blocks
file main.c: 9 kernel-doc blocks
file poweroff.c: 0 kernel-doc blocks
file process.c: 2 kernel-doc blocks
file snapshot.c: 39 kernel-doc blocks
file swap.c: 10 kernel-doc blocks
file swsusp.c: 4 kernel-doc blocks
file user.c: 0 kernel-doc blocks

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 Documentation/DocBook/kernel-api.tmpl |    5 -----
 1 file changed, 5 deletions(-)

--- mmotm-2008-0314-1449.orig/Documentation/DocBook/kernel-api.tmpl
+++ mmotm-2008-0314-1449/Documentation/DocBook/kernel-api.tmpl
@@ -297,11 +297,6 @@ X!Earch/x86/kernel/mca_32.c
 !Ikernel/acct.c
   </chapter>
 
-  <chapter id="pmfuncs">
-     <title>Power Management</title>
-!Ekernel/power/pm.c
-  </chapter>
-
   <chapter id="devdrivers">
      <title>Device drivers infrastructure</title>
      <sect1><title>Device Drivers Base</title>
