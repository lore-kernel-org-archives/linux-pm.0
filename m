From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 2/4] PM / devfreq: exynos-nocp: Fix module autoload
Date: Wed, 19 Oct 2016 18:06:25 -0300
Message-ID: <1476911187-11040-3-git-send-email-javier@osg.samsung.com>
References: <1476911187-11040-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1476911187-11040-1-git-send-email-javier@osg.samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

If the driver is built as a module, autoload won't work because the module
alias information is not filled. So user-space can't match the registered
device with the corresponding module.

Export the module alias information using the MODULE_DEVICE_TABLE() macro.

Before this patch:

$ modinfo drivers/devfreq/event/exynos-nocp.ko | grep alias
$

After this patch:

$ modinfo drivers/devfreq/event/exynos-nocp.ko | grep alias
alias:          of:N*T*Csamsung,exynos5420-nocpC*
alias:          of:N*T*Csamsung,exynos5420-nocp

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/devfreq/event/exynos-nocp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/devfreq/event/exynos-nocp.c b/drivers/devfreq/event/exynos-nocp.c
index 49e712aca0c1..5c3e7b11e8a6 100644
--- a/drivers/devfreq/event/exynos-nocp.c
+++ b/drivers/devfreq/event/exynos-nocp.c
@@ -190,6 +190,7 @@ static const struct of_device_id exynos_nocp_id_match[] = {
 	{ .compatible = "samsung,exynos5420-nocp", },
 	{ /* sentinel */ },
 };
+MODULE_DEVICE_TABLE(of, exynos_nocp_id_match);
 
 static struct regmap_config exynos_nocp_regmap_config = {
 	.reg_bits = 32,
-- 
2.7.4
