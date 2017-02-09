From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 0/6] PM / Domains: Implement domain performance states
Date: Thu,  9 Feb 2017 09:11:46 +0530
Message-ID: <cover.1486611268.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, khilman@baylibre.com, ulf.hansson@linaro.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, sboyd@codeaurora.org, nm@ti.com, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi,

An earlier series[1] tried to implement bindings for PM domain
performance states. Rob Herring suggested that we can actually merge the
supporting code first instead of bindings, as that will make things
easier to understand for all. The bindings can be decided and merged
later.

The bindings [1] aren't discarded yet and this series is based on a
version of those only. The bindings are only used by the last patch,
which should not be applied and is only sent for completeness.

IOW, this series doesn't have any dependencies and can be merged
straight away without waiting for the DT bindings.

A brief summary of the problem this series is trying to solve:

Some platforms have the capability to configure the performance state of
their Power Domains. The performance levels are represented by positive
integer values, a lower value represents lower performance state.

We decided earlier that we should extend Power Domain framework to
support active state power management as well.  The power-domains until
now were only concentrating on the idle state management of the device
and this needs to change in order to reuse the infrastructure of power
domains for active state management.

The first 5 patches update the PM domain and QoS frameworks to support
that and the last one presents the front end interface to it.

The V1 series was tested by hacking the OPP core a bit but this one is
also tested by Rajendra Nayak (Qcom) on *real* Qualcomm hardware for
which this work is done. And most of his feedback is incorporated here.

V1->V2:
- Based over latest pm/linux-next
- It is mostly a resend of what is sent earlier as this series hasn't
  got any reviews so far and Rafael suggested that its better I resend
  it.
- Only the 4/6 patch got an update, which was shared earlier as reply to
  V1 as well. It has got several fixes for taking care of power domain
  hierarchy, etc.

--
viresh

[1] https://marc.info/?l=linux-kernel&m=148154020127722&w=2

Viresh Kumar (6):
  PM / QOS: Add default case to the switch
  PM / QOS: Pass request type to dev_pm_qos_{add|remove}_notifier()
  PM / QOS: Add 'performance' request
  PM / domain: Register for PM QOS performance notifier
  PM / domain: Save/restore performance state at runtime suspend/resume
  PM / OPP: Add support to parse domain-performance-state

 Documentation/power/pm_qos_interface.txt |  11 ++-
 drivers/base/power/domain.c              | 125 +++++++++++++++++++++++++++++--
 drivers/base/power/opp/core.c            |  75 +++++++++++++++++++
 drivers/base/power/opp/debugfs.c         |   4 +
 drivers/base/power/opp/of.c              |  44 +++++++++++
 drivers/base/power/opp/opp.h             |  12 +++
 drivers/base/power/qos.c                 |  74 ++++++++++++++++--
 include/linux/pm_domain.h                |   6 ++
 include/linux/pm_qos.h                   |  16 +++-
 9 files changed, 345 insertions(+), 22 deletions(-)

-- 
2.7.1.410.g6faf27b
