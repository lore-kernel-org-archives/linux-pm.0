From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 1/8] Documentation: arm: define DT cpu
 capacity-dmips-mhz bindings
Date: Wed, 20 Jul 2016 13:56:07 -0500
Message-ID: <20160720185607.GA30072@rob-hp-laptop>
References: <1468932048-31635-1-git-send-email-juri.lelli@arm.com>
 <1468932048-31635-2-git-send-email-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34976 "EHLO
	mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752485AbcGTS4K (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jul 2016 14:56:10 -0400
Content-Disposition: inline
In-Reply-To: <1468932048-31635-2-git-send-email-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, broonie@kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Olof Johansson <olof@lixom.net>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Paul Walmsley <paul@pwsan.com>, Linus Walleij <linus.walleij@linaro.org>, Chen-Yu Tsai <wens@csie.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

On Tue, Jul 19, 2016 at 01:40:41PM +0100, Juri Lelli wrote:
> ARM systems may be configured to have cpus with different power/performance
> characteristics within the same chip. In this case, additional information
> has to be made available to the kernel (the scheduler in particular) for it
> to be aware of such differences and take decisions accordingly.
> 
> Therefore, this patch aims at standardizing cpu capacities device tree
> bindings for ARM platforms. Bindings define cpu capacity-dmips-mhz
> parameter, to allow operating systems to retrieve such information from
> the device tree and initialize related kernel structures, paving the way
> for common code in the kernel to deal with heterogeneity.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Kumar Gala <galak@codeaurora.org>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> ---
> 
> Changes from v1:
>  - removed section regarding capacity-scale
>  - added information regarding normalization
> 
> Changes from v4:
>  - binding changed to capacity-dmips-mhz
>  - sections and changelod updated accordingly
> 
> Changes from v5:
>  - addressed Mark and Vincent comments
> ---
>  .../devicetree/bindings/arm/cpu-capacity.txt       | 236 +++++++++++++++++++++
>  Documentation/devicetree/bindings/arm/cpus.txt     |  10 +
>  2 files changed, 246 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/cpu-capacity.txt

I guess I'm okay with the scaled values, so:

Acked-by: Rob Herring <robh@kernel.org>

[...]

> +Example 2 (ARM 32-bit, 4-cpu system, two clusters,
> +	   cpus 0,1@1GHz, cpus 2,3@500MHz):
> +capacities-dmips-mhz are scaled w.r.t. 2 (cpu@0 and cpu@1), this means that first
> +cpu@0 and cpu@1 are twice fast than cpu@2 and cpu@3 (at the same frequency)

This example is a bit confusing with both the capacity and frequency 
being half. I also find it a bit unrealistic to have a 2x performance 
difference on the same micro arch. But it is all just an example...

Rob
