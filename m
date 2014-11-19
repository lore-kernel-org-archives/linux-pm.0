From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 1/2] ARM: keystone: pm: switch to use generic pm domains
Date: Wed, 19 Nov 2014 14:47:25 +0100
Message-ID: <2900095.WIocOu7ue2@wuerfel>
References: <1415631557-22897-1-git-send-email-grygorii.strashko@ti.com> <1709760.E0jX3Myv0h@wuerfel> <546C7FDD.7030906@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:62579 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950AbaKSNsI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Nov 2014 08:48:08 -0500
In-Reply-To: <546C7FDD.7030906@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Kevin Hilman <khilman@kernel.org>, ssantosh@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, grant.likely@secretlab.ca, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Wednesday 19 November 2014 13:32:45 Grygorii Strashko wrote:
> On 11/18/2014 09:32 PM, Arnd Bergmann wrote:
> > On Tuesday 18 November 2014 20:54:36 Grygorii Strashko wrote:
> > 
> > Have one pmdomain driver in the generic code that knows about clocks,
> > possibly also regulators and pins and just turns them on when needed.
> > You can have a "simple-pmdomain" or "generic-pmdomain" compatible
> > string.
> > 
> > I'm a bit surprised that your pmdomain code looks up the clocks from the
> > respective device, rather than know about the clocks itself. There is
> > probably a good reason for this, but I don't see it yet.
> 
> The keystone 2 uses simple PM schema based on clocks only:
> - clocks enabled -> dev is active
> - clocks disabled -> dev is suspended
> 
> To achieve explained above the Generic clock manipulation PM callbacks framework (pm_clk) is used.
> - list of managed clocks is filled for each device (for non-DT case the con_id list
>   is specified by platform code like:
> 	.con_ids = { "fck", "master", "slave", NULL }, 
>         - or - 
> 	.con_ids = { }, <-- in this case only first clock will be added to pm_clk
>   )
> - dev.pm_domain is assigned to pm_clk_domain
> - pm_clk_domain has .runtime_resume/runtime_suspend callbacks set and implemented like:
>   static int keystone_pm_runtime_suspend(struct device *dev)
>   {
> 	ret = pm_generic_runtime_suspend(dev);
> 	if (ret)
> 		return ret;
> 
> 	ret = pm_clk_suspend(dev);
> 	if (ret) {
> 		pm_generic_runtime_resume(dev);
> 		return ret;
> 	}
> 
> 	return 0;
>   }
>   static int keystone_pm_runtime_resume(struct device *dev)
>   {
> 	pm_clk_resume(dev);
> 
> 	return pm_generic_runtime_resume(dev);
>   }
> Now this configuration can be done from Platform Bus notifier (clock_ops.c) only and It'll
> be done for ALL Platform devices and, once above steps have been done, the Runtime PM
> starts working for device.
> 
> As was described early in this thread, Keystone 2 PM domain is glue layer which
> allows:
>  - configure pm_clk for devices from DT and get rid of .con_ids
>  - configure only selected devices
>  - get rid of using Platform Bus notifier
>  - enable suspend/resume for devices as side effect :)
> and which manages state of its devices through dev_ops->start()/stop() callbacks. 

Right, that makes a lot more sense now, thanks for the detailed explanation!

> > Another option would be to have a special case for an empty
> > "power-domains" property if this is the most common case: if that
> > property exists but is empty, the pmdomain core could interpret
> > it as an indication to control all the clocks/regulators/pins
> > of a device.
> 
> I can try to do the following:
> - move Keystone PM domain code in drivers/base/power/simple_domain.c
> - add DT bindings like:
> +	clk_pmdomain: simple-clk-pmdomain {
> +		compatible = "simple-clk-pmdomain", "simple-pmdomain";
> +		#power-domain-cells = <0>;
> +	};
> - in case if compatible == "simple-clk-pmdomain" it will do the same sings as in this patch
> 
> In the future, additional support for regulators/clocks/gpios can be added and these resources
> can be managed in .power_on/power_off.
> 
> Is it ok for you?

Yes, it would definitely solve the problem that I see with the infrastructure
code that the current version adds into the platform directory.

The exact binding of course should be reviewed by the pmdomain and
DT maintainers, to ensure that it is done the best possible way, because
I assume we will end up using it a lot, and it would be a shame to get
it slightly wrong.

One possible variation I can think of would be to just use "simple-pmdomain"
as the compatible string, and use properties in the node itself to decide
what the domain should control, e.g.

	clk_pmdomain: pmdomain {
		compatible = "simple-pmdomain";
		pmdomain-enable-clocks;
		#power-domain-cells = <0>;
	};
	clk_regulator_pmdomain: pmdomain {
		compatible = "simple-pmdomain";
		pmdomain-enable-clocks;
		pmdomain-enable-regulators;
		#power-domain-cells = <0>;
	};

and then have each device link to one of the nodes as the pmdomain.

	Arnd
