From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH] Thermal: int3406_thermal: solve the dependency build error
Date: Thu, 16 Oct 2014 16:58:38 +0800
Message-ID: <543F88BE.4090307@intel.com>
References: <CA+r1ZhhoskOXaRSmcrnbdgapi-FsaKf+dnPHTXGkDvkYbvwQ8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+r1ZhhoskOXaRSmcrnbdgapi-FsaKf+dnPHTXGkDvkYbvwQ8Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jim Davis <jim.epost@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next <linux-next@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 10/13/2014 10:43 PM, Jim Davis wrote:
> Building with the attached random configuration file,
> 
> drivers/built-in.o: In function `int3406_thermal_probe':
> int3406_thermal.c:(.text+0x1d10b8): undefined reference to
> `acpi_video_get_levels'
> make: *** [vmlinux] Error 1

Thanks for the report Jim, below patch should fix this problem:

From: Aaron Lu <aaron.lu@intel.com>
Date: Thu, 16 Oct 2014 16:35:02 +0800
Subject: [PATCH] Thermal: int3406_thermal: solve the dependency build error

Jim found that the current kernel may trigger a build error with some
config: drivers/built-in.o: In function `int3406_thermal_probe':
int3406_thermal.c:(.text+0x1d10b8): undefined reference to
`acpi_video_get_levels'. The problem happens when CONFIG_THERMAL=y and
CONFIG_ACPI_VIDEO=m. Since the ACPI video driver can still work well
without CONFIG_THERMAL(regarding its main functionality: backlight
control), solve the problem by removing the select THERMAL line for
ACPI_VIDEO and adding the select ACPI_VIDEO for INT340X_THERMAL. The
result is that for kernels that do not have CONFIG_THERMAL selected now,
the ACPI video driver will not create the cooling device as it did
before(but works well otherwise).

Reported-by: Jim Davis <jim.epost@gmail.com>
Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/acpi/Kconfig    | 1 -
 drivers/thermal/Kconfig | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index b23fe37f67c0..8a09f98dbb0c 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -131,7 +131,6 @@ config ACPI_VIDEO
 	tristate "Video"
 	depends on X86 && BACKLIGHT_CLASS_DEVICE
 	depends on INPUT
-	select THERMAL
 	help
 	  This driver implements the ACPI Extensions For Display Adapters
 	  for integrated graphics devices on motherboard, as specified in
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 9b012ff65220..4e1053a8d774 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -235,6 +235,7 @@ config INT340X_THERMAL
 	select THERMAL_GOV_USER_SPACE
 	select ACPI_THERMAL_REL
 	select ACPI_FAN
+	select ACPI_VIDEO
 	help
 	  Newer laptops and tablets that use ACPI may have thermal sensors and
 	  other devices with thermal control capabilities outside the core
-- 
1.9.3
