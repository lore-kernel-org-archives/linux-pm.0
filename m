From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 1/2] PM / Domains: Introduce domain-performance-state binding
Date: Wed, 23 Nov 2016 14:30:02 -0800
Message-ID: <m2fumhx21h.fsf@baylibre.com>
References: <cover.1479459752.git.viresh.kumar@linaro.org>
        <cce951c7159aa235792959ce27546be3aaa554ec.1479459752.git.viresh.kumar@linaro.org>
        <20161121150708.j4gosfr2uetc7mwp@rob-hp-laptop>
        <20161122031717.GE10014@vireshk-i7> <m260nfz8mr.fsf@baylibre.com>
        <CAKfTPtDR6Y5UgaqJ+D5T0yBeFRSYWm6OT1+r4ZABrtqtvF2D0w@mail.gmail.com>
        <m2wpfuw5wq.fsf@baylibre.com>
        <CAKfTPtBMro7+UruF0-E26TJPu6pEAvkjF9V7SKriNBm5q+K9+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKfTPtBMro7+UruF0-E26TJPu6pEAvkjF9V7SKriNBm5q+K9+A@mail.gmail.com>
        (Vincent Guittot's message of "Wed, 23 Nov 2016 16:55:38 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, Lina Iyer <lina.iyer@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Nayak Rajendra <rnayak@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Vincent Guittot <vincent.guittot@linaro.org> writes:

> On 23 November 2016 at 16:51, Kevin Hilman <khilman@baylibre.com> wrote:
>> Vincent Guittot <vincent.guittot@linaro.org> writes:
>>
>>> On 22 November 2016 at 19:12, Kevin Hilman <khilman@baylibre.com> wrote:
>>>> Viresh Kumar <viresh.kumar@linaro.org> writes:
>>>>
>>>>> On 21-11-16, 09:07, Rob Herring wrote:
>>>>>> On Fri, Nov 18, 2016 at 02:53:12PM +0530, Viresh Kumar wrote:
>>>>>> > Some platforms have the capability to configure the performance state of
>>>>>> > their Power Domains. The performance levels are represented by positive
>>>>>> > integer values, a lower value represents lower performance state.
>>>>>> >
>>>>>> > The power-domains until now were only concentrating on the idle state
>>>>>> > management of the device and this needs to change in order to reuse the
>>>>>> > infrastructure of power domains for active state management.
>>>>>> >
>>>>>> > This patch introduces a new optional property for the consumers of the
>>>>>> > power-domains: domain-performance-state.
>>>>>> >
>>>>>> > If the consumers don't need the capability of switching to different
>>>>>> > domain performance states at runtime, then they can simply define their
>>>>>> > required domain performance state in their node directly. Otherwise the
>>>>>> > consumers can define their requirements with help of other
>>>>>> > infrastructure, for example the OPP table.
>>>>>> >
>>>>>> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>>>>>> > ---
>>>>>> >  Documentation/devicetree/bindings/power/power_domain.txt | 6 ++++++
>>>>>> >  1 file changed, 6 insertions(+)
>>>>>> >
>>>>>> > diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
>>>>>> > index e1650364b296..db42eacf8b5c 100644
>>>>>> > --- a/Documentation/devicetree/bindings/power/power_domain.txt
>>>>>> > +++ b/Documentation/devicetree/bindings/power/power_domain.txt
>>>>>> > @@ -106,6 +106,12 @@ domain provided by the 'parent' power controller.
>>>>>> >   - power-domains : A phandle and PM domain specifier as defined by bindings of
>>>>>> >                     the power controller specified by phandle.
>>>>>> >
>>>>>> > +Optional properties:
>>>>>> > +- domain-performance-state: A positive integer value representing the minimum
>>>>>> > +  performance level (of the parent domain) required by the consumer for its
>>>>>> > +  working. The integer value '1' represents the lowest performance level and the
>>>>>> > +  highest value represents the highest performance level.
>>>>>>
>>>>>> How does one come up with the range of values?
>>>>>
>>>>> Why would we need a range here? The value here represents the minimum 'state'
>>>>> and the assumption is that everything above that level would be fine. So the
>>>>> range is automatically: domain-performance-state -> MAX.
>>>>>
>>>>>> It seems like you are
>>>>>> just making up numbers. Couldn't the domain performance level be an OPP
>>>>>> in the sense that it is a collection of clock frequencies and voltage
>>>>>> settings?
>>>>>
>>>>> The clock is going to be handled by the device itself (at least for the case we
>>>>> have today) and the performance-state lies with the power-domain which is
>>>>> configured separately. If the performance level includes both clk and voltage,
>>>>> then why would we need to show the clock rates in the DT ? Wouldn't a
>>>>> performance level be enough in such cases?
>>>>
>>>> I think the question is: what does the performance-level of a domain
>>>> actually mean?  Or, what are the units?
>>>>
>>>> Depending on the SoC, there's probably a few things this could mean.  It
>>>> might mean is that an underlying bus/interconnect can be configured to
>>>> guarantee a specific bandwidth or throughput.  That in turn might mean
>>>> that that bus/interconnect might have to be set at a specific
>>>> frequency/voltage.
>>>>
>>>> In your case, IIUC, you're just passing some magic value to some
>>>> firmware running on a micro-controller, but under the hood that uC is
>>>> probably configuring a frequency/voltage someplace.
>>>
>>> In the case described by Viresh, it's only about setting the voltage
>>> of a power domain that is shared between different devices. these
>>> devices wants to run at different frequency (set by the devices) but
>>> we have to select a Volateg value that will match with the constraint
>>> of all devices (in this case the highest voltage)
>>
>> Then, at least for this use case, we're talking about voltage, not some
>> unspecified units.
>>
>> But that makes me wonder, this performance state sounds like something
>> that is changing dynamically at runtime, so why do you want to describe
>> this statically in DT?
>>
>> This sounds to me like the job of the genpd.  When any device in the
>> domain does its pm_runtime_get(), the domain could check the device
>> frequency and see if it needs to change the domain voltage in order for
>> that device to operate at that frequency.  When the device goes away
>> (using pm_runtime_put()) the domain can check again if it could lower
>> the voltage and still meet the requirements of the remaining devices.
>
> That's only part of the job. The device can change its frequency and
> as a result ask for a new voltage index while it is already running

That's fine.  Use clock notifiers, or better use QoS (with notifiers) so
that the genpd knows when any of those change.

Kevin
