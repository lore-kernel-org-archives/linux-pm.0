From: florian@mickler.org
Subject: [PATCH] pm_qos: remove unnecessary list-traversal
Date: Tue,  1 Jun 2010 10:46:54 +0200
Message-ID: <1275382014-10178-1-git-send-email-florian__46146.8229572803$1275382096$gmane$org@mickler.org>
References: <20100601090737.4bc243d9@schatten.dmk.lab>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100601090737.4bc243d9@schatten.dmk.lab>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: 640e9920@gmail.com, markgross@thegnar.org, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

The new extreme value is only depending on the old extreme value and
the changed value.

Signed-off-by: Florian Mickler <florian@mickler.org>
---
 kernel/pm_qos_params.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/kernel/pm_qos_params.c b/kernel/pm_qos_params.c
index f42d3f7..5d71c12 100644
--- a/kernel/pm_qos_params.c
+++ b/kernel/pm_qos_params.c
@@ -136,6 +136,16 @@ static s32 min_compare(s32 v1, s32 v2)
 }
 
 
+static void update_target_val(int pm_qos_class, s32 val)
+{
+	s32 extreme_value;
+	s32 new_value;
+	extreme_value = atomic_read(&pm_qos_array[pm_qos_class]->target_value);
+	new_value = pm_qos_array[pm_qos_class]->comparitor(val,extreme_value);
+	if (extreme_value != new_value)
+		atomic_set(&pm_qos_array[pm_qos_class]->target_value,new_value);
+}
+
 static void update_target(int pm_qos_class)
 {
 	s32 extreme_value;
@@ -253,19 +263,24 @@ void pm_qos_update_request(struct pm_qos_request_list *pm_qos_req,
 	s32 temp;
 
 	if (pm_qos_req) { /*guard against callers passing in null */
+		int target = pm_qos_req->pm_qos_class;
 		spin_lock_irqsave(&pm_qos_lock, flags);
 		if (new_value == PM_QOS_DEFAULT_VALUE)
-			temp = pm_qos_array[pm_qos_req->pm_qos_class]->default_value;
+			temp = pm_qos_array[target]->default_value;
 		else
 			temp = new_value;
 
 		if (temp != pm_qos_req->value) {
 			pending_update = 1;
 			pm_qos_req->value = temp;
+			update_target_val(target,temp);
 		}
 		spin_unlock_irqrestore(&pm_qos_lock, flags);
+
 		if (pending_update)
-			update_target(pm_qos_req->pm_qos_class);
+			blocking_notifier_call_chain(
+				pm_qos_array[pm_qos_class]->notifiers,
+					(unsigned long) temp, NULL);
 	}
 }
 EXPORT_SYMBOL_GPL(pm_qos_update_request);
-- 
1.7.1
