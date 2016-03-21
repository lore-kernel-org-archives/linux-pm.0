From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH] cpufreq: rockchip: add driver
Date: Mon, 21 Mar 2016 10:54:44 +0100
Message-ID: <1505152.fhSnu3pvDr@diego>
References: <1458303004-26445-1-git-send-email-xf@rock-chips.com> <1787319.AFAWVqkdk0@diego> <20160321095049.GD27778@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:44928 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752002AbcCUJy5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Mar 2016 05:54:57 -0400
In-Reply-To: <20160321095049.GD27778@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Feng Xiao <xf@rock-chips.com>, linux@arm.linux.org.uk, rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, wxt@rock-chips.com, zyw@rock-chips.com, jay.xu@rock-chips.com, tim.chen@rock-chips.com, xxx@rock-chips.com, huangtao@rock-chips.com, Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>

Am Montag, 21. M=E4rz 2016, 15:20:49 schrieb Viresh Kumar:
> On 18-03-16, 13:56, Heiko St=FCbner wrote:
> > Also, on both the rk3368 as well as the rk3399, you probably want t=
he
> > cluster- handling of arm-bL-cpufreq-dt.
> > Contrary to its name it is _not_ limited to switching between clust=
ers,
> > but
> > can also control frequencies of multiple cpu-clusters running at th=
e same
> > time.
>=20
> We aren't adding any new users to bL driver, please use cpufreq-dt as=
 that
> also supports multiple clusters now.

I hadn't seen that yet ... nice that cpufreq-dt now also supports clust=
ers :-)

The other part still stands though, as we probably should register the=20
platform-device somewhere else and not in some new special module.

When everything is using cpufreq-dt now, I guess we could just add it t=
o the=20
core rockchip clk-code. Or was there some agreement where this should b=
e done=20
(obviously not the devicetree itself)?
