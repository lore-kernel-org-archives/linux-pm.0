From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 0/3] cpufreq: sa11x0: cleanups for 3.13
Date: Tue, 13 Aug 2013 19:01:04 +0530
Message-ID: <cover.1376392060.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael/Russell,

These patches would be part of this patchset finally, sending it separately as I
didn't wanted to send other patches in that series..

https://lkml.org/lkml/2013/8/10/48

(Above series was rebased over https://lkml.org/lkml/2013/8/8/263 and hence this
patchset too)..

These first exposes frequency table and then uses cpufreq generic routines
(which uses exposed table) instead of its own .verify() routine.

Later I will send another patch that would be part of this series:

http://lkml.org/lkml/2013/8/12/406

(I need to send that series again today and so not sending that patch twice,
once here and then in that series)..

All these patches are pushed here with all dependencies:

https://git.linaro.org/gitweb?p=people/vireshk/linux.git;a=shortlog;h=refs/heads/for-v3.13

Viresh Kumar (3):
  cpufreq: sa11x0: Expose frequency table
  cpufreq: sa11x0: let cpufreq core initialize struct policy fields
  cpufreq: sa11x0: Use generic cpufreq routines

 arch/arm/mach-sa1100/generic.c   | 65 +++++++++++++---------------------------
 arch/arm/mach-sa1100/generic.h   |  2 +-
 drivers/cpufreq/sa1100-cpufreq.c |  9 +++---
 drivers/cpufreq/sa1110-cpufreq.c |  9 +++---
 4 files changed, 30 insertions(+), 55 deletions(-)

-- 
1.7.12.rc2.18.g61b472e

