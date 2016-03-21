From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: rockchip: add driver
Date: Mon, 21 Mar 2016 15:28:55 +0530
Message-ID: <20160321095855.GE27778@vireshk-i7>
References: <1458303004-26445-1-git-send-email-xf@rock-chips.com>
 <1787319.AFAWVqkdk0@diego>
 <20160321095049.GD27778@vireshk-i7>
 <1505152.fhSnu3pvDr@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33714 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635AbcCUJ66 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Mar 2016 05:58:58 -0400
Received: by mail-pf0-f182.google.com with SMTP id 4so128228363pfd.0
        for <linux-pm@vger.kernel.org>; Mon, 21 Mar 2016 02:58:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1505152.fhSnu3pvDr@diego>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: Feng Xiao <xf@rock-chips.com>, linux@arm.linux.org.uk, rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, wxt@rock-chips.com, zyw@rock-chips.com, jay.xu@rock-chips.com, tim.chen@rock-chips.com, xxx@rock-chips.com, huangtao@rock-chips.com, Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>

On 21-03-16, 10:54, Heiko St=FCbner wrote:
> I hadn't seen that yet ... nice that cpufreq-dt now also supports clu=
sters :-)
>=20
> The other part still stands though, as we probably should register th=
e=20
> platform-device somewhere else and not in some new special module.
>=20
> When everything is using cpufreq-dt now, I guess we could just add it=
 to the=20
> core rockchip clk-code. Or was there some agreement where this should=
 be done=20
> (obviously not the devicetree itself)?

Yeah, there was a discussion around creating a white or black list of p=
latforms
that want to create a platform device for cpufreq-dt. That can be done =
in
cpufreq-dt.c or a new file, but I haven't worked out on that yet.

You can do it from clk-code or from the driver that was added in this t=
hread.
Just that you need to match your platform's compatible string before do=
ing that.

--=20
viresh
