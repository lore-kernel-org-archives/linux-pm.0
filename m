From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 0/4] PM / core: Introduce some helper for better Code reuse
Date: Sat, 16 Mar 2019 00:59:24 -0400
Message-ID: <20190316045928.31934-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-pm@vger.kernel.org

This patch set introduces some functions and macros that help reduce
code duplication.

Yangtao Li (4):
  PM / core: Introduce dpm_async_fn() helper
  PM / core: Introduce DEVICE_SUSPEND_FUNC() helper macro
  PM / core: Introduce ASYNC_RESUME_FUNC() helper macro
  PM / core: Introduce ASYNC_SUSPEND_FUNC() helper macro

 drivers/base/power/main.c | 182 ++++++++++++--------------------------
 1 file changed, 59 insertions(+), 123 deletions(-)

-- 
2.17.0
