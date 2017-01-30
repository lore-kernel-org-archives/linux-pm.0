From: Thierry Reding <thierry.reding@gmail.com>
Subject: [RFC 0/3] Add system power and restart framework
Date: Mon, 30 Jan 2017 18:15:03 +0100
Message-ID: <20170130171506.3527-1-thierry.reding@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36792 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751471AbdA3Rmn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Jan 2017 12:42:43 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>, Guenter Roeck <linux@roeck-us.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Hi everyone,

This series of patches proposes a small framework targetted at system
power and restart drivers. Restart drivers currently use a notifier
chain and there was an attempt by Guenter Roeck a while ago to move
power off drivers to similar infrastructure[0]. That attempt had met
with some pushback, with the main criticism being that there was no
formal definition of the priorities of these handlers.

The system power and restart framework tries to solve this by adding
a more explicit framework that power and restart drivers can register
with. This is currently very simple, but it is meant primarily as a
basis for discussion so that we can reach concensus on what we want
such a framework to look like (and if we need one at all).

There was a bit of discussion on this two weeks ago[1], and this set
is an attempt at implementing my proposal from that discussion[2]. A
formal mechanism to implement priorities on top of this could easily
be added (see linked discussion).

One very big advantage of this method is that we have a very easy way
of keeping backwards compatibility with the restart notifier chain and
the pm_power_off() mechanism, which means we can convert drivers one
by one and evolve the framework incrementally without having to have a
flag day where everyone needs to convert.

So the goal of this series is to get some feedback on whether or not the
people involved in earlier discussions around this think this is sound.
If so I've got a couple of patches on top that convert architectures
over to using the new function calls and a couple of drivers that I have
converted as a proof of concept.

Thanks,
Thierry

[0]: https://lkml.org/lkml/2014/11/6/505
[1]: https://lkml.org/lkml/2017/1/12/470
[2]: https://lkml.org/lkml/2017/1/20/89

Thierry Reding (3):
  system-power: Add system power and restart framework
  kernel: Wire up system power framework
  PM / hibernate: Wire up system-power framework

 drivers/base/Makefile        |   3 +-
 drivers/base/system-power.c  | 110 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/system-power.h |  38 +++++++++++++++
 kernel/power/hibernate.c     |   3 +-
 kernel/reboot.c              |  11 +++--
 5 files changed, 158 insertions(+), 7 deletions(-)
 create mode 100644 drivers/base/system-power.c
 create mode 100644 include/linux/system-power.h

-- 
2.11.0

