From: Rajagopal Venkat <rajagopal.venkat@linaro.org>
Subject: [PATCH 0/2] Add devfreq runtime pm support
Date: Thu, 21 Mar 2013 18:58:24 +0530
Message-ID: <1363872506-3630-1-git-send-email-rajagopal.venkat@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, rjw@sisk.pl, Kevin Hilman <khilman@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Rajagopal Venkat <rajagopal.venkat@linaro.org>
List-Id: linux-pm@vger.kernel.org

Patch to bind devfreq to runtime pm framework. The device
devfreq is  automatically suspended with pm_runtime_suspend()
and resumed with pm_runtime_resume().

Discussed at http://comments.gmane.org/gmane.linux.linaro.devel/13787

Rajagopal Venkat (2):
  PM / devfreq: Fix compiler warnings
  PM / devfreq: tie suspend/resume to runtime-pm

 drivers/base/power/runtime.c |   18 ++++++++++++++-
 drivers/devfreq/devfreq.c    |   51 ++++++++++++++++++++++++++++++++++++++----
 include/linux/devfreq.h      |   30 +++++++++----------------
 include/linux/pm.h           |    2 ++
 4 files changed, 76 insertions(+), 25 deletions(-)

-- 
1.7.10.4
