From: Pramod Gurav <pramod.gurav@smartplayin.com>
Subject: Re: [PATCH v7 4/7] qcom: pm: Add cpu low power mode functions
Date: Sat, 27 Sep 2014 13:52:57 +0530
Message-ID: <542673E1.60108@smartplayin.com>
References: <1411779495-39724-1-git-send-email-lina.iyer@linaro.org> <1411779495-39724-5-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp93.ord1c.emailsrvr.com ([108.166.43.93]:34181 "EHLO
	smtp93.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752262AbaI0IXI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 27 Sep 2014 04:23:08 -0400
In-Reply-To: <1411779495-39724-5-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>, daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, msivasub@codeaurora.org



On 27-09-2014 06:28 AM, Lina Iyer wrote:
> Based on work by many authors, available at codeaurora.org
> 
> Add interface layer to abstract and handle hardware specific
> functionality for executing various cpu low power modes in QCOM
> chipsets.
> 

..

> +#include <soc/qcom/scm-boot.h>
> +#include <soc/qcom/spm.h>
> +
> +#define SCM_CMD_TERMINATE_PC	(0x2)
> +#define SCM_FLUSH_FLAG_MASK	(0x3)
> +#define SCM_L2_ON 		(0x0)
There is checkpatch warning here.

WARNING: please, no space before tabs
#75: FILE: drivers/soc/qcom/pm.c:28:
+#define SCM_L2_ON ^I^I(0x0)$

> +#define SCM_L2_OFF		(0x1)
> +
> +
..

> +
> +#endif  /* __QCOM_PM_H */
> 
