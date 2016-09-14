From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 19/26] intel_pstate: constify local structures
Date: Wed, 14 Sep 2016 02:59:04 +0200
Message-ID: <3579327.U86TbOTq2t@vostro.rjw.lan>
References: <1473599168-30561-1-git-send-email-Julia.Lawall@lip6.fr> <1473599168-30561-20-git-send-email-Julia.Lawall@lip6.fr> <20160912064230.GA8011@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:47492 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1752289AbcINAw5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Sep 2016 20:52:57 -0400
In-Reply-To: <20160912064230.GA8011@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, joe@perches.com, kernel-janitors@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday, September 12, 2016 12:12:30 PM Viresh Kumar wrote:
> On 11-09-16, 15:06, Julia Lawall wrote:
> > For structure types defined in the same file or local header files, find
> > top-level static structure declarations that have the following
> > properties:
> > 1. Never reassigned.
> > 2. Address never taken
> > 3. Not passed to a top-level macro call
> > 4. No pointer or array-typed field passed to a function or stored in a
> > variable.
> > Declare structures having all of these properties as const.
> > 
> > Done using Coccinelle.
> > Based on a suggestion by Joe Perches <joe@perches.com>.
> > 
> > Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> > 
> > ---
> > The semantic patch seems too long for a commit log, but is in the cover
> > letter.
> > 
> >  drivers/cpufreq/intel_pstate.c |    8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> > index bdbe936..4b5f8c3 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -1029,7 +1029,7 @@ static struct cpu_defaults core_params = {
> >  	},
> >  };
> >  
> > -static struct cpu_defaults silvermont_params = {
> > +static const struct cpu_defaults silvermont_params = {
> >  	.pid_policy = {
> >  		.sample_rate_ms = 10,
> >  		.deadband = 0,
> > @@ -1050,7 +1050,7 @@ static struct cpu_defaults silvermont_params = {
> >  	},
> >  };
> >  
> > -static struct cpu_defaults airmont_params = {
> > +static const struct cpu_defaults airmont_params = {
> >  	.pid_policy = {
> >  		.sample_rate_ms = 10,
> >  		.deadband = 0,
> > @@ -1071,7 +1071,7 @@ static struct cpu_defaults airmont_params = {
> >  	},
> >  };
> >  
> > -static struct cpu_defaults knl_params = {
> > +static const struct cpu_defaults knl_params = {
> >  	.pid_policy = {
> >  		.sample_rate_ms = 10,
> >  		.deadband = 0,
> > @@ -1091,7 +1091,7 @@ static struct cpu_defaults knl_params = {
> >  	},
> >  };
> >  
> > -static struct cpu_defaults bxt_params = {
> > +static const struct cpu_defaults bxt_params = {
> >  	.pid_policy = {
> >  		.sample_rate_ms = 10,
> >  		.deadband = 0,
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied.

Thanks,
Rafael

