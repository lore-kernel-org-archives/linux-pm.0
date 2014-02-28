From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 2/2] thermal,rcar_thermal: Add dependency on HAS_IOMEM
Date: Fri, 28 Feb 2014 09:21:33 +0100
Message-ID: <5310470D.6000404@nod.at>
References: <1390688954-4940-1-git-send-email-richard@nod.at>	<1393484282.2637.17.camel@rzhang1-mobl4> <87fvn4yskv.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from b.ns.miles-group.at ([95.130.255.144]:1661 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750701AbaB1IVn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 28 Feb 2014 03:21:43 -0500
In-Reply-To: <87fvn4yskv.wl%kuninori.morimoto.gx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: eduardo.valentin@ti.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, horms@verge.net.au, laurent.pinchart+renesas@ideasonboard.com

Am 28.02.2014 01:44, schrieb Kuninori Morimoto:
>>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>>> index 35c0664..88efa8f 100644
>>> --- a/drivers/thermal/Kconfig
>>> +++ b/drivers/thermal/Kconfig
>>> @@ -136,6 +136,7 @@ config SPEAR_THERMAL
>>>  config RCAR_THERMAL
>>>  	tristate "Renesas R-Car thermal driver"
>>>  	depends on ARCH_SHMOBILE || COMPILE_TEST
>>> +	depends on HAS_IO_MEM
>>>  	help
>>>  	  Enable this to plug the R-Car thermal sensor driver into the Linux
>>>  	  thermal framework.
> 
> I guess
> 
>  - HAS_IO_MEM
>  + HAS_IOMEM

Yeah, this has been resolved in v2:
https://lkml.org/lkml/2014/1/27/59

Thanks,
//richard
