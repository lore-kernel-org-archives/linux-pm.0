From: =?utf-8?B?R2HDq2w=?= PORTAY <gael.portay@collabora.com>
Subject: Re: [PATCH v2 3/5] devfreq: rk3399_dmc: Pass ODT and auto power down
 parameters to TF-A.
Date: Fri, 22 Mar 2019 08:45:26 -0400
Message-ID: <20190322124525.ge5thq4a7c6ufcra@archlinux.localdomain>
References: <20190319181323.22804-1-gael.portay@collabora.com>
 <20190319181323.22804-4-gael.portay@collabora.com>
 <20190320003352.GN112750@google.com>
 <20190320215013.43zgvyn5frnb3yud@archlinux.localdomain>
 <20190320220223.GP112750@google.com>
 <20190321231055.j7z23f3k3rcngq4u@archlinux.localdomain>
 <20190322000107.GU112750@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190322000107.GU112750@google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Derek Basehore <dbasehore@chromium.org>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Rob Herring <robh+dt@kernel.org>, Klaus Goger <klaus.goger@theobroma-systems.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-rockchip@lists.infradead.org, Randy Li <ayaka@soulik.info>, kernel@collabora.com, linux-arm-kernel@lists.infradead.org, Lin Huang <hl@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

Hi Matthias,

On Thu, Mar 21, 2019 at 05:01:07PM -0700, Matthias Kaehlcke wrote:
> > ...
> > 
> > So, for a reason that I ignore, if we try to save unecessary calls to
> > ROCKCHIP_SIP_CONFIG_DRAM_SET_ODT_PD (odt_enable has not changed since
> > last call), we get stalled in the call to ROCKCHIP_SIP_CONFIG_SET_RAGE
> > that follows. The function arm_smccc_smc never returns and the device
> > hard hang.
> 
> Thanks for giving it a try!
> 
> Did your code ensure to perform the SMC call for the first frequency
> change? If not the problem could be that the DDR PD timings and ODT
> resistors are not properly configured for the new frequency.
> 

The DRAM_ODT_PD SMC call is supposed to be performed before the
DRAM_SET_RATE; unless someone else is doing the set_rate.

Does the ODT resistors should be configured for every existing
frequency?

> In case you already did this or it doesn't help I think it's fine to
> just do the call always, we can always revisit this later.
> 

Okay, sounds good.

> > Thanks to your remark, I have also fixed an issue with the odt_dis_freq
> > value. Its value is initialized to 0 in the probe function. Thus the
> > odt_enable is always true (target_rate > 0). I moved its initialization
> > after the timings are parsed from the device-tree; its value is now none
> > zero (333000000 in my case).
> 
> Great!

Gael
