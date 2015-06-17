From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [pm:bleeding-edge 182/211] warning: (DRM_PS8622 && ..) selects
 BACKLIGHT_CLASS_DEVICE which has unmet direct dependencies (HAS_IOMEM && ..)
Date: Thu, 18 Jun 2015 01:13:43 +0200
Message-ID: <CAJZ5v0j+oULP9DdzSbH0Xj8cxa3p6pzFsXWtJDYcr6oTqWFvMw@mail.gmail.com>
References: <201506170557.YRNvzGlT%fengguang.wu@intel.com>
	<558120D6.3020509@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:37615 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754204AbbFQXNo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jun 2015 19:13:44 -0400
Received: by wifx6 with SMTP id x6so69597184wif.0
        for <linux-pm@vger.kernel.org>; Wed, 17 Jun 2015 16:13:43 -0700 (PDT)
In-Reply-To: <558120D6.3020509@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Wed, Jun 17, 2015 at 9:25 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 16-06-15 23:32, kbuild test robot wrote:
>>
>> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
>> bleeding-edge
>> head:   51fdad2e85fb18646ffc208535c9fa0e15ed8293
>> commit: e6d42ec784d38a2fb70164c2ba6ae1c11e418668 [182/211]
>> acpi-video-detect: video: Make video_detect code part of the video module
>> config: ia64-defconfig (attached as .config)
>> reproduce:
>>    wget
>> https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross
>> -O ~/bin/make.cross
>>    chmod +x ~/bin/make.cross
>>    git checkout e6d42ec784d38a2fb70164c2ba6ae1c11e418668
>>    # save the attached .config to linux build tree
>>    make.cross ARCH=ia64
>>
>> All warnings (new ones prefixed by >>):
>>
>> warning: (DRM_PS8622 && DRM_RADEON && DRM_NOUVEAU && DRM_I915 &&
>> DRM_GMA500 && DRM_SHMOBILE && DRM_TILCDC && FB_BACKLIGHT && FB_MX3 &&
>> USB_APPLEDISPLAY && FB_OLPC_DCON && ACPI_CMPC && SAMSUNG_Q10) selects
>> BACKLIGHT_CLASS_DEVICE which has unmet direct dependencies (HAS_IOMEM &&
>> BACKLIGHT_LCD_SUPPORT)
>
>
> Ugh, it is not clear to me how this patch triggers this warning, it actually
> contains Kconfig fixes
> for various other drivers to avoid this problem.

It may just modify a file where the problem is already present.

> Anyways we will need to fix this, we can either go the intel 915 drm driver
> way (although that seems to
> cause the warning too?) :
>
>         # i915 depends on ACPI_VIDEO when ACPI is enabled
>         # but for select to work, need to select ACPI_VIDEO's dependencies,
> ick
>         select BACKLIGHT_LCD_SUPPORT if ACPI
>         select BACKLIGHT_CLASS_DEVICE if ACPI
>         select INPUT if ACPI
>         select ACPI_VIDEO if ACPI
>         select ACPI_BUTTON if ACPI
>
> Or, which seems a better fix to me, we could make BACKLIGHT_CLASS_DEVICE
> not fall under the BACKLIGHT_LCD_SUPPORT menu enable variable, since as
> a class driver it is used in cases when there are no lcd-backlight drivers
> too.

That sounds good to me.

Thanks,
Rafael
