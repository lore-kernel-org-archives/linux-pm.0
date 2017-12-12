From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 5/7] MAINTAINERS: add new entries for Armada 37xx
 cpufreq driver
Date: Tue, 12 Dec 2017 12:52:10 +0530
Message-ID: <20171212072210.GJ25177@vireshk-i7>
References: <20171207135616.23670-1-gregory.clement@free-electrons.com>
 <20171207135616.23670-6-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35703 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752335AbdLLHWN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Dec 2017 02:22:13 -0500
Received: by mail-pg0-f68.google.com with SMTP id q20so12856091pgv.2
        for <linux-pm@vger.kernel.org>; Mon, 11 Dec 2017 23:22:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171207135616.23670-6-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Antoine Tenart <antoine.tenart@free-electrons.com>, =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Wilson Ding <dingwei@marvell.com>, Hua Jing <jinghua@marvell.com>, Neta Zur Hershkovits <neta@marvell.com>, Evan Wang <xswang@marvell.com>, Andre Heider <a.heider@gmail.com>

On 07-12-17, 14:56, Gregory CLEMENT wrote:
> This new driver belongs to the mvebu family, update the MAINTAINER file
> to document it.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aa71ab52fd76..98dcee849481 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1582,6 +1582,7 @@ F:	arch/arm/boot/dts/kirkwood*
>  F:	arch/arm/configs/mvebu_*_defconfig
>  F:	arch/arm/mach-mvebu/
>  F:	arch/arm64/boot/dts/marvell/armada*
> +F:	drivers/cpufreq/armada-37xx-cpufreq.c
>  F:	drivers/cpufreq/mvebu-cpufreq.c
>  F:	drivers/irqchip/irq-armada-370-xp.c
>  F:	drivers/irqchip/irq-mvebu-*

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
