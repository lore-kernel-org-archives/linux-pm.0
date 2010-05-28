From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/8] cpuidle: fail to register if !CONFIG_CPU_IDLE
Date: Fri, 28 May 2010 02:01:54 -0400
Message-ID: <6b2c676bf32be91f43215d5874c07c1becaba013.1275026041.git.len.brown@intel.com>
References: <1275026521-30835-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1275026521-30835-1-git-send-email-lenb@kernel.org>
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
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/linux/cpuidle.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index dcf77fa..f5e6480 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -137,16 +137,16 @@ extern void cpuidle_disable_device(struct cpuidle_device *dev);
 #else
 
 static inline int cpuidle_register_driver(struct cpuidle_driver *drv)
-{return 0;}
+{return -ENODEV; }
 static inline void cpuidle_unregister_driver(struct cpuidle_driver *drv) { }
 static inline int cpuidle_register_device(struct cpuidle_device *dev)
-{return 0;}
+{return -ENODEV; }
 static inline void cpuidle_unregister_device(struct cpuidle_device *dev) { }
 
 static inline void cpuidle_pause_and_lock(void) { }
 static inline void cpuidle_resume_and_unlock(void) { }
 static inline int cpuidle_enable_device(struct cpuidle_device *dev)
-{return 0;}
+{return -ENODEV; }
 static inline void cpuidle_disable_device(struct cpuidle_device *dev) { }
 
 #endif
-- 
1.6.0.6
