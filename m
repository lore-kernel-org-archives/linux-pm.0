From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 0/2] PM / OPP: Fixes for 4.3
Date: Wed, 12 Aug 2015 16:30:17 +0530
Message-ID: <cover.1439376998.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35364 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933290AbbHLLAj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Aug 2015 07:00:39 -0400
Received: by pacgr6 with SMTP id gr6so12380794pac.2
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2015 04:00:39 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, dan.carpenter@oracle.com, nm@ti.com, sboyd@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

Hi Rafael,

Dan's static checker reported few issues on the latest opp merges. And
this fixes them.

The first patch here was part of the bigger 'debugfs support for opp'
series earlier, but now separated as 4.3 material.

Rebased over: pm/bleeding-edge

Viresh Kumar (2):
  PM / OPP: Free resources and properly return error on failure
  PM / OPP: Fix static checker warning (broken 64bit big endian systems)

 drivers/base/power/opp.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

-- 
2.4.0

