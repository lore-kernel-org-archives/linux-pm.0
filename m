From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH] cpufreq: rockchip: add driver
Date: Mon, 21 Mar 2016 16:13:40 +0100
Message-ID: <1971421.XfIKeB8O8v@diego>
References: <1458303004-26445-1-git-send-email-xf@rock-chips.com> <20160321095855.GE27778@vireshk-i7> <56EFF610.6040402@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:46362 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756541AbcCUPN4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Mar 2016 11:13:56 -0400
In-Reply-To: <56EFF610.6040402@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Feng Xiao <xf@rock-chips.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux@arm.linux.org.uk, rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, wxt@rock-chips.com, zyw@rock-chips.com, jay.xu@rock-chips.com, tim.chen@rock-chips.com, xxx@rock-chips.com, huangtao@rock-chips.com, Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>

Hi,

Am Montag, 21. M=C3=A4rz 2016, 21:24:32 schrieb Feng Xiao:
> =E5=9C=A8 2016/3/21 17:58, Viresh Kumar =E5=86=99=E9=81=93:
> > On 21-03-16, 10:54, Heiko St=C3=BCbner wrote:
> >> I hadn't seen that yet ... nice that cpufreq-dt now also supports
> >> clusters :-)
> >>=20
> >> The other part still stands though, as we probably should register=
 the
> >> platform-device somewhere else and not in some new special module.
> >>=20
> >> When everything is using cpufreq-dt now, I guess we could just add=
 it to
> >> the core rockchip clk-code. Or was there some agreement where this
> >> should be done (obviously not the devicetree itself)?
>=20
> Of_clk_init is called early, and platform_device_register_simple shou=
ld
> be called after devices_init, it will be failed to do it from clk-cod=
e.
> So we need add a new file or add module_init to each clock controller
> driver(like clk-rk3368.c, clk-rk3399.c) ?

as Viresh said, it should be ok to do it like your approach creating a =
module=20
in drivers/cpufreq. But the compatible check is necessary.

Doing it this way also makes it easier to have

> > Yeah, there was a discussion around creating a white or black list =
of
> > platforms that want to create a platform device for cpufreq-dt. Tha=
t can
> > be done in cpufreq-dt.c or a new file, but I haven't worked out on =
that
> > yet.
> >=20
> > You can do it from clk-code or from the driver that was added in th=
is
> > thread. Just that you need to match your platform's compatible stri=
ng
> > before doing that.
> Rockchip-cpufreq.c depends on ARM_ROCKCHIP_CPUFREQ, it will not be
> compiled on non-Rockchip platforms.
> The driver can support all Rockchip SoCs up to now, add
> of_machine_is_compatible may be redundant ?

Please always keep multiplatform in mind. These days the kernel can be=20
compiled for multiple architectures at the same time, so you can have s=
upport=20
for Rockchip, Exynos, Qualcom and whatever in the same kernel image.

Therefore a compile-time check is not enough and you need to check the=20
actually running machine as well.


Heiko
