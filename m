From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v1 03/10] regulator: act8865: Use of_is_system_power_controller helper function
Date: Mon, 27 Oct 2014 18:03:51 +0100
Message-ID: <7689962.rlsfMIoFoC@diego>
References: <1414427215-14380-1-git-send-email-romain.perier@gmail.com> <1414427215-14380-3-git-send-email-romain.perier@gmail.com> <20141027164022.GC14253@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141027164022.GC14253@saruman>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Romain Perier <romain.perier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Am Montag, 27. Oktober 2014, 11:40:22 schrieb Felipe Balbi:
> On Mon, Oct 27, 2014 at 04:26:48PM +0000, Romain Perier wrote:
> > Signed-off-by: Romain Perier <romain.perier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> > 
> >  drivers/regulator/act8865-regulator.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/regulator/act8865-regulator.c
> > b/drivers/regulator/act8865-regulator.c index 76301ed..435aba1 100644
> > --- a/drivers/regulator/act8865-regulator.c
> > +++ b/drivers/regulator/act8865-regulator.c
> > @@ -365,7 +365,7 @@ static int act8865_pmic_probe(struct i2c_client
> > *client,> 
> >  		return ret;
> >  	
> >  	}
> > 
> > -	if (of_system_has_poweroff_source(dev->of_node)) {
> > +	if (of_is_system_power_controller(dev->of_node)) {
> 
> so building this driver is broken until this patch ? not very good
> either.
> 
> Looks to me you should add of_is_system_power_controller without remove
> of_system_has_poweroff_source() until all users of that have been
> converted over.

or alternatively fold this change into patch1 to keep the renaming together
