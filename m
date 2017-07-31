From: Louis Yu <louis.yu@mediatek.com>
Subject: Re: [PATCH v1 4/4] thermal: mediatek: minor mtk_thermal.c cleanups
Date: Mon, 31 Jul 2017 15:23:31 +0800
Message-ID: <1501485811.9219.34.camel@mtksdaap41>
References: <1501134417-3505-1-git-send-email-louis.yu@mediatek.com>
         <1501134417-3505-5-git-send-email-louis.yu@mediatek.com>
         <c8585136-d7a8-3a47-1af2-512c6485eca0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:6382 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750877AbdGaHXh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Jul 2017 03:23:37 -0400
In-Reply-To: <c8585136-d7a8-3a47-1af2-512c6485eca0@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, dawei.chien@mediatek.com, fan.chen@mediatek.com, eddie.huang@mediatek.com, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com

Hi Matthias,

On Thu, 2017-07-27 at 17:49 +0200, Matthias Brugger wrote:
> 
> On 07/27/2017 07:46 AM, louis.yu@mediatek.com wrote:
> > From: Louis Yu <louis.yu@mediatek.com>
> > 
> > Move thermal module reset in the beginning and revise clock error
> > handle flow to pair the clock control.
> > 
> > Signed-off-by: Louis Yu <louis.yu@mediatek.com>
> > ---
> >   drivers/thermal/mtk_thermal.c | 12 ++++++------
> >   1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> > index f2a7155..5dffdb4 100644
> > --- a/drivers/thermal/mtk_thermal.c
> > +++ b/drivers/thermal/mtk_thermal.c
> > @@ -712,20 +712,20 @@ static int mtk_thermal_probe(struct platform_device *pdev)
> >   		return -EINVAL;
> >   	}
> >   
> > +	ret = device_reset(&pdev->dev);
> > +	if (ret)
> > +		return ret;
> > +
> >   	ret = clk_prepare_enable(mt->clk_auxadc);
> >   	if (ret) {
> >   		dev_err(&pdev->dev, "Can't enable auxadc clk: %d\n", ret);
> > -		return ret;
> > -	}
> > -
> > -	ret = device_reset(&pdev->dev);
> > -	if (ret)
> >   		goto err_disable_clk_auxadc;
> > +	}
> >   
> >   	ret = clk_prepare_enable(mt->clk_peri_therm);
> >   	if (ret) {
> >   		dev_err(&pdev->dev, "Can't enable peri clk: %d\n", ret);
> > -		goto err_disable_clk_auxadc;
> > +		goto err_disable_clk_peri_therm;
> 
> If you can't enable the clock, there is no use in disable it in the error path.
> 
> Regards,
> Matthias
> 

Thanks for your reminder.This is no use to disable it in the error path.
I would update this in next version as follows.

diff --git a/drivers/thermal/mtk_thermal.c
b/drivers/thermal/mtk_thermal.c
index 5dffdb4..3df0de3 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -719,13 +719,13 @@ static int mtk_thermal_probe(struct
platform_device *pdev)
 	ret = clk_prepare_enable(mt->clk_auxadc);
 	if (ret) {
 		dev_err(&pdev->dev, "Can't enable auxadc clk: %d\n", ret);
-		goto err_disable_clk_auxadc;
+		return ret;
 	}
 
 	ret = clk_prepare_enable(mt->clk_peri_therm);
 	if (ret) {
 		dev_err(&pdev->dev, "Can't enable peri clk: %d\n", ret);
-		goto err_disable_clk_peri_therm;
+		goto err_disable_clk_auxadc;
 	}
 
 	for (i = 0; i < mt->conf->num_banks; i++)


Regards
Louis

> >   	}
> >   
> >   	for (i = 0; i < mt->conf->num_banks; i++)
> > 
