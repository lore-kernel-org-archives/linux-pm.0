From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH] selftests: cpufreq: Check cpuinfo_cur_freq set as
 expected
Date: Tue, 18 Jul 2017 22:34:19 +0300
Message-ID: <1500406459.11874.1.camel@nxp.com>
References: <704cfb6696840b3838576ea583b8ab8ed2265aaf.1499858779.git.leonard.crestez@nxp.com>
         <20170713085537.GD352@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170713085537.GD352@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, Octavian Purdila <octavian.purdila@nxp.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, 2017-07-13 at 14:25 +0530, Viresh Kumar wrote:
> On 12-07-17, 14:29, Leonard Crestez wrote:
> > 
> > This checks that the cpufreq driver actually sets the requested
> > frequency.
> > 
> > Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> > 
> > ---
> > 
> > I've been looking at using kselftests for imx. This patch exposes an
> > issue with the imx6 cpufreq driver on imx6sx where frequencies are set
> > incorrectly because of clk mishandling. This is already caught by some
> > internal test scripts which also run against upstream but it's nice to
> > make this visible through kselftest.
> Sure, thanks for that.
> 
> > I'm not sure it's correct to check that frequency matches exactly,
> > perhaps something like a 5% tolerance should be included for complex
> > drivers where the target freq is only a "hint"?
> We can do better, see below..
> 
> > I checked intel_pstate
> > but it doesn't even seem to expose an userspace governor for manual
> > frequency selection anyway.
> Sure, and so that wouldn't be affected by this.
> 
> > diff --git a/tools/testing/selftests/cpufreq/cpufreq.sh
> > b/tools/testing/selftests/cpufreq/cpufreq.sh
> > index 1ed3832..323b5bb 100755
> > --- a/tools/testing/selftests/cpufreq/cpufreq.sh
> > +++ b/tools/testing/selftests/cpufreq/cpufreq.sh
> > @@ -151,6 +151,14 @@ test_all_frequencies()
> >  	# Set all frequencies one-by-one
> >  	for freq in $freqs; do
> >  		set_cpu_frequency $1 $freq
> > +
> > +		local cur_freq
> > +		cur_freq=`cat $CPUFREQROOT/$1/cpuinfo_cur_freq`
> Yes, we want to verify if freq change happened or not, but may be only
> reading scaling_cur_freq would be enough for now?
> 
> And that wouldn't be a problem for X86 (which Rafael mentioned) as
> well IIUC.
> 
The semantics of scaling_cur_freq and cpuinfo_cur_freq are not very
clear to me.

In my particular case I need to check cpuinfo_cur_freq because this is
what ends up returning the rate of the arm clk. Otherwise
scaling_cur_freq just returns policy->cur unless the driver has a
setpolicy function (I don't understand that condition).

Since commit f8475cef9008 ("x86: use common aperfmperf_khz_on_cpu() to
calculate KHz using APERF/MPERF") scaling_cur_freq will also try to
return the "computed frequency" on x86.

I ran selftest with this patch on top of upstream on an AMD Phenom
machine (scaling_driver="acpi_cpufreq") and it still passes. It returns
the value computed through aperf/mperf in scaling_cur_freq but manual
explicit switching between supported frequencies is reflected in
cpuinfo_cur_freq, as the test expects.

I'm not sure this means that cpuinfo_cur_freq is the correct choice, it
seems like it works mostly by accident rather than ABI guarantees. I
suspect that if people actually attempt to run this test on a wide
variety of systems it will need an endless stream of platform-specific
hacks to pass. Better to let this die.

--
Regards,
Leonard
