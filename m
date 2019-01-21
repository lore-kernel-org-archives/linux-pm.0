From: Quentin Perret <quentin.perret@arm.com>
Subject: [PATCH v2 0/3] Documentation: Explain EAS and EM
Date: Mon, 21 Jan 2019 11:17:21 +0000
Message-ID: <20190121111724.18234-1-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: corbet@lwn.net, peterz@infradead.org, rjw@rjwysocki.net, juri.lelli@redhat.com
Cc: mingo@redhat.com, morten.rasmussen@arm.com, qais.yousef@arm.com, patrick.bellasi@arm.com, dietmar.eggemann@arm.com, linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The recently introduced Energy Aware Scheduling (EAS) feature relies on
a large set of concepts, assumptions, and design choices that are
probably not obvious for an outsider. Moreover, enabling EAS on a
particular platform isn't straightforward because of all its
dependencies. This series tries to address this by introducing proper
documentation files for the scheduler's part of EAS and for the newly
introduced Energy Model (EM) framework. These are meant to explain not
only the design choices of EAS but also to list its dependencies in a
human-readable location.

Changes in v2:
 - Fixed typos and style in sched-energy.txt (Juri)
 - Moved EM doc under Documentation/driver-api/pm/ (Rafael)
 - Translated EM doc into .rst (Rafael)
 - Fixed EM kerneldoc comments to avoid htmldoc build errors

Quentin Perret (3):
  PM / EM: Fix broken kerneldoc
  PM / EM: Document the Energy Model framework
  sched: Document Energy Aware Scheduling

 Documentation/driver-api/pm/energy-model.rst | 150 +++++++
 Documentation/driver-api/pm/index.rst        |   1 +
 Documentation/scheduler/sched-energy.txt     | 431 +++++++++++++++++++
 include/linux/energy_model.h                 |   4 +-
 kernel/power/energy_model.c                  |   2 +-
 5 files changed, 585 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/driver-api/pm/energy-model.rst
 create mode 100644 Documentation/scheduler/sched-energy.txt

-- 
2.20.1
