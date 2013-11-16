From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [Update PATCH 1/1] Cpufreq: Make governor data on nonboot cpus across system suspend/resume
Date: Sat, 16 Nov 2013 16:09:44 +0100
Message-ID: <2541765.pYv7UXDJWx@vostro.rjw.lan>
References: <1384495294-10565-1-git-send-email-tianyu.lan@intel.com> <5286EDBF.9050001@intel.com> <9847309.KdKOG5y1Zx@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <9847309.KdKOG5y1Zx@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: viresh.kumar@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Saturday, November 16, 2013 03:41:10 PM Rafael J. Wysocki wrote:

[...]

> > >> @@ -1822,6 +1822,9 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
> > >>   			((event == CPUFREQ_GOV_POLICY_EXIT) && !ret))
> > >>   		module_put(policy->governor->owner);
> > >>
> > >> +	if ((event == CPUFREQ_GOV_POLICY_INIT) && ret == -EALREADY)
> > >> +		ret = 0;
> > >> +
> 
> -> I'd prefer this check to be combined with the one done to determine whether
> or not we need to do the module_put().  Something like
> 
> 	if (event == CPUFREQ_GOV_POLICY_EXIT && ret) {

Obviously, that should be:

	if (event == CPUFREQ_GOV_POLICY_INIT && ret) {

> 		module_put(policy->governor->owner);
> 		if (ret == -EALREADY)
> 			return 0;
> 	} else if (event == CPUFREQ_GOV_POLICY_EXIT && !ret) {
> 		module_put(policy->governor->owner);
> 	}

Sorry for the confusion.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
