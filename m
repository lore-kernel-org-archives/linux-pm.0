From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal: armada: add support for suspend/resume
Date: Tue, 27 Sep 2016 09:51:45 +0800
Message-ID: <1474941105.4284.2.camel@intel.com>
References: <1469097807-17748-1-git-send-email-jaz@semihalf.com>
         <57CFCA42.8000807@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:23581 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932504AbcI0Bvu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 26 Sep 2016 21:51:50 -0400
In-Reply-To: <57CFCA42.8000807@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mason <slash.tmp@free.fr>, Grzegorz Jaszczyk <jaz@semihalf.com>, linux-pm@vger.kernel.org
Cc: edubezval@gmail.com, thomas.petazzoni@free-electrons.com, gregory.clement@free-electrons.com, mw@semihalf.com, alior@marvell.com, Arnd Bergmann <arnd@arndb.de>

On 三, 2016-09-07 at 10:05 +0200, Mason wrote:
> On 21/07/2016 12:43, Grzegorz Jaszczyk wrote:
> 
> > 
> > There is no need to implement subroutine for suspend since there is
> > no
> > data to store before suspending.
> > 
> > Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
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
> gcc might warn about 'armada_thermal_resume' defined but not used
> when CONFIG_PM_SLEEP is not defined, I think?
> 
> (I have a similar patch, Arnd suggested using __maybe_unused tag.)
> 
right.
Grzegorz, you can use this one as a reference. https://patchwork.kernel
.org/patch/9318621/

thanks,
rui

> Regards.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
