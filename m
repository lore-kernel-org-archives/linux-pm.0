From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCHv2] cpufreq: Fix GOV_LIMITS handling for the userspace governor
Date: Thu, 05 May 2016 23:24:57 +0200
Message-ID: <1837593.H1JQ1fchN8@vostro.rjw.lan>
References: <5723D5C5.9030900@nvidia.com> <20160502020724.GD2855@vireshk-i7> <572B7A7D.9090505@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:44919 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757135AbcEEVVr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 May 2016 17:21:47 -0400
In-Reply-To: <572B7A7D.9090505@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sai Gurrappadi <sgurrappadi@nvidia.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Matthew Longnecker <MLongnecker@nvidia.com>

On Thursday, May 05, 2016 09:53:17 AM Sai Gurrappadi wrote:
> On 05/01/2016 07:07 PM, Viresh Kumar wrote:
> > On 29-04-16, 14:44, Sai Gurrappadi wrote:
> >> Currently, the userspace governor only updates frequency on GOV_LIMITS
> >> if policy->cur falls outside policy->{min/max}. However, it is also
> >> necessary to update current frequency on GOV_LIMITS to match the user
> >> requested value if it can be achieved within the new policy->{max/min}.
> >>
> >> This was previously the behaviour in the governor until commit d1922f0
> >> ("cpufreq: Simplify userspace governor") which incorrectly assumed that
> >> policy->cur == user requested frequency via scaling_setspeed. This won't
> >> be true if the user requested frequency falls outside policy->{min/max}.
> >> Ex: a temporary thermal cap throttled the user requested frequency.
> >>
> >> Fix this by storing the user requested frequency in a seperate variable.
> >> The governor will then try to achieve this request on every GOV_LIMITS
> >> change.
> >>
> >> Fixes: d1922f02562f ("cpufreq: Simplify userspace governor")
> >>
> >> Signed-off-by: Sai Gurrappadi <sgurrappadi@nvidia.com>
> >> ---
> >>
> >> Changes in v2:
> >> - Used policy->governor_data rather than using a per-cpu variable
> >>
> >>  drivers/cpufreq/cpufreq_userspace.c | 43 ++++++++++++++++++++++++++++++++-----
> >>  1 file changed, 38 insertions(+), 5 deletions(-)
> > 
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > 
> 
> Thanks! Do I just wait for Rafael to review/pick it up? Or is there anything
> else I must do?

That's been applied already, but your e-mail client munges lines that are more
than 80 characters long, so it wasn't fun to apply it.

Please fix that, I'm not going to apply mangled patches from you next time.

Thanks,
Rafael

