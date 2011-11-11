From: =?ks_c_5601-1987?B?w9bC+b/s?= <cw00.choi@samsung.com>
Subject: [RFC PATCH] PM / Domains: Allow devices to generic pm
 domain regardless of power domain state
Date: Fri, 11 Nov 2011 13:49:21 +0900
Message-ID: <004801cca02d$474c0a80$d5e41f80$%choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-language: ko
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: rjw@sisk.pl
Cc: linux-pm@lists.linux-foundation.org, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com
List-Id: linux-pm@vger.kernel.org

This patch allow devices to generic pm domain without reference
to the state of pm domains.

Generic PM domain framework can add devices to pm domain with GPD_STATE_ACTIVE
state.

If I don't want to enable the specific pm domain during kernel boot for power
saving,
so I can't add device to specific pm domain. Usually, the works ,which
initialize pm domain
and add device to pm domain, is operated during early kernel boot.

I think that we allow device to pm domain regardless of the state of pm domain
and
pm domain have to be enabled when devices included in pm domain executes
probe() or runtime pm.

Please let me know reason that why should we enable the pm domain when add
devices to it?

Best regards,
Chanwoo Choi

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Singed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Singed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/base/power/domain.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 6790cf7..3ee34ad 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1093,11 +1093,6 @@ int pm_genpd_add_device(struct generic_pm_domain *genpd,
struct device *dev)
 
 	genpd_acquire_lock(genpd);
 
-	if (genpd->status == GPD_STATE_POWER_OFF) {
-		ret = -EINVAL;
-		goto out;
-	}
-
 	if (genpd->prepared_count > 0) {
 		ret = -EAGAIN;
 		goto out;
-- 
1.7.0.4
