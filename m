From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v3 0/7] drivers: devfreq: fix and optimize workqueue
 mechanism
Date: Tue, 12 Feb 2019 23:23:51 +0100
Message-ID: <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
References: <CGME20190212222422eucas1p1624203db4db3e495035820dea542e23a@eucas1p1.samsung.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: b.zolnierkie@samsung.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, tkjos@google.com, joel@joelfernandes.org, chris.diamand@arm.com, mka@chromium.org, rostedt@goodmis.org, mingo@redhat.com, Lukasz Luba <l.luba@partner.samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch set changes workqueue related features in devfreq framework.
First patch switches to delayed work instead of deferred.
The second switches to regular system work and deletes custom 'devfreq'.

Using deferred work in this context might harm the system performance.
When the CPU enters idle, deferred work is not fired. The devfreq device's
utilization does not have to be connected with a particular CPU.
The drivers for GPUs, Network on Chip, cache L3 rely on devfreq governor.
They all are missing opportunity to check the HW state and react when
the deferred work is not fired.
A corner test case, when Dynamic Memory Controller is utilized by CPUs running
on full speed, might show x5 worse performance if the crucial CPU is in idle.

There was a discussion regarding v2 that the power usage because of waking up
an idle CPU would be too high. In my opinion it won't and fixing bug is more
important than < 1% more power used [1].
I have addressed also this issue. In this patch set there is a mechanism
which prevents from to frequent checks when there is no need.
When the device enters its lowest state (OPP) the framework sets polling
interval to 'polling_idle_ms'. In default Kconfig it is 500ms, so 2 times per
second.
It is tunable from the sysfs interface per device, thus driver developer can
experiment and choose best intervals for the system.

Changes:
v3:
- reordered first two patches
- added functionality to lower power consumption when the device is less busy;
  there is a new polling interval enabled when device enters lowest frequency;
- added trace events to capture the behaviour of the system
v2:
- single patch split into two
- added cover letter

link for the previous version and discussion:
https://marc.info/?l=linux-pm&m=154989907416072&w=2
https://marc.info/?l=linux-pm&m=154904631226997&w=2

Regards,
Lukasz Luba

[1] https://marc.info/?l=linux-kernel&m=155000641622443&w=2

Lukasz Luba (7):
  drivers: devfreq: change deferred work into delayed
  drivers: devfreq: change devfreq workqueue mechanism
  Kconfig: drivers: devfreq: add default idle polling
  include: devfreq: add polling_idle_ms to 'profile'
  drivers: devfreq: add longer polling interval in idle
  trace: events: add devfreq trace event file
  drivers: devfreq: add tracing for scheduling work

 MAINTAINERS                               |   1 +
 drivers/devfreq/Kconfig                   |  13 +++
 drivers/devfreq/devfreq.c                 | 184 ++++++++++++++++++++++++------
 drivers/devfreq/governor.h                |   3 +-
 drivers/devfreq/governor_simpleondemand.c |   6 +-
 include/linux/devfreq.h                   |   6 +
 include/trace/events/devfreq.h            |  39 +++++++
 7 files changed, 218 insertions(+), 34 deletions(-)
 create mode 100644 include/trace/events/devfreq.h

-- 
2.7.4
