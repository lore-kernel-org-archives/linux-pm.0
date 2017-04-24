From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH] drm/etnaviv: add thermal dependency
Date: Mon, 24 Apr 2017 12:44:54 +0200
Message-ID: <1493030694.2891.10.camel@pengutronix.de>
References: <20170419181209.537907-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:45179 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1168301AbdDXKpC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Apr 2017 06:45:02 -0400
In-Reply-To: <20170419181209.537907-1-arnd@arndb.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Airlie <airlied@linux.ie>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, Sujith Thomas <sujith.thomas@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Russell King <linux+etnaviv@armlinux.org.uk>, Christian Gmeiner <christian.gmeiner@gmail.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org

Am Mittwoch, den 19.04.2017, 20:11 +0200 schrieb Arnd Bergmann:
> When CONFIG_THERMAL is enabled as a loadable module, and etnaviv is
> built-in, we get a link error:
> 
> drivers/gpu/drm/etnaviv/etnaviv_gpu.o: In function `etnaviv_gpu_bind':
> etnaviv_gpu.c:(.text.etnaviv_gpu_bind+0x34): undefined reference to `thermal_of_cooling_device_register'
> etnaviv_gpu.c:(.text.etnaviv_gpu_bind+0xe0): undefined reference to `thermal_cooling_device_unregister'
> drivers/gpu/drm/etnaviv/etnaviv_gpu.o: In function `etnaviv_gpu_unbind':
> etnaviv_gpu.c:(.text.etnaviv_gpu_unbind+0xf0): undefined reference to `thermal_cooling_device_unregister'
> 
> This adds a Kconfig dependency to prevent etnaviv from being built-in
> with CONFIG_THERMAL=m, while still allowing the valid configurations.
> Unfortunately, simply adding the dependency here breaks Kconfig through
> a dependency loop involving lots of symbols all the way until ACPI_VIDEO,
> which is the only video driver that explicitly selects 'THERMAL'. Turning
> this into a 'depends on' addresses the problem.
> For completeness, I'm also removing the redundant 'select THERMAL'
> from INTEL_MENLOW, so no other driver uses that statement.
> 
> Fixes: bcdfb5e56dc5 ("drm/etnaviv: add etnaviv cooling device")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

This patch mixes a few things, so the subject doesn't really fit. I'm
fine with taking the patch trough my tree, if I can get an ACK on the
ACPI part.

Regards,
Lucas

> ---
>  drivers/acpi/Kconfig            | 2 +-
>  drivers/gpu/drm/etnaviv/Kconfig | 1 +
>  drivers/platform/x86/Kconfig    | 1 -
>  3 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 03cc4e74096b..252399efa8b3 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -184,7 +184,7 @@ config ACPI_VIDEO
>  	tristate "Video"
>  	depends on X86 && BACKLIGHT_CLASS_DEVICE
>  	depends on INPUT
> -	select THERMAL
> +	depends on THERMAL
>  	help
>  	  This driver implements the ACPI Extensions For Display Adapters
>  	  for integrated graphics devices on motherboard, as specified in
> diff --git a/drivers/gpu/drm/etnaviv/Kconfig b/drivers/gpu/drm/etnaviv/Kconfig
> index 71cee4e9fefb..1d6c744e7924 100644
> --- a/drivers/gpu/drm/etnaviv/Kconfig
> +++ b/drivers/gpu/drm/etnaviv/Kconfig
> @@ -3,6 +3,7 @@ config DRM_ETNAVIV
>  	tristate "ETNAVIV (DRM support for Vivante GPU IP cores)"
>  	depends on DRM
>  	depends on ARCH_MXC || ARCH_DOVE || (ARM && COMPILE_TEST)
> +	depends on THERMAL || THERMAL=n
>  	depends on MMU
>  	select SHMEM
>  	select SYNC_FILE
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index e229ea317b9c..76ced87efde5 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -544,7 +544,6 @@ config SENSORS_HDAPS
>  config INTEL_MENLOW
>  	tristate "Thermal Management driver for Intel menlow platform"
>  	depends on ACPI_THERMAL
> -	select THERMAL
>  	---help---
>  	  ACPI thermal management enhancement driver on
>  	  Intel Menlow platform.
