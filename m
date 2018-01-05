From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [GIT PULL] OPP updates for 4.16-rc1
Date: Fri, 5 Jan 2018 16:40:39 +0530
Message-ID: <20180105111038.GG19742@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pl0-f43.google.com ([209.85.160.43]:45701 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751398AbeAELKm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jan 2018 06:10:42 -0500
Received: by mail-pl0-f43.google.com with SMTP id o2so2858270plk.12
        for <linux-pm@vger.kernel.org>; Fri, 05 Jan 2018 03:10:42 -0800 (PST)
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, ulf.hansson@linaro.org, robh@kernel.org, sboyd@codeaurora.org

Hi Rafael,

Please pull the OPP and power domain DT bindings changes for 4.16-rc1.

These allow the OPP tables to be used for Generic power domains as
well and introduces a new "required-opp" property.

-- 
viresh

-------------------------8<-------------------------

The following changes since commit 1291a0d5049dbc06baaaf66a9ff3f53db493b19b:

  Linux 4.15-rc4 (2017-12-17 18:59:59 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/ opp/linux-next

for you to fetch changes up to e856f078bcf120e1627c750014d2612974ed81a2:

  OPP: Introduce "required-opp" property (2017-12-22 10:46:18 +0530)

----------------------------------------------------------------
Viresh Kumar (2):
      OPP: Allow OPP table to be used for power-domains
      OPP: Introduce "required-opp" property

 Documentation/devicetree/bindings/opp/opp.txt      | 13 +++++
 .../devicetree/bindings/power/power_domain.txt     | 65 ++++++++++++++++++++++
 2 files changed, 78 insertions(+)
