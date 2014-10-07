From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v8 2/7] arm: dts: qcom: Add power-controller device node
 for 8974 Krait CPUs
Date: Tue, 07 Oct 2014 16:17:07 -0700
Message-ID: <54347473.5010605@codeaurora.org>
References: <1412718106-17049-1-git-send-email-lina.iyer@linaro.org> <1412718106-17049-3-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1412718106-17049-3-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 10/07/2014 02:41 PM, Lina Iyer wrote:
> @@ -144,7 +148,27 @@
>   			};
>   		};
>   
> -		saw_l2: regulator@f9012000 {
> +		saw0: power-controller@f9089000 {
> +			compatible = "qcom,msm8974-saw2-v2.1-cpu";
> +			reg = <0xf9089000 0x1000>;

Please add the aliases.


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
