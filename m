From: Rob Clark <robdclark@gmail.com>
Subject: Re: [GIT PULL] On-demand device probing
Date: Sat, 17 Oct 2015 14:45:34 -0400
Message-ID: <CAF6AEGuvr6XMMufY0iDCSkp2BNcWa2=xUxjN66+FtQ6ygS-nyQ@mail.gmail.com>
References: <561E1378.6000906@collabora.com>
	<20151017065750.GA18607@kroah.com>
	<CAL_Jsq+Due3CgV0Z_m4vYQsa+X30DSxgmqz_r=26OrBV7v+H2g@mail.gmail.com>
	<20151017154709.GE4059@kroah.com>
	<CAL_JsqJvtKt6FpZgnYcsEm_opr9gK_a013BVpZGvnB=51oSUXg@mail.gmail.com>
	<20151017165617.GC25156@kroah.com>
	<CAF6AEGvbYYeZx=YVCv9r5K0xjtLf3gN69gX5DyQ3j0S1qT0Yog@mail.gmail.com>
	<20151017182755.GA28072@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20151017182755.GA28072@kroah.com>
Sender: linux-clk-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh+dt@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Russell King <linux@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, =?UTF-8?Q?Terje_Bergstr=C3=B6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>F
List-Id: linux-pm@vger.kernel.org

On Sat, Oct 17, 2015 at 2:27 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Sat, Oct 17, 2015 at 01:54:43PM -0400, Rob Clark wrote:
>> On Sat, Oct 17, 2015 at 12:56 PM, Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>> >> I'm guessing the time is a matter of probing and undoing the probes
>> >> rather than slow h/w. We could maybe improve things by making sure
>> >> drivers move what they defer on to the beginning of probe, but that
>> >> seems like a horrible, fragile hack.
>> >
>> > How can calling probe and failing cause 2 seconds?  How many different
>> > probe calls are failing here?  Again, a boot log graph would be great to
>> > see as it will show the root cause, not just guessing at this.
>>
>>
>> just fwiw, but when you have a driver that depends on several other
>> drivers (which in turn depend on other drivers and so on), the amount
>> of probe-defer we end up seeing is pretty comical.  Yeah, there
>> probably is some room to optimize by juggling around order drivers do
>> things in probe.  But that doesn't solve the fundamental problem with
>> the current state, about probe order having no clue about
>> dependencies..
>
> I can imagine it is a lot of iterations, but how long does it really
> take?  How many different devices are involved that it takes multiple
> loops in order to finally work out the correct order?  Where is the time
> delays here, just calling probe() and having it instantly return
> shouldn't take all that long.

offhand, I think the dependencies go at *least* three levels deep..
I'd say, from memory, I see drm/msm taking at least 5 or 6 tries to
get all the way through requesting it's various different
regulators/clks/gpios.  I hadn't really paid attention to how many
tries the drivers I depend on go through.  (Of those, I take clks from
two different clk drivers (which have dependency on a 3rd clk driver),
and regulators and gpio's come from at least two places, which in turn
have dependencies on clks, etc.)  I don't have really good hard
numbers handy (since my observations of this are w/ console over uart
which effects timings, and so I see it taking much longer than 2sec)..
but the 2sec figure that Tomeu mentioned seemed pretty plausible to
me.

I can try to get better #'s... I should have my kernel hat on at least
some of the time next week.. but the 2sec figure didn't seem
unrealistic to me.

Just as an aside, the amount of probe-defer adds quite a lot of noise
when you are trying to debug why some driver doesn't probe
successfully.  Which itself would be a nice reason to do something
more clever..

BR,
-R


> thanks,
>
> greg k-h
