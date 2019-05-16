From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: next/master boot bisection: next-20190514 on rk3288-veyron-jaq
Date: Thu, 16 May 2019 14:38:52 -0700
Message-ID: <CAD=FV=WDjUBvwoAaWNOmXPaLpZCccpAgRWDzRSnvsQ62TFwVmQ@mail.gmail.com>
References: <5cdae78b.1c69fb81.a32a9.870f@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <5cdae78b.1c69fb81.a32a9.870f-ATjtLOhZ0NVl57MIdRCFDg@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: "kernelci.org bot" <bot-ssFOTAMYnuFg9hUCZPvPmw@public.gmane.org>
Cc: Elaine Zhang <zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Guillaume Tucker <guillaume.tucker-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, mgalka-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, matthew.hart-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi,

From: kernelci.org bot <bot-ssFOTAMYnuFg9hUCZPvPmw@public.gmane.org>
Date: Tue, May 14, 2019 at 9:06 AM
To: <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, <guillaume.tucker-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>,
<mgalka-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
<matthew.hart-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>,
<enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Elaine Zhang, Eduardo Valentin, Daniel
Lezcano
Cc: Heiko Stuebner, <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
Zhang Rui, <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>

> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> * This automated bisection report was sent to you on the basis  *
> * that you may be involved with the breaking commit it has      *
> * found.  No manual investigation has been done to verify it,   *
> * and the root cause of the problem may be somewhere else.      *
> * Hope this helps!                                              *
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>
> next/master boot bisection: next-20190514 on rk3288-veyron-jaq
>
> Summary:
>   Start:      0a13f187b16a Add linux-next specific files for 20190514
>   Details:    https://kernelci.org/boot/id/5cda7f2259b514876d7a3628
>   Plain log:  https://storage.kernelci.org//next/master/next-20190514/arm/multi_v7_defconfig+CONFIG_EFI=y+CONFIG_ARM_LPAE=y/gcc-8/lab-collabora/boot-rk3288-veyron-jaq.txt
>   HTML log:   https://storage.kernelci.org//next/master/next-20190514/arm/multi_v7_defconfig+CONFIG_EFI=y+CONFIG_ARM_LPAE=y/gcc-8/lab-collabora/boot-rk3288-veyron-jaq.html
>   Result:     691d4947face thermal: rockchip: fix up the tsadc pinctrl setting error
>
> Checks:
>   revert:     PASS
>   verify:     PASS
>
> Parameters:
>   Tree:       next
>   URL:        git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>   Branch:     master
>   Target:     rk3288-veyron-jaq
>   CPU arch:   arm
>   Lab:        lab-collabora
>   Compiler:   gcc-8
>   Config:     multi_v7_defconfig+CONFIG_EFI=y+CONFIG_ARM_LPAE=y
>   Test suite: boot
>
> Breaking commit found:
>
> -------------------------------------------------------------------------------
> commit 691d4947faceb8bd841900049e07c81c95ca4b0d
> Author: Elaine Zhang <zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> Date:   Tue Apr 30 18:09:44 2019 +0800
>
>     thermal: rockchip: fix up the tsadc pinctrl setting error
>
>     Explicitly use the pinctrl to set/unset the right mode
>     instead of relying on the pinctrl init mode.
>     And it requires setting the tshut polarity before select pinctrl.
>
>     When the temperature sensor mode is set to 0, it will automatically
>     reset the board via the Clock-Reset-Unit (CRU) if the over temperature
>     threshold is reached. However, when the pinctrl initializes, it does a
>     transition to "otp_out" which may lead the SoC restart all the time.
>
>     "otp_out" IO may be connected to the RESET circuit on the hardware.
>     If the IO is in the wrong state, it will trigger RESET.
>     (similar to the effect of pressing the RESET button)
>     which will cause the soc to restart all the time.
>
>     Signed-off-by: Elaine Zhang <zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>     Reviewed-by: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>     Signed-off-by: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

I can confirm that the above commit breaks my jerry, though I haven't
dug into the details.  :(  Is anyone fixing?  For now I'm just booting
with the revert.


-Doug
