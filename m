From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 0/5] Add new features for SC27XX fuel gauge driver
Date: Thu, 6 Dec 2018 10:57:31 +0800
Message-ID: <CAMz4kuJ1ghPs1Vg9tE9hMrC1GpuwruwfUV02szQ8_L=3ocsG-Q@mail.gmail.com>
References: <cover.1542185618.git.baolin.wang@linaro.org> <20181206001048.awfhmigouztqs6td@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206001048.awfhmigouztqs6td@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux PM list <linux-pm@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, yuanjiang.yu@unisoc.com, Mark Brown <broonie@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Sebastian,

On Thu, 6 Dec 2018 at 08:10, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hi,
>
> On Wed, Nov 14, 2018 at 05:07:03PM +0800, Baolin Wang wrote:
> > This patch set adds some new features for SC27XX fuel gauge driver.
> >
> > 1. Read calibration data from eFuse device to calibrate fuel gauge.
> > 2. Add low voltage alarm to adjust the battery capacity in lower
> > voltage stage.
> > 3. Add power management interfaces
> > 4. Save last optimized battery capacity to be used as the initial
> > battery capacity if system is not first power-on.
> >
> > Baolin Wang (2):
> >   dt-bindings: power: supply: Add nvmem properties to calibrate FGU
> >   power: supply: sc27xx: Add fuel gauge calibration
> >
> > Yuanjiang Yu (3):
> >   power: supply: sc27xx: Add fuel gauge low voltage alarm
> >   power: supply: sc27xx: Add suspend/resume interfaces
> >   power: supply: sc27xx: Save last battery capacity
> >
> >  .../devicetree/bindings/power/supply/sc27xx-fg.txt |    4 +
> >  drivers/power/supply/sc27xx_fuel_gauge.c           |  453 +++++++++++++++++++-
> >  2 files changed, 444 insertions(+), 13 deletions(-)
>
> I applied patches 1-4 and skipped patch 5 due to pending changes.

I will send new version with addressing comments in patch 5. Thanks.

-- 
Baolin Wang
Best Regards
