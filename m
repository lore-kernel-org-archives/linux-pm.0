From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 12/54] MAINTAINERS: Add file patterns for cpufreq device tree bindings
Date: Sun, 22 May 2016 11:05:49 +0200
Message-ID: <1463907991-7916-13-git-send-email-geert@linux-m68k.org>
References: <1463907991-7916-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463907991-7916-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Submitters of device tree binding documentation may forget to CC
the subsystem maintainer if this is missing.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
---
Please apply this patch directly if you want to be involved in device
tree binding documentation for your subsystem.
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4c9f31233670e9dd..b241c14d9ab57e2a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3213,6 +3213,7 @@ L:	linux-pm@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 T:	git git://git.linaro.org/people/vireshk/linux.git (For ARM Updates)
+F:	Documentation/devicetree/bindings/cpufreq/
 F:	drivers/cpufreq/
 F:	include/linux/cpufreq.h
 
-- 
1.9.1
