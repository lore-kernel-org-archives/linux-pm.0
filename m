From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] devfreq_cooling: no need to check state with negative
 number
Date: Wed, 24 Aug 2016 14:10:00 +0800
Message-ID: <1472019000.2682.0.camel@intel.com>
References: <CGME20160822081333epcas1p1d61dc80a90c8961ac5fca0686bc79b48@epcas1p1.samsung.com>
         <1471853286-10432-1-git-send-email-shawn.lin@rock-chips.com>
         <57BBDA4A.3030805@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:16533 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750947AbcHXGKU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 24 Aug 2016 02:10:20 -0400
In-Reply-To: <57BBDA4A.3030805@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, Shawn Lin <shawn.lin@rock-chips.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org

On 二, 2016-08-23 at 14:08 +0900, Chanwoo Choi wrote:
> Hi,
> 
> On 2016년 08월 22일 17:08, Shawn Lin wrote:
> > 
> > We could see that state is defined as unsigned type, so it
> > should never be less than zero. Let' remove this check.
> > 
> > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> > ---
> > 
> >  drivers/thermal/devfreq_cooling.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/thermal/devfreq_cooling.c
> > b/drivers/thermal/devfreq_cooling.c
> > index 01f0015..81631b1 100644
> > --- a/drivers/thermal/devfreq_cooling.c
> > +++ b/drivers/thermal/devfreq_cooling.c
> > @@ -312,7 +312,7 @@ static int devfreq_cooling_state2power(struct
> > thermal_cooling_device *cdev,
> >  	unsigned long freq;
> >  	u32 static_power;
> >  
> > -	if (state < 0 || state >= dfc->freq_table_size)
> > +	if (state >= dfc->freq_table_size)
> >  		return -EINVAL;
> >  
> >  	freq = dfc->freq_table[state];
> > 
> As the description, the 'state' variable is unsigned type.
> 
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> 
Patch applied.

thanks,
rui
