From: Frans Pop <elendil@planet.nl>
Subject: [PATCH 15/16] PM: remove trailing space in message
Date: Sat,  6 Feb 2010 18:47:22 +0100
Message-ID: <1265478443-31072-15-git-send-email-elendil__20504.3045724326$1265478593$gmane$org@planet.nl>
References: <201002061844.45212.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201002061844.45212.elendil@planet.nl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: Frans Pop <elendil@planet.nl>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Frans Pop <elendil@planet.nl>
Cc: linux-pm@lists.linux-foundation.org
Cc: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/snapshot.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 36cb168..2eda407 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1500,7 +1500,7 @@ asmlinkage int swsusp_save(void)
 {
 	unsigned int nr_pages, nr_highmem;
 
-	printk(KERN_INFO "PM: Creating hibernation image: \n");
+	printk(KERN_INFO "PM: Creating hibernation image:\n");
 
 	drain_local_pages(NULL);
 	nr_pages = count_data_pages();
-- 
1.6.6.1
