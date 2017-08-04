From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH 1/1] cpufreq: imx6q: imx6ull: use PLL1 for frequency
 higher than 528MHz
Date: Fri, 4 Aug 2017 14:17:28 +0300
Message-ID: <1501845448.17254.31.camel@nxp.com>
References: <1501230993-15812-1-git-send-email-sebastien.szymanski@armadeus.com>
         <20170803020320.GG31819@dragon>
         <737b6166-1594-677b-1a08-4f9b795d9410@armadeus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-by2nam03on0069.outbound.protection.outlook.com ([104.47.42.69]:22208
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751304AbdHDLRg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 4 Aug 2017 07:17:36 -0400
In-Reply-To: <737b6166-1594-677b-1a08-4f9b795d9410@armadeus.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?ISO-8859-1?Q?S=E9bastien?= Szymanski <sebastien.szymanski@armadeus.com>, Shawn Guo <shawnguo@kernel.org>, Anson Huang <anson.huang@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Julien Boibessot <julien.boibessot@armadeus.com>, Fabio Estevam <fabio.estevam@nxp.com>, linux-arm-kernel@lists.infradead.org

On Thu, 2017-08-03 at 09:32 +0200, Sébastien Szymanski wrote:
> On 08/03/2017 04:03 AM, Shawn Guo wrote:
> > On Fri, Jul 28, 2017 at 10:36:33AM +0200, Sébastien Szymanski wrote:
> > > Setting the frequency higher than 528Mhz actually sets the ARM
> > > clock to 528MHz. That's because PLL2 is used as the root clock when the
> > > frequency is higher than 396MHz.
> > > 
> > > cpupower frequency-set -f 792000
> > > 
> > > arm_clk_root on the CCM_CLKO2 signal is 528MHz instead of 792MHz.
> > > 
> > > [   61.606383] cpu cpu0: 396 MHz, 1025 mV --> 792 MHz, 1225 mV
> > > 
> > > pll2                         1  1  528000000 0 0
> > >    pll2_bypass               1  1  528000000 0 0
> > >       pll2_bus               3  3  528000000 0 0
> > > 	 ca7_secondary_sel   1  1  528000000 0 0
> > > 	    step             1  1  528000000 0 0
> > > 	       pll1_sw       1  1  528000000 0 0
> > > 		  arm        1  1  528000000 0 0
> > > 
> > > Fixes this by using the PLL1 as the root clock when the frequency is
> > > higher than 528MHz.
> > > 
> > > cpupower frequency-set -f 792000
> > > 
> > > arm_clk_root on the CCM_CLKO2 signal is now 792MHz as expected.
> > > 
> > > [   69.717987] cpu cpu0: 198 MHz, 950 mV --> 792 MHz, 1225 mV
> > > 
> > > pll1               1 1 792000000 0 0
> > >    pll1_bypass     1 1 792000000 0 0
> > >       pll1_sys     1 1 792000000 0 0
> > > 	 pll1_sw   1 1 792000000 0 0
> > > 	    arm    1 1 792000000 0 0
> > > 
> > > Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
> > 
> > Can you please specify on which SoCs you are seeing this problem?  And I
> > would like invite Anson and Leonard to review it.
> 
> My SoC is MCIMX6Y2CVM08AA which is a 792MHz i.MX6ULL. I forgot to
> mention that I added the following operating points in my device tree:
> 
> operating-points: 792000  1225000
> fsl,soc-operating-points: 792000  1175000

Yeah, I was wondering about that.

Adding support for higher imx6ul/ull frequencies "properly" requires adding the extra OPPs to .dtsi (they are different between 6ul and 6ull) and reading the speed grading from OCOTP to check if they are supported.

This patch can only work if you hack OPPs for a specific board.

Reading the speed grading is essential because otherwise you risk causing random crashes while running at frequencies not supported by the hardware.
