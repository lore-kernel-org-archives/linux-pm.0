From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] thermal/drivers/generic-iio-adc: Switch tz request to
 devm version
Date: Fri, 8 Sep 2017 09:02:24 +0200
Message-ID: <957821eb-262c-2845-db29-f5d83a685884@linaro.org>
References: <1504808230-12288-1-git-send-email-daniel.lezcano@linaro.org>
 <20170908025606.GA2755@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f179.google.com ([209.85.128.179]:38384 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753804AbdIHHC2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Sep 2017 03:02:28 -0400
Received: by mail-wr0-f179.google.com with SMTP id 108so2828988wra.5
        for <linux-pm@vger.kernel.org>; Fri, 08 Sep 2017 00:02:28 -0700 (PDT)
In-Reply-To: <20170908025606.GA2755@localhost.localdomain>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: ldewangan@nvidia.com, linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, open list <linux-kernel@vger.kernel.org>

On 08/09/2017 04:56, Eduardo Valentin wrote:
> Hey Daniel,

Hi Valentin,

>>  static int gadc_thermal_remove(struct platform_device *pdev)
> 
> Any particular reason why this patch does not include a removal of
> gadc_thermal_remove()?

Ah, yes. Missed it.

Thanks.

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
