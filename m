From: Mandeep Singh Baines <msb@chromium.org>
Subject: [PATCH 6/6] taskstats: use appropriate printk priority
	level
Date: Wed, 26 Jan 2011 15:29:30 -0800
Message-ID: <1296084570-31453-7-git-send-email-msb__23629.9980701462$1296144577$gmane$org@chromium.org>
References: <20110125235700.GR8008@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110125235700.GR8008@google.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: gregkh@suse.de, rjw@sisk.pl, mingo@redhat.com, akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Mandeep Singh Baines <msb@chromium.org>
List-Id: linux-pm@vger.kernel.org

printk()s without a priority level default to KERN_WARNING. To reduce
noise at KERN_WARNING, this patch set the priority level appriopriately
for unleveled printks()s. This should be useful to folks that look at
dmesg warnings closely.

Signed-off-by: Mandeep Singh Baines <msb@chromium.org>
---
 kernel/taskstats.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/taskstats.c b/kernel/taskstats.c
index 3971c6b..9ffea36 100644
--- a/kernel/taskstats.c
+++ b/kernel/taskstats.c
@@ -685,7 +685,7 @@ static int __init taskstats_init(void)
 		goto err_cgroup_ops;
 
 	family_registered = 1;
-	printk("registered taskstats version %d\n", TASKSTATS_GENL_VERSION);
+	pr_info("registered taskstats version %d\n", TASKSTATS_GENL_VERSION);
 	return 0;
 err_cgroup_ops:
 	genl_unregister_ops(&family, &taskstats_ops);
-- 
1.7.3.1
