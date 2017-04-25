From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] PM / Domains: Add DT file to MAINTAINERS
Date: Tue, 25 Apr 2017 12:52:10 +0530
Message-ID: <464469671a1b407737ee28aa41447178366ddb7c.1493104829.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:34906 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933793AbdDYHWW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Apr 2017 03:22:22 -0400
Received: by mail-pg0-f46.google.com with SMTP id 72so24171179pge.2
        for <linux-pm@vger.kernel.org>; Tue, 25 Apr 2017 00:22:22 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>

Add the power_domain.txt DT file to MAINTAINERS, otherwise
get_maintainers.pl doesn't pick the right set of maintainers for changes
to the DT file.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 67280051e30a..55b9ca2d5b98 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5610,6 +5610,7 @@ L:	linux-pm@vger.kernel.org
 S:	Supported
 F:	drivers/base/power/domain*.c
 F:	include/linux/pm_domain.h
+F:	Documentation/devicetree/bindings/power/power_domain.txt
 
 GENERIC UIO DRIVER FOR PCI DEVICES
 M:	"Michael S. Tsirkin" <mst@redhat.com>
-- 
2.12.0.432.g71c3a4f4ba37
