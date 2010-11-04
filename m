From: Colin Cross <ccross@android.com>
Subject: [PATCH] pm_qos: Fix reversed min and max
Date: Wed,  3 Nov 2010 23:40:03 -0700
Message-ID: <1288852803-12356-1-git-send-email-ccross__28871.6350602501$1288852899$gmane$org@android.com>
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
To: linux-pm@lists.linux-foundation.org
Cc: mark gross <markgross@thegnar.org>, linux-kernel@vger.kernel.org, James Bottomley <James.Bottomley@suse.de>, Colin Cross <ccross@android.com>, stable <stable@kernel.org>
List-Id: linux-pm@vger.kernel.org

pm_qos_get_value had min and max reversed, causing all pm_qos
requests to have no effect.

Change-Id: I252c764821eac8d94de57eb482c05bf6afcea15b
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: mark gross <markgross@thegnar.org>
Cc: James Bottomley <James.Bottomley@suse.de>
Cc: stable <stable@kernel.org>
Signed-off-by: Colin Cross <ccross@android.com>
---
 kernel/pm_qos_params.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/pm_qos_params.c b/kernel/pm_qos_params.c
index 645e541..0da2837 100644
--- a/kernel/pm_qos_params.c
+++ b/kernel/pm_qos_params.c
@@ -120,10 +120,10 @@ static inline int pm_qos_get_value(struct pm_qos_object *o)
 
 	switch (o->type) {
 	case PM_QOS_MIN:
-		return plist_last(&o->requests)->prio;
+		return plist_first(&o->requests)->prio;
 
 	case PM_QOS_MAX:
-		return plist_first(&o->requests)->prio;
+		return plist_last(&o->requests)->prio;
 
 	default:
 		/* runtime check for not using enum */
-- 
1.7.3.1
