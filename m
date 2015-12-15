From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Subject: Re: [PATCH v4 3/3] ARM: dts: qcom: add charger otg regulator
Date: Tue, 15 Dec 2015 14:09:21 -0800
Message-ID: <20151215220921.GV4000@usrtlx11787.corpusers.net>
References: <1450209132-20185-1-git-send-email-tim.bird@sonymobile.com>
 <1450209132-20185-3-git-send-email-tim.bird@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:16988 "EHLO
	SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965600AbbLOWT7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Dec 2015 17:19:59 -0500
Content-Disposition: inline
In-Reply-To: <1450209132-20185-3-git-send-email-tim.bird@sonymobile.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tim Bird <tim.bird@sonymobile.com>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "sre@kernel.org" <sre@kernel.org>, "Cavin, Courtney" <Courtney.Cavin@sonymobile.com>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "agross@codeaurora.org" <agross@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tbird20d@gmail.com" <tbird20d@gmail.com>

On Tue 15 Dec 11:52 PST 2015, Tim Bird wrote:

> Add the otg regulator provided by the charger block.
> 
> Signed-off-by: Tim Bird <tim.bird@sonymobile.com>
> ---
> Changes since V3:
>  - change name of charger regulator to "otg-vbus"
> ---
>  arch/arm/boot/dts/qcom-pm8941.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-pm8941.dtsi b/arch/arm/boot/dts/qcom-pm8941.dtsi
> index b0d4439..d0ffca7 100644
> --- a/arch/arm/boot/dts/qcom-pm8941.dtsi
> +++ b/arch/arm/boot/dts/qcom-pm8941.dtsi
> @@ -45,6 +45,10 @@
>  					  "chg-gone",
>  					  "usb-valid",
>  					  "dc-valid";
> +
> +			usb_otg_in-supply = <&pm8941_5vs1>;

Although this could be coming from some other supply I think it's
perfectly fine that we define this on a platform level.

> +
> +			chg_otg: otg-vbus { };
>  		};
>  
>  		pm8941_gpios: gpios@c000 {

Reviewed-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Regards,
Bjorn
