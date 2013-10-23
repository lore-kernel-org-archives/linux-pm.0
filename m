From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: [PATCH 0/2] cpufreq support for the big.LITTLE switcher
Date: Tue, 22 Oct 2013 23:58:09 -0400
Message-ID: <1382500691-634-1-git-send-email-nicolas.pitre@linaro.org>
Content-Transfer-Encoding: 7BIT
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: viresh.kumar@linaro.org, sudeep.karkadanagesha@arm.com, dave.martin@arm.com, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, patches@linaro.org
List-Id: linux-pm@vger.kernel.org

This is the third and final set of patches towards a fully functional
and production quality switcher solution for big.LITTLE systems,
establishing a landmark to compare against for any scheduler based
solution meant to eventually surpass the switcher's power efficiency
available in the mainline kernel.

Rationale for this code: http://lwn.net/Articles/481055/

The first and second patch sets have already been merged by RMK.  They
implement the core switcher mechanism.  This set adds the necessary code
to drive the switcher based on cpufreq governor decisions.


 drivers/cpufreq/arm_big_little.c | 418 ++++++++++++++++++++++++++++++---
 drivers/cpufreq/arm_big_little.h |   5 -
 2 files changed, 389 insertions(+), 34 deletions(-)



