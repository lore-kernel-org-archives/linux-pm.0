From: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 0/5] thermal: imx: Add nvmem-cells binding on imx6sx
Date: Wed, 20 Sep 2017 09:40:58 +0800
Message-ID: <1505871658.2571.4.camel@intel.com>
References: <cover.1500041281.git.leonard.crestez@nxp.com>
         <20170831084817.GC3787@dragon> <1504185083.2749.2.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1504185083.2749.2.camel-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Leonard Crestez <leonard.crestez-3arQi8VN3Tc@public.gmane.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Lothar =?ISO-8859-1?Q?Wa=DFmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>, Dong Aisheng <aisheng.dong-3arQi8VN3Tc@public.gmane.org>, Bai Ping <ping.bai-3arQi8VN3Tc@public.gmane.org>, Anson Huang <Anson.Huang-3arQi8VN3Tc@public.gmane.org>, Octavian Purdila <octavian.purdila-3arQi8VN3Tc@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Thu, 2017-08-31 at 21:11 +0800, Zhang Rui wrote:
> On Thu, 2017-08-31 at 16:48 +0800, Shawn Guo wrote:
> > 
> > On Fri, Jul 14, 2017 at 05:11:05PM +0300, Leonard Crestez wrote:
> > > 
> > > 
> > > Leonard Crestez (5):
> > >   thermal: imx: Add nvmem-cells alternate binding for OCOTP
> > > access
> > >   nvmem: core: Add nvmem_cell_read_u32
> > >   thermal: imx: Add support for reading OCOTP through nvmem
> > >   ARM: dts: imx6sx: Use nvmem-cells for tempmon
> > >   ARM: dts: imx6ul: Add imx6ul-tempmon
> > For last two dts patches,
> > 
> > Acked-by: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> thanks.
> I will push patch 1,3,4,5 after patch 2/5 merged.
> 
sorry that this patch set didn't catch this merge window.
I've rebased it on top of 4.14-rc1 and queued for 4.15.

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
