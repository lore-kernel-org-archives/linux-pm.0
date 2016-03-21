From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH] cpufreq: rockchip: add driver
Date: Mon, 21 Mar 2016 16:52:23 +0100
Message-ID: <1677635.LBekym086Y@diego>
References: <1458303004-26445-1-git-send-email-xf@rock-chips.com> <56EFF610.6040402@rock-chips.com> <1971421.XfIKeB8O8v@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:46464 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756044AbcCUPwd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Mar 2016 11:52:33 -0400
In-Reply-To: <1971421.XfIKeB8O8v@diego>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Feng Xiao <xf@rock-chips.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux@arm.linux.org.uk, rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, wxt@rock-chips.com, zyw@rock-chips.com, jay.xu@rock-chips.com, tim.chen@rock-chips.com, xxx@rock-chips.com, huangtao@rock-chips.com, Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>

Am Montag, 21. M=C3=A4rz 2016, 16:13:40 schrieb Heiko St=C3=BCbner:
> Hi,
>=20
> Am Montag, 21. M=C3=A4rz 2016, 21:24:32 schrieb Feng Xiao:
> > =E5=9C=A8 2016/3/21 17:58, Viresh Kumar =E5=86=99=E9=81=93:
> > > On 21-03-16, 10:54, Heiko St=C3=BCbner wrote:
> > >> I hadn't seen that yet ... nice that cpufreq-dt now also support=
s
> > >> clusters :-)
> > >>=20
> > >> The other part still stands though, as we probably should regist=
er the
> > >> platform-device somewhere else and not in some new special modul=
e.
> > >>=20
> > >> When everything is using cpufreq-dt now, I guess we could just a=
dd it
> > >> to
> > >> the core rockchip clk-code. Or was there some agreement where th=
is
> > >> should be done (obviously not the devicetree itself)?
> >=20
> > Of_clk_init is called early, and platform_device_register_simple sh=
ould
> > be called after devices_init, it will be failed to do it from clk-c=
ode.
> > So we need add a new file or add module_init to each clock controll=
er
> > driver(like clk-rk3368.c, clk-rk3399.c) ?
>=20
> as Viresh said, it should be ok to do it like your approach creating =
a
> module in drivers/cpufreq. But the compatible check is necessary.
>=20
> Doing it this way also makes it easier to have

Seem like I forgot the complete my sentence here. This should've been

Doing it this way also makes it easier to have everything go into cpufr=
eq-dt=20
once that whitelist appears that Viresh wrote about. So this might be b=
etter=20
than to distribute this stuff around other subsystems, as I originally=20
suggested.

>=20
> > > Yeah, there was a discussion around creating a white or black lis=
t of
> > > platforms that want to create a platform device for cpufreq-dt. T=
hat can
> > > be done in cpufreq-dt.c or a new file, but I haven't worked out o=
n that
> > > yet.
> > >=20
> > > You can do it from clk-code or from the driver that was added in =
this
> > > thread. Just that you need to match your platform's compatible st=
ring
> > > before doing that.
> >=20
> > Rockchip-cpufreq.c depends on ARM_ROCKCHIP_CPUFREQ, it will not be
> > compiled on non-Rockchip platforms.
> > The driver can support all Rockchip SoCs up to now, add
> > of_machine_is_compatible may be redundant ?
>=20
> Please always keep multiplatform in mind. These days the kernel can b=
e
> compiled for multiple architectures at the same time, so you can have
> support for Rockchip, Exynos, Qualcom and whatever in the same kernel
> image.
>=20
> Therefore a compile-time check is not enough and you need to check th=
e
> actually running machine as well.
>=20
>=20
> Heiko

