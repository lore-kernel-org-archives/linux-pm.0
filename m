From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/18] cpuidle: menu: fixed wrapping timers at
	4.294 seconds
Date: Sat, 02 Apr 2011 02:22:43 -0400
Message-ID: <c82cf78992a66bfa7f0c82aeb20ba6922127463b.1301724243.git.len.brown__46343.5939200737$1301726098$gmane$org@intel.com>
References: <alpine.LFD.2.02.1104010020280.2797@x980>
	<1301725380-10579-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1301725380-10579-1-git-send-email-lenb@kernel.org>
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
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, stable@kernel.org
List-Id: linux-pm@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

Cpuidle menu governor is using u32 as a temporary datatype for storing
nanosecond values which wrap around at 4.294 seconds. This causes errors
in predicted sleep times resulting in higher than should be C state
selection and increased power consumption. This also breaks cpuidle
state residency statistics.

cc: stable@kernel.org
Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/cpuidle/governors/menu.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index f508690..c47f3d0 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -237,6 +237,7 @@ static int menu_select(struct cpuidle_device *dev)
 	unsigned int power_usage = -1;
 	int i;
 	int multiplier;
+	struct timespec t;
 
 	if (data->needs_update) {
 		menu_update(dev);
@@ -251,8 +252,9 @@ static int menu_select(struct cpuidle_device *dev)
 		return 0;
 
 	/* determine the expected residency time, round up */
+	t = ktime_to_timespec(tick_nohz_get_sleep_length());
 	data->expected_us =
-	    DIV_ROUND_UP((u32)ktime_to_ns(tick_nohz_get_sleep_length()), 1000);
+		t.tv_sec * USEC_PER_SEC + t.tv_nsec / NSEC_PER_USEC;
 
 
 	data->bucket = which_bucket(data->expected_us);
-- 
1.7.5.rc0
