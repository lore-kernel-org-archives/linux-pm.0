From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/4] cpufreq: add i.MX5 cpufreq driver
Date: Mon, 26 May 2014 16:02:56 +0530
Message-ID: <CAKohpoksbFHyX=r0=URMedJNi68c3xAX4OrXzSFqgf1-bCm4+Q@mail.gmail.com>
References: <1401099308-9658-1-git-send-email-l.stach@pengutronix.de>
	<1401099308-9658-2-git-send-email-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:57982 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600AbaEZKc4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 26 May 2014 06:32:56 -0400
Received: by mail-ob0-f182.google.com with SMTP id wn1so7837271obc.13
        for <linux-pm@vger.kernel.org>; Mon, 26 May 2014 03:32:56 -0700 (PDT)
In-Reply-To: <1401099308-9658-2-git-send-email-l.stach@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Shawn Guo <shawn.guo@freescale.com>, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>

On 26 May 2014 15:45, Lucas Stach <l.stach@pengutronix.de> wrote:
> SoC specific driver to be able to handle PLL reprogramming
> for exact OPP frequencies and additional power saving.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  .../devicetree/bindings/cpufreq/cpufreq-imx5.txt   |  43 +++
>  drivers/cpufreq/Kconfig.arm                        |   8 +
>  drivers/cpufreq/Makefile                           |   1 +
>  drivers/cpufreq/imx5-cpufreq.c                     | 302 +++++++++++++++++++++
>  4 files changed, 354 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-imx5.txt
>  create mode 100644 drivers/cpufreq/imx5-cpufreq.c

What stops you to use cpufreq-cpu0 driver with a CPU clock
driver? Its highly discouraged to add a new driver here if you
can reuse it.. Which is more or less confirmed from a broad look..
