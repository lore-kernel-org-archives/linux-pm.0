From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 0/5] Provide real domain names for Exynos power domain
 driver
Date: Tue, 31 Jan 2017 21:27:06 +0200
Message-ID: <20170131192706.npfwwmzoblviz7ax@kozik-lap>
References: <CGME20170130121912eucas1p1002708fc40c2d385c41ef2d7574561f9@eucas1p1.samsung.com>
 <1485778740-30337-1-git-send-email-m.szyprowski@samsung.com>
 <20170130183621.3v77pfrncm2qb7nr@kozik-lap>
 <e632ffe1-87ce-7d05-2ec2-a93e7f91058f@samsung.com>
 <20170131191955.zdv5bzirraf3xoyu@kozik-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wj0-f195.google.com ([209.85.210.195]:34307 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751849AbdAaT1Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Jan 2017 14:27:16 -0500
Content-Disposition: inline
In-Reply-To: <20170131191955.zdv5bzirraf3xoyu@kozik-lap>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>

On Tue, Jan 31, 2017 at 09:19:55PM +0200, Krzysztof Kozlowski wrote:
> On Tue, Jan 31, 2017 at 08:04:53AM +0100, Marek Szyprowski wrote:
> > I have no idea. Are you sure you have applied the dts patch? Here it works
> > fine (Odroid U3 with next-20170130 + this patchset):
> 
> Yep:
> $ git log --oneline
> ee85c687392b arm: dts: exynos: Add labels to all existing power domains
> 6c63bc30112d soc: samsung: pm_domains: Read domain name from the new label property
> f4c8f7f062ca soc: samsung: pm_domains: Remove message about failed memory allocation
> 90d5c7c36ad3 soc: samsung: pm_domains: Remove unused name field
> b8b54d5c4f5a soc: samsung: pm_domains: Use full names in subdomains registration log
> 95648b747071 Merge branch 'next/soc' into for-next
> 
> On the board:
> $ uname -a
> Linux odroidu3 4.10.0-rc2-00070-gee85c687392b-dirty
> 
> The hash matches. Let my try it on the linux-next...
> 

I'm dumbass... The kernel was updated but I put DTB in wrong directory so
old DTB was used.

Now it works fine.

Best regards,
Krzysztof
