From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v2 3/3] arm64: dts: rockchip: add cpu regulator for rk3328 evaluation board
Date: Fri, 25 Aug 2017 11:35:41 +0200
Message-ID: <3733498.rByIbfHvAf@phil>
References: <1503542223-21044-1-git-send-email-cl@rock-chips.com> <1503542223-21044-4-git-send-email-cl@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503542223-21044-4-git-send-email-cl@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: cl@rock-chips.com
Cc: robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, shawnguo@kernel.org, rocky.hao@rock-chips.com, afaerber@suse.de, fabio.estevam@nxp.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, kever.yang@rock-chips.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Am Donnerstag, 24. August 2017, 10:37:03 CEST schrieb cl@rock-chips.com:
> From: Liang Chen <cl@rock-chips.com>
> 
> RK3328 Evaluation Board use rk805 pmic, and one of the DCDCs in
> rk805 is for cpu regulator, assign the cpu regulator, so the
> cpufreq can work fine.
> 
> Signed-off-by: Liang Chen <cl@rock-chips.com>

applied ... but I cannot say if it will still be eligible for 4.14
(late in the cycle). If necessary I'll move it forward a release.

Thanks
Heiko
