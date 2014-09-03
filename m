From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2 3/9] ARM: zynq: DT: Add DDRC node
Date: Wed, 03 Sep 2014 15:49:47 +0200
Message-ID: <54071C7B.4090805@linaro.org>
References: <1409692754-13437-1-git-send-email-soren.brinkmann@xilinx.com> <1409692754-13437-4-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:54558 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756263AbaICNtv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Sep 2014 09:49:51 -0400
Received: by mail-wi0-f172.google.com with SMTP id n3so966298wiv.5
        for <linux-pm@vger.kernel.org>; Wed, 03 Sep 2014 06:49:50 -0700 (PDT)
In-Reply-To: <1409692754-13437-4-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Soren Brinkmann <soren.brinkmann@xilinx.com>, Michal Simek <michal.simek@xilinx.com>
Cc: Russell King <linux@arm.linux.org.uk>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>

On 09/02/2014 11:19 PM, Soren Brinkmann wrote:
> Add the DDR controller to the Zynq devicetree.
>
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   arch/arm/boot/dts/zynq-7000.dtsi | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zyn=
q-7000.dtsi
> index 6cc83d4c6c76..587cadcf7001 100644
> --- a/arch/arm/boot/dts/zynq-7000.dtsi
> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
> @@ -146,6 +146,11 @@
>   			cache-level =3D <2>;
>   		};
>
> +		memory-controller@f8006000 {
> +			compatible =3D "xlnx,zynq-ddrc-a05";
> +			reg =3D <0xf8006000 0x1000>;
> +		} ;
> +
>   		uart0: serial@e0000000 {
>   			compatible =3D "xlnx,xuartps", "cdns,uart-r1p8";
>   			status =3D "disabled";
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

