From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/4] IOMMU: Make dwo drivers use stateless device links
Date: Tue, 29 Jan 2019 00:05:21 +0100
Message-ID: <3532356.d9GMSSLOvP@aspire.rjw.lan>
References: <2405639.4es7pRLqn0@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2405639.4es7pRLqn0@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joerg Roedel <jroedel@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>, Andrzej Hajda <a.hajda@samsung.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Lucas Stach <l.stach@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jeffy Chen <jeffy.chen@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The device links used by rockchip-iommu and exynos-iommu are
completely managed by these drivers within the IOMMU framework,
so there is no reason to involve the driver core in the management
of these links.

For this reason, make rockchip-iommu and exynos-iommu pass
DL_FLAG_STATELESS in flags to device_link_add(), so that the device
links used by them are stateless.

[Note that this change is requisite for a subsequent one that will
 rework the management of stateful device links in the driver core
 and it will not be compatible with the two drivers in question any
 more.]

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/iommu/exynos-iommu.c   |    1 +
 drivers/iommu/rockchip-iommu.c |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/iommu/rockchip-iommu.c
===================================================================
--- linux-pm.orig/drivers/iommu/rockchip-iommu.c
+++ linux-pm/drivers/iommu/rockchip-iommu.c
@@ -1071,7 +1071,8 @@ static int rk_iommu_add_device(struct de
 	iommu_group_put(group);
 
 	iommu_device_link(&iommu->iommu, dev);
-	data->link = device_link_add(dev, iommu->dev, DL_FLAG_PM_RUNTIME);
+	data->link = device_link_add(dev, iommu->dev,
+				     DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME);
 
 	return 0;
 }
Index: linux-pm/drivers/iommu/exynos-iommu.c
===================================================================
--- linux-pm.orig/drivers/iommu/exynos-iommu.c
+++ linux-pm/drivers/iommu/exynos-iommu.c
@@ -1260,6 +1260,7 @@ static int exynos_iommu_add_device(struc
 		 * direct calls to pm_runtime_get/put in this driver.
 		 */
 		data->link = device_link_add(dev, data->sysmmu,
+					     DL_FLAG_STATELESS |
 					     DL_FLAG_PM_RUNTIME);
 	}
 	iommu_group_put(group);
