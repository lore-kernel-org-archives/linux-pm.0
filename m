From: Romain Perier <romain.perier@gmail.com>
Subject: Re: [PATCH 0/4] poweroff-source DT property renaming
Date: Wed, 29 Oct 2014 15:21:23 +0100
Message-ID: <CABgxDo+mxFrdFM4aM389pR26hGUfcgLkGZXcPqtWTExfTV46Tw@mail.gmail.com>
References: <1414568135-8311-1-git-send-email-romain.perier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:58701 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932475AbaJ2OVY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Oct 2014 10:21:24 -0400
In-Reply-To: <1414568135-8311-1-git-send-email-romain.perier@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, devicetree <devicetree@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Johan Hovold <johan@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>

+CC Felipe and linux-tegra@vger.k.o , as both were interested by some
parts of the previous serie (sorry when I tried to reduce the CC list,
I forgot you)

2014-10-29 8:35 GMT+01:00 Romain Perier <romain.perier@gmail.com>:
> The goal of this serie is to rename the property "poweroff-source" to
> "system-power-controller" and to fix things incrementally.
>
> Changes and explanations since v1:
>
>   - The first patch defines "of_is_system_power_controller" which is compatible
>     with both "vendor,system-power-controller" and "system-power-controller"
>     properties. Also, It keeps the old helper function of_system_has_poweroff_source
>     for source compatibility until everything is renamed (in this way, bisections
>     are not broken and change is made "atomically" between each commit)
>
>     Note: the property "poweroff-source" itself is not used in dts files yet.
>     Before this patch tps65910 was broken due to missing backward compatibility
>     with "vendor,system-power-controller". As the old helper uses the new one,
>     it works again.
>
>   - act8865 and tps65910 are ported to the new helper function
>
>   - The last commit removes the olf helper which was only used for source compatibility
>
> Romain Perier (4):
>   of: Rename "poweroff-source" property to "system-power-controller"
>   regulator: act8865: Convert poweroff-source DT property to
>     system-power-controller
>   mfd: tps65910: Convert poweroff-source DT property to
>     system-power-controller
>   of: Remove of_system_has_poweroff_source helper function
>
>  .../devicetree/bindings/power/power-controller.txt | 18 ++++++++++++
>  .../devicetree/bindings/power/poweroff.txt         | 18 ------------
>  .../bindings/regulator/act8865-regulator.txt       |  4 +--
>  drivers/mfd/tps65910.c                             |  2 +-
>  drivers/of/base.c                                  | 34 ++++++++++++++++++++++
>  drivers/regulator/act8865-regulator.c              |  2 +-
>  include/linux/of.h                                 | 12 ++------
>  7 files changed, 58 insertions(+), 32 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/power-controller.txt
>  delete mode 100644 Documentation/devicetree/bindings/power/poweroff.txt
>
> --
> 1.9.1
>
