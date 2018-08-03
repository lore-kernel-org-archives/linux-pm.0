From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v7 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ Firmware
 bindings
Date: Fri, 03 Aug 2018 16:46:50 -0700
Message-ID: <153334001055.10763.8002698033760154254@swboyd.mtv.corp.google.com>
References: <1532428970-18122-1-git-send-email-tdas@codeaurora.org>
 <1532428970-18122-2-git-send-email-tdas@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532428970-18122-2-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Rajendra Nayak <rnayak@codeaurora.org>, Amit Nischal <anischal@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org, amit.kucheria@linaro.org, evgreen@google.com, Taniya Das <tdas@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Quoting Taniya Das (2018-07-24 03:42:49)
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.tx=
t b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> new file mode 100644
> index 0000000..22d4355
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> @@ -0,0 +1,172 @@
[...]
> +
> +               CPU7: cpu@700 {
> +                       device_type =3D "cpu";
> +                       compatible =3D "qcom,kryo385";
> +                       reg =3D <0x0 0x700>;
> +                       enable-method =3D "psci";
> +                       next-level-cache =3D <&L2_700>;
> +                       qcom,freq-domain =3D <&freq_domain_table1>;
> +                       L2_700: l2-cache {
> +                               compatible =3D "cache";
> +                               next-level-cache =3D <&L3_0>;
> +                       };
> +               };
> +       };
> +
> +       qcom,cpufreq-hw {
> +               compatible =3D "qcom,cpufreq-hw";
> +
> +               clocks =3D <&rpmhcc RPMH_CXO_CLK>;
> +               clock-names =3D "xo";
> +
> +               #address-cells =3D <2>;
> +               #size-cells =3D <2>;
> +               ranges;
> +               freq_domain_table0: freq_table0 {
> +                       reg =3D <0 0x17d43000 0 0x1400>;
> +               };
> +
> +               freq_domain_table1: freq_table1 {
> +                       reg =3D <0 0x17d45800 0 0x1400>;
> +               };

Sorry, this is just not proper DT design. The whole node should have a
reg property, and it should contain two (or three if we're handling the
L3 clk domain?) different offsets for the different power clusters. The
problem seems to still be that we don't have a way to map the CPUs to
the clk domains they're in provided by this hardware block. Making
subnodes is not the solution.
