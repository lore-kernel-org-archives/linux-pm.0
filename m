From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH] cpufreq, intel_pstate, set max_sysfs_pct and min_sysfs_pct on governor switch
Date: Wed, 7 Oct 2015 08:40:44 -0700
Message-ID: <000301d10116$88852330$998f6990$@net>
References: <1444168147-17812-1-git-send-email-prarit@redhat.com> <1755198.JNkaHg87IV@vostro.rjw.lan> <1594304.lVcRDcB3yL@vostro.rjw.lan> <002701d100cc$98cb8c60$ca62a520$@net> <5614ED1C.8070709@redhat.com> <000001d10109$10d34630$3279d290$@net> <561527D9.3020009@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta12.telus.net ([209.171.16.85]:49795 "EHLO cmta12.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754002AbbJGPkr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 7 Oct 2015 11:40:47 -0400
In-Reply-To: <561527D9.3020009@redhat.com>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Prarit Bhargava' <prarit@redhat.com>
Cc: 'Kristen Carlson Accardi' <kristen@linux.intel.com>, linux-kernel@vger.kernel.org, 'Viresh Kumar' <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, Doug Smythies <dsmythies@telus.net>

On 2015.09.07 07:11 Prarit Bhargava wrote:

Hi Prarit,

> I have intel_pstate=no_hwp so that doesn't explain things.  I will send you a
> printk debug patch shortly to figure out why your system doesn't see this
> problem.  I have _6_ different variants of intel processors that see this same
> issue.

Interesting.

>
> What is your model #?

Intel(R) Core(TM) i7-2600K CPU @ 3.40GHz

While probably not relevant, it is the identical processor that the previous
maintainer of the intel_pstate driver had on his main test computer.

As mentioned in my original reply, I am using kernel 4.3-rc4
from kernel.org mainline.
For kernel configuration I steal the Ubuntu kernel config.

O.K. meanwhile your printk debug patch e-mail came:

On 2015.10.07 07:34 Prarit Bhargava wrote:

> Doug, please apply and test.

I never get the "store_min_perf_pct" stuff during startup.

I get:

[    2.662092] Intel P-state driver initializing.
[    2.662110] intel_pstate_set_policy[1001] min_perf_pct = 100
[    2.681792] intel_pstate_set_policy[1001] min_perf_pct = 100
[    2.681825] intel_pstate_set_policy[1001] min_perf_pct = 100
[    2.681834] intel_pstate_set_policy[1001] min_perf_pct = 100
[    2.681935] intel_pstate_set_policy[1001] min_perf_pct = 100
[    2.681959] intel_pstate_set_policy[1001] min_perf_pct = 100
[    2.682004] intel_pstate_set_policy[1001] min_perf_pct = 100
[    2.682024] intel_pstate_set_policy[1001] min_perf_pct = 100

[   80.044329] intel_pstate_set_policy[1020] min_perf_pct = 42
[   80.044331] intel_pstate_set_policy[1023] min_perf_pct = 42
[   80.044331] intel_pstate_set_policy[1028] min_perf_pct = 42
[   80.044343] intel_pstate_set_policy[1020] min_perf_pct = 42
[   80.044344] intel_pstate_set_policy[1023] min_perf_pct = 42
[   80.044345] intel_pstate_set_policy[1028] min_perf_pct = 42
[   80.044354] intel_pstate_set_policy[1020] min_perf_pct = 42
[   80.044355] intel_pstate_set_policy[1023] min_perf_pct = 42
[   80.044355] intel_pstate_set_policy[1028] min_perf_pct = 42
[   80.044364] intel_pstate_set_policy[1020] min_perf_pct = 42
[   80.044365] intel_pstate_set_policy[1023] min_perf_pct = 42
[   80.044366] intel_pstate_set_policy[1028] min_perf_pct = 42
[   80.044375] intel_pstate_set_policy[1020] min_perf_pct = 42
[   80.044376] intel_pstate_set_policy[1023] min_perf_pct = 42
[   80.044376] intel_pstate_set_policy[1028] min_perf_pct = 42
[   80.044385] intel_pstate_set_policy[1020] min_perf_pct = 42
[   80.044386] intel_pstate_set_policy[1023] min_perf_pct = 42
[   80.044387] intel_pstate_set_policy[1028] min_perf_pct = 42
[   80.044396] intel_pstate_set_policy[1020] min_perf_pct = 42
[   80.044397] intel_pstate_set_policy[1023] min_perf_pct = 42
[   80.044397] intel_pstate_set_policy[1028] min_perf_pct = 42
[   80.044406] intel_pstate_set_policy[1020] min_perf_pct = 42
[   80.044407] intel_pstate_set_policy[1023] min_perf_pct = 42
[   80.044408] intel_pstate_set_policy[1028] min_perf_pct = 42

Note that the stuff at 80 seconds is from a startup script
that changes the governor to powersave after a 60 second delay.
It is an Ubuntu default script. (/etc/init.d/ondemand),
but merely does that same thing as this:

for file in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do echo "powersave" > $file; done

I do not know why things are done 3 times.

Now, continuing:

echo 50 > /sys/devices/system/cpu/intel_pstate/min_perf_pct

[ 1411.436249] store_min_perf_pct[453] min_sysfs_pct = 50
[ 1411.436253] store_min_perf_pct[456] min_perf_pct = 50
[ 1411.436255] store_min_perf_pct[459] min_perf_pct = 50
[ 1411.436256] store_min_perf_pct[462] min_perf_pct = 50

cpupower frequency-set -g performance

[ 1425.879832] intel_pstate_set_policy[1001] min_perf_pct = 100
[ 1425.879981] intel_pstate_set_policy[1001] min_perf_pct = 100
[ 1425.880049] intel_pstate_set_policy[1001] min_perf_pct = 100
[ 1425.880178] intel_pstate_set_policy[1001] min_perf_pct = 100
[ 1425.880324] intel_pstate_set_policy[1001] min_perf_pct = 100
[ 1425.880467] intel_pstate_set_policy[1001] min_perf_pct = 100
[ 1425.880534] intel_pstate_set_policy[1001] min_perf_pct = 100
[ 1425.880594] intel_pstate_set_policy[1001] min_perf_pct = 100

cpupower frequency-set -g powersave

[ 1437.677179] intel_pstate_set_policy[1020] min_perf_pct = 50
[ 1437.677181] intel_pstate_set_policy[1023] min_perf_pct = 50
[ 1437.677182] intel_pstate_set_policy[1028] min_perf_pct = 50
[ 1437.677205] intel_pstate_set_policy[1020] min_perf_pct = 50
[ 1437.677206] intel_pstate_set_policy[1023] min_perf_pct = 50
[ 1437.677206] intel_pstate_set_policy[1028] min_perf_pct = 50
[ 1437.677224] intel_pstate_set_policy[1020] min_perf_pct = 50
[ 1437.677225] intel_pstate_set_policy[1023] min_perf_pct = 50
[ 1437.677226] intel_pstate_set_policy[1028] min_perf_pct = 50
[ 1437.677244] intel_pstate_set_policy[1020] min_perf_pct = 50
[ 1437.677245] intel_pstate_set_policy[1023] min_perf_pct = 50
[ 1437.677245] intel_pstate_set_policy[1028] min_perf_pct = 50
[ 1437.677270] intel_pstate_set_policy[1020] min_perf_pct = 50
[ 1437.677271] intel_pstate_set_policy[1023] min_perf_pct = 50
[ 1437.677279] intel_pstate_set_policy[1028] min_perf_pct = 50
[ 1437.677296] intel_pstate_set_policy[1020] min_perf_pct = 50
[ 1437.677297] intel_pstate_set_policy[1023] min_perf_pct = 50
[ 1437.677297] intel_pstate_set_policy[1028] min_perf_pct = 50
[ 1437.677316] intel_pstate_set_policy[1020] min_perf_pct = 50
[ 1437.677317] intel_pstate_set_policy[1023] min_perf_pct = 50
[ 1437.677318] intel_pstate_set_policy[1028] min_perf_pct = 50
[ 1437.677350] intel_pstate_set_policy[1020] min_perf_pct = 50
[ 1437.677351] intel_pstate_set_policy[1023] min_perf_pct = 50
[ 1437.677352] intel_pstate_set_policy[1028] min_perf_pct = 50

Do we agree or disagree that the root issue seems to be (from your test)?:

\#  echo 100 > /sys/devices/system/cpu/intel_pstate/min_perf_pct

[   21.483436] store_min_perf_pct[453] min_sysfs_pct = 100
[   21.489373] store_min_perf_pct[456] min_perf_pct = 100
[   21.495203] store_min_perf_pct[459] min_perf_pct = 100
[   21.501050] store_min_perf_pct[462] min_perf_pct = 100

... Doug


