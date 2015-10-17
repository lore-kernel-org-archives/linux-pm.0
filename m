From: Rob Clark <robdclark@gmail.com>
Subject: Re: [GIT PULL] On-demand device probing
Date: Sat, 17 Oct 2015 13:54:43 -0400
Message-ID: <CAF6AEGvbYYeZx=YVCv9r5K0xjtLf3gN69gX5DyQ3j0S1qT0Yog@mail.gmail.com>
References: <561E1378.6000906@collabora.com>
	<20151017065750.GA18607@kroah.com>
	<CAL_Jsq+Due3CgV0Z_m4vYQsa+X30DSxgmqz_r=26OrBV7v+H2g@mail.gmail.com>
	<20151017154709.GE4059@kroah.com>
	<CAL_JsqJvtKt6FpZgnYcsEm_opr9gK_a013BVpZGvnB=51oSUXg@mail.gmail.com>
	<20151017165617.GC25156@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20151017165617.GC25156@kroah.com>
Sender: linux-clk-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh+dt@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Russell King <linux@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, =?UTF-8?Q?Terje_Bergstr=C3=B6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>F
List-Id: linux-pm@vger.kernel.org

On Sat, Oct 17, 2015 at 12:56 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>> I'm guessing the time is a matter of probing and undoing the probes
>> rather than slow h/w. We could maybe improve things by making sure
>> drivers move what they defer on to the beginning of probe, but that
>> seems like a horrible, fragile hack.
>
> How can calling probe and failing cause 2 seconds?  How many different
> probe calls are failing here?  Again, a boot log graph would be great to
> see as it will show the root cause, not just guessing at this.


just fwiw, but when you have a driver that depends on several other
drivers (which in turn depend on other drivers and so on), the amount
of probe-defer we end up seeing is pretty comical.  Yeah, there
probably is some room to optimize by juggling around order drivers do
things in probe.  But that doesn't solve the fundamental problem with
the current state, about probe order having no clue about
dependencies..

BR,
-R
