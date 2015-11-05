From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V2 2/5] PM / OPP: Add {opp-microvolt|opp-microamp|turbo-mode|opp-suspend}-<name>
 binding
Date: Thu, 5 Nov 2015 17:33:12 -0600
Message-ID: <CAL_Jsq+sKbn9Jsp6LjfwO59Ceps3zrL8eABXw74m3A25M8bjJg@mail.gmail.com>
References: <cover.1446687367.git.viresh.kumar@linaro.org> <17a4388be606f21fe1d31b23180d41f6cabdd4b5.1446687367.git.viresh.kumar@linaro.org>
 <20151105030245.GA20613@rob-hp-laptop> <20151105031913.GA29491@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151105031913.GA29491@ubuntu>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Stephen Boyd <sboyd@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Nishanth Menon <nm@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, open list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 4, 2015 at 9:19 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 04-11-15, 21:02, Rob Herring wrote:
>> > +- turbo-mode-<name>: Named turbo-mode property. Similar to opp-microvolt-<name>
>> > +  property, but for turbo mode instead.
>> > +
>> >  - opp-suspend: Marks the OPP to be used during device suspend. Only one OPP in
>> >    the table should have this.
>> >
>> > +- opp-suspend-<name>: Named opp-suspend property. Similar to
>> > +  opp-microvolt-<name> property, but for suspend opp instead.
>> > +
>>
>> I don't think these last 2 make sense. turbo-mode is a flag that the
>> mode has restrictions such as other cores have to be idle or something.
>> Similarly, opp-suspend should not vary by <name>.
>
> Based on what version of the hardware you are running, via
> opp-supported-hw property, the platform can enable a different set of
> OPPs. And in that case we may want to select different OPPs marked as
> turbo or suspend freq. That's what I thought at least.
>
> For example, on version A of the hardware we have following available
> frequencies: 800, 1000, 1100, 1200 MHz. Where 800 MHz is the suspend
> freq and 1200 is the turbo one.
>
> But on a slightly different version of hardware B, we have two more
> OPPs available: 700 and 1400 MHz. And in that case we want the suspend
> freq to be 700 and turbo OPP to be only 1400 MHz.

But different frequencies are different OPP nodes (since that is the
unit address now), so it is not going to hurt to set turbo-mode on
both 1200 and 1400.

Rob

>
> --
> viresh
