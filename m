From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [GIT PULL] On-demand device probing
Date: Sat, 24 Oct 2015 16:17:12 +0200
Message-ID: <24100858.2KIS8Y2npV@vostro.rjw.lan>
References: <20151018192931.GY14956@sirena.org.uk> <562A5602.7000208@sonymobile.com> <CAL_JsqLNSM=+j2r9HPcbSzsZrgnGEY3=kv21EXxisKwP5+57ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqLNSM=+j2r9HPcbSzsZrgnGEY3=kv21EXxisKwP5+57ag@mail.gmail.com>
Sender: linux-clk-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tim Bird <tim.bird@sonymobile.com>, "frowand.list@gmail.com" <frowand.list@gmail.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Russell King <linux@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Terje =?ISO-8859-1?Q?Bergstr=F6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwo>
List-Id: linux-pm@vger.kernel.org

On Friday, October 23, 2015 11:34:34 AM Rob Herring wrote:
> On Fri, Oct 23, 2015 at 10:45 AM, Tim Bird <tim.bird@sonymobile.com> wrote:
> > On 10/22/2015 11:53 AM, Frank Rowand wrote:
> >> On 10/22/2015 7:44 AM, Greg Kroah-Hartman wrote:
> >>> <oops, sent too early...>
> >>>
> >>> On Thu, Oct 22, 2015 at 11:05:11AM +0200, Tomeu Vizoso wrote:
> >>>> But that's moot currently because Greg believes that the time spent
> >>>> probing devices at boot time could be reduced enough so that the order
> >>>> in which devices are probed becomes irrelevant. IME that would have to
> >>>> be under 200ms so that the user doesn't notice and that's unicorn-far
> >>>> from any bootlog I have ever seen.
> >>>
> >>> But as no one has actually produced a bootlog, how do you know that?
> >>> Where exactly is your time being spent?  What driver is causing long
> >>> delays?  Why is the long-delay-drivers not being done in their own
> >>> thread?  And most importantly, why are you ignoring the work that people
> >>> did back in 2008 to solve the issue on other hardware platforms?
> >>>
> >>>> Given that downstreams are already carrying as many hacks as they
> >>>> could think of to speed total boot up, I think this is effectively
> >>>> telling them to go away.
> >>>
> >>> No I'm not, I'm asking for real data, not hand-wavy-this-is-going-to
> >>> solve-the-random-issue-i'm-having type patch by putting random calls in
> >>> semi-random subsystems all over the kernel.
> >>>
> >>> And when I ask for real data, you respond with the fact that you aren't
> >>> trying to speed up boot time here at all, so what am I supposed to think
> >>
> >> I also had the understanding that this patch series was about improving
> >> boot time.  But I was kindly corrected that the behavior change was
> >> getting the panel displaying stuff at an earlier point in the boot sequence,
> >> _not_ completing the entire boot faster.
> >>
> >> The claim for the current series, in patch 0 in v7 is:
> >>
> >>    With this series I get the kernel to output to the panel in 0.5s,
> >>    instead of 2.8s.
> >
> > It's very common to want to get the display up before the
> > rest of the system.  So wanting to accelerate one part of the boot
> > at the expense to the rest of the system is a valid use case.
> > Deferred initcalls, which is out of tree primarily because it requires
> > the type of manual tweaking that Tomeu describes, specifically
> > addressed this issue.
> 
> Agreed and other folks will want other things up first. But it seems
> we are getting lucky with link order with the speed ups in this case.
> We need a way to specify priority of probing devices. If we have that
> piece, then all this plumbing can be used. A simple solution would be
> looking at stdout-path to get the console device to probe. That would
> be trivial to add on top of this. That may work for the display too,
> but you may not want the console on the display. That wouldn't work
> for CAN bus either, but then I'm not sure there is a generic solution
> for its requirements (respond within 50ms IIRC).

Well, I'm not quite sure why exactly everyone is so focused on probing here.

Probing is just one aspect of the fact that we need functional dependencies
to be tracked somehow and acted on when necessary.  And this is not limited
to probing, as I have already said for a few times.  Other cases include:
system shutdown, system suspend/resume, runtime PM, unbinding of drivers.

If there is a functional dependency between two devices (say, B requires A
to be present and functional, meaning that the driver of A has to be present
and working for the driver of B to be working), all of the above need to be
done in a specific order.

Today, however, the driver core only knows about structural dependencies
and only in the specific parent-child case.

So perhaps it's better to start discussing about a solution for the general
issue?

Thanks,
Rafael

