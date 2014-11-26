From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH RFC 0/3] power: mxs_power: add driver for mxs power subsystem
Date: Wed, 26 Nov 2014 11:26:03 +0100
Message-ID: <5475AABB.1050303@i2se.com>
References: <1416514477-19190-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:50520 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbaKZK1P (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Nov 2014 05:27:15 -0500
In-Reply-To: <1416514477-19190-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org

> This patch series adds support for Freescale i.MX23, i.xM28 power subsystem.
>
> The idea for this driver was born in the discussion with Mark Rutland
> about the mxs-regulator driver [1].
>
> The main use is to trigger driver probing of the underlying DT child nodes
> like on-chip regulators. But it's also the first step for cpufreq-dt support.
>
> [1] - https://lkml.org/lkml/2014/9/29/283
>
> Stefan Wahren (3):
>   DT: add binding for mxs power subsystem
>   power: mxs_power: add driver for mxs power subsystem
>   ARM: dts: enable power subsystem for i.MX28
>
>  .../devicetree/bindings/power/mxs_power.txt        |   23 ++
>  arch/arm/boot/dts/imx28.dtsi                       |    6 +-
>  drivers/power/Kconfig                              |    8 +
>  drivers/power/Makefile                             |    1 +
>  drivers/power/mxs_power.c                          |  226 ++++++++++++++++++++
>  5 files changed, 263 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/power/mxs_power.txt
>  create mode 100644 drivers/power/mxs_power.c
>
> --
> 1.7.9.5
>

Are there any other questions or suggestions about these patch series?

Stefan

