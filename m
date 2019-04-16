From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: devfreq: add compatible for mt8183
 cci devfreq
Date: Tue, 16 Apr 2019 18:08:36 +0900
Message-ID: <28f2c90a-9588-3afa-193d-2572c9cc9bf5@samsung.com>
References: <1553841972-19737-1-git-send-email-andrew-sh.cheng@mediatek.com>
        <CGME20190329064630epcas5p216f8d9263dc6fea26bb71165b5673111@epcas5p2.samsung.com>
        <1553841972-19737-4-git-send-email-andrew-sh.cheng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553841972-19737-4-git-send-email-andrew-sh.cheng@mediatek.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com, fan.chen@mediatek.com
List-Id: linux-pm@vger.kernel.org

Hi,

I already reviewed this patch on v1[1].
[1] https://lkml.org/lkml/2019/2/11/2228

But, the second version patch doesn't include the anything
about review. Please check it[1].

On 19. 3. 29. 오후 3:46, Andrew-sh.Cheng wrote:
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
> +
> +Required properties:
> +- compatible: should contain "mediatek,mt8183-cci" for cci devfreq
> +
> +- clocks: for cci devfreq
> +
> +- clock-names: for cci devfreq driver to reference
> +
> +- operating-points-v2: for cci devfreq opp table
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


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
