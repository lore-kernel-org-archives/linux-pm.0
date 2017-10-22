From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH V3 0/4] thermal/drivers/hisi: Add hi3660 thermal driver support
Date: Sun, 22 Oct 2017 10:54:31 +0200
Message-ID: <1508662475-6763-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:57053 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751255AbdJVI4n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Oct 2017 04:56:43 -0400
Received: by mail-wm0-f68.google.com with SMTP id l68so4579433wmd.5
        for <linux-pm@vger.kernel.org>; Sun, 22 Oct 2017 01:56:42 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com
Cc: daniel.lezcano@linaro.org, rui.zhang@intel.com, kevin.wangtao@linaro.org, leo.yan@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

This series adds the support for the hikey960 thermal driver. The tsensor
is almost the same than the hi6220 but with a memory shared updated by a
Cortex-M4.

In order to handle both, the hi6220 and the hi3660, the current code should
be prefixed with the platform name as we will add functions with the same
purpose but slightly different. In addition, the core driver code is
maintained untouched by using a set of ops filled at boot time.

Changelog:

 - V3 :
	- Fixed sparse warning about void const * mismatch assignment

 - V2 : 
        - Fixed extra carriage return, description length reported
          by checkpatch
        - Removed the multi-threshold interrupt
        - Removed DT bindings documentation and DT change as it is
          merge in the arm-soc tree now
        - Tested on hi6220

 - V1 : initial post

Kevin Wangtao (4):
  thermal/drivers/hisi: Put platform code together
  thermal/drivers/hisi: Add platform prefix to function name
  thermal/drivers/hisi: Prepare to add support for other hisi platforms
  thermal/drivers/hisi: Add support for hi3660 SoC

 drivers/thermal/hisi_thermal.c | 452 +++++++++++++++++++++++++++++------------
 1 file changed, 319 insertions(+), 133 deletions(-)

-- 
2.7.4
