From: Amit Kucheria <amit.kucheria@verdurent.com>
Subject: Re: [PATCH 1/7] thermal/drivers/core: Remove the module Kconfig's option
Date: Wed, 24 Apr 2019 11:15:05 +0530
Message-ID: <CAHLCerOs-8pAZFvEpxc-ktNV631LaLEmjCyObsYKKC0U29kLag@mail.gmail.com>
References: <20190402161256.11044-1-daniel.lezcano@linaro.org> <20190423155208.GC16014@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423155208.GC16014@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Guenter Roeck <groeck@chromium.org>, Krzysztof Kozlowski <krzk@kernel.org>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Guan Xuetao <gxt@pku.edu.cn>, Andrew Morton <akpm@linux-foundation.org>, Alexey Brodkin <alexey.brodkin@synopsys.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Arnd Bergmann <arnd@arndb.de>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Daniel Mack <daniel@zonque.org>, "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, "open list:MIPS" <linux-mips@vger.kernel>
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 23, 2019 at 9:22 PM Eduardo Valentin <edubezval@gmail.com> wrote:
>
> Hello,
>
> On Tue, Apr 02, 2019 at 06:12:44PM +0200, Daniel Lezcano wrote:
> > The module support for the thermal subsystem makes little sense:
> >  - some subsystems relying on it are not modules, thus forcing the
> >    framework to be compiled in
> >  - it is compiled in for almost every configs, the remaining ones
> >    are a few platforms where I don't see why we can not switch the thermal
> >    to 'y'. The drivers can stay in tristate.
> >  - platforms need the thermal to be ready as soon as possible at boot time
> >    in order to mitigate
> >
> > Usually the subsystems framework are compiled-in and the plugs are as module.
> >
> > Remove the module option. The removal of the module related dead code will
> > come after this patch gets in or is acked.
>
>
> I remember some buzilla entry around this some time back.
>
> Rui, do you remember why you made this to be module?
>
> I dont have strong opinion here, but I would like to see
> a better description why we are going this direction rather
> than "most people dont use it as module". Was there any particular
> specific technical motivation?

Speaking for Qualcomm platforms, we want the thermal subsystem
available as soon as possible for boot time thermal mitigation since
faster boot times equals hotter cpus. Also the dependency on cpufreq
subsystem due to the cpufreq cooling device would be simplified with
this.

In fact, I now have a follow on patch to move thermal init earlier
than fs_initcall since we'd now not wait on modules to be available.

/Amit
