From: Tushar Behera <tushar.behera@linaro.org>
Subject: [PATCH 0/2] Add reg_ignore_unused and pd_ignore_unused
Date: Fri, 28 Mar 2014 10:50:20 +0530
Message-ID: <1395984022-8284-1-git-send-email-tushar.behera@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:56485 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816AbaC1FUh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Mar 2014 01:20:37 -0400
Received: by mail-pa0-f43.google.com with SMTP id bj1so4495047pad.30
        for <linux-pm@vger.kernel.org>; Thu, 27 Mar 2014 22:20:37 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: rob@landley.net, olof@lixom.net, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Mark Brown <broonie@kernel.org>

These patches take inspiration from Olof's following patch.
1e435256d625 "clk: add clk_ignore_unused option to keep boot clocks on"

This options are solely for debug purposes to figure out whether
the issue at hand is because of improper shutdown of regulators or
power-domains.

Tushar Behera (2):
  PM / Domains: Add pd_ignore_unused to keep power domains enabled
  regulator: core: Add reg_ignore_unused to keep boot time regulators
    enabled

 Documentation/kernel-parameters.txt |   15 +++++++++++++++
 drivers/base/power/domain.c         |   13 +++++++++++++
 drivers/regulator/core.c            |   13 +++++++++++++
 3 files changed, 41 insertions(+)

CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: linux-pm@vger.kernel.org
CC: Mark Brown <broonie@kernel.org>

-- 
1.7.9.5

