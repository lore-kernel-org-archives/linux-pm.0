From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] : cpuidle-big.little fix when mcpm is not available
Date: Sun, 25 Jan 2015 15:39:40 +0100
Message-ID: <54C5002C.4050600@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:64681 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753412AbbAYOjp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 25 Jan 2015 09:39:45 -0500
Received: by mail-wi0-f172.google.com with SMTP id h11so5391726wiw.5
        for <linux-pm@vger.kernel.org>; Sun, 25 Jan 2015 06:39:43 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <Sudeep.Holla@arm.com>, lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Linux PM mailing list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Rafael,

This pull request has a single patch which is a fix for the=20
cpuidle-big.little driver. If the mcpm backend is not available because=
=20
the CCI is not defined in the DT, the cpuidle driver will=20
unconditionally assume it is and call the mcpm functions leading to a=20
kernel WARNING.

Sudeep Holla fixed that by checking at the init time the mcpm is=20
available before initializing the deeper idle states.

Thanks
   -- Daniel

The following changes since commit ec6f34e5b552fb0a52e6aae1a5afbbb1605c=
c6cc:

   Linux 3.19-rc5 (2015-01-18 18:02:20 +1200)

are available in the git repository at:

   http://git.linaro.org/people/daniel.lezcano/linux.git cpuidle/3.20

for you to fetch changes up to 194fe6f28e2819d3f50fbed24c3b72f21501dbfa=
:

   drivers: cpuidle: Don't initialize big.LITTLE driver if MCPM is=20
unavailable (2015-01-23 15:05:48 +0100)

----------------------------------------------------------------
Sudeep Holla (1):
       drivers: cpuidle: Don't initialize big.LITTLE driver if MCPM is=20
unavailable

  drivers/cpuidle/cpuidle-big_little.c | 4 ++++
  1 file changed, 4 insertions(+)

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

