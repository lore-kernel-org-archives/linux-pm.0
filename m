From: Frank Rowand <frowand.list@gmail.com>
Subject: Re: [GIT PULL] On-demand device probing
Date: Wed, 21 Oct 2015 11:18:08 -0700
Message-ID: <5627D6E0.5020708@gmail.com>
References: <561E1378.6000906@collabora.com> <20151017065750.GA18607@kroah.com> <20151018192931.GY14956@sirena.org.uk> <20151018193757.GA9147@kroah.com> <20151018195330.GB14956@sirena.org.uk> <CAAObsKB2BUZ-smid45wOdAQw6h2yNqCydk+azAFNk69ewHJtZQ@mail.gmail.com> <5627B677.5090109@gmail.com> <20151021162758.GP32054@sirena.org.uk>
Reply-To: frowand.list@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <20151021162758.GP32054@sirena.org.uk>
Sender: linux-i2c-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, =?ISO-8859-1?Q?Terje_Bergstr=F6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Felipe Balbi <balbi@ti>
List-Id: linux-pm@vger.kernel.org

On 10/21/2015 9:27 AM, Mark Brown wrote:
> On Wed, Oct 21, 2015 at 08:59:51AM -0700, Frank Rowand wrote:
>> On 10/19/2015 5:34 AM, Tomeu Vizoso wrote:
>=20
>>> To be clear, I was saying that this series should NOT affect total
>>> boot times much.
>=20
>> I'm confused.  If I understood correctly, improving boot time was
>> the key justification for accepting this patch set.  For example,
>> from "[PATCH v7 0/20] On-demand device probing":
>>
>>    I have a problem with the panel on my Tegra Chromebook taking lon=
ger
>>    than expected to be ready during boot (St=E9phane Marchesin repor=
ted what
>>    is basically the same issue in [0]), and have looked into ordered
>>    probing as a better way of solving this than moving nodes around =
in the
>>    DT or playing with initcall levels and linking order.
>>
>>    ...
>>
>>    With this series I get the kernel to output to the panel in 0.5s,
>>    instead of 2.8s.
>=20
> Overall boot time and time to get some individual built in component =
up
> and running aren't the same thing - what this'll do is get things up
> more in the link order of the leaf consumers rather than deferring th=
ose
> leaf consumers when their dependencies aren't ready yet.

Thanks!  I read too much into what was being improved.

So this patch series, which on other merits may be a good idea, is as
a by product solving a specific ordering issue, moving successful panel
initialization to an earlier point in the boot sequence, if I now
understand more correctly.

In that context, this seems like yet another ad hoc way of causing the
probe order to change in a way to solves one specific issue?  Could
it just as likely move the boot order of some other driver on some
other board later, to the detriment of somebody else?


>=20
>> While not as dramatic as your results, they are somewhat supportive.
>> What has changed your assessment that the on-demand device probing
>> patches will give a big boot performance increase?  Do you have
>> new data or analysis?
>=20
> See above, my understanding was that the performance improvements wer=
e
> more around improved control/predictability/handwave of the boot
> ordering rather than total time.
>=20
