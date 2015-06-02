From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH] power_supply: bq25890: make chip_id int
Date: Tue, 02 Jun 2015 22:12:44 +0900
Message-ID: <556DABCC.2080302@samsung.com>
References: <1433241411-27423-1-git-send-email-laurentiu.palcu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:33578 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753267AbbFBNMu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jun 2015 09:12:50 -0400
In-Reply-To: <1433241411-27423-1-git-send-email-laurentiu.palcu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laurentiu Palcu <laurentiu.palcu@intel.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

W dniu 02.06.2015 o 19:36, Laurentiu Palcu pisze:
> Smatch static checker correctly detected an impossible condition because
> chip_id was declared as u8, instead of int:
> 
> drivers/power/bq25890_charger.c:843 bq25890_probe()
> warn: impossible condition '(bq->chip_id < 0) => (0-255 < 0)'
> 
> Also, while at it, fix the return value too.

I wondered whether this should be split into two commits... but actually
returning uninitialized value is not possible now because of the cast, so:

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

