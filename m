From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/2] SH: cpuidle: use init/exit common routine
Date: Wed, 24 Apr 2013 14:08:52 +0200
Message-ID: <1913054.HRUbb7yvdy@vostro.rjw.lan>
References: <1366728077-18988-1-git-send-email-daniel.lezcano@linaro.org> <1366728077-18988-2-git-send-email-daniel.lezcano@linaro.org> <20130424060214.GA7149@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:42704 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757633Ab3DXMAt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 24 Apr 2013 08:00:49 -0400
In-Reply-To: <20130424060214.GA7149@verge.net.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, ben-linux@fluff.org, kgene.kim@samsung.com, lethal@linux-sh.org, patches@linaro.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org

On Wednesday, April 24, 2013 03:02:15 PM Simon Horman wrote:
> On Tue, Apr 23, 2013 at 04:41:17PM +0200, Daniel Lezcano wrote:
> > Remove the duplicated code and use the cpuidle common code for initialization.
> > 
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> Acked-by: Simon Horman <horms+renesas@verge.net.au>

Applied.

Thanks,
Rafael


> > ---
> >  arch/sh/kernel/cpu/shmobile/cpuidle.c |    7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)
> > 
> > diff --git a/arch/sh/kernel/cpu/shmobile/cpuidle.c b/arch/sh/kernel/cpu/shmobile/cpuidle.c
> > index fdfe57f4..d306225 100644
> > --- a/arch/sh/kernel/cpu/shmobile/cpuidle.c
> > +++ b/arch/sh/kernel/cpu/shmobile/cpuidle.c
> > @@ -51,7 +51,6 @@ static int cpuidle_sleep_enter(struct cpuidle_device *dev,
> >  	return k;
> >  }
> >  
> > -static struct cpuidle_device cpuidle_dev;
> >  static struct cpuidle_driver cpuidle_driver = {
> >  	.name   = "sh_idle",
> >  	.owner  = THIS_MODULE,
> > @@ -100,9 +99,5 @@ int __init sh_mobile_setup_cpuidle(void)
> >  	if (sh_mobile_sleep_supported & SUSP_SH_STANDBY)
> >  		cpuidle_driver.states[2].disabled = false;
> >  
> > -	ret = cpuidle_register_driver(&cpuidle_driver);
> > -	if (ret)
> > -		return ret;
> > -
> > -	return cpuidle_register_device(&cpuidle_dev);
> > +	return cpuidle_register(&cpuidle_driver);
> >  }
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
