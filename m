From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 0/5] cpufreq: db8500: Rename driver and update some parts
Date: Wed, 28 Nov 2012 11:27:39 +0100
Message-ID: <1354098464-6665-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Rickard Andersson <rickard.andersson@stericsson.com>, Jonas Aberg <jonas.aberg@stericsson.com>, Vincent Guittot <vincent.guittot@linaro.org>, Philippe Begnic <philippe.begnic@st.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Ulf Hansson <ulf.hansson@linaro.org>

This patchset starts by renaming the db8500 cpufreq driver to a more generic
name. There are new variants which rely on it too, so instead we give it a
family name of dbx500.

On top of that a fixup patch for initialization of the driver and some minor
cleanup patches are included as well.

These patches can be material for 3.8, thus I think it should be fine if the
patches are merged through different trees. Unless some of the maintainers
are of other opinions.

Jonas Aaberg (1):
  cpufreq: dbx500: Minor code cleanup

Lee Jones (3):
  cpufreq: Give driver used for dbx500 family a more generic name
  mfd: db8500: Update cpufreq device name
  cpufreq: dbx500: Update file header

Ulf Hansson (1):
  cpufreq: dbx500: Move clk_get to probe

 drivers/cpufreq/Makefile         |    2 +-
 drivers/cpufreq/db8500-cpufreq.c |  179 -------------------------------------
 drivers/cpufreq/dbx500-cpufreq.c |  180 ++++++++++++++++++++++++++++++++++++++
 drivers/mfd/db8500-prcmu.c       |    4 +-
 4 files changed, 183 insertions(+), 182 deletions(-)
 delete mode 100644 drivers/cpufreq/db8500-cpufreq.c
 create mode 100644 drivers/cpufreq/dbx500-cpufreq.c

-- 
1.7.10

