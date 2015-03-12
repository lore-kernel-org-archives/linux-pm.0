From: Kevin Hilman <khilman@kernel.org>
Subject: [PATCH] MAINTAINERS: add entry for Generic PM domains (genpd)
Date: Thu, 12 Mar 2015 10:33:46 -0700
Message-ID: <1426181626-18218-1-git-send-email-khilman@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Add entry for genpd with Rafael, myself and Ulf as co-maintainers.

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Kevin Hilman <khilman@kernel.org>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6239a305dff0..4c4a03f230f3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4294,6 +4294,15 @@ S:	Supported
 F:	drivers/phy/
 F:	include/linux/phy/
 
+GENERIC PM DOMAINS
+M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
+M:	Kevin Hilman <khilman@kernel.org>
+M:	Ulf Hansson <ulf.hansson@linaro.org>
+L:	linux-pm@vger.kernel.org
+S:	Supported
+F:	drivers/base/power/domain*.c
+F:	include/linux/pm_domain.h
+
 GENERIC UIO DRIVER FOR PCI DEVICES
 M:	"Michael S. Tsirkin" <mst@redhat.com>
 L:	kvm@vger.kernel.org
-- 
2.3.1
