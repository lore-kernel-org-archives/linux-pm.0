From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH] selftests: cpufreq: Check cpuinfo_cur_freq set as
 expected
Date: Wed, 12 Jul 2017 19:51:27 +0300
Message-ID: <1499878287.11612.35.camel@nxp.com>
References: <704cfb6696840b3838576ea583b8ab8ed2265aaf.1499858779.git.leonard.crestez@nxp.com>
         <CAJZ5v0g5Chq-zw0tN6Mvp2YD2WKavUMp37UtAoFPLW3yiX4F1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bn3nam01on0086.outbound.protection.outlook.com ([104.47.33.86]:10689
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753659AbdGLQvd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Jul 2017 12:51:33 -0400
In-Reply-To: <CAJZ5v0g5Chq-zw0tN6Mvp2YD2WKavUMp37UtAoFPLW3yiX4F1w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, Octavian Purdila <octavian.purdila@nxp.com>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, 2017-07-12 at 13:36 +0200, Rafael J. Wysocki wrote:
> On Wed, Jul 12, 2017 at 1:29 PM, Leonard Crestez
> <leonard.crestez@nxp.com> wrote:
> > 
> > This checks that the cpufreq driver actually sets the requested
> > frequency.
> This won't work on modern x86  with APERF/MPERF (see recent commits in
> that area).

This test should be skipped if the cpu always adjusts it's own
frequency dynamically. It should check if scaling_set_speed won't
reflect in cpuinfo_cur_freq, but I'm not sure how to do that reliably.

I checked with the intel_pstate driver and it's already skipped in this
test because no userspace governor is available. This could be a way to
check if the CPU supports targetting a precise constant frequency.

Or are you saying that cpuinfo_cur_freq in general shouldn't be
expected to just return the current frequency but also adjust for time
spent in various idle states? It seems to me that if you want to track
the current load it might be better to report this through different
more explicit mechanism.

In particular imx already supports cpuidle states where the arm core
clock is turned off and later resumed but this has no effect on
cpuinfo_cur_freq.

--
Regards,
Leonard
