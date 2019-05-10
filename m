From: Niklas =?iso-8859-1?Q?S=F6derlund?=
        <niklas.soderlund@ragnatech.se>
Subject: Re: [PATCH v4 0/2] thermal: rcar_gen3_thermal: fix IRQ issues
Date: Fri, 10 May 2019 13:36:08 +0200
Message-ID: <20190510113608.GD28561@bigcity.dyn.berto.se>
References: <20190424051145.23072-1-jiada_wang@mentor.com>
 <20190507235403.GA24112@bigcity.dyn.berto.se>
 <20190510104231.GA15836@vmlxhi-102.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190510104231.GA15836@vmlxhi-102.adit-jv.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eugeniu Rosca <erosca@de.adit-jv.com>
Cc: Jiada Wang <jiada_wang@mentor.com>, rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, horms+renesas@verge.net.au, geert+renesas@glider.be, sergei.shtylyov@cogentembedded.com, marek.vasut+renesas@gmail.com, kuninori.morimoto.gx@renesas.com, hien.dang.eb@renesas.com, fabrizio.castro@bp.renesas.com, dien.pham.ry@renesas.com, biju.das@bp.renesas.com, george_davis@mentor.com, joshua_frkuska@mentor.com, Eugeniu Rosca <roscaeugeniu@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Eugeniu,

On 2019-05-10 12:42:31 +0200, Eugeniu Rosca wrote:
> Hi Niklas,
> 
> On Wed, May 08, 2019 at 01:54:03AM +0200, Niklas Söderlund wrote:
> > Hi Jiada,
> [..]
> > I really like this series, nice work.
> > 
> > Tested-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> > Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> 
> Is there anything off-the-shelf available for testing the rcar3
> thermal driver, to avoid reinventing the wheel via
> https://patchwork.kernel.org/cover/10913163/#22602335

Not that I know of, unfortunately :-(

I have a private home hacked testing framework (don't we all?) based on 
tcl+expect where I have two basic tests for rcar_gen3_thermal. I'm 
willing to share the tests if you by chance want them, but be warned 
that they are highly specialised for my needs and I'm reluctant to 
publish my whole hack tool as it just a ugly hack ;-)

On a high level the tests I have are

1. thermal-load
    Generates load on target and observes the temperature is increased 
    using the /sys/class/thermal/thermal_zone*/temp" interface. This 
    seems similar to the test case your reference using stress-ng.

2. thermal-cooling
    Emulate the passive trip point temperatures using the 
    /sys/class/thermal/*/emul_temp interface and observe that the 
    specified cooling state is achieved.

I should add a third test to make sure IRQ fires but this is just a pet 
project for me so maybe I will get around to it sometime...

If you know of anything around to test thermal drivers or if you create 
something please let me know so I can add it to my tests. And let me 
know if you want my hacks for inspiration for your own testing.

-- 
Regards,
Niklas Söderlund
