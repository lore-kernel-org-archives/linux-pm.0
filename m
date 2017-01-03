From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 0/6] PM / Domains: Implement domain performance states
Date: Tue,  3 Jan 2017 16:36:06 +0530
Message-ID: <cover.1483439894.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:32929 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757125AbdACLGc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Jan 2017 06:06:32 -0500
Received: by mail-pg0-f43.google.com with SMTP id g1so174776440pgn.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Jan 2017 03:06:32 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, khilman@baylibre.com, ulf.hansson@linaro.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Vincent Guittot <vincent.guittot@linaro.org>, robh+dt@kernel.org, mark.rutland@arm.com, lina.iyer@linaro.org, rnayak@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

Hi,

An earlier series[1] tried to implement bindings for PM domain
performance states. Rob Herring suggested that we can actually write the
supporting code first instead of bindings, as that will make things
easier to understand for all.

The bindings [1] aren't discarded yet and this series is based on a
version of those only. The bindings are only used by the last patch,
which should not be applied and is only sent for completeness.

All other patches can be reviewed/applied whenever the maintainers feel
they look good.


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

All the patches are tested by hacking the OPP core a bit for now.

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

 Documentation/power/pm_qos_interface.txt |  11 ++--
 drivers/base/power/domain.c              | 102 ++++++++++++++++++++++++++++---
 drivers/base/power/opp/core.c            |  75 +++++++++++++++++++++++
 drivers/base/power/opp/debugfs.c         |   4 ++
 drivers/base/power/opp/of.c              |  44 +++++++++++++
 drivers/base/power/opp/opp.h             |  12 ++++
 drivers/base/power/qos.c                 |  74 +++++++++++++++++++---
 include/linux/pm_domain.h                |   6 ++
 include/linux/pm_qos.h                   |  16 +++--
 9 files changed, 322 insertions(+), 22 deletions(-)

-- 
2.7.1.410.g6faf27b

