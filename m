From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 1/2] power: supply: sbs-battery: don't assume
 MANUFACTURER_DATA formats
Date: Tue, 12 Jun 2018 13:23:25 -0700
Message-ID: <CA+ASDXMuohDxvAXdnea8xAZyq6Nn4JThQFGTPPtxTzvf-2dJ0Q@mail.gmail.com>
References: <20180612202042.107603-1-briannorris@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180612202042.107603-1-briannorris@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Rhyland Klein <rklein@nvidia.com>, Alexandru Stan <amstan@chromium.org>, Guenter Roeck <linux@roeck-us.net>, Doug Anderson <dianders@chromium.org>, Phil Reid <preid@electromag.com.au>, Brian Norris <briannorris@chromium.org>
List-Id: linux-pm@vger.kernel.org

Eek, sorry this series should have subjects "[PATCH v5 X/2] ...". I
can resend if really needed, but hopefully by now this is ready to
go...

Brian

On Tue, Jun 12, 2018 at 1:20 PM, Brian Norris <briannorris@chromium.org> wrote:
> This driver was originally submitted for the TI BQ20Z75 battery IC
> (commit a7640bfa10c5 ("power_supply: Add driver for TI BQ20Z75 gas gauge
> IC")) and later renamed to express generic SBS support. While it's
> mostly true that this driver implemented a standard SBS command set, it
> takes liberties with the REG_MANUFACTURER_DATA register. This register
> is specified in the SBS spec, but it doesn't make any mention of what
> its actual contents are.

...

> ---
> v2:
>  * don't stub out POWER_SUPPLY_PROP_PRESENT from sbs_data[]
>  * use if/else instead of switch/case
>
> v3:
>  * pull 'return 0' out of if/else, to satisfy braindead tooling
>
> v4:
>  * make ManufacturerAccess non-optional for TI parts again
>
> v5: no change
> ---
>  drivers/power/supply/sbs-battery.c | 67 ++++++++++++++++++++++++------
>  1 file changed, 54 insertions(+), 13 deletions(-)
