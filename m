From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpuidle: governor: Add new governors to cpuidle_governors again
Date: Tue, 12 Mar 2019 19:13:13 +0100
Message-ID: <5539737.TtKXfUnNfs@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit 61cb5758d3c4 ("cpuidle: Add cpuidle.governor= command
line parameter") new cpuidle governors are not added to the list
of available governors, so governor selection via sysfs doesn't
work as expected (even though it is rarely used anyway).

Fix that by making cpuidle_register_governor() add new governors to
cpuidle_governors again.

Fixes: 61cb5758d3c4 ("cpuidle: Add cpuidle.governor= command line parameter")
Reported-by: Kees Cook <keescook@chromium.org>
Cc: 5.0+ <stable@vger.kernel.org> # 5.0+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governor.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-pm/drivers/cpuidle/governor.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governor.c
+++ linux-pm/drivers/cpuidle/governor.c
@@ -89,6 +89,7 @@ int cpuidle_register_governor(struct cpu
 	mutex_lock(&cpuidle_lock);
 	if (__cpuidle_find_governor(gov->name) == NULL) {
 		ret = 0;
+		list_add_tail(&gov->governor_list, &cpuidle_governors);
 		if (!cpuidle_curr_governor ||
 		    !strncasecmp(param_governor, gov->name, CPUIDLE_NAME_LEN) ||
 		    (cpuidle_curr_governor->rating < gov->rating &&
