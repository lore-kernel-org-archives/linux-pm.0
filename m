From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 28/30] MAINTAINERS: update thermal entry by adding file cpu_cooling.h
Date: Wed, 17 Apr 2013 13:12:21 -0400
Message-ID: <1366218743-20841-29-git-send-email-eduardo.valentin@ti.com>
References: <1366218743-20841-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1366218743-20841-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: amit.kachhap@linaro.org
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Add cpu_cooling.h to thermal entry in MAINTAINERS.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 05dd187..3e075dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8011,6 +8011,7 @@ T:      git git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git
 S:      Supported
 F:      drivers/thermal/
 F:      include/linux/thermal.h
+F:      include/linux/cpu_cooling.h
 
 THINGM BLINK(1) USB RGB LED DRIVER
 M:	Vivien Didelot <vivien.didelot@savoirfairelinux.com>
-- 
1.8.2.1.342.gfa7285d
