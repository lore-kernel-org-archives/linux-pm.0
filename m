From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH 04/10] arm: dts: qcom: Add power-controller device node
 for 8074 Krait CPUs
Date: Wed, 26 Nov 2014 16:41:31 -0700
Message-ID: <20141126234131.GG594@linaro.org>
References: <1417040910-43290-1-git-send-email-lina.iyer@linaro.org>
 <1417040910-43290-5-git-send-email-lina.iyer@linaro.org>
 <5476576E.6010608@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5476576E.6010608@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 26 2014 at 15:42 -0700, Stephen Boyd wrote:
>On 11/26/2014 02:28 PM, Lina Iyer wrote:
>>Each Krait CPU in the QCOM 8074/8974 SoC has an SAW power controller to
>>regulate the power to the cpu and aide the core in entering idle states.
>>Reference the SAW instance and associate the instance with the CPU core.
>>
>>Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>>
>
>Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
>
>I imagine all these dts changes will go through qcom tree -> arm-soc?

I will ping Kumar.

>
>-- 
>Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
>a Linux Foundation Collaborative Project
>
