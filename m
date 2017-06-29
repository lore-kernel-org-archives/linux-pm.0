From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM/hibernate: Free memory occupied by the memory bitmap when hibernation failed
Date: Fri, 30 Jun 2017 00:31:21 +0200
Message-ID: <2672809.Vy2seEJDbu@aspire.rjw.lan>
References: <CGME20170522054414epcas1p38b221b576b6f304c911a196457e248fe@epcas1p3.samsung.com> <"002101d2d2be$71fc1210$55f43630$@luo"@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:47446 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751683AbdF2Wiu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jun 2017 18:38:50 -0400
In-Reply-To: <"002101d2d2be$71fc1210$55f43630$@luo"@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: BaoJun Luo <baojun.luo@samsung.com>
Cc: pavel@ucw.cz, linux-pm@vger.kernel.org

On Monday, May 22, 2017 01:43:17 PM BaoJun Luo wrote:
> From 17f24d918f4c2ac292ec2aaeb13a527a10b91f80 Mon Sep 17 00:00:00 2001
> From: "baojun.luo" <baojun.luo@samsung.com>
> Date: Fri, 19 May 2017 17:58:21 +0800
> Subject: [PATCH] PM/hibernate: Free memory bitmap by orig_bm/copy_bm hold when  hibernation failed
> 
> During prepare for hibernation operation, if there is an error, the image bitmap memory needs to be released.
> 
> This patch will make sure the bitmap memory be released when hibernation error

They will be released by swsusp_free(), because the pages used by them are
marked as "image pages".

At least that's what is supposed to happen, maybe it does not work correctly,
but in that case it needs to be fixed instead of worked around.

Thanks,
Rafael
