From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 2/2] PM / Hibernate: swap,
	remove useless check from swsusp_read
Date: Wed, 27 Jan 2010 17:46:18 +0100
Message-ID: <1264610778-13242-2-git-send-email-jslaby__1740.19943592629$1264627440$gmane$org@suse.cz>
References: <1264610778-13242-1-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1264610778-13242-1-git-send-email-jslaby@suse.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: rjw@sisk.pl
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

It will never reach here if the sws_resume_bdev is erratic.
swsusp_read is called only from software_resume, but after
swsusp_check which would catch the error state.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>
---
 kernel/power/swap.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 09b2b0a..1d57573 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -657,10 +657,6 @@ int swsusp_read(unsigned int *flags_p)
 	struct swsusp_info *header;
 
 	*flags_p = swsusp_header->flags;
-	if (IS_ERR(resume_bdev)) {
-		pr_debug("PM: Image device not initialised\n");
-		return PTR_ERR(resume_bdev);
-	}
 
 	memset(&snapshot, 0, sizeof(struct snapshot_handle));
 	error = snapshot_write_next(&snapshot, PAGE_SIZE);
-- 
1.6.6.1
