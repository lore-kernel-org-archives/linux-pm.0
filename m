From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH v2] MAINTAINERS: Add mailing list for the interconnect API
Date: Fri, 22 Mar 2019 12:04:41 +0200
Message-ID: <20190322100441.6315-1-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, evgreen@chromium.org, daidavid1@codeaurora.org, georgi.djakov@linaro.org, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

Add a mailing list for patch reviews and discussions related to tuning
the on-chip interconnects. For now i am not expecting a lot of traffic,
so let's use the linux-pm@ list.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---

Hi Greg,
Can you please pick this fix for the next possible -rc, so people can
know where to send patches. Thanks!
Georgi

Changes since v1 (https://lore.kernel.org/lkml/20190321155050.25847-1-georgi.djakov@linaro.org/)
- Picked Rafael's Ack.

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e17ebf70b548..186439e7f846 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8046,6 +8046,7 @@ F:	drivers/gpio/gpio-intel-mid.c
 
 INTERCONNECT API
 M:	Georgi Djakov <georgi.djakov@linaro.org>
+L:	linux-pm@vger.kernel.org
 S:	Maintained
 F:	Documentation/interconnect/
 F:	Documentation/devicetree/bindings/interconnect/
