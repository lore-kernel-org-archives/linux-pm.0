From: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Subject: [RFC/PATCH 4/4] ARM: shmobile: Enable Renesas R-Car cpuidle for shmobile_defconfig
Date: Mon, 6 Apr 2015 12:50:44 +0900
Message-ID: <1428292244-2160-5-git-send-email-keita.kobayashi.ym@renesas.com>
References: <1428292244-2160-1-git-send-email-keita.kobayashi.ym@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1428292244-2160-1-git-send-email-keita.kobayashi.ym@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: horms@verge.net.au, rjw@rjwysocki.net, daniel.lezcano@linaro.org
Cc: linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, magnus.damm@gmail.com, Keita Kobayashi <keita.kobayashi.ym@renesas.com>
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
---
 arch/arm/configs/shmobile_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index b58618e..e487045 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -44,6 +44,8 @@ CONFIG_CPU_FREQ_GOV_USERSPACE=y
 CONFIG_CPU_FREQ_GOV_ONDEMAND=y
 CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
 CONFIG_CPUFREQ_DT=y
+CONFIG_CPU_IDLE=y
+CONFIG_ARM_RCAR_CPUIDLE=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
-- 
1.9.1

