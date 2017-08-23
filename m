From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH] thermal/drivers/hisi: Remove confusing error message
Date: Wed, 23 Aug 2017 14:13:52 +0800
Message-ID: <20170823061352.GB19253@leoy-ThinkPad-T440>
References: <1499439833-32531-1-git-send-email-daniel.lezcano@linaro.org>
 <1502178956.4296.7.camel@intel.com>
 <46604862-fbb8-8ed1-8b0d-7a51543b3398@linaro.org>
 <1502196531.4296.41.camel@intel.com>
 <20170808132955.GB32732@leoy-ThinkPad-T440>
 <8f58bd6d-0561-7383-6be4-04ee3704099a@linaro.org>
 <20170822080427.GB13910@leoy-ThinkPad-T440>
 <12e90c78-d8dc-5184-17aa-281cd0ad5417@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:34703 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753238AbdHWGOB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Aug 2017 02:14:01 -0400
Received: by mail-wm0-f41.google.com with SMTP id r187so4065931wma.1
        for <linux-pm@vger.kernel.org>; Tue, 22 Aug 2017 23:14:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <12e90c78-d8dc-5184-17aa-281cd0ad5417@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>, edubezval@gmail.com, "open list:THERMAL" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, kong.kongxinwei@hisilicon.com

On Tue, Aug 22, 2017 at 10:25:07AM +0200, Daniel Lezcano wrote:
> On 22/08/2017 10:04, Leo Yan wrote:
> > Hi Daniel,
> > 
> > On Mon, Aug 21, 2017 at 12:06:17PM +0200, Daniel Lezcano wrote:
> > 
> > [...]
> > 
> >> Hi Leo,
> >>
> >> a cleanest solution would be either:
> >>
> >>  - add the 3 missing thermal sensors in the DT and default to the id 2
> > 
> > Yeah, so do you think below change works for you?
> 
> Isn't it possible to set the delay also ? so we don't have to send
> another patch if we want to use one of those instead of 2.

Yeah, this makes sense for me. Have shared updated DT binding patch
with you, you could stack it with your changes.

Thanks for the suggestion.

[...]

Thanks,
Leo Yan
