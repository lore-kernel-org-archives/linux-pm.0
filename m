From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH V2 01/20] thermal: exynos: Moving exynos thermal files into
 samsung directory
Date: Tue, 07 May 2013 15:36:50 +0200
Message-ID: <16696787.3vbuFaRQiY@amdc1227>
References: <1366972671-9227-1-git-send-email-amit.daniel@samsung.com>
 <1927845.etOFu5Zfbm@amdc1227>
 <CADGdYn5YE6KPgrJYLjh+ctgfQDboajaLWXO6qXZHJtgxXseFtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CADGdYn5YE6KPgrJYLjh+ctgfQDboajaLWXO6qXZHJtgxXseFtg@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: amit daniel kachhap <amit.daniel@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday 07 of May 2013 18:48:46 amit daniel kachhap wrote:
> Hi Tomasz Figa,
> 
> On Tue, May 7, 2013 at 3:51 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> > On Monday 06 of May 2013 23:05:06 Zhang Rui wrote:
> >> On Fri, 2013-04-26 at 16:07 +0530, Amit Daniel Kachhap wrote:
> >> > This movement of files is done for easy maintenance and adding more
> >> > new sensor's support for exynos platform easily . This will also help
> >> > in
> >> > bifurcating exynos common, sensor driver and sensor data related parts.
> >> > 
> >> > Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> >> > Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> >> > ---
> >> > 
> >> >  drivers/thermal/Kconfig                        |   13 +++++--------
> >> >  drivers/thermal/Makefile                       |    2 +-
> >> >  drivers/thermal/samsung/Kconfig                |    9 +++++++++
> >> >  drivers/thermal/samsung/Makefile               |    4 ++++
> >> >  drivers/thermal/{ => samsung}/exynos_thermal.c |    0
> >> >  5 files changed, 19 insertions(+), 9 deletions(-)
> >> >  create mode 100644 drivers/thermal/samsung/Kconfig
> >> >  create mode 100644 drivers/thermal/samsung/Makefile
> >> >  rename drivers/thermal/{ => samsung}/exynos_thermal.c (100%)
> >> > 
> >> > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> >> > index 5e3c025..081ddc5 100644
> >> > --- a/drivers/thermal/Kconfig
> >> > +++ b/drivers/thermal/Kconfig
> >> > @@ -114,14 +114,6 @@ config KIRKWOOD_THERMAL
> >> > 
> >> >       Support for the Kirkwood thermal sensor driver into the Linux
> >> >       thermal
> >> >       framework. Only kirkwood 88F6282 and 88F6283 have this sensor.
> >> > 
> >> > -config EXYNOS_THERMAL
> >> > -   tristate "Temperature sensor on Samsung EXYNOS"
> >> > -   depends on (ARCH_EXYNOS4 || ARCH_EXYNOS5)
> >> > -   depends on CPU_THERMAL
> >> > -   help
> >> > -     If you say yes here you get support for TMU (Thermal Management
> >> > -     Unit) on SAMSUNG EXYNOS series of SoC.
> >> > -
> >> > 
> >> >  config DOVE_THERMAL
> >> >  
> >> >     tristate "Temperature sensor on Marvell Dove SoCs"
> >> >     depends on ARCH_DOVE
> >> > 
> >> > @@ -169,4 +161,9 @@ config INTEL_POWERCLAMP
> >> > 
> >> >       enforce idle time which results in more package C-state
> >> >       residency. The
> >> >       user interface is exposed via generic thermal framework.
> >> > 
> >> > +menu "Exynos thermal drivers"
> >> 
> >> would it be more proper to use "Samsung thermal drivers" or "Samsung
> >> Exynos thermal drivers" instead?
> > 
> > +1
> > 
> > Still, I wonder if it really makes sense to create a separate directory
> > and
> > submenu for this.
> 
> Yes separate directory was needed as the current TMU drivers supports
> many exynos SOC's with some differences in the controller itself. This
> has made it unmanageable and unclean and configuration data need to be
> separated from driver. With all these re-structuring, tmu support for
> exynos5440 is added very cleanly. Also many changes in this patchset
> are for making the driver multi-stance which is needed for 5440.

I fully understand the need to restructure this driver. I'm just thinking if 
there is really a reason to have a separate directory with its own Makefile and 
Kconfig just for six source files, which could be placed in drivers/thermal/ 
directly as well. I guess it's just a matter of preference, though.

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
SW Solution Development, Kernel and System Framework
