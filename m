From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [GIT PULL] On-demand device probing
Date: Wed, 21 Oct 2015 16:12:44 -0500
Message-ID: <CAL_Jsq+FPtCuBnte2HTgbdpNYM=v_kLaCRcOC1kMaCQwVC=5Kw@mail.gmail.com>
References: <561E1378.6000906@collabora.com> <20151017065750.GA18607@kroah.com>
 <20151018192931.GY14956@sirena.org.uk> <20151018193757.GA9147@kroah.com>
 <20151018195330.GB14956@sirena.org.uk> <CAAObsKB2BUZ-smid45wOdAQw6h2yNqCydk+azAFNk69ewHJtZQ@mail.gmail.com>
 <5627B677.5090109@gmail.com> <20151021162758.GP32054@sirena.org.uk> <5627D6E0.5020708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <5627D6E0.5020708@gmail.com>
Sender: linux-clk-owner@vger.kernel.org
To: Frank Rowand <frowand.list@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, =?UTF-8?Q?Terje_Bergstr=C3=B6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Felipe Balbi <balbi@ti.co>
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 21, 2015 at 1:18 PM, Frank Rowand <frowand.list@gmail.com> =
wrote:
> On 10/21/2015 9:27 AM, Mark Brown wrote:
>> On Wed, Oct 21, 2015 at 08:59:51AM -0700, Frank Rowand wrote:
>>> On 10/19/2015 5:34 AM, Tomeu Vizoso wrote:
>>
>>>> To be clear, I was saying that this series should NOT affect total
>>>> boot times much.
>>
>>> I'm confused.  If I understood correctly, improving boot time was
>>> the key justification for accepting this patch set.  For example,
>>> from "[PATCH v7 0/20] On-demand device probing":
>>>
>>>    I have a problem with the panel on my Tegra Chromebook taking lo=
nger
>>>    than expected to be ready during boot (St=C3=A9phane Marchesin r=
eported what
>>>    is basically the same issue in [0]), and have looked into ordere=
d
>>>    probing as a better way of solving this than moving nodes around=
 in the
>>>    DT or playing with initcall levels and linking order.
>>>
>>>    ...
>>>
>>>    With this series I get the kernel to output to the panel in 0.5s=
,
>>>    instead of 2.8s.
>>
>> Overall boot time and time to get some individual built in component=
 up
>> and running aren't the same thing - what this'll do is get things up
>> more in the link order of the leaf consumers rather than deferring t=
hose
>> leaf consumers when their dependencies aren't ready yet.
>
> Thanks!  I read too much into what was being improved.
>
> So this patch series, which on other merits may be a good idea, is as
> a by product solving a specific ordering issue, moving successful pan=
el
> initialization to an earlier point in the boot sequence, if I now
> understand more correctly.
>
> In that context, this seems like yet another ad hoc way of causing th=
e
> probe order to change in a way to solves one specific issue?  Could
> it just as likely move the boot order of some other driver on some
> other board later, to the detriment of somebody else?

Time to display on is important for many products. Having the console
up as early as possible is another case. CAN bus is another. This is a
real problem that is not just bad drivers.

I don't think it is completely ad hoc. Given all devices are
registered after drivers, drivers will still probe first in initcall
level order and then link order AFAIK. We may not take (more) initcall
level tweak hacks, but that is a much more simple change for
downstream. Don't get me wrong, I'd really like to see a way to
control order independent of initcall level.

Rob
