From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v13 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ Firmware bindings
Date: Thu, 13 Dec 2018 21:32:59 -0800
Message-ID: <154476557998.19322.11977618193120872801@swboyd.mtv.corp.google.com>
References: <1544760624-12874-1-git-send-email-tdas@codeaurora.org> <1544760624-12874-2-git-send-email-tdas@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544760624-12874-2-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org, linux-arm-msm@vger.kernel.org, evgreen@google.com, Matthias Kaehlcke <mka@chromium.org>, Taniya Das <tdas@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Quoting Taniya Das (2018-12-13 20:10:23)
> Add QCOM cpufreq firmware device bindings for Qualcomm Technology Inc's
> SoCs. This is required for managing the cpu frequency transitions which a=
re
> controlled by the hardware engine.
>=20
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

except one question below for Rob.

> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.tx=
t b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> new file mode 100644
> index 0000000..33856947
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> @@ -0,0 +1,172 @@
> +Qualcomm Technologies, Inc. CPUFREQ Bindings
> +
> +CPUFREQ HW is a hardware engine used by some Qualcomm Technologies, Inc.=
 (QTI)
> +SoCs to manage frequency in hardware. It is capable of controlling frequ=
ency
> +for multiple clusters.
> +
> +Properties:
> +- compatible
> +       Usage:          required
> +       Value type:     <string>
> +       Definition:     must be "qcom,cpufreq-hw".
> +
> +- clocks
> +       Usage:          required
> +       Value type:     <phandle> From common clock binding.
> +       Definition:     clock handle for XO clock and GPLL0 clock.
> +
> +- clock-names
> +       Usage:          required
> +       Value type:     <string> From common clock binding.
> +       Definition:     must be "xo", "alternate".
> +
> +- reg
> +       Usage:          required
> +       Value type:     <prop-encoded-array>
> +       Definition:     Addresses and sizes for the memory of the HW base=
s in
> +                       each frequency domain.
> +- reg-names
> +       Usage:          Optional
> +       Value type:     <string>
> +       Definition:     Frequency domain name i.e.
> +                       "freq-domain0", "freq-domain1".
> +
> +- #freq-domain-cells:

I still wonder if this should be #qcom,freq-domain-cells, but if Rob is
OK I won't complain.

> +       Usage:          required.

Nitpick: Weird full-stop here     ^

> +       Definition:     Number of cells in a freqency domain specifier.
> +
> +* Property qcom,freq-domain
> +Devices supporting freq-domain must set their "qcom,freq-domain" propert=
y with
> +phandle to a cpufreq_hw followed by the Domain ID(0/1) in the CPU DT nod=
e.
> +
> +
