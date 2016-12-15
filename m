From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH 1/2] cpu/hotplug: Clarify description of __cpuhp_setup_state() return value
Date: Thu, 15 Dec 2016 10:00:57 -0500
Message-ID: <1481814058-4799-2-git-send-email-boris.ostrovsky@oracle.com>
References: <1481814058-4799-1-git-send-email-boris.ostrovsky@oracle.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1481814058-4799-1-git-send-email-boris.ostrovsky@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, bigeasy@linutronix.de, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: linux-pm@vger.kernel.org

When ivoked with CPUHP_AP_ONLINE_DYN state __cpuhp_setup_state()
is expected to return positive value which is the hotplug state that
the routine assigns.

Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---

 kernel/cpu.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 217fd2e..5339aca 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1586,7 +1586,11 @@ int __cpuhp_state_add_instance(enum cpuhp_state state, struct hlist_node *node,
  * @startup:	startup callback function
  * @teardown:	teardown callback function
  *
- * Returns 0 if successful, otherwise a proper error code
+ * Returns:
+ *   On success:
+ *      Positive state number if @state is CPUHP_AP_ONLINE_DYN
+ *      0 for all other states
+ *   On failure: proper (negative) error code
  */
 int __cpuhp_setup_state(enum cpuhp_state state,
 			const char *name, bool invoke,
-- 
1.7.1
