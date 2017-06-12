From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] ARM: cpuidle for 4.13
Date: Mon, 12 Jun 2017 17:54:41 +0200
Message-ID: <20170612155441.GE2261@mai>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f172.google.com ([209.85.128.172]:34083 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754219AbdFLPyp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2017 11:54:45 -0400
Received: by mail-wr0-f172.google.com with SMTP id g76so100760856wrd.1
        for <linux-pm@vger.kernel.org>; Mon, 12 Jun 2017 08:54:45 -0700 (PDT)
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org

Hi Rafael,

this is a pull request for a fix already and the asymmetric idle state support
for HMP systems. It is based on V4.12-rc5.

 - Make per cpuidle driver for the ARM cpuidle driver in order to support SMP,
   HMP and future DynamIQ cpus (Daniel Lezcano)

 - Release of node on error (Christophe Jaillet)

Thanks

  -- Daniel

The following changes since commit 32c1431eea4881a6b17bd7c639315010aeefa452:

  Linux 4.12-rc5 (2017-06-11 16:48:20 -0700)

are available in the git repository at:

  http://git@git.linaro.org/people/daniel.lezcano/linux.git cpuidle/4.13

for you to fetch changes up to 610c28be6046786ccec22c827481fd865d4db8e0:

  ARM: cpuidle: Support asymmetric idle definition (2017-06-12 14:57:21 +0200)

----------------------------------------------------------------
Christophe Jaillet (1):
      cpuidle: dt: Add missing 'of_node_put()'

Daniel Lezcano (1):
      ARM: cpuidle: Support asymmetric idle definition

 drivers/cpuidle/Kconfig.arm      |  1 +
 drivers/cpuidle/cpuidle-arm.c    | 62 ++++++++++++++++++++++++++++++++++++++------------------------
 drivers/cpuidle/dt_idle_states.c |  4 +++-
 3 files changed, 42 insertions(+), 25 deletions(-)



-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
