From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH 0/6] Make pxa core clocks settable
Date: Mon, 10 Oct 2016 22:09:03 +0200
Message-ID: <1476130149-31834-1-git-send-email-robert.jarzmik@free.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>
List-Id: linux-pm@vger.kernel.org

This serie is two fold:
 - a set of fixes, patches 1 to 4
 - a patch with transfers most of core clock handling from pxa2xx-cpufreq into
   clk-pxa*, ie. patch 5
   This is the main change, and is providing control over CPU clocks for both
   pxa25x and pxa27x through the clock API.

 - a last patch (patch 6), which is not to be taken right away, just reviewed,
   and which simplifies pxa2xx-cpufreq by removing everything clock related.
   This one relies on the former one, but is not necessarily to be taken in the
   same cycle, as the cpufreq will continue to work with the former cpufreq
   driver even if the clock changes are in.

The patches have been tested on lubbock (pxa25x) and mainstone (pxa27x) boards,
with a cpu-burn and different scaling max frequencies.

Happy review.

--
Robert

Robert Jarzmik (6):
  clk: pxa: remove unused variables
  clk: pxa: core pll is not affected by t bit
  clk: pxa: b bit of clkcfg means fast bus
  clk: pxa: export core clocks
  clk: pxa: transfer CPU clock setting from pxa2xx-cpufreq
  cpufreq: pxa: convert to clock API

 drivers/clk/pxa/clk-pxa.c        | 128 ++++++++++++++++++++++++++
 drivers/clk/pxa/clk-pxa.h        |  56 +++++++++++-
 drivers/clk/pxa/clk-pxa25x.c     | 107 +++++++++++++++++++---
 drivers/clk/pxa/clk-pxa27x.c     | 168 +++++++++++++++++++++++++++-------
 drivers/cpufreq/pxa2xx-cpufreq.c | 191 ++++++++-------------------------------
 5 files changed, 453 insertions(+), 197 deletions(-)

-- 
2.1.4
