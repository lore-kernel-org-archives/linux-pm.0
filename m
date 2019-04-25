From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/4] PM / Domains: Improve support for CPUs in genpd
Date: Thu, 25 Apr 2019 11:04:09 +0200
Message-ID: <20190425090413.10700-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Rajendra Nayak <rnayak@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, Niklas Cassel <niklas.cassel@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Recently genpd was extended to cope with devices belonging to CPUs. However,
attaching CPU devices via genpd_dev_pm_attach_by_id|name() doesn't work,
because of the virtual device that genpd allocates in this path.

In this series, this limitation is addressed, together with a few other related
fixes/cleanups.

Ulf Hansson (4):
  PM / Domains: Use the base device for
    driver_deferred_probe_check_state()
  PM / Domains: Drop unused in-parameter to some genpd functions
  PM / Domains: Search for the CPU device outside the genpd lock
  PM / Domains: Allow to attach a CPU via
    genpd_dev_pm_attach_by_id|name()

 drivers/base/power/domain.c | 73 ++++++++++++++++++-------------------
 include/linux/pm_domain.h   |  1 +
 2 files changed, 36 insertions(+), 38 deletions(-)

-- 
2.17.1
