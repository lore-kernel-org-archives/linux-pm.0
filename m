From: Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH] MAINTAINERS: add maintainer for tools/power/cpupower
Date: Thu,  2 Nov 2017 13:19:47 -0600
Message-ID: <20171102191947.18486-1-shuahkh@osg.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from osg.samsung.com ([64.30.133.232]:53478 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932571AbdKBTTz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 Nov 2017 15:19:55 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rafael@kernel.org, trenn@suse.com
Cc: Shuah Khan <shuahkh@osg.samsung.com>, davem@davemloft.net, gregkh@linuxfoundation.org, mchehab@kernel.org, rdunlap@infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Based on discussions with Rafael J. Wysocki, cpupower is need of an
active maintainer. I decided to on take the task of maintaining this
tool.

Patches will flow through the pm sub-systems to the mainline.

Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index af0cb69f6a3e..9fd3ce23095a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3636,6 +3636,8 @@ F:	drivers/cpufreq/arm_big_little_dt.c
 
 CPU POWER MONITORING SUBSYSTEM
 M:	Thomas Renninger <trenn@suse.com>
+M:	Shuah Khan <shuahkh@osg.samsung.com>
+M:	Shuah Khan <shuah@kernel.org>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
 F:	tools/power/cpupower/
-- 
2.11.0
