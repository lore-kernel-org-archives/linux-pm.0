From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] selftests: cpufreq: Check cpuinfo_cur_freq set as
 expected
Date: Thu, 13 Jul 2017 14:25:37 +0530
Message-ID: <20170713085537.GD352@vireshk-i7>
References: <704cfb6696840b3838576ea583b8ab8ed2265aaf.1499858779.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33267 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbdGMIzl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jul 2017 04:55:41 -0400
Received: by mail-pf0-f182.google.com with SMTP id e7so26329838pfk.0
        for <linux-pm@vger.kernel.org>; Thu, 13 Jul 2017 01:55:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <704cfb6696840b3838576ea583b8ab8ed2265aaf.1499858779.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Octavian Purdila <octavian.purdila@nxp.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 12-07-17, 14:29, Leonard Crestez wrote:
> This checks that the cpufreq driver actually sets the requested
> frequency.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> 
> ---
> 
> I've been looking at using kselftests for imx. This patch exposes an
> issue with the imx6 cpufreq driver on imx6sx where frequencies are set
> incorrectly because of clk mishandling. This is already caught by some
> internal test scripts which also run against upstream but it's nice to
> make this visible through kselftest.

Sure, thanks for that.

> I'm not sure it's correct to check that frequency matches exactly,
> perhaps something like a 5% tolerance should be included for complex
> drivers where the target freq is only a "hint"?

We can do better, see below..

> I checked intel_pstate
> but it doesn't even seem to expose an userspace governor for manual
> frequency selection anyway.

Sure, and so that wouldn't be affected by this.

> Unfortunately cpufreq selftests don't seem to have a clear idea of
> "pass" or "fail" results.

Yeah, I had this test setup for a while and just pushed it through.
Over that many tests aren't really tests but just looking out for
crashes, etc. Never got a chance to improve it :(

> This patch will just print some TAP-like
> "ok" and "not ok" lines but failures are not actually propagated upwards
> in a well-defined way.

That would be fine for now.

> Have you considered what it would take to TAP-ify the output of cpufreq
> tests? Output is very complex so perhaps it might make sense to adopt some
> sort of subtest syntax for kselftest, something like this:

Not yet :(

> diff --git a/tools/testing/selftests/cpufreq/cpufreq.sh b/tools/testing/selftests/cpufreq/cpufreq.sh
> index 1ed3832..323b5bb 100755
> --- a/tools/testing/selftests/cpufreq/cpufreq.sh
> +++ b/tools/testing/selftests/cpufreq/cpufreq.sh
> @@ -151,6 +151,14 @@ test_all_frequencies()
>  	# Set all frequencies one-by-one
>  	for freq in $freqs; do
>  		set_cpu_frequency $1 $freq
> +
> +		local cur_freq
> +		cur_freq=`cat $CPUFREQROOT/$1/cpuinfo_cur_freq`

Yes, we want to verify if freq change happened or not, but may be only
reading scaling_cur_freq would be enough for now?

And that wouldn't be a problem for X86 (which Rafael mentioned) as
well IIUC.

-- 
viresh
