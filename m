From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT-PULL] cpuidle fixes for 3.12
Date: Mon, 12 Aug 2013 11:41:29 +0200
Message-ID: <5208ADC9.2050309@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:37693 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755382Ab3HLJle (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 Aug 2013 05:41:34 -0400
Received: by mail-we0-f174.google.com with SMTP id q54so5330135wes.33
        for <linux-pm@vger.kernel.org>; Mon, 12 Aug 2013 02:41:32 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM mailing list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Jingoo Han <jg1.han@samsung.com>, Rob Herring <rob.herring@calxeda.com>, "jason@lakedaemon.net" <jason@lakedaemon.net>

The following changes since commit d4e4ab86bcba5a72779c43dc1459f71fea3d=
89c8:

Linux 3.11-rc5 (2013-08-11 18:04:20 -0700)

are available in the git repository at:

git://git.linaro.org/people/dlezcano/linux.git cpuidle/arm-next

for you to fetch changes up to 75d6137da195a1e059e1c814cb95635e168f85c0=
:

cpuidle: kirkwood: Make kirkwood_cpuidle_remove function static
(2013-08-12 11:28:50 +0200)

This series fixes some compilation issues:

* for SH, a parameter is missing for the cpuidle_register function
* for Calxeda, an _iomem annotation is missing for scu_base_addr variab=
le
* for kirkwood, a static declaration is missing for the
kirkwood_cpuidle_remove function

Thanks
-- Daniel

----------------------------------------------------------------
Geert Uytterhoeven (1):
SH: cpuidle: Add missing parameter for cpuidle_register()

Jingoo Han (2):
cpuidle: calxeda: Add missing __iomem annotation
cpuidle: kirkwood: Make kirkwood_cpuidle_remove function static

arch/sh/kernel/cpu/shmobile/cpuidle.c | 4 +---
drivers/cpuidle/cpuidle-calxeda.c | 2 +-
drivers/cpuidle/cpuidle-kirkwood.c | 2 +-
3 files changed, 3 insertions(+), 5 deletions(-)

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


