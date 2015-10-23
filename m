From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PULL] cpuidle for 4.4
Date: Fri, 23 Oct 2015 13:54:08 +0200
Message-ID: <562A1FE0.1060302@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:38464 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbbJWLyL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 23 Oct 2015 07:54:11 -0400
Received: by wicll6 with SMTP id ll6so28035041wic.1
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2015 04:54:10 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM mailing list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


Hi Rafael,

this pull request contains a couple of changes from Russel King.

  - Disable bind/unbind attribute and use builtin_platform_driver for=20
mvebu (Russell King)

  - Clean up the code by removing the multiple platform drivers and use=
=20
the platform ID instead (Russell King)

Thanks !

   -- Daniel

The following changes since commit 7379047d5585187d1288486d4627873170d0=
005a:

   Linux 4.3-rc6 (2015-10-18 16:08:42 -0700)

are available in the git repository at:

   http://git.linaro.org/people/daniel.lezcano/linux.git cpuidle/4.4

for you to fetch changes up to ab319939a58678c19a68ff10c8a08cef462a3ba6=
:

   cpuidle: mvebu: disable the bind/unbind attributes and use=20
builtin_platform_driver (2015-10-23 12:40:48 +0200)

----------------------------------------------------------------
Russell King (2):
       cpuidle: mvebu: clean up multiple platform drivers
       cpuidle: mvebu: disable the bind/unbind attributes and use=20
builtin_platform_driver

  drivers/cpuidle/cpuidle-mvebu-v7.c | 46=20
+++++++++++++++++++++-------------------------
  1 file changed, 21 insertions(+), 25 deletions(-)


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

