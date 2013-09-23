From: Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v4 0/3] ARM: S5PV210: move to common clk framework
Date: Mon, 23 Sep 2013 14:28:33 +0200
Message-ID: <1533271.F4sWn2BdKU@amdc1227>
References: <1379785342-25107-1-git-send-email-m.krawczuk@partner.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1379785342-25107-1-git-send-email-m.krawczuk-GrGkmOP51GdLN7c7dRTbYkEOCMrvLtNR@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mateusz Krawczuk <m.krawczuk-GrGkmOP51GdLN7c7dRTbYkEOCMrvLtNR@public.gmane.org>
Cc: mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Mateusz,

On Saturday 21 of September 2013 19:42:19 Mateusz Krawczuk wrote:
> This patch series is the new s5pv210 clock implementation
> (using common clk framework).
> 
> This implementation is compatible with device tree definition and board
> files.
> 
> This patch series is based on linux-next and has been tested on goni and
> aquila
> boards using board file.
> 
> Since v3:
> 
> Replace s5pv210_clk_register_finpll, by creating mux finpll
> with xusbxti and xxti as parrents.
> 
> Mateusz Krawczuk (3):
>   clk: samsung: Add clock driver for s5pc110/s5pv210
>   Cpufreq: s5pv210 cpufreq fixes for CCF
>   ARM: s5pv210: Migrate clock handling to Common Clock Framework
> 
>  .../bindings/clock/samsung,s5pv210-clock.txt       |  75 +++
>  arch/arm/mach-s5pv210/Kconfig                      |   9 +
>  arch/arm/mach-s5pv210/Makefile                     |   4 +-
>  arch/arm/mach-s5pv210/common.c                     |  17 +
>  arch/arm/mach-s5pv210/common.h                     |  10 +
>  arch/arm/mach-s5pv210/mach-goni.c                  |   2 +-
>  arch/arm/mach-s5pv210/mach-smdkv210.c              |   2 +-
>  arch/arm/plat-samsung/Kconfig                      |   2 +-
>  drivers/clk/samsung/Makefile                       |   3 +
>  drivers/clk/samsung/clk-s5pv210.c                  | 673
> +++++++++++++++++++++ drivers/cpufreq/s5pv210-cpufreq.c                 
> |   6 +-
>  include/dt-bindings/clock/samsung,s5pv210-clock.h  | 224 +++++++
>  12 files changed, 1019 insertions(+), 8 deletions(-)
>  create mode 100644
> Documentation/devicetree/bindings/clock/samsung,s5pv210-clock.txt create
> mode 100644 drivers/clk/samsung/clk-s5pv210.c
>  create mode 100644 include/dt-bindings/clock/samsung,s5pv210-clock.h

Very nice work. I hope we will be able to finally move S5PV210 to Device 
Tree for 3.13 and drop all the legacy code.

Acked-by: Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Best regards,
Tomasz

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
