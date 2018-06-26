From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v4 09/12] dt-bindings: PM / OPP: add opp-throttlers
 property
Date: Tue, 26 Jun 2018 11:11:39 -0700
Message-ID: <20180626181139.GL129942@google.com>
References: <20180621015237.100100-1-mka@chromium.org>
 <20180621015237.100100-10-mka@chromium.org>
 <20180625153341.GB23270@rob-hp-laptop>
 <20180625185037.GE129942@google.com>
 <20180625200304.GF129942@google.com>
 <CAL_JsqLkYn66nrjphfLQzsO-eG1KZWdHxZbW5NEgkX4EhLbwAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqLkYn66nrjphfLQzsO-eG1KZWdHxZbW5NEgkX4EhLbwAQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Brian Norris <briannorris@chromium.org>, Doug Anderson <dianders@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>, Olof Johansson <olof@lixom.net>
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 26, 2018 at 09:49:49AM -0600, Rob Herring wrote:
> On Mon, Jun 25, 2018 at 2:03 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > On Mon, Jun 25, 2018 at 11:50:37AM -0700, Matthias Kaehlcke wrote:
> > > Hi Rob,
> > >
> > > On Mon, Jun 25, 2018 at 09:33:41AM -0600, Rob Herring wrote:
> > > > On Wed, Jun 20, 2018 at 06:52:34PM -0700, Matthias Kaehlcke wrote:
> > > > > The optional opp-throttlers property is used to configure the throttlers
> > > > > (see drivers/misc/throttler/*) that use a given OPP to throttle the
> > > > > corresponding device(s).
> > > > >
> > > > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > > > Reviewed-by: Brian Norris <briannorris@chromium.org>
> > > > > ---
> > > > > Changes in v4:
> > > > > - added 'Reviewed-by: Brian Norris <briannorris@chromium.org>' tag
> > > > >
> > > > > Changes in v3:
> > > > > - none
> > > > >
> > > > > Changes in v2:
> > > > > - patch added to series
> > > > > ---
> > > > >  Documentation/devicetree/bindings/opp/opp.txt | 3 +++
> > > > >  1 file changed, 3 insertions(+)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> > > > > index c396c4c0af92..747e79740c75 100644
> > > > > --- a/Documentation/devicetree/bindings/opp/opp.txt
> > > > > +++ b/Documentation/devicetree/bindings/opp/opp.txt
> > > > > @@ -170,6 +170,9 @@ Optional properties:
> > > > >    functioning of the current device at the current OPP (where this property is
> > > > >    present).
> > > > >
> > > > > +- opp-throttlers: Array with phandles of throttlers that use this OPP to
> > > > > +  throttle the corresponding device(s).
> > > > > +
> > > >
> > > > I think it would be better to make this a boolean for each OPP entry and
> > > > then add "operating-points-v2" property to the EC node to point to the
> > > > OPP table.
> > >
> > > Thanks for your suggestion. "operating-points-v2" would have to be an
> > > array of phandles, a single thottler can have multiple throttling
> > > devices.
> 
> I don't see any issue with allowing that.
> 
> > > > Unless there is some need for a different throttler for each OPP entry?
> > >
> > > Having the option to use different OPPs per throttler would be my
> > > preference. E.g. there could be configurations where one throttler
> > > only interacts with certain throttling devices and another one
> > > with others.
> 
> Your terminology is confusing. By "throttling device", you mean an OPP
> table (or OPP entry) which is not a device. OPPs are just a table of
> state information.

It reads OPP entries, but it interacts with hardware entities (not
necessarily devices in the kernel sense) like CPUs, GPUs, which is
what I call 'throttling devices'. I'm open to suggestions for a better
terminology :)

> > > I see another option to achieve this, if you don't like the reference
> > > to the throttlers in the OPPs. The throttler could have a list of OPPs
> > > (as phandles, not frequencies as in v1). The main inconvenient I see
> > > here is that the used OPPs would need a label, which they usually
> > > don't have. Maybe this is no soooo bad, since the label could be added
> > > at device level, only on devices that use a throttler, so it wouldn't
> > > clutter the platform .dts files.
> > >
> > > This could be a single array with all OPPs from different devices,
> > > or multiple arrays, one for each throttling device:
> > >
> > > throttler-opps-0 = <&cpu0_opp_03 &cpu0_opp_05>;
> > > throttler-opps-1 = <&gpu_opp_02 &gpu_opp_04>;
> > >
> > > My preference would be multiple arrays, because it's easier to read.
> >
> > I take the preference back. The OPPs for each device (group) can be
> > clustered within the single array and if needed clarifying comments
> > can be added:
> >
> > throttler-opps = <&cpu0_opp_03 &cpu0_opp_05  /* CPU0 */
> >                   &gpu_opp_02 &gpu_opp_04>;  /* GPU */
> >
> > This is simpler algorithmically and there is no need for an additional
> > property indicating the number of OPP groups or probing.
> 
> I'm still trying to understand why you would have say throttler-A
> wanting to set cpu freq to X and throttler-B wanting to set cpu freq
> to Y. There's both the question of why/when would you have 2 or more
> throttlers (in DT) and how would you resolve multiple requests.

The two throttlers could monitor different types of events, e.g. the
cros-ec throttler from this series and a throttler responding to a
GPIO change (real world example from an older platform, addressed with
a custom driver because there was no throttler).

Multiple requests are resolved by the cpufreq and devfreq
framework. The CPU/DEVFREQ_ADJUST callback allows callees to adjust
min/max frequencies (devfreq support for this is added in this
series). Well behaved callees use cpufreq/devfreq_verify_within_limits()
for the adjustment to ensure the most restrictive settings are applied.

> The whole design of a throttler directly dealing with OPPs especially
> for non-cpu devices seems like it is missing some level of
> abstraction. What if you want to throttle by some means other than
> frequency such as idling cores? I guess abstraction would make it hard
> to make things optimal for every platform when in the end you just
> want to set specific frequencies on a number of devices. It seems like
> a similar situation as early big.LITTLE designs vs. EAS.

For non-CPU devices the throttler currently supports devfreq devices,
which have a level of abstraction similar to cpufreq. I don't have a
comprehensive view of other devices that use OPPs, but if there is a
need in the future to support them I agree that there should probably
be an abstraction, or they should be integrated with devfreq if
applicable.

As of now I don't have plans to throttle by other means than
frequency. This can certainly come up, but I'd suggest we'll cross the
bridge when we get there, unless it is already evident that the
current bindings would cause problems.

Thanks

Matthias
