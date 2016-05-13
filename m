From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/5] cpufreq: governor: Rework API to use callbacks instead of events
Date: Sat, 14 May 2016 00:58:37 +0200
Message-ID: <10707470.yIcqGAzuFY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

This series is on top of the current linux-next witn the following two patches
applied:

https://patchwork.kernel.org/patch/9080801/
https://patchwork.kernel.org/patch/9080791/

It cleans up a few things and then reworks the governor API to get rid of
governor events and use callbacks representing individual governor operations
(init, exit, start, stop, limits update) instead.

I'm regarding it as v4.8 material, but I'd like to put it into linux-next as
soon as 4.7-rc1 is out so subsequent cpufreq development happens on top of it.

It has been lightly tested without any problems showing up so far.

Thanks,
Rafael
