From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] cpuidle: A few improvements for ARM cpuidle via DT
Date: Wed, 19 Nov 2014 11:16:11 +0100
Message-ID: <546C6DEB.8060204@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:51086 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753776AbaKSKQP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Nov 2014 05:16:15 -0500
Received: by mail-wi0-f181.google.com with SMTP id r20so1256891wiv.14
        for <linux-pm@vger.kernel.org>; Wed, 19 Nov 2014 02:16:14 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm >> Linux PM mailing list" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


Hi Rafael,

this pull request, based on 3.18-rc5, contains a set of changes from=20
Lorenzo Pieralisi.

  * Added a 'status' definition flag in the DT to specify the=20
unsupported firmware idle states and ignore those states in the parsing=
=20
code when initializing the cpuidle driver

  * Added an idle state description in the DT. As the idle states are=20
not standardized on ARM, the description gives information about the=20
idle state

  * Removed duplicate error message in the arm64 cpuidle drivers

Thanks !

   -- Daniel


The following changes since commit fc14f9c1272f62c3e8d01300f52467c0d9af=
50f9:

   Linux 3.18-rc5 (2014-11-16 16:36:20 -0800)

are available in the git repository at:

   http://git.linaro.org/git-ro/people/daniel.lezcano/linux.git cpuidle=
/3.19

for you to fetch changes up to 18f95a3640dbf421ab9532e517070a0c1cd4d582=
:

   drivers: cpuidle: Remove cpuidle-arm64 duplicate error messages=20
(2014-11-19 10:16:28 +0100)

----------------------------------------------------------------
Lorenzo Pieralisi (3):
       drivers: cpuidle: Add status property to ARM idle states
       drivers: cpuidle: Add idle-state-name description to ARM idle st=
ates
       drivers: cpuidle: Remove cpuidle-arm64 duplicate error messages

  Documentation/devicetree/bindings/arm/idle-states.txt | 20=20
++++++++++++++++++++
  drivers/cpuidle/cpuidle-arm64.c                       | 13 ++--------=
---
  drivers/cpuidle/dt_idle_states.c                      | 10 +++++++++-
  3 files changed, 31 insertions(+), 12 deletions(-)

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

