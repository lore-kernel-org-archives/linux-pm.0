From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v2 3/5] devfreq: rk3399_dmc: Pass ODT and auto power down
 parameters to TF-A.
Date: Tue, 26 Mar 2019 17:24:41 -0700
Message-ID: <20190327002441.GB112750@google.com>
References: <20190319181323.22804-1-gael.portay@collabora.com>
 <20190319181323.22804-4-gael.portay@collabora.com>
 <20190320003352.GN112750@google.com>
 <20190320215013.43zgvyn5frnb3yud@archlinux.localdomain>
 <20190320220223.GP112750@google.com>
 <20190321231055.j7z23f3k3rcngq4u@archlinux.localdomain>
 <20190322000107.GU112750@google.com>
 <20190322124525.ge5thq4a7c6ufcra@archlinux.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190322124525.ge5thq4a7c6ufcra@archlinux.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?R2HDq2w=?= PORTAY <gael.portay@collabora.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Derek Basehore <dbasehore@chromium.org>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Rob Herring <robh+dt@kernel.org>, Klaus Goger <klaus.goger@theobroma-systems.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-rockchip@lists.infradead.org, Randy Li <ayaka@soulik.info>, kernel@collabora.com, linux-arm-kernel@lists.infradead.org, Lin Huang <hl@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 22, 2019 at 08:45:26AM -0400, Gaël PORTAY wrote:
> Hi Matthias,
> 
> On Thu, Mar 21, 2019 at 05:01:07PM -0700, Matthias Kaehlcke wrote:
> > > ...
> > > 
> > > So, for a reason that I ignore, if we try to save unecessary calls to
> > > ROCKCHIP_SIP_CONFIG_DRAM_SET_ODT_PD (odt_enable has not changed since
> > > last call), we get stalled in the call to ROCKCHIP_SIP_CONFIG_SET_RAGE
> > > that follows. The function arm_smccc_smc never returns and the device
> > > hard hang.
> > 
> > Thanks for giving it a try!
> > 
> > Did your code ensure to perform the SMC call for the first frequency
> > change? If not the problem could be that the DDR PD timings and ODT
> > resistors are not properly configured for the new frequency.
> > 
> 
> The DRAM_ODT_PD SMC call is supposed to be performed before the
> DRAM_SET_RATE; unless someone else is doing the set_rate.

However earlier the call wasn't done at all, and that didn't cause
problems.

> Does the ODT resistors should be configured for every existing
> frequency?

I don't have any background here. My initial assumption would be that
it should be enough to re-configure them when the frequency passes the
threshold in either direction.

Anyway, IIUC there shouldn't be more than 5 frequency changes per
second (polling_ms = 200), and likely no all of them would pass the
threshold, so it seems limiting the calls (if possible) would be a
micro-optimization and is probably not worth the hassle :)

Thanks

Matthias
