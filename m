From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: Recommended notation for OPP to avoid DTC warnings
Date: Fri, 31 Mar 2017 11:59:41 +0900
Message-ID: <CAK7LNAQxyPChjjH4oL2HDhXXHxq6ujVR+S+4MocF-99rWDrwFQ@mail.gmail.com>
References: <CAK7LNAQyc9=3d07-1upywYDk-AaRUGK4mJwAVduCuEJgnY1uFA@mail.gmail.com>
 <20170227104445.GE6795@leverpostej> <20170227105533.GA19417@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170227105533.GA19417@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi.

2017-02-27 19:55 GMT+09:00 Viresh Kumar <viresh.kumar@linaro.org>:
> On 27-02-17, 10:44, Mark Rutland wrote:
>> On Sun, Feb 26, 2017 at 02:18:03PM +0900, Masahiro Yamada wrote:
>> > Hi.
>> >
>> >
>> > Decumentation/devicetree/bindings/opp/opp.txt
>> > takes examples like this:
>> >
>> >         opp@1000000000 {
>> >                 opp-hz = /bits/ 64 <1000000000>;
>> >                 opp-microvolt = <970000 975000 985000>;
>> >                 opp-microamp = <70000>;
>> >                 clock-latency-ns = <300000>;
>> >                 opp-suspend;
>> >         };
>>
>> > If we follow this notation and the device-tree is built with W=1,
>> > DTC warns like follows:
>> >
>> > Warning (unit_address_vs_reg): Node /opp_table0/opp@1000000000 has a
>> > unit name, but no reg property
>> >
>> > Is there a recommended notation to avoid it?
>> >
>> > Maybe, simply omit the "@" ?
>>
>> I think just s/@/-/ should be fine, e.g. call the above opp-1000000000.
>
> That's fine with me. I can send a patch to fix all existing users if we all
> agree for it.
>
> --
> viresh


Any progress on this?

Did we reach on agreement with s/@/-/  ?


-- 
Best Regards
Masahiro Yamada
