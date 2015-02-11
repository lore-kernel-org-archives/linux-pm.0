From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 0/7] OPP: Introduce OPP bindings V2 and supporting code
Date: Wed, 11 Feb 2015 16:16:23 +0800
Message-ID: <cover.1423642246.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:42780 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940AbbBKIQw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Feb 2015 03:16:52 -0500
Received: by pdbfp1 with SMTP id fp1so2870944pdb.9
        for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2015 00:16:52 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, grant.likely@linaro.org, olof@lixom.net, nm@ti.com, Sudeep.Holla@arm.com, sboyd@codeaurora.org, devicetree@vger.kernel.org, santosh.shilimkar@oracle.com, mike.turquette@linaro.org, kesavan.abhilash@gmail.com, catalin.marinas@arm.com, ta.omasab@gmail.com, linux-arm-kernel@lists.infradead.org, thomas.petazzoni@free-electrons.com, l.stach@pengutronix.de, broonie@kernel.org, viswanath.puttagunta@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>

Now that I have received an verbal Ack from Rob Herring (in a personal
conversation) about the bindings, I am showing how the code looks like with
these new bindings.

Some part is still now done:
- Interface for adding new detailed OPPs from platform code instead of DT
- Providing cpufreq helpers for the next OPPs
- Providing regulator helpers for the target/min/max ranges

Please provide feedback on how this looks like..

--
viresh

Viresh Kumar (7):
  OPP: Redefine bindings to overcome shortcomings
  opp: Relocate few routines
  OPP: Break _opp_add_dynamic() into smaller functions
  opp: Parse new (v2) bindings
  opp: convert device_opp->dev to a list of devices
  opp: Add helpers for initializing CPU opps
  cpufreq-dt: Use DT to set policy->cpus/related_cpus

 Documentation/devicetree/bindings/power/opp.txt |  407 ++++++++-
 drivers/base/power/opp.c                        | 1041 +++++++++++++++++------
 drivers/cpufreq/cpufreq-dt.c                    |   16 +-
 include/linux/pm_opp.h                          |   23 +
 4 files changed, 1232 insertions(+), 255 deletions(-)

-- 
2.3.0.rc0.44.ga94655d

