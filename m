From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v2 2/3] cpufreq: rockchip: add support for rk3328 soc
Date: Fri, 25 Aug 2017 11:29:55 +0200
Message-ID: <1648103.UpmdRsUd1Z@phil>
References: <1503542223-21044-1-git-send-email-cl@rock-chips.com> <1503542223-21044-3-git-send-email-cl@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:60820 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754497AbdHYJaO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 25 Aug 2017 05:30:14 -0400
In-Reply-To: <1503542223-21044-3-git-send-email-cl@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: cl@rock-chips.com
Cc: robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, shawnguo@kernel.org, rocky.hao@rock-chips.com, afaerber@suse.de, fabio.estevam@nxp.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, kever.yang@rock-chips.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org

Hi,

Am Donnerstag, 24. August 2017, 10:37:02 CEST schrieb cl@rock-chips.com:
> From: Liang Chen <cl@rock-chips.com>
> 
> Add compatible rockchip,rk3328 to the machines table to
> launch cpufreq-dt driver for rk3328 soc.
> 
> Signed-off-by: Liang Chen <cl@rock-chips.com>

this already got added some days ago by a patch from Finley [0]


Heiko

[0] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=319af40a0053fea2ecadcf10bef7e796c91ea8c0
