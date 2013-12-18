From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH V3 2/2] cpufreq: imx6q: correct VDDSOC/PU voltage scaling
 when cpufreq is changed
Date: Wed, 18 Dec 2013 22:25:39 +0800
Message-ID: <20131218142536.GM6691@S2101-09.ap.freescale.net>
References: <1387402010-31749-1-git-send-email-b20788@freescale.com>
 <1387402010-31749-2-git-send-email-b20788@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1387402010-31749-2-git-send-email-b20788@freescale.com>
Sender: cpufreq-owner@vger.kernel.org
To: Anson Huang <b20788@freescale.com>
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 18, 2013 at 04:26:50PM -0500, Anson Huang wrote:
> on i.MX6Q, cpu freq change need to follow below flows:
> 
> 1. each setpoint has different VDDARM, VDDSOC/PU voltage, get the setpoint
>    table from dts;
> 2. when cpu freq is scaling up, need to increase VDDSOC/PU voltage before
>    VDDARM, if VDDPU is off, no need to change it;
> 3. when cpu freq is scaling down, need to decrease VDDARM voltage before
>    VDDSOC/PU, if VDDPU is off, no need to change it;
> 
> normally dts will pass vddsoc/pu freq/volt info to kernel, if not, will
> use fixed value for vddsoc/pu voltage setting.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

