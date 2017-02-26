From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Recommended notation for OPP to avoid DTC warnings
Date: Sun, 26 Feb 2017 14:18:03 +0900
Message-ID: <CAK7LNAQyc9=3d07-1upywYDk-AaRUGK4mJwAVduCuEJgnY1uFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Cc: masahiroy@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi.


Decumentation/devicetree/bindings/opp/opp.txt
takes examples like this:

        opp@1000000000 {
                opp-hz = /bits/ 64 <1000000000>;
                opp-microvolt = <970000 975000 985000>;
                opp-microamp = <70000>;
                clock-latency-ns = <300000>;
                opp-suspend;
        };
        opp@1100000000 {
                opp-hz = /bits/ 64 <1100000000>;
                opp-microvolt = <980000 1000000 1010000>;
                opp-microamp = <80000>;
                clock-latency-ns = <310000>;
        };
        opp@1200000000 {
                opp-hz = /bits/ 64 <1200000000>;
                opp-microvolt = <1025000>;
                clock-latency-ns = <290000>;
                turbo-mode;
        };


If we follow this notation and the device-tree is built with W=1,
DTC warns like follows:


Warning (unit_address_vs_reg): Node /opp_table0/opp@1000000000 has a
unit name, but no reg property


Is there a recommended notation to avoid it?

Maybe, simply omit the "@" ?



-- 
Best Regards
Masahiro Yamada
