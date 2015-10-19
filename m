From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [GIT PULL] On-demand device probing
Date: Mon, 19 Oct 2015 07:35:05 -0500
Message-ID: <CAL_JsqKehmSobpbdeXGo=-1pAbtrhCHovyyCWya_MNOhGCi8CQ@mail.gmail.com>
References: <561E1378.6000906@collabora.com> <20151017065750.GA18607@kroah.com>
 <20151018192931.GY14956@sirena.org.uk> <20151018193757.GA9147@kroah.com>
 <20151018195330.GB14956@sirena.org.uk> <1445247881.53393.146.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1445247881.53393.146.camel@infradead.org>
Sender: linux-i2c-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Russell King <linux@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, =?UTF-8?Q?Terje_Bergstr=C3=B6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Felipe Balbi <balbi@ti.co>
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 19, 2015 at 4:44 AM, David Woodhouse <dwmw2@infradead.org> wrote:
> On Sun, 2015-10-18 at 20:53 +0100, Mark Brown wrote:
>> On Sun, Oct 18, 2015 at 12:37:57PM -0700, Greg Kroah-Hartman wrote:
>> > On Sun, Oct 18, 2015 at 08:29:31PM +0100, Mark Brown wrote:
>> > > On Fri, Oct 16, 2015 at 11:57:50PM -0700, Greg Kroah-Hartman wrote:
>>
>> > > > I can't see adding calls like this all over the tree just to solve a
>> > > > bus-specific problem, you are adding of_* calls where they aren't
>> > > > needed, or wanted, at all.
>>
>> > > This isn't bus specific, I'm not sure what makes you say that?
>>
>> > You are making it bus-specific by putting these calls all over the tree
>> > in different bus subsystems semi-randomly for all I can determine.
>>
>> Do you mean firmware rather than bus here?  I think that's the confusion
>> I have...
>
> Certainly, if it literally is adding of_* calls then that would seem to
> be gratuitously firmware-specific. Nothing should be using those these
> days; any new code should be using the generic device property APIs
> (except in special cases).

See version 2 of the series[1] which did that. It became obvious that
was pointless because the call paths ended up looking like this:

Generic subsystem code -> DT look-up code -> fwnode_probe_device ->
of_probe_device

Rob

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/361137.html
