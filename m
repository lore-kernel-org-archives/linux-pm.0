From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH] MAINTAINERS: Add mailing list for the interconnect API
Date: Thu, 21 Mar 2019 17:50:50 +0200
Message-ID: <20190321155050.25847-1-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, georgi.djakov@linaro.org
List-Id: linux-pm@vger.kernel.org

Add a mailing list for patch reviews and discussions related to tuning
the on-chip interconnects. For now i am not expecting a lot of traffic,
so let's use the linux-pm@ list.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---

Hi Rafael,
Please ack the patch if you don't mind this.
Thanks!

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
