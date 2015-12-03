From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 2/5] thermal: rockchip: fix a impossible condition
 caused by the warning
Date: Thu, 3 Dec 2015 12:35:39 -0800
Message-ID: <20151203203539.GB34901@dtor-ws>
References: <1449132523-18817-1-git-send-email-wxt@rock-chips.com>
 <1449132523-18817-3-git-send-email-wxt@rock-chips.com>
 <20151203201908.GA34901@dtor-ws>
 <20151203203357.GA141945@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151203203357.GA141945-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Dec 03, 2015 at 12:33:57PM -0800, Brian Norris wrote:
> On Thu, Dec 03, 2015 at 12:19:08PM -0800, Dmitry Torokhov wrote:
> > On Thu, Dec 03, 2015 at 04:48:40PM +0800, Caesar Wang wrote:
> > > As the Dan report the smatch check the thermal driver warning:
> > > drivers/thermal/rockchip_thermal.c:551 rockchip_configure_from_dt()
> > > warn: impossible condition '(thermal->tshut_temp > ((~0 >> 1))) =>
> > > (s32min-s32max > s32max)'
> > > 
> > > Let's we remove the imposssible condition Since the Temperature is
> > > currently represented as int not long in the thermal driver.
> > > 
> > > Fixes: commit 437df2172e8d
> > > ("thermal: rockchip: consistently use int for temperatures")
> > > 
> > > Reported-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
> > > Signed-off-by: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> > > 
> > > ---
> > > 
> > > Changes in v3:
> > > - As Brian comments on https://patchwork.kernel.org/patch/7580661/,
> > >   let's remove the impossible condition.
> > > 
> > > Changes in v2: None
> > > Changes in v1: None
> > > 
> > >  drivers/thermal/rockchip_thermal.c | 6 ------
> > >  1 file changed, 6 deletions(-)
> > > 
> > > diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> > > index ae796ec..611de00 100644
> > > --- a/drivers/thermal/rockchip_thermal.c
> > > +++ b/drivers/thermal/rockchip_thermal.c
> > > @@ -549,12 +549,6 @@ static int rockchip_configure_from_dt(struct device *dev,
> > >  		thermal->tshut_temp = shut_temp;
> > >  	}
> > >  
> > > -	if (thermal->tshut_temp > INT_MAX) {
> > > -		dev_err(dev, "Invalid tshut temperature specified: %d\n",
> > > -			thermal->tshut_temp);
> > > -		return -ERANGE;
> > > -	}
> > 
> > Well, that is not entirely correct. The value that we read from DT is
> > u32, but we convert it down to int. I believe you want to move the check
> 
> Do we really account for the possibility of sizeof(int) < sizeof(u32)?
> 
> EDIT: A bit after writing the above line, I notice my error, but in case
> anyone else is thinking the same thing... I guess you're referring to
> the sign bit, since we're casting unsigned to signed.

Yes, exactly. Sorry I was not clear.

-- 
Dmitry
