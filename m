From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v2] power_supply: Add TI BQ24257 charger driver
Date: Thu, 16 Apr 2015 18:59:50 +0900
Message-ID: <CAJKOXPfb1TSQ9k+9nXfrefPRxJtsRjVw5WfpcV3DPpse5fzO+g@mail.gmail.com>
References: <1429176676-10354-1-git-send-email-laurentiu.palcu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vn0-f53.google.com ([209.85.216.53]:40750 "EHLO
	mail-vn0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753630AbbDPJ7v (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 Apr 2015 05:59:51 -0400
In-Reply-To: <1429176676-10354-1-git-send-email-laurentiu.palcu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laurentiu Palcu <laurentiu.palcu@intel.com>
Cc: Sebastian Reichel <sre@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

2015-04-16 18:31 GMT+09:00 Laurentiu Palcu <laurentiu.palcu@intel.com>:
> Based on the datasheet found here:
> http://www.ti.com/lit/ds/symlink/bq24257.pdf
>
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@intel.com>
> ---
> Changes since v1:
>  * removed redundant bq24257_is_writeable_reg();
>  * made power_supply_desc struct a static const, since it's not changed;
>
> laurentiu
>
>  .../devicetree/bindings/power/bq24257.txt          |  21 +
>  drivers/power/Kconfig                              |   7 +
>  drivers/power/Makefile                             |   1 +
>  drivers/power/bq24257_charger.c                    | 863 +++++++++++++++++++++
>  4 files changed, 892 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/bq24257.txt
>  create mode 100644 drivers/power/bq24257_charger.c
>

Reviewed-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

Best regards,
Krzysztof
