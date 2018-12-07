From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v6 0/8] AXP8x3 AC and battery power supply support
Date: Fri, 7 Dec 2018 07:28:03 +0000
Message-ID: <20181207072803.GG26661@dell>
References: <20181120175211.3913-1-oskari@lemmela.net>
 <CAGb2v65Bwve25jwdGHHK9j03RxQ3tKwme51762DjyQK2femG6g@mail.gmail.com>
 <20181205180042.fr5npvtwuvt2c6q3@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181205180042.fr5npvtwuvt2c6q3@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Chen-Yu Tsai <wens@csie.org>, oskari@lemmela.net, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Quentin Schulz <quentin.schulz@bootlin.com>, Vasily Khoruzhick <anarsoul@gmail.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 05 Dec 2018, Sebastian Reichel wrote:

> Hi,
> 
> On Fri, Nov 30, 2018 at 04:31:28PM +0800, Chen-Yu Tsai wrote:
> > On Wed, Nov 21, 2018 at 1:52 AM Oskari Lemmela <oskari@lemmela.net> wrote:
> > >
> > > AXP813 AC power supply support with input current and
> > > voltage limiting support.
> > >
> > > AXP803 AC and battery power supply support.
> > >
> > > Changes in v6:
> > > * Collected tags
> > > * Rebase to master
> > > * Dropped AXP803 compatible patches
> > >
> > > Changes in v5:
> > > * Return correct input current limit for values 0x6 and 0x7
> > > * Add specific compatibles for AXP803
> > > * Change commit messages
> > > * Add Vasily Khoruzhick Pinebook DTS patch
> > >
> > > Changes in v4:
> > > * Change order of axp20x-gpio in axp20x.c
> > > * Fix indentation and spaces to tabs in axp20x.c
> > >
> > > Changes in v3:
> > > * Reorder ac_power_supply DT node
> > > * Rename axp20x_ac_power_set_property function
> > > * Split mfd commit
> > >
> > > Changes in v2:
> > > * Reuse axp813 compatibles for axp803
> > > * Refactor axp20x_ac_power.c
> > >
> > >
> > > Oskari Lemmela (7):
> > >   dt-bindings: power: supply: axp20x: add AXP813 AC power DT binding
> > >   ARM: dts: axp81x: add AC power supply subnode
> > >   arm64: dts: allwinner: axp803: add AC and battery power supplies
> > >   arm64: dts: allwinner: a64: sopine-baseboard: enable power supplies
> > >   power: supply: add AC power supply driver for AXP813
> > >   mfd: axp20x: Add AC power supply cell for AXP813
> > >   mfd: axp20x: Add supported cells for AXP803
> > >
> > > Vasily Khoruzhick (1):
> > >   arm64: dts: allwinner: a64: pinebook: enable power supplies
> > 
> > Since this series has been fully reviewed, and the devices it
> > adds/enables aren't critical, i.e. won't cause the system to fail
> > if the drivers are missing, I've merged the dts patches for 4.21.
> > 
> > Hopefully Sebastian and Lee will get around to merging the driver
> > patches.
> 
> I queued the power-supply driver changes and prepared a signed
> immutable tag for Lee:
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/psy-mfd-axp813-immutable-for-v4.21-signed
> 
> for you to fetch changes up to 7693b5643fd2d682de90733b67fc8032b9646911:
> 
>   power: supply: add AC power supply driver for AXP813 (2018-12-05 18:49:32 +0100)
> 
> ----------------------------------------------------------------
> Immutable branch between mfd and power-supply for driver
> changes related to axp813.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> 
> ----------------------------------------------------------------
> Oskari Lemmela (2):
>       dt-bindings: power: supply: axp20x: add AXP813 AC power DT binding
>       power: supply: add AC power supply driver for AXP813
> 
>  .../bindings/power/supply/axp20x_ac_power.txt      |  3 +
>  drivers/power/supply/axp20x_ac_power.c             | 94 ++++++++++++++++++++++
>  include/linux/mfd/axp20x.h                         |  1 +
>  3 files changed, 98 insertions(+)

What patches are left now?  Just 7 and 8?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
