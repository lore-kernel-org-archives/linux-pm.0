From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 0/4] PM / devfreq: Refactor load monitoring
Date: Wed, 13 Feb 2019 17:30:38 -0800
Message-ID: <20190214013042.254790-1-mka@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, Lukasz Luba <l.luba@partner.samsung.com>
Cc: Matthias Kaehlcke <mka@chromium.org>
List-Id: linux-pm@vger.kernel.org

The devfreq core currently expects governors to call specific load
monitor functions on certain DEVFREQ_GOV_ events. Since the devfreq
core itself invokes the event handler it can as well call the
corresponding load monitor functions itself. This series refactors
the code to do this for DEVFREQ_GOV_START/STOP/SUSPEND and RESUME.

In the process it also moves some repeated code involved in starting
and stopping the governor into helper functions.


Unfortunately I could only do limited testing of this series with a 4.19
kernel and few rather inactive devfreq devices. In this sense additional
testing would be appreciated.

Thanks

Matthias


Matthias Kaehlcke (4):
  PM / devfreq: Track overall load monitor state instead of
    'stop_polling'
  PM / devfreq: Handle monitor suspend/resume in the devfreq core
  PM / devfreq: Add devfreq_governor_start/stop()
  PM / devfreq: Handle monitor start/stop in the devfreq core

 drivers/devfreq/devfreq.c                 | 185 +++++++++++++---------
 drivers/devfreq/governor.h                |   4 -
 drivers/devfreq/governor_simpleondemand.c |  16 --
 drivers/devfreq/tegra-devfreq.c           |   4 -
 include/linux/devfreq.h                   |   4 +-
 5 files changed, 111 insertions(+), 102 deletions(-)

-- 
2.20.1.791.gb4d0f1c61a-goog
