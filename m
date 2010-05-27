From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/8] cpuidle: fail to register if !CONFIG_CPU_IDLE
Date: Wed, 26 May 2010 22:42:24 -0400
Message-ID: <e099975ca65a7f6ac7f8bc3fee84d3e03893aa31.1274926772.git.len.brown__10242.7568789155$1274929152$gmane$org@intel.com>
References: <1274928151-30919-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1274928151-30919-1-git-send-email-lenb@kernel.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: x86@kernel.org, linux-pm@lists.linux-foundation.org
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/linux/cpuidle.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index dcf77fa..0fe1efe 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -137,16 +137,16 @@ extern void cpuidle_disable_device(struct cpuidle_device *dev);
 #else
 
 static inline int cpuidle_register_driver(struct cpuidle_driver *drv)
-{return 0;}
+{return -ENODEV;}
 static inline void cpuidle_unregister_driver(struct cpuidle_driver *drv) { }
 static inline int cpuidle_register_device(struct cpuidle_device *dev)
-{return 0;}
+{return -ENODEV;}
 static inline void cpuidle_unregister_device(struct cpuidle_device *dev) { }
 
 static inline void cpuidle_pause_and_lock(void) { }
 static inline void cpuidle_resume_and_unlock(void) { }
 static inline int cpuidle_enable_device(struct cpuidle_device *dev)
-{return 0;}
+{return -ENODEV;}
 static inline void cpuidle_disable_device(struct cpuidle_device *dev) { }
 
 #endif
-- 
1.6.0.6
