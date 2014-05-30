From: Thomas Abraham <ta.omasab@gmail.com>
Subject: Re: [PATCH v6 2/2] Documentation: devicetree: Add boost-frequency
 binding to list boost mode frequency
Date: Fri, 30 May 2014 23:35:43 +0530
Message-ID: <CAJuA9ajs6K1PVtXC4_U0vQsA0oPnpaF_PdMfiQJxBFStF3Z2aw@mail.gmail.com>
References: <1401440477-4328-1-git-send-email-thomas.ab@samsung.com>
	<1401440477-4328-3-git-send-email-thomas.ab@samsung.com>
	<20140530130827.GK24233@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20140530130827.GK24233@leverpostej>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "t.figa@samsung.com" <t.figa@samsung.com>, "l.majewski@samsung.com" <l.majewski@samsung.com>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "nm@ti.com" <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Hi Mark,

On Fri, May 30, 2014 at 6:38 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi,
>
> Apologies for being somewhat late w.r.t. review on this.
>
> On Fri, May 30, 2014 at 10:01:17AM +0100, Thomas Abraham wrote:
>> From: Thomas Abraham <thomas.ab@samsung.com>
>>
>> Add a new optional boost-frequency binding for specifying the frequencies
>> usable in boost mode.
>>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Pawel Moll <pawel.moll@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
>> Cc: Kumar Gala <galak@codeaurora.org>
>> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>> Acked-by: Nishanth Menon <nm@ti.com>
>> Acked-by: Lukasz Majewski <l.majewski@samsung.com>
>> ---
>>  .../devicetree/bindings/cpufreq/cpufreq-boost.txt  |   38 ++++++++++++++++++++
>>  1 file changed, 38 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-boost.txt
>>
>> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-boost.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-boost.txt
>> new file mode 100644
>> index 0000000..63ed0fc
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-boost.txt
>> @@ -0,0 +1,38 @@
>> +* Device tree binding for CPU boost frequency (aka over-clocking)
>> +
>> +Certain CPU's can be operated in optional 'boost' mode (or sometimes referred as
>
> Nit: CPUs (we're not greengrocers [1])
>
>> +overclocking) in which the CPU can operate at frequencies which are not
>> +specified by the manufacturer as CPU's operating frequency.
>> +
>> +Optional Properties:
>> +- boost-frequencies: list of frequencies in KHz to be used only in boost mode.
>> +  This list should be a subset of frequencies listed in "operating-points"
>> +  property. Refer to Documentation/devicetree/bindings/power/opp.txt for
>> +  details about "operating-points" property.
>
> What is 'boost-mode'?

boost-mode activates additional one or more cpu clock speeds (which
are not specified as operating frequency of the cpu by the
manufacturer). The cpu is allowed to operate in these boost mode
speeds when the boost mode is active. The boost mode speeds are
usually undocumented. Some of the chip samples could be clocked in
boost mode speeds and only such samples can be safely operated in
boost mode.

The mechanism of entry into and exit out of boost mode is outside the
scope of this documentation.

>
> What are the limitations on boost frequencies? When is a CPU expected to
> go to these frequencies and for now long? When should I as a dt author
> place elements in boost-frequencies?

I will add these details in the next revision of this patch.

>
> Why are these in both operating-points and boost-frequencies? It'll be
> really easy to accidentally forget to mark something as a
> boost-frequency this way. Why not have a boost-points instead?

Does boost-points mean a set of clock speeds which are not listed as
part of operating-points property? If yes, that also is a possible
implementation (it was implemented in one of the earlier version of
this series). Could you confirm that you want the boost mode speeds to
be exclusive of the speeds listed in operating-points?

Thanks,
Thomas.

>
>> +
>> +Example:
>> +
>> +     cpus {
>> +             #address-cells = <1>;
>> +             #size-cells = <0>;
>> +             cpu@0 {
>> +                     device_type = "cpu";
>> +                     compatible = "arm,cortex-a9";
>> +                     reg = <0>;
>> +
>> +                     operating-points = <
>> +                             1500000 1350000
>> +                             1400000 1287500
>> +                             1300000 1250000
>> +                             1200000 1187500
>> +                             1100000 1137500
>> +                             1000000 1087500
>> +                     >;
>> +                     boost-frequencies = <1500000 1400000>;
>
> This is more of a general issue, but I hate the whole cpufreq-cpu0 way
> of assuming that all CPUs mirror CPU0.
>
> It would be nicer if either this were dropped in /cpus or repeated
> per-cpu.
>
> Cheers,
> Mark.
>
>> +             };
>> +             cpu@1 {
>> +                     device_type = "cpu";
>> +                     compatible = "arm,cortex-a9";
>> +                     reg = <1>;
>> +             };
>> +     };
>> --
>> 1.7.9.5
>>
>>
>
> [1] http://en.wikipedia.org/wiki/Apostrophe#Superfluous_apostrophes_.28.22greengrocers.27_apostrophes.22.29
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
