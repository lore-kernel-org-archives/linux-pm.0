From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH v2 05/10] Documentation: add DT bindings for ARM SCPI sensors
Date: Thu, 03 Sep 2015 16:08:06 +0100
Message-ID: <9hhsi6vilrd.fsf@e105922-lin.cambridge.arm.com>
References: <1438615378-14241-1-git-send-email-punit.agrawal@arm.com>
	<1438615378-14241-6-git-send-email-punit.agrawal@arm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:55646 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755688AbbICPIH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Sep 2015 11:08:07 -0400
In-Reply-To: <1438615378-14241-6-git-send-email-punit.agrawal@arm.com> (Punit
	Agrawal's message of "Mon, 3 Aug 2015 16:22:53 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, liviu.dudau@arm.com, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>

Punit Agrawal <punit.agrawal@arm.com> writes:

> The System Control Processor (SCP) provides access to SoC sensors via
> the System Control and Power Interface (SCPI) Message Protocol. Add
> bindings to allow probing of these sensors. Also support referencing
> of the sensors for setting up thermal zones via the thermal DT
> bindings.
>
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>

Gentle ping for the bindings review.

> ---
>  Documentation/devicetree/bindings/arm/arm,scpi.txt | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/arm,scpi.txt b/Documentation/devicetree/bindings/arm/arm,scpi.txt
> index e309249..8ead68a 100644
> --- a/Documentation/devicetree/bindings/arm/arm,scpi.txt
> +++ b/Documentation/devicetree/bindings/arm/arm,scpi.txt
> @@ -72,8 +72,18 @@ Required sub-node properties:
>  - compatible : should be "arm,juno-scp-shmem" for Non-secure SRAM based
>  	       shared memory on Juno platforms
>  
> +Sensor bindings for the sensors based on SCPI Message Protocol
> +--------------------------------------------------------------
> +SCPI provides an API to access the various sensors on the SoC.
> +
> +Required properties:
> +- compatible : should be "arm,scpi-sensors".
> +- #thermal-sensor-cells: should be set to 1. This property follows the
> +			 thermal device tree bindings[2].
> +
>  [0] http://community.arm.com/servlet/JiveServlet/download/8401-45-18326/DUI0922B_scp_message_interface.pdf
>  [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +[2] Documentation/devicetree/bindings/thermal/thermal.txt
>  
>  Example:
>  
> @@ -122,6 +132,11 @@ scpi_protocol: scpi@2e000000 {
>  			clock-output-names = "pxlclk0", "pxlclk1";
>  		};
>  	};
> +
> +	scpi_sensors0: sensors {
> +		compatible = "arm,scpi-sensors";
> +		#thermal-sensor-cells = <1>;
> +	};
>  };
>  
>  cpu@0 {
