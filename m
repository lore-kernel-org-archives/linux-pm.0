From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: Recommended notation for OPP to avoid DTC warnings
Date: Mon, 10 Apr 2017 10:28:21 +0530
Message-ID: <20170410045821.GB4377@vireshk-i7>
References: <CAK7LNAQyc9=3d07-1upywYDk-AaRUGK4mJwAVduCuEJgnY1uFA@mail.gmail.com>
 <20170227104445.GE6795@leverpostej>
 <20170227105533.GA19417@vireshk-i7>
 <CAK7LNAQxyPChjjH4oL2HDhXXHxq6ujVR+S+4MocF-99rWDrwFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK7LNAQxyPChjjH4oL2HDhXXHxq6ujVR+S+4MocF-99rWDrwFQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 31-03-17, 11:59, Masahiro Yamada wrote:
> Hi.
> 
> 2017-02-27 19:55 GMT+09:00 Viresh Kumar <viresh.kumar@linaro.org>:
> > On 27-02-17, 10:44, Mark Rutland wrote:
> >> On Sun, Feb 26, 2017 at 02:18:03PM +0900, Masahiro Yamada wrote:
> >> > Hi.
> >> >
> >> >
> >> > Decumentation/devicetree/bindings/opp/opp.txt
> >> > takes examples like this:
> >> >
> >> >         opp@1000000000 {
> >> >                 opp-hz = /bits/ 64 <1000000000>;
> >> >                 opp-microvolt = <970000 975000 985000>;
> >> >                 opp-microamp = <70000>;
> >> >                 clock-latency-ns = <300000>;
> >> >                 opp-suspend;
> >> >         };
> >>
> >> > If we follow this notation and the device-tree is built with W=1,
> >> > DTC warns like follows:
> >> >
> >> > Warning (unit_address_vs_reg): Node /opp_table0/opp@1000000000 has a
> >> > unit name, but no reg property
> >> >
> >> > Is there a recommended notation to avoid it?
> >> >
> >> > Maybe, simply omit the "@" ?
> >>
> >> I think just s/@/-/ should be fine, e.g. call the above opp-1000000000.
> >
> > That's fine with me. I can send a patch to fix all existing users if we all
> > agree for it.
> >
> > --
> > viresh
> 
> 
> Any progress on this?
> 
> Did we reach on agreement with s/@/-/  ?

We can follow this as no one else objected. I will send a patch for existing
entries and you can do it for the newer ones.

-- 
viresh
