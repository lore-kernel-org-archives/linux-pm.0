From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: rockchip: add driver
Date: Mon, 21 Mar 2016 15:20:49 +0530
Message-ID: <20160321095049.GD27778@vireshk-i7>
References: <1458303004-26445-1-git-send-email-xf@rock-chips.com>
 <1787319.AFAWVqkdk0@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34146 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281AbcCUJux (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Mar 2016 05:50:53 -0400
Received: by mail-pf0-f180.google.com with SMTP id x3so258926935pfb.1
        for <linux-pm@vger.kernel.org>; Mon, 21 Mar 2016 02:50:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1787319.AFAWVqkdk0@diego>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: Feng Xiao <xf@rock-chips.com>, linux@arm.linux.org.uk, rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, wxt@rock-chips.com, zyw@rock-chips.com, jay.xu@rock-chips.com, tim.chen@rock-chips.com, xxx@rock-chips.com, huangtao@rock-chips.com, Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>

On 18-03-16, 13:56, Heiko St=FCbner wrote:
> Also, on both the rk3368 as well as the rk3399, you probably want the=
 cluster-
> handling of arm-bL-cpufreq-dt.
> Contrary to its name it is _not_ limited to switching between cluster=
s, but=20
> can also control frequencies of multiple cpu-clusters running at the =
same=20
> time.

We aren't adding any new users to bL driver, please use cpufreq-dt as t=
hat also
supports multiple clusters now.

--=20
viresh
