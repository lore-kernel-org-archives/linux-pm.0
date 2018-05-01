From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 2/3] power: supply: add cros-ec USBPD charger driver.
Date: Tue, 1 May 2018 14:27:02 +0100
Message-ID: <20180501132702.GP5147@dell>
References: <20180430131403.14296-1-enric.balletbo@collabora.com>
 <20180430131403.14296-3-enric.balletbo@collabora.com>
 <20180501121728.65bow5vzpzfeq4en@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180501121728.65bow5vzpzfeq4en@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, Gwendal Grignou <gwendal@chromium.org>, Sameer Nanda <snanda@chromium.org>, linux-pm@vger.kernel.org, Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>, miguel.ojeda.sandonis@gmail.com
List-Id: linux-pm@vger.kernel.org

On Tue, 01 May 2018, Sebastian Reichel wrote:

> Hi Enric,
> 
> On Mon, Apr 30, 2018 at 03:14:02PM +0200, Enric Balletbo i Serra wrote:
> > From: Sameer Nanda <snanda@chromium.org>
> > 
> > This driver gets various bits of information about what is connected to
> > USB PD ports from the EC and converts that into power_supply properties.
> > 
> > Signed-off-by: Sameer Nanda <snanda@chromium.org>
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > ---
> > 
> > Changes in v2:
> > - [2/3] Add SPDX header, use devm_ variant and drop .owner
> > - [2/3] Removed the PD log functionality (will be send on a follow up patch)
> > - [2/3] Removed the extra custom sysfs attributes (will be send on a follow up patch)
> 
> Thanks, it makes reviewing the patchset easier.
> 
> >  drivers/power/supply/Kconfig              |  10 +
> >  drivers/power/supply/Makefile             |   1 +
> >  drivers/power/supply/cros_usbpd-charger.c | 511 ++++++++++++++++++++++
> >  include/linux/mfd/cros_ec.h               |   2 +
> >  4 files changed, 524 insertions(+)
> >  create mode 100644 drivers/power/supply/cros_usbpd-charger.c

[...]

Sebastian,

When you review a patch, would you mind chopping/snipping unnecessary
text please?  The chunks in-between the ones you reply to.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
