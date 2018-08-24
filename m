From: Lina Iyer <ilina@codeaurora.org>
Subject: Re: [PATCH v3 2/2] arm64: dts: sdm845: Add interconnect provider DT
 nodes
Date: Fri, 24 Aug 2018 08:58:40 -0600
Message-ID: <20180824145840.GK5081@codeaurora.org>
References: <1535075814-17343-1-git-send-email-daidavid1@codeaurora.org>
 <1535075814-17343-3-git-send-email-daidavid1@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1535075814-17343-3-git-send-email-daidavid1@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Dai <daidavid1@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, vincent.guittot@linaro.org, bjorn.andersson@linaro.org, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, grahamr@qti.qualcomm.com, evgreen@google.com
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 23 2018 at 19:57 -0600, David Dai wrote:
>Add RSC(Resource State Coordinator) provider
>dictating network-on-chip interconnect bus performance
>found on SDM845-based platforms.
>
>Change-Id: I58f0bfc3ed484d7b45064dceb94dcfda507e9333
Remove this pls.

-- Lina

>Signed-off-by: David Dai <daidavid1@codeaurora.org>
>---
> arch/arm64/boot/dts/qcom/sdm845.dtsi | 5 +++++
> 1 file changed, 5 insertions(+)
>
>diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>index 1097c7e..4d15784 100644
>--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>@@ -1651,6 +1651,11 @@
> 				compatible = "qcom,sdm845-rpmh-clk";
> 				#clock-cells = <1>;
> 			};
>+
>+			qnoc: qnoc{
>+				compatible = "qcom,sdm845-rsc-hlos";
>+				#interconnect-cells = <1>;
>+			};
> 		};
>
> 		ufsphy: phy@1d87000 {
>--
>The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>a Linux Foundation Collaborative Project
>
