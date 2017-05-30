From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH 1/4] thermal: uniphier: add UniPhier thermal driver
Date: Tue, 30 May 2017 13:09:20 +0900
Message-ID: <20170530130919.685A.4A936039@socionext.com>
References: <20170530114738.6856.4A936039@socionext.com> <42ed5250-781b-d829-cead-cc095de6e96f@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx.socionext.com ([202.248.49.38]:27000 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750708AbdE3EJW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 30 May 2017 00:09:22 -0400
In-Reply-To: <42ed5250-781b-d829-cead-cc095de6e96f@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, yamada.masahiro@socionext.com, masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org

On Tue, 30 May 2017 08:51:31 +0530 Keerthy <j-keerthy@ti.com> wrote:

> 
> 
> On Tuesday 30 May 2017 08:17 AM, Kunihiko Hayashi wrote:
> > Hi Keerthy,
> > Thank you for your comment.
> > 
> > On Mon, 29 May 2017 15:53:39 +0530 Keerthy <j-keerthy@ti.com> wrote:
> >>
> >>
> >> On Monday 29 May 2017 02:45 PM, Kunihiko Hayashi wrote:
> >>> Add a thermal driver for on-chip PVT (Process, Voltage and Temperature)
> >>> monitoring unit implemented on UniPhier SoCs. This driver supports
> >>> temperature monitoring and alert function.
> >>
> >> The Documentation in patch 2/4 should be squashed into this patch.
> > 
> > According to the following guide,
> > http://elixir.free-electrons.com/linux/latest/source/Documentation/devicetree/bindings/submitting-patches.txt
> > 
> >   1) The Documentation/ portion of the patch should be a separate patch.
> > 
> > I think it should be separated, how about that?
> 
> Then you should reorder the series as we get the warning with checkpatch:
> 
> WARNING: DT compatible string "socionext,uniphier-pxs2-thermal" appears
> un-documented -- check ./Documentation/devicetree/bindings/
> #488: FILE: drivers/thermal/uniphier_thermal.c:367:
> +		.compatible = "socionext,uniphier-pxs2-thermal",
> 
> WARNING: DT compatible string "socionext,uniphier-ld20-thermal" appears
> un-documented -- check ./Documentation/devicetree/bindings/
> #492: FILE: drivers/thermal/uniphier_thermal.c:371:
> +		.compatible = "socionext,uniphier-ld20-thermal",
> 
> When i apply the first patch.

OK. I also confirmed the warning messages. I'll reorder the patches 1/4 and 2/4.

Best Regards,
Kunihiko Hayashi
