From: Mike Turquette <mturquette@linaro.org>
Subject: [PATCH 0/2] allow cpufreq drivers to export flags
Date: Wed,  8 Oct 2014 00:48:52 -0700
Message-ID: <1412754534-14068-1-git-send-email-mturquette@linaro.org>
References: <CAKohpo=7q9bDcHRxLehNLX6A2idGxUy3jEWvQ+EGbKOQG-MH2g@mail.gmail.com>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAKohpo=7q9bDcHRxLehNLX6A2idGxUy3jEWvQ+EGbKOQG-MH2g@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: viresh.kumar@linaro.org
Cc: thomas.petazzoni@free-electrons.com, rjw@rjwysocki.net, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, shawn.guo@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, spk.linux@gmail.com, pramod.gurav@smartplayin.com, rob.herring@linaro.org, ezequiel.garcia@free-electrons.com, tawfik@marvell.com, nadavh@marvell.com, alior@marvell.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, nicolas.pitre@linaro.org, linux-kernel@vger.kernel.org, tuukka.tikkanen@linaro.org, Mike Turquette <mturquette@linaro.org>
List-Id: linux-pm@vger.kernel.org

This series is partially in response to a discussion around DT bindings
for CPUfreq drivers [0], but it is also needed for on-going work to
integrate CPUfreq with the scheduler. In particular a scheduler-driven
cpu frequency scaling policy would be well served to know if the
underlying CPUfreq driver .target callback might sleep or block for a
long time.

[0] http://lkml.kernel.org/r/<fcb88cd21f31a467d2d49911c2505082837f72ea.1410323179.git.viresh.kumar@linaro.org>

Mike Turquette (2):
  cpufreq: add driver flag for sleepable transitions
  cpufreq: new function to query driver for flags

 drivers/cpufreq/cpufreq.c |  9 +++++++++
 include/linux/cpufreq.h   | 13 +++++++++++++
 2 files changed, 22 insertions(+)

-- 
1.8.3.2
