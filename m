From: Feng Xiao <xf@rock-chips.com>
Subject: Re: [PATCH] cpufreq: rockchip: add driver
Date: Mon, 21 Mar 2016 21:24:32 +0800
Message-ID: <56EFF610.6040402@rock-chips.com>
References: <1458303004-26445-1-git-send-email-xf@rock-chips.com>
 <1787319.AFAWVqkdk0@diego> <20160321095049.GD27778@vireshk-i7>
 <1505152.fhSnu3pvDr@diego> <20160321095855.GE27778@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular2.263xmail.com ([211.157.152.3]:51492 "EHLO
	regular2.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754583AbcCUNYW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Mar 2016 09:24:22 -0400
In-Reply-To: <20160321095855.GE27778@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc: linux@arm.linux.org.uk, rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, wxt@rock-chips.com, zyw@rock-chips.com, jay.xu@rock-chips.com, tim.chen@rock-chips.com, xxx@rock-chips.com, huangtao@rock-chips.com, Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>



=E5=9C=A8 2016/3/21 17:58, Viresh Kumar =E5=86=99=E9=81=93:
> On 21-03-16, 10:54, Heiko St=C3=BCbner wrote:
>> I hadn't seen that yet ... nice that cpufreq-dt now also supports cl=
usters :-)
>>
>> The other part still stands though, as we probably should register t=
he
>> platform-device somewhere else and not in some new special module.
>>
>> When everything is using cpufreq-dt now, I guess we could just add i=
t to the
>> core rockchip clk-code. Or was there some agreement where this shoul=
d be done
>> (obviously not the devicetree itself)?
Of_clk_init is called early, and platform_device_register_simple should=
=20
be called after devices_init, it will be failed to do it from clk-code.
So we need add a new file or add module_init to each clock controller=20
driver(like clk-rk3368.c, clk-rk3399.c) ?
> Yeah, there was a discussion around creating a white or black list of=
 platforms
> that want to create a platform device for cpufreq-dt. That can be don=
e in
> cpufreq-dt.c or a new file, but I haven't worked out on that yet.
>
> You can do it from clk-code or from the driver that was added in this=
 thread.
> Just that you need to match your platform's compatible string before =
doing that.
Rockchip-cpufreq.c depends on ARM_ROCKCHIP_CPUFREQ, it will not be=20
compiled on non-Rockchip platforms.
The driver can support all Rockchip SoCs up to now, add=20
of_machine_is_compatible may be redundant ?
>


