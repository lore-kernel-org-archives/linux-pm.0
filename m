From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: Apply default governor for setpolicy drivers
Date: Thu, 19 Dec 2013 00:33:26 +0100
Message-ID: <2651749.Dr3egRT25J@vostro.rjw.lan>
References: <20131218203102.9F9692036@prod-mail-relay06.akamai.com> <1451068.r0h0sa1DaG@vostro.rjw.lan> <52B21508.3000303@akamai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <52B21508.3000303@akamai.com>
Sender: cpufreq-owner@vger.kernel.org
To: Jason Baron <jbaron@akamai.com>
Cc: "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dirk Brandewie <dirk.j.brandewie@intel.com>, "dirk.brandewie@gmail.com" <dirk.brandewie@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday, December 18, 2013 04:35:04 PM Jason Baron wrote:
> On 12/18/2013 04:38 PM, Rafael J. Wysocki wrote:
> > On Wednesday, December 18, 2013 08:31:02 PM Jason Baron wrote:
> >> When configuring a default governor (via CONFIG_CPU_FREQ_DEFAULT_*) with the
> >> 'intel_pstate' driver, I found that the default is not honored. For example,
> >> configure 'CONFIG_CPU_FREQ_GOV_PERFORMANCE', and then do:
> > intel_pstate doesn't use any cpufreq governors, so all of this is pointless
> > for that particular driver anyway.
> >
> > Thanks!
> >
> 
> Ok, but if I look at 'intel_pstate', I see a 'set_policy' call that does different
> things if the policy is 'performance' vs. 'powersave'. Same for the 'longrun'
> driver. So yes, they don't use the 'governors', but changing the governors
> at runtime does appear to change change how they behave.

OK, so you want the initial policy to be set in accordance with the
CONFIG_CPU_FREQ_DEFAULT_* setting.  That makes sense, although it is not
immediately clear from the patch changelog.

That said the change in the patch looks kind of overly complicated.
What about adding something like this instead?

+       if (cpufreq_driver->setpolicy) {
+               unsigned int ret;
+
+       	/* Use the default policyt if it is valid. */
+               if (!cpufreq_parse_governor(policy->governor->name, &ret, NULL))
+                       new_policy.policy = ret;
+       }

Rafael

