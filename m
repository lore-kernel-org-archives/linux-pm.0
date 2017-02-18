From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / sleep: Fix test_suspend after sleep state rework
Date: Sat, 18 Feb 2017 02:19:42 +0100
Message-ID: <6203202.JSVJeZt2xv@aspire.rjw.lan>
References: <1487337524-26094-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:48603 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752384AbdBRBYm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Feb 2017 20:24:42 -0500
In-Reply-To: <1487337524-26094-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday, February 17, 2017 02:18:44 PM Geert Uytterhoeven wrote:
> When passing "test_suspend=mem" to the kernel:
> 
>     PM: can't test 'mem' suspend state
> 
> and the suspend test is not run.
> 
> Commit 406e79385f3223d8 ("PM / sleep: System sleep state selection
> interface rework") changed pm_labels[] from a contiguous NULL-terminated
> array to a sparse array (with the first element unpopulated), breaking
> the assumptions of the iterator in setup_test_suspend().
> 
> Iterate from PM_SUSPEND_MIN to PM_SUSPEND_MAX - 1 to fix this.
> 
> Fixes: 406e79385f3223d8 ("PM / sleep: System sleep state selection interface rework")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied.

Thanks,
Rafael
