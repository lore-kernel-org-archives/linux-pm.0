From: Rob Herring <robherring2@gmail.com>
Subject: [PATCH 1/2] cpufreq: enable ARM drivers on arm64
Date: Wed,  4 Dec 2013 18:23:13 -0600
Message-ID: <1386202994-30784-2-git-send-email-robherring2@gmail.com>
References: <1386202994-30784-1-git-send-email-robherring2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1386202994-30784-1-git-send-email-robherring2@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <rob.herring@calxeda.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

From: Rob Herring <rob.herring@calxeda.com>

Enable cpufreq and power kconfig menus on arm64 along with arm cpufreq
drivers. The power menu is needed for OPP support. At least on Calxeda
systems, the same cpufreq driver is used for arm and arm64 based
systems.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: cpufreq@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
 arch/arm64/Kconfig      | 8 ++++++++
 drivers/cpufreq/Kconfig | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 88c8b6c1..1808dd1 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -276,6 +276,14 @@ config SYSVIPC_COMPAT
 
 endmenu
 
+menu "Power management options"
+
+source "kernel/power/Kconfig"
+
+source "drivers/cpufreq/Kconfig"
+
+endmenu
+
 source "net/Kconfig"
 
 source "drivers/Kconfig"
diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 38093e2..e26fdcd 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -195,7 +195,7 @@ source "drivers/cpufreq/Kconfig.x86"
 endmenu
 
 menu "ARM CPU frequency scaling drivers"
-depends on ARM
+depends on ARM || ARM64
 source "drivers/cpufreq/Kconfig.arm"
 endmenu
 
-- 
1.8.3.2
