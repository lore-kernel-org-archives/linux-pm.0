From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v11 2/8] power: add power sequence library
Date: Sat, 7 Jan 2017 10:54:56 +0200
Message-ID: <20170107085456.w5dhm7qadqa6tc7v@kozik-lap>
References: <1483596119-27508-1-git-send-email-peter.chen@nxp.com>
 <1483596119-27508-3-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1483596119-27508-3-git-send-email-peter.chen@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <peter.chen@nxp.com>
Cc: gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org, rjw@rjwysocki.net, dbaryshkov@gmail.com, heiko@sntech.de, linux-arm-kernel@lists.infradead.org, p.zabel@pengutronix.de, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, linux-usb@vger.kernel.org, arnd@arndb.de, s.hauer@pengutronix.de, mail@maciej.szmigiero.name, troy.kisky@boundarydevices.com, festevam@gmail.com, oscar@naiandei.net, stephen.boyd@linaro.org, linux-pm@vger.kernel.org, stillcompiling@gmail.com, linux-kernel@vger.kernel.org, mka@chromium.org, vaibhav.hiremath@linaro.org, gary.bisson@boundarydevices.com, hverkuil@xs4all.nl, krzk@kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 05, 2017 at 02:01:53PM +0800, Peter Chen wrote:
> We have an well-known problem that the device needs to do some power
> sequence before it can be recognized by related host, the typical
> example like hard-wired mmc devices and usb devices.
> 
> This power sequence is hard to be described at device tree and handled by
> related host driver, so we have created a common power sequence
> library to cover this requirement. The core code has supplied
> some common helpers for host driver, and individual power sequence
> libraries handle kinds of power sequence for devices. The pwrseq
> librares always need to allocate extra instance for compatible
> string match.
> 
> pwrseq_generic is intended for general purpose of power sequence, which
> handles gpios and clocks currently, and can cover other controls in
> future. The host driver just needs to call of_pwrseq_on/of_pwrseq_off
> if only one power sequence is needed, else call of_pwrseq_on_list
> /of_pwrseq_off_list instead (eg, USB hub driver).
> 
> For new power sequence library, it can add its compatible string
> to pwrseq_of_match_table, then the pwrseq core will match it with
> DT's, and choose this library at runtime.
> 
> Signed-off-by: Peter Chen <peter.chen@nxp.com>
> Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> Tested-by Joshua Clayton <stillcompiling@gmail.com>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  MAINTAINERS                           |   9 +
>  drivers/power/Kconfig                 |   1 +
>  drivers/power/Makefile                |   1 +
>  drivers/power/pwrseq/Kconfig          |  20 ++
>  drivers/power/pwrseq/Makefile         |   2 +
>  drivers/power/pwrseq/core.c           | 335 ++++++++++++++++++++++++++++++++++
>  drivers/power/pwrseq/pwrseq_generic.c | 224 +++++++++++++++++++++++
>  include/linux/power/pwrseq.h          |  81 ++++++++
>  8 files changed, 673 insertions(+)
>  create mode 100644 drivers/power/pwrseq/Kconfig
>  create mode 100644 drivers/power/pwrseq/Makefile
>  create mode 100644 drivers/power/pwrseq/core.c
>  create mode 100644 drivers/power/pwrseq/pwrseq_generic.c
>  create mode 100644 include/linux/power/pwrseq.h
> 

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Tested on Odroid U3 (reset sequence for LAN9730):
Tested-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
