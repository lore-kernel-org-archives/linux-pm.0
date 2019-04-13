From: andrew-sh.cheng <andrew-sh.cheng@mediatek.com>
Subject: Re: [PATCH v2 2/4] opp: add API which get max freq by voltage
Date: Sat, 13 Apr 2019 11:36:15 +0800
Message-ID: <1555126575.14109.4.camel@mtksdaap41>
References: <1553841972-19737-3-git-send-email-andrew-sh.cheng@mediatek.com>
 <1553841972-19737-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <CGME20190329064632epcas2p4d10ea099bfea4ad682d7312a75bfbe68@epcms1p8>
 <20190401023047epcms1p888e2dba45fcbc1de98d71d8a37acb976@epcms1p8>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190401023047epcms1p888e2dba45fcbc1de98d71d8a37acb976@epcms1p8>
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

On Mon, 2019-04-01 at 11:30 +0900, MyungJoo Ham wrote:
> >This API will get voltage as input parameter.
> >Search all opp items for the item which with max frequency,
> >and the voltae is smaller than provided voltage.
> >
> >Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> >---
> > drivers/opp/core.c     | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++
> > include/linux/pm_opp.h |  8 ++++++++
> > 2 files changed, 63 insertions(+)
> >
> >diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> >index 24c757a..57deef9 100644
> >--- a/include/linux/pm_opp.h
> >+++ b/include/linux/pm_opp.h
> >@@ -102,6 +102,8 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
> > 
> > struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
> > 					      unsigned long *freq);
> >+struct dev_pm_opp *dev_pm_opp_find_max_freq_by_volt(struct device *dev,
> >+					      unsigned long u_volt);
> 
> For the symmetricity, wouldn't it be better to name it
> dev_pm_opp_find_volt_ceiling(dev, u_volt); ?
Yes.
Viresh has comment on this, too.
I will use dev_pm_opp_find_freq_ceil_by_volt() in next patch.

> 
> Cheers,
> MyungJoo
> 
> 
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
