From: Amit Kucheria <amit.kucheria@verdurent.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ FW bindings
Date: Fri, 15 Jun 2018 16:07:20 +0300
Message-ID: <CAHLCerOBTbBGC61qD=u1=4GWi=w64rPbWXFFGdv-9B-UO8A5BQ@mail.gmail.com>
References: <1528801355-18719-1-git-send-email-tdas@codeaurora.org> <1528801355-18719-2-git-send-email-tdas@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528801355-18719-2-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Taniya Das <tdas@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan <skannan@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 12, 2018 at 2:02 PM, Taniya Das <tdas@codeaurora.org> wrote:
> Add QCOM cpufreq firmware device bindings for Qualcomm Technology Inc's
> SoCs. This is required for managing the cpu frequency transitions which are
> controlled by firmware.
>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>


> +       qcom,cpufreq-fw {
> +               compatible = "qcom,cpufreq-fw";
> +
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +
> +               freq_domain_table0 : freq_table0 {
> +                       reg = <0x17d43920 0x4>, <0x17d43110 0x500>,
> +                                <0x17d41000 0x4>;

Changing the enable address to 0x17d43000 would make this a working
example, I think.

> +                       reg-names = "perf", "lut", "enable";
> +               };
> +
> +               freq_domain_table1 : freq_table1 {
> +                       reg = <0x17d46120 0x4>, <0x17d45910 0x500>,
> +                               <0x17d45800 0x4> ;
> +                       reg-names = "perf", "lut", "enable";
> +               };
> +       };
