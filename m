From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v7 2/8] dt-bindings: Introduce interconnect provider bindings
Date: Fri, 24 Aug 2018 10:35:23 -0500
Message-ID: <CAL_JsqKMPm=qmfYMQH99_gqSv0-ynUSvbkoNjjeDKtyxfgE1tg@mail.gmail.com>
References: <20180731161340.13000-1-georgi.djakov@linaro.org>
 <20180731161340.13000-3-georgi.djakov@linaro.org> <CABGGisxq+hf91R18pnZ=VZ9f99GssWWPhpPCjNAROJmKg5-udA@mail.gmail.com>
 <e114ed83-fd54-4952-f375-e1d94826ac6e@linaro.org> <20180820153207.xx5outviph7ec76p@flea>
 <672e6c6c-222f-5e7f-5d0c-acc8da68b1ab@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <672e6c6c-222f-5e7f-5d0c-acc8da68b1ab@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Michael Turquette <mturquette@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Saravana Kannan <skannan@codeaurora.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, Evan Green <evgreen@chromium.org>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Alexandre Bailon <abailon@baylibre.com>, Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, moderated list:
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 24, 2018 at 9:51 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Hi Maxime,
>
> On 08/20/2018 06:32 PM, Maxime Ripard wrote:
> > Hi Georgi,
> >
> > On Tue, Aug 07, 2018 at 05:54:38PM +0300, Georgi Djakov wrote:
> >>> There is also a patch series from Maxime Ripard that's addressing the
> >>> same general area. See "dt-bindings: Add a dma-parent property". We
> >>> don't need multiple ways to address describing the device to memory
> >>> paths, so you all had better work out a common solution.
> >>
> >> Looks like this fits exactly into the interconnect API concept. I see
> >> MBUS as interconnect provider and display/camera as consumers, that
> >> report their bandwidth needs. I am also planning to add support for
> >> priority.
> >
> > Thanks for working on this. After looking at your serie, the one thing
> > I'm a bit uncertain about (and the most important one to us) is how we
> > would be able to tell through which interconnect the DMA are done.
> >
> > This is important to us since our topology is actually quite simple as
> > you've seen, but the RAM is not mapped on that bus and on the CPU's,
> > so we need to apply an offset to each buffer being DMA'd.
>
> Ok, i see - your problem is not about bandwidth scaling but about using
> different memory ranges by the driver to access the same location. So
> this is not really the same and your problem is different. Also the
> interconnect bindings are describing a path and endpoints. However i am
> open to any ideas.

It may be different things you need, but both are related to the path
between a bus master and memory. We can't have each 'problem'
described in a different way. Well, we could as long as each platform
has different problems, but that's unlikely.

It could turn out that the only commonality is property naming
convention, but that's still better than 2 independent solutions.

I know you each want to just fix your issues, but the fact that DT
doesn't model the DMA side of the bus structure has been an issue at
least since the start of DT on ARM. Either we should address this in a
flexible way or we can just continue to manage without. So I'm not
inclined to take something that only addresses one SoC family.

Rob
