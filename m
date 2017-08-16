From: Leonard Crestez <leonard.crestez-3arQi8VN3Tc@public.gmane.org>
Subject: Re: [PATCH v2 3/5] thermal: imx: Add support for reading OCOTP
 through nvmem
Date: Wed, 16 Aug 2017 18:33:41 +0300
Message-ID: <1502897621.23210.41.camel@nxp.com>
References: <cover.1500041281.git.leonard.crestez@nxp.com>
         <faf9c3e5f970b9609073c4c191a7af03d647ea51.1500041281.git.leonard.crestez@nxp.com>
         <20170725080835.GD20064@dragon> <1502176915.4296.1.camel@intel.com>
         <26407dd5-a9b1-67c0-c4ab-d97fa0b88b79@linaro.org>
         <1502192287.24350.9.camel@nxp.com>
         <9732c524-fbdc-d1be-cd03-089dbb2266c4@linaro.org>
         <1502197100.4296.45.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1502197100.4296.45.camel-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Lothar =?ISO-8859-1?Q?Wa=DFmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>, Dong Aisheng <aisheng.dong-3arQi8VN3Tc@public.gmane.org>, Bai Ping <ping.bai-3arQi8VN3Tc@public.gmane.org>, Anson Huang <Anson.Huang-3arQi8VN3Tc@public.gmane.org>, Octavian Purdila <octavian.purdila-3arQi8VN3Tc@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2017-08-08 at 20:58 +0800, Zhang Rui wrote:
> On Tue, 2017-08-08 at 12:44 +0100, Srinivas Kandagatla wrote:
> > On 08/08/17 12:38, Leonard Crestez wrote:
> > > On Tue, 2017-08-08 at 12:00 +0100, Srinivas Kandagatla wrote:
> > > > On 08/08/17 08:21, Zhang Rui wrote:

> > > > > I'm okay with the thermal change.
> > > > > We still need ACK for the nvmem changes in this patch series.

> > > > NVMEM changes are already sent to Greg K H with other patches
> > > > https://lkml.org/lkml/2017/8/8/436, should appear in next.

> > > These patches have a compile-time dependency on each other.
> > > Wouldn't it make more sense for the whole series to go through a single
> > > maintainer tree, atomically? Most of the changes are in driver/thermal.

> > I was expecting that the nvmem change go in as fix in a rc release
> > so that you could apply the other patches after that.
> > 
> > Let me ping Greg about this!!

> As Shawn is okay with patch 4/5 and 5/5, I guess I can queue patch 1/5,
> 3/5, 4/5, 5/5 for 4.14-rc1, if the nvmem patch can catch 4.13, or I can
> queue the full patch set for 4.14, with Srinivas' ACK.

It's been a week since the last email and it seems that nothing
happened. I can't find any of these patches in either torvalds/master
or linux-next. It seems to me that the nvmem series linked above was
not picked up after all?

It's not clear how to proceed. It's been more a month since the series
was sent so maybe I should resend it but it's not clear who would pick
it up.

--
Regards,
Leonard
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
