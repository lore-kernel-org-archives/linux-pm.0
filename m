From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] PM / Domains: Fix compatible for domain idle state
Date: Thu, 8 Dec 2016 10:07:28 -0600
Message-ID: <CAL_Jsq+dEpZ4AG2inixLhThuVc66LYKnDshhk9oJ_f8Dhxig=Q@mail.gmail.com>
References: <1478210075-92045-1-git-send-email-lina.iyer@linaro.org>
 <CAPDyKFqFnk6+Rfdzp-4wzEy8KNkq=03q5qfbkQD4pPNF0Pc6ww@mail.gmail.com>
 <1616414.c1s7NxTqJS@aspire.rjw.lan> <1526421.aCsca4sLnR@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1526421.aCsca4sLnR@aspire.rjw.lan>
Sender: linux-arm-msm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Lina Iyer <lina.iyer@linaro.org>, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Andy Gross <andy.gross@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Brendan Jackman <brendan.jackman@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 7, 2016 at 6:13 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Thursday, December 01, 2016 10:21:59 PM Rafael J. Wysocki wrote:
>> On Tuesday, November 29, 2016 09:47:03 AM Ulf Hansson wrote:
>> > On 10 November 2016 at 20:58, Rob Herring <robh@kernel.org> wrote:
>> > > On Mon, Nov 07, 2016 at 12:14:28PM +0100, Ulf Hansson wrote:
>> > >> On 3 November 2016 at 22:54, Lina Iyer <lina.iyer@linaro.org> wrote:
>> > >> > Re-using idle state definition provided by arm,idle-state for domain
>> > >> > idle states creates a lot of confusion and limits further evolution of
>> > >> > the domain idle definition. To keep things clear and simple, define a
>> > >> > idle states for domain using a new compatible "domain-idle-state".
>> > >> >
>> > >> > Fix existing PM domains code to look for the newly defined compatible.
>> > >> >
>> > >> > Cc: <devicetree@vger.kernel.org>
>> > >> > Cc: Rob Herring <robh@kernel.org>
>> > >> > Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>> > >> > ---
>> > >> >  .../bindings/power/domain-idle-state.txt           | 33 ++++++++++++++++++++++
>> > >> >  .../devicetree/bindings/power/power_domain.txt     |  8 +++---
>> > >> >  drivers/base/power/domain.c                        |  2 +-
>> > >> >  3 files changed, 38 insertions(+), 5 deletions(-)
>> > >> >  create mode 100644 Documentation/devicetree/bindings/power/domain-idle-state.txt
>> > >> >
>> > >> > diff --git a/Documentation/devicetree/bindings/power/domain-idle-state.txt b/Documentation/devicetree/bindings/power/domain-idle-state.txt
>> > >> > new file mode 100644
>> > >> > index 0000000..eefc7ed
>> > >> > --- /dev/null
>> > >> > +++ b/Documentation/devicetree/bindings/power/domain-idle-state.txt
>> > >> > @@ -0,0 +1,33 @@
>> > >> > +PM Domain Idle State Node:
>> > >> > +
>> > >> > +A domain idle state node represents the state parameters that will be used to
>> > >> > +select the state when there are no active components in the domain.
>> > >> > +
>> > >> > +The state node has the following parameters -
>> > >> > +
>> > >> > +- compatible:
>> > >> > +       Usage: Required
>> > >> > +       Value type: <string>
>> > >> > +       Definition: Must be "domain-idle-state".
>> > >> > +
>> > >> > +- entry-latency-us
>> > >> > +       Usage: Required
>> > >> > +       Value type: <prop-encoded-array>
>> > >> > +       Definition: u32 value representing worst case latency in
>> > >> > +                   microseconds required to enter the idle state.
>> > >> > +                   The exit-latency-us duration may be guaranteed
>> > >> > +                   only after entry-latency-us has passed.
>> > >>
>> > >> As we anyway are going to change this, why not use an u64 and have the
>> > >> value in ns instead of us?
>> > >
>> > > I can't imagine that you would need more resolution or range. For times
>> > > less than 1us, s/w and register access times are going to dominate the
>> > > time.
>> > >
>> > > Unless there is a real need, I'd keep alignment with the existing
>> > > binding.
>> >
>> > Rob, are you fine with this? I thought it would be great to get this
>> > in for 4.10 rc1.
>>
>> Rob, any objections here?
>
> Well, no objections, so applied.

Sorry, just found my ack sitting in my drafts. Thought I had sent it.

Rob
