From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v6 0/7] cpufreq: schedutil governor
Date: Tue, 22 Mar 2016 02:44:08 +0100
Message-ID: <7262976.zPkLj56ATU@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

Yet another iteration of the schedutil governor patchset.

It essentially is a resend of the series, but since patches [6-7/7] have been
updated since the v4 (http://marc.info/?l=linux-kernel&m=145814047719883&w=4),
the complete series goes again here.

The patches are based on the current Linus' tree and they have been present
in my pm-cpufreq-experimental branch for a few days.

Also, Srinivas ran SpecPower on one of the previous iterations and the
results are very promising.  With CPU loads below 80% the system using the
new governor achieves the same performance and consumes much less energy at the
same time (up to around 30% less which translates to around 100 W of power
in this particular test setup).

Again, the question here is whether or not anyone has anything against
queuing this series up for 4.7 early in the cycle (preferably right after
the closing of the 4.6 merge window) in order to provide a convenient base
for further development.

Of course, ACKs are welcome in case of no objections. :-)

Thanks,
Rafael
