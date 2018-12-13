From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v12 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ Firmware bindings
Date: Thu, 13 Dec 2018 00:28:06 -0800
Message-ID: <154468968610.19322.9386616050590076502@swboyd.mtv.corp.google.com>
References: <1544687394-331-1-git-send-email-tdas@codeaurora.org> <1544687394-331-2-git-send-email-tdas@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544687394-331-2-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org, linux-arm-msm@vger.kernel.org, evgreen@google.com, Matthias Kaehlcke <mka@chromium.org>, Taniya Das <tdas@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Quoting Taniya Das (2018-12-12 23:49:53)
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.tx=
t b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> new file mode 100644
> index 0000000..2b82965
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> @@ -0,0 +1,172 @@
[...]
> +- reg-names
> +       Usage:          Optional
> +       Value type:     <string>
> +       Definition:     Frequency domain name i.e.
> +                       "freq-domain0", "freq-domain1".
> +
> +- freq-domain-cells:

Should be #freq-domain-cells? Or maybe #qcom,freq-domain-cells?

> +       Usage:          required.
> +       Definition:     Number of cells in a freqency domain specifier.
> +
> +* Property qcom,freq-domain
> +Devices supporting freq-domain must set their "qcom,freq-domain" propert=
y with
> +phandle to a cpufreq_hw followed by the Domain ID(0/1) in the CPU DT nod=
e.
> +
> +
