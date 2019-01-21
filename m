From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v1 0/2] thermal: trivial fixes to error messages
Date: Mon, 21 Jan 2019 15:12:21 +0530
Message-ID: <cover.1548063429.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, edubezval@gmail.com, swboyd@chromium.org, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Javi Merino <javi.merino@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Zhang Rui <rui.zhang@intel.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Fix up a couple of error messages

Amit Kucheria (2):
  thermal: of-thermal: Print name of device node with error
  thermal: cpu_cooling: Clarify error message

 drivers/thermal/cpu_cooling.c | 2 +-
 drivers/thermal/of-thermal.c  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.17.1
