From: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RESEND PATCH 0/6] thermal: sti: Add new Thermal driver
Date: Wed, 09 Jul 2014 21:19:24 +0800
Message-ID: <1404911964.28592.4.camel@rzhang1-toshiba>
References: <1401980819-19962-1-git-send-email-lee.jones@linaro.org>
	 <20140624092309.GD13803@lee--X1> <20140709120823.GA32573@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140709120823.GA32573@lee--X1>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, ajitpal.singh-qxv4g6HH51o@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, maxime.coquelin-qxv4g6HH51o@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Wed, 2014-07-09 at 13:08 +0100, Lee Jones wrote:
> On Tue, 24 Jun 2014, Lee Jones wrote:
> 
> > > I'm re-sending this set, as one of the maintainers' email addresses
> > > is incorrect in the MAINTAINERS file.
> > > 
> > > This patchset adds full support for 2 types of Thermal Controllers
> > > produced by STMicroelectronics.  One is a more traditional memory
> > > mapped variant, the other is controlled solely by system configuration
> > > registers.
> > 
> > Any thing from the Thermal guys? Has this set fallen through the gaps?
> 
> Anything at all?  It's been well over a month now.
> 
Well, for the soc thermal drivers, I'd prefer to take them via Eduardo,
but as we didn't get any feedback from Eduardo, I will take them.

thanks,
rui
> > >  Documentation/devicetree/bindings/thermal/st-thermal.txt |  42 ++++++++++++++++
> > >  arch/arm/boot/dts/stih416.dtsi                           |  18 +++++++
> > >  arch/arm/configs/multi_v7_defconfig                      |   2 +
> > >  drivers/thermal/Kconfig                                  |   5 ++
> > >  drivers/thermal/Makefile                                 |   1 +
> > >  drivers/thermal/st/Kconfig                               |  12 +++++
> > >  drivers/thermal/st/Makefile                              |   3 ++
> > >  drivers/thermal/st/st_thermal.c                          | 313 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > > ++++++++++++++++++++++++++++
> > >  drivers/thermal/st/st_thermal.h                          | 104 ++++++++++++++++++++++++++++++++++++++
> > >  drivers/thermal/st/st_thermal_memmap.c                   | 209 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  drivers/thermal/st/st_thermal_syscfg.c                   | 179 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  11 files changed, 888 insertions(+)
> > > 
> > 
> 


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
