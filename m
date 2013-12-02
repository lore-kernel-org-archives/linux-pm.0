From: Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH RFC 1/2] Documentation: arm: add cache DT bindings
Date: Mon, 2 Dec 2013 11:28:41 -0600
Message-ID: <D010BD06-683A-4500-AF13-64699ECEF808@codeaurora.org>
References: <1386001205-11978-1-git-send-email-lorenzo.pieralisi@arm.com> <1386001205-11978-2-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:60811 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752999Ab3LBR2u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Dec 2013 12:28:50 -0500
In-Reply-To: <1386001205-11978-2-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: devicetree <devicetree@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Dave Martin <dave.martin@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Grant Likely <grant.likely@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Mark Hambleton <mark.hambleton@broadcom.com>, Hanjun Guo <hanjun.guo@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>


On Dec 2, 2013, at 10:20 AM, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:

> On ARM systems the cache topology cannot be probed at runtime, in
> particular, it is impossible to probe which CPUs share a given cache
> level. Power management software requires this knowledge to implement
> optimized power down sequences, hence this patch adds a document that
> defines the DT cache bindings for ARM systems. The bindings are compliant
> with ePAPR (PowerPC bindings), and rely on the cache bindings already
> standardized in the ePAPR v1.1 document; ARM required updates are underlined
> in the binding document.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
> Documentation/devicetree/bindings/arm/cache.txt | 25 +++++++++++++++++++++++++
> 1 file changed, 25 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/arm/cache.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/cache.txt b/Documentation/devicetree/bindings/arm/cache.txt
> new file mode 100644
> index 0000000..009cddb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/cache.txt
> @@ -0,0 +1,25 @@
> +==========================================
> +ARM processors cache binding description
> +==========================================
> +
> +Device tree bindings for ARM processor caches adhere to the cache bindings
> +described in [3], in section 3.8 for multi-level and shared caches.
> +
> +On ARM, internal caches cannot be described in the cpu node but require
> +specific nodes marked with compatible string set to "cache" (see [3],
> +section 3.8).

can you explain why

> +
> +Furthermore the cache bindings in [3] require the following property update:
> +
> +- [Table 3.9] cache-level: This property of cache nodes must match the cache
> +			   level encoded in the processors CLIDR (v7) and
> +			   CLIDR_EL1 (v8) registers, as described in [1][2].
> +
> +All other properties and rules apply.
> +
> +[1] ARMv7-AR Reference Manual
> +    http://infocenter.arm.com/help/index.jsp
> +[2] ARMv8-A Reference Manual
> +    http://infocenter.arm.com/help/index.jsp
> +[3] ePAPR standard
> +    https://www.power.org/documentation/epapr-version-1-1/
> -- 
> 1.8.4
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

