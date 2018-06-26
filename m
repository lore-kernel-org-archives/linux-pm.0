From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2 10/21] cpufreq: intel_pstate: use match_string()
 helper
Date: Tue, 26 Jun 2018 16:56:30 -0700
Message-ID: <9ae4955e8026e1ddf0567e5cc210c5713668b631.camel@linux.intel.com>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
         <1527765086-19873-11-git-send-email-xieyisheng1@huawei.com>
         <1633797.WhvbXNE1Nx@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1633797.WhvbXNE1Nx@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Yisheng Xie <xieyisheng1@huawei.com>
Cc: linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com, Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 2018-06-26 at 17:23 +0200, Rafael J. Wysocki wrote:
> On Thursday, May 31, 2018 1:11:15 PM CEST Yisheng Xie wrote:
> > match_string() returns the index of an array for a matching string,
> > which can be used instead of open coded variant.
> > 
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: linux-pm@vger.kernel.org
> > Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> > ---
> > v2:
> >  - add Reviewed-by tag.
> > 
> >  drivers/cpufreq/intel_pstate.c | 15 ++++++---------
> >  1 file changed, 6 insertions(+), 9 deletions(-)
> > performance
> > diff --git a/drivers/cpufreq/intel_pstate.c
> > b/drivers/cpufreq/intel_pstate.c
> > index 17e566af..d701e26 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -645,21 +645,18 @@ static ssize_t
> > store_energy_performance_preference(
> >  {
> >  	struct cpudata *cpu_data = all_cpu_data[policy->cpu];
> >  	char str_preference[21];
> > -	int ret, i = 0;
> > +	int ret;
> >  
> >  	ret = sscanf(buf, "%20s", str_preference);
> >  	if (ret != 1)
> >  		return -EINVAL;
> >  
> > -	while (energy_perf_strings[i] != NULL) {
> > -		if (!strcmp(str_preference,
> > energy_perf_strings[i])) {
> > -			intel_pstate_set_energy_pref_index(cpu_dat
> > a, i);
> > -			return count;
> > -		}
> > -		++i;
> > -	}
> > +	ret = match_string(energy_perf_strings, -1,
> > str_preference);
> > +	if (ret < 0)
> > +		return ret;
> >  
> > -	return -EINVAL;
> > +	intel_pstate_set_energy_pref_index(cpu_data, ret);
> > +	return count;
> >  }
> >  
> >  static ssize_t show_energy_performance_preference(
> > 
> 
> Srinivas, any concerns?
> 
