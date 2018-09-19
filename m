From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 00/12] OPP: Don't create multiple OPP tables for devices sharing OPP table
Date: Wed, 19 Sep 2018 15:20:19 -0700
Message-ID: <cover.1537394233.git.viresh.kumar@linaro.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, Jason Cooper <jason@lakedaemon.net>, Nishanth Menon <nm@ti.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Stephen Boyd <sboyd@kernel.org>, Viresh Kumar <vireshk@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, "4.18" <stable@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Niklas Cassel <niklas.cassel@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hello,

Niklas Cassle recently reported some regressions with his Qcom cpufreq
driver where he was getting some errors while creating the OPPs tables.

After looking into it I realized that the OPP core incorrectly creates
multiple OPP tables for the devices even if they are sharing the OPP
table in DT. This happens when the request comes using different CPU
devices. For example, dev_pm_opp_set_supported_hw() getting called using
CPU0 and dev_pm_opp_of_add_table() getting called using CPU1.

This series redesigns the internals of the OPP core to fix that. The
redesign has simplified the core itself though.

The first three patches are fixes really for the current code and the rest
of them are making necessary changes to fix the issue defined in
$subject here.

Nikklas already tested this series and his Tested-by is already applied
to series here. I would like to get this merged during the 4.20 merge
window and will push the series to linux-next soon to get more test
coverage. Please provide comments as soon as possible, else will send it
as part of the pull request to Rafael for 4.20.

--
viresh

V1->V2:
- Nikklas reported another regressions which is fixed by the 2nd commit
  in this series.

Viresh Kumar (12):
  OPP: Free OPP table properly on performance state irregularities
  OPP: Don't try to remove all OPP tables on failure
  OPP: Protect dev_list with opp_table lock
  OPP: Pass index to _of_init_opp_table()
  OPP: Parse OPP table's DT properties from _of_init_opp_table()
  OPP: Don't take OPP table's kref for static OPPs
  OPP: Create separate kref for static OPPs list
  cpufreq: mvebu: Remove OPPs using dev_pm_opp_remove()
  OPP: Don't remove dynamic OPPs from _dev_pm_opp_remove_table()
  OPP: Use a single mechanism to free the OPP table
  OPP: Prevent creating multiple OPP tables for devices sharing OPP
    nodes
  OPP: Pass OPP table to _of_add_opp_table_v{1|2}()

 drivers/cpufreq/mvebu-cpufreq.c |   9 +-
 drivers/opp/core.c              | 147 ++++++++++++++++++++-----------
 drivers/opp/cpu.c               |  15 ++--
 drivers/opp/of.c                | 188 +++++++++++++++++++++-------------------
 drivers/opp/opp.h               |  19 ++--
 include/linux/pm_opp.h          |   6 ++
 6 files changed, 226 insertions(+), 158 deletions(-)

-- 
2.14.1
