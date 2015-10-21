From: Frank Rowand <frowand.list@gmail.com>
Subject: Re: [GIT PULL] On-demand device probing
Date: Wed, 21 Oct 2015 14:50:39 -0700
Message-ID: <562808AF.7090406@gmail.com>
References: <561E1378.6000906@collabora.com> <20151017065750.GA18607@kroah.com> <20151018192931.GY14956@sirena.org.uk> <20151018193757.GA9147@kroah.com> <20151018195330.GB14956@sirena.org.uk> <CAAObsKB2BUZ-smid45wOdAQw6h2yNqCydk+azAFNk69ewHJtZQ@mail.gmail.com> <5627B677.5090109@gmail.com> <20151021162758.GP32054@sirena.org.uk> <5627D6E0.5020708@gmail.com> <CAL_Jsq+FPtCuBnte2HTgbdpNYM=v_kLaCRcOC1kMaCQwVC=5Kw@mail.gmail.com>
Reply-To: frowand.list@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <CAL_Jsq+FPtCuBnte2HTgbdpNYM=v_kLaCRcOC1kMaCQwVC=5Kw@mail.gmail.com>
Sender: linux-clk-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, =?UTF-8?B?VGVyamUgQmVyZ3N0csO2bQ==?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Felipe Balbi <balbi@t>
List-Id: linux-pm@vger.kernel.org

On 10/21/2015 2:12 PM, Rob Herring wrote:
> On Wed, Oct 21, 2015 at 1:18 PM, Frank Rowand <frowand.list@gmail.com=
> wrote:
>> On 10/21/2015 9:27 AM, Mark Brown wrote:
>>> On Wed, Oct 21, 2015 at 08:59:51AM -0700, Frank Rowand wrote:
>>>> On 10/19/2015 5:34 AM, Tomeu Vizoso wrote:
>>>
>>>>> To be clear, I was saying that this series should NOT affect tota=
l
>>>>> boot times much.
>>>
>>>> I'm confused.  If I understood correctly, improving boot time was
>>>> the key justification for accepting this patch set.  For example,
>>>> from "[PATCH v7 0/20] On-demand device probing":
>>>>
>>>>    I have a problem with the panel on my Tegra Chromebook taking l=
onger
>>>>    than expected to be ready during boot (St=C3=A9phane Marchesin =
reported what
>>>>    is basically the same issue in [0]), and have looked into order=
ed
>>>>    probing as a better way of solving this than moving nodes aroun=
d in the
>>>>    DT or playing with initcall levels and linking order.
>>>>
>>>>    ...
>>>>
>>>>    With this series I get the kernel to output to the panel in 0.5=
s,
>>>>    instead of 2.8s.
>>>
>>> Overall boot time and time to get some individual built in componen=
t up
>>> and running aren't the same thing - what this'll do is get things u=
p
>>> more in the link order of the leaf consumers rather than deferring =
those
>>> leaf consumers when their dependencies aren't ready yet.
>>
>> Thanks!  I read too much into what was being improved.
>>
>> So this patch series, which on other merits may be a good idea, is a=
s
>> a by product solving a specific ordering issue, moving successful pa=
nel
>> initialization to an earlier point in the boot sequence, if I now
>> understand more correctly.
>>
>> In that context, this seems like yet another ad hoc way of causing t=
he
>> probe order to change in a way to solves one specific issue?  Could
>> it just as likely move the boot order of some other driver on some
>> other board later, to the detriment of somebody else?
>=20
> Time to display on is important for many products. Having the console
> up as early as possible is another case. CAN bus is another. This is =
a
> real problem that is not just bad drivers.

Yes, I agree.

What I am seeing is that there continues to be a need for the ability
to explicitly order at least some driver initialization (at some
granularity), despite the push back against explicit ordering that
has been present in the past.


> I don't think it is completely ad hoc. Given all devices are
> registered after drivers, drivers will still probe first in initcall
> level order and then link order AFAIK. We may not take (more) initcal=
l
> level tweak hacks, but that is a much more simple change for
> downstream. Don't get me wrong, I'd really like to see a way to
> control order independent of initcall level.
>=20
> Rob

Yep, it is not directly ad hoc, just a fortunate side effect in
this case.  So just accidently ad hoc. :-)

-Frank

