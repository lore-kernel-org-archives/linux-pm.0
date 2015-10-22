From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [GIT PULL] On-demand device probing
Date: Thu, 22 Oct 2015 11:05:11 +0200
Message-ID: <CAAObsKAkyjdvNOS3+nuT0N9sudUFLsZXFtcm6Y038p+HSdsZsg@mail.gmail.com>
References: <561E1378.6000906@collabora.com> <20151017065750.GA18607@kroah.com>
 <20151018192931.GY14956@sirena.org.uk> <20151018193757.GA9147@kroah.com>
 <20151018195330.GB14956@sirena.org.uk> <CAAObsKB2BUZ-smid45wOdAQw6h2yNqCydk+azAFNk69ewHJtZQ@mail.gmail.com>
 <5627B677.5090109@gmail.com> <20151021162758.GP32054@sirena.org.uk>
 <5627D6E0.5020708@gmail.com> <CAL_Jsq+FPtCuBnte2HTgbdpNYM=v_kLaCRcOC1kMaCQwVC=5Kw@mail.gmail.com>
 <562808AF.7090406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <562808AF.7090406@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Frank Rowand <frowand.list@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, =?UTF-8?Q?Terje_Bergstr=C3=B6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Felipe Balbi <balbi@ti.com>, Jingoo
List-Id: linux-pm@vger.kernel.org

On 21 October 2015 at 23:50, Frank Rowand <frowand.list@gmail.com> wrot=
e:
> On 10/21/2015 2:12 PM, Rob Herring wrote:
>> On Wed, Oct 21, 2015 at 1:18 PM, Frank Rowand <frowand.list@gmail.co=
m> wrote:
>>> On 10/21/2015 9:27 AM, Mark Brown wrote:
>>>> On Wed, Oct 21, 2015 at 08:59:51AM -0700, Frank Rowand wrote:
>>>>> On 10/19/2015 5:34 AM, Tomeu Vizoso wrote:
>>>>
>>>>>> To be clear, I was saying that this series should NOT affect tot=
al
>>>>>> boot times much.
>>>>
>>>>> I'm confused.  If I understood correctly, improving boot time was
>>>>> the key justification for accepting this patch set.  For example,
>>>>> from "[PATCH v7 0/20] On-demand device probing":
>>>>>
>>>>>    I have a problem with the panel on my Tegra Chromebook taking =
longer
>>>>>    than expected to be ready during boot (St=C3=A9phane Marchesin=
 reported what
>>>>>    is basically the same issue in [0]), and have looked into orde=
red
>>>>>    probing as a better way of solving this than moving nodes arou=
nd in the
>>>>>    DT or playing with initcall levels and linking order.
>>>>>
>>>>>    ...
>>>>>
>>>>>    With this series I get the kernel to output to the panel in 0.=
5s,
>>>>>    instead of 2.8s.
>>>>
>>>> Overall boot time and time to get some individual built in compone=
nt up
>>>> and running aren't the same thing - what this'll do is get things =
up
>>>> more in the link order of the leaf consumers rather than deferring=
 those
>>>> leaf consumers when their dependencies aren't ready yet.
>>>
>>> Thanks!  I read too much into what was being improved.
>>>
>>> So this patch series, which on other merits may be a good idea, is =
as
>>> a by product solving a specific ordering issue, moving successful p=
anel
>>> initialization to an earlier point in the boot sequence, if I now
>>> understand more correctly.
>>>
>>> In that context, this seems like yet another ad hoc way of causing =
the
>>> probe order to change in a way to solves one specific issue?  Could
>>> it just as likely move the boot order of some other driver on some
>>> other board later, to the detriment of somebody else?
>>
>> Time to display on is important for many products. Having the consol=
e
>> up as early as possible is another case. CAN bus is another. This is=
 a
>> real problem that is not just bad drivers.
>
> Yes, I agree.
>
> What I am seeing is that there continues to be a need for the ability
> to explicitly order at least some driver initialization (at some
> granularity), despite the push back against explicit ordering that
> has been present in the past.

The important point that I have struggled to explain is that right now
for downstreams to influence the order in which devices are probed,
they have to carry a substantial amount of patches that cannot be ever
upstreamed. This fiddling with initcall levels and link order means
changing files that are very frequently changing, increasing the
amount of work when rebasing and increasing the probability of
regressions after a rebase.

This just adds up to other shortcomings of mainline and ends up with
the net result of vendors getting stuck with 3.4 kernels on SoCs that
start production in 2015. Another consequence is that vendors don't
have a chance to upstream their stuff even if they cared. The
overarching goal of the project I'm in is to reduce those shortcomings
that downstreams have to workaround, to facilitate their involvement
upstream.

With this series, the order in which devices are probed becomes the
order in which they were registered, which is the order in which the
devices appear in the FW description of the hw or in the board files
(much more predictable, which makes for a more robust process). For DT
and board files, which cover a good part of the consumer devices
shipped today with Linux, the downstream could just change the order
of device nodes and get their display or whatever to probe before any
other devices.

And even if downstream's hw has a SoC .dtsi that exists in mainline,
they could add a step to their build process that automatically
reorders the nodes to avoid carrying changes to that DT fragment.

But that's moot currently because Greg believes that the time spent
probing devices at boot time could be reduced enough so that the order
in which devices are probed becomes irrelevant. IME that would have to
be under 200ms so that the user doesn't notice and that's unicorn-far
from any bootlog I have ever seen.

Given that downstreams are already carrying as many hacks as they
could think of to speed total boot up, I think this is effectively
telling them to go away.

Sorry for the rant,

Tomeu

>> I don't think it is completely ad hoc. Given all devices are
>> registered after drivers, drivers will still probe first in initcall
>> level order and then link order AFAIK. We may not take (more) initca=
ll
>> level tweak hacks, but that is a much more simple change for
>> downstream. Don't get me wrong, I'd really like to see a way to
>> control order independent of initcall level.
>>
>> Rob
>
> Yep, it is not directly ad hoc, just a fortunate side effect in
> this case.  So just accidently ad hoc. :-)
>
> -Frank
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
