From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v4 3/4] mvebu: Dove: Enable cpufreq driver in defconfig
Date: Wed,  4 Dec 2013 15:17:20 +0100
Message-ID: <1386166641-7567-4-git-send-email-andrew@lunn.ch>
References: <1386166641-7567-1-git-send-email-andrew@lunn.ch>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:56588 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932358Ab3LDORr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 4 Dec 2013 09:17:47 -0500
In-Reply-To: <1386166641-7567-1-git-send-email-andrew@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>
Cc: linux-pm@vger.kernel.org, linux ARM <linux-arm-kernel@lists.infradead.org>, Andrew Lunn <andrew@lunn.ch>

Add cpufreq to dove_defconfig, so it is built by default.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 arch/arm/configs/dove_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/dove_defconfig b/arch/arm/configs/dove_defconfig
index 110105476848..3d9235017e89 100644
--- a/arch/arm/configs/dove_defconfig
+++ b/arch/arm/configs/dove_defconfig
@@ -22,6 +22,8 @@ CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
+CONFIG_CPU_FREQ=y
+CONFIG_CPU_FREQ_GOV_ONDEMAND=y
 CONFIG_VFP=y
 CONFIG_NET=y
 CONFIG_PACKET=y
-- 
1.8.5

