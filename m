From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH v2 1/5] thermal: change "hysteresis" as optional property
Date: Fri, 4 Mar 2016 11:03:49 +0800
Message-ID: <20160304030349.GA11012@leoy-linaro>
References: <1456458227-12950-1-git-send-email-leo.yan@linaro.org>
 <1456458227-12950-2-git-send-email-leo.yan@linaro.org>
 <20160303162942.GA2445@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34727 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbcCDDD7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Mar 2016 22:03:59 -0500
Received: by mail-pf0-f173.google.com with SMTP id 4so26656692pfd.1
        for <linux-pm@vger.kernel.org>; Thu, 03 Mar 2016 19:03:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160303162942.GA2445@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Zhang Rui <rui.zhang@intel.com>, kongxinwei <kong.kongxinwei@hisilicon.com>, Javi Merino <javi.merino@arm.com>, Punit Agrawal <Punit.Agrawal@arm.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Hi Eduardo,

On Thu, Mar 03, 2016 at 08:29:44AM -0800, Eduardo Valentin wrote:
> Hi Leo,
> 
> On Fri, Feb 26, 2016 at 11:43:43AM +0800, Leo Yan wrote:
> > The property "hysteresis" is mandatory for trip points, so if without
> > it the thermal zone cannot register successfully. But "hysteresis" is
> > ignored in the thermal subsystem and only inquired by several thermal
> > sensor drivers.
> 
> I am not sure this a good direction to go. Remember that Linux
> implementation not necessarily has to be the implication of the DT
> binding. Hysteresis is a property that plays a significant role on
> thermal control systems, which in many cases avoid overshooting cooling
> actions. Having the DT writer to explicitly set it to 0 means that zone
> does not suffer of overshooting and does not need hysteresis.

After review current code, the "hysteresis" is used to calculate
temperature falling threshold with a more conservative value; so that
finally avoid overshooting issue.

Please confirm if is my understanding correct or not?

> If the Linux thermal subsystem has a problem with handling hysteresis, I
> would rather fix Linux code than relaxing the DT binding. Or if you
> still believe hysteresis is really optional, I would prefer to see a
> better justification than "Linux ignores it".

If we think about power allocator governor, PID's two parameters are
also used to dismiss overshooting issue: one is k_po (proportional
term), another is k_i (integral term). So that means after we apply
power allocator governor, we don't need parameter "hysteresis" due PID
algorithm can automatically dismiss potential errors.

Does this make sense?

Thanks,
Leo Yan
