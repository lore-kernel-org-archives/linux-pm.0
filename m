From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] cpuidle: new driver for Cirrus Logic for 3.16
Date: Wed, 30 Apr 2014 12:24:23 +0200
Message-ID: <5360CF57.9050202@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:48757 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757359AbaD3KYW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Apr 2014 06:24:22 -0400
Received: by mail-wi0-f176.google.com with SMTP id f8so2631293wiw.15
        for <linux-pm@vger.kernel.org>; Wed, 30 Apr 2014 03:24:21 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Alexander Shiyan <shc_work@mail.ru>, Linux PM mailing list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


Hi Rafael,

this pull request is based on top 3.15-rc3

  * Alexander Shiyan added a new driver for the Cirrus Logic clps711x

Thanks
   -- Daniel

The following changes since commit d1db0eea852497762cab43b905b879dfcd3b=
8987:

   Linux 3.15-rc3 (2014-04-27 19:29:27 -0700)

are available in the git repository at:

   git://git.linaro.org/people/daniel.lezcano/linux.git cpuidle/3.16

for you to fetch changes up to 7c7f8f7f2c6bf078874e5de35d7e2c66467fc664=
:

   ARM: clps711x: Add cpuidle driver (2014-04-30 01:33:02 +0200)

----------------------------------------------------------------
Alexander Shiyan (1):
       ARM: clps711x: Add cpuidle driver

  drivers/cpuidle/Kconfig.arm        |    6 ++++
  drivers/cpuidle/Makefile           |    1 +
  drivers/cpuidle/cpuidle-clps711x.c |   64=20
++++++++++++++++++++++++++++++++++++
  3 files changed, 71 insertions(+)
  create mode 100644 drivers/cpuidle/cpuidle-clps711x.c

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

