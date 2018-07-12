From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ Firmware
 bindings
Date: Thu, 12 Jul 2018 16:49:59 -0700
Message-ID: <153143939986.48062.4653224503139250796@swboyd.mtv.corp.google.com>
References: <1531418745-19742-1-git-send-email-tdas@codeaurora.org>
 <1531418745-19742-2-git-send-email-tdas@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531418745-19742-2-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Rajendra Nayak <rnayak@codeaurora.org>, Amit Nischal <anischal@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org, amit.kucheria@linaro.org, evgreen@google.com, Taniya Das <tdas@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Quoting Taniya Das (2018-07-12 11:05:44)
[..]
> +                       compatible =3D "qcom,kryo385";
> +                       reg =3D <0x0 0x600>;
> +                       enable-method =3D "psci";
> +                       next-level-cache =3D <&L2_600>;
> +                       qcom,freq-domain =3D <&freq_domain_table1>;
> +                       L2_600: l2-cache {
> +                               compatible =3D "cache";
> +                               next-level-cache =3D <&L3_0>;
> +                       };
> +               };
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

It seems that we need to map the CPUs in the cpus node to the frequency
domains in the cpufreq-hw node. Wouldn't that be better served via a
#foo-cells and <&phandle foo-cell> property in the CPU node? It's
annoying that the cpufreq-hw node doesn't have a reg property, when it
really should have one that goes over the whole register space (or is
split across the frequency domains so that there are two reg properties
here).
