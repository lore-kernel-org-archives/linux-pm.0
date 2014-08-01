From: keita kobayashi <keita.kobayashi.ym@renesas.com>
Subject: [PATCH 6/6] ARM: shmobile: Enable CPUIdle configuration for shmobile_defconfig
Date: Fri, 1 Aug 2014 18:49:01 +0900
Message-ID: <53DB628D.4000900@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org, linux-pm@vger.kernel.org
Cc: horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, rjw@rjwysocki.net
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
---
 arch/arm/configs/shmobile_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 3b13614..63e57a5 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -149,6 +149,8 @@ CONFIG_NLS_ISO8859_1=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_ARM_UNWIND is not set
+CONFIG_CPU_IDLE=y
+CONFIG_ARM_SHMOBILE_CPUIDLE=y
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_GOV_COMMON=y
 CONFIG_CPU_FREQ_STAT=y
-- 
1.7.9.5
