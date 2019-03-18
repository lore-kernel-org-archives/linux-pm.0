From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] clk: mvebu: armada-37xx-periph: Fix initialization for
 cpu clocks
Date: Mon, 18 Mar 2019 14:21:13 +0200
Message-ID: <20190318122113.GA4834@apalos>
References: <20190313163558.6705-1-gregory.clement@bootlin.com>
 <20190314121541.GB19385@apalos>
 <CAC5LXJcCs4nr-qFOWzUJpUBAJ9ngG-cgeTCVCFBKFc1SPzHMuQ@mail.gmail.com>
 <20190314134428.GA24768@apalos>
 <874l85v8p6.fsf@FE-laptop>
 <20190318112844.GA1708@apalos>
 <87h8c0s955.fsf@FE-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87h8c0s955.fsf@FE-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Christian Neubert <christian.neubert.86@gmail.com>, Stephen Boyd <sboyd@codeaurora.org>, Mike Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-arm-kernel@lists.infradead.org, Antoine Tenart <antoine.tenart@bootlin.com>, =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Gregory, 

> >> 
> > [   14.909524] clk_pm_cpu_set_parent old=28004840 -> val=0x6000000 load_level=0
> > [   14.916424] clk_pm_cpu_set_parent old=2E004840 -> val=0x600 load_level=1
> > [   14.923315] clk_pm_cpu_set_parent old=8880A8C0 -> val=0x6000000 load_level=2
> > [   14.930572] clk_pm_cpu_set_parent old=8E80A8C0 -> val=0x600 load_level=3
> >
> >
> > Let me know if you need anything else
> 
> Could you show me the output of "cat /sys/kernel/debug/clk/clk_summary"
> 
root@localhost ~ # cat /sys/kernel/debug/clk/clk_summary
                                 enable  prepare  protect                                duty
   clock                          count    count    count        rate   accuracy phase  cycle
---------------------------------------------------------------------------------------------
 xtal                                 2        3        0    25000000          0     0  50000
    i2c_1                             0        0        0    25000000          0     0  50000
    i2c_2                             0        0        0    25000000          0     0  50000
    avs                               0        0        0    25000000          0     0  50000
    TBG-B-S                           2        2        0  1000000000          0     0  50000
       cpu                            0        0        0   200000000          0     0  50000
       usb32_ss_sys                   1        1        0   125000000          0     0  50000
       usb32_usb2_sys                 0        0        0   100000000          0     0  50000
       gbe_125                        0        0        0   125000000          0     0  50000
          gbe0_125                    0        0        0   125000000          0     0  50000
          gbe1_125                    0        0        0   125000000          0     0  50000
       gbe_core                       1        1        0   250000000          0     0  50000
          gbe_bm                      0        0        0   250000000          0     0  50000
          gbe0_core                   1        1        0   250000000          0     0  50000
          gbe1_core                   0        0        0   250000000          0     0  50000
       eip97                          0        0        0   500000000          0     0  50000
       trace                          0        0        0  1000000000          0     0  50000
       ddr_fclk                       0        0        0   125000000          0     0  50000
       pwm                            0        0        0    50000000          0     0  50000
       tscem_tmx                      0        0        0  1000000000          0     0  50000
       sec_dap                        0        0        0   100000000          0     0  50000
       sec_at                         0        0        0   200000000          0     0  50000
    TBG-A-S                           0        0        0  1600000000          0     0  50000
       sdio                           0        0        0   400000000          0     0  50000
       ddr_phy                        0        0        0   400000000          0     0  50000
       mmc                            0        0        0   400000000          0     0  50000
    TBG-B-P                           0        0        0   500000000          0     0  50000
       gbe_50                         0        0        0    50000000          0     0  50000
          gbe0_50                     0        0        0    50000000          0     0  50000
          gbe1_50                     0        0        0    50000000          0     0  50000
    TBG-A-P                           0        1        0   800000000          0     0  50000
       counter                        0        0        0   160000000          0     0  50000
       sqf                            0        1        0   200000000          0     0  50000
       tscem                          0        0        0   200000000          0     0  50000
       sata_host                      0        0        0   200000000          0     0  50000
root@localhost ~ # 

> Also, during this week-end, Christian suggested that the issue might
> come from the AVS support.
> 
> Could you disable it and check you still have the issue?
> 
> For this, you just have to remove the avs node in
> arch/arm64/boot/dts/marvell/armada-37xx.dtsi and rebuild the dtb.
Sure. You'll have to wait for a week though. Currently on a trip. I'll run that
 once i return


Cheers
/Ilias
