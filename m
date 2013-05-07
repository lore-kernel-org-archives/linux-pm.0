From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH 1/6] thermal: armada: remove unnecessary
 platform_set_drvdata()
Date: Tue, 07 May 2013 09:09:47 +0900
Message-ID: <000601ce4ab7$2f696530$8e3c2f90$@samsung.com>
References: <003e01ce4a11$e1134900$a339db00$@samsung.com>
 <1367850754.2079.50.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:49208 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757466Ab3EGAJt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 May 2013 20:09:49 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MME007QMJ44K3D0@mailout3.samsung.com> for
 linux-pm@vger.kernel.org; Tue, 07 May 2013 09:09:47 +0900 (KST)
In-reply-to: <1367850754.2079.50.camel@rzhang1-mobl4>
Content-language: ko
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Zhang Rui' <rui.zhang@intel.com>
Cc: 'Eduardo Valentin' <eduardo.valentin@ti.com>, linux-pm@vger.kernel.org, 'Ezequiel Garcia' <ezequiel.garcia@free-electrons.com>, Jingoo Han <jg1.han@samsung.com>

On Monday, May 06, 2013 11:33 PM, Zhang Rui wrote:
> On Mon, 2013-05-06 at 13:26 +0900, Jingoo Han wrote:
> > The driver core clears the driver data to NULL after device_release
> > or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
> > (device-core: Ensure drvdata = NULL when no driver is bound).
> > Thus, it is not needed to manually clear the device driver data to NULL.
> >
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> 
> it seems that we already have a patchset for this issue.
> please check https://patchwork.kernel.org/patch/2516651/

OK, I see.
These patches seem to be already submitted.
Thank you.

Best regards,
Jingoo Han

> 
> thanks,
> rui
> > ---
> >  drivers/thermal/armada_thermal.c |    1 -
> >  1 files changed, 0 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
> > index 5b4d75f..0d02d4e 100644
> > --- a/drivers/thermal/armada_thermal.c
> > +++ b/drivers/thermal/armada_thermal.c
> > @@ -210,7 +210,6 @@ static int armada_thermal_exit(struct platform_device *pdev)
> >  		platform_get_drvdata(pdev);
> >
> >  	thermal_zone_device_unregister(armada_thermal);
> > -	platform_set_drvdata(pdev, NULL);
> >
> >  	return 0;
> >  }


