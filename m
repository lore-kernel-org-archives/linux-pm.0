From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] drm/etnaviv: add thermal dependency
Date: Mon, 24 Apr 2017 19:39:27 +0200
Message-ID: <CAK8P3a39B5C9ZcE7ZBMe9FaoTiBP5Dp4o_25V05nC5O8J+fTrg@mail.gmail.com>
References: <20170419181209.537907-1-arnd@arndb.de> <1493030694.2891.10.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1493030694.2891.10.camel@pengutronix.de>
Sender: linux-acpi-owner@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: David Airlie <airlied@linux.ie>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, Sujith Thomas <sujith.thomas@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Russell King <linux+etnaviv@armlinux.org.uk>, Christian Gmeiner <christian.gmeiner@gmail.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, etnaviv@lists.freedesktop.org, dri-devel <dri-devel@lists.freedesktop.org>, platform-driver-x86@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 24, 2017 at 12:44 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Am Mittwoch, den 19.04.2017, 20:11 +0200 schrieb Arnd Bergmann:
>> When CONFIG_THERMAL is enabled as a loadable module, and etnaviv is
>> built-in, we get a link error:
>>
>> drivers/gpu/drm/etnaviv/etnaviv_gpu.o: In function `etnaviv_gpu_bind':
>> etnaviv_gpu.c:(.text.etnaviv_gpu_bind+0x34): undefined reference to `thermal_of_cooling_device_register'
>> etnaviv_gpu.c:(.text.etnaviv_gpu_bind+0xe0): undefined reference to `thermal_cooling_device_unregister'
>> drivers/gpu/drm/etnaviv/etnaviv_gpu.o: In function `etnaviv_gpu_unbind':
>> etnaviv_gpu.c:(.text.etnaviv_gpu_unbind+0xf0): undefined reference to `thermal_cooling_device_unregister'
>>
>> This adds a Kconfig dependency to prevent etnaviv from being built-in
>> with CONFIG_THERMAL=m, while still allowing the valid configurations.
>> Unfortunately, simply adding the dependency here breaks Kconfig through
>> a dependency loop involving lots of symbols all the way until ACPI_VIDEO,
>> which is the only video driver that explicitly selects 'THERMAL'. Turning
>> this into a 'depends on' addresses the problem.
>> For completeness, I'm also removing the redundant 'select THERMAL'
>> from INTEL_MENLOW, so no other driver uses that statement.
>>
>> Fixes: bcdfb5e56dc5 ("drm/etnaviv: add etnaviv cooling device")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> This patch mixes a few things, so the subject doesn't really fit. I'm
> fine with taking the patch trough my tree, if I can get an ACK on the
> ACPI part.

Actually the ACPI part triggered a new warning that I haven't figured
out completely yet. Please disregard my patch for the moment.

I think we can just drop the dependency in ACPI_VIDEO, but I'm not
entirely sure yet if we could hit a broken configuration with THERMAL=m
and ACPI_VIDEO=y in that case. Unfortunately we cannot use the
same trick in ACPI_VIDEO that I used for ETNAVIV, because of
another circular dependency in ACPI.

        Arnd
