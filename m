From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: Recommended notation for OPP to avoid DTC warnings
Date: Mon, 27 Feb 2017 09:12:05 +0530
Message-ID: <20170227034205.GG7147@vireshk-i7>
References: <CAK7LNAQyc9=3d07-1upywYDk-AaRUGK4mJwAVduCuEJgnY1uFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAK7LNAQyc9=3d07-1upywYDk-AaRUGK4mJwAVduCuEJgnY1uFA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, masahiroy@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 26-02-17, 14:18, Masahiro Yamada wrote:
> Hi.
> 
> 
> Decumentation/devicetree/bindings/opp/opp.txt
> takes examples like this:
> 
>         opp@1000000000 {
>                 opp-hz = /bits/ 64 <1000000000>;
>                 opp-microvolt = <970000 975000 985000>;
>                 opp-microamp = <70000>;
>                 clock-latency-ns = <300000>;
>                 opp-suspend;
>         };
>         opp@1100000000 {
>                 opp-hz = /bits/ 64 <1100000000>;
>                 opp-microvolt = <980000 1000000 1010000>;
>                 opp-microamp = <80000>;
>                 clock-latency-ns = <310000>;
>         };
>         opp@1200000000 {
>                 opp-hz = /bits/ 64 <1200000000>;
>                 opp-microvolt = <1025000>;
>                 clock-latency-ns = <290000>;
>                 turbo-mode;
>         };
> 
> 
> If we follow this notation and the device-tree is built with W=1,
> DTC warns like follows:
> 
> 
> Warning (unit_address_vs_reg): Node /opp_table0/opp@1000000000 has a
> unit name, but no reg property
> 
> 
> Is there a recommended notation to avoid it?
> 
> Maybe, simply omit the "@" ?

I would let Rob suggest something here.

-- 
viresh
