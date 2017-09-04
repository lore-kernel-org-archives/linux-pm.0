From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH 09/13] thermal/drivers/hisi: Remove costly sensor
 inspection
Date: Mon, 4 Sep 2017 22:30:04 +0800
Message-ID: <20170904143004.GB24156@leoy-ThinkPad-T440>
References: <1504082857-21702-1-git-send-email-daniel.lezcano@linaro.org>
 <1504082857-21702-9-git-send-email-daniel.lezcano@linaro.org>
 <20170902032924.GB3841@leoy-linaro>
 <30efb5b7-fdb4-cbdc-56a3-d06e90720a75@linaro.org>
 <20170904005036.GG3841@leoy-linaro>
 <881b622a-5815-8859-90fe-6a3075cf1085@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36192 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753621AbdIDOaS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Sep 2017 10:30:18 -0400
Received: by mail-pf0-f178.google.com with SMTP id e199so1482144pfh.3
        for <linux-pm@vger.kernel.org>; Mon, 04 Sep 2017 07:30:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <881b622a-5815-8859-90fe-6a3075cf1085@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org, kevin.wangtao@linaro.org, open list <linux-kernel@vger.kernel.org>, ionela.voinescu@arm.com

On Mon, Sep 04, 2017 at 01:29:19PM +0200, Daniel Lezcano wrote:
> On 04/09/2017 02:50, Leo Yan wrote:
> 
> [ ... ]
> 
> >> That is something I asked myself but I finally decided to not change the
> >> current behavior and let that be added in a separate patch.
> > 
> > This is fine.
> 
> Hi Leo,
> 
> can you tag this patch if you agree with it?

Yeah; I have tested this patch at my side:

Reviewed-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>

> 
> -- 
>  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 
