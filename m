From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v6 0/3] PM / devfreq: misc changes (spinned out from throttler series)
Date: Fri,  3 Aug 2018 13:05:08 -0700
Message-ID: <20180803200511.189664-1-mka@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Matthias Kaehlcke <mka@chromium.org>
List-Id: linux-pm@vger.kernel.org

This series includes miscellaneous changes that were originally part
of the throttler patch series (https://lore.kernel.org/patchwork/project/lkml/list/?series=357937).
They have been spinned out to facilitate merging them independently
from the throttler changes.

The series is based on
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next

Matthias Kaehlcke (3):
  PM / devfreq: Fix handling of min/max_freq == 0
  PM / devfreq: Don't adjust to user limits in governors
  PM / devfreq: Make update_devfreq() public

 drivers/devfreq/devfreq.c                 | 42 ++++++++++++++++-------
 drivers/devfreq/governor.h                |  6 ++--
 drivers/devfreq/governor_performance.c    |  5 +--
 drivers/devfreq/governor_powersave.c      |  2 +-
 drivers/devfreq/governor_simpleondemand.c | 12 ++-----
 drivers/devfreq/governor_userspace.c      | 16 +++------
 include/linux/devfreq.h                   |  8 +++++
 7 files changed, 50 insertions(+), 41 deletions(-)

-- 
2.18.0.597.ga71716f1ad-goog
