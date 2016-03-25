From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/3] cpufreq: dt: Create platform device from generic code
Date: Fri, 25 Mar 2016 10:11:24 +0530
Message-ID: <20160325044124.GN22062@vireshk-i7>
References: <cover.1458801338.git.viresh.kumar@linaro.org>
 <5800397.rNERvs0XYE@wuerfel>
 <20160324140600.GM22062@vireshk-i7>
 <4531000.a0G78BGFu1@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33714 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866AbcCYEl2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 25 Mar 2016 00:41:28 -0400
Received: by mail-pf0-f182.google.com with SMTP id 4so74663408pfd.0
        for <linux-pm@vger.kernel.org>; Thu, 24 Mar 2016 21:41:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4531000.a0G78BGFu1@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linaro-kernel@lists.linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, arnd.bergmann@linaro.org, kgene.kim@samsung.com, heiko@sntech.de, xf@rock-chips.com, mmcclint@codeaurora.org, linux-pm@vger.kernel.org

On 24-03-16, 15:16, Arnd Bergmann wrote:
> Hmm, can you give an example where this is needed?

I don't remember them, but I am quite sure that I have seen people
asking for that support again and again.

> I assume you are
> thinking of some clock controller or regulator that gets initialized
> after the cpufreq driver, right?

Yeah.

> Are there any that are in loadable modules, rather than just later
> in the init sequence for built-in drivers?

Maybe both, don't remember. Sorry.

Over that, independent of what the users are doing today, I think its
important to support defer probing for anyone that wants to use it.

> I think we do care about compatibility there, but there are clearly
> other ways to handle the special case for opp-v1 if we want to.

Okay, and what are those ? There is only one platform which has used
the pdata, mvebu.

-- 
viresh
