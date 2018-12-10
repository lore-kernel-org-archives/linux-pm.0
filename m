From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v10 0/8] Introduce on-chip interconnect API
Date: Mon, 10 Dec 2018 10:04:14 +0100
Message-ID: <CAJZ5v0gP50tmq4ZzB7LLSaWGWjGjK31y=qFg5PS9B7c2XQ+DyQ@mail.gmail.com>
References: <20181127180349.29997-1-georgi.djakov@linaro.org>
 <CAE=gft4jUjr3oDAZrM=-orLM-YoVAwa+e=crDDC_p9ArGE1dig@mail.gmail.com> <20181206145547.GA7884@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206145547.GA7884@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: evgreen@chromium.org, Georgi Djakov <georgi.djakov@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Saravana Kannan <skannan@codeaurora.org>, bjorn.andersson@linaro.org, Amit Kucheria <amit.kucheria@linaro.org>, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, abailon@baylibre.com, maxime.ripard@bootlin.com, Arnd Bergmann <arnd@arndb.de>, Thierry Reding <thierry.reding@gmail.com>, ksitaraman@nvidia.com, sanjayc@nvidia.com, "devicetree@vger.kernel.org" <devicetree@vg>
List-Id: linux-pm@vger.kernel.org

On Thu, Dec 6, 2018 at 3:55 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Dec 05, 2018 at 12:41:35PM -0800, Evan Green wrote:
> > On Tue, Nov 27, 2018 at 10:03 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
> > >
> > > Modern SoCs have multiple processors and various dedicated cores (video, gpu,
> > > graphics, modem). These cores are talking to each other and can generate a
> > > lot of data flowing through the on-chip interconnects. These interconnect
> > > buses could form different topologies such as crossbar, point to point buses,
> > > hierarchical buses or use the network-on-chip concept.
> > >
> > > These buses have been sized usually to handle use cases with high data
> > > throughput but it is not necessary all the time and consume a lot of power.
> > > Furthermore, the priority between masters can vary depending on the running
> > > use case like video playback or CPU intensive tasks.
> > >
> > > Having an API to control the requirement of the system in terms of bandwidth
> > > and QoS, so we can adapt the interconnect configuration to match those by
> > > scaling the frequencies, setting link priority and tuning QoS parameters.
> > > This configuration can be a static, one-time operation done at boot for some
> > > platforms or a dynamic set of operations that happen at run-time.
> > >
> > > This patchset introduce a new API to get the requirement and configure the
> > > interconnect buses across the entire chipset to fit with the current demand.
> > > The API is NOT for changing the performance of the endpoint devices, but only
> > > the interconnect path in between them.
> >
> > For what it's worth, we are ready to land this in Chrome OS. I think
> > this series has been very well discussed and reviewed, hasn't changed
> > much in the last few spins, and is in good enough shape to use as a
> > base for future patches. Georgi's also done a great job reaching out
> > to other SoC vendors, and there appears to be enough consensus that
> > this framework will be usable by more than just Qualcomm. There are
> > also several drivers out on the list trying to add patches to use this
> > framework, with more to come, so it made sense (to us) to get this
> > base framework nailed down. In my experiments this is an important
> > piece of the overall power management story, especially on systems
> > that are mostly idle.
> >
> > I'll continue to track changes to this series and we will ultimately
> > reconcile with whatever happens upstream, but I thought it was worth
> > sending this note to express our "thumbs up" towards this framework.
>
> Looks like a v11 will be forthcoming, so I'll wait for that one to apply
> it to the tree if all looks good.

I'm honestly not sure if it is ready yet.

New versions are coming on and on, which may make such an impression,
but we had some discussion on it at the LPC and some serious questions
were asked during it, for instance regarding the DT binding introduced
here.  I'm not sure how this particular issue has been addressed here,
for example.

Thanks,
Rafael
