From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/3] thermal: cpu_cooling: Check OPP for errors
Date: Tue, 7 Feb 2017 09:28:15 +0530
Message-ID: <20170207035815.GK3131@vireshk-i7>
References: <232171cd9d89c2179e10e1f2aed71ad7fc1f7872.1486376756.git.viresh.kumar@linaro.org>
 <de7260e97192c3fb57709340cf3766366e38ae76.1486376756.git.viresh.kumar@linaro.org>
 <2237771.GAr8QlFsVi@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36706 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751414AbdBGD6T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Feb 2017 22:58:19 -0500
Received: by mail-pf0-f181.google.com with SMTP id 189so29340324pfu.3
        for <linux-pm@vger.kernel.org>; Mon, 06 Feb 2017 19:58:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <2237771.GAr8QlFsVi@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Amit Daniel Kachhap <amit.kachhap@gmail.com>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Dan Carpenter <dan.carpenter@oracle.com>

On 06-02-17, 13:02, Rafael J. Wysocki wrote:
> On Monday, February 06, 2017 03:56:28 PM Viresh Kumar wrote:
> > It is possible for dev_pm_opp_find_freq_exact() to return errors. It was
> > all fine earlier as dev_pm_opp_get_voltage() had a check within it to
> > check for invalid OPPs, but dev_pm_opp_put() doesn't have any similar
> > checks and the callers need to make sure OPP is valid before calling
> > them.
> > 
> > Also update the later dev_warn_ratelimited() to not print the error
> > message as the OPP is guaranteed to be valid now.
> > 
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/thermal/cpu_cooling.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> > index 85fdbf762fa0..9534540434e2 100644
> > --- a/drivers/thermal/cpu_cooling.c
> > +++ b/drivers/thermal/cpu_cooling.c
> > @@ -431,13 +431,20 @@ static int get_static_power(struct cpufreq_cooling_device *cpufreq_device,
> >  
> >  	opp = dev_pm_opp_find_freq_exact(cpufreq_device->cpu_dev, freq_hz,
> >  					 true);
> > +	if (IS_ERR(opp)) {
> > +		dev_warn_ratelimited(cpufreq_device->cpu_dev,
> > +				     "Failed to find OPP for frequency %lu: %ld\n",
> > +				     freq_hz, PTR_ERR(opp));
> 
> I'm quite unconvinced about the WARN level of these messages.
> 
> They seem to be mostly useful for the people who provide device trees for
> platforms (ie. system integrators).  If users see them, there is not much
> they can do to fix the problem by themselves and the hardware is OK,
> actually.

Sure. I just wanted to keep it consistent within the function.

-- 
viresh
