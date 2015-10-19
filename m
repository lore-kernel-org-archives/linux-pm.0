From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [GIT PULL] On-demand device probing
Date: Mon, 19 Oct 2015 18:21:40 +0200
Message-ID: <CAMuHMdVv=ieYM-Nehp0qV8CEggHEeJ22j-6i_N09rRA_U=2ePw@mail.gmail.com>
References: <561E1378.6000906@collabora.com>
	<20151017065750.GA18607@kroah.com>
	<20151018192931.GY14956@sirena.org.uk>
	<20151018193757.GA9147@kroah.com>
	<20151018195330.GB14956@sirena.org.uk>
	<CAAObsKB2BUZ-smid45wOdAQw6h2yNqCydk+azAFNk69ewHJtZQ@mail.gmail.com>
	<20151019131821.GA32532@n2100.arm.linux.org.uk>
	<CAAObsKDS_+AZ26P_fHc6pvAYrQotsuoO0DEGQUWC514t3DD_jQ@mail.gmail.com>
	<20151019143045.GE32532@n2100.arm.linux.org.uk>
	<CAAObsKDWM6A98tdKHqi4fe5DBf0BmB0JeghcZDWan_PYbyshag@mail.gmail.com>
	<20151019153548.GM32532@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20151019153548.GM32532@n2100.arm.linux.org.uk>
Sender: linux-clk-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, =?UTF-8?Q?Terje_Bergstr=C3=B6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gma>
List-Id: linux-pm@vger.kernel.org

Hi Russell,

On Mon, Oct 19, 2015 at 5:35 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>> > What you can do is print those devices which have failed to probe at
>> > late_initcall() time - possibly augmenting that with reports from
>> > subsystems showing what resources are not available, but that's only
>> > a guide, because of the "it might or might not be in a kernel module"
>> > problem.
>>
>> Well, adding those reports would give you a changelog similar to the
>> one in this series...
>
> I'm not sure about that, because what I was thinking of is adding
> a flag which would be set at late_initcall() time prior to running
> a final round of deferred device probing.

Which round is the final round?
That's the one which didn't manage to bind any new devices to drivers,
which is something you only know _after_ the round has been run.

So I think we need one extra round to handle this.

> This flag would then be used in a deferred_warn() printk function
> which would normally be silent, but when this flag is set, it would
> print the reason for the deferral - and this would replace (or be
> added) to the subsystems and drivers which return -EPROBE_DEFER.
>
> That has the effect of hiding all the deferrals up until just before
> launching into userspace, which should then acomplish two things -
> firstly, getting rid of the rather useless deferred messages up to
> that point, and secondly printing the reason why the remaining
> deferrals are happening.
>
> That should be a small number of new lines plus a one-line change
> in subsystems and drivers.

Apart from the extra round we probably can't get rid of, that sounds OK to me.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
