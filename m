From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/1] ARM: imx7ulp: add cpuidle support
Date: Tue, 29 Aug 2017 10:30:08 +0200
Message-ID: <b8d1f428-a4f5-5a02-8aa4-379b5c85e8d7@linaro.org>
References: <1503841421-17677-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38404 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751236AbdH2IaL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Aug 2017 04:30:11 -0400
Received: by mail-wm0-f44.google.com with SMTP id t201so17563222wmt.1
        for <linux-pm@vger.kernel.org>; Tue, 29 Aug 2017 01:30:10 -0700 (PDT)
In-Reply-To: <1503841421-17677-1-git-send-email-aisheng.dong@nxp.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dong Aisheng <aisheng.dong@nxp.com>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net, shawnguo@kernel.org, Anson.Huang@nxp.com

On 27/08/2017 15:43, Dong Aisheng wrote:
> i.MX7ULP support 3 levels idle as below:
> 1. patial stop mode 3;
> 2. patial stop mode 2;
> 3. patial stop mode 1.
> 
> PSTOP1 - Partial Stop with system and bus clock disabled
> PSTOP2 - Partial Stop with system clock disabled and bus clock enabled
> PSTOP3 - Partial Stop with system clock enabled and bus clock enabled
> 
> For PSTOP 1/2 mode, as the system and bus clock will be disabled, the
> devices working inprogress may not be able to work anymore, driver needs
> to use pm_qos API to prevent system enter those modes.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Will you consider in the future to move the driver to a DT based
description and to the cpuidle-arm driver ?

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
