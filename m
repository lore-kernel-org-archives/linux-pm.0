From: Quentin Perret <quentin.perret@arm.com>
Subject: [PATCH 0/2] Documentation: Explain EAS and EM
Date: Thu, 10 Jan 2019 11:05:44 +0000
Message-ID: <20190110110546.8101-1-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: corbet@lwn.net, peterz@infradead.org, rjw@rjwysocki.net
Cc: mingo@redhat.com, morten.rasmussen@arm.com, qais.yousef@arm.com, patrick.bellasi@arm.com, dietmar.eggemann@arm.com, linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, quentin.perret@arm.com
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

The two new doc files are simple .txt to be consistent with the existing
documentation of the relevant subsystems, but I'm happy to translate to
.rst if deemed necessary.

All feedback is welcome.

Thanks !
Quentin

Quentin Perret (2):
  PM / EM: Document the Energy Model framework
  sched: Document Energy Aware Scheduling

 Documentation/power/energy-model.txt     | 144 ++++++++
 Documentation/scheduler/sched-energy.txt | 425 +++++++++++++++++++++++
 2 files changed, 569 insertions(+)
 create mode 100644 Documentation/power/energy-model.txt
 create mode 100644 Documentation/scheduler/sched-energy.txt

-- 
2.20.1
