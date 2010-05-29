From: mark gross <640e9920@gmail.com>
Subject: [patch] complain when users abuse the pm_qos API
Date: Fri, 28 May 2010 21:50:27 -0700
Message-ID: <20100529045027.GE11600__33421.526689972$1275108665$gmane$org@gvim.org>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The following patch is to help clean up API abusers of pm_qos where
they call update_request before registering a request.

--mgross

--Signed-off-by: markgross <markgross@thegnar.org>


>From a0813007ddc7b72cb3da7a533fefba9889aab1d8 Mon Sep 17 00:00:00 2001
From: mgross <mgross@mgross-desktop.(none)>
Date: Fri, 28 May 2010 21:36:06 -0700
Subject: [PATCH] complain when users abuse the pm_qos API by updating a request that
 isn't registered yet.

---
 kernel/pm_qos_params.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/kernel/pm_qos_params.c b/kernel/pm_qos_params.c
index f42d3f7..8e55bf1 100644
--- a/kernel/pm_qos_params.c
+++ b/kernel/pm_qos_params.c
@@ -266,6 +266,10 @@ void pm_qos_update_request(struct pm_qos_request_list *pm_qos_req,
 		spin_unlock_irqrestore(&pm_qos_lock, flags);
 		if (pending_update)
 			update_target(pm_qos_req->pm_qos_class);
+	} else {
+		WARN(true, "pm_qos: updating an unregistered request "
+				"does nothing");
+		dump_stack();
 	}
 }
 EXPORT_SYMBOL_GPL(pm_qos_update_request);
-- 
1.7.0.4
