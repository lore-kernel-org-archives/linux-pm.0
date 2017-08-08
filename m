From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v2 3/5] thermal: imx: Add support for reading OCOTP
 through nvmem
Date: Tue, 08 Aug 2017 20:58:20 +0800
Message-ID: <1502197100.4296.45.camel@intel.com>
References: <cover.1500041281.git.leonard.crestez@nxp.com>
         <faf9c3e5f970b9609073c4c191a7af03d647ea51.1500041281.git.leonard.crestez@nxp.com>
         <20170725080835.GD20064@dragon> <1502176915.4296.1.camel@intel.com>
         <26407dd5-a9b1-67c0-c4ab-d97fa0b88b79@linaro.org>
         <1502192287.24350.9.camel@nxp.com>
         <9732c524-fbdc-d1be-cd03-089dbb2266c4@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9732c524-fbdc-d1be-cd03-089dbb2266c4@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Leonard Crestez <leonard.crestez@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Lothar =?ISO-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>, Dong Aisheng <aisheng.dong@nxp.com>, Bai Ping <ping.bai@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Octavian Purdila <octavian.purdila@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 2017-08-08 at 12:44 +0100, Srinivas Kandagatla wrote:
> > 


> 
> On 08/08/17 12:38, Leonard Crestez wrote:
> > 
> > On Tue, 2017-08-08 at 12:00 +0100, Srinivas Kandagatla wrote:
> > > 
> > > On 08/08/17 08:21, Zhang Rui wrote:
> > > > 
> > > > On Tue, 2017-07-25 at 16:08 +0800, Shawn Guo wrote:
> > > > > 
> > > > > On Fri, Jul 14, 2017 at 05:11:08PM +0300, Leonard Crestez
> > > > > wrote:
> > > 
> > > > 
> > > > > 
> > > > > > 
> > > > > > On newer imx SOCs accessing OCOTP directly is wrong because
> > > > > > the
> > > > > > ocotp clock
> > > > > > needs to be enabled first. Add support for reading those
> > > > > > same
> > > > > > values through
> > > > > > the nvmem API instead.
> > > > > > 
> > > > > > The older path is preserved for compatibility with older
> > > > > > dts and
> > > > > > because it
> > > > > > works correctly on imx6qdl chips.
> > > > > > 
> > > > > > Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> > > > > Acked-by: Shawn Guo <shawnguo@kernel.org>
> > > 
> > > > 
> > > > I'm okay with the thermal change.
> > > > We still need ACK for the nvmem changes in this patch series.
> > > 
> > > NVMEM changes are already sent to Greg K H with other patches
> > > (https://lkml.org/lkml/2017/7/26/164), should appear in next.
> > These patches have a compile-time dependency on each other.
> > Wouldn't it
> > make more sense for the whole series to go through a single
> > maintainer
> > tree, atomically? Most of the changes are in driver/thermal.
> I was expecting that the nvmem change go in as fix in a rc release
> so 
> that you could apply the other patches after that.
> 
> Let me ping Greg about this!!

As Shawn is okay with patch 4/5 and 5/5, I guess I can queue patch 1/5,
3/5, 4/5, 5/5 for 4.14-rc1, if the nvmem patch can catch 4.13, or I can
queue the full patch set for 4.14, with Srinivas' ACK.

thanks,
rui
> > 
> > I'm really very confused about how series that touch multiple areas
> > are
> > applied. It seems to be a mostly ad-hoc process.
> > 
> > --
> > Regards,
> > Leonard
> > 
