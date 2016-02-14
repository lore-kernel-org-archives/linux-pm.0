From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: Regard of thermal power allocator's coefficients
Date: Sun, 14 Feb 2016 09:12:19 -0800
Message-ID: <20160214171217.GA5924@localhost.localdomain>
References: <20160214110041.GB26920@leoy-linaro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33394 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523AbcBNRMV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 14 Feb 2016 12:12:21 -0500
Content-Disposition: inline
In-Reply-To: <20160214110041.GB26920@leoy-linaro>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leo Yan <leo.yan@linaro.org>
Cc: linux-pm@vger.kernel.org, Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org

Hello Leo,

On Sun, Feb 14, 2016 at 07:00:41PM +0800, Leo Yan wrote:
> Hi there,
> 
> I'm trying to upstreaming IPA patches for 96board Hikey, but so far
> there have no standard DT binding for passing IPA coefficients for
> power modeling.

Thanks for your effort.

> 
> So want to firstly to confirm if should we pass coefficients by using
> device tree? Is someone working on related work for this?

We pass the sustainable power, but not the coefficients. IIRC, the IPA
coefficients were considered (SW) implementation details. Sustainable power,
on the other hand, still describes hardware capabilities.

So, I don't think they will go via DT.

> 
> Here has another more straightforward method is to directly to
> include power model's coefficients in thermal sensor driver (such like
> drivers/thermal/hisi_thermal.c), but my concern is this method will
> include SoC specific data in the common thermal sensor driver,
> so is this doable?

Yeah, unless you are sure that these coefficients are SoC dependent, and
not board dependent, for instance, (or even, use case dependent), I
would prefer you do not leave them configured in the driver.

Keep in mind that power allocator will compute defaults.

Also, userspace software may also tune these parameters, per thermal
zone.

> 
> Welcome any suggestion.
> 
> Thanks,
> Leo Yan

BR,

Eduardo Valentin
