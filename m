From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL] Thermal Management updates for 3.19-rc5 #2
Date: Thu, 15 Jan 2015 11:17:31 +0800
Message-ID: <1421291851.6923.21.camel@rzhang1-toshiba>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:9194 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751119AbbAODRf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 14 Jan 2015 22:17:35 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, "Zhang, Rui" <rui.zhang@intel.com>

Hi, Linus,

Please pull from
  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git
thermal-soc

to receive Thermal SoC Management updates for v3.19-rc5 with top-most
commit a4378cc66d9c772dc37d32d434b14c7545e6fc21:

  Merge branch 'fixes' of
git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal
into thermal-soc (2015-01-14 15:49:19 +0800)

on top of commit 693a30b8f19a964087a3762d09fb2e1cbad6b0d4:

  Merge branch 'for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml (2015-01-04
11:46:43 -0800)

Specifics:

- bogus type qualifier fix in OF thermal code.
- Minor fixes on imx and rcar thermal drivers.
- Update TI SoC thermal maintainer entry.
- Updated documentation of OF cpufreq cooling register.

thanks,
rui

----------------------------------------------------------------
Anson Huang (1):
      Thermal: imx: add clk disable/enable for suspend/resume

Eduardo Valentin (1):
      MAINTAINERS: update ti-soc-thermal status

Geert Uytterhoeven (2):
      thermal: of: Remove bogus type qualifier for
of_thermal_get_trip_points()
      thermal: rcar: Spelling/grammar: s/drier use .../driver uses ...s/

Javi Merino (1):
      Documentation: thermal: document of_cpufreq_cooling_register()

Nishanth Menon (1):
      MAINTAINERS: Add linux-omap to list of reviewers for TI Thermal

Yoshihiro Shimoda (2):
      thermal: rcar: fix ENR register value
      thermal: rcar: change type of ctemp in rcar_thermal_update_temp()

 Documentation/thermal/cpu-cooling-api.txt | 15 +++++++++++++--
 MAINTAINERS                               |  3 ++-
 drivers/thermal/imx_thermal.c             |  2 ++
 drivers/thermal/of-thermal.c              |  2 +-
 drivers/thermal/rcar_thermal.c            | 17 +++++++++++------
 drivers/thermal/thermal_core.h            |  4 ++--
 6 files changed, 31 insertions(+), 12 deletions(-)

