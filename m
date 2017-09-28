From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V2] thermal/drivers/hisi: Switch to interrupt mode
Date: Thu, 28 Sep 2017 09:32:20 +0200
Message-ID: <20170928073220.GF2196@mai>
References: <1bfd974e-3dc1-e99b-d0dd-50102cee762d@ti.com>
 <1506575625-20388-1-git-send-email-daniel.lezcano@linaro.org>
 <20170928065752.GA31697@leoy-linaro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:52529 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751060AbdI1HcY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Sep 2017 03:32:24 -0400
Received: by mail-pf0-f176.google.com with SMTP id p87so445868pfj.9
        for <linux-pm@vger.kernel.org>; Thu, 28 Sep 2017 00:32:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170928065752.GA31697@leoy-linaro>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leo Yan <leo.yan@linaro.org>
Cc: rui.zhang@intel.com, edubezval@gmail.com, jean.wangtao@linaro.org, Keerthy <j-keerthy@ti.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Thu, Sep 28, 2017 at 02:57:52PM +0800, Leo Yan wrote:
> Hi Daniel,
> 
> On Thu, Sep 28, 2017 at 07:13:44AM +0200, Daniel Lezcano wrote:
> > At this moment, we have both the interrupt setup and the polling enabled. The
> > interrupt does nothing more than forcing an update while the temperature is
> > polled every second.
> > 
> > We can do much better than that, threshold is set to 65C in the DT and the
> > passive cooling device enters in the dance when 75C is reached. We need to
> > sample the temperature at 65C in order to let the IPA gather enough values for
> > the PID computation. If the SoC is running at a temperature below 65C, we will
> > be constantly polling for nothing.
> > 
> > This patch disables the sensor when the temperature is below 65C and enables it
> > when passing the threshold. It results the thermal sensor driver will have no
> > activity most of the time.
> > 
> > Cc: Keerthy <j-keerthy@ti.com>
> > Cc: Leo Yang <leo.yan@linaro.org>
> 
> s/Yang/Yan :) Have tested this patch on Hikey at my side:

Oops sorry :)

> Reviewed-by: Leo Yan <leo.yan@linaro.org>
> Tested-by: Leo Yan <leo.yan@linaro.org>


Great! Thanks for testing.

  -- Daniel
