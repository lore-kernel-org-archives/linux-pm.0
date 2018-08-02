From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: [PATCH v3 1/2] PM / devfreq: Generic CPU frequency to device
 frequency mapping governor
Date: Thu, 02 Aug 2018 18:56:08 +0900
Message-ID: <20180802095608epcms1p33fb061543efc9ceb3ec12d5567ceffbc@epcms1p3>
References: <1533171465-25508-1-git-send-email-skannan@codeaurora.org>
        <CGME20180802005756epcas4p465a12f42a0e36f0af6fd276a3a56957f@epcms1p3>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533171465-25508-1-git-send-email-skannan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Saravana Kannan <skannan@codeaurora.org>, "georgi.djakov@linaro.org" <georgi.djakov@linaro.org>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "daidavid1@codeaurora.org" <daidavid1@codeaurora.org>, "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

>Many CPU architectures have caches that can scale independent of the CPUs.
>Frequency scaling of the caches is necessary to make sure the cache is not
>a performance bottleneck that leads to poor performance and power. The same
>idea applies for RAM/DDR.
>
>To achieve this, this patch adds a generic devfreq governor that takes the
>current frequency of each CPU frequency domain and then adjusts the
>frequency of the cache (or any devfreq device) based on the frequency of
>the CPUs. It listens to CPU frequency transition notifiers to keep itself
>up to date on the current CPU frequency.
>
>To decide the frequency of the device, the governor does one of the
>following:

This exactly has the same purpose with "passive" governor except for the
single part: passive governor depends on another devfreq driver, not
cpufreq driver.

If both governors have many features in common, can you merge them into one?
Passive governor also has "get_target_freq", which allows driver authors
to define the mapping.

Probably, you will need to add one more notifier call to get events from
cpufreq instead of devfreq.

>
>* Uses a CPU frequency to device frequency mapping table
>  - Either one mapping table used for all CPU freq policies (typically used
>    for system with homogeneous cores/clusters that have the same OPPs).
>  - One mapping table per CPU freq policy (typically used for ASMP systems
>    with heterogeneous CPUs with different OPPs)
>
>OR
>
>* Scales the device frequency in proportion to the CPU frequency. So, if
>  the CPUs are running at their max frequency, the device runs at its max
>  frequency.  If the CPUs are running at their min frequency, the device
>  runs at its min frequency. And interpolated for frequencies in between.

If you want to satisfy these two cases to the "modified" passive governors,
you may need to supply two "preloaded" get_target_freq functions for
struct devfreq_passive_data. If that's impossible, requiring a bit more
modifications, you may need to write alternative routines in
update_devfreq_passive().

Cheers,
MyungJoo

>
>Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>---
> .../bindings/devfreq/devfreq-cpufreq-map.txt       |  53 ++
> drivers/devfreq/Kconfig                            |   8 +
> drivers/devfreq/Makefile                           |   1 +
> drivers/devfreq/governor_cpufreq_map.c             | 583 +++++++++++++++++++++
> 4 files changed, 645 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/devfreq/devfreq-cpufreq-map.txt
> create mode 100644 drivers/devfreq/governor_cpufreq_map.c
>
[]
>diff --git a/drivers/devfreq/governor_cpufreq_map.c b/drivers/devfreq/governor_cpufreq_map.c
>new file mode 100644
>index 0000000..084a3ff
>--- /dev/null
>+++ b/drivers/devfreq/governor_cpufreq_map.c
>@@ -0,0 +1,583 @@
>+// SPDX-License-Identifier: GPL-2.0
>+/*
>+ * Copyright (c) 2014-2015, 2018, The Linux Foundation. All rights reserved.
>+ */

Is this boilerplate fine? ( using // )
