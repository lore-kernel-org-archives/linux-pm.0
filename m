From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v3 1/2] cpufreq / OPP: Allow boost frequency to be looked
 up from device tree
Date: Wed, 14 May 2014 08:09:30 +0200
Message-ID: <20140514080930.781e0557@amdc2363>
References: <1400029380-5372-1-git-send-email-thomas.ab@samsung.com>
 <1400029380-5372-2-git-send-email-thomas.ab@samsung.com>
 <CAKohponnPSRAotJUu+5a9y8j97QF8Jqgc5DA5WQnwGWCnVY-aA@mail.gmail.com>
 <CAGo_u6p-uqw82ewDciDEhAt0=Nswfw33-gf8Aa+-6_k3eCcTzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CAGo_u6p-uqw82ewDciDEhAt0=Nswfw33-gf8Aa+-6_k3eCcTzw@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Viresh Kumar <viresh.kumar@linaro.org>, Thomas Abraham <ta.omasab@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <rob.herring@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Tomasz Figa <t.figa@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Thomas P Abraham <thomas.ab@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi Nishanth, Viresh

If I may add my 2 cents.

> On Tue, May 13, 2014 at 10:40 PM, Viresh Kumar
> <viresh.kumar@linaro.org> wrote:
> > On 14 May 2014 06:32, Thomas Abraham <ta.omasab@gmail.com> wrote:
> [...]
> >> +#ifdef CONFIG_CPU_FREQ_BOOST_SW
> >> +       if (of_find_property(dev->of_node, "boost-frequency",
> >> &len)) {
> >
> > Does this mean another block inside the cpu node ? Like this: ?
> >
> > cpu@0 {
> >         compatible = "arm,cortex-a9";
> >         reg = <0>;
> >         next-level-cache = <&L2>;
> >         operating-points = <
> >                 /* kHz    uV */
> >                 792000  1100000
> >                 396000  950000
> >                 198000  850000
> >         >;
> >         boost-frequency = <
> >                 792000
> >                 198000
> >         >;

I think that the above approach is more appealing [*].

> > };
> >
> > I think it we might better add another field in the opp block as
> > these OPPs are rather boost one..
> 
> If we change the meaning to be:
>          operating-points = <
>                  /* kHz    uV          boost? */
>                  792000  1100000  1
>                  396000  950000    0
> 
> We are adding a modifier to the OPP definition here and does imply
> every platform which may or maynot require "boost" need to indicate
> that - basically fails at least my "least common" description for a
> generic definition. As I had indicated in other threads -> we are back
> to the discussion of "additional properties" to an OPP..
> Option 1:
>   - describe modifiers separately (as in boost-frequencies) - that
> operate based on data from opp table.
> Option 2:
>   - keep adding to the description of opp as time goes by - every SoC
> has it's own set of quirks that are needed for an OPP - I know that at
> TI, we have certain OPPs that can only be enabled *if* "custom
> hardware driver" is enabled, and similar stories. - yet another
> example is enable the OPP if efuse X, bit Y is set.
> 
> Personally, looking at the various descriptions and bL, cpu-idle
> states dependencies on OPPs, etc.. Option 2 is a non-scalable
> approach.

I agree with Nishanth here, that point 1 (as described by Viresh at
[*]) is a more scalable approach.

> 
> [...]



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
