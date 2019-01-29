From: Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>
Subject: [PATCH 0/3] Add cpufreq and cci devfreq for mt8183
Date: Tue, 29 Jan 2019 14:35:01 +0800
Message-ID: <1548743704-16821-1-git-send-email-andrew-sh.cheng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com, fan.chen@mediatek.com, Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>
List-Id: linux-pm@vger.kernel.org

MT8183 supports CPU DVFS and CCI DVFS, and LITTLE cpus and CCI are in the same voltage domain.
So, this series is to add drivers to handle the voltage coupling between CPU and CCI DVFS.

Andrew-sh.Cheng (3):
  cpufreq: mediatek: add mt8183 cpufreq support
  dt-bindings: devfreq: add compatible for mt8183 cci devfreq
  devfreq: add mediatek cci devfreq

 .../bindings/devfreq/mt8183-cci-devfreq.txt        |  19 ++
 drivers/cpufreq/cpufreq-dt-platdev.c               |   1 +
 drivers/cpufreq/mediatek-cpufreq.c                 |   7 +-
 drivers/devfreq/Kconfig                            |   9 +
 drivers/devfreq/Makefile                           |   1 +
 drivers/devfreq/mt8183-cci-devfreq.c               | 224 +++++++++++++++++++++
 6 files changed, 260 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/devfreq/mt8183-cci-devfreq.txt
 create mode 100644 drivers/devfreq/mt8183-cci-devfreq.c

-- 
1.8.1.1.dirty
