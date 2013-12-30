From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] ARM : cpuidle: 3.13 fix
Date: Mon, 30 Dec 2013 12:00:56 +0100
Message-ID: <52C15268.4050403@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:58620 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754210Ab3L3LA7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Dec 2013 06:00:59 -0500
Received: by mail-wi0-f179.google.com with SMTP id z2so11451854wiv.12
        for <linux-pm@vger.kernel.org>; Mon, 30 Dec 2013 03:00:58 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andre Przywara <andre.przywara@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM mailing list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Rafael,

this pull request provides a single fix for the calxeda cpuidle driver.=
=20
It is based on v3.13-rc6.

* Andre Przywara fixed a compilation warning due to the driver probe=20
function prototype mismatch for the calxeda cpuidle driver

Thanks
   -- Daniel

The following changes since commit 802eee95bde72fd0cd0f3a5b2098375a487d=
1eda:

   Linux 3.13-rc6 (2013-12-29 16:01:33 -0800)

are available in the git repository at:

   git://git.linaro.org/people/daniel.lezcano/linux.git cpuidle/3.13-fi=
xes

for you to fetch changes up to 5781532ebecd9e0b7b5fc25d78030bdec635f4ac=
:

   ARM/cpuidle: remove __init tag from Calxeda cpuidle probe function=20
(2013-12-30 11:55:20 +0100)

----------------------------------------------------------------
Andre Przywara (1):
       ARM/cpuidle: remove __init tag from Calxeda cpuidle probe functi=
on

  drivers/cpuidle/cpuidle-calxeda.c |    2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

