From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 0/3] drivers: Frequency constraint infrastructure
Date: Fri, 11 Jan 2019 14:48:33 +0530
Message-ID: <cover.1547197612.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <vireshk@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, mka@chromium.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

This commit introduces the frequency constraint infrastructure, which
provides a generic interface for parts of the kernel to constraint the
working frequency range of a device.

The primary users of this are the cpufreq and devfreq frameworks. The
cpufreq framework already implements such constraints with help of
notifier chains (for thermal and other constraints) and some local code
(for user-space constraints). The devfreq framework developers have also
shown interest [1] in such a framework, which may use it at a later
point of time.

The idea here is to provide a generic interface and get rid of the
notifier based mechanism.

Only one constraint is added for now for the cpufreq framework and the
rest will follow after this stuff is merged.

Matthias Kaehlcke was involved in the preparation of the first draft of
this work and so I have added him as Co-author to the first patch.
Thanks Matthias.

FWIW, This doesn't have anything to do with the boot-constraints
framework [2] I was trying to upstream earlier :)

--
viresh

[1] lore.kernel.org/lkml/20181002220625.GJ22824@google.com
[2] lore.kernel.org/lkml/cover.1519380923.git.viresh.kumar@linaro.org

Viresh Kumar (3):
  drivers: base: Add frequency constraint infrastructure
  cpufreq: Implement freq-constraint callback
  cpufreq: Implement USER constraint

 MAINTAINERS                     |   8 +
 drivers/base/Kconfig            |   5 +
 drivers/base/Makefile           |   1 +
 drivers/base/freq_constraint.c  | 633 ++++++++++++++++++++++++++++++++++++++++
 drivers/cpufreq/Kconfig         |   1 +
 drivers/cpufreq/cpufreq.c       |  92 ++++--
 include/linux/cpufreq.h         |   8 +-
 include/linux/freq_constraint.h |  45 +++
 8 files changed, 756 insertions(+), 37 deletions(-)
 create mode 100644 drivers/base/freq_constraint.c
 create mode 100644 include/linux/freq_constraint.h

-- 
2.7.4
