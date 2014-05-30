From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v6 2/2] Documentation: devicetree: Add boost-frequency
 binding to list boost mode frequency
Date: Fri, 30 May 2014 22:43:51 +0200
Message-ID: <5388ED87.1090209@gmail.com>
References: <1401440477-4328-1-git-send-email-thomas.ab@samsung.com> <1401440477-4328-3-git-send-email-thomas.ab@samsung.com> <20140530130827.GK24233@leverpostej> <CAJuA9ajs6K1PVtXC4_U0vQsA0oPnpaF_PdMfiQJxBFStF3Z2aw@mail.gmail.com> <20140530185549.GN24233@leverpostej> <5388E105.3070609@ti.com> <5388E3D2.2060602@gmail.com> <5388E666.2090203@ti.com> <5388E7DC.40606@gmail.com> <5388EB21.5020300@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <5388EB21.5020300@ti.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>, Thomas Abraham <ta.omasab@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "t.figa@samsung.com" <t.figa@samsung.com>, "l.majewski@samsung.com" <l.majewski@samsung.com>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On 30.05.2014 22:33, Nishanth Menon wrote:
> On 05/30/2014 03:19 PM, Tomasz Figa wrote:
>> On 30.05.2014 22:13, Nishanth Menon wrote:
>>> On 05/30/2014 03:02 PM, Tomasz Figa wrote:
>>>> On 30.05.2014 21:50, Nishanth Menon wrote:
>>>>> On 05/30/2014 01:55 PM, Mark Rutland wrote:
>>>>>> On Fri, May 30, 2014 at 07:05:43PM +0100, Thomas Abraham wrote:
>>>>>>> Hi Mark,
>>>>>>>
>>>>>>> On Fri, May 30, 2014 at 6:38 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> Apologies for being somewhat late w.r.t. review on this.
>>>>>>>>
>>>>>>>> On Fri, May 30, 2014 at 10:01:17AM +0100, Thomas Abraham wrote:
>>>>>>>>> From: Thomas Abraham <thomas.ab@samsung.com>
>>>>>>>>>
>>>>>>>>> Add a new optional boost-frequency binding for specifying the frequencies
>>>>>>>>> usable in boost mode.
>>>>>>>>>
>>>>>>>>> Cc: Rob Herring <robh+dt@kernel.org>
>>>>>>>>> Cc: Pawel Moll <pawel.moll@arm.com>
>>>>>>>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>>>>>>>> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
>>>>>>>>> Cc: Kumar Gala <galak@codeaurora.org>
>>>>>>>>> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>>>>>>>>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>>>>>>>> Acked-by: Nishanth Menon <nm@ti.com>
>>>>>>>>> Acked-by: Lukasz Majewski <l.majewski@samsung.com>
>>>>>>>>> ---
>>>>>>>>>  .../devicetree/bindings/cpufreq/cpufreq-boost.txt  |   38 ++++++++++++++++++++
>>>>>>>>>  1 file changed, 38 insertions(+)
>>>>>>>>>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-boost.txt
>>>>>>>>>
>>>>>>>>> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-boost.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-boost.txt
>>>>>>>>> new file mode 100644
>>>>>>>>> index 0000000..63ed0fc
>>>>>>>>> --- /dev/null
>>>>>>>>> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-boost.txt
>>>>>>>>> @@ -0,0 +1,38 @@
>>>>>>>>> +* Device tree binding for CPU boost frequency (aka over-clocking)
>>>>>>>>> +
>>>>>>>>> +Certain CPU's can be operated in optional 'boost' mode (or sometimes referred as
>>>>>>>>
>>>>>>>> Nit: CPUs (we're not greengrocers [1])
>>>>>>>>
>>>>>>>>> +overclocking) in which the CPU can operate at frequencies which are not
>>>>>>>>> +specified by the manufacturer as CPU's operating frequency.
>>>>>>>>> +
>>>>>>>>> +Optional Properties:
>>>>>>>>> +- boost-frequencies: list of frequencies in KHz to be used only in boost mode.
>>>>>>>>> +  This list should be a subset of frequencies listed in "operating-points"
>>>>>>>>> +  property. Refer to Documentation/devicetree/bindings/power/opp.txt for
>>>>>>>>> +  details about "operating-points" property.
>>>>>>>>
>>>>>>>> What is 'boost-mode'?
>>>>>>>
>>>>>>> boost-mode activates additional one or more cpu clock speeds (which
>>>>>>> are not specified as operating frequency of the cpu by the
>>>>>>> manufacturer). The cpu is allowed to operate in these boost mode
>>>>>>> speeds when the boost mode is active. The boost mode speeds are
>>>>>>> usually undocumented. Some of the chip samples could be clocked in
>>>>>>> boost mode speeds and only such samples can be safely operated in
>>>>>>> boost mode.
>>>>>>>
>>>>>>> The mechanism of entry into and exit out of boost mode is outside the
>>>>>>> scope of this documentation.
>>>>>>>
>>>>>>>>
>>>>>>>> What are the limitations on boost frequencies? When is a CPU expected to
>>>>>>>> go to these frequencies and for now long? When should I as a dt author
>>>>>>>> place elements in boost-frequencies?
>>>>>>>
>>>>>>> I will add these details in the next revision of this patch.
>>>>>>
>>>>>> Cheers.
>>>>>>
>>>>>>>>
>>>>>>>> Why are these in both operating-points and boost-frequencies? It'll be
>>>>>>>> really easy to accidentally forget to mark something as a
>>>>>>>> boost-frequency this way. Why not have a boost-points instead?
>>>>>>>
>>>>>>> Does boost-points mean a set of clock speeds which are not listed as
>>>>>>> part of operating-points property? If yes, that also is a possible
>>>>>>> implementation (it was implemented in one of the earlier version of
>>>>>>> this series). Could you confirm that you want the boost mode speeds to
>>>>>>> be exclusive of the speeds listed in operating-points?
>>>>>>
>>>>>> If these boost mode operating points are not generally advisable for use
>>>>>> as the other operating-points are, then they should IMO been in an
>>>>>> entirely separate property exclusive of (but in the same format as) the
>>>>>> operating-points property, e.g.
>>>>>>
>>>>>> operating points = <A B>, <C D>;
>>>>>> boost-points = <E F>;
>>>>>
>>>>> you are asking boost frequencies to remain for ever tied down to OPP
>>>>> style description.
>>>>>
>>>>> What we are trying to describe? "What are my SoC's overclocked
>>>>> frequencies"? That description can be used even in a system that does
>>>>> not use OPP style table (say ACPI based OPP tables or whatever
>>>>> acronymned table).
>>>>>
>>>>> Tying it down to operating points just because we have it today as a
>>>>> convenient description, is limiting.
>>>>>
>>>>> Further, if we decide to educate boost-frequencies to also indicate
>>>>> how long is it safe? That does indeed belong to boost-frequency
>>>>> description and not OPP description. Or if we decide to change
>>>>> operating-points description[1] in the future has an impact on
>>>>> "boost-points" description, when it should not have.
>>>>>
>>>>>>
>>>>>> Otherwise, without boost-mode support we have to parse the boost mode
>>>>>> table to figure out which points to avoid. Or if someone typos a value
>>>>> That is OS usage of h/w description - yeah - in anycase, if OS has no
>>>>> ability to deal with boost-frequencies, it should skip it for sure.
>>>>>
>>>>>> in either table we might go into a boost mode when we didn't want to!
>>>>>>
>>>>> There are other ways to screw up device with dts typo. you could give
>>>>> a wrong voltage(extra 0?) and ensure you never use the chip ever
>>>>> again.. typos are dt bugs, we can do the best to write robust code to
>>>>> report them.
>>>>>
>>>>
>>>> Typos are not the primary thing to worry about here. Adding boost
>>>> frequencies to the list of primary operating points is flawed, because
>>>> an OS that has no idea of boost mode will use them as normal operating
>>>> points and this is not desired.
>>>
>>> That means we have an implementation bug in OS since it does not
>>> consider the complete hardware description that device tree is
>>> providing. An analogy will be a regulator compatible match being used
>>> but regulator-min-microvolt and regulator-max-microvolt being ignored
>>> by OS.
>>
>> No. The operating points bindings were defined far before this
>> boost-frequency and so there is no requirement to support the latter.
> 
> So, we dont add any new bindings ever again? /me blinks. *IF* we add a
> new property in the future, do we expect the new description to be
> supported in older kernel(which could not have known about it)? How
> far are we taking this ABI thing?
> Documentation/devicetree/bindings/ABI.txt states:
> 3) Bindings can be augmented, but the driver shouldn't break when given
>    the old binding. ie. add additional properties, but don't change the
>    meaning of an existing property. For drivers, default to the original
>    behaviour when a newly added property is missing.
> 
> we are not changing the meaning of existing property, we are
> augumenting it.
> 
> In my opinion, *IF* we are concerned about polluting operating-points
> description, why dont we enforce that the boost operating points
> should NOT be defined in the current "operating-points" description -
> and - just follow what Rob suggested and iMx already does - add such
> operating points from platform code.
> 
> 
>>> We never said that "operating points" are "primary operating points".
>>> all we said is they are "operating points" for the device - we dont
>>> associate meanings to it. You may add to it[1] in platform code, as we
>>> decided to.
>>
>> Maybe generic OPP bindings don't state that, but I believe that at least
>> cpufreq-cpu0 bindings have been defined (and the driver implemented)
>> this way and changing the semantics now would be breaking DT ABI
>> compatibility.
> Did you mean
> Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt which
> points to the generic bindings? Quote:
> - operating-points: Refer to
> Documentation/devicetree/bindings/power/opp.txt
>   for details
> 
>>> boost-frequencies are describing "overclocked frequencies" - should it
>>> matter if the description of that comes from platform code OR existing
>>> opp tables or what ever? I dont think defining them as "operating
>>> point" style as the only way of describing overclocked frequencies are
>>> the right approach to describing it.
>>
>> Nobody said that it is the only way. The whole point here is that it
>> should be separate from the main operating-points property, as boost
>> operating points are not normal operating points and the OS must be
>> specifically aware how to handle them.
> They are descriptions - I repeat myself when I state that they are
> "overclocked frequencies" that happen to map to operating points on
> the platforms of concern, but may not necessarily be OPP based on
> other platforms which also be able to support "overclocked frequencies".
> 
> 

OK, so you add overclocked frequencies to operating-points property,
boost-frequency property, build a dtb, use it with a kernel that doesn't
support boost-frequency and nicely overheat (and likely destroy) your
board. I don't think this makes too much sense, sorry.

Best regards,
Tomasz
