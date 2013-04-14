From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [V3 patch 17/19] ARM: kirkwood: cpuidle: use init/exit common
 routine
Date: Sun, 14 Apr 2013 17:14:29 +0200
Message-ID: <20130414151429.GF5061@lunn.ch>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
 <1365770165-27096-18-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from londo.lunn.ch ([80.238.139.98]:39471 "EHLO londo.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751873Ab3DNPQA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 14 Apr 2013 11:16:00 -0400
Content-Disposition: inline
In-Reply-To: <1365770165-27096-18-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@sisk.pl, linus.walleij@linaro.org, jason@lakedaemon.net, andrew@lunn.ch, kernel@pengutronix.de, swarren@wwwdotorg.org, santosh.shilimkar@ti.com, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux@maxim.org.za, rob.herring@calxeda.com, nsekhar@ti.com, horms@verge.net.au, magnus.damm@gmail.com, deepthi@linux.vnet.ibm.com, lethal@linux-sh.org, jkosina@suse.cz, kgene.kim@samsung.com, khilman@deeprootsystems.com, tony@atomide.com, linux-pm@vger.kernel.org, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, josephl@nvidia.com

On Fri, Apr 12, 2013 at 02:36:03PM +0200, Daniel Lezcano wrote:
> Remove the duplicated code and use the cpuidle common code for initialization.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/cpuidle/cpuidle-kirkwood.c |   17 ++---------------
>  1 file changed, 2 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-kirkwood.c b/drivers/cpuidle/cpuidle-kirkwood.c
> index 6f31524..53290e1 100644
> --- a/drivers/cpuidle/cpuidle-kirkwood.c
> +++ b/drivers/cpuidle/cpuidle-kirkwood.c
> @@ -52,9 +52,6 @@ static struct cpuidle_driver kirkwood_idle_driver = {
>  	},
>  	.state_count = KIRKWOOD_MAX_STATES,
>  };
> -static struct cpuidle_device *device;
> -
> -static DEFINE_PER_CPU(struct cpuidle_device, kirkwood_cpuidle_device);
>  
>  /* Initialize CPU idle by registering the idle states */
>  static int kirkwood_cpuidle_probe(struct platform_device *pdev)
> @@ -69,22 +66,12 @@ static int kirkwood_cpuidle_probe(struct platform_device *pdev)
>  	if (IS_ERR(ddr_operation_base))
>  		return PTR_ERR(ddr_operation_base);
>  
> -	device = &per_cpu(kirkwood_cpuidle_device, smp_processor_id());
> -	device->state_count = KIRKWOOD_MAX_STATES;
> -
> -	cpuidle_register_driver(&kirkwood_idle_driver);
> -	if (cpuidle_register_device(device)) {
> -		pr_err("kirkwood_init_cpuidle: Failed registering\n");
> -		return -EIO;
> -	}
> -	return 0;
> +	return cpuidle_register(&kirkwood_idle_driver, NULL);
>  }
>  
>  int kirkwood_cpuidle_remove(struct platform_device *pdev)
>  {
> -	cpuidle_unregister_device(device);
> -	cpuidle_unregister_driver(&kirkwood_idle_driver);
> -
> +	cpuidle_unregister(&kirkwood_idle_driver);
>  	return 0;
>  }
>  
> -- 
> 1.7.9.5
> 

Tested-by: Andrew Lunn <andrew@lunn.ch>
