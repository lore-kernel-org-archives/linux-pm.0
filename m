From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v2 2/2] power_supply: Add support for TI BQ25890 charger
 chip
Date: Wed, 20 May 2015 09:47:24 +0900
Message-ID: <555BD99C.2090305@samsung.com>
References: <1432041880-7373-1-git-send-email-laurentiu.palcu@intel.com>
 <1432041880-7373-3-git-send-email-laurentiu.palcu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53596 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbbETAr2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 May 2015 20:47:28 -0400
In-reply-to: <1432041880-7373-3-git-send-email-laurentiu.palcu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laurentiu Palcu <laurentiu.palcu@intel.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On 19.05.2015 22:24, Laurentiu Palcu wrote:
> More details about the chip can be found here:
> http://www.ti.com/product/bq25890
> 
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@intel.com>
> ---
>  drivers/power/Kconfig           |   7 +
>  drivers/power/Makefile          |   1 +
>  drivers/power/bq25890_charger.c | 999 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1007 insertions(+)
>  create mode 100644 drivers/power/bq25890_charger.c

Hi,

Looks fine:
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
