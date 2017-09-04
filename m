From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH 08/13] thermal/drivers/hisi: Fix configuration register
 setting
Date: Mon, 4 Sep 2017 08:58:25 +0800
Message-ID: <20170904005825.GH3841@leoy-linaro>
References: <1504082857-21702-1-git-send-email-daniel.lezcano@linaro.org>
 <1504082857-21702-8-git-send-email-daniel.lezcano@linaro.org>
 <20170902025426.GA3841@leoy-linaro>
 <e5775d5d-bd5d-5472-31e6-a0751a9aa0ce@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e5775d5d-bd5d-5472-31e6-a0751a9aa0ce@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org, kevin.wangtao@linaro.org, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Sep 02, 2017 at 10:34:34AM +0200, Daniel Lezcano wrote:
> On 02/09/2017 04:54, Leo Yan wrote:
> > On Wed, Aug 30, 2017 at 10:47:32AM +0200, Daniel Lezcano wrote:
> >> The TEMP0_CFG configuration register contains different field to set up the
> >> temperature controller. However in the code, nothing prevents a setup to
> >> overwrite the previous one: eg. writing the hdak value overwrites the sensor
> >> selection, the sensor selection overwrites the hdak value.
> >>
> >> In order to prevent such thing, use a regmap-like mechanism by reading the
> >> value before, set the corresponding bits and write the result.
> >>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> ---
> >>  drivers/thermal/hisi_thermal.c | 30 +++++++++++++++++++++++++-----
> >>  1 file changed, 25 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
> >> index d77a938..3e03908 100644
> >> --- a/drivers/thermal/hisi_thermal.c
> >> +++ b/drivers/thermal/hisi_thermal.c
> >> @@ -132,19 +132,39 @@ static inline void hisi_thermal_enable(void __iomem *addr, int value)
> >>  	writel(value, addr + TEMP0_EN);
> >>  }
> >>  
> >> -static inline void hisi_thermal_sensor_select(void __iomem *addr, int sensor)
> >> +static inline int hisi_thermal_get_temperature(void __iomem *addr)
> >>  {
> >> -	writel((sensor << 12), addr + TEMP0_CFG);
> >> +	return hisi_thermal_step_to_temp(readl(addr + TEMP0_VALUE));
> >>  }
> >>  
> >> -static inline int hisi_thermal_get_temperature(void __iomem *addr)
> >> +/*
> >> + * Temperature configuration register - Sensor selection
> >> + *
> >> + * Bits [19:12]
> >> + *
> >> + * 0x0: local sensor (default)
> >> + * 0x1: remote sensor 1 (ACPU cluster 1)
> >> + * 0x2: remote sensor 2 (ACPU cluster 0)
> >> + * 0x3: remote sensor 3 (G3D)
> >> + */
> >> +static inline void hisi_thermal_sensor_select(void __iomem *addr, int sensor)
> >>  {
> >> -	return hisi_thermal_step_to_temp(readl(addr + TEMP0_VALUE));
> >> +	writel(readl(addr + TEMP0_CFG) | (sensor << 12), addr + TEMP0_CFG);
> > 
> > nitpick: maybe it's better to firstly clear related bits and then set
> > value?
> 
> Sorry, I don't get the comment. Can you elaborate ?

Sure, here I am bit concern there the mixing old bits value and new
setting bits. My suggested code likes below:

  u32 val;

  val = readl(addr + TEMP0_CFG);
  val &= ~0xF000;
  val |= (sensor << 12);
  writel(val, addr + TEMP0_CFG);

Thanks,
Leo Yan
