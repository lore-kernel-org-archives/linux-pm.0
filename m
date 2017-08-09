From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: dt: Add rk3328 compatible to use generic cpufreq driver
Date: Thu, 10 Aug 2017 00:49:35 +0200
Message-ID: <2561837.4o82W0B20K@aspire.rjw.lan>
References: <1501811551-39168-1-git-send-email-finley.xiao@rock-chips.com> <20170804051041.GB28857@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:65438 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751884AbdHIW5x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Aug 2017 18:57:53 -0400
In-Reply-To: <20170804051041.GB28857@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Finley Xiao <finley.xiao@rock-chips.com>
Cc: heiko@sntech.de, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, jay.xu@rock-chips.com, huangtao@rock-chips.coms, tony.xie@rock-chips.com, cl@rock-chips.com

On Friday, August 4, 2017 7:10:41 AM CEST Viresh Kumar wrote:
> On 04-08-17, 09:52, Finley Xiao wrote:
> > This patch adds the rk3328 compatible string for supporting
> > the generic cpufreq driver on RK3328.
> > 
> > Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> > ---
> >  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> > index 096aea7..13c0c47 100644
> > --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> > +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> > @@ -76,6 +76,7 @@ static const struct of_device_id machines[] __initconst = {
> >  	{ .compatible = "rockchip,rk3188", },
> >  	{ .compatible = "rockchip,rk3228", },
> >  	{ .compatible = "rockchip,rk3288", },
> > +	{ .compatible = "rockchip,rk3328", },
> >  	{ .compatible = "rockchip,rk3366", },
> >  	{ .compatible = "rockchip,rk3368", },
> >  	{ .compatible = "rockchip,rk3399", },
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> 

Applied, thanks!
