From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/7] OPP: Introduce OPP bindings V2 and supporting code
Date: Tue, 17 Feb 2015 13:16:25 +0530
Message-ID: <CAKohpo=uJJw0=T+yfV=aAUQq+Z2-kZFJWFqxnN6B8QtSb2XHqg@mail.gmail.com>
References: <cover.1423642246.git.viresh.kumar@linaro.org>
	<20150212005220.GG11190@codeaurora.org>
	<CAKohponaLt51hiHd=uTocK_fPPwRDgkse5wc_PGG5tFQNnvfAQ@mail.gmail.com>
	<20150212082004.GJ11190@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:37638 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932329AbbBQHq0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Feb 2015 02:46:26 -0500
Received: by mail-ob0-f179.google.com with SMTP id wp4so50498761obc.10
        for <linux-pm@vger.kernel.org>; Mon, 16 Feb 2015 23:46:25 -0800 (PST)
In-Reply-To: <20150212082004.GJ11190@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Nishanth Menon <nm@ti.com>, Rob Herring <rob.herring@linaro.org>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, Thomas Abraham <ta.omasab@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viswanath Puttagunta <viswanath.puttagunta@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, santosh shilimkar <santosh.shilimkar@oracle.com>, Rafael Wysocki <rjw@rjwysocki.net>, "olof@lixom.net" <olof@lixom.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Mike Turquette <mike.turquette@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 12 February 2015 at 16:20, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 02/12, Viresh Kumar wrote:
>> On 12 February 2015 at 08:52, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> > Here's some feedback on how we can't use OPPs (and OPPs in DT) on
>> > qcom platforms.
>> >
>> > On these platforms the OPPs are not always frequency voltage
>> > pairs. Sometimes they're a frequency voltage voltage triplet, or
>>
>> So, making opp-microvolt an array of <target/min/max>, values should fix this?
>> Do we also need a opp-microvolt-names array as well? or can we reused
>> similar ones from the CPU node where regulator are defined.
>>
>
> I don't follow how target/min/max does anything for two different

<target/min/max> represents a single regulators voltage levels for any OPP, this
replaces the existing target+voltage-tolerance stuff..

Now to support multiple regulators, we can have an array here.

> voltages. I suppose something like opp-microvolt-names would work
> though but I don't know how software would correlate that to the
> regulator it uses because that information is elsewhere in the

I hope the CPU node will have an array of supplies to support multiple
regulators, right? If yes, then we can just keep the array of <t/min/max>
in the same order. And software should be able to correlate then?

> device's node. Why not put the information about which clock and
> regulator is used into the opp node?

Don't know. I have been asked specifically to keem them out of the OPPs,
as they belong to the CPU or device instead.

>> > Furthermore, we have a large number of OPP sets that apply to
>> > different speed bins and silicon characteristics of the SoC. In
>> > our systems we read some efuses (an eeprom of sorts) that tell us
>> > to use a certain set of OPPs because the silicon is so fast or
>> > has these certain characteristics. The bootloader is *not*
>> > reading these fuses and populating OPPs in DT. So right now we
>> > just put all these custom OPPish tables in DT and then pick the
>> > right one based on a node name match constructed from the bits we
>> > read in the efuses. How can we express this in DT with these
>> > bindings?
>>
>> What about keeping things as is in DT and disabling the OPPs which
>> you don't support at boot? And only keep enabled the set of OPPs
>> that you want to use based on these efuses ?
>
> Let's look at an example:
>
>
>         speed0 bin0 version0 = /* Hz      uV  uA */
>                         <  300000000  815000  73 >,
>                         <  345600000  825000  85 >,
>                         <  422400000  835000 104 >,
>                         ....
>
>         speed0 bin1 version0 =
>                         <  300000000  800000  73 >,
>                         <  345600000  810000  85 >,
>                         <  422400000  820000 104 >,
>                         ...
>
> Each set of fuses has the exact same frequency (as long as the
> speed is the same) but the bin changes the voltage and sometimes
> current. Maybe we could make this into:
>
>  speed0_bin0_version0_opp: opp0 {
>          compatible = "qcom,speed0-bin0-version0-opp", "operating-points-v2";
>          entry0 {
>                  opp-khz = <300000>;
>                  opp-microvolt = <815000>;
>                  opp-milliamp = <73>;
>          };
>
>          entry1 {
>                  opp-khz = <345600>;
>                  opp-microvolt = <825000>;
>                  opp-milliamp = <85>;
>          };
>          ...
>  };
>
>  speed0_bin1_version0_opp: opp0 {
>          compatible = "qcom,speed0-bin1-version0-opp", "operating-points-v2";
>          entry0 {
>                  opp-khz = <300000>;
>                  opp-microvolt = <800000>;
>                  opp-milliamp = <73>;
>          };
>
>          entry1 {
>                  opp-khz = <345600>;
>                  opp-microvolt = <810000>;
>                  opp-milliamp = <85>;
>          };
>          ...
>  };
>
> And then we can construct a compatible string to search the cpus

So we can make:

                       operating-points-v2 = <&cpu0_opp>;

an array instead, and that btw is expandable in future as well. So we may
leave it as is right now, and update it later.


> node for. I wonder if we shouldn't put all this into an opps node
> under the cpus node?

Nodes in 'cpus' node are thought of as CPUs and so was asked to put
this out at the top.

>> > guess something similar could happen if there were two clocks and
>> > one regulator although I've never seen such a scenario in
>> > practice.
>>
>> Isn't this common? A single regulator voltage supporting multiple clock
>> rates? Or did I misunderstood it :)
>>
>> We can have separate OPP nodes in this case.
>>
>
> I was thinking the same device has two clocks that share the same
> voltage and these two clocks can run at different rates. If two
> opp nodes under the same device works then it sounds like it will
> be ok. We probably still need some way to correlate the two so
> that if one clock is at some freq, the other clock should be at
> the corresponding freq in the OPP, assuming that the OPP is
> really two clocks and a voltage (i.e. the clocks need to scale
> together).

Oh, I got it wrong. So what this requires is an array of clock-rates
like what I am proposing for regulators.

Over that we can make these entries arrays later on as well, as this
wouldn't break anything. So, keep life simple for now.
