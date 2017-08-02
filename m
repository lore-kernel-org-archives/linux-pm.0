From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/1] cpufreq: imx6q: imx6ull: use PLL1 for frequency
 higher than 528MHz
Date: Wed, 2 Aug 2017 09:19:51 +0530
Message-ID: <20170802034951.GA31169@vireshk-i7>
References: <1501230993-15812-1-git-send-email-sebastien.szymanski@armadeus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:35988 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751696AbdHBDty (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Aug 2017 23:49:54 -0400
Received: by mail-pg0-f46.google.com with SMTP id v77so10300981pgb.3
        for <linux-pm@vger.kernel.org>; Tue, 01 Aug 2017 20:49:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1501230993-15812-1-git-send-email-sebastien.szymanski@armadeus.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>, =?iso-8859-1?Q?S=E9bastien?= Szymanski <sebastien.szymanski@armadeus.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Fabio Estevam <fabio.estevam@nxp.com>, Julien Boibessot <julien.boibessot@armadeus.com>

On 28-07-17, 10:36, Sébastien Szymanski wrote:
> Setting the frequency higher than 528Mhz actually sets the ARM
> clock to 528MHz. That's because PLL2 is used as the root clock when the
> frequency is higher than 396MHz.
> 
> cpupower frequency-set -f 792000
> 
> arm_clk_root on the CCM_CLKO2 signal is 528MHz instead of 792MHz.
> 
> [   61.606383] cpu cpu0: 396 MHz, 1025 mV --> 792 MHz, 1225 mV
> 
> pll2                         1  1  528000000 0 0
>    pll2_bypass               1  1  528000000 0 0
>       pll2_bus               3  3  528000000 0 0
> 	 ca7_secondary_sel   1  1  528000000 0 0
> 	    step             1  1  528000000 0 0
> 	       pll1_sw       1  1  528000000 0 0
> 		  arm        1  1  528000000 0 0
> 
> Fixes this by using the PLL1 as the root clock when the frequency is
> higher than 528MHz.
> 
> cpupower frequency-set -f 792000
> 
> arm_clk_root on the CCM_CLKO2 signal is now 792MHz as expected.
> 
> [   69.717987] cpu cpu0: 198 MHz, 950 mV --> 792 MHz, 1225 mV
> 
> pll1               1 1 792000000 0 0
>    pll1_bypass     1 1 792000000 0 0
>       pll1_sys     1 1 792000000 0 0
> 	 pll1_sw   1 1 792000000 0 0
> 	    arm    1 1 792000000 0 0
> 
> Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Looks fine to me:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

@Shawn: Can you also confirm if this looks fine to you ?

-- 
viresh
