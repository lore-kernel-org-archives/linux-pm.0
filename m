From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH v5 3/3] dts: hi6220: enable thermal sensor for hisilicon
 SoC
Date: Wed, 20 May 2015 11:02:54 +0800
Message-ID: <20150520030254.GA27887@leoy-linaro>
References: <1431933109-22764-1-git-send-email-kong.kongxinwei@hisilicon.com>
 <1431933109-22764-4-git-send-email-kong.kongxinwei@hisilicon.com>
 <20150520045100.GB4295@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:35609 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589AbbETDDD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 May 2015 23:03:03 -0400
Received: by pdea3 with SMTP id a3so50879469pde.2
        for <linux-pm@vger.kernel.org>; Tue, 19 May 2015 20:03:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150520045100.GB4295@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Xinwei Kong <kong.kongxinwei@hisilicon.com>, rui.zhuang@intel.com, amit.kucheria@linaro.org, punit.agrawal@arm.com, Javi.Merino@arm.com, jorge.ramirez-ortiz@linaro.org, haojian.zhuang@linaro.org, linux-pm@vger.kernel.org, dan.zhao@hisilicon.com, devicetree@vger.kernel.org, gongyu@hisilicon.com, guodong.xu@linaro.org, robh@kernel.org, mark.rutland@arm.com, linuxarm@huawei.com, zhenwei.wang@hisilicon.com, mporter@konsulko.com, zhangfei.gao@linaro.org, liguozhu@hisilicon.com

On Tue, May 19, 2015 at 09:51:01PM -0700, Eduardo Valentin wrote:
> On Mon, May 18, 2015 at 03:11:49PM +0800, Xinwei Kong wrote:
> > From: kongxinwei <kong.kongxinwei@hisilicon.com>
> > 
> > Dts includes two part: the first part is related with thermal sensor;
> > the second part is related with thermal zones, in this part it will
> > define the thermal zones and which sensor device should be bound to.
> > it also need specify the polling interval for every thermal zone.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > Signed-off-by: kongxinwei <kong.kongxinwei@hisilicon.com>
> > ---
> >  arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 127 ++++++++++++++++++++++++++++++
> >  1 file changed, 127 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> > 
> > diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> > new file mode 100644
> > index 0000000..82f213d
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> > @@ -0,0 +1,127 @@
> > +
> > +#include <dt-bindings/thermal/thermal.h>
> > +
> > +/ {
> > +
> > +	tsensor: tsensor@0,f7030700 {
> > +		compatible = "hisilicon,tsensor";
> > +		reg = <0x0 0xf7030700 0x0 0x1000>;
> > +		interrupts = <0 7 0x4>;
> > +		clocks = <&clock_sys HI6220_TSENSOR_CLK>;
> > +		clock-names = "thermal_clk";
> > +		#thermal-sensor-cells = <1>;
> > +
> > +	thermal-zones {
> 
> The thermal-zones node is typically in the root node, not inside the
> sensor node.
> 
> > +		local: local {
> > +			/* milliseconds */
> > +			polling-delay-passive = <1000>;
> > +			/* milliseconds */
> > +			polling-delay = <5000>;
> > +
> > +			/* sensor	ID */
> > +			thermal-sensors = <&tsensor  0>;
> > +
> > +			trips {
> > +				local_alert: local_alert {
> > +					/* millicelsius */
> > +					temperature = <70000>;
> > +					/* millicelsius */
> > +					hysteresis = <2000>;
> > +					type = "passive";
> > +				};
> > +				local_crit: local_crit {
> > +					temperature = <90000>;
> > +					hysteresis = <2000>;
> > +					type = "critical";
> > +				};
> > +			};
> > +
> > +			cooling-maps {
> > +				/* There are currently no cooling maps
> > +				because there are no cooling devices */
> 
> Not even cpufreq? in your driver you mention about cpufreq cooling.
> 
> Do you have cpufreq-dt driver  properly setup in your board?

Yes, cpufreq-dt will be used on hi6220 to enable cpufreq cooling
device. [1]

Xinwei will resend this patch, and should verify it based on
hi6220's minimal system patch series. [2]

[1] http://archive.arm.linux.org.uk/lurker/message/20150330.052637.16e0f3f4.en.html
[2] http://archive.arm.linux.org.uk/lurker/message/20150507.140019.bde047ed.en.html

Thanks,
Leo Yan
