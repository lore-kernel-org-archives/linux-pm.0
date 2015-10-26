From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [GIT PULL] On-demand device probing
Date: Mon, 26 Oct 2015 13:55:29 +0100
Message-ID: <CAAObsKAFJ+OKiLR2aMOjf15bd7k89EKsKLpd3ubsPMKeGLkRZw@mail.gmail.com>
References: <20151018192931.GY14956@sirena.org.uk> <562A5602.7000208@sonymobile.com>
 <CAL_JsqLNSM=+j2r9HPcbSzsZrgnGEY3=kv21EXxisKwP5+57ag@mail.gmail.com>
 <24100858.2KIS8Y2npV@vostro.rjw.lan> <20151024220648.GR29919@sirena.org.uk>
 <CAJZ5v0hPVu7AL8zBdU4Kb7+MVfYv0mTa43RhnCyyPR+RKDbhLA@mail.gmail.com> <20151026105138.20687.13546@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20151026105138.20687.13546@quantum>
Sender: linux-gpio-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tim Bird <tim.bird@sonymobile.com>, "frowand.list@gmail.com" <frowand.list@gmail.com>, Russell King <linux@arm.linux.org.uk>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, =?UTF-8?Q?Terje_Bergstr=C3=B6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshko>
List-Id: linux-pm@vger.kernel.org

On 26 October 2015 at 11:51, Michael Turquette <mturquette@baylibre.com> wrote:
> Quoting Rafael J. Wysocki (2015-10-25 06:54:39)
>> On Sun, Oct 25, 2015 at 12:06 AM, Mark Brown <broonie@kernel.org> wrote:
>> > On Sat, Oct 24, 2015 at 04:17:12PM +0200, Rafael J. Wysocki wrote:
>> >
>> >> Well, I'm not quite sure why exactly everyone is so focused on probing here.
>> >
>> > Probe deferral is really noisy even if it's working fine on a given
>> > system so it's constantly being highlighted to people in a way that
>> > other issues aren't if you're not directly having problems.
>> >
>> > There's also the understanding people had that the order things get
>> > bound changes the ordering for some of the other cases (perhaps it's a
>> > good idea to do that, it seems likely to be sensible?).
>>
>> But it really doesn't do that.  Also making it do so doesn't help much
>> in the cases where things can happen asynchronously (system
>> suspend/resume, runtime PM).
>>
>> If, instead, there was a way to specify a functional dependency at the
>> device registration time, it might be used to change the order of
>> everything relevant, including probe.  That should help to reduce the
>> noise you're referring to.
>
> Taking it a step further, if functional dependencies were understood at
> link-time then we could optimize link order as well. There are probably
> lots of optimizations if we only made the effort to understand these
> dependencies earlier.
>
> Constructing the device/resource dependency graph before the device ever
> boots sounds interesting to me.

Alexander Holler has been looking at that for some time already.

Regards,

Tomeu

> Regards,
> Mike
>
>>
>> If the dependency could only be discovered at the probe time, the
>> order of things might be changed in response to letting the driver
>> core know about it rather than "just in case", which should be more
>> efficient.
>>
>> Thanks,
>> Rafael
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
