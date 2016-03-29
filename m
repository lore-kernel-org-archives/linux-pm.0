From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V1 Resend 2/3] cpufreq: dt: Add generic platform-device
 creation support
Date: Tue, 29 Mar 2016 22:06:49 +0530
Message-ID: <20160329163649.GE14322@vireshk-i7>
References: <cover.1459233524.git.viresh.kumar@linaro.org>
 <2f2947872d41ecccc393d6ae95eafc72f205e03c.1459233524.git.viresh.kumar@linaro.org>
 <5412084.gVvuDFzkvo@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35403 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754718AbcC2Qg4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Mar 2016 12:36:56 -0400
Received: by mail-pa0-f42.google.com with SMTP id td3so17438729pab.2
        for <linux-pm@vger.kernel.org>; Tue, 29 Mar 2016 09:36:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5412084.gVvuDFzkvo@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linaro-kernel@lists.linaro.org, k.kozlowski@samsung.com, kgene.kim@samsung.com, heiko@sntech.de, xf@rock-chips.com, linux-pm@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, mmcclint@codeaurora.org

On 29-03-16, 17:14, Arnd Bergmann wrote:
> On Tuesday 29 March 2016 12:09:48 Viresh Kumar wrote:
> > +config CPUFREQ_DT_PLATDEV
> > +	bool
> > +	depends on CPUFREQ_DT
> 
> The 'depends on' line is redundant as you always 'select' the code
> from CPUFREQ_DT. Since they are always set together, you can also
> just drop the new symbol, or put the new code into the same file.

I would like to keep a separate file for this, it looks awkward to update the
driver for any new user platform.

I added a separate symbol to take care of the Modular case of cpufreq-dt. i.e. I
didn't wanted to add module_exit() code in the new file. Currently, it gets
included in the kernel even if cpufreq-dt is selected as a Module, so we just
create the platform-device just once and never touch it again.

-- 
viresh
