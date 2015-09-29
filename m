From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v7 08/15] power: bq24257: Allow manual setting of input
 current limit
Date: Tue, 29 Sep 2015 15:02:51 +0900
Message-ID: <560A298B.6030505@samsung.com>
References: <1443196460-26156-1-git-send-email-dannenberg@ti.com>
 <1443196460-26156-9-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34901 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755232AbbI2GC5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Sep 2015 02:02:57 -0400
In-Reply-To: <1443196460-26156-9-git-send-email-dannenberg@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andreas Dannenberg <dannenberg@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>
Cc: Ramakrishna Pallala <ramakrishna.pallala@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-api@vger.kernel.org

W dniu 26.09.2015 o 00:54, Andreas Dannenberg pisze:
> A new optional device property called "ti,current-limit" is introduced
> to allow disabling the D+/D- USB signal-based charger type auto-
> detection algorithm used to set the input current limit and instead to
> use a fixed input current limit.
> 
> Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
> ---
>  drivers/power/bq24257_charger.c | 93 +++++++++++++++++++++++++++++++++--------
>  1 file changed, 75 insertions(+), 18 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

