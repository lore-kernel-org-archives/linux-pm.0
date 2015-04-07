From: Simon Horman <horms@verge.net.au>
Subject: Re: [RFC/PATCH 2/4] ARM: shmobile: Add cpuidle_ops for R-Car cpuidle
Date: Tue, 7 Apr 2015 10:50:40 +0900
Message-ID: <20150407015040.GD27486@verge.net.au>
References: <1428292244-2160-1-git-send-email-keita.kobayashi.ym@renesas.com>
 <1428292244-2160-3-git-send-email-keita.kobayashi.ym@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:60455 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752840AbbDGBuo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Apr 2015 21:50:44 -0400
Content-Disposition: inline
In-Reply-To: <1428292244-2160-3-git-send-email-keita.kobayashi.ym@renesas.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Cc: rjw@rjwysocki.net, daniel.lezcano@linaro.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, magnus.damm@gmail.com

On Mon, Apr 06, 2015 at 12:50:42PM +0900, Keita Kobayashi wrote:
> This patch add Core-Standby support for R-Car cpuidle.
> 
> Signed-off-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>

[snip]

> diff --git a/arch/arm/mach-shmobile/pm-rcar-gen2.c b/arch/arm/mach-shmobile/pm-rcar-gen2.c
> index 6815781..846b8ae 100644

[snip]

> +struct cpuidle_ops rcar_cpuidle_ops __initdata = {
> +	.suspend = rcar_cpuidle_enter,
> +};
> +CPUIDLE_METHOD_OF_DECLARE(rcar, "renesas,rcar-idle", &rcar_cpuidle_ops);
> +#endif

It seems to me that that renesas,rcar-idle should be documented
as an enable-method in Documentation/devicetree/bindings/arm/cpus.txt.

That change could be a separate patch for device tree.
