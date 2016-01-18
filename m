From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v4 2/2] power: add documentation for ACT8945A's charger DT
 bindings
Date: Mon, 18 Jan 2016 17:20:43 +0900
Message-ID: <569CA05B.3010107@samsung.com>
References: <1452659289-30837-1-git-send-email-wenyou.yang@atmel.com>
 <1452659289-30837-3-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:31364 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751657AbcARIUx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jan 2016 03:20:53 -0500
In-reply-to: <1452659289-30837-3-git-send-email-wenyou.yang@atmel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wenyou Yang <wenyou.yang@atmel.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier@dowhile0.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Lee Jones <lee.jones@linaro.org>

On 13.01.2016 13:28, Wenyou Yang wrote:
> This patch adds documentation for the DT bindings of the charger
> subdevice of ACT8945A MFD.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> ---
> 
> Changes in v4:
>  - change the properties with more legible name, clearer description.
> 
> Changes in v3: None
> Changes in v2: None
> 
>  .../devicetree/bindings/power/act8945a-charger.txt |   33 ++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/act8945a-charger.txt
> 

Okay for me:

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

