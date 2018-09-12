From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 00/11] OPP: Don't create multiple OPP tables for devices sharing OPP table
Date: Wed, 12 Sep 2018 13:58:39 +0530
Message-ID: <cover.1536736872.git.viresh.kumar@linaro.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: niklas.cassel@linaro.org, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, Jason Cooper <jason@lakedaemon.net>, Nishanth Menon <nm@ti.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Stephen Boyd <sboyd@kernel.org>, Viresh Kumar <vireshk@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, "4.18" <stable@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

@Niklas: Can you please confirm that this series fixes the issues you
have reported ? I have already tested it on Hikey960.
