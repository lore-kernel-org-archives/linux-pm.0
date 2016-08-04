From: Brendan Jackman <brendan.jackman@arm.com>
Subject: Re: [PATCH v2 02/14] dt/bindings: update binding for PM domain idle
 states
Date: Thu, 4 Aug 2016 16:29:00 +0100
Message-ID: <20160804152900.GC1732@brendan-thinkstation>
References: <1469829385-11511-1-git-send-email-lina.iyer@linaro.org>
 <1469829385-11511-3-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1469829385-11511-3-git-send-email-lina.iyer@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: devicetree@vger.kernel.org, ulf.hansson@linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, khilman@kernel.org, rjw@rjwysocki.net, Axel Haslam <ahaslam+renesas@baylibre.com>, Marc Titinger <mtitinger+renesas@baylibre.com>, linux-arm-msm@vger.kernel.org, andy.gross@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Lina,

Sorry, forgot to mention this in my other email:

On Fri, Jul 29, 2016 at 03:56:13PM -0600, Lina Iyer wrote:
>
> +Example 3:
> +
> +	pm-domains {
> +		a57_pd: a57_pd@ {
> +			/* will have a57 platform ARM_PD_METHOD_OF_DECLARE*/
> +			compatible = "arm,pd","arm,cortex-a57";
> +			#power-domain-cells = <0>;
> +			idle-states = <&CLUSTER_SLEEP_0>;
> +		};
> +
> +		a53_pd: a53_pd@ {
> +			/* will have a a53 platform ARM_PD_METHOD_OF_DECLARE*/
> +			compatible = "arm,pd","arm,cortex-a53";
> +			#power-domain-cells = <0>;
> +			idle-states = <&CLUSTER_SLEEP_0>, <&CLUSTER_SLEEP_1>;
> +		};
> +
> +		CLUSTER_SLEEP_0: idle-state@0 {
> +			compatible = "arm,idle-state";
> +			entry-latency-us = <1000>;
> +			exit-latency-us = <2000>;
> +			residency-us = <10000>;

Existing bindings for CPU idle states use "min-residency-us" instead of
"residency-us" here.

> +		};
> +
> +		CLUSTER_SLEEP_1: idle-state@1 {
> +			compatible = "arm,idle-state";
> +			entry-latency-us = <5000>;
> +			exit-latency-us = <5000>;
> +			residency-us = <100000>;
> +		};
> +	};

Regards,
Brendan
