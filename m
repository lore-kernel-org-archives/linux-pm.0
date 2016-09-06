From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal: armada: add support for suspend/resume
Date: Tue, 06 Sep 2016 08:36:51 +0800
Message-ID: <1473122211.2201.28.camel@intel.com>
References: <1469097807-17748-1-git-send-email-jaz@semihalf.com>
         <1471611994.2691.72.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:39683 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754823AbcIFAg4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 5 Sep 2016 20:36:56 -0400
In-Reply-To: <1471611994.2691.72.camel@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Grzegorz Jaszczyk <jaz@semihalf.com>, edubezval@gmail.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, thomas.petazzoni@free-electrons.com, gregory.clement@free-electrons.com, ezequiel.garcia@free-electrons.com
Cc: mw@semihalf.com, alior@marvell.com

On 五, 2016-08-19 at 21:06 +0800, Zhang Rui wrote:
> On 四, 2016-07-21 at 12:43 +0200, Grzegorz Jaszczyk wrote:
> > 
> > There is no need to implement subroutine for suspend since there is
> > no
> > data to store before suspending.
> > 
> > Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
> Ezequiel,
> 
> what do you think of this patch?
> 
Ezequiel,
As the author of the armada_thermal driver, it would be great if you
can be the goalkeeper for all armada_thermal changes, and I'd prefer to
get your ACK/NAK before applying/dropping any armada thermal patches.
Can you please take a look at this patch?

BTW, Grzegorz, for the PM callbacks, you'd better to either use
__maybe_unused so that gcc can drop it if it's not used, or use #ifdef
to compile them out when CONFIG_PM_SLEEP is not set.
You can also refer to this patch https://patchwork.kernel.org/patch/931
1025/	


thanks,
rui 
> thanks,
> rui
> > 
> > ---
> >  drivers/thermal/armada_thermal.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/drivers/thermal/armada_thermal.c
> > b/drivers/thermal/armada_thermal.c
> > index ae75328..65f9838 100644
> > --- a/drivers/thermal/armada_thermal.c
> > +++ b/drivers/thermal/armada_thermal.c
> > @@ -304,12 +304,26 @@ static int armada_thermal_exit(struct
> > platform_device *pdev)
> >  	return 0;
> >  }
> >  
> > +static int armada_thermal_resume(struct device *dev)
> > +{
> > +	struct thermal_zone_device *thermal =
> > +		dev_get_drvdata(dev);
> > +	struct armada_thermal_priv *priv = thermal->devdata;
> > +
> > +	priv->data->init_sensor(to_platform_device(dev), priv);
> > +
> > +	return 0;
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(armada_thermal_pm_ops, NULL,
> > armada_thermal_resume);
> > +
> >  static struct platform_driver armada_thermal_driver = {
> >  	.probe = armada_thermal_probe,
> >  	.remove = armada_thermal_exit,
> >  	.driver = {
> >  		.name = "armada_thermal",
> >  		.of_match_table = armada_thermal_id_table,
> > +		.pm = &armada_thermal_pm_ops,
> >  	},
> >  };
> >  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
