From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 0/2] PM-runtime: fix and clean up of time accounting
Date: Mon,  4 Feb 2019 17:25:51 +0100
Message-ID: <1549297553-17647-1-git-send-email-vincent.guittot@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, ulf.hansson@linaro.org, biju.das@bp.renesas.com
Cc: linux-arm-kernel@lists.infradead.org, geert@linux-m68k.org, thara.gopinath@linaro.org, linux-renesas-soc@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

Fix time accounting which has the same lock contraint as for using hrtimer
and update accounting_timestamp only when useful.

Vincent Guittot (2):
  PM-runtime: move runtime accounting on ktime_get_mono_fast_ns()
  PM-runtime: update time accounting only when enabled

 drivers/base/power/runtime.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

-- 
2.7.4
