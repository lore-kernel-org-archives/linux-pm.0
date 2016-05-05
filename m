From: Steve Muckle <steve.muckle@linaro.org>
Subject: cpufreq governors broken with !CONFIG_SMP?
Date: Thu, 5 May 2016 16:49:22 -0700
Message-ID: <20160505234922.GA14673@sky.smuckle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

While working on a few patches for schedutil I noticed that the CFS
cpufreq hooks depend on PELT, which depends on CONFIG_SMP.

I compiled and ran a UP kernel with intel_pstate. Running a cpu-bound
task did not result in the frequency increasing beyond fmin. For some reason
ondemand is working for me with the same test, not sure why yet.

It appears dbs/intel-pstate/schedutil have a dependency on CONFIG_SMP
now. Or am I missing something?
