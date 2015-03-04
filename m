From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 2/4] cpufreq: dt-bindings: add bindings for mtk-cpufreq driver
Date: Wed, 4 Mar 2015 15:59:39 +0530
Message-ID: <CAKohpomxTVBkj=EzucUE7BvV6LVCs6r+S4FE_UvUofgogZWtdw@mail.gmail.com>
References: <1425458956-20665-1-git-send-email-pi-cheng.chen@linaro.org>
	<1425458956-20665-3-git-send-email-pi-cheng.chen@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:43948 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758573AbbCDK3k (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Mar 2015 05:29:40 -0500
Received: by obcvb8 with SMTP id vb8so1891897obc.10
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2015 02:29:40 -0800 (PST)
In-Reply-To: <1425458956-20665-3-git-send-email-pi-cheng.chen@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "pi-cheng.chen" <pi-cheng.chen@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Joe.C" <yingjoe.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Howard Chen <ibanezchen@gmail.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Mike Turquette <mturquette@linaro.org>, fan.chen@mediatek.com, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 4 March 2015 at 14:19, pi-cheng.chen <pi-cheng.chen@linaro.org> wrote:
> Add dt-binding for mtk-cpufreq driver so that the driver could get SoC specific
> information (intermediate_clk for now) from device tree.
>
> Signed-off-by: pi-cheng.chen <pi-cheng.chen@linaro.org>
> ---
>  .../devicetree/bindings/cpufreq/cpufreq-mtk.txt         | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-mtk.txt
>
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mtk.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-mtk.txt
> new file mode 100644
> index 0000000..53bf108
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mtk.txt
> @@ -0,0 +1,17 @@
> +
> +Mediatek cpufreq driver
> +-------------------
> +
> +Mediatek SoC cpufreq driver for CPU frequency scaling.
> +
> +Required properties:
> +- compatible: "mediatek,mtk-cpufreq"
> +- intermediate_clk: The intermediate clock source which CPUs will switch to
> +during CPU frequency transition.
> +
> +Examples:
> +--------
> +       mtk-cpufreq {
> +               compatible = "mediatek,mtk-cpufreq";
> +               intermediate_clk = <&apmixedsys APMIXED_MAINPLL>;
> +       };

Such nodes aren't allowed. NACK.
