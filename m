From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 2/3] dt-bindings: devfreq: add compatible for mt8183 cci
 devfreq
Date: Tue, 12 Feb 2019 10:00:20 +0900
Message-ID: <803eacf2-a3c7-a4d0-682a-837b7367bf2f@samsung.com>
References: <1548743704-16821-1-git-send-email-andrew-sh.cheng@mediatek.com>
        <CGME20190129063540epcas2p2562f42dd248030292eb438259e54236b@epcas2p2.samsung.com>
        <1548743704-16821-3-git-send-email-andrew-sh.cheng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548743704-16821-3-git-send-email-andrew-sh.cheng@mediatek.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com, fan.chen@mediatek.com
List-Id: linux-pm@vger.kernel.org

Hi Andrew-sh.Cheng,

On 19. 1. 29. 오후 3:35, Andrew-sh Cheng wrote:
> From: "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
> 
> This adds dt-binding documentation of cci devfreq
> for Mediatek MT8183 SoC platform.
> 
> Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> ---
>  .../bindings/devfreq/mt8183-cci-devfreq.txt           | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/mt8183-cci-devfreq.txt
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/mt8183-cci-devfreq.txt b/Documentation/devicetree/bindings/devfreq/mt8183-cci-devfreq.txt
> new file mode 100644
> index 0000000..e2b61cf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/devfreq/mt8183-cci-devfreq.txt
> @@ -0,0 +1,19 @@
> +* Mediatek CCI frequency device

You have to add more detailed what to do on this driver.
Also, please add the full alphabet for CCI.

> +
> +Required properties:
> +- compatible: should contain "mediatek,mt8183-cci" for cci devfreq

Usually, dt-binding document only specifies h/w information
and how to bind device. 'devfreq' is the word of linux-side.
It means that 'devfreq' cannot indicate the any h/w device.

You should use the h/w device information and word of CCI for writing
the dt-binding document without linux-side word like devfreq.

For example, 
- cci devfreq -> frequency scaling of CCI

> +

Remove unneeded blank line.

> +- clocks: for cci devfreq

ditto of 'devfreq' word.

> +

ditto of blank line

> +- clock-names: for cci devfreq driver to reference

ditto of 'devfreq' word.

> +

ditto of blank line

> +- operating-points-v2: for cci devfreq opp table

ditto of 'devfreq' word.

> +
> +Example:
> +	cci: cci {
> +		compatible = "mediatek,cci";
> +		clocks = <&apmixedsys CLK_APMIXED_CCIPLL>;
> +		clock-names = "cci_clock";
> +		operating-points-v2 = <&cci_opp>;
> +	};
> +
> 

This document is missing the 'regulator' property. Please add it

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
