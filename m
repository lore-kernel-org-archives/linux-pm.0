From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 7/7] thermal: rcar: add Device Tree support
Date: Wed, 06 Feb 2013 16:36:27 +0800
Message-ID: <1360139787.2982.43.camel@rzhang1-mobl4>
References: <87y5f9pvxv.wl%kuninori.morimoto.gx@renesas.com>
	 <87obg5pvsd.wl%kuninori.morimoto.gx@renesas.com>
	 <1360129047.2982.28.camel@rzhang1-mobl4>
	 <87r4ktg7yh.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:8387 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752296Ab3BFIgb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 6 Feb 2013 03:36:31 -0500
In-Reply-To: <87r4ktg7yh.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, linux-pm@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>

On Wed, 2013-02-06 at 00:30 -0800, Kuninori Morimoto wrote:
> Hi Zhang
> 
> Thank you for checking patch
> 
> > > +static const struct of_device_id rcar_thermal_dt_ids[] __devinitconst = {
> > > +	{ .compatible = "renesas,rcar-thermal", },
> > > +	{},
> > > +};
> > > +MODULE_DEVICE_TABLE(of, rcar_thermal_dt_ids);
> > > +
> > you do not need 
> > #ifdef CONFIG_OF
> > here?
> 
> I didn't get any compile error here with/without CONFIG_OF.
> Of course I can add it if you want.
> 
I checked some other drivers, some use #ifdef while some not.
I'm okay with this.
patch applied to thermal -next.

thanks,
rui

> Best regards
> ---
> Kuninori Morimoto


