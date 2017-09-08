From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH][thermal-next] thermal: brcmstb: remove two redundant
 integer range checks
Date: Thu, 7 Sep 2017 19:59:36 -0700
Message-ID: <20170908025935.GB2755@localhost.localdomain>
References: <20170903131619.6857-1-colin.king@canonical.com>
 <20170906184046.GB35422@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170906184046.GB35422@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: Colin King <colin.king@canonical.com>, Markus Mayer <mmayer@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Zhang Rui <rui.zhang@intel.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-pm@vger.kernel.org

Hello,

On Wed, Sep 06, 2017 at 11:40:46AM -0700, Brian Norris wrote:
> Hi,
> 
> On Sun, Sep 03, 2017 at 02:16:19PM +0100, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > The comparisons for integer low on low > INT_MAX and also
> > integer high > INT_MAX are never going to be true since an
> > int type cannot be greater than INT_MAX.  Remove these redundant
> > checks.
> > 
> > Detected by: CoverityScan CID#1455245, 1455248 ("Operands don't affect
> >   result (CONSTANT_EXPRESSION_RESULT)")
> > 
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/thermal/broadcom/brcmstb_thermal.c | 4 ----
> >  1 file changed, 4 deletions(-)
> > 
> > diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
> > index 87b8e7a86ee3..bcb3945feea6 100644
> > --- a/drivers/thermal/broadcom/brcmstb_thermal.c
> > +++ b/drivers/thermal/broadcom/brcmstb_thermal.c
> > @@ -278,8 +278,6 @@ static int brcmstb_set_trips(void *data, int low, int high)
> >  	dev_dbg(priv->dev, "set trips %d <--> %d\n", low, high);
> >  
> >  	if (low) {
> > -		if (low > INT_MAX)
> > -			low = INT_MAX;
> >  		avs_tmon_set_trip_temp(priv, TMON_TRIP_TYPE_LOW, low);
> >  		avs_tmon_trip_enable(priv, TMON_TRIP_TYPE_LOW, 1);
> >  	} else {
> > @@ -287,8 +285,6 @@ static int brcmstb_set_trips(void *data, int low, int high)
> >  	}
> >  
> >  	if (high < ULONG_MAX) {
> 
> Dan's robots noticed that the above condition is not useful either (on
> architectures where INT_MAX < ULONG_MAX -- i.e., all?), since 'high' is
> 'int', not 'unsigned long'.
> 
> Should probably fix that
> 
> s/ULONG_MAX/INT_MAX/

Yeah, that would probably make sense. I might be also the case that the
driver was considering long because that was the type used to represent
temperature some time back in the thermal subsystem. So, the limits on
the driver may be outdated.

> 
> ?
> 
> Brian
> 
> > -		if (high > INT_MAX)
> > -			high = INT_MAX;
> >  		avs_tmon_set_trip_temp(priv, TMON_TRIP_TYPE_HIGH, high);
> >  		avs_tmon_trip_enable(priv, TMON_TRIP_TYPE_HIGH, 1);
> >  	} else {
> > -- 
> > 2.14.1
> > 
