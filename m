From: Fabien Parent <fparent@baylibre.com>
Subject: Re: [PATCH 0/3] power: supply: cros: add support for dedicated port
 and expose connected ports
Date: Mon, 4 Jun 2018 10:13:03 -0700
Message-ID: <CAOwMV_y91U=teT5aC1+cHrPdxRZNRDEjCNs2UXEeEP=MeQE1-g@mail.gmail.com>
References: <20180530031704.18597-1-fparent@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180530031704.18597-1-fparent@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Enric Balletbo Serra <eballetbo@gmail.com>, Guillaume Pain <gpain@baylibre.com>, Fabien Parent <fparent@baylibre.com>
List-Id: linux-pm@vger.kernel.org

+ Lee Jones for the mfd patch.

On Tue, May 29, 2018 at 8:17 PM, Fabien Parent <fparent@baylibre.com> wrote:
> Dear all,
>
> This patch series adds support for an optional dedicated port
> to the ChromeOS power supply driver and adds a new property that expose
> when a power supply is connected. The series was tested on ChromeOS "Fizz"
> hardware.
>
> This patch series depends on the following patch serie which adds
> the ChromeOS power supply driver:
>  * https://lkml.org/lkml/2018/5/2/585 [PATCH v4 0/3] mfd/power: cros_ec: add
>    support for USBPD charger driver
>
> The ChromeOS power supply driver also depends on the following patches to be
> applied:
>  * https://lkml.org/lkml/2018/4/23/602 ([PATCH v8 0/6] typec: tcpm: Add
>    sink side support for PPS)
>  * https://lkml.org/lkml/2018/4/18/229 ([RESEND PATCH v5 4/7] mfd:
>    cros_ec_dev: Register cros-ec-rtc driver as a subdevice.)
>
> Best Regards,
> Fabien
>
> Fabien Parent (3):
>   mfd: cros: add charger port count command definition
>   power: supply: cros: add support for dedicated port
>   power: supply: cros: add property to detect connected ports
>
>  drivers/power/supply/cros_usbpd-charger.c | 129 +++++++++++++++++++---
>  include/linux/mfd/cros_ec_commands.h      |  10 ++
>  2 files changed, 124 insertions(+), 15 deletions(-)
>
> --
> 2.17.0
>
