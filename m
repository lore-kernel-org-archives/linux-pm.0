From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] CPUFREQ: Loongson2: constify platform_device_id
Date: Tue, 22 Aug 2017 15:30:33 +0200
Message-ID: <1667536.6Dg5FN45O3@aspire.rjw.lan>
References: <38726390c030dc256d7dd169a416bc4a9814cbf7.1502617113.git.arvind.yadav.cs@gmail.com> <20170816032559.GB4233@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:54769 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932833AbdHVNjG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Aug 2017 09:39:06 -0400
In-Reply-To: <20170816032559.GB4233@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Wednesday, August 16, 2017 5:25:59 AM CEST Viresh Kumar wrote:
> On 13-08-17, 15:10, Arvind Yadav wrote:
> > platform_device_id are not supposed to change at runtime. All functions
> > working with platform_device_id provided by <linux/platform_device.h>
> > work with const platform_device_id. So mark the non-const structs as
> > const.
> > 
> > Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> > ---
> >  drivers/cpufreq/loongson2_cpufreq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/loongson2_cpufreq.c b/drivers/cpufreq/loongson2_cpufreq.c
> > index 9ac27b2..da34469 100644
> > --- a/drivers/cpufreq/loongson2_cpufreq.c
> > +++ b/drivers/cpufreq/loongson2_cpufreq.c
> > @@ -114,7 +114,7 @@ static struct cpufreq_driver loongson2_cpufreq_driver = {
> >  	.attr = cpufreq_generic_attr,
> >  };
> >  
> > -static struct platform_device_id platform_device_ids[] = {
> > +static const struct platform_device_id platform_device_ids[] = {
> >  	{
> >  		.name = "loongson2_cpufreq",
> >  	},
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> 

Applied, thanks!
