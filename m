From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: regression caused by bb6ab52f2bef ("intel_pstate: Do not set utilization update hook too early")
Date: Sat, 25 Jun 2016 17:27:42 -0700
Message-ID: <000201d1cf41$8e4e6020$aaeb2060$@net>
References: <20160617163023.5bb374f8@xhacker> <393b63b7caa7474a97baf248c4891b72@SC-EXCH02.marvell.com> <24e20dd7b2b047a19515ff52ad105c37@SC-EXCH02.marvell.com> <2958182.eDEME9b2CX@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta7.telus.net ([209.171.16.80]:47650 "EHLO cmta7.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751501AbcFZA1q (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 25 Jun 2016 20:27:46 -0400
In-Reply-To: <2958182.eDEME9b2CX@vostro.rjw.lan>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Jisheng Zhang' <jszhang@marvell.com>, 'Srinivas Pandruvada' <srinivas.pandruvada@intel.com>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>, linux-pm@vger.kernel.org, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'Viresh Kumar' <viresh.kumar@linaro.org>

On 2016.06.24 16:09 Rafael J. Wysocki wrote:
> On Friday, June 17, 2016 04:09:33 PM Jisheng Zhang wrote:
>> Dear all,
>> 
>> If using acpi-cpufreq instead, v4.6, v4.6-rc3, v4.7-rc3 can't reproduce the issue. It seems
>> only intel_pstate is impacted.
>
> Which is quite obvious, since the commit your bisection led to was
> intel_pstate-specific. :-)
>
> If the issue is what I'm thinking it is, the patch below should help, so
> can you please test it?

Rafael, while you asked Jisheng to test, I tested it also, since I was
already setup for testing this stuff. Summary: works great, see further below
for details.

On 2016.06.25 08:10 Srinivas Pandruvada wrote:
> We should also check why the set_policy callback is getting called
> quite often. May be some thermal zone is tripping quite often.
>
> echo 'file thermal_core.c +p' > /sys/kernel/debug/dynamic_debug/control
>
> may give us some clue.

Srinivas, This part has me baffled, particularly with the new test data
(see further below). Note that my test sever never suffers from thermal events,
It can run flat out on all CPU's forever.

Details (some old test data repeated so as to provide context with the new data):

Powertop Wakeups/Second as a function of sample time:
Sample time	Kernel 4.7-rc4	+rjw patch
(seconds)	Wakeups/second	Wakeups/second
300			~20			~14
200			~20			~15
100			~22			~16
 50			~29			~14
 30			~33			~15
 20			~44			~15
  5						~17 (noisy)
  3			~155			~20 (noisy)

Manual timer stats method:
Kernel 4.7-rc4: ~20 Events/Second
Kernel 4.7-rc4+rjw patch: ~20 Events / Second
Kernel 4.4.0-24 (Ubuntu version numbering method): ~20 Events / Second

Note (to self): Do the timer stats method over a long period (say 300 seconds)
so as to reduce the localized influence from running the script itself.

Skipped samples in the intel_pstate driver while running powertop at 5 second sample time:
Kernel 4.7-rc4: ~200 / minute, or ~3.3 per second.
Kernel 4.7-rc4+rjw patch: 0.
Kernel 4.4.0-24: 0.
Other tests were done with Kernel 4.7-rc4 such as compile the kernel and a bunch of Phoronix tests,
and some skipped samples were observed (8 over a 3 hour trace session), but nothing like when running powertop.

Check for messing with the minimum frequency while running powertop at 5 second sample time:
Command: watch -n 0.3 -g cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_min_freq
Kernel 4.7-rc4: Never takes more than a few second to get a hit.
Kernel 4.7-rc4+rjw patch: Ran for over 2 hours without a hit.
Kernel 4.4.0-24: Can not recall how long I ran the test for. No hit.
Srinivas, this is what has me baffled. If it wasn't powertop itself messing
with the minimum CPU clock frequency and setting it to maximum, then what was it?

On an otherwise "idle" system,
how many times does the intel-pstate driver run per unit time?
Kernel 4.7-rc4: (14341 + 0 skipped) times / 1000 seconds.
Kernel 4.7-rc4 + powertop --time=5: (38148 + 3075 skipped) times / 1000 seconds.
Kernel 4.7-rc4+rjw: (11947 + 0 skipped) times / 1000 seconds.
Kernel 4.7-rc4+rjw + powertop --time=5: (22657 + 0 skipped) times / 1000 seconds.
Kernel 4.4.0-24: (5725 + 0 skipped) times / 1000 seconds.
Kernel 4.4.0-24 + powertop --time=5: (16656 + 0 skipped) times / 1000 seconds.

Important note: It is a good thing that the number of driver passes per unit time increased
with the recent changes. The driver was not running often enough before,
often hitting the watchdog limits. Isn't it energy and performance that
matters (see next test)?

Energy consumption on an otherwise "idle" system (package power):
Kernel 4.7-rc4: 3.84 Watts
Kernel 4.7-rc4 + powertop --time=5: sometimes 4.92 watts, sometimes 6.2 watts (not sure why)
Kernel 4.7-rc4+rjw: 3.88 Watts
Kernel 4.7-rc4+rjw + powertop --time=5: 4.5 watts (did observe a 6.3 watts one)
Kernel 4.4.0-24: 3.92 Watts.
Kernel 4.4.0-24 + powertop --time=5: did not test.
While there are variations in the results, the 2 to 3% savings in idle energy seems
somewhat consistent (referring to between Kernel 4.4 and 4.7-rc4+rjw patch, without powertop).

... Doug


