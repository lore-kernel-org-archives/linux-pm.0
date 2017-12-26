From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC V7 2/2] OPP: Allow "opp-hz" and "opp-microvolt" to contain
 magic values
Date: Tue, 26 Dec 2017 14:23:49 -0600
Message-ID: <CAL_Jsq+ntPMiSacpsx7M7VwSXsx+fRbHpX-KFNVpDj+bYdNCiQ@mail.gmail.com>
References: <23ba51eaa6b52117458165dccc00a95cf8e86e1d.1509453284.git.viresh.kumar@linaro.org>
 <CAL_JsqKr7MsM6iZ_QYO=iCzXNwANEGQGDLFUEwe0Z-p2Z_aMYw@mail.gmail.com>
 <CAKohpokvQD4Z6YY6MRG8c+hnsS=Z52X4XhyTgC5FTgf7VuaNmw@mail.gmail.com>
 <CAL_JsqK-qtAaM_Ou5NtxcWR3F_q=8rMPJUm-VqGtKhbtWe5SAQ@mail.gmail.com>
 <20171101214333.GG30645@codeaurora.org> <20171102045155.GX4240@vireshk-i7>
 <20171102071533.GM30645@codeaurora.org> <20171102090033.GZ4240@vireshk-i7>
 <CAPDyKFryn5=GMs+hiRcxGOC1U=-LL9RQdnY3cWniyE+4pwQDog@mail.gmail.com>
 <20171130005029.GC19419@codeaurora.org> <20171130065907.GI11413@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171130065907.GI11413@vireshk-i7>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rajendra Nayak <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 30, 2017 at 12:59 AM, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On 29-11-17, 16:50, Stephen Boyd wrote:
>> Sorry it still makes zero sense to me. It seems that we're trying
>> to make the OPP table parsing generic just for the sake of code
>> brevity.
>
> Not just the code but bindings as well to make sure we don't add a new
> property (similar to earlier ones) for every platform that wants to
> use performance states.
>
>> Is this the goal? From a DT writer perspective it seems
>> confusing to say that opp-microvolt is sometimes a microvolt and
>> sometimes not a microvolt.
>
> Well it would still represent the voltage but not in microvolt units
> as the platform guys decided to hide those values from kernel and
> handle them directly in firmware.
>
>> Why can't the SoC specific genpd
>> driver parse something like "qcom,corner" instead out of the
>> node?
>
> Sure we can, but that means that a new property will be required for
> the next platform.
>
> I did it this way as Kevin (and Rob) suggested NOT to add another
> property but use the earlier ones as we aren't passing anything new
> here, just that the units of the property are different. For another
> SoC, we may want to hide both freq and voltage values from kernel and
> pass firmware dependent values. Should we add two new properties for
> that SoC then ?
>
>> BTW, I don't believe I have a use-case where I want to express
>> power domain OPP tables.
>
> I do remember that you once said [1] that you may want to pass the
> real voltage values as well via DT. And so I thought that you can pass
> performance-state (corner) in opp-hz and real voltage values in
> opp-microvolt.
>
>> I have many devices that all have
>> different frequencies that are all tied into the same power
>> domain. This binding makes it look like we can only have one
>> frequency per domain which won't work.
>
> No, that isn't the case. Looks like we have some confusion here. Let
> me try with a simple example:
>
>         foo: foo-power-domain@09000000 {
>                 compatible = "foo,genpd";
>                 #power-domain-cells = <0>;
>                 operating-points-v2 = <&domain_opp_table>;
>         };
>
>         cpu0: cpu@0 {
>                 compatible = "arm,cortex-a53", "arm,armv8";
>                 ...
>                 operating-points-v2 = <&cpu_opp_table>;
>                 power-domains = <&foo>;
>         };
>
>
>         domain_opp_table: domain_opp_table {
>                 compatible = "operating-points-v2";
>
>                 domain_opp_1: opp00 {
>                         opp-hz = /bits/ 64 <1>; /* These are corners AKA perf states */
>                 };
>                 domain_opp_2: opp01 {
>                         opp-hz = /bits/ 64 <2>;
>                 };
>                 domain_opp_3: opp02 {
>                         opp-hz = /bits/ 64 <3>;
>                 };
>         };
>
>         cpu_opp_table: cpu_opp_table {
>                 compatible = "operating-points-v2";
>                 opp-shared;
>
>                 opp00 {
>                         opp-hz = /bits/ 64 <208000000>;
>                         clock-latency-ns = <500000>;
>                         power-domain-opp = <&domain_opp_1>;

What is this? opp00 here is not a device. One OPP should not point to
another. "power-domain-opp" is only supposed to appear in devices
alongside power-domains properties.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
