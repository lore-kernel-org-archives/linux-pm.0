From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH RFC] Add cpufreq support
Date: Mon, 8 Feb 2016 18:01:12 +0530
Message-ID: <20160208123111.GE8294@vireshk>
References: <56B4D4BE.2040008@free.fr>
 <3308645.nrPBoahQ2V@wuerfel>
 <20160207122212.GA3808@vireshk>
 <2425296.hvcP5NDLXy@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33200 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510AbcBHMbQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2016 07:31:16 -0500
Received: by mail-pf0-f170.google.com with SMTP id q63so5444250pfb.0
        for <linux-pm@vger.kernel.org>; Mon, 08 Feb 2016 04:31:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <2425296.hvcP5NDLXy@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Mason <slash.tmp@free.fr>, linux-pm <linux-pm@vger.kernel.org>

On 08-02-16, 13:24, Arnd Bergmann wrote:
> Whatever you want to do in drivers/cpufreq that keeps this out of arch/arm/
> 
> As I have said numerous times, there is absolutely no point in having a
> platform device for this, but if you insist on having one

No, I don't insist on that. I just hate it.

But the problem was that we never agreed to a way, by which we could
have probed cpufreq-dt. We were talking about compatible string from
'opp-v2' earlier, but that was soon discarded.

> just write one
> file that has an early_initcall() function and move all the code creating
> those devices in there for platforms using DT, e.g. by matching on the
> root compatible string the same way the platform code does today.
>
> For new platforms, please come up with a way to not need that and create
> a generic binding that anyone can follow.

Do you have any suggestions ?
- We aren't allowed to (re)use opp-v2 compatibility string
- We can't add a DT node for virtual device - cpufreq

What else can be done ?

-- 
viresh
