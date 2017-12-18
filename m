From: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
Subject: [PATCH] PM / OPP: list_del_rcu should be used in function _remove_list_dev
Date: Mon, 18 Dec 2017 16:32:23 +0800
Message-ID: <20171218083223.26647-1-chunyan.zhang@spreadtrum.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Wang <vincent.wang@spreadtrum.com>, Orson Zhai <orson.zhai@spreadtrum.com>, Chunyan Zhang <zhang.lyra@gmail.com>
List-Id: linux-pm@vger.kernel.org

From: Vincent Wang <vincent.wang@spreadtrum.com>

list_del_rcu() should be used to replace list_del() in the function
_remove_list_dev(), since the opp is a rcu protected pointer.

For example, on an ARM big.Little platform of spreadtrum, there are
little cluster, big cluster and gpu using pm_opp. And the opp_table
of big cluster will be removed when big cluster is removed, which
is implemented in the cpufreq driver. Sometimes an issue maybe occur:

[  237.647758] c0 Unable to handle kernel paging request at virtual address dead000000000110
[  237.647776] c0 pgd = ffffffc073e78000
[  237.647786] c0 [dead000000000110] *pgd=0000000000000000, *pud=0000000000000000
[  237.647808] c0 Internal error: Oops: 96000004 [#1] PREEMPT SMP
[  237.653535] c0 Modules linked in: sprdwl_ng(O) mtty marlin2_fm mali_kbase(O)
[  237.653569] c0 CPU: 0 PID: 38 Comm: kworker/u12:1 Tainted: G S      W  O    4.4.83+ #1
[  237.653578] c0 Hardware name: Spreadtrum SP9850KHsmt 1h10 Board (DT)
[  237.653594] c0 Workqueue: devfreq_wq devfreq_monitor
[  237.653605] c0 task: ffffffc0babd0d80 task.stack: ffffffc0badbc000
[  237.653619] c0 PC is at _find_device_opp+0x58/0xac
[  237.653629] c0 LR is at dev_pm_opp_find_freq_ceil+0x2c/0xb8

[  237.921294] c0 Call trace:
[  237.921425] c0 [<ffffff80085362b0>] _find_device_opp+0x58/0xac
[  237.921437] c0 [<ffffff8008536560>] dev_pm_opp_find_freq_ceil+0x2c/0xb8
[  237.921452] c0 [<ffffff80088760f4>] devfreq_recommended_opp+0x54/0x7c
[  237.921494] c0 [<ffffff8000b6a96c>] kbase_wait_write_flush+0x164/0x358 [mali_kbase]
[  237.921504] c0 [<ffffff800887485c>] update_devfreq+0x8c/0xf8
[  237.921514] c0 [<ffffff80088749e4>] devfreq_monitor+0x34/0x94
[  237.921529] c0 [<ffffff80080bd75c>] process_one_work+0x154/0x458
[  237.921539] c0 [<ffffff80080be428>] worker_thread+0x134/0x4a4
[  237.921551] c0 [<ffffff80080c4bec>] kthread+0xdc/0xf0
[  237.921564] c0 [<ffffff8008085f20>] ret_from_fork+0x10/0x30

Cc: stable <stable@vger.kernel.org>     # 4.4
Signed-off-by: Vincent Wang <vincent.wang@spreadtrum.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---

This patch is only for 4.4 stable branch.
Once this patch accepted, I can cook a similar patch for 4.9 stable branch.

---
 drivers/base/power/opp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index db6e7e5..e0eac53 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -463,7 +463,7 @@ static void _kfree_list_dev_rcu(struct rcu_head *head)
 static void _remove_list_dev(struct device_list_opp *list_dev,
 			     struct device_opp *dev_opp)
 {
-	list_del(&list_dev->node);
+	list_del_rcu(&list_dev->node);
 	call_srcu(&dev_opp->srcu_head.srcu, &list_dev->rcu_head,
 		  _kfree_list_dev_rcu);
 }
-- 
1.9.1
