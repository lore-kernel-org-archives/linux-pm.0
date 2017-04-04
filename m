From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v5 1/5] PM / Domains: Add generic data pointer to genpd data
 struct
Date: Mon, 3 Apr 2017 21:47:28 -0500
Message-ID: <20170404024732.32699-2-d-gerlach@ti.com>
References: <20170404024732.32699-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170404024732.32699-1-d-gerlach@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Add a void *data pointer to struct generic_pm_domain_data. Because this
exists for each device associated with a genpd it will allow us to
assign per-device data if needed on a platform for control of that
specific device.

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 include/linux/pm_domain.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 5339ed5bd6f9..b213d22daefd 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -117,6 +117,7 @@ struct generic_pm_domain_data {
 	struct pm_domain_data base;
 	struct gpd_timing_data td;
 	struct notifier_block nb;
+	void *data;
 };
 
 #ifdef CONFIG_PM_GENERIC_DOMAINS
-- 
2.11.0
