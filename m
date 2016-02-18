From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH] thermal: use %d to print S32 parameters
Date: Thu, 18 Feb 2016 17:42:22 +0800
Message-ID: <20160218094222.GB28887@leoy-linaro>
References: <1452674036-14907-1-git-send-email-leo.yan@linaro.org>
 <20160113092216.GB2594@e104805>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34090 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425910AbcBRJma (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2016 04:42:30 -0500
Received: by mail-pa0-f50.google.com with SMTP id fy10so27960727pac.1
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2016 01:42:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160113092216.GB2594@e104805>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Punit Agrawal <punit.agrawal@arm.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jan 13, 2016 at 09:22:16AM +0000, Javi Merino wrote:
> On Wed, Jan 13, 2016 at 04:33:56PM +0800, Leo Yan wrote:
> > Power allocator's parameters are S32 type, so use %d to print them.
> 
> Indeed.  The name of the macro is create_s32_tzp_attr(), it's
> explicitly saying that the parameter is signed!
> 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> 
> Acked-by: Javi Merino <javi.merino@arm.com>

Rui, Eduardo,

Could you help merge this patch as well?

Thanks,
Leo Yan

> 
> Cheers,
> Javi
> 
> > ---
> >  drivers/thermal/thermal_core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> > index d9e525c..1335df2 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -931,7 +931,7 @@ static DEVICE_ATTR(sustainable_power, S_IWUSR | S_IRUGO, sustainable_power_show,
> >  	struct thermal_zone_device *tz = to_thermal_zone(dev);		\
> >  									\
> >  	if (tz->tzp)							\
> > -		return sprintf(buf, "%u\n", tz->tzp->name);		\
> > +		return sprintf(buf, "%d\n", tz->tzp->name);		\
> >  	else								\
> >  		return -EIO;						\
> >  	}								\
> > -- 
> > 1.9.1
> > 
