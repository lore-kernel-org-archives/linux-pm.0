From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v5 8/8] arm64: boot: dts: update rtsm aemv8 dts with PSCI
 and idle states
Date: Wed, 25 Jun 2014 15:29:06 +0100
Message-ID: <53AADCB2.9010802@arm.com>
References: <1403705421-17597-1-git-send-email-lorenzo.pieralisi@arm.com> <1403705421-17597-9-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:55260 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757212AbaFYO2o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Jun 2014 10:28:44 -0400
In-Reply-To: <1403705421-17597-9-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Tomasz Figa <t.figa@samsung.com>, Mark Brown <broonie@kernel.org>, Paul Walmsley <paul@pwsan.com>, Chander Kashyap <chander.kashyap@linaro.org>



On 25/06/14 15:10, Lorenzo Pieralisi wrote:
> This patch updates the RTSM dts file with PSCI bindings and nodes
> describing the AEMv8 model idle states parameters.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>   arch/arm64/boot/dts/rtsm_ve-aemv8a.dts | 44 +++++++++++++++++++++++++++-------
>   1 file changed, 36 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/rtsm_ve-aemv8a.dts b/arch/arm64/boot/dts/rtsm_ve-aemv8a.dts
> index d79de9c..4051ffb 100644
> --- a/arch/arm64/boot/dts/rtsm_ve-aemv8a.dts
> +++ b/arch/arm64/boot/dts/rtsm_ve-aemv8a.dts
> @@ -27,37 +27,65 @@
>   		serial3 = &v2m_serial3;
>   	};
>
> +	psci {
> +		compatible = "arm,psci-0.2";
> +		method = "smc";
> +		cpu_suspend = <0xc4000001>;
> +		cpu_off = <0x84000002>;
> +		cpu_on = <0xc4000003>;

Standard PSCI v0.2 function IDs are used for "arm,psci-0.2", so you can drop
them here.

Regards,
Sudeep

