From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V8 2/3] OPP: Introduce "required-opp" property
Date: Wed, 20 Dec 2017 09:23:35 +0100
Message-ID: <CAPDyKFoWo0bUMNbGFSgjdN-ZwS+o6_GUXt-sQK0Qpcndw5B8eA@mail.gmail.com>
References: <cover.1513591822.git.viresh.kumar@linaro.org> <6615035f294a64a4c17e5b44ac6690d1c2ac127c.1513591822.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:44771 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752304AbdLTIXh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Dec 2017 03:23:37 -0500
Received: by mail-it0-f67.google.com with SMTP id b5so5809279itc.3
        for <linux-pm@vger.kernel.org>; Wed, 20 Dec 2017 00:23:36 -0800 (PST)
In-Reply-To: <6615035f294a64a4c17e5b44ac6690d1c2ac127c.1513591822.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>, Rob Herring <robh+dt@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 18 December 2017 at 11:21, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Devices have inter-dependencies some times. For example a device that
> needs to run at 800 MHz, needs another device (e.g. Its power domain) to
> be configured at a particular operating performance point.
>
> This patch introduces a new property "required-opp" which can be present
> directly in a device's node (if it doesn't need to change its OPPs), or
> in device's OPP nodes. More details on the property can be seen in the
> binding itself.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  Documentation/devicetree/bindings/opp/opp.txt      |  8 +++
>  .../devicetree/bindings/power/power_domain.txt     | 59 ++++++++++++++++++++++
>  2 files changed, 67 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> index a3953a1bb1a1..4e4f30288c8b 100644
> --- a/Documentation/devicetree/bindings/opp/opp.txt
> +++ b/Documentation/devicetree/bindings/opp/opp.txt
> @@ -159,6 +159,14 @@ properties.
>
>  - status: Marks the node enabled/disabled.
>
> +- required-opp: This contains phandle to an OPP node in another device's OPP
> +  table. It may contain an array of phandles, where each phandle points to an
> +  OPP of a different device. It should not contain multiple phandles to the OPP
> +  nodes in the same OPP table. This specifies the minimum required OPP of the
> +  device(s), whose OPP's phandle is present in this property, for the
> +  functioning of the current device at the current OPP (where this property is
> +  present).
> +
>  Example 1: Single cluster Dual-core ARM cortex A9, switch DVFS states together.
>
>  / {
> diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
> index 61549840ab3b..f824763b202e 100644
> --- a/Documentation/devicetree/bindings/power/power_domain.txt
> +++ b/Documentation/devicetree/bindings/power/power_domain.txt
> @@ -126,4 +126,63 @@ The node above defines a typical PM domain consumer device, which is located
>  inside a PM domain with index 0 of a power controller represented by a node
>  with the label "power".
>
> +Optional properties:
> +- required-opp: This contains phandle to an OPP node in another device's OPP
> +  table. It may contain an array of phandles, where each phandle points to an
> +  OPP of a different device. It should not contain multiple phandles to the OPP
> +  nodes in the same OPP table. This specifies the minimum required OPP of the
> +  device(s), whose OPP's phandle is present in this property, for the
> +  functioning of the current device at the current OPP (where this property is
> +  present).
> +
> +Example:
> +- OPP table for domain provider that provides two domains.
> +
> +       domain0_opp_table: opp_table0 {
> +               compatible = "operating-points-v2";
> +
> +               domain0_opp_0: opp-1000000000 {
> +                       opp-hz = /bits/ 64 <1000000000>;
> +                       opp-microvolt = <975000 970000 985000>;
> +               };
> +               domain0_opp_1: opp-1100000000 {
> +                       opp-hz = /bits/ 64 <1100000000>;
> +                       opp-microvolt = <1000000 980000 1010000>;
> +               };
> +       };
> +
> +       domain1_opp_table: opp_table1 {
> +               compatible = "operating-points-v2";
> +
> +               domain1_opp_0: opp-1200000000 {
> +                       opp-hz = /bits/ 64 <1200000000>;
> +                       opp-microvolt = <975000 970000 985000>;
> +               };
> +               domain1_opp_1: opp-1300000000 {
> +                       opp-hz = /bits/ 64 <1300000000>;
> +                       opp-microvolt = <1000000 980000 1010000>;
> +               };
> +       };
> +
> +       parent: power-controller@12340000 {

Nitpick: Could you please change "parent" to "power", to be consistent
with earlier examples.

> +               compatible = "foo,power-controller";
> +               reg = <0x12340000 0x1000>;
> +               #power-domain-cells = <1>;
> +               operating-points-v2 = <&domain0_opp_table>, <&domain1_opp_table>;
> +       };
> +
> +       leaky-device0@12350000 {
> +               compatible = "foo,i-leak-current";
> +               reg = <0x12350000 0x1000>;
> +               power-domains = <&parent 0>;
> +               required-opp = <&domain0_opp_0>;
> +       };
> +
> +       leaky-device1@12350000 {
> +               compatible = "foo,i-leak-current";
> +               reg = <0x12350000 0x1000>;
> +               power-domains = <&parent 1>;
> +               required-opp = <&domain1_opp_1>;
> +       };
> +
>  [1]. Documentation/devicetree/bindings/power/domain-idle-state.txt
> --
> 2.15.0.194.g9af6a3dea062
>


Besides the nitpick, feel free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
