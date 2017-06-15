From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fixes for v4.12-rc6
Date: Thu, 15 Jun 2017 02:34:24 +0200
Message-ID: <CAJZ5v0haQpA=eTX8P=s29jWD8nVafHX7dzzCAD+xYpiqYRUc4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:36292 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751555AbdFOAeZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Jun 2017 20:34:25 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.12-rc6

with top-most commit f63e4f7d4179c9157c51bbe82af7c8f6b5fb39dd

 Merge branches 'pm-cpufreq', 'pm-cpuidle' and 'pm-devfreq'

on top of commit 32c1431eea4881a6b17bd7c639315010aeefa452

 Linux 4.12-rc5

to receive power management fixes for v4.12-rc6.

These revert a recent cpufreq schedutil governor change that turned
out to be problematic and fix a few minor issues in cpufreq, cpuidle
and the Exynos devfreq drivers.

Specifics:

 - Revert a recent cpufreq schedutil governor change that caused some
   systems to behave undesirably (Rafael Wysocki).

 - Fix a cpufreq conservative governor issue introduced during the
   3.10 cycle that prevents it from working as expected in some
   situations (Tomasz Wilczy=C5=84ski).

 - Fix an error code path in the generic cpuidle driver for DT-based
   systems (Christophe Jaillet).

 - Fix 3 minor issues in devfreq drivers for Exynos (Arvind Yadav,
   Krzysztof Kozlowski).

Thanks!


---------------

Arvind Yadav (2):
      PM / devfreq: exynos-nocp: Handle return value of clk_prepare_enable
      PM / devfreq: exynos-ppmu: Handle return value of clk_prepare_enable

Christophe Jaillet (1):
      cpuidle: dt: Add missing 'of_node_put()'

Krzysztof Kozlowski (1):
      PM / devfreq: exynos-ppmu: Staticize event list

Rafael J. Wysocki (1):
      Revert "cpufreq: schedutil: Reduce frequencies slower"

Tomasz Wilczy=C5=84ski (1):
      cpufreq: conservative: Allow down_threshold to take values from 1 to =
10

---------------

 drivers/cpufreq/cpufreq_conservative.c | 4 ++--
 drivers/cpuidle/dt_idle_states.c       | 4 +++-
 drivers/devfreq/event/exynos-nocp.c    | 6 +++++-
 drivers/devfreq/event/exynos-ppmu.c    | 8 ++++++--
 kernel/sched/cpufreq_schedutil.c       | 3 ---
 5 files changed, 16 insertions(+), 9 deletions(-)
