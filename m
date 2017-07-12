From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] selftests: cpufreq: Check cpuinfo_cur_freq set as expected
Date: Wed, 12 Jul 2017 22:38:44 +0200
Message-ID: <CAJZ5v0gtqQKcpyn0+aDMn39CLzgtP35Yg5qK9KoJp-ux8PF7Xg@mail.gmail.com>
References: <704cfb6696840b3838576ea583b8ab8ed2265aaf.1499858779.git.leonard.crestez@nxp.com>
 <CAJZ5v0g5Chq-zw0tN6Mvp2YD2WKavUMp37UtAoFPLW3yiX4F1w@mail.gmail.com> <1499878287.11612.35.camel@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:35337 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752973AbdGLUip (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jul 2017 16:38:45 -0400
In-Reply-To: <1499878287.11612.35.camel@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, Octavian Purdila <octavian.purdila@nxp.com>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Jul 12, 2017 at 6:51 PM, Leonard Crestez
<leonard.crestez@nxp.com> wrote:
> On Wed, 2017-07-12 at 13:36 +0200, Rafael J. Wysocki wrote:
>> On Wed, Jul 12, 2017 at 1:29 PM, Leonard Crestez
>> <leonard.crestez@nxp.com> wrote:
>> >
>> > This checks that the cpufreq driver actually sets the requested
>> > frequency.
>> This won't work on modern x86  with APERF/MPERF (see recent commits in
>> that area).
>
> This test should be skipped if the cpu always adjusts it's own
> frequency dynamically. It should check if scaling_set_speed won't
> reflect in cpuinfo_cur_freq, but I'm not sure how to do that reliably.

Well, this is my concern, actually.

> I checked with the intel_pstate driver and it's already skipped in this
> test because no userspace governor is available. This could be a way to
> check if the CPU supports targetting a precise constant frequency.
>
> Or are you saying that cpuinfo_cur_freq in general shouldn't be
> expected to just return the current frequency but also adjust for time
> spent in various idle states?

On x86 cpuinfo_cur_freq shouldn't be expected to return the frequency
requested by the driver.

After the recent changes, if the APERF and MPERF feedback registers
are available, arch code will use them to compute the current
frequency as seen by the CPU which is not guaranteed to be equal to
whatever has been requested by the cpufreq driver for various reasons.

> It seems to me that if you want to track
> the current load it might be better to report this through different
> more explicit mechanism.
>
> In particular imx already supports cpuidle states where the arm core
> clock is turned off and later resumed but this has no effect on
> cpuinfo_cur_freq.

I guess you could just blacklist x86 overall in this test.

Thanks,
Rafael
