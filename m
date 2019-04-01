From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: [PATCH v2 4/4] devfreq: add mediatek cci devfreq
Date: Mon, 01 Apr 2019 13:18:43 +0900
Message-ID: <20190401041843epcms1p10a664023cf0556e42afe118a1d84daad@epcms1p1>
References: <1553841972-19737-5-git-send-email-andrew-sh.cheng@mediatek.com>
        <1553841972-19737-1-git-send-email-andrew-sh.cheng@mediatek.com>
        <CGME20190329064636epcas1p13633ae078ef83ceda0b8189df1399753@epcms1p1>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553841972-19737-5-git-send-email-andrew-sh.cheng@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "srv_heupstream@mediatek.com" <srv_heupstream@mediatek.com>, "fan.chen@mediatek.com" <fan.chen@mediatek.com>, "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
List-Id: linux-pm@vger.kernel.org

>This adds a devfreq driver for the Cache Coherent Interconnect (CCI)
>of the Mediatek MT8183.
>
>On the MT8183 the CCI is supplied by the same regulator as the LITTLE
>cores. The driver is notified when the regulator voltage changes
>(driven by cpufreq) and adjusts the CCI frequency to the maximum
>possible value.
>
>Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
>---
> drivers/devfreq/Kconfig              |  10 ++
> drivers/devfreq/Makefile             |   1 +
> drivers/devfreq/mt8183-cci-devfreq.c | 235 +++++++++++++++++++++++++++++++++++
> 3 files changed, 246 insertions(+)
> create mode 100644 drivers/devfreq/mt8183-cci-devfreq.c
>

1. It appears that proc_reg_uV might be used before initialization.
It would be appropriate to initialize it at the probe function.

2. Because you are already using OPP, why don't you rely on
OPP fully? (use OPP from CPUFreq drivers as well in order to get
OPP events automatically.) Anyway, this is a minor item that does
not need to be corrected.

Cheers
MyungJoo
