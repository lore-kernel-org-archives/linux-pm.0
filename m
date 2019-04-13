From: andrew-sh.cheng <andrew-sh.cheng@mediatek.com>
Subject: Re: [PATCH v2 4/4] devfreq: add mediatek cci devfreq
Date: Sat, 13 Apr 2019 13:54:28 +0800
Message-ID: <1555134868.14109.11.camel@mtksdaap41>
References: <1553841972-19737-5-git-send-email-andrew-sh.cheng@mediatek.com>
 <1553841972-19737-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <CGME20190329064636epcas1p13633ae078ef83ceda0b8189df1399753@epcms1p1>
 <20190401041843epcms1p10a664023cf0556e42afe118a1d84daad@epcms1p1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190401041843epcms1p10a664023cf0556e42afe118a1d84daad@epcms1p1>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: myungjoo.ham@samsung.com
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "srv_heupstream@mediatek.com" <srv_heupstream@mediatek.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J.
 Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Rob Herring <robh+dt@kernel.org>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, "fan.chen@mediatek.com" <fan.chen@mediatek.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 2019-04-01 at 13:18 +0900, MyungJoo Ham wrote:
> >This adds a devfreq driver for the Cache Coherent Interconnect (CCI)
> >of the Mediatek MT8183.
> >
> >On the MT8183 the CCI is supplied by the same regulator as the LITTLE
> >cores. The driver is notified when the regulator voltage changes
> >(driven by cpufreq) and adjusts the CCI frequency to the maximum
> >possible value.
> >
> >Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> >---
> > drivers/devfreq/Kconfig              |  10 ++
> > drivers/devfreq/Makefile             |   1 +
> > drivers/devfreq/mt8183-cci-devfreq.c | 235 +++++++++++++++++++++++++++++++++++
> > 3 files changed, 246 insertions(+)
> > create mode 100644 drivers/devfreq/mt8183-cci-devfreq.c
> >
> 
> 1. It appears that proc_reg_uV might be used before initialization.
> It would be appropriate to initialize it at the probe function.
In this governor, cci only change frequency after get notification.
So it must set proc_reg_uV first, and then call update_devfreq() which
call to mtk_cci_governor_get_target() and use proc_reg_uV.
> 
> 2. Because you are already using OPP, why don't you rely on
> OPP fully? (use OPP from CPUFreq drivers as well in order to get
> OPP events automatically.) Anyway, this is a minor item that does
> not need to be corrected.
For some discuss about this in Mediatek before, we decide to put the
operation of CCI in CCI related driver and separated from CPUFreq.
> 
> Cheers
> MyungJoo
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
