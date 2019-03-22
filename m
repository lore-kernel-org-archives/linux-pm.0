From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v2 3/5] devfreq: rk3399_dmc: Pass ODT and auto power down
 parameters to TF-A.
Date: Thu, 21 Mar 2019 17:01:07 -0700
Message-ID: <20190322000107.GU112750@google.com>
References: <20190319181323.22804-1-gael.portay@collabora.com>
 <20190319181323.22804-4-gael.portay@collabora.com>
 <20190320003352.GN112750@google.com>
 <20190320215013.43zgvyn5frnb3yud@archlinux.localdomain>
 <20190320220223.GP112750@google.com>
 <20190321231055.j7z23f3k3rcngq4u@archlinux.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190321231055.j7z23f3k3rcngq4u@archlinux.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?R2HDq2w=?= PORTAY <gael.portay@collabora.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Derek Basehore <dbasehore@chromium.org>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Rob Herring <robh+dt@kernel.org>, Klaus Goger <klaus.goger@theobroma-systems.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-rockchip@lists.infradead.org, Randy Li <ayaka@soulik.info>, kernel@collabora.com, linux-arm-kernel@lists.infradead.org, Lin Huang <hl@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

Hi Gaël,

On Thu, Mar 21, 2019 at 07:10:55PM -0400, Gaël PORTAY wrote:
> Matthias,
> 
> On Wed, Mar 20, 2019 at 03:02:23PM -0700, Matthias Kaehlcke wrote:
> > Hi Gaël,
> > 
> > On Wed, Mar 20, 2019 at 05:50:13PM -0400, Gaël PORTAY wrote:
> > > Hi Matthias,
> > > 
> > > On Tue, Mar 19, 2019 at 05:33:52PM -0700, Matthias Kaehlcke wrote:
> > > > ...
> > > > > @@ -95,6 +103,19 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
> > > > >  
> > > > >  	mutex_lock(&dmcfreq->lock);
> > > > >  
> > > > > +	if (target_rate >= dmcfreq->odt_dis_freq)
> > > > > +		odt_enable = true;
> > > > > +
> > > > > +	/*
> > > > > +	 * This makes a SMC call to the TF-A to set the DDR PD (power-down)
> > > > > +	 * timings and to enable or disable the ODT (on-die termination)
> > > > > +	 * resistors.
> > > > > +	 */
> > > > > +	arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, dmcfreq->odt_pd_arg0,
> > > > > +		      dmcfreq->odt_pd_arg1,
> > > > > +		      ROCKCHIP_SIP_CONFIG_DRAM_SET_ODT_PD,
> > > > > +		      odt_enable, 0, 0, 0, &res);
> > > > 
> > > > Is it necessary/desirable to make this call for every frequency
> > > > change? IIUC it should be only needed when odt_enable changes and the
> > > > driver could track the state. If the DDR frequency doesn't change too
> > > > often and the overhead of the call is small it shouldn't be really
> > > > important though.
> > > >
> > > 
> > > I will test your solution first to make sure there is no regression to
> > > run that call for frequency change only.
> > 
> 
> Oops, I wanted to say when odt_enable changes since last call.
> 
> > If there is no frequency change the function returns at the
> > beginning. My suggestion was to only do the call when 'odt_enable'
> > changes, i.e. when a change (up or down) passes the 'odt_dis_freq'
> > threshold.
> > 
> 
> So, for a reason that I ignore, if we try to save unecessary calls to
> ROCKCHIP_SIP_CONFIG_DRAM_SET_ODT_PD (odt_enable has not changed since
> last call), we get stalled in the call to ROCKCHIP_SIP_CONFIG_SET_RAGE
> that follows. The function arm_smccc_smc never returns and the device
> hard hang.

Thanks for giving it a try!

Did your code ensure to perform the SMC call for the first frequency
change? If not the problem could be that the DDR PD timings and ODT
resistors are not properly configured for the new frequency.

In case you already did this or it doesn't help I think it's fine to
just do the call always, we can always revisit this later.

> Thanks to your remark, I have also fixed an issue with the odt_dis_freq
> value. Its value is initialized to 0 in the probe function. Thus the
> odt_enable is always true (target_rate > 0). I moved its initialization
> after the timings are parsed from the device-tree; its value is now none
> zero (333000000 in my case).

Great!
