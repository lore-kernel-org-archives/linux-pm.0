From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [pm:bleeding-edge 182/211] warning: (DRM_PS8622 && ..) selects
 BACKLIGHT_CLASS_DEVICE which has unmet direct dependencies (HAS_IOMEM &&
 ..)
Date: Wed, 17 Jun 2015 09:25:10 +0200
Message-ID: <558120D6.3020509@redhat.com>
References: <201506170557.YRNvzGlT%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57783 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757689AbbFQHZN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 17 Jun 2015 03:25:13 -0400
In-Reply-To: <201506170557.YRNvzGlT%fengguang.wu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

Hi,

On 16-06-15 23:32, kbuild test robot wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
> head:   51fdad2e85fb18646ffc208535c9fa0e15ed8293
> commit: e6d42ec784d38a2fb70164c2ba6ae1c11e418668 [182/211] acpi-video-detect: video: Make video_detect code part of the video module
> config: ia64-defconfig (attached as .config)
> reproduce:
>    wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>    chmod +x ~/bin/make.cross
>    git checkout e6d42ec784d38a2fb70164c2ba6ae1c11e418668
>    # save the attached .config to linux build tree
>    make.cross ARCH=ia64
>
> All warnings (new ones prefixed by >>):
>
> warning: (DRM_PS8622 && DRM_RADEON && DRM_NOUVEAU && DRM_I915 && DRM_GMA500 && DRM_SHMOBILE && DRM_TILCDC && FB_BACKLIGHT && FB_MX3 && USB_APPLEDISPLAY && FB_OLPC_DCON && ACPI_CMPC && SAMSUNG_Q10) selects BACKLIGHT_CLASS_DEVICE which has unmet direct dependencies (HAS_IOMEM && BACKLIGHT_LCD_SUPPORT)

Ugh, it is not clear to me how this patch triggers this warning, it actually contains Kconfig fixes
for various other drivers to avoid this problem.

Anyways we will need to fix this, we can either go the intel 915 drm driver way (although that seems to
cause the warning too?) :

         # i915 depends on ACPI_VIDEO when ACPI is enabled
         # but for select to work, need to select ACPI_VIDEO's dependencies, ick
         select BACKLIGHT_LCD_SUPPORT if ACPI
         select BACKLIGHT_CLASS_DEVICE if ACPI
         select INPUT if ACPI
         select ACPI_VIDEO if ACPI
         select ACPI_BUTTON if ACPI

Or, which seems a better fix to me, we could make BACKLIGHT_CLASS_DEVICE
not fall under the BACKLIGHT_LCD_SUPPORT menu enable variable, since as
a class driver it is used in cases when there are no lcd-backlight drivers
too.

Regards,

Hans
