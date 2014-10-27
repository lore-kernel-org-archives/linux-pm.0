From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 8/8] MAINTAINERS: add at91 power and memory entries
Date: Mon, 27 Oct 2014 16:17:17 -0700
Message-ID: <1414451837.18896.14.camel@perches.com>
References: <1414451377-11053-1-git-send-email-alexandre.belloni@free-electrons.com>
	 <1414451377-11053-9-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1414451377-11053-9-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Sebastian Reichel <sre@kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 2014-10-28 at 00:09 +0100, Alexandre Belloni wrote:
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -871,6 +871,25 @@ M:	Boris Brezillon <boris.brezillon@free-electrons.com>
>  S:	Maintained
>  F:	drivers/clk/at91
>  
> +ARM/ATMEL AT91 Poweroff driver
> +M:	Alexandre Belloni <alexandre.belloni@free-electrons.com>
> +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	drivers/power/reset/at91-poweroff.c
> +
> +ARM/ATMEL AT91 Reset driver
> +M:	Alexandre Belloni <alexandre.belloni@free-electrons.com>
> +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	drivers/power/reset/at91-reset.c

It's traditional to use upper case section descriptions.

Do these 2 really need to be separate entries?

> +
> +ARM/ATMEL AT91 SDRAM Controller driver
> +M:	Alexandre Belloni <alexandre.belloni@free-electrons.com>
> +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	drivers/memory/atmel-sdramc.c
> +F:	include/soc/atmel/memory.h
> +
>  ARM/CALXEDA HIGHBANK ARCHITECTURE
>  M:	Rob Herring <robh@kernel.org>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
