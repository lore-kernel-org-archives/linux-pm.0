From: Leo Yan <leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 2/3] thermal: hisilicon: add thermal sensor driver for
 Hi3660
Date: Mon, 4 Sep 2017 23:06:21 +0800
Message-ID: <20170904150621.GC24156@leoy-ThinkPad-T440>
References: <e313015d-11d5-91b8-aa64-37e9410cb882@hisilicon.com>
 <1503994666-13954-1-git-send-email-kevin.wangtao@hisilicon.com>
 <1503994666-13954-3-git-send-email-kevin.wangtao@hisilicon.com>
 <77ceb395-57bb-8de7-7b1a-3218baa5d5f3@linaro.org>
 <b884f2ca-86e1-0df3-0cbf-99b13232ee03@hisilicon.com>
 <8fe3ad22-59db-40c6-18db-7b6859f05a95@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <8fe3ad22-59db-40c6-18db-7b6859f05a95-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "Wangtao (Kevin, Kirin)" <kevin.wangtao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, kevin.wangtao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, sunzhaosheng-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, gengyanping-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Mon, Sep 04, 2017 at 01:06:39PM +0200, Daniel Lezcano wrote:
> 
> Hi Kevin,
> 
> 
> On 04/09/2017 09:56, Wangtao (Kevin, Kirin) wrote:
> > 
> > 
> > 在 2017/9/1 5:17, Daniel Lezcano 写道:
> >>
> >> Hi Kevin,
> >>
> >>
> >> On 29/08/2017 10:17, Tao Wang wrote:
> >>> From: Tao Wang <kevin.wangtao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >>>
> >>> This patch adds the support for thermal sensor of Hi3660 SoC.
> >>
> >> for the Hi3660 SoC thermal sensor.
> >>
> >>> this will register sensors for thermal framework and use device
> >>> tree to bind cooling device.
> >>
> >> Is it possible to give a pointer to some documentation or to describe
> >> the hardware?
> > Yes, there used to be on patch V3, I removed it on V4.
> >>
> >> An explanation of the adc min max coef[] range[] conversion would be
> >> nice.
> > OK
> >>
> >> In addition, having the rational behind the average and the max would be
> >> nice. Do we really need both avg and max as virtual sensor?
> > We only need max currently.
> >>
> >>> Signed-off-by: Tao Wang <kevin.wangtao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >>> Signed-off-by: Leo Yan <leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >>> ---
> >>>   drivers/thermal/Kconfig        |  13 +++
> >>>   drivers/thermal/Makefile       |   1 +
> >>>   drivers/thermal/hisi_tsensor.c | 209
> >>> +++++++++++++++++++++++++++++++++++++++++
> >>
> >>
> >> IMO, we don't need a new file, but merge this code with the current
> >> hisi_thermal.c driver. BTW, the hi6220 has also a tsensor which is
> >> different from this one.
> >>
> >> I suggest to base the hi3660 thermal driver on top of the cleanup I sent
> >> for the hi6220.
> > The tsensor of hi3660 is a different one, merging the code with hi6220
> > will need a lot of change.
> 
> Have a look at the hisi_thermal.c at:
> 
> https://git.linaro.org/people/daniel.lezcano/linux.git/tree/drivers/thermal/hisi_thermal.c?h=thermal/hikey-4.14
> 
> after the cleanup I recently sent.
> 
> I'm pretty sure, with a little effort, we can merge both.
> 
> Especially if the virtual things is separated.
> 
> At the end, what do we do ? Read a register.

Just more input at here. I agree currently Hi3660 thermal driver
is quite similiar with Hi6220, before we wrote a dedicated Hi3660
thermal driver due we used mailbox method rather than shared
memory mode.

If we merge two thermal drivers, this means Hi3660 register layout
should be adjusted as same with Hi6220; I am not sure if this is
feasible and need Kevin to confirm for this.

And does this mean we need provide interrupt mode for Hi3660? Or
we can extend the driver to only support pollig mode?

[...]

Thanks,
Leo Yan
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
