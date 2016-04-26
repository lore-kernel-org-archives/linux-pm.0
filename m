From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] cpufreq: qoriq: Don't show cooling device messages if THERMAL_OF undefined
Date: Tue, 26 Apr 2016 02:02:50 +0200
Message-ID: <85987216.08EdccM4Dt@vostro.rjw.lan>
References: <1460966372-4877-1-git-send-email-hongtao.jia@nxp.com> <1460966372-4877-2-git-send-email-hongtao.jia@nxp.com> <20160418103345.GE2322@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:43400 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751095AbcDYX7v (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Apr 2016 19:59:51 -0400
In-Reply-To: <20160418103345.GE2322@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Jia Hongtao <hongtao.jia@nxp.com>
Cc: linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, scott.wood@nxp.com, yuantian.tang@nxp.com

On Monday, April 18, 2016 04:03:45 PM Viresh Kumar wrote:
> On 18-04-16, 15:59, Jia Hongtao wrote:
> > When THERMAL_OF is undefined the cooling device messages should not be
> > shown. -ENOSYS is returned from of_cpufreq_cooling_register() when
> > THERMAL_OF is undefined.
> > 
> > Signed-off-by: Jia Hongtao <hongtao.jia@nxp.com>
> > ---
> >  drivers/cpufreq/qoriq-cpufreq.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
> > index 1c2fdc1..ff8da83 100644
> > --- a/drivers/cpufreq/qoriq-cpufreq.c
> > +++ b/drivers/cpufreq/qoriq-cpufreq.c
> > @@ -340,8 +340,8 @@ static void qoriq_cpufreq_ready(struct cpufreq_policy *policy)
> >  		cpud->cdev = of_cpufreq_cooling_register(np,
> >  							 policy->related_cpus);
> >  
> > -		if (IS_ERR(cpud->cdev)) {
> > -			pr_err("Failed to register cooling device cpu%d: %ld\n",
> > +		if (IS_ERR(cpud->cdev) && PTR_ERR(cpud->cdev) != -ENOSYS) {
> > +			pr_err("cpu%d is not running as cooling device: %ld\n",
> >  					policy->cpu, PTR_ERR(cpud->cdev));
> >  
> >  			cpud->cdev = NULL;
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!

