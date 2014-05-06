From: Javi Merino <javi.merino@arm.com>
Subject: [RFC PATCH 0/5] The power allocator thermal governor
Date: Tue,  6 May 2014 13:06:33 +0100
Message-ID: <1399377998-14870-1-git-send-email-javi.merino@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:32972 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757398AbaEFMHF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 May 2014 08:07:05 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Punit.Agrawal@arm.com, Javi Merino <javi.merino@arm.com>

Hi,

This RFC is our first stab at implementing the ideas we proposed in
[1].  The power allocator governor allocates device power to control
temperature.  This requires transforming performance requests into
requested power, which we do with the aid of power models.  Patch 3
(thermal: add a basic cpu power actor) implements a simple power model
for cpus.  The division of power between the actors ensures that power
is allocated where it is needed the most, based on the current
workload.

[1] http://article.gmane.org/gmane.linux.power-management.general/43243

Patches 1 and 2 were previously sent as separate patches: [2] and
[3]. There was a similar patch to "thermal: provide a way for the
governors to have private data for each thermal zone" posted by Wei Ni
but we can't use it as it is because it doesn't allow the governor's
bind() function (start() in Wei's patch) to modify the governor_data.
Other than that, this patch incorporates Rui's suggestion of keeping
the original governor if the new governor fails to bind.

[2] http://article.gmane.org/gmane.linux.power-management.general/43624
[3] https://patchwork.kernel.org/patch/3859721/

It's an RFC because we still need to tune it to achieve the
temperature stability that we are aiming for.  This RFC is just meant
to remove major road blocks as early as possible (if any).

We'll provide integration instructions soon so that people can test it
in their platforms.

Cheers,
Javi & Punit

Javi Merino (5):
  thermal: let governors have private data for each thermal zone
  thermal: let cooling devices operate on other units other than state
  thermal: add a basic cpu power actor
  thermal: introduce the Power Allocator governor
  thermal: add trace events to the power allocator governor

 drivers/acpi/fan.c                      |   22 +-
 drivers/acpi/processor_thermal.c        |   23 +-
 drivers/acpi/video.c                    |   22 +-
 drivers/platform/x86/acerhdf.c          |   24 +-
 drivers/platform/x86/intel_menlow.c     |   26 +-
 drivers/power/power_supply_core.c       |   24 +-
 drivers/thermal/Kconfig                 |   14 +
 drivers/thermal/Makefile                |    1 +
 drivers/thermal/cpu_cooling.c           |  427 +++++++++++++++++++++++++++=
++--
 drivers/thermal/db8500_thermal.c        |    2 +-
 drivers/thermal/fair_share.c            |    2 +-
 drivers/thermal/intel_powerclamp.c      |   24 +-
 drivers/thermal/power_allocator.c       |  413 +++++++++++++++++++++++++++=
+++
 drivers/thermal/step_wise.c             |    2 +-
 drivers/thermal/thermal_core.c          |   91 +++++--
 drivers/thermal/thermal_core.h          |    8 +
 include/linux/cpu_cooling.h             |   28 ++
 include/linux/thermal.h                 |   25 +-
 include/trace/events/thermal.h          |   34 +++
 include/trace/events/thermal_governor.h |   35 +++
 20 files changed, 1153 insertions(+), 94 deletions(-)
 create mode 100644 drivers/thermal/power_allocator.c
 create mode 100644 include/trace/events/thermal.h
 create mode 100644 include/trace/events/thermal_governor.h

--=20
1.7.9.5


