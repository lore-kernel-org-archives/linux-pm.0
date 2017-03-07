From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v4 2/5] PM / Domains: Do not check if simple providers have
 phandle cells
Date: Tue, 7 Mar 2017 04:22:31 -0600
Message-ID: <1488882154-21485-3-git-send-email-d-gerlach@ti.com>
References: <1488882154-21485-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1488882154-21485-1-git-send-email-d-gerlach@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

There is no reason that a platform genpd driver registered using
of_genpd_add_provider_simple needs to be constrained to having no cells
in the "power-domains" phandle. Currently the genpd framework will fail
if any arguments are passed with for a simple provider but the framework
does not actually care, so remove the check for phandle argument count.

This will allow greater flexibility for genpd providers to use their own
arguments that are passed in the phandle and interpret them however they
see fit.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
v3->v4:
 Drop ti,sci-id device property and instead describe using phandle cell
 for id.

 drivers/base/power/domain.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index e697dec9d25b..8e0550c27394 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1622,8 +1622,6 @@ static struct generic_pm_domain *genpd_xlate_simple(
 					struct of_phandle_args *genpdspec,
 					void *data)
 {
-	if (genpdspec->args_count != 0)
-		return ERR_PTR(-EINVAL);
 	return data;
 }
 
-- 
2.11.0
