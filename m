From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [GIT PULL] On-demand device probing
Date: Sat, 17 Oct 2015 11:28:29 -0500
Message-ID: <CAL_JsqJvtKt6FpZgnYcsEm_opr9gK_a013BVpZGvnB=51oSUXg@mail.gmail.com>
References: <561E1378.6000906@collabora.com> <20151017065750.GA18607@kroah.com>
 <CAL_Jsq+Due3CgV0Z_m4vYQsa+X30DSxgmqz_r=26OrBV7v+H2g@mail.gmail.com> <20151017154709.GE4059@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20151017154709.GE4059@kroah.com>
Sender: linux-clk-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Russell King <linux@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, =?UTF-8?Q?Terje_Bergstr=C3=B6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Felipe Balbi <balbi@ti.com>, Jingoo
List-Id: linux-pm@vger.kernel.org

On Sat, Oct 17, 2015 at 10:47 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Sat, Oct 17, 2015 at 10:04:55AM -0500, Rob Herring wrote:
>> On Sat, Oct 17, 2015 at 1:57 AM, Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>> > On Wed, Oct 14, 2015 at 10:34:00AM +0200, Tomeu Vizoso wrote:
>> >> Hi Rob,
>> >>
>> >> here is the pull request you asked for, with no changes from the version
>> >> that I posted last to the list.
>> >>
>> >> The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:
>> >>
>> >> Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)
>> >>
>> >> are available in the git repository at:
>> >>
>> >> git+ssh://git.collabora.co.uk/git/user/tomeu/linux.git
>> >> on-demand-probes-for-next
>> >
>> > That's not a signed tag :(
>> >
>> > Anyway, I REALLY don't like this series (sorry for the delay in
>> > reviewing them, normally I trust Rob's judgement...)
>>
>> We've seen a lot of attempts here. This is really the best solution so
>> far in that it is simple, uses existing data from DT, and was low risk
>> for breaking platforms (at least I thought it would be). Anyway,
>> getting more exposure is why I've put it into -next.
>
> Exposure is good, now we know it breaks some builds, which was useful :)

Now that I've looked at them, they are somewhat questionable failures.
They do show the fragile nature of probe ordering and the implicit
dependencies we have.

>> > I can't see adding calls like this all over the tree just to solve a
>> > bus-specific problem, you are adding of_* calls where they aren't
>> > needed, or wanted, at all.
>>
>> I think Linus W, Mark B, and I all said a similar thing initially in
>> that dependencies should be handled in the driver core. We went down
>> the path of making this not firmware (aka bus) specific and an earlier
>> version had just that (with fwnode_* calls). That turned out to be
>> pointless as the calling locations were almost always in DT specific
>> code anyway. If you notice, the calls are next to other DT specific
>> calls generally (usually a "get"). So yes, I'd prefer not to have to
>> touch every subsystem, but we had to do that anyway to add DT support.
>
> If they are "next" to a call like that, why not put it in that call?  I
> really object to having to "sprinkle" this all over the kernel, for no
> obvious reason why that is happening at all (look at the USB patch for
> one such example.)

Looking at it again, they are in DT specific code already. The USB one
is in devm_usb_get_phy_by_node() which is a DT specific call.

>> We've generally split the DT code into the core (in drivers/of) and
>> the binding specific (in subsystems). Extracting dependency
>> information the DT is going to require binding specific knowledge, so
>> subsystem changes are probably unavoidable.
>>
>> The alternative is we put binding specific knowledge into the core DT
>> code to parse dependencies.
>>
>> > What is the root-problem of your delay in device probing?  I read your
>> > last patch series and I can't seem to figure out what the issue is that
>> > this is solving in any "better" way from the existing deferred probing.
>>
>> It saves 2 seconds in the boot time as re-probing takes time. That
>> alone seems compelling to me.
>
> 2 seconds is _forever_, and really seems like some other driver is
> sleeping and causing this problem.  What does the bootlog time-chart say
> is really causing this long delay?  There's no way we are stuck in some
> sort of logic loop for that long (i.e. having to walk the list of
> devices somehow.)  This sounds like a driver-specific problem that is
> being worked around by having to touch all subsystems, which isn't nice.

I don't think it is one driver as the improvement is seen on multiple
platforms. I'll let Tomeu comment further on where the time was spent.

> Hint, we didn't have to do this type of thing to solve boot delays on
> x86 when we had hardware that was slow to initialize, why should DT be
> special?  :)

x86 did not need deferred probe either (though we probably can find
some initcall ordering hacks). This is an embedded problem, not a DT
problem.

I'm guessing the time is a matter of probing and undoing the probes
rather than slow h/w. We could maybe improve things by making sure
drivers move what they defer on to the beginning of probe, but that
seems like a horrible, fragile hack.

>> Another downside to deferred probing is you have to touch every driver
>> and subsystem to support it. This contains the problem to the
>> subsystems.
>
> But we have deferred probing already, only those drivers that need/want
> it have to do anything, why create yet-another model here?

Yes, the only ones needing it are drivers dependent on clocks, gpio,
regulators, pwm, pin-ctrl, dma, etc. That's not a small number. This
is a side benefit and wouldn't take this series for that reason alone.

I've used the deferred probing is good enough argument myself on
previous attempts. The boot time improvements convinced me it is not
good enough except for simple cases.

Rob
