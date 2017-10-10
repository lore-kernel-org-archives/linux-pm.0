From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: dt-platdev: drop socionext,uniphier-ld6b from
 whitelist
Date: Tue, 10 Oct 2017 08:55:25 +0530
Message-ID: <20171010032525.GE4031@vireshk-i7>
References: <1504021023-12459-1-git-send-email-yamada.masahiro@socionext.com>
 <20170914212655.GD11836@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170914212655.GD11836@ubuntu>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 14-09-17, 14:26, Viresh Kumar wrote:
> On 30-08-17, 00:37, Masahiro Yamada wrote:
> > As you see arch/arm/boot/dts/uniphier-ld6b.dtsi, it includes
> > uniphier-pxs2.dtsi, which uses "operating-points-v2" property
> > and whose cpufreq device is automatically created.
> > 
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> > 
> >  drivers/cpufreq/cpufreq-dt-platdev.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> > index a020da7940d6..c344fc1c4eb8 100644
> > --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> > +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> > @@ -83,8 +83,6 @@ static const struct of_device_id whitelist[] __initconst = {
> >  	{ .compatible = "rockchip,rk3368", },
> >  	{ .compatible = "rockchip,rk3399", },
> >  
> > -	{ .compatible = "socionext,uniphier-ld6b", },
> > -
> >  	{ .compatible = "st-ericsson,u8500", },
> >  	{ .compatible = "st-ericsson,u8540", },
> >  	{ .compatible = "st-ericsson,u9500", },
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

@Rafael: You missed my Ack while applying this patch ?

-- 
viresh
