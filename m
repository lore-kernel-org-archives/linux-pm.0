From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH 07/13] thermal/drivers/hisi: Encapsulate register writes
 into helpers
Date: Sat, 2 Sep 2017 10:17:10 +0800
Message-ID: <20170902021710.GD19958@leoy-linaro>
References: <1504082857-21702-1-git-send-email-daniel.lezcano@linaro.org>
 <1504082857-21702-7-git-send-email-daniel.lezcano@linaro.org>
 <20170902020915.GC19958@leoy-linaro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170902020915.GC19958@leoy-linaro>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org, kevin.wangtao@linaro.org, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Sep 02, 2017 at 10:09:15AM +0800, Leo Yan wrote:
> On Wed, Aug 30, 2017 at 10:47:31AM +0200, Daniel Lezcano wrote:
> > Hopefully, the function name can help to clarify the semantic of the operations
> > when writing in the register.
> > 
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > ---
> >  drivers/thermal/hisi_thermal.c | 96 +++++++++++++++++++++++++++++++-----------
> >  1 file changed, 72 insertions(+), 24 deletions(-)
> > 
> > diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
> > index 6f0dab1..d77a938 100644
> > --- a/drivers/thermal/hisi_thermal.c
> > +++ b/drivers/thermal/hisi_thermal.c
> > @@ -26,6 +26,7 @@
> >  
> >  #include "thermal_core.h"
> >  
> > +#define TEMP0_LAG			(0x0)
> >  #define TEMP0_TH			(0x4)
> >  #define TEMP0_RST_TH			(0x8)
> >  #define TEMP0_CFG			(0xC)
> > @@ -96,6 +97,56 @@ static inline long hisi_thermal_round_temp(int temp)
> >  		hisi_thermal_temp_to_step(temp));
> >  }
> >  
> > +static inline void hisi_thermal_set_lag(void __iomem *addr, int value)
> > +{
> > +	writel(value, addr + TEMP0_LAG);
> > +}
> > +
> > +static inline void hisi_thermal_alarm_clear(void __iomem *addr, int value)
> > +{
> > +	writel(value, addr + TEMP0_INT_CLR);
> > +}
> > +
> > +static inline void hisi_thermal_alarm_enable(void __iomem *addr, int value)
> > +{
> > +	writel(value, addr + TEMP0_INT_EN);
> > +}
> > +
> > +static inline void hisi_thermal_alarm_set(void __iomem *addr, int temp)
> > +{
> > +	writel(hisi_thermal_temp_to_step(temp) | 0x0FFFFFF00, addr + TEMP0_TH);
> > +}
> > +
> > +static inline void hisi_thermal_reset_set(void __iomem *addr, int temp)
> > +{
> > +        writel(hisi_thermal_temp_to_step(temp), addr + TEMP0_RST_TH);
> > +}
> > +
> > +static inline void hisi_thermal_reset_enable(void __iomem *addr, int value)
> > +{
> > +        writel(value, addr + TEMP0_RST_MSK);
> > +}
> > +
> > +static inline void hisi_thermal_enable(void __iomem *addr, int value)
> > +{
> > +	writel(value, addr + TEMP0_EN);
> > +}
> > +
> > +static inline void hisi_thermal_sensor_select(void __iomem *addr, int sensor)
> > +{
> > +	writel((sensor << 12), addr + TEMP0_CFG);
> > +}
> > +
> > +static inline int hisi_thermal_get_temperature(void __iomem *addr)
> > +{
> > +	return hisi_thermal_step_to_temp(readl(addr + TEMP0_VALUE));
> > +}
> > +
> > +static inline void hisi_thermal_hdak_set(void __iomem *addr, int value)
> > +{
> > +	writel(value, addr + TEMP0_CFG);
> > +}
> 
> hdak and sensor id setting share the same one register, so it's
> possible to overwrite their value with each other. And for hdak
> setting, it should offset 4 bits.
> 
> The issues are exists in old code yet but not introduce by this
> patch. Could fix these issues as well in this patch?

Have seen the mentioned issues have been fixed in patch 0008. So have
no more question at here.

[...]

Thanks,
Leo Yan
