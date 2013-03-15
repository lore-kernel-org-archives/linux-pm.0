From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 48/50] staging: omap-thermal: remove TODO entry suggesting regmap usage
Date: Fri, 15 Mar 2013 09:00:36 -0400
Message-ID: <1363352438-15935-49-git-send-email-eduardo.valentin@ti.com>
References: <1363352438-15935-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1363352438-15935-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-pm@vger.kernel.org

It is hard to use regmap because benefit of using regmap cache
may not be applicable as there is a specific sequence to
restore the bandgap context.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/staging/omap-thermal/TODO |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/omap-thermal/TODO b/drivers/staging/omap-thermal/TODO
index 0f24e9b..91e2070 100644
--- a/drivers/staging/omap-thermal/TODO
+++ b/drivers/staging/omap-thermal/TODO
@@ -1,7 +1,6 @@
 List of TODOs (by Eduardo Valentin)
 
 on omap-bandgap.c:
-- Improve driver code by adding usage of regmap-mmio
 - Test every exposed API to userland
 - Add support to hwmon
 - Review and revisit all API exposed
-- 
1.7.7.1.488.ge8e1c

