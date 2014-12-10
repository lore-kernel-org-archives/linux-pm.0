From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v5] Thermal: introduce INT3406 thermal driver
Date: Wed, 10 Dec 2014 11:53:25 -0800
Message-ID: <CAOesGMirF-_H2ZzFR-VpwkEErZE2uQJSYx5EuePArQsEh=r_Kw@mail.gmail.com>
References: <54868CF6.6020505@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <54868CF6.6020505@intel.com>
Sender: linux-next-owner@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Zhang Rui <rui.zhang@intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next <linux-next@vger.kernel.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-pm@vger.kernel.org

Hi,

[+daniel vetter]

On Mon, Dec 8, 2014 at 9:47 PM, Aaron Lu <aaron.lu@intel.com> wrote:
> INT3406 ACPI device object resembles an ACPI video output device, but its
> _BCM is said to be deprecated and should not be used. So we will make
> use of the raw interface to do the actual cooling. Due to this, the
> backlight core has some modifications. Also, to re-use some of the ACPI
> video module's code, one function has been exported.
>
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
> v5:
> Add the missing file drivers/thermal/int340x_thermal/Kconfig
> Remove the assignment of .owner field from the device_driver structure


Did this patch show up in -next for the first time last night, or did
some other change break this?

It causes a panic in i915 when booting Minnowboard Max for me.


Bootlog with panic is at:

http://arm-soc.lixom.net/bootlogs/next/next-20141210/minnowmax-x86-minnowmax_defconfig.html

I bisected and verified that reverting this patch makes the system boot again.


-Olof
